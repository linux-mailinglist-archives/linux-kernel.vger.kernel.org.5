Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9EE78E92A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjHaJRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjHaJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:17:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF157CDD;
        Thu, 31 Aug 2023 02:16:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3110ab7110aso435176f8f.3;
        Thu, 31 Aug 2023 02:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693473413; x=1694078213; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0dnYJvLMIpANPASquNaD9gnfxzlO89jbOPtXwZ31rbY=;
        b=Iy+dIqsCf9PglYA1rzkDbZyIZU5U/uJcQ5cKGDHivEjVmUwtYIh4iuiZGTiaB3Iy2G
         y25OLec3N4v18XD/gApRii7V7GA5Q7jR2oz0fRW0gd9y/Jg3W5AIyku0ksLxqzeZjWUK
         JmzWrrxbKPh3vEO8ULTOeDOLtl9SWmUaa98AgH0rafUUFbQG8Bm7sMYE9ChuLkhBFvup
         FsxwGFRyhGEqors/enR+H3FA/JFHTMUwcf+QwzvnymiwzlnNpXkgGwkCFKnbmohAbDzI
         Lc3tJr6HevEjrHmPXffDq4CP8r0//W5vw3b8Suyx99F4JEd3KU9h4E0quT84rxsJQ4cm
         dBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693473413; x=1694078213;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0dnYJvLMIpANPASquNaD9gnfxzlO89jbOPtXwZ31rbY=;
        b=KF3SlYX7Kws+qinAX1JOKTPrEiVIpheib+UzLnqwdnpLy3EXf1ktjoz9bU57iTVrub
         C06wcs0QJKC6uznvBktbUDMZcdt45SoAtmUBW//4PPs/5feJjFocEUIdEmbiNdgO+sm6
         crhezhcXtuRmiuykTCMwfqhZJIsqA1O4sbFuCfoLWdt/ciLfBt3FiGZqoHT1Tk0Tk+YC
         2jWADU5hu7QylayZi1Ayz8jakNDT0fC7COKsdc+HteLrU0Yy6fXs5XaMfetvnUZAR5ED
         YcAbTWZ0MdDHWakCcqs6wvLiweIOCALcQeARMWcIphHIygjG8ra/ZD7iF578/8tZfJS8
         HGpg==
X-Gm-Message-State: AOJu0YwCZSInVG62TO4cpESjtGzUamKH1ley/Sv9nYzjdUUt87i1yzEk
        uX2quxmLFT6MvpGiSKo5NZ4=
X-Google-Smtp-Source: AGHT+IEEC/IOcwAaa1oeciqMKRGj3e18yNmGwPrz8uNum8h2wf2Xg6roNPMd7mlQPgS5E8Sgdk5faw==
X-Received: by 2002:a05:6000:110a:b0:31a:e87e:103 with SMTP id z10-20020a056000110a00b0031ae87e0103mr3103180wrw.48.1693473412883;
        Thu, 31 Aug 2023 02:16:52 -0700 (PDT)
Received: from localhost (a109-49-32-45.cpe.netcabo.pt. [109.49.32.45])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d45c2000000b003195504c754sm1528513wrs.31.2023.08.31.02.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 02:16:52 -0700 (PDT)
From:   Rui Miguel Silva <rmfrfs@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: imx-mipi-csis: Remove an incorrect
 fwnode_handle_put() call
In-Reply-To: <dd5b741f496d074d342958f14baff5bae8c71531.1693429556.git.christophe.jaillet@wanadoo.fr>
References: <dd5b741f496d074d342958f14baff5bae8c71531.1693429556.git.christophe.jaillet@wanadoo.fr>
Date:   Thu, 31 Aug 2023 10:16:51 +0100
Message-ID: <m3msy7eflo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,
Many thanks for the fix.

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:

> The commit in Fixes has removed an fwnode_graph_get_endpoint_by_id() call
> in mipi_csis_subdev_init().
> So the reference that was taken should not be released anymore in the
> error handling path of the probe and in the remove function.
>
> Remove the now incorrect fwnode_handle_put() calls.
>
> Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

LGTM.
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>

Cheers,
   Rui

> ---
>  drivers/media/platform/nxp/imx-mipi-csis.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/media/platform/nxp/imx-mipi-csis.c b/drivers/media/platform/nxp/imx-mipi-csis.c
> index 16f19a640130..5f93712bf485 100644
> --- a/drivers/media/platform/nxp/imx-mipi-csis.c
> +++ b/drivers/media/platform/nxp/imx-mipi-csis.c
> @@ -1490,7 +1490,6 @@ static int mipi_csis_probe(struct platform_device *pdev)
>  	v4l2_async_unregister_subdev(&csis->sd);
>  err_disable_clock:
>  	mipi_csis_clk_disable(csis);
> -	fwnode_handle_put(csis->sd.fwnode);
>  
>  	return ret;
>  }
> @@ -1510,7 +1509,6 @@ static void mipi_csis_remove(struct platform_device *pdev)
>  	mipi_csis_clk_disable(csis);
>  	v4l2_subdev_cleanup(&csis->sd);
>  	media_entity_cleanup(&csis->sd.entity);
> -	fwnode_handle_put(csis->sd.fwnode);
>  	pm_runtime_set_suspended(&pdev->dev);
>  }
>  
> -- 
> 2.34.1
