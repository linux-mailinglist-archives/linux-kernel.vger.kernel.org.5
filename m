Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29988768A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjGaDNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjGaDM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:12:59 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A11E75
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 20:12:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VoXPAnl_1690773174;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VoXPAnl_1690773174)
          by smtp.aliyun-inc.com;
          Mon, 31 Jul 2023 11:12:54 +0800
Message-ID: <1b30056e-0208-841e-9174-4a977dbba309@linux.alibaba.com>
Date:   Mon, 31 Jul 2023 11:13:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] mm/compaction: correct comment of candidate pfn in
 fast_isolate_freepages
To:     Kemeng Shi <shikemeng@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230721150957.2058634-1-shikemeng@huawei.com>
 <20230721150957.2058634-2-shikemeng@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230721150957.2058634-2-shikemeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/2023 11:09 PM, Kemeng Shi wrote:
> If no preferred one was not found, we will use candidate page with maximum
> pfn > min_pfn which is saved in high_pfn. Correct "minimum" to "maximum
> candidate" in comment.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Yes, the 'minimum' can be confused. At least to me, it looks good.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index eb1d3d9a422c..c0d8d08fc163 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1526,7 +1526,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
>   				break;
>   		}
>   
> -		/* Use a minimum pfn if a preferred one was not found */
> +		/* Use a maximum candidate pfn if a preferred one was not found */
>   		if (!page && high_pfn) {
>   			page = pfn_to_page(high_pfn);
>   
