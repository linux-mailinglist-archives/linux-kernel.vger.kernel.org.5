Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0CE781A1D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjHSOcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjHSOcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:32:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740341BDD7;
        Sat, 19 Aug 2023 07:32:06 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6EBB45A4;
        Sat, 19 Aug 2023 16:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1692455449;
        bh=PJ9ezBh6LVf1LVfwJCbXodQu9UmpAA8uoBBdA3GVUdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9jDTjpzsdwspUkNOCepo1Jd1CJqdOFMwEvYRPfdXUX/un4FsKWJJr0AkudmyxYkj
         OvgyQbCkki2g69SoU/gk0ELDmlnHsPCwKJ+zDCnSpU4mWzfYEjJU9TDONbQHqlyBQf
         2XAZgtVIIJnk+7dzC9EugllNZCF0yuBigUPOQZp4=
Date:   Sat, 19 Aug 2023 17:32:12 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Anshul <anshulusr@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, anshulusr2@gmail.com
Subject: Re: [PATCH] fixing ERROR: Macros with compex values must be enclosed
 within parentheses
Message-ID: <20230819143212.GB31744@pendragon.ideasonboard.com>
References: <20230819133115.23048-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230819133115.23048-1-anshulusr@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshul,

On Sat, Aug 19, 2023 at 07:01:13PM +0530, Anshul wrote:

The commit message must explain *why* the change is useful. In this
particular case, I don't think it is.

> Signed-off-by: Anshul <anshulusr@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 08fcd2ffa727..8d3bcd18b652 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2417,9 +2417,8 @@ static const struct uvc_device_info uvc_quirk_force_y8 = {
>  	.quirks = UVC_QUIRK_FORCE_Y8,
>  };
>  
> -#define UVC_INFO_QUIRK(q) (kernel_ulong_t)&(struct uvc_device_info){.quirks = q}
> -#define UVC_INFO_META(m) (kernel_ulong_t)&(struct uvc_device_info) \
> -	{.meta_format = m}
> +#define UVC_INFO_QUIRK(q) ((kernel_ulong_t)&(struct uvc_device_info){.quirks = q})
> +#define UVC_INFO_META(m) ((kernel_ulong_t)&(struct uvc_device_info) {.meta_format = m})
>  
>  /*
>   * The Logitech cameras listed below have their interface class set to

-- 
Regards,

Laurent Pinchart
