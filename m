Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809D2776EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjHJEDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHJEDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:03:22 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3672AFD;
        Wed,  9 Aug 2023 21:03:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-78bb7b89cabso16556639f.1;
        Wed, 09 Aug 2023 21:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691640201; x=1692245001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X4weC6EmV/6BRjaDA/sQHx2C0WkVUVfjxnnNcvUVsk=;
        b=fcqkUZT+3UlpGQfJpKbu2UooRRNtzslQLImGAYbzxjz7l/8+7dnlKqv9nbsR/r0wqD
         PZ7hv6q3sxCMBAQrrU6cKOYXI/9vgnEXMl0cFSwQi/yCSemfBZXFtvrpeEBqEzmBpJNg
         mi/BK5M6I7MyA+t0MI+iFvYYnU/MxDJkW35LZBi61l28f47OWa2MsS23WO5kJVy5rrvX
         Y36wQCxJIsQShzgGliHYpKwfdw1VN67XqDTgbyxQJjTxU5E607RyC09qHVjHdgCwezlL
         jEMpSH91Y0VRvFlYBUu9rneNA079g0VODQoinGLug4nO1I22fTyyIQ2DiEWdNnZVe2ml
         +6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640201; x=1692245001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9X4weC6EmV/6BRjaDA/sQHx2C0WkVUVfjxnnNcvUVsk=;
        b=hkffefen1akY+KqDcT9y6YEDN16V39IT7AFwiGSM9sQnN73pN/RZeSjYoyh3d+5oNl
         pzKjH+oR5UhUvTKsBnbHcaLauJdg3Y7NK/OeQCCc163qQj1PDS5EzHOQVijYBxE7TxKp
         ZtvnJenRnxVZHUKiaKT+H9lXzKo1OSXr7d1YW9HYx237aBIgS7M0NCoXQ4aryGtLB6yb
         R9o9VoP+j2rFqnlEMdn8OkNGMCvZ/iX697Suc+06QmCE78AGzuteBLLn8Xbr0mREkmI2
         mE+/DhvbVIQRnEi+glLJI1uxwDlOfb5xtPk82FsNvLl45esw+a2zM/YeZ3QYBOWAK6vI
         TSPQ==
X-Gm-Message-State: AOJu0YwUUGkfdXVUv64wbUiYpJRQU93NfhENYlbjNufcoswNTLPa7NzG
        Vr4+n2OQemXkt2MwkwUh0qzZk4Kw/gM=
X-Google-Smtp-Source: AGHT+IF3+HVSaWE0jLkUL97mTYSLvykSHqqosBViMOn98lH1Tks5Yhr6WQNkJcymoK92+mO/7UxbFQ==
X-Received: by 2002:a5e:8912:0:b0:780:c787:637b with SMTP id k18-20020a5e8912000000b00780c787637bmr1664775ioj.0.1691640201508;
        Wed, 09 Aug 2023 21:03:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v5-20020a02cba5000000b0042ad6abe0bbsm165685jap.20.2023.08.09.21.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 21:03:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 9 Aug 2023 21:03:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     krzysztof.kozlowski+dt@linaro.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (max6639) Add compatible string
Message-ID: <eb7101f6-0bfe-4e43-bb12-3be86692d8da@roeck-us.net>
References: <20230803144401.1151065-1-Naresh.Solanki@9elements.com>
 <20230803144401.1151065-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803144401.1151065-2-Naresh.Solanki@9elements.com>
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

On Thu, Aug 03, 2023 at 04:44:00PM +0200, Naresh Solanki wrote:
> Use maxim,max6639 as compatible string for the driver.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

Applied to hwmon-next, but please consider updating your e-mail
addresses to either all say Naresh.Solanki@9elements.com or
naresh.nolanki@9elements.com to avoid nuisance checkpatch
warnings in the future.

Thanks,
Guenter

> ---
> Changes in V3:
> - None
> Changes in V2:
> - None, Updated DT patch
> ---
>  drivers/hwmon/max6639.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index caf527154fca..aa7f21ab2395 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -618,11 +618,17 @@ MODULE_DEVICE_TABLE(i2c, max6639_id);
>  
>  static DEFINE_SIMPLE_DEV_PM_OPS(max6639_pm_ops, max6639_suspend, max6639_resume);
>  
> +static const struct of_device_id max6639_of_match[] = {
> +	{ .compatible = "maxim,max6639", },
> +	{ },
> +};
> +
>  static struct i2c_driver max6639_driver = {
>  	.class = I2C_CLASS_HWMON,
>  	.driver = {
>  		   .name = "max6639",
>  		   .pm = pm_sleep_ptr(&max6639_pm_ops),
> +		   .of_match_table = max6639_of_match,
>  		   },
>  	.probe = max6639_probe,
>  	.id_table = max6639_id,
