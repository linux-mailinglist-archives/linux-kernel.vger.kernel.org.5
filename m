Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847667F8DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 20:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjKYTWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 14:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYTWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 14:22:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A4115
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 11:22:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184D8C433C7;
        Sat, 25 Nov 2023 19:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700940174;
        bh=SKH8DpdKj2rUFQzT6NaFG0MvPM8ey9Lp6jvp8mfmNt8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kAcXS0gijUWwsyAkYhFTYk3IyT3L30FzvVwLVAbdpkVWSfrAShs+MswkQGhTzLhow
         8/zPfrEEHCg89D2Io9VzMmALp10Z171dDm5Ir82pf6HrTHvQf0g0rb6Vm3LU4Dj0Y9
         b60EObeKDi9mSm1ZY5TSGmG38DN6nNWkOaEgqPC04tDmH4jZjq3sVAcjvNnXDa9xi2
         e6iazidswkRR/vSEAJC671fGBCKVZCdJ6dkJJ59K9TPG2WJ5PCAizOpZAeCV/JFgSq
         84VPKMJinzR8uIrW+yM4xYY4pIxndda/51K7Ac3TfyLd3Ggrybqsz9E3jNchgKgCIN
         b+Ms/ibjNhXsg==
Date:   Sat, 25 Nov 2023 19:22:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <marius.cristea@microchip.com>
Cc:     <lars@metafoo.de>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: MCP3564: fix hardware identification logic
Message-ID: <20231125192249.2ed29b08@jic23-huawei>
In-Reply-To: <20231122111106.45288-1-marius.cristea@microchip.com>
References: <20231122111106.45288-1-marius.cristea@microchip.com>
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

On Wed, 22 Nov 2023 13:11:06 +0200
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> In mcp3564_config() fix the hardware identification logic
> based on the hardware ID registers. Second part of the code was
> disabled by an logic error.
> Fix a typo related to the "MODULE_DESCRIPTION".
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
Fixes tag?

> ---
>  drivers/iio/adc/mcp3564.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index e3f1de5fcc5a..e914a885a868 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -1122,7 +1122,7 @@ static int mcp3564_config(struct iio_dev *indio_dev)
>  	enum mcp3564_ids ids;
>  	int ret = 0;
>  	unsigned int tmp = 0x01;
> -	bool err = true;
> +	bool err = false;
>  
>  	/*
>  	 * The address is set on a per-device basis by fuses in the factory,
> @@ -1509,5 +1509,5 @@ static struct spi_driver mcp3564_driver = {
>  module_spi_driver(mcp3564_driver);
>  
>  MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
> -MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP346xR ADCs");
> +MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP356xR ADCs");
>  MODULE_LICENSE("GPL v2");
> 
> base-commit: 6543f376ec8aa90a6c1ed44b765f4f0d6c3eb1db

