Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077D5758B72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGSCml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGSCmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:42:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B4FC;
        Tue, 18 Jul 2023 19:42:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55ba5fae2e6so4892768a12.0;
        Tue, 18 Jul 2023 19:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689734557; x=1692326557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5KOrbgJn78bTaSZL6HNIplSuIpotz6ofRA91y3cvtM=;
        b=KvWWPaAocCd+Taia0CPls6QtQ0nt1ZcRwIc21kFg7D7FFKu5LfqL+B1NwglFZ1aGal
         E05D6qJCjpUzeRUf1dR0EJMvf4nk02RdZK1JUR6+bHUu4nA2de6OhF9Kz/CfW1e9nOeG
         y+7amJ/3uftK4jH+i0Xs9vXIbhyl5j9BRC0mhC2EHvlSiNszusM6n08FKvuHBxTDWe8E
         XHkxyJArYSKNXpqo1pyOnaavHhTeDxQodBx9xR5XSqJOplczUMVrTsls7s30hY88damW
         Nx/gFCZY2dD933T3Ps9j+rh+jaGaiHE+CeIh2Tv8zj7Ve3boYh183awn6Fg1Jvy8bDvx
         d6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689734557; x=1692326557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5KOrbgJn78bTaSZL6HNIplSuIpotz6ofRA91y3cvtM=;
        b=OnTfjUIS1XBCrboZxRf3PLouDxn0vtBHQWDp40V3S6ChyAPjnLqjCJFJu2m1OUFuxM
         OuN3CEHUVwzDsI9b/XmY3pcuQ13WIgYow8MGOW6hVv42Zf2anxm5F5lb5QE3Ux+fdvRK
         o6qz+6b8+PbFHHd+8cbntGs11a5b+OfQEDOOflKyZettPKUE7Plp8OWl5eQieK1hoagx
         oMMxk0OMffyUxMNq+RlBxeU2RkvrjgLSCVslLUzxnqOyxiinDjskGfvpcmy3/jKeiwJS
         vNiqFStfHA6eS7h/UpgvrQu1uMEACh+kwYZ7G7h39Uw9O3svRgk2l2gTJKBxm270c5ai
         +8zw==
X-Gm-Message-State: ABy/qLaFMzhYdr8FDPpDmtc1CgG8TsHLIWqWN4OBX2FXwbHyAi1H3YS1
        83ghalMVHduKw1pFl7GkhsuGWDitJGs=
X-Google-Smtp-Source: APBJJlFdqrXk/9r5QOqLM9yYG1yJC1ES9jplTjdlSsAIZVtvd13RWgu5TP2rnFJybqrecuBRQBI6vw==
X-Received: by 2002:a05:6a20:918e:b0:134:b28f:b58a with SMTP id v14-20020a056a20918e00b00134b28fb58amr1426754pzd.7.1689734557481;
        Tue, 18 Jul 2023 19:42:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001b83db0bcf2sm2572446pla.141.2023.07.18.19.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 19:42:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 18 Jul 2023 19:42:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] hwmon: (oxp-sensors) Move tt_toggle attribute to
 dev_groups
Message-ID: <bf0f1dc5-35b8-4a72-be11-692e82fe6ab9@roeck-us.net>
References: <20230717222526.229984-1-samsagax@gmail.com>
 <20230717222526.229984-2-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230717222526.229984-2-samsagax@gmail.com>
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

On Mon, Jul 17, 2023 at 07:25:15PM -0300, Joaquín Ignacio Aramendía wrote:
> A driver should not be manually adding groups in its probe function (it will
> race with userspace), so replace the call to devm_device_add_groups() to use
> the platform dev_groups callback instead.
> 
> This will allow for removal of the devm_device_add_groups() function.
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/oxp-sensors.c | 38 +++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index e1a907cae820..1e1cc67bcdea 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -220,6 +220,20 @@ static int tt_toggle_disable(void)
>  }
>  
>  /* Callbacks for turbo toggle attribute */
> +static umode_t tt_toggle_is_visible(struct kobject *kobj,
> +				    struct attribute *attr, int n)
> +{
> +	switch (board) {
> +	case aok_zoe_a1:
> +	case oxp_mini_amd_a07:
> +	case oxp_mini_amd_pro:
> +		return attr->mode;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
>  static ssize_t tt_toggle_store(struct device *dev,
>  			       struct device_attribute *attr, const char *buf,
>  			       size_t count)
> @@ -396,7 +410,15 @@ static struct attribute *oxp_ec_attrs[] = {
>  	NULL
>  };
>  
> -ATTRIBUTE_GROUPS(oxp_ec);
> +static struct attribute_group oxp_ec_attribute_group = {
> +	.is_visible = tt_toggle_is_visible,
> +	.attrs = oxp_ec_attrs,
> +};
> +
> +static const struct attribute_group *oxp_ec_groups[] = {
> +	&oxp_ec_attribute_group,
> +	NULL
> +};
>  
>  static const struct hwmon_ops oxp_ec_hwmon_ops = {
>  	.is_visible = oxp_ec_hwmon_is_visible,
> @@ -415,7 +437,6 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  	const struct dmi_system_id *dmi_entry;
>  	struct device *dev = &pdev->dev;
>  	struct device *hwdev;
> -	int ret;
>  
>  	/*
>  	 * Have to check for AMD processor here because DMI strings are the
> @@ -430,18 +451,6 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  
>  	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
>  
> -	switch (board) {
> -	case aok_zoe_a1:
> -	case oxp_mini_amd_a07:
> -	case oxp_mini_amd_pro:
> -		ret = devm_device_add_groups(dev, oxp_ec_groups);
> -		if (ret)
> -			return ret;
> -		break;
> -	default:
> -		break;
> -	}
> -
>  	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
>  						     &oxp_ec_chip_info, NULL);
>  
> @@ -451,6 +460,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
>  static struct platform_driver oxp_platform_driver = {
>  	.driver = {
>  		.name = "oxp-platform",
> +		.dev_groups = oxp_ec_groups,
>  	},
>  	.probe = oxp_platform_probe,
>  };
