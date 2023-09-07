Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6970179770E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbjIGQUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjIGQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:20:17 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427FE1BC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:16:06 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-402e7968042so11495245e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694103007; x=1694707807; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AfBRtUznKahZ3dwZyCgaTKUpdQMQZ0q3hwDeizi9iw8=;
        b=ywnXTCHnolnOG3P00loCgiQvc74O66ZqsdZ9lfALM+VU1NtM+cKZOqFl3x1axPlMzN
         Pvo1vlph3Z9cW5gKYMj5NBnLExHN1CaLsXXDbYSaARKK6JSMSfS0OvA7ZQQqtdCa9rdR
         C4RJdi5mbRIWz6vQs/2JVGSlS4BHdwj2aZ6X9pzjsGWmJRBBEHtrhIfpmRYr4M20dRIX
         zLZFTPS8O/I8x2MROMJW1lzN05YBx+F1OEL//sap+WgQwz1kJcue/5WPpvqWolaMmIXO
         uHVjB8SSeYl/iojWcDd3LALfiOlyhQb2gme6JfNIA/mONAmvBGmGBMuxFx0mGqTnEHr2
         nzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103007; x=1694707807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfBRtUznKahZ3dwZyCgaTKUpdQMQZ0q3hwDeizi9iw8=;
        b=i7Hc1IeDGG3WgtVPR9HJVS8IoBVp+53EnhiLCmo5uMnrFmgnZPy6HbC+tpTtcv84Qn
         vUiR9ZXCdC8b/KzjC3TqspUqeK2V/yEo9UWDhUfW5xcyLn9Ingt8gouCXqjPPGsyo1AW
         F029wXTsy4ybDvq2MtpaPTEkPJtC+iRpW64SP/2L2SHylpnqPDDATmUa4LdSsE0EKDGZ
         UzgmB9i187wKTiuXglcS4Zr0678UDyT5jsf4+O4fuKHMgTv1QuZyfY+VVkDur6+j1egi
         /iolhfxylX1F2q55hDWAhYgk1say9jmAi9sXVoqk6vja5CIzrgcJcvzWFE/OoSB9gdkf
         GOWA==
X-Gm-Message-State: AOJu0YxBk+tUWI3ycol/xClhasbZDny2Jc3DmplNLZMzsHz11lo64VMQ
        oLFKjz9k4q2xZvx8/aIBDsWVRAZk2yHoi3qQHzI=
X-Google-Smtp-Source: AGHT+IFN1DVLDmj0KO6926C82lwOVs09adWFw1TE8GqB7efKq4l0BjednSUngORngfvmRmj6+fehVg==
X-Received: by 2002:a5d:51d1:0:b0:317:6470:3271 with SMTP id n17-20020a5d51d1000000b0031764703271mr4725013wrv.45.1694083787100;
        Thu, 07 Sep 2023 03:49:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003fef3180e7asm2143464wmi.44.2023.09.07.03.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 03:49:46 -0700 (PDT)
Date:   Thu, 7 Sep 2023 13:49:43 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] driver base: slience unused warning
Message-ID: <3b710f6d-05cf-49d5-b004-849ee2a3ca42@kadam.mountain>
References: <20230831073654.1713710-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230831073654.1713710-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 03:36:55PM +0800, Su Hui wrote:
> Avoid unused warning with gcc and W=1 option.
> 
> drivers/base/module.c:36:6: error:
> variable ‘no_warn’ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/base/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/module.c b/drivers/base/module.c
> index 46ad4d636731..10494336d601 100644
> --- a/drivers/base/module.c
> +++ b/drivers/base/module.c
> @@ -33,7 +33,7 @@ static void module_create_drivers_dir(struct module_kobject *mk)
>  void module_add_driver(struct module *mod, struct device_driver *drv)
>  {
>  	char *driver_name;
> -	int no_warn;
> +	int __maybe_unused no_warn;

Just delete the variable if it isn't used.

regards,
dan carpenter

