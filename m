Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ABB7EDCB5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbjKPIMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjKPIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:12:44 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F5C101;
        Thu, 16 Nov 2023 00:12:41 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6bd73395bceso416293b3a.0;
        Thu, 16 Nov 2023 00:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700122360; x=1700727160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qlj+PnzT+FOOl2mvRo0HP4CXC0RlLZiBghwvRd5W0XU=;
        b=ZmMCGkB6Ar9OnqqnqUhNXj2UPnDfZcmTi6dJOsuLizoHVzksK8ljr6G1sH9sMXe5DY
         F/TBklS+tyKZphKDzxz1Bmrl1nVZduQMLgiU/bwkhop/F0JuHA6OkaEz+vQb4G9jiOUl
         D3X7IH366OCur9/AeC3Brv8ny047Xgap41XR6d8axq6/w0z9uRckWYJzVcIagt5MzJWH
         bLHrz3sq/JjOz61aX84cmjjGTxeHa8tbRfJ1Jrilp0tv2sGIQaovPE/Pdve90yxJAlc+
         yOugijwxlZgH8e/nTkNfAhTszuJxlWCjfa++8WkssyRDSONKxt9+zF9xgIdLnqWjzRzo
         koMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700122360; x=1700727160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qlj+PnzT+FOOl2mvRo0HP4CXC0RlLZiBghwvRd5W0XU=;
        b=Oqy/XEHPqMMOOEY46a33vO+sfCzmxfn5LimK1H79V0Xp6wDlQP0WOZkj1AuviuKvt+
         DLOQjnFUm6MmuHaP6/iNIq7D5y6PqE2AcbBVOYzLrO5W3q+xtOKOAuPWj7KZeCWiezPn
         9XF5wGHX0Y0F6aI3JM6PMbfBUcwwNAu9dB8zgSFaz4hHLOhXjcKWMmrT+H13/RG0EuXf
         +nq1w9scSdmDlkoRcTtNyF7Pyb1CQlj4DV8QKTYMc4tt2ffEeK4WDePROQI3wm2K8thE
         mPZ13FLM5lvipVMKrZRHGP0RmH3n3SWvkPlsQlE+Co/ul3sYz0r9GCT4XKFxBFP9Srly
         gpUw==
X-Gm-Message-State: AOJu0Ywh+Cjx2FHg7Q6s3ydr1FYbFocZuE+bVFCBuJR/vVyE11u1k09M
        882ArBsIjDDGsPonXMCgmms=
X-Google-Smtp-Source: AGHT+IEZ4Ok5G//CU9wOewoSR94geWgb3+39sWqfFXMVmxrP1uDgX4Ymv9nmSR7GrrH84tQQFCvKZQ==
X-Received: by 2002:a05:6a20:1447:b0:17b:2c56:70bc with SMTP id a7-20020a056a20144700b0017b2c5670bcmr1692981pzi.10.1700122360526;
        Thu, 16 Nov 2023 00:12:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h5-20020a056a00218500b006c33c82da66sm3945317pfi.75.2023.11.16.00.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 00:12:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 00:12:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Xing Tong Wu <xingtong_wu@163.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, xingtong.wu@siemens.com,
        tobias.schaffner@siemens.com, gerd.haeussler.ext@siemens.com
Subject: Re: [PATCH 3/3] hwmon: (nct6775) Fix fan speed set failure in
 automatic mode
Message-ID: <949b2ae6-d631-449a-958c-a7d97fed57f6@roeck-us.net>
References: <20231116022330.2696-1-xingtong_wu@163.com>
 <20231116022330.2696-4-xingtong_wu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116022330.2696-4-xingtong_wu@163.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 10:23:30AM +0800, Xing Tong Wu wrote:
> From: Xing Tong Wu <xingtong.wu@siemens.com>
> 
> Setting the fan speed is only valid in manual mode; it is not possible
> to set the fan's speed in automatic mode.
> Return error and show error message when attempting to set the fan
> speed in automatic mode.
> 
> Signed-off-by: Xing Tong Wu <xingtong.wu@siemens.com>
> ---
>  drivers/hwmon/nct6775-core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
> index 575db6cb96e9..3fb9896c61ce 100644
> --- a/drivers/hwmon/nct6775-core.c
> +++ b/drivers/hwmon/nct6775-core.c
> @@ -2551,6 +2551,14 @@ store_pwm(struct device *dev, struct device_attribute *attr, const char *buf,
>  	int err;
>  	u16 reg;
>  
> +	if (index == 0 && data->pwm_enable[nr] != manual) {
> +		dev_err(dev,
> +			"The pwm%d doesn't support manual fan speed control in automatic mode.\n",
> +			nr + 1);
> +		dev_err(dev, "Please set pwm%d_enable to manual mode.\n", nr + 1);

No kernel log messages as reponse to user input, please. This
could and likely would clog the kernel log if, for example, some automated
script tries to write into the register.

Please add a comment describing why this is blocked.

> +		return -EOPNOTSUPP;

Wrong error code. I would suggest -EBUSY; that is what is used in the it87
driver.

Guenter

> +	}
> +
>  	err = kstrtoul(buf, 10, &val);
>  	if (err < 0)
>  		return err;
> -- 
> 2.25.1
> 
