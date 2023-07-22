Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930CB75DD8B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGVQ5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81F51A1;
        Sat, 22 Jul 2023 09:57:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54E0C60B06;
        Sat, 22 Jul 2023 16:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529F2C433CA;
        Sat, 22 Jul 2023 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690045025;
        bh=bMLB9Dfamws2FvVaWzHXaq6s30YKLIbNPm/3XP/ZaZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EAGVns2RR7ZUPz0kvTP78hYRrOyP5SMu4yS0DVkKLx7NUWCzRHS8dG0xXNrap2IWV
         zyaBi+tNtV12fz2zY8dGVOnYVmDWfXw7ruDpLl3NtuB1PP3cZpapTS8+j441nIvOHW
         bMOGaEBLiYXLU71h2/GpV0usb78Wth3bcLn6uCfGkhSxggM1VfWfgBuVKPhws5Rxd3
         yfWiI6uOAYqPA3L+iDtsh4uWFENa2PWUWPeIsI2kVQUL/cTVNkCDHmhtdjgCA0aR1/
         aTTNMVJrl7qhUEDO4j0BmS/SW7MX1yfcN1HJc+et4dEe/qGoHRYS9h+HLn+CmUxwKG
         Qccu/I8ZkKO8A==
Date:   Sat, 22 Jul 2023 17:57:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     zhumao001@208suo.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: Fix typo in comment
Message-ID: <20230722175701.144fed35@jic23-huawei>
In-Reply-To: <7939814b6ca28cfcae466e436d159d22@208suo.com>
References: <20230718161444.1710-1-dengshaomin@cdjrlc.com>
        <20230718161444.1710-6-dengshaomin@cdjrlc.com>
        <7939814b6ca28cfcae466e436d159d22@208suo.com>
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

On Wed, 19 Jul 2023 00:28:15 +0800
zhumao001@208suo.com wrote:

Hi,

This didn't make the mailing list - I think because you sent
it as an html email.  Please fix that and resend as then it'll will
be tracked in patchwork / b4 tooling will work etc.

Thanks,

Jonathan

> 
> There is rebundant word 'actual' in comment, remove one.
> 
> Signed-off-by: Mao Zhu <zhumao001@208suo.com>
> ---
>   drivers/iio/gyro/adxrs450.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
> index f84438e0c42c..195c09beb937 100644
> --- a/drivers/iio/gyro/adxrs450.c
> +++ b/drivers/iio/gyro/adxrs450.c
> @@ -128,7 +128,7 @@ static int adxrs450_spi_read_reg_16(struct iio_dev 
> *indio_dev,
> 
>   /**
>    * adxrs450_spi_write_reg_16() - write 2 bytes data to a register pair
> - * @indio_dev: device associated with child of actual actual iio_dev
> + * @indio_dev: device associated with child of actual iio_dev
>    * @reg_address: the address of the lower of the two registers,which 
> should be
>    *    an even address, the second register's address is reg_address + 
> 1.
>    * @val: value to be written.
