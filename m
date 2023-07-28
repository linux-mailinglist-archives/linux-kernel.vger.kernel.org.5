Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B37176653C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjG1HZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjG1HZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:25:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8AF7;
        Fri, 28 Jul 2023 00:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfOjJBtymi9AltTjmjAp2A+kKjFdd2Fpl2Pbocw507NOCLKQ5ONYRYkusDgLdd/qnpotFvsocu8EQVmVTwSpKFt1hj4ycxGMiHLZEDrfm5eX9aDqO2o/oHyLXiW19C/t6Dr52PfWCMqZ7cSdAdgM2d89vTKpOEphFWIx6iwJ+eAPpDfTM2F4OhRhYqqIGIk6j+bl+QJDtGv1cGcv39tVck5Wn9MqNBGf58iiDt/pvB48V2dALkq7yigpUVNSlmFVroupWt1xWz1psTiPChZWtVabAElqZtp31Z5JE/wtAeEruS3pZ58UesLtoeO49gW5M2wso/W5xGCu91gWdbjs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1zH5iD06uIN2Df8J/5dWEnKGxnn5hK5qU/cZ/CVX/g=;
 b=c9ODCKn/KOoAAaSAwyU1zMMacuYGIEULFm0pnb6WigJ8UqvzPnKkCFOeTJNZDzcHvDqVNjTFbmwV3h+5RMXj18y4W1h4XQ5rtGpud85PrAxfMwQ8QFa6FfuMD8dxSmpyQmcWCDURqVlQEoQpH+Aa2BkmZzu7wDsdzbpNGRNKRJWEuDEg59Bhl7vZ5tH7C3MwzCuzxmBWODqGuvUqZzjHMRrAxHb6+j2sN4ezLBEhvD9bu9HZxjUaFRhK04m2ojlOqlxpj8Esnp8x7qr8GNZW6iTzq8AngMdkSSYPykOJVkZpn8uYJ9IKIb6iuxYQ1O57nzlzP9MGK1ojyMDirbMN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1zH5iD06uIN2Df8J/5dWEnKGxnn5hK5qU/cZ/CVX/g=;
 b=l6gubXuWMMTmrcgqiNbEPR3eeMEGf1b8PRgzaxbAeEuJ67mF/Ku90rPn+ublMB2Nr8jUCgi5tpfvXDBDJM4aXf7rPm3FK4RP5HJKcrPY9sYZwLji1NxiLmIdTgoCCmu/316KOv7uwdQjYSb+2ZvaQPks03oa/Jb2AVRIMhDBgyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CH2PR03MB5285.namprd03.prod.outlook.com (2603:10b6:610:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 07:24:54 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 07:24:53 +0000
Message-ID: <9bc67e88-bce1-b812-aa57-76eca764cb38@synaptics.com>
Date:   Fri, 28 Jul 2023 15:24:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 04/11] media: videobuf2: Stop define VB2_MAX_FRAME as
 global
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, linux-staging@lists.linux.dev,
        ming.qian@nxp.com, kernel@collabora.com,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-5-benjamin.gaignard@collabora.com>
 <e7444263-0ce5-1575-8cca-1e51b1cfbe9a@synaptics.com>
 <5cb3f216-5041-a155-5d2c-059dc1f15024@collabora.com>
 <25b21252-0d3a-3e50-0012-57055f386fee@synaptics.com>
 <20230712104801.tgawhexpm53ocgd6@chromium.org>
 <2d239d33-b05d-1b51-2268-43b2839b64ea@synaptics.com>
 <CAAFQd5D7oNG8oZB66qEW720fR79paw_q0LGBg7X4jK-ZkgYD_g@mail.gmail.com>
 <f6a3e3e5-14be-6d5c-48d3-009424e1a49a@synaptics.com>
 <CAAFQd5D3NUqvkJFYgystFVFRQvq-5S0ZNUOrv1LJqmCA_8+a_w@mail.gmail.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5D3NUqvkJFYgystFVFRQvq-5S0ZNUOrv1LJqmCA_8+a_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:510:324::21) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CH2PR03MB5285:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a49eb5-c132-451d-776c-08db8f3bbcc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npyHke5+ySPVqx0QcR4NNBzhsFTeQs2pj4R9cg+pYwWF7nQT7etAMuWYtmYyT0h0ug0anU7QFGqHK5SeqYpQXFtjQ40sv0OeG3Zl7nhDCo0uC6Hq7ZhFH12NQd80iD2f7JrN5Qkw8jquW/FnnMd6F2aBwT+JdSWxE9kYPRNI5pr0yQJFf/PBGZloOmc2JkbEKrLwoyZvSPeXFYU/XdKa7mtfa4SWO7NWxkWXdSV2Vtaz61+e7fkDjGcR+/sXtYbaLqORzy86jtBnI61WIOEinkUhdNd8/dsEDfurYMN+Gt3k4QBxjuet+e2/6alTgChAu1dXxSOavhSnaPEiLn8ZiUTFQoMYr24CwFlxiD6UwAvQqQylSCZlzLEZopce6nY+alwyR9KtxTuSTPo9f9jOAiX/3T1CEgRzustDHkZpY8Egip/eM2HEFII14wHGHmquFYejNhtDNcvIoxrn6B2aTIZ/vOuSsfsTJgVARDpEIEXxgHssAzjHrEYYTJ6er/ZOs0NwgfOsC9V8EyWtpDFKvB4nB25HECS5WSOydrxinerujLNcS+ksUfrhIqoKbS9gMDmTfcUpi+P8Kpb5cJhXId5DBov0bI3+HyTMOw6gl83S59CY9l+9mQ58J9hyBHHggtxdVNNoxz3EaqdK73ziwHuKy679brVDV/HNhgqdPsDCUFz6E1Z7AIrQ8X28aBq8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39850400004)(376002)(136003)(366004)(451199021)(38100700002)(6666004)(6486002)(478600001)(38350700002)(52116002)(316002)(8676002)(41300700001)(6916009)(2616005)(66476007)(66946007)(8936002)(66556008)(5660300002)(4326008)(186003)(66574015)(83380400001)(26005)(53546011)(6506007)(6512007)(31696002)(86362001)(30864003)(2906002)(7416002)(36756003)(66899021)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzkvVHZiRE1pQytmQk1YdU83YjIrN3ZveDFwbTcyQ2oybHEyaE1jc1lOM2FB?=
 =?utf-8?B?SCtwZ3B2RjVZa1dRZnpLOGUzUU9RNnpkL1NYUTBIelJ4SlJyZXR1ZW1RcEV0?=
 =?utf-8?B?WFkzY0VWaGxKZ0Rrb2xuNm1iK3lqU2ZTdG5aK1Zscm5nTUFZelg3OW9PUk5i?=
 =?utf-8?B?d0pLWlJOanlTUjNxVU5rc1JNbjFSZWMzUUt2ZDNlNlZaYUFWZ1dFb1lRLzRy?=
 =?utf-8?B?ZFFqekRoN1pwcktoSklnTlVDRVBhaXlmNVcyakpwaFRzTERudndpcHI2anZU?=
 =?utf-8?B?a0VPR2RJZ2k3b0pYcmhQbThUMm1GK2o3UmJSVCtUa3JIaXgzVmc0eDloMzUw?=
 =?utf-8?B?eFdBTDg0Zmk3RFg3VWs3cm9LN2taeS9GV2ExeTZEREZVRU1veENCUllYWk1S?=
 =?utf-8?B?bmM4T0p1MDBNTTZ3Z0ttV0h1bWdDbjBPK0NEVE9hdXBqR0IvSzJxRStxWjNr?=
 =?utf-8?B?T3pYMUJUU0NJVndQQmtFNlBINzByNGVMU0pQVVRQWjhXRm5VK2t0dm9CeEZi?=
 =?utf-8?B?ekczVCttRHEycGpWMVl4cUp3MmxkQmVIbHloMU80dGl5UnZTY2V1em1MRDVl?=
 =?utf-8?B?Smd0LzNsMFMzWkpjNzFGN2ppa094QjZ1MkMwMVp5eDlHd2gzUHo2aUhRMHhh?=
 =?utf-8?B?UmlnMDZ1a1JJa0JwZ1laUkpHekhSK05uS2d4bWViM3JqUGxPVmJ6SUxwbFNX?=
 =?utf-8?B?cG9rWUNFNGdkekVNZnY1TFN2SVR3cmRkTm0rQlE2dVBsb1BSWndGMFo3dnVw?=
 =?utf-8?B?cTVWaGJSS2ZBMmNKN1VBSXU5bFdGeEJqL21rZStiRmdvMW1CQXU2OUxtWDF6?=
 =?utf-8?B?TlJ1a0d1SS9lYURjeWVIRCs2R2prZVhidW9WRzNESHZhL2hINjAyWXVSMkJW?=
 =?utf-8?B?WkVkR09SeTc1RjFIOHE2VFBYamtQd2JkQXJHeFNmVW1kSXl4VTZ2WFMycTQw?=
 =?utf-8?B?M2pvT3JYY1BlWTJadTV3VzZwTk9HYlYzdGx4eWdKSEdrNDhSYUpFSUNkd2dX?=
 =?utf-8?B?UTVVWGV1SktMU1BlL2p0bHdmMEVsZlZ3NUdHOVhPY3JQM3RFcGdkNHl6ME5l?=
 =?utf-8?B?My8wWDBCNm9ubnJ1Zm95NHEvdUVkS2xHWk80OGgzbXBud1VhMXVRRk41dm1F?=
 =?utf-8?B?OS9OQTFxOFc4b2pFN3pkYTBVRFNjMGdWRnlOS29Xay9oQVN0MDlzcW9oQjcx?=
 =?utf-8?B?R2xzWTdtMTJPZ0E3OU5lKzV2QS8wMGFJSGlObkFtRDZiOEF0bjhlNTkwb1Az?=
 =?utf-8?B?Vi94L2toeXJwdUhPRUdzZXZYK29iWWkwN01Lci8yNmR1WUo5dkRIQ2RnKzdX?=
 =?utf-8?B?L2lCbElEUzk0akNqVUUzU3hDLzRISVJhNHJRZC9BaFBwc3Vva1lTS1NVVlhu?=
 =?utf-8?B?eExzR1VDM09TaG1uTUNqRzRzb1U2TG43S2c4OGUzWU9ZU3hGbWJUMEdwbnBO?=
 =?utf-8?B?bTBHWmx1VnhkNlZ4TGsvOEhhMkFGMUJaSG00NHdicjFhL2Zxa0pMcTJJQVAw?=
 =?utf-8?B?NkNQT3ZCOHhIRFJaam1yWUNLS3JwL2duZ0wwUURVVFk3T2V4MnhiUXNCUDYy?=
 =?utf-8?B?ei9sUllQZ2JZM0xBcnFhYlB5K1h4TDlTVTBsQzZpcnZhczA2OTEzWkZsRzkv?=
 =?utf-8?B?RDdXMUs3RHI5R0JsV3FXQ0xaVHBuMVJsbXhVWWE5dnlmL2JOVStPdFgrNHd2?=
 =?utf-8?B?Q0NtdHQvNGdueUdGZUl2NHJoNW5XOE4rd1ZMVitXbXRsQ2lmSFJWRk1yQnJQ?=
 =?utf-8?B?RG9nRXRRV3JYQ3ZUeHIwRHVHVTl6S1hJZmRKRkN5WWs4REM4RGJ2ZlNjYTBx?=
 =?utf-8?B?WlNyT1ZFSmhhY3BGN2hHOFZvODdOTG5iYVpGRm9IcTNGMWNsT0R4Zytacmsv?=
 =?utf-8?B?ckJCNHdvL1dQMEsxcmRCcUw5RDZ3ODBxZVk3Yi9NMnRBQk5sc1dranR1MEZa?=
 =?utf-8?B?cHdCd3MybVRjNzM3dUoxU1FiWHlnSlhJNjg5SEhMcGFma05ReFhHRm12TUNn?=
 =?utf-8?B?WWtQS1ZKbDdmcjRSU1liNjFKVUtsZWJpUkJ2VitCRS9aYk9Kb1NrZzJBSzRH?=
 =?utf-8?B?TDJjRHlxSzNQUHNkdXUxSlZsSVBqOFJTVHFSaVJ3VSs4LzhiSEMzQkdaemw4?=
 =?utf-8?Q?itliqyqjF6k4OyjcLlX7XeuGc?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a49eb5-c132-451d-776c-08db8f3bbcc8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 07:24:53.7477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYwdoWjzfndJPJWxiMZFbYqm4ySecghsEnDcqRXI2MFOPKrqFmgDckWQR364EVSISrggzsFT6wZQBsnfZca4qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5285
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 15:03, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Fri, Jul 28, 2023 at 3:55 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>
>>
>>
>> On 7/28/23 14:46, Tomasz Figa wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> On Mon, Jul 17, 2023 at 4:44 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>>>
>>>>
>>>> On 7/12/23 18:48, Tomasz Figa wrote:
>>>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>
>>>>>
>>>>> On Mon, Jul 03, 2023 at 04:35:30PM +0800, Hsia-Jun Li wrote:
>>>>>> On 7/3/23 16:09, Benjamin Gaignard wrote:
>>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>>> attachments unless you recognize the sender and know the content is
>>>>>>> safe.
>>>>>>>
>>>>>>>
>>>>>>> Le 30/06/2023 à 11:51, Hsia-Jun Li a écrit :
>>>>>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>>>>> attachments unless you recognize the sender and know the content is
>>>>>>>>> safe.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> After changing bufs arrays to a dynamic allocated array
>>>>>>>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
>>>>>>>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI kernel is
>>>>>>>> more reasonable.
>>>>>>>>
>>>>>>>> It would be hard to iterate the whole array, it would go worse with a
>>>>>>>> filter. Such iterate may need to go twice because you mix
>>>>>>>> post-processing buffer and decoding buffer(with MV) in the same array.
>>>>>>> Here I don't want to change drivers behavior so I keep the same value.
>>>>>>> If it happens that they need more buffers, like for dynamic resolution
>>>>>>> change
>>>>>>> feature for Verisilicon VP9 decoder, case by case patches will be needed.
>>>>>>>
>>>>>> I just don't like the idea that using a variant length array here.
>>>>>>
>>>>> "I don't like" is not an argument. We had a number of arguments for
>>>>> using a generic helper (originally idr, but later decided to go with
>>>>> XArray, because the former is now deprecated) that we pointed out in
>>>>> our review comments for previous revisions. It wasn't really about the
>>>>> size being variable, but rather avoiding open coding things in vb2 and
>>>>> duplicating what's already implemented in generic code.
>>>>
>>>> I just want to say I don't think we need a variable length array to
>>>> store the buffer here.
>>>>
>>>> And the below is the reason that such a case could be avoided in the
>>>> first place.
>>>>
>>>>>
>>>>>> And I could explain why you won't need so many buffers for the performance
>>>>>> of decoding.
>>>>>>
>>>>>> VP9 could support 10 reference frames in dpb.
>>>>>>
>>>>>> Even for those frequent resolution changing test set, it would only happen
>>>>>> to two resolutions,
>>>>>>
>>>>>> 32 would be enough for 20 buffers of two resolution plus golden frames. It
>>>>>> also leaves enough slots for re-order latency.
>>>>>>
>>>>>> If your case had more two resolutions, likes low->medium->high.
>>>>>>
>>>>>> I would suggest just skip the medium resolutions, just allocate the lower
>>>>>> one first for fast playback then the highest for all the possible
>>>>>>
>>>>>> medium cases. Reallocation happens frequently would only cause memory
>>>>>> fragment, nothing benefits your performance.
>>>>>>
>>>>> We have mechanisms in the kernel to deal with memory fragmentation
>>>>> (migration/compaction) and it would still only matters for the
>>>>> pathologic cases of hardware that require physically contiguous memory.
>>>>> Modern hardware with proper DMA capabilities can either scatter-gather
>>>>> or are equipped with an IOMMU, so the allocation always happens in page
>>>>> granularity and fragmentation is avoided.
>>>>
>>>> Unfortunately, there are more devices that didn't have a IOMMU attached
>>>> to it, supporting scatter gather is more odd.
>>>>
>>>> It would be more likely that IOMMU would be disabled for the performance
>>>> reason.
>>>
>>> These days IOMMU is totally mandatory if you want to think about
>>> having any level of security in your system. Sure, there could be some
>>> systems that are completely isolated from any external environment,
>>> like some offline industry automation machines, but then arguably
>>> their running conditions would also be quite static and require very
>>> little memory re-allocation.
>> Vendor just decided not to included such hardware.
>> That is why From ION to DMA-heap, people like to allocate from a cavout
>> out memory.
>>>
>>> I also don't buy the performance reason. CPUs have been behind MMUs
>>> for ages and nobody is running them with paging disabled for
>>> performance reasons. Similarly, most of the modern consumer systems
>> Page lookup would increase the delay. Besides a few upstream devices
>> prove them only use a level 1 page table without TBL.
> 
> That's just an excuse for a bad hardware design/implementation. As I
> said, there are good IOMMU implementations out there that don't suffer
> from performance issues.
> 
I could do nothing about that.
Besides, even with TLB, cache missing could happen frequently, 
especially we need to access many (5~16, 10 usually) buffers and more 
11MBytes each in a hardware processing.
You can't have a very large TLB.
>>> (mobile phones, PCs) run with IOMMUs enabled for pretty much anything
>>> because of the security reason and they don't seem to be having any
>> If the page is secure, you can't operate it in a insecure IOMMU or MMU.
>> The most security way here, we should use a dedicated memory(or a zone
>> in unified memory).
> 
> You still need something to enforce that the hardware is not accessing
> memory that it's not supposed to access. How do you do that without an
> IOMMU?
> 
If you know the arm security pipeline and security controller, you could 
found we could reserved a range of memory for a security id(devices in 
secure world may be a different security domain).
Besides, a MMU or security MPU could mark some pages for the secure 
world access only, it doesn't mean the device need an IOMMU to access 
them. The MPU could filter the access through the AXI id.
>> I believe there are more users in mobile for DMA-heap than kernel's dma
>> allocation API.
> 
> Yes, but that's completely separate from whether there is an IOMMU or
> not. It's just a different allocation API.
> 
The memory heap would mean a dedicated memory usually(we don't talk 
about system heap or why there are many vendor heaps). Dedicated memory 
means contiguous memory in the most of cases.
>>> performance issues. In fact, it can improve the performance, because
>>> memory allocation is much easier and without contiguous careouts (as
>>> we used to have long ago on Android devices) the extra memory can be
>>> used for buffers and caches to improve system performance.
>>>
>>> Best regards,
>>> Tomasz
>>>
>>>>
>>>>>
>>>>> Best regards,
>>>>> Tomasz
>>>>>
>>>>>>>>> Remove it from the core definitions but keep it for drivers internal
>>>>>>>>> needs.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
>>>>>>>>>      drivers/media/platform/amphion/vdec.c | 1 +
>>>>>>>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
>>>>>>>>>      drivers/media/platform/qcom/venus/hfi.h | 2 ++
>>>>>>>>>      drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
>>>>>>>>>      drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
>>>>>>>>>      include/media/videobuf2-core.h | 1 -
>>>>>>>>>      include/media/videobuf2-v4l2.h | 4 ----
>>>>>>>>>      8 files changed, 11 insertions(+), 5 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>>> index 86e1e926fa45..899783f67580 100644
>>>>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>>> @@ -31,6 +31,8 @@
>>>>>>>>>
>>>>>>>>>      #include <trace/events/vb2.h>
>>>>>>>>>
>>>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>>>> +
>>>>>>>>>      static int debug;
>>>>>>>>>      module_param(debug, int, 0644);
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/media/platform/amphion/vdec.c
>>>>>>>>> b/drivers/media/platform/amphion/vdec.c
>>>>>>>>> index 3fa1a74a2e20..b3219f6d17fa 100644
>>>>>>>>> --- a/drivers/media/platform/amphion/vdec.c
>>>>>>>>> +++ b/drivers/media/platform/amphion/vdec.c
>>>>>>>>> @@ -28,6 +28,7 @@
>>>>>>>>>
>>>>>>>>>      #define VDEC_MIN_BUFFER_CAP            8
>>>>>>>>>      #define VDEC_MIN_BUFFER_OUT            8
>>>>>>>>> +#define VB2_MAX_FRAME                  32
>>>>>>>>>
>>>>>>>>>      struct vdec_fs_info {
>>>>>>>>>             char name[8];
>>>>>>>>> diff --git
>>>>>>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>>>> index 6532a69f1fa8..a1e0f24bb91c 100644
>>>>>>>>> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>>>> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>>>> @@ -16,6 +16,8 @@
>>>>>>>>>      #include "../vdec_drv_if.h"
>>>>>>>>>      #include "../vdec_vpu_if.h"
>>>>>>>>>
>>>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>>>> +
>>>>>>>>>      /* reset_frame_context defined in VP9 spec */
>>>>>>>>>      #define VP9_RESET_FRAME_CONTEXT_NONE0 0
>>>>>>>>>      #define VP9_RESET_FRAME_CONTEXT_NONE1 1
>>>>>>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
>>>>>>>>> b/drivers/media/platform/qcom/venus/hfi.h
>>>>>>>>> index f25d412d6553..bd5ca5a8b945 100644
>>>>>>>>> --- a/drivers/media/platform/qcom/venus/hfi.h
>>>>>>>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
>>>>>>>>> @@ -10,6 +10,8 @@
>>>>>>>>>
>>>>>>>>>      #include "hfi_helper.h"
>>>>>>>>>
>>>>>>>>> +#define VB2_MAX_FRAME                          32
>>>>>>>>> +
>>>>>>>>>      #define VIDC_SESSION_TYPE_VPE                  0
>>>>>>>>>      #define VIDC_SESSION_TYPE_ENC                  1
>>>>>>>>>      #define VIDC_SESSION_TYPE_DEC                  2
>>>>>>>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>>>> b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>>>> index e83f0c523a30..9e8faf7ba6fb 100644
>>>>>>>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>>>> @@ -15,6 +15,8 @@
>>>>>>>>>      #include <media/v4l2-vp9.h>
>>>>>>>>>      #include <media/videobuf2-core.h>
>>>>>>>>>
>>>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>>>> +
>>>>>>>>>      #define DEC_8190_ALIGN_MASK    0x07U
>>>>>>>>>
>>>>>>>>>      #define MB_DIM                 16
>>>>>>>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>>>> index e530767e80a5..6627b5c2d4d6 100644
>>>>>>>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>>>> @@ -10,6 +10,8 @@
>>>>>>>>>      #include "ipu3.h"
>>>>>>>>>      #include "ipu3-dmamap.h"
>>>>>>>>>
>>>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>>>> +
>>>>>>>>>      /******************** v4l2_subdev_ops ********************/
>>>>>>>>>
>>>>>>>>>      #define IPU3_RUNNING_MODE_VIDEO                0
>>>>>>>>> diff --git a/include/media/videobuf2-core.h
>>>>>>>>> b/include/media/videobuf2-core.h
>>>>>>>>> index 77921cf894ef..080b783d608d 100644
>>>>>>>>> --- a/include/media/videobuf2-core.h
>>>>>>>>> +++ b/include/media/videobuf2-core.h
>>>>>>>>> @@ -20,7 +20,6 @@
>>>>>>>>>      #include <media/media-request.h>
>>>>>>>>>      #include <media/frame_vector.h>
>>>>>>>>>
>>>>>>>>> -#define VB2_MAX_FRAME  (32)
>>>>>>>>>      #define VB2_MAX_PLANES (8)
>>>>>>>>>
>>>>>>>>>      /**
>>>>>>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>>>>>>> b/include/media/videobuf2-v4l2.h
>>>>>>>>> index 5a845887850b..88a7a565170e 100644
>>>>>>>>> --- a/include/media/videobuf2-v4l2.h
>>>>>>>>> +++ b/include/media/videobuf2-v4l2.h
>>>>>>>>> @@ -15,10 +15,6 @@
>>>>>>>>>      #include <linux/videodev2.h>
>>>>>>>>>      #include <media/videobuf2-core.h>
>>>>>>>>>
>>>>>>>>> -#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>>>>>> -#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>>>>>> -#endif
>>>>>>>>> -
>>>>>>>>>      #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>>>>>      #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>>>>>      #endif
>>>>>>>>> --
>>>>>>>>> 2.39.2
>>>>>>>>>
>>>>>> --
>>>>>> Hsia-Jun(Randy) Li
>>>>>>
>>>> --
>>>> Hsia-Jun(Randy) Li
>>>>
>>
>> --
>> Hsia-Jun(Randy) Li

-- 
Hsia-Jun(Randy) Li
