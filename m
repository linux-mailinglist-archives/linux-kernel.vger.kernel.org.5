Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD7D75C00F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGUHob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGUHo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:44:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2127A2D6D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:44:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4R6hQT0VkLz4f3jJH
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:44:17 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
        by APP2 (Coremail) with SMTP id Syh0CgBnDetMN7pktBOOOQ--.2147S2;
        Fri, 21 Jul 2023 15:44:14 +0800 (CST)
Subject: Re: [PATCH 1/2] mm/compaction: correct comment of candidate pfn in
 fast_isolate_freepages
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20230720115351.2039431-1-shikemeng@huaweicloud.com>
 <20230720115351.2039431-2-shikemeng@huaweicloud.com>
From:   Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c9c8aa27-d1e0-3123-6767-31e94be89b91@huaweicloud.com>
Date:   Fri, 21 Jul 2023 15:44:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20230720115351.2039431-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Syh0CgBnDetMN7pktBOOOQ--.2147S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw4rur1kZr18Ar15Gw4kJFb_yoW8JF4kpF
        4DAa1UXwnrJa48Ca47Aa17ua47Xws3tF18Grs3G3yrAanag3s7u3s2qF45ur92vr9Yk3y2
        vrZ2gF1Ut3yUZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin, I try to resend a new v2 patchset, the patch 1 is still
missing. Here is the patch 1 in old version and I find it in lore
archive of lore.kernel.org with link [1].
It's likely that patch 1 is denied by linux-mm.kvack.org but accepted
by linux-kernel@vger.kernel.org. Is anyone know how to submit issue of
linux-mm.kvack.org, please let know. Thanks!

[1] https://lore.kernel.org/all/20230720115351.2039431-2-shikemeng@huaweicloud.com/

on 7/20/2023 7:53 PM, Kemeng Shi wrote:
> If no preferred one was not found, we will use candidate page with maximum
> pfn > min_pfn which is saved in high_pfn. Correct "minimum" to "maximum
> candidate" in comment.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/compaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index eb1d3d9a422c..c0d8d08fc163 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1526,7 +1526,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
>  				break;
>  		}
>  
> -		/* Use a minimum pfn if a preferred one was not found */
> +		/* Use a maximum candidate pfn if a preferred one was not found */
>  		if (!page && high_pfn) {
>  			page = pfn_to_page(high_pfn);
>  
> 

-- 
Best wishes
Kemeng Shi

