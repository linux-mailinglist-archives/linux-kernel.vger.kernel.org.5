Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63D766490
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjG1Gzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjG1Gzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:55:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF0ABA;
        Thu, 27 Jul 2023 23:55:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giKvOFd+tkT9XyjFhIe/AaSDIXRkMVT5snQXmq0zEsAFBWOMELMertza89jTX7U1J5a9D9NOxy5Gt7U2JgC9RcM7mllBKzWrTjeQNomKHJRCW1Lj301g8TdQxKwbAR91HEwUr6GTKjmOR580WTgozlEz8hqwEmfSrGYQoRQLJTJtG7asBDAzarkY+f7XPc2tvKkMtYH9fUzUGajSRIYEoUL7WgFlUcSkZ3vkrCqRcAqrW/6c3vYErxnA/q2a8Iv+TssvuA2TrWKW+xMv+6/gNRjPFhFq9ta8xHMu1frLTMF3WEj2JM5iH3sd8i1hddF/NX3U3hEPsy4R8DLMsG9Huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0Pu3ZZ/wp9ehtY4JbxabFrMEcOK1+1emJwdtRv2B0g=;
 b=II4/GxX9hgqP8RgX/RVKgD1cajeO/UgEGjbUKc9s+/amtYTTYtL8UYon1ltgrolXDNXAP4Zc2GOT7Lv0CwSMReU/zUV9E8ZFyRCLdg8WgtStwNsMHRlg8eji3E3PhN46Nv7KQeo5HS2C0aAoO8UszhoxndQEUrjitHbpG/HNO+dnwu5chuot4VWtNgOcQSjxdlYEMlf2OS4XNS2nIZGLcCPHpEPJLVOAFHs1wuVMol8vr/mpHARP81DnJwvrmwdQIbdu8wMNO/CWiHT97Yc6600EsaOgJ4B9EMTQyb+CcusxDRIsOAcglL6Z7M1R93F7TPRobzOd5koHlEB/YLdwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0Pu3ZZ/wp9ehtY4JbxabFrMEcOK1+1emJwdtRv2B0g=;
 b=gOeXMvPLce408pztCV/cI8MphO9rERgJSSV9XpLmJqqUybkvV7HjZlGMgm/OB4GO65w0cXt/owdp1QFC8SOEcplXda7UfJTMR/Qj5yz09FtyJ4rmlcY5cTPzjNMavNQqgnkB1FkHXT/BnUuX+CjzeIpDdPJkc93qvcTQYGjRQ0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SJ0PR03MB6676.namprd03.prod.outlook.com (2603:10b6:a03:389::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:55:33 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 06:55:32 +0000
Message-ID: <f6a3e3e5-14be-6d5c-48d3-009424e1a49a@synaptics.com>
Date:   Fri, 28 Jul 2023 14:55:21 +0800
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
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5D7oNG8oZB66qEW720fR79paw_q0LGBg7X4jK-ZkgYD_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::32) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SJ0PR03MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b71208f-09a5-4544-b830-08db8f37a2f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6QQk/1wbIWTJqOhS4iZTaKWX7rnCw/JfLtCmUadY89j4RGiEJfitvDd5L4/NvcUNVETC9kEPqn91AQe/dUgegRllO014nN87Lp+lnuDskdTUoKtHOju8b07IKKCQvgRNIUGbMq5sWEZ0g24kF2RrUK5/ZTGrLvkNyJZSORbgLXywM0uotyQdaYpEp+Pv8v2mls2KXCo7au7j3DYYB+Z9seTcRdn4faQrkuOkgYRcG/TCH9bL3TtWv8uj2JThlK1lgfa3y4OOGJncCoaFsjPtUK4Yq1WHgSv60cmVEQFSBSX/sxXyoyGNYe78bGo1YcyBxT+hjdhns/qQFeSc+TzQKQtcB2Aj70GyCxioXZV+JZrJNtqCP4q7Zg4omPhqKHsaphkXikn64wa9t0PJBz8f6bkxz8IHf8VAMm6Mys2/5h+qe7dIRIihVpgf+0lw6G0v1PQ4xskuwuEPpNPmc4aL3CBawIYien56IZPNJe/vZ3jj+lYKzKGmAA91iQWxLoJDCA3umzbYt3RiuqVstpguAQISV/Q4sP4GEDkjSqOLaB+NlE3FCVp3oxVuGn0FftgvCK4Vpt8u7mimbL3joSafmU9lSGC/wCSvDwVGz95iujxyMYdaSkXpIVKVb52ETOD9Yn6fmh/+JzW9wsIU2jjAxF/aCssfFvkTiN+BzrqAR3r7s2mLdI+/oZBxxmE3R0/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(38100700002)(66574015)(478600001)(31696002)(86362001)(66556008)(38350700002)(6916009)(4326008)(66946007)(316002)(66476007)(186003)(6486002)(53546011)(6512007)(26005)(8676002)(6666004)(52116002)(6506007)(8936002)(2906002)(7416002)(30864003)(5660300002)(41300700001)(2616005)(36756003)(83380400001)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXpjeDZsMkg2bVJCZEVYUm04SlNndllyZHV2SzA4L1FRS1VpbFBwK01GNEF6?=
 =?utf-8?B?Rm1JSHpXamZOUDk1b1ExMCs1bk5yTUJsS3NnNldXWnQybUNPbHM0V3JEaUp0?=
 =?utf-8?B?a21tbEtxdWIvc0xrM1BEU0dFdStGei9PV0c2b1dZbFpjQnVuVE5HV3hPYnVu?=
 =?utf-8?B?WVE3aUV1SUp5b3FlQnNCcHNTODlaelVZZXBML3RiVXZSVk82VUUwNWZ5K1N0?=
 =?utf-8?B?Sk44ZWI1Wmt4a2ZCVWtJZ2tQUnBjbnhDODlKNnZ6VmdwY1YwOHhwTzVseC9L?=
 =?utf-8?B?V0x3NVZxSjdTcWloYy9KVGpJQm52VXNFU25JN2dYSUFNWldVS0lSSFQrL2VE?=
 =?utf-8?B?TkxCeHVEY1haWUZUcmRWa2NyVEZCUmlpKzkraFBKbDU1bnBxeFBEdTV2cTFP?=
 =?utf-8?B?N3ZjMTF6QU5CMDYyanFvMWpKbDhpMHlCd2FxWngvaU1Tbm1XNlZoblZaMXhP?=
 =?utf-8?B?RFlDU3RsTVdNOE1ORHpDVlh4QkI0THN1ZWtEN0pQSlR4VGFaWW1zc293SUUx?=
 =?utf-8?B?OFo3U1pETXl4bTdmRVd6U1dTK0VmaHdabHFnYnN4ZnkyZi82MlJoMGlUb3Z3?=
 =?utf-8?B?MUNNRnlURTJkNjQ5ZHI3WmNIeEZsbWpoYSs0RytuK1N0SmE1b25xQkZDRWJM?=
 =?utf-8?B?Ujk3eWlrejZWdElhbFBSK3FoUlJhNW9LazJDY1VSVEcweFYwTFdScS9ZYmNr?=
 =?utf-8?B?cTNiMlNkdnUxY0F6VFdsbmtVazRiYWlsMXA2WHlqUERla2JCNVIxVEFtdFFZ?=
 =?utf-8?B?VlNXOGNlTytHK242T2lBcitQNUNZcUFTT0RhK2Z3V3d5TzJkcDdub3RHbEMy?=
 =?utf-8?B?cHNuTXJDaFBIQkxramE4QWlUUXZkd1pYbURDNXdxTW9LNU16WjhlK2YvOEt0?=
 =?utf-8?B?bFM3cUFzUWo1TjVkckdCZEZISUwwU0VBK2czM3hLaGFGS2lpL0lJd1M4WE4y?=
 =?utf-8?B?cWdlV1ROV0g0U0pCbGpqbGRjNGJtbVRtTWJUaU1odVVjanYrUlBqYzVUM2Z5?=
 =?utf-8?B?bGJSZndJS3RHaVRSNVBoZzRiaWtUVjhjNzlnRFJyNDJXMXBNTGx4c0YyRkpO?=
 =?utf-8?B?dHhzS2NKTWV6OUF6dmdsTUlhYW9qZDJVTWxBT1NIQWF4RXphbEhjMlRmTm00?=
 =?utf-8?B?QVMvbnE2elo2WHY0WHF4TjNoUE0zejlpb3dyUm5tTWQrTFo5TnhYOXBUc1la?=
 =?utf-8?B?MGk1QlJ0VXZNcnhhemkxaVFScG9uN0xTcERudTlMQTZNUENjeU1EUXJrNFhv?=
 =?utf-8?B?dzRnOCtwOU5aTzFuSlRHYng4M0tmN3djZnFHU2o4Rk5aMmVKc1kxMTVQZ2FQ?=
 =?utf-8?B?VkpqTHhKSTc3OVNSdFZFNDBGNHQxWWdNaS91aVB3NEFnNG54WG1memtSaEFo?=
 =?utf-8?B?eGN1U2RpTjlmTVRacVVSaG5DcjEvZlpEM1VrNCtKVVZobFdUcWtlRytJZ2kr?=
 =?utf-8?B?NGxGeGMrZUhiemdnMlR5T21jWnRPOGdldXF2bjY2OHFTNFhtSmcwZjVOME5P?=
 =?utf-8?B?dHh0MjNwUWx6dXdBdmk0MzJveHU3M05pZ1RUNVJWR0hoS1ZCU0ppWkNKT0xG?=
 =?utf-8?B?NGo5M3VKLzNDaVVxVHZGenV4eW5wTEJ3eDhDVzlIQWwvNW5jQ2tWME1PZTB1?=
 =?utf-8?B?S05SelovVUU4VitRdzhPandlT0c4UFJPSXM2L1hvWU4rcW1NK28zTFdsSkZL?=
 =?utf-8?B?bUE1RDBQcTE4OXlZUU9qYUVlMGV0MW1BZXZ2OVFRc0ZsSWI0Q1V1TlRDd096?=
 =?utf-8?B?ajROc3RoZWNtVnZ6UjFNcE4xMU95V0JrYTkzcDdLSTk5d1FQNkcwVXNLMXVu?=
 =?utf-8?B?NGVDaUZ3WHNHWmduYTR3RkpvV05GZEkzelpYZE53TzBVQm85WlpDK1ZlRk5J?=
 =?utf-8?B?N01vNzRBSXhpWnRaQjhqWmIwNzVrcXJ6dDJWTm4zYjEvS0szK0NJdFRycHJ5?=
 =?utf-8?B?aisyT0VzN3gyNDY0a003L1IwbmpZSi9NS01jZlFLN1J2MHFPMlArd1VFY21G?=
 =?utf-8?B?SVRON2VuZ3JoSmo5N1llbnFscFE1czhtWFpOdFh1SS9wMjE4YW5IbGkrUFFR?=
 =?utf-8?B?ZWhVNVgzOVVKQjNvTUJERE9mSWZqbnFqU21iR2x1NUx3bG1BOGNFdHBTMGhE?=
 =?utf-8?Q?XV/L3xJGF1KJhIcc4PpkPvSlD?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b71208f-09a5-4544-b830-08db8f37a2f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:55:32.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMzE7l7NkLrffIs8A9g8jnK/QY0KxrUOV+EwV9tPE9rMcUu5Dce8o4b4IAIFUrJtpVNejN2KoPFAAh0NKzO+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6676
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 14:46, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Mon, Jul 17, 2023 at 4:44 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>
>>
>> On 7/12/23 18:48, Tomasz Figa wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> On Mon, Jul 03, 2023 at 04:35:30PM +0800, Hsia-Jun Li wrote:
>>>> On 7/3/23 16:09, Benjamin Gaignard wrote:
>>>>> CAUTION: Email originated externally, do not click links or open
>>>>> attachments unless you recognize the sender and know the content is
>>>>> safe.
>>>>>
>>>>>
>>>>> Le 30/06/2023 à 11:51, Hsia-Jun Li a écrit :
>>>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>>> attachments unless you recognize the sender and know the content is
>>>>>>> safe.
>>>>>>>
>>>>>>>
>>>>>>> After changing bufs arrays to a dynamic allocated array
>>>>>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
>>>>>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI kernel is
>>>>>> more reasonable.
>>>>>>
>>>>>> It would be hard to iterate the whole array, it would go worse with a
>>>>>> filter. Such iterate may need to go twice because you mix
>>>>>> post-processing buffer and decoding buffer(with MV) in the same array.
>>>>> Here I don't want to change drivers behavior so I keep the same value.
>>>>> If it happens that they need more buffers, like for dynamic resolution
>>>>> change
>>>>> feature for Verisilicon VP9 decoder, case by case patches will be needed.
>>>>>
>>>> I just don't like the idea that using a variant length array here.
>>>>
>>> "I don't like" is not an argument. We had a number of arguments for
>>> using a generic helper (originally idr, but later decided to go with
>>> XArray, because the former is now deprecated) that we pointed out in
>>> our review comments for previous revisions. It wasn't really about the
>>> size being variable, but rather avoiding open coding things in vb2 and
>>> duplicating what's already implemented in generic code.
>>
>> I just want to say I don't think we need a variable length array to
>> store the buffer here.
>>
>> And the below is the reason that such a case could be avoided in the
>> first place.
>>
>>>
>>>> And I could explain why you won't need so many buffers for the performance
>>>> of decoding.
>>>>
>>>> VP9 could support 10 reference frames in dpb.
>>>>
>>>> Even for those frequent resolution changing test set, it would only happen
>>>> to two resolutions,
>>>>
>>>> 32 would be enough for 20 buffers of two resolution plus golden frames. It
>>>> also leaves enough slots for re-order latency.
>>>>
>>>> If your case had more two resolutions, likes low->medium->high.
>>>>
>>>> I would suggest just skip the medium resolutions, just allocate the lower
>>>> one first for fast playback then the highest for all the possible
>>>>
>>>> medium cases. Reallocation happens frequently would only cause memory
>>>> fragment, nothing benefits your performance.
>>>>
>>> We have mechanisms in the kernel to deal with memory fragmentation
>>> (migration/compaction) and it would still only matters for the
>>> pathologic cases of hardware that require physically contiguous memory.
>>> Modern hardware with proper DMA capabilities can either scatter-gather
>>> or are equipped with an IOMMU, so the allocation always happens in page
>>> granularity and fragmentation is avoided.
>>
>> Unfortunately, there are more devices that didn't have a IOMMU attached
>> to it, supporting scatter gather is more odd.
>>
>> It would be more likely that IOMMU would be disabled for the performance
>> reason.
> 
> These days IOMMU is totally mandatory if you want to think about
> having any level of security in your system. Sure, there could be some
> systems that are completely isolated from any external environment,
> like some offline industry automation machines, but then arguably
> their running conditions would also be quite static and require very
> little memory re-allocation.
Vendor just decided not to included such hardware.
That is why From ION to DMA-heap, people like to allocate from a cavout 
out memory.
> 
> I also don't buy the performance reason. CPUs have been behind MMUs
> for ages and nobody is running them with paging disabled for
> performance reasons. Similarly, most of the modern consumer systems
Page lookup would increase the delay. Besides a few upstream devices 
prove them only use a level 1 page table without TBL.
> (mobile phones, PCs) run with IOMMUs enabled for pretty much anything
> because of the security reason and they don't seem to be having any
If the page is secure, you can't operate it in a insecure IOMMU or MMU.
The most security way here, we should use a dedicated memory(or a zone 
in unified memory).
I believe there are more users in mobile for DMA-heap than kernel's dma 
allocation API.
> performance issues. In fact, it can improve the performance, because
> memory allocation is much easier and without contiguous careouts (as
> we used to have long ago on Android devices) the extra memory can be
> used for buffers and caches to improve system performance.
> 
> Best regards,
> Tomasz
> 
>>
>>>
>>> Best regards,
>>> Tomasz
>>>
>>>>>>> Remove it from the core definitions but keep it for drivers internal
>>>>>>> needs.
>>>>>>>
>>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>>> ---
>>>>>>>     drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
>>>>>>>     drivers/media/platform/amphion/vdec.c | 1 +
>>>>>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
>>>>>>>     drivers/media/platform/qcom/venus/hfi.h | 2 ++
>>>>>>>     drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
>>>>>>>     drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
>>>>>>>     include/media/videobuf2-core.h | 1 -
>>>>>>>     include/media/videobuf2-v4l2.h | 4 ----
>>>>>>>     8 files changed, 11 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>> index 86e1e926fa45..899783f67580 100644
>>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>> @@ -31,6 +31,8 @@
>>>>>>>
>>>>>>>     #include <trace/events/vb2.h>
>>>>>>>
>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>> +
>>>>>>>     static int debug;
>>>>>>>     module_param(debug, int, 0644);
>>>>>>>
>>>>>>> diff --git a/drivers/media/platform/amphion/vdec.c
>>>>>>> b/drivers/media/platform/amphion/vdec.c
>>>>>>> index 3fa1a74a2e20..b3219f6d17fa 100644
>>>>>>> --- a/drivers/media/platform/amphion/vdec.c
>>>>>>> +++ b/drivers/media/platform/amphion/vdec.c
>>>>>>> @@ -28,6 +28,7 @@
>>>>>>>
>>>>>>>     #define VDEC_MIN_BUFFER_CAP            8
>>>>>>>     #define VDEC_MIN_BUFFER_OUT            8
>>>>>>> +#define VB2_MAX_FRAME                  32
>>>>>>>
>>>>>>>     struct vdec_fs_info {
>>>>>>>            char name[8];
>>>>>>> diff --git
>>>>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>> index 6532a69f1fa8..a1e0f24bb91c 100644
>>>>>>> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>> @@ -16,6 +16,8 @@
>>>>>>>     #include "../vdec_drv_if.h"
>>>>>>>     #include "../vdec_vpu_if.h"
>>>>>>>
>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>> +
>>>>>>>     /* reset_frame_context defined in VP9 spec */
>>>>>>>     #define VP9_RESET_FRAME_CONTEXT_NONE0 0
>>>>>>>     #define VP9_RESET_FRAME_CONTEXT_NONE1 1
>>>>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
>>>>>>> b/drivers/media/platform/qcom/venus/hfi.h
>>>>>>> index f25d412d6553..bd5ca5a8b945 100644
>>>>>>> --- a/drivers/media/platform/qcom/venus/hfi.h
>>>>>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
>>>>>>> @@ -10,6 +10,8 @@
>>>>>>>
>>>>>>>     #include "hfi_helper.h"
>>>>>>>
>>>>>>> +#define VB2_MAX_FRAME                          32
>>>>>>> +
>>>>>>>     #define VIDC_SESSION_TYPE_VPE                  0
>>>>>>>     #define VIDC_SESSION_TYPE_ENC                  1
>>>>>>>     #define VIDC_SESSION_TYPE_DEC                  2
>>>>>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>> b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>> index e83f0c523a30..9e8faf7ba6fb 100644
>>>>>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>> @@ -15,6 +15,8 @@
>>>>>>>     #include <media/v4l2-vp9.h>
>>>>>>>     #include <media/videobuf2-core.h>
>>>>>>>
>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>> +
>>>>>>>     #define DEC_8190_ALIGN_MASK    0x07U
>>>>>>>
>>>>>>>     #define MB_DIM                 16
>>>>>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>> index e530767e80a5..6627b5c2d4d6 100644
>>>>>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>> @@ -10,6 +10,8 @@
>>>>>>>     #include "ipu3.h"
>>>>>>>     #include "ipu3-dmamap.h"
>>>>>>>
>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>> +
>>>>>>>     /******************** v4l2_subdev_ops ********************/
>>>>>>>
>>>>>>>     #define IPU3_RUNNING_MODE_VIDEO                0
>>>>>>> diff --git a/include/media/videobuf2-core.h
>>>>>>> b/include/media/videobuf2-core.h
>>>>>>> index 77921cf894ef..080b783d608d 100644
>>>>>>> --- a/include/media/videobuf2-core.h
>>>>>>> +++ b/include/media/videobuf2-core.h
>>>>>>> @@ -20,7 +20,6 @@
>>>>>>>     #include <media/media-request.h>
>>>>>>>     #include <media/frame_vector.h>
>>>>>>>
>>>>>>> -#define VB2_MAX_FRAME  (32)
>>>>>>>     #define VB2_MAX_PLANES (8)
>>>>>>>
>>>>>>>     /**
>>>>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>>>>> b/include/media/videobuf2-v4l2.h
>>>>>>> index 5a845887850b..88a7a565170e 100644
>>>>>>> --- a/include/media/videobuf2-v4l2.h
>>>>>>> +++ b/include/media/videobuf2-v4l2.h
>>>>>>> @@ -15,10 +15,6 @@
>>>>>>>     #include <linux/videodev2.h>
>>>>>>>     #include <media/videobuf2-core.h>
>>>>>>>
>>>>>>> -#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>>>> -#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>>>> -#endif
>>>>>>> -
>>>>>>>     #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>>>     #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>>>     #endif
>>>>>>> --
>>>>>>> 2.39.2
>>>>>>>
>>>> --
>>>> Hsia-Jun(Randy) Li
>>>>
>> --
>> Hsia-Jun(Randy) Li
>>

-- 
Hsia-Jun(Randy) Li
