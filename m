Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C91B761C62
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjGYO6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGYO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:58:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD7A1999;
        Tue, 25 Jul 2023 07:58:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2681223aaacso1594154a91.0;
        Tue, 25 Jul 2023 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690297130; x=1690901930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mP7oQvIOHT89NG0UNieZfVGvKInvFVTGIGh0GgRirQs=;
        b=CvU3jQi0iOW33Bh7v5q2cygR7raEaFMwJDywwlD6Fit5HSpslSO5xcbckbIZHB957B
         6I8cnCmasc3pGyU39a914j1tCG8lPelj33eoukV3s1Cv9EDGiktRUbitOdFfXxNx7sOC
         im5TQWFL5r2AWOGCnUE2wL+aHm7VUSDnEYDobteay4eWKSYTgf0y88ap/07qfnRVttop
         eG+1bzuTij2fT8oYJCxmkxmUVDkIJyNoNRp4LGzPFiVhYLZ0Xp9yqFk0kiIIF+KLYaod
         1XTjdSaojEgIZnDOA5ERy00lS1NqGO+E7MvT+p63pVqfTZ4xBjPR0M/9Jfbfr4xtJNb4
         sWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690297130; x=1690901930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mP7oQvIOHT89NG0UNieZfVGvKInvFVTGIGh0GgRirQs=;
        b=NAQIfyBxBBifRlhs9RNf+nfMJDAJvLh+q2F3PhdlxQOlOH9ZRe68/QjiyVxnuXPNy9
         pkS2XwKvdEA5DJumpN0P9M/4KgdzgFsALeVMgwrTZezXywcTtN7E91EESpVS1R/NdBUS
         bqLQd5uT+duZb6yG/6Ba+sZm9DxjZWGYY7VmP55iLakjzoRuULUwzMRZod+460bYp45m
         1cpLymqIcBkSJnLXvAEsKv+Ye8Gfy0yYiZW2zC5ZNQHcnLqobKk7FzwJMS2rPrAmmvJF
         Za/8hY4xVoV40DJiQqUIdcSbE+7iFkRsyJ66cv6cYBKT/liYeYgVIqSjViMl9tuf3LEK
         J8tg==
X-Gm-Message-State: ABy/qLb0GwBEEGZcVS5MqzevAg/4nSbJfiGgU2rzEGonYfdLipSvGm9n
        cXEOpfizZxNtCwyLXe9qOcQ=
X-Google-Smtp-Source: APBJJlG22GBPK7ppfCDmmhR/yFQ1NDJHaAb/hVvhslYX9PSWC/gpxDwbE41zXWo5Lcn/kWz5k3CRNw==
X-Received: by 2002:a17:90b:2551:b0:261:219b:13b3 with SMTP id nw17-20020a17090b255100b00261219b13b3mr3697643pjb.16.1690297129889;
        Tue, 25 Jul 2023 07:58:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a4c8500b002676e961260sm1449936pjh.0.2023.07.25.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 07:58:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Jul 2023 07:58:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] pmbus_core: Fix NULL pointer dereference
Message-ID: <b5b0e15e-d58e-47fa-9398-7fdd48a803b2@roeck-us.net>
References: <20230725125428.3966803-1-Naresh.Solanki@9elements.com>
 <20230725125428.3966803-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725125428.3966803-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 02:54:26PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Pass i2c_client to _pmbus_is_enabled to drop the assumption
> that a regulator device is passed in.
> 
> This will fix the issue of a NULL pointer dereference when called from
> _pmbus_get_flags.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter

> ---
> Changes in V2:
> - Fix build error.
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 42fb7286805b..30aeb59062a5 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2745,9 +2745,8 @@ static const struct pmbus_status_category __maybe_unused pmbus_status_flag_map[]
>  	},
>  };
>  
> -static int _pmbus_is_enabled(struct device *dev, u8 page)
> +static int _pmbus_is_enabled(struct i2c_client *client, u8 page)
>  {
> -	struct i2c_client *client = to_i2c_client(dev->parent);
>  	int ret;
>  
>  	ret = _pmbus_read_byte_data(client, page, PMBUS_OPERATION);
> @@ -2758,14 +2757,13 @@ static int _pmbus_is_enabled(struct device *dev, u8 page)
>  	return !!(ret & PB_OPERATION_CONTROL_ON);
>  }
>  
> -static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
> +static int __maybe_unused pmbus_is_enabled(struct i2c_client *client, u8 page)
>  {
> -	struct i2c_client *client = to_i2c_client(dev->parent);
>  	struct pmbus_data *data = i2c_get_clientdata(client);
>  	int ret;
>  
>  	mutex_lock(&data->update_lock);
> -	ret = _pmbus_is_enabled(dev, page);
> +	ret = _pmbus_is_enabled(client, page);
>  	mutex_unlock(&data->update_lock);
>  
>  	return ret;
> @@ -2844,7 +2842,7 @@ static int _pmbus_get_flags(struct pmbus_data *data, u8 page, unsigned int *flag
>  	if (status < 0)
>  		return status;
>  
> -	if (_pmbus_is_enabled(dev, page)) {
> +	if (_pmbus_is_enabled(client, page)) {
>  		if (status & PB_STATUS_OFF) {
>  			*flags |= REGULATOR_ERROR_FAIL;
>  			*event |= REGULATOR_EVENT_FAIL;
> @@ -2898,7 +2896,10 @@ static int __maybe_unused pmbus_get_flags(struct pmbus_data *data, u8 page, unsi
>  #if IS_ENABLED(CONFIG_REGULATOR)
>  static int pmbus_regulator_is_enabled(struct regulator_dev *rdev)
>  {
> -	return pmbus_is_enabled(rdev_get_dev(rdev), rdev_get_id(rdev));
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +
> +	return pmbus_is_enabled(client, rdev_get_id(rdev));
>  }
>  
>  static int _pmbus_regulator_on_off(struct regulator_dev *rdev, bool enable)
