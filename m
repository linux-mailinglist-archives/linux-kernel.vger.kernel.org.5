Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C315575C236
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjGUI4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUI4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:56:45 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7172D71;
        Fri, 21 Jul 2023 01:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8GewZJQvn3LezOf8YkVlStgTr6HpnjEgOSM2xuNcMWEGNnzKr5xFc1WDscjsEaOuurEVpUeOkFkxlZvhi9WDsYce+NzVHdhe7R8zTfXA572s7Q7VcJaParsoQ0AGP12WEzeFHU7v/ZNJKQ4WRY7nlYBCgUykAqnd1RY7BqyXorjjQ4JNaxPRAD5m/9slRaTiz/Ba1X2hU0s3UTGpRXd7T9BPVrpgt718OIrt12kVueVl9EI5QMwwbw47sdWUSaPrI04XEsMzDA9kYPf3281s/GC3vaoVjCaOETVDjHX/ASDzakMN+JA7lrTEVmqcm15MKKEcV3SkffiGc9mBe9F4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0Di8HWX3zaYtnQlte3m3inRyjcW2thYJHW56hnbFic=;
 b=few5zRfVudX3y1TgrZxzx347OO1OPcMwOw64FND82lUM3lWEw7Y4HejGfjYjC4RqW3yB1L5jEUSL+d5WoaePyVkI/fQHawnvgfoC0bYE4h6PjnSiQmG0w2YHo/33VnY9ZwKovOs9XCbTIJqZg67cYAMeIry4JeRjKxm0gJNhl9gf60f0UlO6tMpnx0PMD1tztHaeilzOis7gXW9rxUv92E1qGjm6+U1Rl2DJbxmjCG+yKotjSScOCo7+PmZSV/POu1TR4kSndtxjah/tgeaFEzMYpSRWkX36GOgZafY4ZrkGp+8L20GOmpoJR3quqLrTiBUjd6SNeU1GH+MSlpXn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0Di8HWX3zaYtnQlte3m3inRyjcW2thYJHW56hnbFic=;
 b=Of1qMHjfCxYmLrpGkLVYlBJ8EVucsfxRPHI4uvWnGt7M5fZQGXCG6Xftp1ncLZg0nqKNM3+L4ZzK8esYvYcp/4vobzLnr4JQKfnLSZ/LWxmJOymoR11VFwhCdbKd7XWC4p5bvY0+45A6Y+Dkwvf52jY2hDInB4LHgeyRZxfebL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by DM6PR03MB5132.namprd03.prod.outlook.com (2603:10b6:5:1e4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.26; Fri, 21 Jul
 2023 08:56:38 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::411c:e486:3837:cc25%3]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 08:56:37 +0000
Message-ID: <452a4d48-fd73-d539-25f6-ded6bc6212bc@synaptics.com>
Date:   Fri, 21 Jul 2023 16:56:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] [RESEND] media: v4l2-mem2mem: allow device run
 without buf
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media@vger.kernel.org, ayaka@soulik.info,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-2-randy.li@synaptics.com>
 <20452e233a9a4b39b58139081d818d3b1454105a.camel@ndufresne.ca>
 <20230712093129.pdcbvlxd5zphwr5m@chromium.org>
 <17ca8c5ee31ac8e48bb2ac7f89f6bae84816c893.camel@ndufresne.ca>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <17ca8c5ee31ac8e48bb2ac7f89f6bae84816c893.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0025.namprd10.prod.outlook.com
 (2603:10b6:a03:255::30) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|DM6PR03MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: c4cb6a47-7a18-4128-a0eb-08db89c8644e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5aISkBUp3QtzjfqtWzuTyUAI4xwTEOAcI3a79/Drm+i7qNzrSQCP83H2PYzcGHcYWUxg/U8eVjBQcL7NtXCUktSIxmFmCbHmj0c5daA3JDzE/nth19JeqPsbJf89AxXl5XxdvHIfHx7p66PivzxCrT1ZI5AeqwV/hLv9og42eKj/ZVoB+mJCmg9ZFSlmXhRQYvO0Q4n5mRPJMP8sYQC+AH7qGp3Ig/wW8fM3zIlS2ZRNUG8cMZ3/wn9qSuF53h7hUEHJzQKga0qU1al7Wznvd/tYYSbxSJb4sU9QKVY/cqztpMzMTl1DC1XiS33izN4PjIjwLU06z9uQ99OQlSk1H91T5PfoRgoCFB8BDURISJ74OAgA4nSgOGekYGVl4EjCMVb1ZQknEHwZ5k3wjCuKS64LDoSAcNMTrC63kmNXaLupjh/JLzuJ8XCNQ6G3BK8RNwTeu3kIV+rFn5IrFnd0wTGb1sGzxKFTjkYPcnvTFEgmGHY5ZNUjg5gwK8eUrpn4SzOJ0wndb9/Gn6bKw2+4yVMLROJE2n1bYMP/u25aFuNBr8458L4SmQ5nKNGANKHabd7ZJMQKjwH350yXbAdFWY9Ogf1FnkuE/As9wCTwubZuAWsvIGvYiTHJbiqXCdyy8fTzzubCeHGwpEzH0cQWh4XiGK7at4v/c8rnyhF63Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(39850400004)(136003)(451199021)(36756003)(2616005)(316002)(186003)(6666004)(83380400001)(41300700001)(6486002)(52116002)(478600001)(66946007)(4326008)(110136005)(53546011)(26005)(6506007)(66556008)(66476007)(6512007)(38350700002)(38100700002)(31696002)(2906002)(86362001)(966005)(8676002)(7416002)(8936002)(5660300002)(66899021)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjlnMFlIcEQ1YnNXSzZlZVRuRUFSVDBMTUdaazNDMTRGQUZKQnhJKzJ1L01I?=
 =?utf-8?B?V1M4MWdwQ0E5ejF1MjhPOVBZSmVSN1hUdjcya28vVkMzVWFZVzB6TE5KYXk3?=
 =?utf-8?B?bmNEeGpib1BHdERRMkZiQ2h1ekRDK0Z5blNNKzVmWjh4MkJEbDkvUFJTTlJ0?=
 =?utf-8?B?UzJSYTFPSWNkRThDZEVDMW03ZDFhN0lHNFg0NWNsZXFMckVTbWljdmg3cGE3?=
 =?utf-8?B?eHhCdjBhYnZQbHBzUFcxOE5scS9PUGNIM01WNGVYc2dSQ2NwTldDQW1CTTdY?=
 =?utf-8?B?ZWUrbTJvdGd6aXlXSUJEdVpHdHlYaktzUGVPTlVmNlBOUVp3NGtiWTV1Rlhx?=
 =?utf-8?B?QzRVdUdZdGMrS3pGbXFncEhXd1NPWHMxeGU3UkVFcjRJc2VvdkRzOWdzM3RJ?=
 =?utf-8?B?RlBHR3B3RGc0RmhIN0FtNkhkWFN1NkJ1MldCVjRlT2FHYklLMlBDMXljbDk0?=
 =?utf-8?B?YmRpV0FuNDJKS1NUK1I5U1BodXhIZVh5dWRtZTNDTXJoT0dqcGd0Y3JHOFkw?=
 =?utf-8?B?ZkxhQ25XRldyaDEwOWFVZDJOWTAwNGRZOFh1bWlKZ00rU3JrZkpKcmw4SnhD?=
 =?utf-8?B?Y213aFRoaE84ekthTklxMUtOTm4yOFBRMTEreTVLdUhSYm0xL2ptei9LMVh3?=
 =?utf-8?B?SHNkVjBONkFDbm5tdTMyM014RDBIdVBWSk5rbVVJVGxadjl2Qi9lRForMGxn?=
 =?utf-8?B?bWgxcTdnWFZjUnQwQVRJMWhhVEpKVk5zd1lWOGFwNmZpRXlDTGErMjlHOTR3?=
 =?utf-8?B?eWFIR05iQ1VvUHpBYWkrU2hQYXRxUkRKdURycXk5b3l4VUtEVElyNDRkSkh0?=
 =?utf-8?B?TXBBbFpzSjNPODkxckhmakJEVTJhbHpYTEpQcnZpeUN4MU82Z1VPamhxZHVo?=
 =?utf-8?B?NnRlTnQ5a25tUldvT3c3QkxBbEZDOXJwTWp5VnMzcFJ0SHptWUIxbkxUTjFj?=
 =?utf-8?B?MWo4OVJDMFVsNjB0S295SHVJSndkbW02c0FrRFQzK3VsdkJIU3o3SElVeFAw?=
 =?utf-8?B?Z3FiMWltclRqNEFkWVZIMy9BYy9ueHkwWkJYQlM3bXBoWlVZbXJ4Tk9tYzQv?=
 =?utf-8?B?dk9EbzJxM0l3cytqd1c4UTBpUjZCWXB5VXBLWnJzOWx3ajJvZXN2VEV5Q2R5?=
 =?utf-8?B?aU5QS2I2OTRQSThpTFErdi9mSS9NNitTWExLS2t6SDlFempORW9IR01IY2tD?=
 =?utf-8?B?cGRmbEt2bGJEanpNRWV0a3Z5a0hyc091eUZVRWNzRU5CM1VUKytIbElSRW5L?=
 =?utf-8?B?VzdROFRVM01WUDMrN1ZXTXRsYkdTVE5sQStReGFZMEpqZXp1UmNveW5ncFJZ?=
 =?utf-8?B?NUtmVVVveXVsQUlTZG9iSlA1TWxVS3I5UXR4L0wwNUQvaWhsVUUrTkZRNWtJ?=
 =?utf-8?B?b1JrV29mWXVEUlB4eDJ3cEFoSVVUMVF3Vys5cnJNNnlSRnBQZGhVdW9wZDJM?=
 =?utf-8?B?Q0dmZTVwR0h6RytRRXg3NDFjUTkyL3VmY2RXdEpwbTNFUHJZQ2QzQS9yeHNm?=
 =?utf-8?B?TTRWelhRbEpaNlFOTTdXVFgxYjBNWFh3L1JXUzJrdWNabHFSbFRNZlJxbm5V?=
 =?utf-8?B?MU9Ucm5uMVlnc2pzVXJoT29Jc0F3WHhOcDd1L1RHRmtHRTB0RTN0VHBSNmJM?=
 =?utf-8?B?WlpSNmhBVTRiblp0dDVsSytscjJ2eTdJcVA3VzNuUHNGWFdNSDczL0lTV000?=
 =?utf-8?B?VTRuK2RRNHI3cXJlY1ZFbzNmcjhiZVNBM0xKSmFjZWNIV2RhNEovQXNJN0kz?=
 =?utf-8?B?TmxKVXV2M0lSeXNqOVI1ZGQ4M2RrU1dJTHBQa0xORmhaaDBvbnB0OEQ3WjZ1?=
 =?utf-8?B?RmhpWTdsRFhjK1ZDbmdWVnZwYjNjb00xQUpGTmczeWkrZEJLcFdLeHhnNUxN?=
 =?utf-8?B?QndCZFJXaHpGSHpyQ2pKMUVDRU5ndXFxZ0N0Zm45UnZyRFE4T0Y2ZG03aFNV?=
 =?utf-8?B?OTJJMFNHeHUyc2JkdjltdERjUEF4OVVwUDhmOW82WERGTzBWY2lGN1JZWXN4?=
 =?utf-8?B?czBBQ2N4SGg0a0VkSDRNVVNmSmxHUlVPcGdGTVBSeEpqUEorQ1BPR2RwTnoy?=
 =?utf-8?B?MzRuK2wvbDV2MEhXWitKb1Rtc0c5MXBpbFJrc041b1hoaXBNRXlYd21LZjBY?=
 =?utf-8?Q?Tfzg4Jy9MExqrPz6cwLjo9hpB?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4cb6a47-7a18-4128-a0eb-08db89c8644e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 08:56:37.4663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5tBnb/vkOhg1sZmYlI/pmjmxezeLzVC7Dvlm1n0TM9OG969rNIxwKu0crNsgLqJGE4r2tjBFEJjWJ1PxImXOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5132
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 22:00, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le mercredi 12 juillet 2023 à 09:31 +0000, Tomasz Figa a écrit :
>> On Fri, Jul 07, 2023 at 03:14:23PM -0400, Nicolas Dufresne wrote:
>>> Hi Randy,
>>>
>>> Le mardi 04 juillet 2023 à 12:00 +0800, Hsia-Jun Li a écrit :
>>>> From: Randy Li <ayaka@soulik.info>
>>>>
>>>> For the decoder supports Dynamic Resolution Change,
>>>> we don't need to allocate any CAPTURE or graphics buffer
>>>> for them at inital CAPTURE setup step.
>>>>
>>>> We need to make the device run or we can't get those
>>>> metadata.
>>>>
>>>> Signed-off-by: Randy Li <ayaka@soulik.info>
>>>> ---
>>>>   drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>> index 0cc30397fbad..c771aba42015 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>> @@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_dev *m2m_dev,
>>>>
>>>>    dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
>>>>
>>>> - if (!m2m_ctx->out_q_ctx.q.streaming
>>>> -     || !m2m_ctx->cap_q_ctx.q.streaming) {
>>>> + if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered)
>>>> +     || !(m2m_ctx->cap_q_ctx.q.streaming
>>>> +          || m2m_ctx->cap_q_ctx.buffered)) {
>>>
>>> I have a two atches with similar goals in my wave5 tree. It will be easier to
>>> upstream with an actual user, though, I'm probably a month or two away from
>>> submitting this driver again.
>>>
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.collabora.com_chipsnmedia_kernel_-2D_commit_ac59eafd5076c4deb3bfe1fb85b3b776586ef3eb&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=9eWwqueFnh1yZHTW11j-syNVQvema7iBzNQeX1GKUQwXZ9pm6V4HDL_R2tIYKoOw&s=Ez5AyEYFIAJmC_k00IPO_ImzVdLZjr_veRq1bN4RSNg&e=
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.collabora.com_chipsnmedia_kernel_-2D_commit_5de4fbe0abb20b8e8d862b654f93e3efeb1ef251&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=9eWwqueFnh1yZHTW11j-syNVQvema7iBzNQeX1GKUQwXZ9pm6V4HDL_R2tIYKoOw&s=tM81gjNe-bTjpjmidZ1sAhiodMh6npcVJNOhMCi1mPo&e=
>>>
>>
>> While I'm not going to NAK this series or those 2 patches if you send
>> them, I'm not really convinced that adding more and more complexity to
>> the mem2mem helpers is a good idea, especially since all of those seem
>> to be only needed by stateful video decoders.
>>
>> The mem2mem framework started as a set of helpers to eliminate boiler
>> plate from simple drivers that always get 1 CAPTURE and 1 OUTPUT buffer,
>> run 1 processing job on them and then return both of the to the userspace
>> and I think it should stay like this.
> 
> Its a bit late to try and bring that argument. It should have been raised couple
> of years ago (before I even started helping with these CODEC). Now that all the
> newly written stately decoders uses this framework, it is logical to keep
> reducing the boiler plate for these too. In my opinion, the job_ready()
> callback, should have been a lot more flexible from the start. And allowing
> driver to make it more powerful does not really add that much complexity.
> 
> Speaking of complexity, driving the output manually (outside of the job
> workqueue) during sequence initialization is a way more complex and risky then
> this. Finally, sticking with 1:1 pattern means encoder, detilers, image
> enhancement reducing framerate, etc. would all be unwelcome to use this. Which
> in short, means no one should even use this.
> 
I think those things are m2m, but it would be hard to present in current 
m2m framework:
1. N:1 compositor(It may be implemented as a loop running 2:1 compositor).
2. AV1 film gain
3. HDR with dynamic meta data to SDR

The video things fix for m2m model could be just a little less complex 
than ISP or camera pipeline. The only difference is just ISP won't have 
multiple contexts running at the same time.
If we could design a model for the video encoder I think we could solve 
the most of problems.
A video encoder would have:
1. input graphics buffer
2. reconstruction graphics buffer
3. motion vector cache buffer(optional)
4. coded bitstream output
5. encoding statistic report
>>
>> I think we're strongly in need of a stateful video decoder framework that
>> would actually address the exact problems that those have rather than
>> bending something that wasn't designed with them in mind to work around the
>> differences.
> 
> The bend is already there, of course I'd be happy to help with any new
> framework. Specially on modern stateless, were there is a need to do better
> scheduling.
I didn't know the schedule problem about stateless codec, are they 
supposed to be in the job queue when the buffers that DPB requests are 
own by the driver and its registers are prepared except the trigger bit?
  Just ping me if you have some effort starting, I don't currently
> have a budget or bandwidth to write new drivers or port existing drivers them on
> a newly written framework.
> 
> Nicolas
> 
> 
> [...]

-- 
Hsia-Jun(Randy) Li
