Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A568279736A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbjIGPXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjIGPXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C11A8;
        Thu,  7 Sep 2023 08:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz0ELa4dICUQcRUpjKfldYFnUh5NfvgMcnd9iHEZTd91zzsp/yMKpwY3VdW+QL3b/7gKaWhU1mdnCT0pg/bOsB7cv4KNBpiS7fdfguzVnvnOUXp1vfcNuMkYXofQSp+2WN98wvVzaEo1ycX5XeOE4VIezFbeYD950qy9d0GHM0SVij4zgHUyTV54wRRpkX30pShzyJs+flbPgQNI7/9rWJEGn0x2gLFxw0iad6ZMNtApsdPvNp69yPCR0HuGxqpCvtBNjl5t6P2bTiECtmxW1bkvbtXIB4YHycOSlqHQyscZPMgqIIQvGNM9lY4ADYiJvSF5nPnd9f0hD6m6ETgwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY1nFnXv5b4xbGZIJUeRlG8ASTcVV+JOXzwaSg1uBNw=;
 b=dzkVXQba7pr3fA8yufLx5p0BQkZHhVI8ewFSm78UJXgFG+wScGx2Mz1stBCk4/wArsnyZrdwzs2dVE/6gtRdSX3f1rF+81UZH3dMbrWdPXyws9ptpeKThE2tOexLaaElWeN/uoX1DOTC4/CXDU5rOZdoYJd2M2xmo646voynZKbhWfqZH42ClVUy1vPk+S+iaGdeuvaEw5YG/tIjEQqydAXqUmZ8hTElZ6O93ywHfYOOkNu22f8nCeaZ8hQ6plRFIn0HQ6fKQfMlgdAZuBU5+JnYx+401OYZdL+KvKqUK74qlekZjMl1zYuAwW3EbvcXku6tTnZ9aXZxTZG2ez66kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY1nFnXv5b4xbGZIJUeRlG8ASTcVV+JOXzwaSg1uBNw=;
 b=xWAjIHTu2h52MTGEoBaxCMCCNZ2Jm9IWNfuoTUXyQWPl54FP64757EBzb4p2eW3xQu6a4W7baby90vUq2VXU8DDOBppWyAv4m2iTLYeGwShLsPzwvr5aIA7fC5HiKL5i9vbOKkYzuPTpuyilWYWgSTtGNrei3fdeN2RalERNvIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by LV8PR03MB7519.namprd03.prod.outlook.com (2603:10b6:408:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 06:54:34 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 06:54:34 +0000
Message-ID: <282f9c8c-fee4-a4d8-127b-8636c17e2bdc@synaptics.com>
Date:   Thu, 7 Sep 2023 14:54:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 04/11] media: videobuf2: Stop define VB2_MAX_FRAME as
 global
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
 <9bc67e88-bce1-b812-aa57-76eca764cb38@synaptics.com>
 <CAAFQd5DpCfS7RyTbd_kfFz+wQ41=gnLosMMNK_GcH8JO=DbzSQ@mail.gmail.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
Content-Language: en-GB
In-Reply-To: <CAAFQd5DpCfS7RyTbd_kfFz+wQ41=gnLosMMNK_GcH8JO=DbzSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|LV8PR03MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 425c8f43-a3f0-48a7-71e5-08dbaf6f4b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvFCYiA6sd4i1yCslEqU5OvLRsCllpYgS5R+bIv8K/WEcbKKl2SGPALItrheB4IbLriQkCNe9SL6Y1gGS4XaMQ3OR4WgUGvoCrF5UMvDXsqPHv2BKiau8lTWC2EnivtphKQLo2zezHfi5Rff0UkGqvF1AqdYV/EF8SlmgOffF75zWeXfR/+zSguYER7XsXoG8b/b/c0BCvg60WeCoqe2LskmfIK9d9GoYiVlMYLFTlD9aXBVa/mHNPMC9LvSGFFj5mStdo8HXvNIg7TENTpEXroL3RcXC5EerxMVKXZ5wtlR3rvPh1Cuxr8LZrE8nM8FkfL2GspLUuE7gJNvjhrcqTk6nUTqJYAgS18gNoY9Fscr+i2Vdwb6xEA017JwblxyFG8o/MFPwWBC91YCOQZ+ykNVW/tQVyZhCNguwMSNskmrnFJj1tL+ppzXT/q0EaFOJFpxsgQLKdp9ijePermfKiJ9NHX8ajUlimQthRbvHN0g7jyXqiGPPh9JysIvMy7vmV/6KPTTtk2vEAP5iRtKAo9LijqFMsAs12TiPlADbkkqpzOgm46k3Nj+MWoUQID+QT5SENXUfMZAAd1plOw4M9XGGbrPTyLMSWorjYGB2h9mg2ehUbNoTOKCBZD+Xg5Nzk/53i26LRPDcio2fEqyO66AgD0qRpYDVWUjScurjow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199024)(1800799009)(186009)(31686004)(38100700002)(66899024)(6512007)(6506007)(6486002)(6666004)(53546011)(52116002)(8676002)(36756003)(31696002)(86362001)(38350700002)(26005)(2616005)(66574015)(30864003)(7416002)(478600001)(966005)(83380400001)(5660300002)(316002)(8936002)(2906002)(41300700001)(4326008)(66556008)(6916009)(66946007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjlmYjBKbzBFTnUwWmhqNjlVNUwwQlFRWXVDZVZ3MDN3RDhtbUd2dFVsUGQ3?=
 =?utf-8?B?NGV3Ny9uTDdSemVEcndBZ2xMeW1lcU16aHlCN2JRRldtMlptUWFoeUhFU3Jt?=
 =?utf-8?B?ME4xLzE2T3RoUFNFdjdBNW5yYThkdzRjdTNyU0JTNnlqcFZGamp4SWNsdE9F?=
 =?utf-8?B?cUwva3J2dm9NckZ2dWZZd0VycHozNmRHOGJSWFc4M1dZWGxKL042RzFzRElr?=
 =?utf-8?B?UDBibktRcUh0NVVnVXdFZFAvYk5CbEVRanZvRzZFVjNDWTVxL0g3NHhKRU8w?=
 =?utf-8?B?b2FNTmlESFJDKzk2Mmo1RkJpNXRhMEVKejRhYU0wYUdzcHhpOS9jMTlqMzVW?=
 =?utf-8?B?dVdCR2dxMjc5cVNsd1RxcWZXNm9VK1hlOUlFL2pReUZuZDh3blBOTCtzNS8r?=
 =?utf-8?B?eG9Mb2ExZ1F2L3JmR3JTM09WSndua0VicEdoZE5aQndPTnMveURNQ0VRL2di?=
 =?utf-8?B?bmtWWHphYmw5dGtLSUcvTkg4cHhvSXJuWDVIU1RmMTlPd29iejJWY2RGc3BT?=
 =?utf-8?B?emhPV0NGZG1WS1AwQTVhMjhzL1I3Z2F4N1pjTGcrUjdLbHhnVGJPek53bVlK?=
 =?utf-8?B?R1hqWi9yTGxSZ1lLSjM2aHB2OGxWd1dnOFFrR3lkQW96S0hsSHdRU2RLTnky?=
 =?utf-8?B?dkJBc3RlZllVcUhiaHc5Qy96TDhrQU5RczQ2TEt3NnBSTXNRcUNZbjh6ek0y?=
 =?utf-8?B?aHhPamdPdnZqOUozNFRtSlFMemQwK2JSQjFlQmF3cTRFYldwdFArUi9jMXJD?=
 =?utf-8?B?eGdWUTVUVW91eVM4OG1hSHIxVEM4K0VaNDhmRzljTnlpd0FMOExpVTlWeUVU?=
 =?utf-8?B?dmNqK1pQYW1NWXRoUUlXdmxGQjlicDBUcEFqK2JKdWovQjdNQjg3ZjlwTG5Y?=
 =?utf-8?B?YUtRUDRMaG9LcDZGckZBU2pGVmtBNUw5RzNuNW9GR0wzcTd6QndtdHFkL2Fa?=
 =?utf-8?B?bjU0WXkwNWs2U2hOSDRrdUJibS9NYkxQUDZQK2lMS0VFekdLZGhNeU82Y1U5?=
 =?utf-8?B?cndPcTZkeGs2bW9mMEtOSjgwaW85eTR2R21XdHZ0NkpHMEg5MXNuRDVVS0U5?=
 =?utf-8?B?Yk9uWmdoTEZ2akZSYlc4UmQ2TFRKc09LT0tRV2txRWdTWDJhODlkb29ObU1P?=
 =?utf-8?B?TzdvVlZHNWZvOVIxazVHUVY4cU5QTmlkZUpvUEJIbERQa0N0NnR6L1d5enE2?=
 =?utf-8?B?OWNPUU1US2tONmpGZ0UzTW5ZeGxRc0J3M1FiOVdrL1Y1c3d2UEJBdEt1VW45?=
 =?utf-8?B?UmUwZndCWVZKWGQrc3JoTUY2Rk1SZXNUbTNOekMrNk5tc3NxT1d0d0hVcDdK?=
 =?utf-8?B?V3RrRHU3SjVHWlhYWmZ3LzZ4WU9hbEY4ZnI1eXk0aytvYnIrVEFCekxZa2N6?=
 =?utf-8?B?SXdEeHlrSjZhdG1LRzcrbmRnQll2dEhqWmcyNDFhZm1qdnFsN0pXV2N1ZFJj?=
 =?utf-8?B?ZGxCYlhvb3ozNTRGei9zUGh1cjJPVElxZmpMVjZSUmJSRmxCa2NzSitNbStD?=
 =?utf-8?B?QjR2Q3MwaXlyWXRKZGV5QmU0WTFhVnNYVXE3WnpLWG5HOTBlNHRwRElrRmxC?=
 =?utf-8?B?STBjaUJNeU5BUXF0U2d4VG9HM3ZrS3k0MllTL2FvYk9DWnBMSXRvR0pVZm8x?=
 =?utf-8?B?VCt6TUt0WGJXL3pFUXZZQW82U2kwUVF0SXlwL3ptNDE4VFlyMU1mb1dRaUhy?=
 =?utf-8?B?c3AwS2RnZzVXNkxDYllRQ2RtTUJ0clpWMkUvWjZDQXpUYUJoakFFTE1EMlFz?=
 =?utf-8?B?ZUI0UEF1QzBMaVdwSGNQRHg5SGtpRElDODN6SkhIbkg4N1JpOXBMc0NIS2VY?=
 =?utf-8?B?amYvU0E4a0VPNnIrZ00rSklYbjZoMERGYlZyUXVVTXpYeVpXV0dOaWVxZ3Vq?=
 =?utf-8?B?Z1FCQUJpZ2Q4NDdDcGFpY0wwaTRvYzYxaFNlcGVqM1d5akloVWdHaEFtS3ZO?=
 =?utf-8?B?S05WL2VsQ25KVEFxMHpDdzhsQmhZMkI3Y2FjSHh3YXNEZk9EekpxdHZaQ29m?=
 =?utf-8?B?YWg1NURYVGRsWlJNV2RNY2pEMkJRZGVyc3Vsb1hFekQ4ckorR0RjclU0MnFt?=
 =?utf-8?B?SGlEN1VOMW15VTRNVnM4bXBXRis3M0RIVGdCNUkvNWlaQVExaS9mbXpFN2Q2?=
 =?utf-8?Q?BLe4YGlHd7Lm/z1/YgUS05mV0?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 425c8f43-a3f0-48a7-71e5-08dbaf6f4b09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 06:54:34.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3po6+CrmS6OZKGV2UdzcuyVP+JHrePb5Ev5lW5UQ/1O3V7PQ/HZakqIUcuKMmdVHA1qfHl/vfEkE+Kv4kdjsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR03MB7519
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are little off topic here.

On 9/7/23 12:15, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Fri, Jul 28, 2023 at 4:25 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>
>>
>>
>> On 7/28/23 15:03, Tomasz Figa wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> On Fri, Jul 28, 2023 at 3:55 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/28/23 14:46, Tomasz Figa wrote:
>>>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>
>>>>>
>>>>> On Mon, Jul 17, 2023 at 4:44 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 7/12/23 18:48, Tomasz Figa wrote:
>>>>>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>>>
>>>>>>>
>>>>>>> On Mon, Jul 03, 2023 at 04:35:30PM +0800, Hsia-Jun Li wrote:
>>>>>>>> On 7/3/23 16:09, Benjamin Gaignard wrote:
>>>>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>>>>> attachments unless you recognize the sender and know the content is
>>>>>>>>> safe.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Le 30/06/2023 à 11:51, Hsia-Jun Li a écrit :
>>>>>>>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>>>>>>>>> CAUTION: Email originated externally, do not click links or open
>>>>>>>>>>> attachments unless you recognize the sender and know the content is
>>>>>>>>>>> safe.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> After changing bufs arrays to a dynamic allocated array
>>>>>>>>>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
>>>>>>>>>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI kernel is
>>>>>>>>>> more reasonable.
>>>>>>>>>>
>>>>>>>>>> It would be hard to iterate the whole array, it would go worse with a
>>>>>>>>>> filter. Such iterate may need to go twice because you mix
>>>>>>>>>> post-processing buffer and decoding buffer(with MV) in the same array.
>>>>>>>>> Here I don't want to change drivers behavior so I keep the same value.
>>>>>>>>> If it happens that they need more buffers, like for dynamic resolution
>>>>>>>>> change
>>>>>>>>> feature for Verisilicon VP9 decoder, case by case patches will be needed.
>>>>>>>>>
>>>>>>>> I just don't like the idea that using a variant length array here.
>>>>>>>>
>>>>>>> "I don't like" is not an argument. We had a number of arguments for
>>>>>>> using a generic helper (originally idr, but later decided to go with
>>>>>>> XArray, because the former is now deprecated) that we pointed out in
>>>>>>> our review comments for previous revisions. It wasn't really about the
>>>>>>> size being variable, but rather avoiding open coding things in vb2 and
>>>>>>> duplicating what's already implemented in generic code.
>>>>>>
>>>>>> I just want to say I don't think we need a variable length array to
>>>>>> store the buffer here.
>>>>>>
>>>>>> And the below is the reason that such a case could be avoided in the
>>>>>> first place.
>>>>>>
>>>>>>>
>>>>>>>> And I could explain why you won't need so many buffers for the performance
>>>>>>>> of decoding.
>>>>>>>>
>>>>>>>> VP9 could support 10 reference frames in dpb.
>>>>>>>>
>>>>>>>> Even for those frequent resolution changing test set, it would only happen
>>>>>>>> to two resolutions,
>>>>>>>>
>>>>>>>> 32 would be enough for 20 buffers of two resolution plus golden frames. It
>>>>>>>> also leaves enough slots for re-order latency.
>>>>>>>>
>>>>>>>> If your case had more two resolutions, likes low->medium->high.
>>>>>>>>
>>>>>>>> I would suggest just skip the medium resolutions, just allocate the lower
>>>>>>>> one first for fast playback then the highest for all the possible
>>>>>>>>
>>>>>>>> medium cases. Reallocation happens frequently would only cause memory
>>>>>>>> fragment, nothing benefits your performance.
>>>>>>>>
>>>>>>> We have mechanisms in the kernel to deal with memory fragmentation
>>>>>>> (migration/compaction) and it would still only matters for the
>>>>>>> pathologic cases of hardware that require physically contiguous memory.
>>>>>>> Modern hardware with proper DMA capabilities can either scatter-gather
>>>>>>> or are equipped with an IOMMU, so the allocation always happens in page
>>>>>>> granularity and fragmentation is avoided.
>>>>>>
>>>>>> Unfortunately, there are more devices that didn't have a IOMMU attached
>>>>>> to it, supporting scatter gather is more odd.
>>>>>>
>>>>>> It would be more likely that IOMMU would be disabled for the performance
>>>>>> reason.
>>>>>
>>>>> These days IOMMU is totally mandatory if you want to think about
>>>>> having any level of security in your system. Sure, there could be some
>>>>> systems that are completely isolated from any external environment,
>>>>> like some offline industry automation machines, but then arguably
>>>>> their running conditions would also be quite static and require very
>>>>> little memory re-allocation.
>>>> Vendor just decided not to included such hardware.
>>>> That is why From ION to DMA-heap, people like to allocate from a cavout
>>>> out memory.
>>>>>
>>>>> I also don't buy the performance reason. CPUs have been behind MMUs
>>>>> for ages and nobody is running them with paging disabled for
>>>>> performance reasons. Similarly, most of the modern consumer systems
>>>> Page lookup would increase the delay. Besides a few upstream devices
>>>> prove them only use a level 1 page table without TBL.
>>>
>>> That's just an excuse for a bad hardware design/implementation. As I
>>> said, there are good IOMMU implementations out there that don't suffer
>>> from performance issues.
>>>
>> I could do nothing about that.
>> Besides, even with TLB, cache missing could happen frequently,
>> especially we need to access many (5~16, 10 usually) buffers and more
>> 11MBytes each in a hardware processing.
>> You can't have a very large TLB.
> 
> Right, but as I wrote in my previous emails, we have the right methods
> in the kernel for providing drivers with contiguous memory and those
> can be used for those special cases.
> 
I think we were talking about whether the IOMMU should be considered 
mandatory for the future possible hardware.

About the right methods, I don't think we have a protocol for negotiate 
the allocation hints between drivers or anybody.
I sent an email to dri-devel to start(continue) the discussion of that.
>>>>> (mobile phones, PCs) run with IOMMUs enabled for pretty much anything
>>>>> because of the security reason and they don't seem to be having any
>>>> If the page is secure, you can't operate it in a insecure IOMMU or MMU.
>>>> The most security way here, we should use a dedicated memory(or a zone
>>>> in unified memory).
>>>
>>> You still need something to enforce that the hardware is not accessing
>>> memory that it's not supposed to access. How do you do that without an
>>> IOMMU?
>>>
>> If you know the arm security pipeline and security controller, you could
>> found we could reserved a range of memory for a security id(devices in
>> secure world may be a different security domain).
>> Besides, a MMU or security MPU could mark some pages for the secure
>> world access only, it doesn't mean the device need an IOMMU to access
>> them. The MPU could filter the access through the AXI id.
>>>> I believe there are more users in mobile for DMA-heap than kernel's dma
>>>> allocation API.
>>>
>>> Yes, but that's completely separate from whether there is an IOMMU or
>>> not. It's just a different allocation API.
>>>
>> The memory heap would mean a dedicated memory usually(we don't talk
>> about system heap or why there are many vendor heaps). Dedicated memory
>> means contiguous memory in the most of cases.
> 
> No, and no.
> First no - DMA-buf heap doesn't imply dedicated memory and usually one
> wants to completely avoid carving out memory, because it becomes
> useless if specific use case is not active.
> Second no - there are ways to provide dedicated memory regions to the
> DMA mapping API, such as shared or restricted DMA pool [1].
> 
> [1] https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml
> 
I think the reserved memory exits even before the ION was in kernel.
Why Android prefer to use ION and now DMA-heap, I thinik it is a 
google's problem.
Youl can say what reserved memory didn't do is allowing allocate from 
the userspace. That is how gralloc in Android works.
Allocation decided by the users could be a important feature, for 
example, a video codec could decode either secure or non secure buffer.
We could make the driver only allocate the non secure memory while the 
usersapce could feed the secure memory, that could satisfy both generic 
application and DRM video playback.
> Best regards,
> Tomasz
> 
>>>>> performance issues. In fact, it can improve the performance, because
>>>>> memory allocation is much easier and without contiguous careouts (as
>>>>> we used to have long ago on Android devices) the extra memory can be
>>>>> used for buffers and caches to improve system performance.
>>>>>
>>>>> Best regards,
>>>>> Tomasz
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Best regards,
>>>>>>> Tomasz
>>>>>>>
>>>>>>>>>>> Remove it from the core definitions but keep it for drivers internal
>>>>>>>>>>> needs.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
>>>>>>>>>>>       drivers/media/platform/amphion/vdec.c | 1 +
>>>>>>>>>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
>>>>>>>>>>>       drivers/media/platform/qcom/venus/hfi.h | 2 ++
>>>>>>>>>>>       drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
>>>>>>>>>>>       drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
>>>>>>>>>>>       include/media/videobuf2-core.h | 1 -
>>>>>>>>>>>       include/media/videobuf2-v4l2.h | 4 ----
>>>>>>>>>>>       8 files changed, 11 insertions(+), 5 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>>>>> index 86e1e926fa45..899783f67580 100644
>>>>>>>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>>>>>>>> @@ -31,6 +31,8 @@
>>>>>>>>>>>
>>>>>>>>>>>       #include <trace/events/vb2.h>
>>>>>>>>>>>
>>>>>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>>>>>> +
>>>>>>>>>>>       static int debug;
>>>>>>>>>>>       module_param(debug, int, 0644);
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/media/platform/amphion/vdec.c
>>>>>>>>>>> b/drivers/media/platform/amphion/vdec.c
>>>>>>>>>>> index 3fa1a74a2e20..b3219f6d17fa 100644
>>>>>>>>>>> --- a/drivers/media/platform/amphion/vdec.c
>>>>>>>>>>> +++ b/drivers/media/platform/amphion/vdec.c
>>>>>>>>>>> @@ -28,6 +28,7 @@
>>>>>>>>>>>
>>>>>>>>>>>       #define VDEC_MIN_BUFFER_CAP            8
>>>>>>>>>>>       #define VDEC_MIN_BUFFER_OUT            8
>>>>>>>>>>> +#define VB2_MAX_FRAME                  32
>>>>>>>>>>>
>>>>>>>>>>>       struct vdec_fs_info {
>>>>>>>>>>>              char name[8];
>>>>>>>>>>> diff --git
>>>>>>>>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>>>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>>>>>> index 6532a69f1fa8..a1e0f24bb91c 100644
>>>>>>>>>>> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>>>>>> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>>>>>>>> @@ -16,6 +16,8 @@
>>>>>>>>>>>       #include "../vdec_drv_if.h"
>>>>>>>>>>>       #include "../vdec_vpu_if.h"
>>>>>>>>>>>
>>>>>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>>>>>> +
>>>>>>>>>>>       /* reset_frame_context defined in VP9 spec */
>>>>>>>>>>>       #define VP9_RESET_FRAME_CONTEXT_NONE0 0
>>>>>>>>>>>       #define VP9_RESET_FRAME_CONTEXT_NONE1 1
>>>>>>>>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
>>>>>>>>>>> b/drivers/media/platform/qcom/venus/hfi.h
>>>>>>>>>>> index f25d412d6553..bd5ca5a8b945 100644
>>>>>>>>>>> --- a/drivers/media/platform/qcom/venus/hfi.h
>>>>>>>>>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
>>>>>>>>>>> @@ -10,6 +10,8 @@
>>>>>>>>>>>
>>>>>>>>>>>       #include "hfi_helper.h"
>>>>>>>>>>>
>>>>>>>>>>> +#define VB2_MAX_FRAME                          32
>>>>>>>>>>> +
>>>>>>>>>>>       #define VIDC_SESSION_TYPE_VPE                  0
>>>>>>>>>>>       #define VIDC_SESSION_TYPE_ENC                  1
>>>>>>>>>>>       #define VIDC_SESSION_TYPE_DEC                  2
>>>>>>>>>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>>>>>> b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>>>>>> index e83f0c523a30..9e8faf7ba6fb 100644
>>>>>>>>>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>>>>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>>>>>>>> @@ -15,6 +15,8 @@
>>>>>>>>>>>       #include <media/v4l2-vp9.h>
>>>>>>>>>>>       #include <media/videobuf2-core.h>
>>>>>>>>>>>
>>>>>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>>>>>> +
>>>>>>>>>>>       #define DEC_8190_ALIGN_MASK    0x07U
>>>>>>>>>>>
>>>>>>>>>>>       #define MB_DIM                 16
>>>>>>>>>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>>>>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>>>>>> index e530767e80a5..6627b5c2d4d6 100644
>>>>>>>>>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>>>>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>>>>>>>> @@ -10,6 +10,8 @@
>>>>>>>>>>>       #include "ipu3.h"
>>>>>>>>>>>       #include "ipu3-dmamap.h"
>>>>>>>>>>>
>>>>>>>>>>> +#define VB2_MAX_FRAME  32
>>>>>>>>>>> +
>>>>>>>>>>>       /******************** v4l2_subdev_ops ********************/
>>>>>>>>>>>
>>>>>>>>>>>       #define IPU3_RUNNING_MODE_VIDEO                0
>>>>>>>>>>> diff --git a/include/media/videobuf2-core.h
>>>>>>>>>>> b/include/media/videobuf2-core.h
>>>>>>>>>>> index 77921cf894ef..080b783d608d 100644
>>>>>>>>>>> --- a/include/media/videobuf2-core.h
>>>>>>>>>>> +++ b/include/media/videobuf2-core.h
>>>>>>>>>>> @@ -20,7 +20,6 @@
>>>>>>>>>>>       #include <media/media-request.h>
>>>>>>>>>>>       #include <media/frame_vector.h>
>>>>>>>>>>>
>>>>>>>>>>> -#define VB2_MAX_FRAME  (32)
>>>>>>>>>>>       #define VB2_MAX_PLANES (8)
>>>>>>>>>>>
>>>>>>>>>>>       /**
>>>>>>>>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>>>>>>>>> b/include/media/videobuf2-v4l2.h
>>>>>>>>>>> index 5a845887850b..88a7a565170e 100644
>>>>>>>>>>> --- a/include/media/videobuf2-v4l2.h
>>>>>>>>>>> +++ b/include/media/videobuf2-v4l2.h
>>>>>>>>>>> @@ -15,10 +15,6 @@
>>>>>>>>>>>       #include <linux/videodev2.h>
>>>>>>>>>>>       #include <media/videobuf2-core.h>
>>>>>>>>>>>
>>>>>>>>>>> -#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>>>>>>>> -#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>>>>>>>> -#endif
>>>>>>>>>>> -
>>>>>>>>>>>       #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>>>>>>>       #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>>>>>>>       #endif
>>>>>>>>>>> --
>>>>>>>>>>> 2.39.2
>>>>>>>>>>>
>>>>>>>> --
>>>>>>>> Hsia-Jun(Randy) Li
>>>>>>>>
>>>>>> --
>>>>>> Hsia-Jun(Randy) Li
>>>>>>
>>>>
>>>> --
>>>> Hsia-Jun(Randy) Li
>>
>> --
>> Hsia-Jun(Randy) Li

-- 
Hsia-Jun(Randy) Li
