Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14317BF2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442210AbjJJGOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbjJJGOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:14:19 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209D89D;
        Mon,  9 Oct 2023 23:14:18 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (185-9-11-240.cust.suomicom.net [185.9.11.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S4QbC4GQQz49Q4j;
        Tue, 10 Oct 2023 09:14:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1696918456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFJA2tqBva7PfHLrqbPQpWk8J1xI2ifThc/jSVknM30=;
        b=LEQEOuZ22wnylwJfycQOeMFFEitnTTUtOeu+j+9HY/XkS/F6dB7FEzj1ohkHON/63X+8/G
        0BlhYet6me0PJoIIRcVI6r2JV5M1a3yNnkIcMkLyD7ILqv2vXmb3F68EoOeme/tUGKiPSZ
        Ilz9T64hYiY2FBk0AAgomvaFX8UUlJLYASa/S9sGXZo3lBjDkuT4cm4abkei4MDn1KOVIT
        Vlz/tFxo1qWnFR/WnxqSlfg51uTNdpfSxrVxFqI2wh+QNp5c1CdPsYLS2jku3v2E1EaKvv
        saH5XjKtsPDo21swY3v4cjEgblhVFT2yDekAgYIExJyEAQmiHKsTMCzTD3qhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1696918456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFJA2tqBva7PfHLrqbPQpWk8J1xI2ifThc/jSVknM30=;
        b=An4EF1s1kZt0Ec+ZUPBAc5bjnHnNAORVUTKA6uLJtM9sGBGTn1UeLd5JjBZdEQK64Ufjf9
        2V71Q2Ix2/vINsgxwLdsj4trUUDuBDeUQWphOGOHFaTvYJLKN4Zx3gJXYYN1fHTGkw0ptt
        Z2Y/Hl9RRvmcl5pbILtTv1GQJJPqsHN6eKk6pRcNcYPdiZfrzQciKFdvmDgWECQW6LLmb3
        I/V+4J9QgzRpcZqXA0y/wcBE3Uo9+NwtUdkfvTxip3qXfPHaPJwEBgRkOFFJVAT0lyjfhb
        5ae6+4HNXk2e+phPup8ZpzsxB+RQP4kyorNVfe+6K2OmxGHEGaUpOmWAdcihkQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1696918456; a=rsa-sha256;
        cv=none;
        b=fTyi4ddZZtv+5Nk8ev1t6KOkXVbGbyrxTz9STwh34enumJErbfnqIoXKA0NHNwPhnbBJ3V
        QGmHI0EiuKTzHnbEWcyUp+NQve/vOxz3Z5tXpdA3uX20wruMYVHfGzo48IRyusNr7O0I6O
        WeVTPmxfyW9IMi6f7mHvF1FPUS9ac8sUXoqMnqXsM9YUV+aV28CFZj+/XRZTBC1gTvQV5+
        5Rf7J5B16bzFSswvrfDdeH4OtTa8Ql0y1+vE+mm8NJHPPNnPIO3Is7UJMWeNEEWFfQbQDR
        n36R56PHxFwRXMyOnC2wWr5O6t6vs4f/wpmWPbTjmcrNVDL6huLj++neZ3qFsg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id EA3E4634CA9;
        Tue, 10 Oct 2023 09:14:09 +0300 (EEST)
Date:   Tue, 10 Oct 2023 06:14:09 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 3/5] media: i2c: imx335: Implement get selection API
Message-ID: <ZSTrse7OeKIA+k2t@valkosipuli.retiisi.eu>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
 <20231010005126.3425444-4-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010005126.3425444-4-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Tue, Oct 10, 2023 at 01:51:24AM +0100, Kieran Bingham wrote:
> Support reporting of the Sensor Native and Active pixel array areas
> through the Selection API.
> 
> The implementation reports a single target crop only for the mode that
> is presently exposed by the driver.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Shouldn't you use the same callback for .set_selection? I guess this is
somewhat grey area but doing so would be in line with how V4L2 API works in
general.

Cc Laurent.

> ---
>  drivers/media/i2c/imx335.c | 44 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index bf12b9b69fce..026777eb362e 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -55,6 +55,14 @@
>  #define IMX335_REG_MIN		0x00
>  #define IMX335_REG_MAX		0xfffff
>  
> +/* IMX335 native and active pixel array size. */
> +#define IMX335_NATIVE_WIDTH		2616U
> +#define IMX335_NATIVE_HEIGHT		1964U
> +#define IMX335_PIXEL_ARRAY_LEFT		12U
> +#define IMX335_PIXEL_ARRAY_TOP		12U
> +#define IMX335_PIXEL_ARRAY_WIDTH	2592U
> +#define IMX335_PIXEL_ARRAY_HEIGHT	1944U
> +
>  /**
>   * struct imx335_reg - imx335 sensor register
>   * @address: Register address
> @@ -651,6 +659,41 @@ static int imx335_init_pad_cfg(struct v4l2_subdev *sd,
>  	return imx335_set_pad_format(sd, sd_state, &fmt);
>  }
>  
> +/**
> + * imx335_get_selection() - Selection API
> + * @sd: pointer to imx335 V4L2 sub-device structure
> + * @sd_state: V4L2 sub-device configuration
> + * @sel: V4L2 selection info
> + *
> + * Return: 0 if successful, error code otherwise.
> + */
> +static int imx335_get_selection(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_state *sd_state,
> +				struct v4l2_subdev_selection *sel)
> +{
> +	switch (sel->target) {
> +	case V4L2_SEL_TGT_NATIVE_SIZE:
> +		sel->r.top = 0;
> +		sel->r.left = 0;
> +		sel->r.width = IMX335_NATIVE_WIDTH;
> +		sel->r.height = IMX335_NATIVE_HEIGHT;
> +
> +		return 0;
> +
> +	case V4L2_SEL_TGT_CROP:
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +		sel->r.top = IMX335_PIXEL_ARRAY_TOP;
> +		sel->r.left = IMX335_PIXEL_ARRAY_LEFT;
> +		sel->r.width = IMX335_PIXEL_ARRAY_WIDTH;
> +		sel->r.height = IMX335_PIXEL_ARRAY_HEIGHT;
> +
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /**
>   * imx335_start_streaming() - Start sensor stream
>   * @imx335: pointer to imx335 device
> @@ -864,6 +907,7 @@ static const struct v4l2_subdev_pad_ops imx335_pad_ops = {
>  	.init_cfg = imx335_init_pad_cfg,
>  	.enum_mbus_code = imx335_enum_mbus_code,
>  	.enum_frame_size = imx335_enum_frame_size,
> +	.get_selection = imx335_get_selection,
>  	.get_fmt = imx335_get_pad_format,
>  	.set_fmt = imx335_set_pad_format,
>  };

-- 
Regards,

Sakari Ailus
