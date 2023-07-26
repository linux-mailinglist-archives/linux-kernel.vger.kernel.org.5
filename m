Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F017637DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjGZNoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjGZNoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:44:02 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1435226A2;
        Wed, 26 Jul 2023 06:43:59 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-78625caa702so258134439f.1;
        Wed, 26 Jul 2023 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690379038; x=1690983838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6RozXNlQIbFbg5pC8dau61J8871NJ1Uqfh1ZnuL9+I=;
        b=X076srfFhD6s6yNddnTQ1Ns5PmbMuawF8wgUnBLnoJCUUajU/vqMfXR2pL7hVre6gD
         N5M8bux9l1hppPIQsqpDIP8i7IO7NRK7Kg3GEWpCqycdWPnsh+GxVnSRtyebJsgXSP5W
         9ssSnVOKhqJ2+81JYIlygwYCgERR78Pcpf/nVpWlRUKoMjNis35fdEf4a4rkTt6mb+ub
         IyD9AVxYY24Fxwj7HZYYfwAz1DtgrA9L1ect5IxFvvdt1VYjttGjpgo6NsuzG8NHUYy2
         fMGZTz1UrXo7dT1W422xZUvQbcZlZYFbCJfD3GMUnBrKn2ckTUAQoVRmcOmf4pOxYwuG
         Y3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379038; x=1690983838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6RozXNlQIbFbg5pC8dau61J8871NJ1Uqfh1ZnuL9+I=;
        b=JX5p5UrJuV8q1M7Ni+a9FRVsN8lXx3s6Zuj+iJJiHT5aahRRBloO+UeIBYf/gl7i/f
         jPTEpjDvRLfJQRqD43lY01N2yygS8L3q1vIeQPFINYQSr1C+CueBZtjTDVrxIKL8PpV2
         tLfRvuVMnLuvorliDSYxE/wxUwdI69viFBshVP/BVfwQAGWWXMjIDkhAoquUO2Ec8+E7
         2XqPZBb+67ZYMqdzzakHpxcuMV2Dvn33wSAl3feslZ+fyB6ED7tI9C1mC4an6iL363Q+
         eV7xOG44Zq1vkKuFvWG7ZD1qFq9QrycgEGUhGTJ8eweSG/hgJlgmpGT+8w/fLV3xMhiJ
         gx4Q==
X-Gm-Message-State: ABy/qLah52NXU8zJY8rRCLjDI0Hho9yG96K5SgBrZ91lmrJ5dwKY1KKy
        rndhBpEEiYjtk53rwMoM1Oo=
X-Google-Smtp-Source: APBJJlGNXQA3agYOiMQnxC5Rqnsug+PZU/Hc23ObsiHORG67kpt7MS1Iet03hR0tCl2RHMtOJgMuJg==
X-Received: by 2002:a6b:904:0:b0:783:3957:9b46 with SMTP id t4-20020a6b0904000000b0078339579b46mr1881951ioi.13.1690379038246;
        Wed, 26 Jul 2023 06:43:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k22-20020a02ccd6000000b0042b4437d857sm4302524jaq.106.2023.07.26.06.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:43:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Jul 2023 06:43:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     werneazc@gmail.com
Cc:     jdelvare@suse.com, krzysztof.kozlowski+dt@linaro.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] hwmon: (hs3001) Fix unused variable compiler warning
Message-ID: <385499b6-6022-44d2-9073-b7c7893ddab7@roeck-us.net>
References: <11620112-ffe4-8df1-6b38-0f3082c5d16f@linaro.org>
 <20230726130648.23056-1-andre.werner@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726130648.23056-1-andre.werner@systec-electronic.com>
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

On Wed, Jul 26, 2023 at 03:06:02PM +0200, werneazc@gmail.com wrote:
> From: Andre Werner <andre.werner@systec-electronic.com>
> 
> Delete unused variable in drivers probe function.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307261819.VMDuxZOM-lkp@intel.com/
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>

Applied.

Thanks,
Guenter

> ---
> v2: Delete blank line between tags in commit message.
> ---
>  drivers/hwmon/hs3001.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hs3001.c b/drivers/hwmon/hs3001.c
> index 17c3455922eb..9972f6bbb22a 100644
> --- a/drivers/hwmon/hs3001.c
> +++ b/drivers/hwmon/hs3001.c
> @@ -193,7 +193,6 @@ static int hs3001_probe(struct i2c_client *client)
>  	struct hs3001_data *data;
>  	struct device *hwmon_dev;
>  	struct device *dev = &client->dev;
> -	int ret;
>  
>  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
>  		return -EOPNOTSUPP;
