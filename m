Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A840781CAF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjHTGb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjHTGbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:31:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010B92120E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 23:24:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso291495166b.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692512660; x=1693117460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=joLgLL1PJeNBYVJ1vdHU5vdt5oa9jpreW5jsUy4YGmw=;
        b=Ym/WkQc3DaAmwTEY/w0L8y29ougMW9IOz9Ol6pw9gVLPQVplWvTpfeBvYTK4YyADJt
         U7esD7gJD354LFpM8UlIbVALTXv5lvSe4r9EOel+gMG/KU/pLcnrFuNAGrenWWhVI66k
         /8XBtitBUZXuy652oJopfBsTRFMbG98hJoe5w8RAuUlDk5uj5X5hb4hVQutGXeUnErOL
         IuXz5J2nE6CefMjWvGH7nC7r9Cq9aVEsp0OW5VECNZJTT9csZ1PkMqGI1y78CsJwHZUQ
         c5l3Z8RmxQgHOd0yyIwMUSNEdky0rreZfevL8rMInO8sPXjnGpjNcEsM90/cvLIZCfhA
         mM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692512660; x=1693117460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=joLgLL1PJeNBYVJ1vdHU5vdt5oa9jpreW5jsUy4YGmw=;
        b=bR6c4pFmWkJhIPwMkeXTplmLfOaF39lLi1RX5kFI5MQ7qY4fdIGYWq19BZhs5u1fb3
         1OxpmbNrKEmJWW3UQ7WLAQ4+1jdqTtTrQNpX0rqLP9/waJKfHXOT4jgROxZig3GdATp6
         gfu8Wrma6NKs+gIF49+WKqqgaF17MPvlte6BzMiRhRkzoxxYA052cfffucG3entVYLmG
         5NB4KWmzTEwHbYanoXi/ZIboAzSrsl0+pU8ZKJOBVppjuSc6EjFYecU2yzXPnlir6ZNB
         aytcZ9E6p6Yu4d+LVZwk/WCUOe6jrQAVSGWslYmHHspXxImOW6ntITBH6DjYpIJKIgaz
         5iPA==
X-Gm-Message-State: AOJu0YxVI0u2NaIeGCKx1mJH7DEZ7QGuliGRWnGcF4CiRuKXrPvYIONX
        +MWGEs8O0YctE04PnlTZ/Dnv2w==
X-Google-Smtp-Source: AGHT+IEXzXHWO65GWmnQ4NiP0DImCrr2SQNIoQJOUj1oPQV6MhaCWuuQqfH18Ua9Noffj1moWLI2mQ==
X-Received: by 2002:a17:906:3051:b0:99c:f47a:2354 with SMTP id d17-20020a170906305100b0099cf47a2354mr2686060ejd.70.1692512660451;
        Sat, 19 Aug 2023 23:24:20 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id q20-20020a17090622d400b0099cce6f7d50sm4034493eja.64.2023.08.19.23.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 23:24:19 -0700 (PDT)
Message-ID: <a13e829e-f238-41e8-1877-50c8cf009547@linaro.org>
Date:   Sun, 20 Aug 2023 08:24:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/2] USB: typec: Add TI TPS25750 USB Type-C controller
Content-Language: en-US
To:     Abdel Alkuor <alkuor@gmail.com>, heikki.krogerus@linux.intel.com,
        devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abdelalkuor@geotab.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1692507038.git.abdelalkuor@geotab.com>
 <9ad92e760e67dfdc740f5b0a32a9c1dbb2342fed.1692507038.git.abdelalkuor@geotab.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9ad92e760e67dfdc740f5b0a32a9c1dbb2342fed.1692507038.git.abdelalkuor@geotab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 07:23, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> TPS25750 is USB Type-C controller and Power Delivery controller.
> 
> TPS25750 needs to be configured after a cold reset. The configuration
> can be applied either from an external EEPROM connected to the
> controller or by a host using I2C. TI provides an online GUI that
> can be used to generate the configuration binary.
> Tool link: https://tinyurl.com/2s3watcm
> P.S. It requires a TI account to be able to use the tool.
> 
...


> +
> +static void tps25750_remove(struct i2c_client *client)
> +{
> +	struct tps25750 *tps = i2c_get_clientdata(client);
> +
> +	tps25750_disconnect(tps, 0);
> +	typec_unregister_port(tps->port);
> +	usb_role_switch_put(tps->role_sw);
> +
> +	/* clear the patch by a hard reset */
> +	tps25750_exec_normal_cmd(tps, TPS_4CC_GAID);
> +}
> +
> +static int __maybe_unused tps25750_suspend(struct device *dev)
> +{
> +	/* TODO: should we remove the patch? */
> +	return 0;
> +}
> +
> +static int __maybe_unused tps25750_resume(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct tps25750 *tps = i2c_get_clientdata(client);
> +
> +	/* The controller needs to be reinitialized again

Format is:

/*
 * The....

> +	 * if it is powered off as config is not persisted
> +	 */
> +	return tps25750_init(tps);
> +}
> +
> +static const struct dev_pm_ops tps25750_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(tps25750_suspend, tps25750_resume)
> +};
> +
> +static const struct of_device_id tps25750_of_match[] = {
> +	{ .compatible = "ti,tps25750", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tps25750_of_match);
> +
> +static const struct i2c_device_id tps25750_id[] = {
> +	{ "tps25750" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tps25750_id);
> +
> +static struct i2c_driver tps25750_i2c_driver = {
> +	.driver = {
> +		.name = "tps25750",
> +		.pm = pm_ptr(&tps25750_pm_ops),
> +		.of_match_table = of_match_ptr(tps25750_of_match),

Drop of_match_ptr(). It will cause warnings.

> +	},
> +	.probe_new = tps25750_probe,
> +	.remove = tps25750_remove,
> +	.id_table = tps25750_id,
> +};
> +module_i2c_driver(tps25750_i2c_driver);


Best regards,
Krzysztof

