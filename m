Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C4B754A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 19:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjGORfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGORfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 13:35:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D365172C;
        Sat, 15 Jul 2023 10:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0EE960BD6;
        Sat, 15 Jul 2023 17:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8E0C433C8;
        Sat, 15 Jul 2023 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689442522;
        bh=oawNHOu6cEn/o8yHbi2Ylqw7LxrIWJEIsGhh23eVmII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YT4fzAdMOWprMWZIVOz97OS+Wa7N2wEak7qCKwnAzLRT/3EtP09nnCT9cTcMOs56B
         9I/7FGLw7lEwwql7W3FrP2un/jI3t5dO/tnWry0oONO9EoLvVuux95g4YXcAlGLkpy
         /8TvsR4x74NmA+OEkFHDyLaA1lNqKgs0jaASXNJo3ZcyF2qzpP+1cncFWx4o7SJ59x
         5iGKC+SADuegKU9s9VvfPZXMHxO7dKqvvtkIKy7od6aZn3dm7+mKC4+shryCNDStms
         iRpFkWShtmiiYKHfokJn3jOBko7m9V/lwG/CX71tf3gulZGeiSD3U02ToY0lhDtDLA
         6Vk62nR/eM5Dw==
Date:   Sat, 15 Jul 2023 18:35:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: lsm6dsx: Fix mount matrix retrieval
Message-ID: <20230715183515.56deaa1d@jic23-huawei>
In-Reply-To: <20230714153132.27265-1-atafalla@dnyon.com>
References: <20230714153132.27265-1-atafalla@dnyon.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 17:31:26 +0200
Alejandro Tafalla <atafalla@dnyon.com> wrote:

> The function lsm6dsx_get_acpi_mount_matrix should return an error when ACPI
> support is not enabled to allow executing iio_read_mount_matrix in the
> probe function.
> 
> Fixes: dc3d25f22b88 ("iio: imu: lsm6dsx: Add ACPI mount matrix retrieval")
> 

I can fix it up whilst applying if no other issues, but there must not be
a blank line here.  All tags need to be in a single block for some tooling
that is used with the kernel tree (and some of the checking scripts warn
about this so it won't get applied with the blank line here).

> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
> Changes in v3:
> - Removed unneeded check for err == -EOPNOTSUPP.
> 
> Changes in v2:
> - Use of error codes instead of true/false
> 
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 6a18b363cf73..b6e6b1df8a61 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
>  static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
>  					  struct iio_mount_matrix *orientation)
>  {
> -	return false;
> +	return -EOPNOTSUPP;
>  }
>  
>  #endif

