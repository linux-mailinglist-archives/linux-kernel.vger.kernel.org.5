Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0BE7B6404
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjJCIZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjJCIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:25:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1054A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:25:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCB8C433C9;
        Tue,  3 Oct 2023 08:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696321552;
        bh=KXtojPedPQ+gz2QcHLNOECeONC8uwhpiha9CkLTHH94=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gVmp0y6zM/OpiA+ivIdveacXcOe7zYH+/DlLedhxXryQIZ7BnDsKAOnDhX0O75ZA5
         MfDH0hmrqjBtKXxwwnbL2mnonUZz6L+i6+t7Ce7YIDc6a/KfvAV1BYoz+DJ1eG8mkf
         TXPQ9oqzBTzHDVgcZeFGkTRriOKqzcj1q+RvvIKcJjuTb+eh9Sr5aB3juC7UlLcNE2
         ATVBdO7C0YLA2vX8v+2gqHi+4aFr44+VnlhwLDat6+2x8aHtJgFBfOv5F2Zi6+qAYT
         OKnG0FE9nskYsQeDelp5tD+EhTTt2Y79hFqWTLHZWon4MECinn2ttVaWa8L4ai9a5e
         jt0rvQDb95R/A==
Message-ID: <4fe44a5f-9a6f-5259-f14a-d464a7cb8556@kernel.org>
Date:   Tue, 3 Oct 2023 17:25:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] mfd: max77686: Convert to use maple tree register
 cache
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <20231001-mfd-maxim-maple-v1-0-cdfeb48a4d15@kernel.org>
 <20231001-mfd-maxim-maple-v1-2-cdfeb48a4d15@kernel.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20231001-mfd-maxim-maple-v1-2-cdfeb48a4d15@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23. 10. 1. 08:47, Mark Brown wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/mfd/max77686.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
> index 91c286c4571c..0118a444a68b 100644
> --- a/drivers/mfd/max77686.c
> +++ b/drivers/mfd/max77686.c
> @@ -108,7 +108,7 @@ static const struct regmap_config max77802_regmap_config = {
>  	.precious_reg = max77802_is_precious_reg,
>  	.volatile_reg = max77802_is_volatile_reg,
>  	.name = "max77802-pmic",
> -	.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_MAPLE,
>  };
>  
>  static const struct regmap_irq max77686_irqs[] = {
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

