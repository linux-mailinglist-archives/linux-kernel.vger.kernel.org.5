Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9110A79F187
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjIMS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjIMS6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:58:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F8D1986;
        Wed, 13 Sep 2023 11:58:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52586C433C8;
        Wed, 13 Sep 2023 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694631516;
        bh=L9fkqwogJ6Mw64LwM2CsR4hDgaa8lc+8w9VbJ4PNCGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J8b1Bplv02uuQdKs58aNHvlwnrlJzMkrtHa9J+XFcom8YQCnTmaRf1wDO9C1rwehy
         883tTyW9cD7u1328pmVBgbH7da3lwn6FIthkYyQdK224myzMg1+L/AqWtbpr7hGDxo
         6/l98Rm8s6Kr8XoEcyOQPtXNKVSPanC/z6rFuo12XwJtEea3RRJ1OSB3pROfDbgvHx
         vKC2mPhq9Edn8A+aWZJRuoqLF73+7efE1dY8gFUQsatnylccdo7zdJBWp8nYnnv0ja
         uN/UkoAKU3EuMdnYnq3VB7o2Ew1LM5Q4bCxEtscc37DQQqAOpJhl1WEv+Snu0uVTvf
         a+88nhgxm98WA==
Date:   Wed, 13 Sep 2023 19:58:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: addac: Kconfig: update ad74413r selections
Message-ID: <20230913195830.04126014@jic23-huawei>
In-Reply-To: <20230912085421.51102-1-antoniu.miclaus@analog.com>
References: <20230912085421.51102-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 11:54:21 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Building ad74413r without selecting IIO_BUFFER and
> IIO_TRIGGERED_BUFFER generates error with respect to the iio trigger
> functions that are used within the driver.
> Update the Kconfig accordingly.
> 
> Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/addac/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
> index 877f9124803c..397544f23b85 100644
> --- a/drivers/iio/addac/Kconfig
> +++ b/drivers/iio/addac/Kconfig
> @@ -24,6 +24,8 @@ config AD74413R
>  	depends on GPIOLIB && SPI
>  	select REGMAP_SPI
>  	select CRC8
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to build support for Analog Devices AD74412R/AD74413R
>  	  quad-channel software configurable input/output solution.

