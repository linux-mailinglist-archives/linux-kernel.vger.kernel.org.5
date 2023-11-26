Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DD87F945D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjKZQ7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 11:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZQ7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 11:59:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E69FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 08:59:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA21C433C8;
        Sun, 26 Nov 2023 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701017995;
        bh=94Bci4GQgPMxbZ/erfL1pyC11g82pEl07yqNHLKZj7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BRp9xeG9spO1EL4jWi23045SOTlscPwoHiSfsgw8kiHkOALRDSUZoWxUGXg/igD23
         GSftBXq/CYUtEk7LeIEGAMSezlrv1WvV1Ebgab78Zsfuq2YjWNo569tBQNpSug3Ang
         DAo47hkodHkSgMs9ly7qB/5DWVFZUjCLKQ1CKPc3Tqn/XgT6mUxbmBzrztz3Pjg2Kk
         cOid6/8AZesBEOJrJkoWxrVw9G/0hhzd+UaQXgt/gTcsVkm2VbhFwobvYwzlXTTsoE
         0t2Jp6Tm8pzcb0bTbbw0x77a0nqx5fWmzFH89/gY9zSowEFWu6BelnYFgaNm9KvhHJ
         kw695R336MDSg==
Date:   Sun, 26 Nov 2023 16:59:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [RFC PATCH] iio: accel: st_accel: silent spi_device_id warnings
Message-ID: <20231126165949.7678ebce@jic23-huawei>
In-Reply-To: <20231101151612.4159362-1-sean@geanix.com>
References: <20231101151612.4159362-1-sean@geanix.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Nov 2023 16:16:12 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> Add and correct spi_device_id entries to silent following warnings:
>  SPI driver st-accel-spi has no spi_device_id for st,lis302dl-spi
>  SPI driver st-accel-spi has no spi_device_id for st,lis3lv02dl-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lis3dh-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lsm330d-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lsm330dl-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lsm330dlc-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lis331dlh-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lsm330-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lsm303agr-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lis2dh12-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lng2dm-accel
>  SPI driver st-accel-spi has no spi_device_id for st,h3lis331dl-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lis331dl-accel
>  SPI driver st-accel-spi has no spi_device_id for st,lsm303c-accel
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Is the names with underscore from ACPI or?
Ancient history for the _ and I suspect no particularly strong reason for it.

> Is it fine to do this?
Hmm. I 'think' the only breakage would be to user space scripts that might
rely on poking the device add stuff for i2c which is affected by this even
though the warning is about SPI.  Also to any userspace that was matching
on the iio name which this fills (I think)

If that's a potential problem we will need to keep underscores for that
purpose whilst using - for the ID tables which is messy.

Bit odd that this driver replaces spi->modalias like it does. Should probably
operate on a separate string

It may be a case of fingers crossed - however, +CC Dennis in case
he can remember and his email address still works...


> 
>  drivers/iio/accel/st_accel.h     | 35 ++++++++++++++++----------------
>  drivers/iio/accel/st_accel_spi.c |  1 +
>  2 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
> index e7525615712b..817ccd0423d5 100644
> --- a/drivers/iio/accel/st_accel.h
> +++ b/drivers/iio/accel/st_accel.h
> @@ -14,30 +14,31 @@
>  #include <linux/types.h>
>  #include <linux/iio/common/st_sensors.h>
>  
> -#define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl_accel"
> -#define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl_accel"
> -#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
> -#define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
> -#define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
> -#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
> -#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
> -#define LIS331DL_ACCEL_DEV_NAME		"lis331dl_accel"
> -#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
> -#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
> -#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
> -#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
> -#define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
> -#define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr_accel"
> -#define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12_accel"
> +#define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl-accel"
> +#define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl-accel"
> +#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc-accel"
> +#define LIS3DH_ACCEL_DEV_NAME		"lis3dh-accel"
> +#define LSM330D_ACCEL_DEV_NAME		"lsm330d-accel"
> +#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl-accel"
> +#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc-accel"
> +#define LIS331DL_ACCEL_DEV_NAME		"lis331dl-accel"
> +#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh-accel"
> +#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl-accel"
> +#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh-accel"
> +#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm-accel"
> +#define LSM330_ACCEL_DEV_NAME		"lsm330-accel"
> +#define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr-accel"
> +#define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12-accel"
>  #define LIS3L02DQ_ACCEL_DEV_NAME	"lis3l02dq"
> -#define LNG2DM_ACCEL_DEV_NAME		"lng2dm"
> +#define LNG2DM_ACCEL_DEV_NAME		"lng2dm-accel"
>  #define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
>  #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
>  #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
>  #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
>  #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
>  #define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
> -#define LSM303C_ACCEL_DEV_NAME		"lsm303c_accel"
> +#define LIS302DL_SPI_ACCEL_DEV_NAME	"lis302dl-spi"
> +#define LSM303C_ACCEL_DEV_NAME		"lsm303c-accel"
>  #define SC7A20_ACCEL_DEV_NAME		"sc7a20"
>  #define IIS328DQ_ACCEL_DEV_NAME		"iis328dq"
>  
> diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
> index f72a24f45322..749d770d2350 100644
> --- a/drivers/iio/accel/st_accel_spi.c
> +++ b/drivers/iio/accel/st_accel_spi.c
> @@ -160,6 +160,7 @@ static const struct spi_device_id st_accel_id_table[] = {
>  	{ LIS3DHH_ACCEL_DEV_NAME },
>  	{ LIS3DE_ACCEL_DEV_NAME },
>  	{ LIS302DL_ACCEL_DEV_NAME },
> +	{ LIS302DL_SPI_ACCEL_DEV_NAME },
>  	{ LSM303C_ACCEL_DEV_NAME },
>  	{ IIS328DQ_ACCEL_DEV_NAME },
>  	{},

