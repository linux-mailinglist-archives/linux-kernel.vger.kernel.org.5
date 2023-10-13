Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1D7C8627
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjJMMwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjJMMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:51:59 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5FECBD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:51:53 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8AxZ+hmPSllO7cxAA--.59996S3;
        Fri, 13 Oct 2023 20:51:50 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxjNxjPSllVeUiAA--.7995S3;
        Fri, 13 Oct 2023 20:51:49 +0800 (CST)
Message-ID: <73ddfc81-3f94-4403-8bb2-d537742a7042@loongson.cn>
Date:   Fri, 13 Oct 2023 20:51:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loongarch/mm: disable WUC for pgprot_writecombine as
 same as ioremap_wc
Content-Language: en-US
To:     Xi Ruoyao <xry111@xry111.site>, WANG Xuerui <kernel@xen0n.name>,
        Icenowy Zheng <uwu@icenowy.me>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Weihao Li <liweihao@loongson.cn>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Jun Yi <yijun@loongson.cn>, Baoquan He <bhe@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhihong Dong <donmor3000@hotmail.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231009042841.635366-1-uwu@icenowy.me>
 <4f1af31b-15be-cb47-6b34-45de1b5696be@loongson.cn>
 <42b0e6f6-c2b5-49c6-b1f2-0200bef913da@xen0n.name>
 <3641d3fe-c2e7-868f-ab0d-3951c9a78b6d@loongson.cn>
 <8373ccfd93b0402caf9f5c06a2d9b93b3c0d0b49.camel@xry111.site>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <8373ccfd93b0402caf9f5c06a2d9b93b3c0d0b49.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxjNxjPSllVeUiAA--.7995S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr4rCFykXF1fWrWftFWfCrX_yoWDZrg_uF
        Wv9asrGw4fWFsrtF47tr4Ygr9xKw1qvry0q3y8tasIq345CFZ7WF4v9wnFkr15JF45CrWk
        Wr12qFW8tanF9osvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
        s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
        cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
        vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
        Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
        Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
        CY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
        JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2
        IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07joc_-UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 2023/10/10 20:26, Xi Ruoyao wrote:
>> - For buffers at VRAM(device memory), we replace the WC mappings with uncached mappings.
>> - For buffers reside in RAM, we replace the WC mappings with cached mappings.
>>
>> By this way, we were able to minimum the side effects, and meet the usable requirements
>> for all of the GPU drivers.
> AFAIK there has been some clear NAK from DRM maintainers towards this
> "approach".  So it's not possible to be applied upstream.


Yeah, domain specific reviewers are really hard to persuade to accept our solution.
Probably because they are not know our hardware very well. But the side effects of
this patch is really too hurt to accept. In this case, if you really want to make
a progress by workaround. I think you could try scan the PCI device in the whole
system on boot time. Turn off the WC mappings when there is a AMD or ATI GPUs found.
Leave the the WC mappings open at the rest of cases. But this is yet another ugly
workaround. Perhaps it is a bit of better than this because there is no way left.

  
  

