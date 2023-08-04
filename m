Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB076FFAE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjHDLt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHDLtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:49:55 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA327E77;
        Fri,  4 Aug 2023 04:49:21 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RHPBj1G6lzyWs;
        Fri,  4 Aug 2023 14:49:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1691149757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0UMGikCOwPi2Cg7B7z5dyNKxMM2SEVt8S0+qyO4JLA=;
        b=A3o3lFXj8b7TFO4ZFnczWGtOrfcCUYSWBgBm3WkzEVoRRYWNsx7HiLZ0xbDrsDFncQOQ08
        OcBf2mP+8qkDaSNS301Ot4ppj597MPemgNzCoiG3O1th2uwbwIAoT8ue2qdl8atfpcdnaK
        aNqvpw1dGY7qMGB+2LmMi/I/5uADMO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1691149757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b0UMGikCOwPi2Cg7B7z5dyNKxMM2SEVt8S0+qyO4JLA=;
        b=LqYI5qy8U/ye5KYW6LCXy+7drILgsnjdVgJazLla+khcb24yq51eRQKtw0BU+dfKj9cVDs
        7eu0zbiDky8505UFF7iyXRi0XOByXrZDmvGIOO7/bbgP4fAl/hSzVeDcmNLg9DESpsYlWG
        bQmWvyR44tbQCy5tnvomeVR3fc2jSOU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1691149757; a=rsa-sha256; cv=none;
        b=A0QuZMAbAwDJPN4dyZOA1JMGLoocVy9ZxoTOFjAlvjX/4aNXHDOUBtw36sNIhwsOpvcN0r
        x/29ERAZ32tlv7JGUbBcKIay1RQnhIGdnnxLGaAanQMv3XH9vKPjbhaIb7VTtk/g68kP+H
        EUSpD3qONbo486rzz1vKWmsfZe+HvvQ=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 82E68634C23;
        Fri,  4 Aug 2023 14:49:16 +0300 (EEST)
Date:   Fri, 4 Aug 2023 11:49:16 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: imx334: add support for test pattern
 generator
Message-ID: <ZMzlvMrxEZTlc/w+@valkosipuli.retiisi.eu>
References: <20230710095111.2994969-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710095111.2994969-1-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Mon, Jul 10, 2023 at 03:21:11PM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Add support for the imx334's test pattern generator.
> By default the test pattern generator is disabled, so add support for
> enabling and disabling horizontal and vertical colour bars.
> 
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 57 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index b65c526a5f1c..248ab65a6725 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -56,6 +56,24 @@
>  #define IMX334_REG_MIN		0x00
>  #define IMX334_REG_MAX		0xfffff
>  
> +/* Test Pattern Control */
> +#define IMX334_REG_TP		0x329e
> +#define IMX334_TP_COLOR_HBARS	0xA
> +#define IMX334_TP_COLOR_VBARS	0xB
> +
> +#define IMX334_TPG_EN_DOUT	0x329c
> +#define IMX334_TP_ENABLE	0x1
> +#define IMX334_TP_DISABLE	0x0
> +
> +#define IMX334_TPG_COLORW	0x32a0
> +#define IMX334_TPG_COLORW_120P	0x13
> +
> +#define IMX334_TP_CLK_EN	0x3148
> +#define IMX334_TP_CLK_EN_VAL	0x10
> +#define IMX334_TP_CLK_DIS_VAL	0x0
> +
> +#define IMX334_DIG_CLP_MODE	0x3280
> +
>  /**
>   * struct imx334_reg - imx334 sensor register
>   * @address: Register address
> @@ -429,6 +447,18 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
>  	{0x3a29, 0x00},
>  };
>  
> +static const char * const imx334_test_pattern_menu[] = {
> +	"Disabled",
> +	"Color Bars Ver",
> +	"Color Bars Hor",

I'd try to align this with what's already there.

E.g. "Vertical Color Bars" and "Horizontal Color Bars".

Seems fine otherwise. Please cc me for v2.

> +};
> +
> +static const int imx334_test_pattern_val[] = {
> +	IMX334_TP_DISABLE,
> +	IMX334_TP_COLOR_HBARS,
> +	IMX334_TP_COLOR_VBARS,
> +};
> +
>  static const struct imx334_reg raw10_framefmt_regs[] = {
>  	{0x3050, 0x00},
>  	{0x319d, 0x00},
> @@ -711,6 +741,26 @@ static int imx334_set_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_HBLANK:
>  		ret = 0;
>  		break;
> +	case V4L2_CID_TEST_PATTERN:
> +		if (ctrl->val) {
> +			imx334_write_reg(imx334, IMX334_TP_CLK_EN, 1,
> +					 IMX334_TP_CLK_EN_VAL);
> +			imx334_write_reg(imx334, IMX334_DIG_CLP_MODE, 1, 0x0);
> +			imx334_write_reg(imx334, IMX334_TPG_COLORW, 1,
> +					 IMX334_TPG_COLORW_120P);
> +			imx334_write_reg(imx334, IMX334_REG_TP, 1,
> +					 imx334_test_pattern_val[ctrl->val]);
> +			imx334_write_reg(imx334, IMX334_TPG_EN_DOUT, 1,
> +					 IMX334_TP_ENABLE);
> +		} else {
> +			imx334_write_reg(imx334, IMX334_DIG_CLP_MODE, 1, 0x1);
> +			imx334_write_reg(imx334, IMX334_TP_CLK_EN, 1,
> +					 IMX334_TP_CLK_DIS_VAL);
> +			imx334_write_reg(imx334, IMX334_TPG_EN_DOUT, 1,
> +					 IMX334_TP_DISABLE);
> +		}
> +		ret = 0;
> +		break;
>  	default:
>  		dev_err(imx334->dev, "Invalid control %d", ctrl->id);
>  		ret = -EINVAL;
> @@ -1217,7 +1267,7 @@ static int imx334_init_controls(struct imx334 *imx334)
>  	u32 lpfr;
>  	int ret;
>  
> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 6);
> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
>  	if (ret)
>  		return ret;
>  
> @@ -1277,6 +1327,11 @@ static int imx334_init_controls(struct imx334 *imx334)
>  	if (imx334->hblank_ctrl)
>  		imx334->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>  
> +	v4l2_ctrl_new_std_menu_items(ctrl_hdlr, &imx334_ctrl_ops,
> +				     V4L2_CID_TEST_PATTERN,
> +				     ARRAY_SIZE(imx334_test_pattern_menu) - 1,
> +				     0, 0, imx334_test_pattern_menu);
> +
>  	if (ctrl_hdlr->error) {
>  		dev_err(imx334->dev, "control init failed: %d",
>  			ctrl_hdlr->error);
> -- 
> 2.34.1
> 

-- 
Kind regards,

Sakari Ailus
