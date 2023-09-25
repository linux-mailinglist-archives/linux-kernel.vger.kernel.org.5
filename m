Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1577AD886
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjIYND6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjIYND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:03:56 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E271103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:03:47 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77410032cedso397709785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695647026; x=1696251826; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PLJaBCun5muI3mMA2tWhuILomu/amJZWSYYuZNcnf18=;
        b=gwaDysEmb2VcMsThnsiWUuOuMnjK9+uKn5MTHtj8Rux/bUc/lS/peXSt7aSmqVUcGO
         gDWGG08dPb0JRBbSDy56aQDaWYrRRzm4EVg0aHSx00ah47dfgHrX6tEmuSZ0QWHPvIvJ
         BepsOL1VJAHPOGBnYaGJC9KnEEWaUbcsNwbjKdv2Aahia3aOp0EhtIAstXQZYIjBqqib
         PBm96m2Hsj+PYmn1s+oXPKVfjMPvV8ONBvbsZZjOg8dyLbxi5dYqwDpWjgB+ep2NOk5U
         dJfCGYOzZcTArVtu/FKvcZf09aEZhthBVdfCgydtvHTsmNwDLUZyVTZLaUJ7yNDh9Ip8
         W6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647026; x=1696251826;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLJaBCun5muI3mMA2tWhuILomu/amJZWSYYuZNcnf18=;
        b=Dtj0xbaMwn6HdxLidBfWcU3TwdC8Qc/etdNXqpJEeriUl9Fxtgg51yZSyaQ7gYeVCW
         2m+MIwLUy4ro25Zuzlf8XNUDm54Tse0DXiqZw7AeYNW1rRNCO5EzhWpsZ7Eo9HerNi3e
         5YKbbOPCNCmj3R0nHJtf9/LewORJbW1GOwtQO48IcH60X+vEH1sBb2W7ZDvj6QdMfASp
         KrHqZjFqY55d6uFnGoRex8oYvfQt8+LiBDrbNA2sSynM/pooxW6VwaFaUBoCw46TRqhD
         5QeKLNPvzja6NoWIRXAvZ5hWLSvfL9XELbp7MY5/TlfPZcpWC80KZsSCqvNaBi8zHtQc
         yptA==
X-Gm-Message-State: AOJu0YwMyZrmtw0C+gkh0z9vR/2rLEtLl4AK8or9Mil+iE/tt9dStf08
        PFHcSsfr6tdav72r8/Y3sow=
X-Google-Smtp-Source: AGHT+IFuRsomuLYw1c1/Gh5zNIZOFxMD/3ZFWSGrbzNA1H+GlhIDkoKlrX3x955Kav9y5K4KeTvwSQ==
X-Received: by 2002:a05:620a:c86:b0:76d:aa23:f8e1 with SMTP id q6-20020a05620a0c8600b0076daa23f8e1mr6091192qki.27.1695647026300;
        Mon, 25 Sep 2023 06:03:46 -0700 (PDT)
Received: from GLSVMLIN.INI.CMU.EDU (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id w8-20020ae9e508000000b0076cdc3b5beasm615381qkf.86.2023.09.25.06.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:03:45 -0700 (PDT)
Date:   Mon, 25 Sep 2023 09:03:43 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 12/40] soc/litex: litex_soc_ctrl: Convert to platform
 remove callback returning void
Message-ID: <ZRGFL+Z2Pw+EF5oe@GLSVMLIN.INI.CMU.EDU>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <20230925095532.1984344-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230925095532.1984344-13-u.kleine-koenig@pengutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 11:55:03AM +0200, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks!
Acked-by: Gabriel Somlo <gsomlo@gmail.com>

> ---
>  drivers/soc/litex/litex_soc_ctrl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> index f75790091d38..10813299aa10 100644
> --- a/drivers/soc/litex/litex_soc_ctrl.c
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -120,12 +120,11 @@ static int litex_soc_ctrl_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int litex_soc_ctrl_remove(struct platform_device *pdev)
> +static void litex_soc_ctrl_remove(struct platform_device *pdev)
>  {
>  	struct litex_soc_ctrl_device *soc_ctrl_dev = platform_get_drvdata(pdev);
>  
>  	unregister_restart_handler(&soc_ctrl_dev->reset_nb);
> -	return 0;
>  }
>  
>  static struct platform_driver litex_soc_ctrl_driver = {
> @@ -134,7 +133,7 @@ static struct platform_driver litex_soc_ctrl_driver = {
>  		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
>  	},
>  	.probe = litex_soc_ctrl_probe,
> -	.remove = litex_soc_ctrl_remove,
> +	.remove_new = litex_soc_ctrl_remove,
>  };
>  
>  module_platform_driver(litex_soc_ctrl_driver);
> -- 
> 2.40.1
> 
