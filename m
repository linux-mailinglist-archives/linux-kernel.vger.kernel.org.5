Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2E781FA9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHTT6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjHTT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:58:35 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C6B46B5;
        Sun, 20 Aug 2023 12:56:04 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64c2e2572f7so13835316d6.1;
        Sun, 20 Aug 2023 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692561363; x=1693166163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=65VaV5gCUA/UvHnVI3TmiZIS5JSl1bSmfSgKQUoax38=;
        b=Atm8X5glEZA9NqRTTfrqyDhBwRxwCTnRaQfAZXe81CHAjNdP4kEOOT+kucFHLE6fhY
         VAbSe9oxJ+RRxsQ/l6N4T/atrYz8PS14LboBNcwpeuyfNIhCPtfr6/gvwJ93S2KnFvMR
         QA8QfQo04RpqSXPnTzaSWZ1htbYNRcGkVmq7vfzBizUvm5OKcYV5BbLRckvtDltvWFJO
         dwJPrGYqE1QetTbceEKeF4eWjoprxqR8050Vl7OTKYIXQhSkXj1ifUQBcTSwcDOoIA81
         GMQYfQ8fgzdMK+dpii64EwaN3a6qLFhuUdrzmvuRcus2stbYACs7UwU0CqfgXCdMd/30
         Z4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692561363; x=1693166163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65VaV5gCUA/UvHnVI3TmiZIS5JSl1bSmfSgKQUoax38=;
        b=V0g2sLF5e+9JCVm7OxC1Jkj1bJ2nMVwmhYgFAJO6kTm9KOPmdJiwbZ4/oM17g3t18z
         oinZokHUnDTLPxi4zAeU4tbT5wRhemVszhIxTZDcA3U+2dCqnyARsjndXEd3ENdKAEl2
         LgimPof6UUVVfev5Ni07AQBtRgos8pQ2DqNSYDnX0TffEHMPTqSHBVc+/EWTmo3+mxbv
         L95lhT31a5VbZJ8pCFv3UvfNKb6QcqKNmLHYlbPtJyakRKYMRmHJuuKvhb7DboJ8SenT
         b8d2I7CRXi+MSk0y8IakRmuNEJL1ELT1179aOKdiHLMxphd38eI4ZxvHSEDRd+j0cBP3
         bU8g==
X-Gm-Message-State: AOJu0Yxji+QcmhUqVOrMdgEUuKkeGu5Sczs92AhaePW/GApwy4Y+Z1kP
        E9diBcPqXLXTsp2i2T8dOlMfTHon7xTrgQ==
X-Google-Smtp-Source: AGHT+IEbqcyDQKwW1ZQVhhp/XdJHc4lHwG1v9CEvnqxLXGTbMx1evjRyW5PUYureHwi8c1voKE8uNA==
X-Received: by 2002:a0c:ef02:0:b0:641:8b09:98ac with SMTP id t2-20020a0cef02000000b006418b0998acmr4902687qvr.37.1692561363459;
        Sun, 20 Aug 2023 12:56:03 -0700 (PDT)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id m17-20020a0cdb91000000b0063d3744c5c5sm2373897qvk.5.2023.08.20.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 12:56:02 -0700 (PDT)
Date:   Sun, 20 Aug 2023 15:55:52 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, abdelalkuor@geotab.com
Subject: Re: [PATCH v3 2/2] USB: typec: Add TI TPS25750 USB Type-C controller
Message-ID: <ZOJvyMMgu0sN8jGM@abdel>
References: <cover.1692507038.git.abdelalkuor@geotab.com>
 <9ad92e760e67dfdc740f5b0a32a9c1dbb2342fed.1692507038.git.abdelalkuor@geotab.com>
 <a13e829e-f238-41e8-1877-50c8cf009547@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a13e829e-f238-41e8-1877-50c8cf009547@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 08:24:18AM +0200, Krzysztof Kozlowski wrote:
> On 20/08/2023 07:23, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > TPS25750 is USB Type-C controller and Power Delivery controller.
> > 
> > TPS25750 needs to be configured after a cold reset. The configuration
> > can be applied either from an external EEPROM connected to the
> > controller or by a host using I2C. TI provides an online GUI that
> > can be used to generate the configuration binary.
> > Tool link: https://tinyurl.com/2s3watcm
> > P.S. It requires a TI account to be able to use the tool.
> > 
> ...
> 
> 
> > +
> > +static void tps25750_remove(struct i2c_client *client)
> > +{
> > +	struct tps25750 *tps = i2c_get_clientdata(client);
> > +
> > +	tps25750_disconnect(tps, 0);
> > +	typec_unregister_port(tps->port);
> > +	usb_role_switch_put(tps->role_sw);
> > +
> > +	/* clear the patch by a hard reset */
> > +	tps25750_exec_normal_cmd(tps, TPS_4CC_GAID);
> > +}
> > +
> > +static int __maybe_unused tps25750_suspend(struct device *dev)
> > +{
> > +	/* TODO: should we remove the patch? */
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused tps25750_resume(struct device *dev)
> > +{
> > +	struct i2c_client *client = to_i2c_client(dev);
> > +	struct tps25750 *tps = i2c_get_clientdata(client);
> > +
> > +	/* The controller needs to be reinitialized again
> 
> Format is:
> 
> /*
>  * The....
>
Fixed all mult-line comments in v4.
> > +	 * if it is powered off as config is not persisted
> > +	 */
> > +	return tps25750_init(tps);
> > +}
> > +
> > +static const struct dev_pm_ops tps25750_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(tps25750_suspend, tps25750_resume)
> > +};
> > +
> > +static const struct of_device_id tps25750_of_match[] = {
> > +	{ .compatible = "ti,tps25750", },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, tps25750_of_match);
> > +
> > +static const struct i2c_device_id tps25750_id[] = {
> > +	{ "tps25750" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, tps25750_id);
> > +
> > +static struct i2c_driver tps25750_i2c_driver = {
> > +	.driver = {
> > +		.name = "tps25750",
> > +		.pm = pm_ptr(&tps25750_pm_ops),
> > +		.of_match_table = of_match_ptr(tps25750_of_match),
> 
> Drop of_match_ptr(). It will cause warnings.
>
Removed in v4.
> > +	},
> > +	.probe_new = tps25750_probe,
> > +	.remove = tps25750_remove,
> > +	.id_table = tps25750_id,
> > +};
> > +module_i2c_driver(tps25750_i2c_driver);
> 
> 
> Best regards,
> Krzysztof
>

Thanks,
Abdel
