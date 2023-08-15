Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B300D77C77C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjHOGJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjHOGIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:08:44 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 323212694;
        Mon, 14 Aug 2023 23:07:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7A8A180E0;
        Tue, 15 Aug 2023 06:07:30 +0000 (UTC)
Date:   Tue, 15 Aug 2023 09:07:29 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: multi_v7_defconfig: Enable TLV320AIC3x
Message-ID: <20230815060729.GR11676@atomide.com>
References: <20230731-arm-tlv320aic31xx-config-v1-1-013c8c321dad@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-arm-tlv320aic31xx-config-v1-1-013c8c321dad@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Mark Brown <broonie@kernel.org> [230731 11:53]:
> A number of TI based platforms use TLV320AIC3x since it was their
> standard audio CODEC for quite some time, including the Beagle X15.
> Enable it multi_v7_defconfig to improve test coverage.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Looks like this is still pending, I don't have any defconfig changes to queue,
so I've added Arnd to Cc:

Reviewed-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index f0800f806b5f..00e95220e08d 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -825,6 +825,7 @@ CONFIG_SND_SOC_SGTL5000=m
>  CONFIG_SND_SOC_STI_SAS=m
>  CONFIG_SND_SOC_TLV320AIC32X4=m
>  CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
> +CONFIG_SND_SOC_TLV320AIC3X_I2C=m
>  CONFIG_SND_SOC_WM8960=m
>  CONFIG_SND_SOC_WM8962=m
>  CONFIG_SND_SOC_WM8978=m
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230707-arm-tlv320aic31xx-config-f52a886647db
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 
