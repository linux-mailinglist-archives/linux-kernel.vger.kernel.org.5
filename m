Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BDF812FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572955AbjLNMMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572923AbjLNMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:12:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159811A;
        Thu, 14 Dec 2023 04:12:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC3F04A9;
        Thu, 14 Dec 2023 13:11:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1702555900;
        bh=J1W791y5z9tb+RMNhkJ3fZXGR3XgxrCTNy61KkwXuPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XVjx4qHgReg8Rrb3/ikXD7shwptR2xncpRS1Uz2UZ+Q/NccDWuxKgctDo6ngMEqRz
         g2FmJHpQ17/JNSEwUcoj6oWU5jJw3nM0xsMx7U8/kgFARBAn5FTlINRVjG77mfL3s2
         NjL3Z2CVj6Zp4p0VyyKyH2x8rkulkkbRy5TR3foE=
Date:   Thu, 14 Dec 2023 14:12:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marvin Lin <milkfafa@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Ming Qian <ming.qian@nxp.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 4/9] staging: media: starfive: camss: Replace format
 index with pad
Message-ID: <20231214121233.GB21146@pendragon.ideasonboard.com>
References: <20231214065027.28564-1-changhuang.liang@starfivetech.com>
 <20231214065027.28564-5-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231214065027.28564-5-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Changhuang,

Thank you for the patch.

On Wed, Dec 13, 2023 at 10:50:22PM -0800, Changhuang Liang wrote:
> Replace format index with pad.

The code change looks good I think, but the commit message needs to
explain *why* you're changing this.

> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/staging/media/starfive/camss/stf-isp.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
> index ac83f23842df..c3ae02cf6dd8 100644
> --- a/drivers/staging/media/starfive/camss/stf-isp.c
> +++ b/drivers/staging/media/starfive/camss/stf-isp.c
> @@ -11,9 +11,6 @@
>  
>  #include "stf-camss.h"
>  
> -#define SINK_FORMATS_INDEX	0
> -#define SOURCE_FORMATS_INDEX	1
> -
>  static int isp_set_selection(struct v4l2_subdev *sd,
>  			     struct v4l2_subdev_state *state,
>  			     struct v4l2_subdev_selection *sel);
> @@ -95,11 +92,7 @@ static void isp_try_format(struct stf_isp_dev *isp_dev,
>  		return;
>  	}
>  
> -	if (pad == STF_ISP_PAD_SINK)
> -		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
> -	else if (pad == STF_ISP_PAD_SRC)
> -		formats = &isp_dev->formats[SOURCE_FORMATS_INDEX];
> -
> +	formats = &isp_dev->formats[pad];
>  	fmt->width = clamp_t(u32, fmt->width, STFCAMSS_FRAME_MIN_WIDTH,
>  			     STFCAMSS_FRAME_MAX_WIDTH);
>  	fmt->height = clamp_t(u32, fmt->height, STFCAMSS_FRAME_MIN_HEIGHT,
> @@ -124,7 +117,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
>  		if (code->index >= ARRAY_SIZE(isp_formats_sink))
>  			return -EINVAL;
>  
> -		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
> +		formats = &isp_dev->formats[code->pad];
>  		code->code = formats->fmts[code->index].code;
>  	} else {
>  		struct v4l2_mbus_framefmt *sink_fmt;

-- 
Regards,

Laurent Pinchart
