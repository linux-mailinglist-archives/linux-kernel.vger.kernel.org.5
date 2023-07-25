Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3585C761CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjGYPGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGYPGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:06:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8068199D;
        Tue, 25 Jul 2023 08:06:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-668709767b1so3580435b3a.2;
        Tue, 25 Jul 2023 08:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690297607; x=1690902407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wuTjQYFpmzQtLhftP40rTf1zL6bn9Ib9M4B+PGI748=;
        b=HMmJ+PVqGvXj3E04tMsHnTSrEyB71zV530f6rVq6FO51uPUnpplvDXcq9pve5USoX4
         1Z4FXXThCw81j8Mvo11pyLQ7HtuxXFM4LKce1XHKPlObZ2aMNfbMFCz2Faw3AgrdmfLX
         S8QAw7FmrHc+zSEExILuZ3TTp7h6QV2wU738aHPsWAIfV/VWJnn8LA93FP/lhYsgCF3s
         Lvny1FssE2NXGGDDB94snRoLivbNATJ4/greNLr675i8KmvMrmpYse5hQAhdhOVSzFXY
         XsJCzzGHxeuzzBgWaO3Zeh+lSuJ1UvXjLIJwpz4IhQjxv/Z60bB/N1E2mPAWnOj1UavM
         kEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690297607; x=1690902407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wuTjQYFpmzQtLhftP40rTf1zL6bn9Ib9M4B+PGI748=;
        b=A69I1f1ipHq0pSW5DF+C4ZOov5rul9CwgpTiJq/7pAlvYLQThvgFl19C5DOzfe38tF
         wKoga+nyeAOqgod3PIoH7ehc2eNi7vzGdENF/p7DJYKBXz7wFmIwfes7J2QPzPAVy7rE
         tYrdHRJ+laR7hzIvoM1heDqpng05I0S69O1tyZX7QsGMresVhFYcJsFrC3E8W8w4qAyt
         F597p0fgIA4aaHyfC0rDi7GEt0AAIVAL7nCw3Ns39TOrhflf7txOPRJ+fs7cO/EMbsmT
         mVtm4BUEBTowheYUtPcP+TNyX40DcQTSQ9IHsKdfKXKGvIv4TO+WSqF45elIXrkktxxK
         aIzQ==
X-Gm-Message-State: ABy/qLZLylxFATCLQQGrK8fl1QBkkvWflSjMLbdTt6yo9WlKcxllsAVT
        zl+2ogSejIIpQxhuc20P5+ZAihBqRP0=
X-Google-Smtp-Source: APBJJlHuidekr3LQrembU/ETAsJYqajVLLu4elnT35u+2G3fz1sLQobQGXoNDBH4Uca6QnEHquGJ7g==
X-Received: by 2002:a05:6a00:14d0:b0:675:8f71:28f1 with SMTP id w16-20020a056a0014d000b006758f7128f1mr13123071pfu.30.1690297607063;
        Tue, 25 Jul 2023 08:06:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l12-20020a62be0c000000b0067459e92801sm9718173pff.64.2023.07.25.08.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:06:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 25 Jul 2023 08:06:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pmbus_core: Fix Deadlock
Message-ID: <b7a3ad85-aab4-4718-a001-1d8b1c0eef36@roeck-us.net>
References: <20230725125428.3966803-1-Naresh.Solanki@9elements.com>
 <20230725125428.3966803-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725125428.3966803-3-Naresh.Solanki@9elements.com>
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

On Tue, Jul 25, 2023 at 02:54:27PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> pmbus_regulator_get_error_flags() will also acquire the update_lock,
> thus unlock the mutex before trying to lock it again from within
> the same thread.
> 
> Fixes a deadlock when trying to read the regulator status.
> 

The idea was that the lock would cover both pmbus_get_status()
and pmbus_regulator_get_error_flags() to avoid inconsistencies.
This change defeats that purpose.

> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 30aeb59062a5..42f4250c53ed 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2949,37 +2949,27 @@ static int pmbus_regulator_get_status(struct regulator_dev *rdev)
>  
>  	mutex_lock(&data->update_lock);
>  	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> -	if (status < 0) {
> -		ret = status;
> -		goto unlock;
> -	}
> +	mutex_unlock(&data->update_lock);
> +	if (status < 0)
> +		return status;
>  
> -	if (status & PB_STATUS_OFF) {
> -		ret = REGULATOR_STATUS_OFF;
> -		goto unlock;
> -	}
> +	if (status & PB_STATUS_OFF)
> +		return REGULATOR_STATUS_OFF;
>  
>  	/* If regulator is ON & reports power good then return ON */
> -	if (!(status & PB_STATUS_POWER_GOOD_N)) {
> -		ret = REGULATOR_STATUS_ON;
> -		goto unlock;
> -	}
> +	if (!(status & PB_STATUS_POWER_GOOD_N))
> +		return REGULATOR_STATUS_ON;
>  
>  	ret = pmbus_regulator_get_error_flags(rdev, &status);

Why not just call _pmbus_get_flags() here instead ?

Guenter

>  	if (ret)
> -		goto unlock;
> +		return ret;
>  
>  	if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
>  	   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL | REGULATOR_ERROR_OVER_TEMP)) {
> -		ret = REGULATOR_STATUS_ERROR;
> -		goto unlock;
> +		return REGULATOR_STATUS_ERROR;
>  	}
>  
> -	ret = REGULATOR_STATUS_UNDEFINED;
> -
> -unlock:
> -	mutex_unlock(&data->update_lock);
> -	return ret;
> +	return REGULATOR_STATUS_UNDEFINED;
>  }
>  
>  static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
