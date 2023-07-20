Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66875A607
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGTGIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjGTGIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:08:48 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E23D2684
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:08:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VnorP94_1689833318;
Received: from 30.97.48.52(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VnorP94_1689833318)
          by smtp.aliyun-inc.com;
          Thu, 20 Jul 2023 14:08:39 +0800
Message-ID: <2909fe72-5873-7186-88d6-0667cd71f705@linux.alibaba.com>
Date:   Thu, 20 Jul 2023 14:08:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Two minor cleanups for compaction
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230720115351.2039431-1-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230720115351.2039431-1-shikemeng@huaweicloud.com>
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



On 7/20/2023 7:53 PM, Kemeng Shi wrote:
> Hi all, this series contains two random cleanups for compaction.
> Patch 1 correct wrong comment in fast_isolate_freepages.
> Patch 2 avoid to call unneeded pageblock_end_pfn when no_set_skip_hint
> is set.
> Thanks!

I only received the patch 2 in this patch set, and I checked the lore
archives[1], still did not find patch 1. You missed patch 1?

[1] 
https://lore.kernel.org/linux-mm/20230720115351.2039431-1-shikemeng@huaweicloud.com/

> 
> Kemeng Shi (2):
>    mm/compaction: correct comment of candidate pfn in
>      fast_isolate_freepages
>    mm/compaction: avoid unneeded pageblock_end_pfn when no_set_skip_hint
>      is set
> 
>   mm/compaction.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
