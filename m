Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC41781982
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjHSMWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjHSMWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:22:03 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8728A5EC;
        Sat, 19 Aug 2023 05:19:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-688731c6331so1387298b3a.3;
        Sat, 19 Aug 2023 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692447562; x=1693052362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zi3fLIF3cGkVGZeEalT4geZlr93ZgMT5amDrzmJ86OY=;
        b=At99HNtuapecOOibNo6Xw4mNJPidJtHCQdgdpFupob2NHTpTOp/Tp6KL4z80/bpX6N
         hPHMs0A9SkMEZo7SuqLoG51Rn+Ro1MPk3R93YBnRb8lUw9j4G0++aedCJ6UF+i9bZ6vc
         KGFwu5fZHQtm+9/8XVlUvRYIrjX2mHkbSESMLQPf1TIOYP6Yyaz95ym7bCn1bxHrzg4b
         U+Wc7wnrEdy85xtmT8bNRxGmSE0FPucw3K4me3GQaa7K4ru7YWKtmDu8K8XpEazoakVi
         7q5pWzshLb6W96IzAdrAwQL5PxvpAkhVMm0yVAE60HHm6UcVYXFZjApLzeLgFmWQbrNQ
         8bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692447562; x=1693052362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zi3fLIF3cGkVGZeEalT4geZlr93ZgMT5amDrzmJ86OY=;
        b=BdhrE0NAM93L6mvoVKlhPWrhZj2E7a/yHLmLDTt5kV/UyFjUvequWENn65QpH1Ltku
         1jo4I3nEfFDm25av0x1a/IXbWf7MsK+RHcsVlyTUWgFpgnJIKTL1bZM0B31u/lHC4h0j
         kXEb7wMknZ9muXz14HufCxOW+Zlu+aJq2KYet/5JSJTaTFlDdMvX0oyL/rDVRTy8VX4e
         oU27kFTwVMtXZcJIPr5R1dLCXr7n255EN82uzEdN6sSw0UCxXVT/gJiDbb23vlejQ17a
         w7JYsUgUEyZpTKBhQLUdI6iLGT3heIrW7hn0ibrCdx93SUD6BGgX4cpAVcyKWoFvPqYT
         20GA==
X-Gm-Message-State: AOJu0YzBn9rHg0YPGyHCfhRdKPGWOxw1LUxMdHOvrNR0F6NqLtY8+6Fu
        YimgOMweKR2hTmU2ROisDOTwj9mrutY=
X-Google-Smtp-Source: AGHT+IH2ZoDgEZsGdXUAYiSmLcOV0RHSayrQCyb1RFijJsXGT/RtxCGa9Llls0ynFR1Z+OASSf283w==
X-Received: by 2002:a05:6a20:8f09:b0:137:2281:944f with SMTP id b9-20020a056a208f0900b001372281944fmr1738987pzk.40.1692447562160;
        Sat, 19 Aug 2023 05:19:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902ac8800b001b80de83b10sm3506628plr.301.2023.08.19.05.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 05:19:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Aug 2023 05:19:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: pmbus: Fix -EIO seen on pli1209
Message-ID: <bc0f5e1a-36f9-491b-a4e5-03dc4441976c@roeck-us.net>
References: <20230817092527.808631-1-Naresh.Solanki@9elements.com>
 <20230817092527.808631-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817092527.808631-3-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:25:26AM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> After doing performance optimizations the pli1209 driver failed to
> probe with a probabilty of 2%. It wasn't able to read the PMBUS_OPERATION
> register due to an -EIO error.
> 
> An investigation showed that the PLI1209 takes 230 usec to execute the
> CLEAR_FAULTS command. During that time it's busy and NACKs all requests
> on the SMBUS interface. It also NACKs reads on PMBUS_STATUS_BYTE
> making it impossible to poll the BUSY flag.
> 
> Add a custom write_data function to just wait for not BUSY unconditionally
> after sending a CLEAR_FAULTS command.
> 
> TEST: Verified using an I2C bus analyser that no more NACKs are seen after
>       sending a CLEAR_FAULTS command.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/pmbus/pli1209bc.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pli1209bc.c b/drivers/hwmon/pmbus/pli1209bc.c
> index 7d8bd3167b21..c95433790b11 100644
> --- a/drivers/hwmon/pmbus/pli1209bc.c
> +++ b/drivers/hwmon/pmbus/pli1209bc.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2022 9elements GmbH
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/pmbus.h>
> @@ -53,6 +54,30 @@ static int pli1209bc_read_word_data(struct i2c_client *client, int page,
>  	}
>  }
>  
> +static int pli1209bc_write_byte(struct i2c_client *client, int page, u8 reg)
> +{
> +	int ret;
> +
> +	switch (reg) {
> +	case PMBUS_CLEAR_FAULTS:
> +		ret = pmbus_write_byte(client, page, reg);
> +		/*
> +		 * PLI1209 takes 230 usec to execute the CLEAR_FAULTS command.
> +		 * During that time it's busy and NACKs all requests on the
> +		 * SMBUS interface. It also NACKs reads on PMBUS_STATUS_BYTE
> +		 * making it impossible to poll the BUSY flag.
> +		 *
> +		 * Just wait for not BUSY unconditionally.
> +		 */
> +		usleep_range(250, 300);
> +		break;
> +	default:
> +		ret = -ENODATA;
> +		break;
> +	}
> +	return ret;
> +}
> +
>  #if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
>  static const struct regulator_desc pli1209bc_reg_desc = {
>  	.name = "vout2",
> @@ -102,6 +127,7 @@ static struct pmbus_driver_info pli1209bc_info = {
>  	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>  	    | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT,
>  	.read_word_data = pli1209bc_read_word_data,
> +	.write_byte = pli1209bc_write_byte,
>  #if IS_ENABLED(CONFIG_SENSORS_PLI1209BC_REGULATOR)
>  	.num_regulators = 1,
>  	.reg_desc = &pli1209bc_reg_desc,
