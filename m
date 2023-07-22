Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6675DCED
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGVObm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 10:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVObk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 10:31:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ED11FE1;
        Sat, 22 Jul 2023 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KOFQHKY9FiS+M1ooBdGcu9VMnSbo7Qp9uGzk3JA61Tc=; b=gWjrQ4i5TaiVDqlOAIfX0xtisS
        gwfUvVPBeTvGNyZShxKRbKdVUoL36JonhPRVYnygEXTIXpqMc+wztGcxQyLXRwKln/3LFZbh4tjgZ
        K+gJoM7irVGYDNPIbi4jFH/BnthWOR3J262z10I4hxTM1pHTmJ49Zk2MLVBAKtJXZlnM5yxyWJyt8
        +ATQ7hHaIbDroehG3a2KrB/oXOQGLGoD3xQbS9qlSUgzaABrMoaS3yoQ4PQjXubPx97Ri9/vjlTxR
        vN/1GvkWVkN5cgRbdZfj6GLBjXcOcnDnU2iGUeE0EvRGfDEv96DgvVhO2+rfETPst5Ewcv4AdBYjq
        9ttgRb+A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNDdl-00Gr7H-0i;
        Sat, 22 Jul 2023 14:31:25 +0000
Message-ID: <a60c8c63-509e-682c-16be-1a381b09b1eb@infradead.org>
Date:   Sat, 22 Jul 2023 07:31:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] clk: sunxi-ng: Modify mismatched function name
Content-Language: en-US
To:     Zhang Jianhua <chris.zjh@huawei.com>, mturquette@baylibre.com,
        sboyd@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, ulf.hansson@linaro.org, mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230722153107.2078179-1-chris.zjh@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230722153107.2078179-1-chris.zjh@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/22/23 08:31, Zhang Jianhua wrote:
> No functional modification involved.
> 
> drivers/clk/sunxi-ng/ccu_mmc_timing.c:54: warning: expecting prototype for sunxi_ccu_set_mmc_timing_mode(). Prototype was for sunxi_ccu_get_mmc_timing_mode() instead
> 
> Fixes: f6f64ed868d3 ("clk: sunxi-ng: Add interface to query or configure MMC timing modes.")
> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/clk/sunxi-ng/ccu_mmc_timing.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_mmc_timing.c b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
> index 23a8d44e2449..78919d7843be 100644
> --- a/drivers/clk/sunxi-ng/ccu_mmc_timing.c
> +++ b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
> @@ -43,7 +43,7 @@ int sunxi_ccu_set_mmc_timing_mode(struct clk *clk, bool new_mode)
>  EXPORT_SYMBOL_GPL(sunxi_ccu_set_mmc_timing_mode);
>  
>  /**
> - * sunxi_ccu_set_mmc_timing_mode: Get the current MMC clock timing mode
> + * sunxi_ccu_get_mmc_timing_mode: Get the current MMC clock timing mode
>   * @clk: clock to query
>   *
>   * Return: %0 if the clock is in old timing mode, > %0 if it is in

-- 
~Randy
