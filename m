Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83F755F20
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGQJVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjGQJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:21:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8175EE9;
        Mon, 17 Jul 2023 02:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiOo1ZSG6NB+YQMlC5asbJxA1u9Gk2y7WUO6FCFlOV686ATN5gWKq9qADBLWxAfn8Aeisxw/lrKIV6PhoEF7xs5GyXZG2MEXgHC+qidoOVnKd9sL7yiv2+HqG45f5URUG+Dzem5UulvjUfsk9sg64vZZgdfexSpdbI515N3imE5pg2Gu4XTWIUflYEKhKvdglWVADo6sfE/7UMIlZt6aii0JH4AiDdquicW1aTSHq3nNV/eAjx6LQurakdoo+9YDhpL0FAWyLCjOLNnvUowVdYsT6Gj1sYJlY6HDlXxltgnwScg5W6AWnkB+FtDc8Zip6Vt0aFj9es9BhKiEgVGHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LH50eQoxUDTdcqWT2fKNmW+3tPDspEh4Do/nCHwZ/Uk=;
 b=jnH98MCnlvtd4KLLcjtdhIjyEvIaFaWtw/zz+yYK/VvZviPWsec4Edm5hxLi090Pk8gGaf4XRCPeGJdFyWMuP3DC1WkHeKCcAbIrOKhG/D1aHcM2P3y1yueQAhGInMyE73s1r3uR0iYWKOSG9LthefcT6LfqVO65/ut+shD/RLQ/HY0zJ1Ei0tpSsyGwHQwJ8g6s+VhtrHkygmHa5JRaPIvW6J0PskiuOov/dEZWVt1qWBEduiPzZN/aX7QZW6deRPMVBd6B65nFhrKr4ANk5vsn925U8cxbSFZXlQSq1hFu1E7+V8zsUz6r811gz3FKAGhRpwj6CQmAtu0xIerm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH50eQoxUDTdcqWT2fKNmW+3tPDspEh4Do/nCHwZ/Uk=;
 b=eaMx665yhxdTUr5x/HmhcGQ4aKdzHRvIgbm8mkD7Q0s4t3KqR60Ibv4/NOCy8Mr52ng5iPkUF5RFlvyk2DtTcEajyILNjqUOLjX8qZa009Plb6tuEVzslyhpVMKBcCv6QwWUBbHhvegpBcLEtZDmSFoTZ3AENXdMj9mY/+3duaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by DM6PR03MB5354.namprd03.prod.outlook.com (2603:10b6:5:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 09:21:30 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 09:21:30 +0000
Message-ID: <91c7e958-4f58-7f8c-d413-158d691809dc@synaptics.com>
Date:   Mon, 17 Jul 2023 17:21:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 8/8] videobuf2: handle non-contiguous DMA allocations
Content-Language: en-GB
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210302004624.31294-1-senozhatsky@chromium.org>
 <20210302004624.31294-9-senozhatsky@chromium.org>
 <08fa86bf-b4bf-408a-89f6-a0ebc222b253@synaptics.com>
 <CAAFQd5AW8ue4haSn9=yi7gSA6bw2pUtPFVSLpkZXrRu1HFZwsA@mail.gmail.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5AW8ue4haSn9=yi7gSA6bw2pUtPFVSLpkZXrRu1HFZwsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|DM6PR03MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3185eaae-6aaa-4d0e-779c-08db86a73449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jg6QbDbHA84xAkDWATBqFYz2wCQ/ejw1fwikryDBJvWyh5q8dcNsHlkGIVq2MnW5VqOaS10qtf5Eas1hYxjUOs8PWo5Vlgte0nktM7RmNsHKDLYkCup3zgQqBqqkQ1QONHfygDO8BEOssFnKogKPdE2CcZ3u/taigwyL7lz+3ms4g8FxWzRlRxJMvhXqVD3vMhObNaVRbezHgT6m1oJ+kEwjwNtVIEWBvMbjIcqSSxBxy0f/gUnomYVHeJzYK9C36+W8ogCP9pBd998pNYVqYx8ogcaalwBQTTUDZk4cllbcLU2AtvOzRAUTXce3WYwSFfR8w1Z/LljNfQcCpU3Zq9HPGBpk1G/ppPhka8BLDmvPRYavBvEizIB7Z1+sgeO0NK3OzfmdFlrdab3ruc5dX3nJCEjqhkV5zfOTVeOjllJlgktjoBHREvZWdFoWxM7EtzpqZ5ZeljoHxnnVgULFCj8NWQgTR+gax+HdIpplpuyfxm2gM2FuVhxLC8xSiptkblSJg0Gy/bTvNiPTeIHyBfDYqXN7sIIj8eOjAXWbL8i78VcxTHM+XZSeYNK6qTkxRsB/nPorKKrS09N7GucymuSqC/6FYGV3ICxsi8dzAXPtUHNAcQ9ZgKLc9JY3NGC4+JrBgg1RIsvPQlQNRcZXyB1RJM0q2ogFQw0Efru/nT2PJvXf89W5TDH3AffCR19O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(376002)(396003)(136003)(346002)(366004)(451199021)(54906003)(6666004)(38350700002)(52116002)(6486002)(478600001)(41300700001)(5660300002)(38100700002)(8676002)(8936002)(66946007)(66476007)(6916009)(316002)(4326008)(2616005)(66556008)(186003)(83380400001)(6512007)(26005)(53546011)(6506007)(86362001)(31696002)(36756003)(30864003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGpGcnNhNEhqK0JqaDBmOXBGcEhFMk44d1ZDSDE0OVJseGx0c29aanExWUdC?=
 =?utf-8?B?ZXh1Q2VIR2F0M3JxSVh2UUdJbGU5MTY2b2E1dkhmQzlHUzhDdWttTS9pTXRK?=
 =?utf-8?B?Yy9HRWlMbERrMXAwd0NscjVQOXdBeWw2Z2xTZFNhQlk2dEJjRmgxZmdQZjVh?=
 =?utf-8?B?bFRpUmx1TXIvcGQ3OW1aeVFuT2lLdTZnU2RnY3hzcFpwd0ZVQjAycW1nSEdX?=
 =?utf-8?B?eHZvVEo5NWxpUmZ1UXcvN1BNR0RVdVNKYStkTGpyTGpJVGcvemJXZG5oUlha?=
 =?utf-8?B?dDYzK3VITW9xQmpraTBqdWxUMmRQRkFSU1ExUzlvc0M2bjc1bjAxdklZOXcx?=
 =?utf-8?B?WmU5dVR0WkVkWUNzUXY1VC9iU2RYZWVwWWt2cE5TSDgxcURheWlNRllvUTUy?=
 =?utf-8?B?NlFZd2RqVTdTVCtFZlM4TnlQVmNUbnZXRy9PcmlVanJxblVrWkNLdk5PQ3NB?=
 =?utf-8?B?N2FJenVBMnQ0N1NQUjRJWTdCL3dzMVNQdjRheTFtc1FTMFA4ZUdnODBXRVFI?=
 =?utf-8?B?Z0VINXhRZytINkQ1cE4vdnQwMkUxTTVqTFFyODZ6TnVPdlZZTVpkL2p2OUJY?=
 =?utf-8?B?QldHYjU1bmdBamkvYUVRVEpKOEg4bXVPR1ZmbXBkWThvYmlrZ0xMemlaK3Bo?=
 =?utf-8?B?bVh3WVFRSTgwWnE1TW9UV1ZRV0VEVUgrdnZVVXNiWU14SXVqZ1VOYk45VURI?=
 =?utf-8?B?MDBPWmt5OGpDOUZXSDQyOTZpeW00SVYzR1NvbU1SVlVPRmNiM1dsMVZ2c0V0?=
 =?utf-8?B?VGI0Z0JaSFp0c2tHVTdTODdwQU4yVGFySjlWd0grNGtSZXROcVpOWmljN0NR?=
 =?utf-8?B?QmZaREVHMWRKN2tCSFd5NkZMSnBUdUpCMkc4ZTkrQTZVclp0bzUrRHpWZjk0?=
 =?utf-8?B?aXFXTFJsdG5EYVhEVWxEcnNDVENBeU9ZOFdNRHRqcFlsWlVLUG5hbW5jQnlL?=
 =?utf-8?B?Nnh5MDY5dUdmSDJHREg3YWwrazVqb3M1WlQwZ3ZMNTFtTDREWm5XbDVINk1x?=
 =?utf-8?B?L2hqMGZ6SFBaTEVNWUpFSFFkUzFJbm43MFQwVVc4WlB1MFQ4a0RmQzhaRzhE?=
 =?utf-8?B?aDlNQXRob09vcHkwVWZGaDR6dlAzKy9adTB1aCs0N0ZwNElQN1lYVkVTNU0w?=
 =?utf-8?B?Sjlpd2ZnRjZFT3pvTm04MnNrTmI2ZklFdU5zamlBeFhrQkpsaFVmNVlaYkZR?=
 =?utf-8?B?OVN2Y21TVEJXbGY2dlVLSkFrdzI1VlJRUHZXYmxNZVpwYUJYd2pFSDcrY3c2?=
 =?utf-8?B?amtmUkx2M25CSmcxelM2YktiZWJ6OE9lVHJWSEhUZEFnUVcxbnpESE1pVjJp?=
 =?utf-8?B?S0g1T0lWeXB0K2FEaC9aVUlFblkySW1rblJkdnFiSlJIZGg3SmlBVnpTUjlH?=
 =?utf-8?B?WHVRMHFYZXhhRjFoWmVWc0huYjhlblNLMjRNczRpdkxaQmhQRTRmOWNLVjYr?=
 =?utf-8?B?M2Z5RE1nazMyRFo0dnRwMGFDM0hwSWhEemh0dEJqZ2JraW4yTFFnUUZjcklF?=
 =?utf-8?B?SndiUWRiU2YwcllGV3VhN3VMYjk4cDdpMjhzY0dhNE41RFdqMHRwV0o2TFJx?=
 =?utf-8?B?ZUdwam1hV1k1U3AzYWZqb2Q4ejJjL2t6aGVhYlFrNERsYTVVbkJmZ3RwOFFF?=
 =?utf-8?B?N0IwQlA3dTRHMS9FaVQ2c2FSWEJocWJySm1ucG5VWGQ0ZFcwSEU1czVuRTFB?=
 =?utf-8?B?ck10a2M3eWg0OFhFU09NYm5ydlBkbjdlb2QvNFNxOFFaVlNrQkZPSmE5MjhQ?=
 =?utf-8?B?UkJrbC9oRTdZaVVDS3Z6dW92YTYzQzZ0NGo5eUgzQzV3MUtON0JYOUpGUVpr?=
 =?utf-8?B?M1dDRG53eFFYMWMwV1BkK0tJdEtmeG9raTQ1N3BDWVQ1NFpsdUNreHd5TmZ4?=
 =?utf-8?B?TU9EOWdVSW9ybzZ0aCtxTDFZd2NBM2IrVHJUd0hpREUvb2tpQmpUSDdWcGZ1?=
 =?utf-8?B?VVgwZi9WTndhcnV0eHpYdGtrWCtoMnJ1aVAwUVJBYzA4WVQyVjJFdEU5aTRt?=
 =?utf-8?B?d0NGN2N3VzlNSy9IYlRqYTVueTFoV1dSUEcrMTJCNGNOaExwQjNDK3oybVJ4?=
 =?utf-8?B?VXdTNXVYeXpYdDAyd2RMSmgreGxrUVV2MUwzcmJWekx1SjZ3d0lMZ2xBNFRT?=
 =?utf-8?Q?s+vkA0CHu/qIvZTtJIxeuX29R?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3185eaae-6aaa-4d0e-779c-08db86a73449
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:21:30.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYMSWbi4cNIeRn/uOFUY35JBWPi9407KclTc7XECVwTaGNQly7iwDIfzUihigMwTxnmQgxGoFIF2Kv+va64YMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5354
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/5/23 18:45, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Tue, Jul 4, 2023 at 7:51 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>> Hello Sergey
>>
>> I known this patch have been merged for a long time. I am thinking
>> whether we need this flag in the new v4l2_ext_buffer.
>>
>> On 3/2/21 08:46, Sergey Senozhatsky wrote:
>>> This adds support for new noncontiguous DMA API, which
>>> requires allocators to have two execution branches: one
>>> for the current API, and one for the new one.
>> There is no way we could allocate a coherent buffer in the platform
>> except the x86.
>>
> The flag is for requesting the kernel to try allocating *non*-coherent
> buffers if possible. If the flag is not given, it's up to the kernel
> to choose the right mapping type, which for vb2-dma-contig is
> coherent. For compatibility reasons, we need the user space to pass
> the flag to change the allocation behavior to avoid UAPI breakages.
>
> I don't get what you mean that there is no way to allocate a coherent
> buffer on a platform other than x86.

I wonder the case for the x86 platform, does that means we don't need to 
do dma_sync_*() neither DMA_TO_DEVICE  nor DMA_FROM_DEVICE.

When a remote device likes a PCIe peer write to the system memory, the 
CPU's memory controller could be aware of that and invalidate the CPU's 
cache?

>   Most of the platforms implement
> dma_alloc_coherent() by remapping the allocated memory in
> uncached/write-combine mode. x86 is an exception because it usually
> has the DMAs coherent with the CPU caches and no special handling is
> necessary, so dma_alloc_coherent() is just a simple pass-through
> allocator.
>
>> Should we make this flag a platform compiling time fixed value?
> This is not a platform-specific flag. There are use cases which
> perform better with coherent buffers (i.e. when there is no CPU access
> happening to the buffers or just a linear memcpy)

I wonder how to implement the coherent memory in the platform likes 
ARMv7 or later. Disable the CPU cache for those pages?

> and some perform
> better when the mapping is non-coherent (i.e. non-linear access from
> the CPU, e.g. a software video encoder).

One problem from migration from ION to DMA-heap is that we don't have a 
flag for allocating non CPU cache buffer(coherent),

I was thinking, marking all the buffer in ARM to be non coherent, it 
sounds a bad idea now.

Maybe I should send a patch to userspace utils, which let them allocate 
the non coherent buffer first if no mmap() would be invoked.

>
>> And I didn't see Gstreamer nor FFmpeg uses it, it is obvious that they
>> are running in many(almost all) embedded devices which are ARM.
>>
> It's likely that those generic frameworks don't have any specific
> advanced use cases which would benefit from the performance gains of
> this flag. FWIW, ChromeOS uses it in the camera and video stack
> whenever complex CPU access to the buffers is needed.
>
> Best regards,
> Tomasz
>
>>> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
>>> [hch: untested conversion to the ne API]
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>    .../common/videobuf2/videobuf2-dma-contig.c   | 141 +++++++++++++++---
>>>    1 file changed, 117 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
>>> index 1e218bc440c6..d6a9f7b682f3 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
>>> @@ -17,6 +17,7 @@
>>>    #include <linux/sched.h>
>>>    #include <linux/slab.h>
>>>    #include <linux/dma-mapping.h>
>>> +#include <linux/highmem.h>
>>>
>>>    #include <media/videobuf2-v4l2.h>
>>>    #include <media/videobuf2-dma-contig.h>
>>> @@ -42,8 +43,14 @@ struct vb2_dc_buf {
>>>        struct dma_buf_attachment       *db_attach;
>>>
>>>        struct vb2_buffer               *vb;
>>> +     unsigned int                    non_coherent_mem:1;
>>>    };
>>>
>>> +static bool vb2_dc_is_coherent(struct vb2_dc_buf *buf)
>>> +{
>>> +     return !buf->non_coherent_mem;
>>> +}
>>> +
>>>    /*********************************************/
>>>    /*        scatterlist table functions        */
>>>    /*********************************************/
>>> @@ -78,12 +85,21 @@ static void *vb2_dc_cookie(struct vb2_buffer *vb, void *buf_priv)
>>>    static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
>>>    {
>>>        struct vb2_dc_buf *buf = buf_priv;
>>> -     struct dma_buf_map map;
>>> -     int ret;
>>>
>>> -     if (!buf->vaddr && buf->db_attach) {
>>> -             ret = dma_buf_vmap(buf->db_attach->dmabuf, &map);
>>> -             buf->vaddr = ret ? NULL : map.vaddr;
>>> +     if (buf->vaddr)
>>> +             return buf->vaddr;
>>> +
>>> +     if (buf->db_attach) {
>>> +             struct dma_buf_map map;
>>> +
>>> +             if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
>>> +                     buf->vaddr = map.vaddr;
>>> +     }
>>> +
>>> +     if (!vb2_dc_is_coherent(buf)) {
>>> +             buf->vaddr = dma_vmap_noncontiguous(buf->dev,
>>> +                                                 buf->size,
>>> +                                                 buf->dma_sgt);
>>>        }
>>>
>>>        return buf->vaddr;
>>> @@ -101,13 +117,26 @@ static void vb2_dc_prepare(void *buf_priv)
>>>        struct vb2_dc_buf *buf = buf_priv;
>>>        struct sg_table *sgt = buf->dma_sgt;
>>>
>>> +     /* This takes care of DMABUF and user-enforced cache sync hint */
>>>        if (buf->vb->skip_cache_sync_on_prepare)
>>>                return;
>>>
>>> +     /*
>>> +      * Coherent MMAP buffers do not need to be synced, unlike coherent
>>> +      * USERPTR and non-coherent MMAP buffers.
>>> +      */
>>> +     if (buf->vb->memory == V4L2_MEMORY_MMAP && vb2_dc_is_coherent(buf))
>>> +             return;
>>> +
>>>        if (!sgt)
>>>                return;
>>>
>>> +     /* For both USERPTR and non-coherent MMAP */
>>>        dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
>>> +
>>> +     /* Non-coherrent MMAP only */
>>> +     if (!vb2_dc_is_coherent(buf) && buf->vaddr)
>>> +             flush_kernel_vmap_range(buf->vaddr, buf->size);
>>>    }
>>>
>>>    static void vb2_dc_finish(void *buf_priv)
>>> @@ -115,19 +144,46 @@ static void vb2_dc_finish(void *buf_priv)
>>>        struct vb2_dc_buf *buf = buf_priv;
>>>        struct sg_table *sgt = buf->dma_sgt;
>>>
>>> +     /* This takes care of DMABUF and user-enforced cache sync hint */
>>>        if (buf->vb->skip_cache_sync_on_finish)
>>>                return;
>>>
>>> +     /*
>>> +      * Coherent MMAP buffers do not need to be synced, unlike coherent
>>> +      * USERPTR and non-coherent MMAP buffers.
>>> +      */
>>> +     if (buf->vb->memory == V4L2_MEMORY_MMAP && vb2_dc_is_coherent(buf))
>>> +             return;
>>> +
>>>        if (!sgt)
>>>                return;
>>>
>>> +     /* For both USERPTR and non-coherent MMAP */
>>>        dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
>>> +
>>> +     /* Non-coherrent MMAP only */
>>> +     if (!vb2_dc_is_coherent(buf) && buf->vaddr)
>>> +             invalidate_kernel_vmap_range(buf->vaddr, buf->size);
>>>    }
>>>
>>>    /*********************************************/
>>>    /*        callbacks for MMAP buffers         */
>>>    /*********************************************/
>>>
>>> +static void __vb2_dc_put(struct vb2_dc_buf *buf)
>>> +{
>>> +     if (vb2_dc_is_coherent(buf)) {
>>> +             dma_free_attrs(buf->dev, buf->size, buf->cookie,
>>> +                            buf->dma_addr, buf->attrs);
>>> +             return;
>>> +     }
>>> +
>>> +     if (buf->vaddr)
>>> +             dma_vunmap_noncontiguous(buf->dev, buf->vaddr);
>>> +     dma_free_noncontiguous(buf->dev, buf->size,
>>> +                            buf->dma_sgt, buf->dma_addr);
>>> +}
>>> +
>>>    static void vb2_dc_put(void *buf_priv)
>>>    {
>>>        struct vb2_dc_buf *buf = buf_priv;
>>> @@ -139,17 +195,47 @@ static void vb2_dc_put(void *buf_priv)
>>>                sg_free_table(buf->sgt_base);
>>>                kfree(buf->sgt_base);
>>>        }
>>> -     dma_free_attrs(buf->dev, buf->size, buf->cookie, buf->dma_addr,
>>> -                    buf->attrs);
>>> +     __vb2_dc_put(buf);
>>>        put_device(buf->dev);
>>>        kfree(buf);
>>>    }
>>>
>>> +static int vb2_dc_alloc_coherent(struct vb2_dc_buf *buf)
>>> +{
>>> +     struct vb2_queue *q = buf->vb->vb2_queue;
>>> +
>>> +     buf->cookie = dma_alloc_attrs(buf->dev,
>>> +                                   buf->size,
>>> +                                   &buf->dma_addr,
>>> +                                   GFP_KERNEL | q->gfp_flags,
>>> +                                   buf->attrs);
>>> +     if (!buf->cookie)
>>> +             return -ENOMEM;
>>> +     if ((q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
>>> +             buf->vaddr = buf->cookie;
>>> +     return 0;
>>> +}
>>> +
>>> +static int vb2_dc_alloc_non_coherent(struct vb2_dc_buf *buf)
>>> +{
>>> +     struct vb2_queue *q = buf->vb->vb2_queue;
>>> +
>>> +     buf->dma_sgt = dma_alloc_noncontiguous(buf->dev,
>>> +                                            buf->size,
>>> +                                            buf->dma_dir,
>>> +                                            GFP_KERNEL | q->gfp_flags,
>>> +                                            buf->attrs);
>>> +     if (!buf->dma_sgt)
>>> +             return -ENOMEM;
>>> +     return 0;
>>> +}
>>> +
>>>    static void *vb2_dc_alloc(struct vb2_buffer *vb,
>>>                          struct device *dev,
>>>                          unsigned long size)
>>>    {
>>>        struct vb2_dc_buf *buf;
>>> +     int ret;
>>>
>>>        if (WARN_ON(!dev))
>>>                return ERR_PTR(-EINVAL);
>>> @@ -159,27 +245,28 @@ static void *vb2_dc_alloc(struct vb2_buffer *vb,
>>>                return ERR_PTR(-ENOMEM);
>>>
>>>        buf->attrs = vb->vb2_queue->dma_attrs;
>>> -     buf->cookie = dma_alloc_attrs(dev, size, &buf->dma_addr,
>>> -                                   GFP_KERNEL | vb->vb2_queue->gfp_flags,
>>> -                                   buf->attrs);
>>> -     if (!buf->cookie) {
>>> -             dev_err(dev, "dma_alloc_coherent of size %ld failed\n", size);
>>> -             kfree(buf);
>>> -             return ERR_PTR(-ENOMEM);
>>> -     }
>>> -
>>> -     if ((buf->attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
>>> -             buf->vaddr = buf->cookie;
>>> +     buf->dma_dir = vb->vb2_queue->dma_dir;
>>> +     buf->vb = vb;
>>> +     buf->non_coherent_mem = vb->vb2_queue->non_coherent_mem;
>>>
>>> +     buf->size = size;
>>>        /* Prevent the device from being released while the buffer is used */
>>>        buf->dev = get_device(dev);
>>> -     buf->size = size;
>>> -     buf->dma_dir = vb->vb2_queue->dma_dir;
>>> +
>>> +     if (vb2_dc_is_coherent(buf))
>>> +             ret = vb2_dc_alloc_coherent(buf);
>>> +     else
>>> +             ret = vb2_dc_alloc_non_coherent(buf);
>>> +
>>> +     if (ret) {
>>> +             dev_err(dev, "dma alloc of size %ld failed\n", size);
>>> +             kfree(buf);
>>> +             return ERR_PTR(-ENOMEM);
>>> +     }
>>>
>>>        buf->handler.refcount = &buf->refcount;
>>>        buf->handler.put = vb2_dc_put;
>>>        buf->handler.arg = buf;
>>> -     buf->vb = vb;
>>>
>>>        refcount_set(&buf->refcount, 1);
>>>
>>> @@ -196,9 +283,12 @@ static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
>>>                return -EINVAL;
>>>        }
>>>
>>> -     ret = dma_mmap_attrs(buf->dev, vma, buf->cookie,
>>> -             buf->dma_addr, buf->size, buf->attrs);
>>> -
>>> +     if (vb2_dc_is_coherent(buf))
>>> +             ret = dma_mmap_attrs(buf->dev, vma, buf->cookie, buf->dma_addr,
>>> +                                  buf->size, buf->attrs);
>>> +     else
>>> +             ret = dma_mmap_noncontiguous(buf->dev, vma, buf->size,
>>> +                                          buf->dma_sgt);
>>>        if (ret) {
>>>                pr_err("Remapping memory failed, error: %d\n", ret);
>>>                return ret;
>>> @@ -390,6 +480,9 @@ static struct sg_table *vb2_dc_get_base_sgt(struct vb2_dc_buf *buf)
>>>        int ret;
>>>        struct sg_table *sgt;
>>>
>>> +     if (!vb2_dc_is_coherent(buf))
>>> +             return buf->dma_sgt;
>>> +
>>>        sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
>>>        if (!sgt) {
>>>                dev_err(buf->dev, "failed to alloc sg table\n");
>> --
>> Hsia-Jun(Randy) Li
>>
-- 
Hsia-Jun(Randy) Li

