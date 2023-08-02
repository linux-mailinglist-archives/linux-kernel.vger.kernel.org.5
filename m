Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627B476C33B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHBC7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjHBC7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:59:37 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7826B7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:59:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vot7iDF_1690945172;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vot7iDF_1690945172)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:59:33 +0800
Message-ID: <60c83ca0-de10-1c69-b03f-e3b73c2d01dc@linux.alibaba.com>
Date:   Wed, 2 Aug 2023 11:00:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] mm/compaction: remove unnecessary "else continue" at
 end of loop in isolate_freepages_block
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230729174354.2239980-1-shikemeng@huaweicloud.com>
 <20230729174354.2239980-6-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230729174354.2239980-6-shikemeng@huaweicloud.com>
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



On 7/30/2023 1:43 AM, Kemeng Shi wrote:
> There is no behavior change to remove "else continue" code at end of scan loop.
> Just remove it to make code cleaner.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index cfb661f4ce23..d38297018077 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -670,9 +670,6 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>   isolate_fail:
>   		if (strict)
>   			break;
> -		else
> -			continue;
> -
>   	}
>   
>   	compact_unlock_irqrestore(&locked, flags);
