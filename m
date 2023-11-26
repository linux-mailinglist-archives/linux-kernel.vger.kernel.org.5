Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE67F94C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjKZSGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 13:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 13:06:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE57C8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 10:06:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D10C433C8;
        Sun, 26 Nov 2023 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701022005;
        bh=p6pNrvNvpBYQrf6KyXpLpX8bFfn2jNLT6e4Wi7PEf04=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KChUsiRXHl3vEPXtjrHXhvJwnz3eCN19O6H9V8Kw5H/LTNuOJZTpB8vbot6SfSXyf
         L254+AfwdIYObskHu0ji4rHe+gYnSyZfbn0nprzJYdOBAK/aFR9mEntxwyXquhNiS5
         sWyoPNjFx5xsZ5k9iI8NRO+0vZOrjATlb5Snqj7O/hbTMgmGgljLLQ03BMBRh6YPkp
         SQTi8dm2oLtKqaDQpXqfD8ABjVj+gUCTPOMuUOE/AH3Xv/wPXdZT+1+bxeWuSNd0CE
         7XBFb44H6ieAWdwUp8miQMME67c9Wy8ogOKtdFcAX0uJ9InLlQPS7nLsZV0VjzKbZw
         ajftHtjpRyysw==
Date:   Sun, 26 Nov 2023 18:06:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, oe-kbuild-all@lists.linux.dev,
        lkp@intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi323: Make the local structures static
Message-ID: <20231126180637.1a832574@jic23-huawei>
In-Reply-To: <20231108035831.5889-1-jagathjog1996@gmail.com>
References: <20231108035831.5889-1-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 09:28:31 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Make the local structures static within their respective driver files.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311070530.qKhLTz1Y-lkp@intel.com/
> Fixes: b512c767e7bc ("iio: imu: Add driver for BMI323 IMU")
Applied to the togreg branch of iio.git but I dropped this fixes tag because
it's already wrong due to a rebase and that may well happen again.

Probably better to just not have one in this case :(

Jonathan

> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/imu/bmi323/bmi323_i2c.c | 2 +-
>  drivers/iio/imu/bmi323/bmi323_spi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> index 0008e186367d..20a8001b9956 100644
> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -66,7 +66,7 @@ static struct regmap_bus bmi323_regmap_bus = {
>  	.write = bmi323_regmap_i2c_write,
>  };
>  
> -const struct regmap_config bmi323_i2c_regmap_config = {
> +static const struct regmap_config bmi323_i2c_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 16,
>  	.max_register = BMI323_CFG_RES_REG,
> diff --git a/drivers/iio/imu/bmi323/bmi323_spi.c b/drivers/iio/imu/bmi323/bmi323_spi.c
> index 6dc3352dd714..7b1e8127d0dd 100644
> --- a/drivers/iio/imu/bmi323/bmi323_spi.c
> +++ b/drivers/iio/imu/bmi323/bmi323_spi.c
> @@ -41,7 +41,7 @@ static struct regmap_bus bmi323_regmap_bus = {
>  	.write = bmi323_regmap_spi_write,
>  };
>  
> -const struct regmap_config bmi323_spi_regmap_config = {
> +static const struct regmap_config bmi323_spi_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 16,
>  	.pad_bits = 8,

