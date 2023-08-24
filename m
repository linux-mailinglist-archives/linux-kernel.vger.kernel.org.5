Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CDD78655D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbjHXCaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbjHXC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:29:45 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E38E6D;
        Wed, 23 Aug 2023 19:29:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VqS.qLi_1692844178;
Received: from 30.97.48.68(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VqS.qLi_1692844178)
          by smtp.aliyun-inc.com;
          Thu, 24 Aug 2023 10:29:39 +0800
Message-ID: <f663c2cc-4a4d-7f89-748e-559cd21ff0a4@linux.alibaba.com>
Date:   Thu, 24 Aug 2023 10:29:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] clk: sprd: Fix thm_parents incorrect configuration
To:     Zhifeng Tang <zhifeng.tang@unisoc.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Cixi Geng <cixi.geng1@unisoc.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhifeng Tang <zhifeng.tang23@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
References: <20230805064820.30305-1-zhifeng.tang@unisoc.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230805064820.30305-1-zhifeng.tang@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/2023 2:48 PM, Zhifeng Tang wrote:
> The thm*_clk have two clock sources 32k and 250k,excluding 32m.
> 
> Signed-off-by: Zhifeng Tang <zhifeng.tang@unisoc.com>

Please add a Fixes tag. With that, you can add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/clk/sprd/ums512-clk.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sprd/ums512-clk.c b/drivers/clk/sprd/ums512-clk.c
> index fc25bdd85e4e..f43bb10bd5ae 100644
> --- a/drivers/clk/sprd/ums512-clk.c
> +++ b/drivers/clk/sprd/ums512-clk.c
> @@ -800,7 +800,7 @@ static SPRD_MUX_CLK_DATA(uart1_clk, "uart1-clk", uart_parents,
>   			 0x250, 0, 3, UMS512_MUX_FLAG);
>   
>   static const struct clk_parent_data thm_parents[] = {
> -	{ .fw_name = "ext-32m" },
> +	{ .fw_name = "ext-32k" },
>   	{ .hw = &clk_250k.hw  },
>   };
>   static SPRD_MUX_CLK_DATA(thm0_clk, "thm0-clk", thm_parents,
