Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858EE7DCA54
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjJaKBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjJaKBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:01:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF32F1;
        Tue, 31 Oct 2023 03:01:42 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.252])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F1683D6;
        Tue, 31 Oct 2023 11:01:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698746484;
        bh=Jl+xsisgGaEGcRycAbLfuH+GR5oIKMeZIutbGi45Jio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mObP8r+Bj16HOBypfv+h8OpHY2GSQr9PdprT/4uCHMoEb+3flzfrcrgb43yBHDPm1
         p35eJcn924dFAaPfJcqX+rVY1UzNLsRjq4Xime6MQnTWTNM153BKXXKowxYx6MzYKD
         uGj9y+cPMozszty+ECAKkEBMDmv4il6hOd0SIKOQ=
Date:   Tue, 31 Oct 2023 15:31:30 +0530
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: remove unnecessary NULL check
Message-ID: <4hbwnpv3qw6sxbtgqjraalzh55cg7los6mtddksitcikm4xjgx@wpqa3eqsw7xn>
References: <1dff4d9b-d067-4525-95e0-ffdc1185cccd@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dff4d9b-d067-4525-95e0-ffdc1185cccd@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch.

On Tue, Oct 31, 2023 at 11:59:34AM +0300, Dan Carpenter wrote:
> We ensured that "service" as non-NULL in the previous if statement so
> there is no need to check again here.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

LGTM,

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index 39b857da2d42..a0117efa2991 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -2040,8 +2040,7 @@ sync_func(void *v)
>  			continue;
>  		}
>  
> -		svc_fourcc = service ? service->base.fourcc
> -				     : VCHIQ_MAKE_FOURCC('?', '?', '?', '?');
> +		svc_fourcc = service->base.fourcc;
>  
>  		vchiq_log_trace(state->dev, VCHIQ_SYNC,
>  				"Rcvd Msg %s from %p4cc s:%d d:%d len:%d",
> -- 
> 2.42.0
> 
