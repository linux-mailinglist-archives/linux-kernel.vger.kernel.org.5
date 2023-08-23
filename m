Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F143786069
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbjHWTOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237937AbjHWTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:14:04 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8A810C3;
        Wed, 23 Aug 2023 12:14:02 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1bbb4bde76dso3732591fac.2;
        Wed, 23 Aug 2023 12:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692818041; x=1693422841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkRiXtT9qgRHA1MKcE0+A+p3QG0zRao4eJgb/tjcvlQ=;
        b=Q7FSR6dB4wlwBDBXWX1KuXmDaeBGHhW7k1v1+ImA0gFuBtUwOFzm4sVD7FddobVmOr
         3flBiIIHqODI7t/NtETd5yagNh/2+9nwVLOimnCEL/3pAZ8RjhiV22UkBemb+lIXscwj
         DnFQ4PiEtqRe9E2f0zkPWsOj9Hy7mWxzVtKoJ9mepCvmUQHMlEuHbjs441uTrkJiDCGP
         zOOUcPo6LL0fpfPCaoa+h4tYIUmAtTrNwKlxMERhHWFxOqZpB2UfXC5I0/E6y22ulicG
         jBUuDlVtTebd0QNP7nUEgop+ZYUsMc+eB0t5G18veKrNJqhCljBxCriqGeos55fR4QVa
         q37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692818041; x=1693422841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkRiXtT9qgRHA1MKcE0+A+p3QG0zRao4eJgb/tjcvlQ=;
        b=cB0TuaWtMIirz1llb2mitV39qqR6VdNZiMzfr8fYD/xW7WGMt92nPKMZV0fXleuMf2
         E3cr7yj4kdhLLvFBFF7GwDwmbmBygg1ZOGecNcW7WDeXABr3jIvY0nYDvM253sz4ShfN
         fez4A1F2DxkynOQkRwiXMzEHSqEiYXP6fNT21r077kZstBWy4rzLbwdjHhlZ+yo4tVsK
         OiQa9m+zxdZ5VtVXhWptuAGAyOLhunu7faRfTS92bzVIkKS3EirQgnU/P9zUSBx42kV0
         +laP6y4siN5KFNCnmMVMSbfizccL93Hg7K5GnQpodm8tRPjLri/jEBOZ267qypUaDYeA
         I/+w==
X-Gm-Message-State: AOJu0YwsflArI8dIRcpPWGkrMTcKsmyDnyJOWN/Hbux0gmtdik/Eu44d
        MMZWEJMbwpGznoFW9knABVo7Leg+vHZBeUVf
X-Google-Smtp-Source: AGHT+IHnSuSCucRZeqayL6ja0sJEQ/drYGXt+yBc/3mzIKZdrzN5yLF7PvV5D8Ze5IKPro5ArXJ8Hg==
X-Received: by 2002:a05:6870:2051:b0:1c8:39a6:779d with SMTP id l17-20020a056870205100b001c839a6779dmr15738900oad.20.1692818041186;
        Wed, 23 Aug 2023 12:14:01 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id d1-20020a0cf0c1000000b0064f46c719fasm2197994qvl.31.2023.08.23.12.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:14:00 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:13:58 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH 1/3] clk: lmk04832: Set missing parent_names for output
 clocks
Message-ID: <20230823191358.GA2572839@shaak>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.05b2cfbe-0414-4869-b825-034b9be5bf9a@emailsignatures365.codetwo.com>
 <20230802064100.15793-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802064100.15793-1-mike.looijmans@topic.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:40:58AM +0200, Mike Looijmans wrote:
> lmk04832_register_clkout forgot to fill in the parent_names, resulting
> in the error message "Must specify parents if num_parents > 0".
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Reviewed-by: Liam Beguin <liambeguin@gmail.com>

> ---
>  drivers/clk/clk-lmk04832.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
> index e22ac93e0c2f..188085e7a30b 100644
> --- a/drivers/clk/clk-lmk04832.c
> +++ b/drivers/clk/clk-lmk04832.c
> @@ -1297,6 +1297,7 @@ static int lmk04832_register_clkout(struct lmk04832 *lmk, const int num)
>  		sprintf(dclk_name, "lmk-dclk%02d_%02d", num, num + 1);
>  		init.name = dclk_name;
>  		parent_names[0] = clk_hw_get_name(&lmk->vco);
> +		init.parent_names = parent_names;
>  		init.ops = &lmk04832_dclk_ops;
>  		init.flags = CLK_SET_RATE_PARENT;
>  		init.num_parents = 1;
> -- 
> 2.17.1
> 
> 
> Met vriendelijke groet / kind regards,
> 
> Mike Looijmans
> System Expert
> 
> 
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
> 
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topicproducts.com
> W: www.topic.nl
> 
> Please consider the environment before printing this e-mail
