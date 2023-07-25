Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62092762413
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGYVCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjGYVCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:02:47 -0400
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78514F5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:02:45 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id OPAzqClnw1d2aOPAzqO6Qd; Tue, 25 Jul 2023 23:02:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1690318962;
        bh=nkQ74CLtd9z0A/xmDW80xpHVujKaMTsHCLvN52AI+kQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BI/3ze1WDYB6B3HbHDeTVuGDMKPe8SLnC8Mslv6Y3Whh9NOpDtu8WXaHi7h2Nbm24
         h2MfFIhTpsqT7js9r1Awwjc2mihbKmyHlCn+0Hb5irpP4HAu6ALL5VZr1+niNRvpWT
         1jYhUxBhR0ow2JkN8XaX0WoVucKu6avcRFBA//X1BKmps6NHDRyDEedraTOaa88vmI
         /cwjOJAUKipjsmDXgpgr54jKiaD9Bbv8QZuOwHkcLV3eCnow8CDQczL8pUfrDGnDwe
         /3k/0SIS3YfujCiSiJy+oBlU+mctzK8dmzYGItw+bK7+5TK7fVsHHAGBcm0i7wyWgd
         b/GO9GGkg7lwQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 Jul 2023 23:02:42 +0200
X-ME-IP: 86.243.2.178
Message-ID: <fb62b2e7-7c7c-dc2e-768d-3393f151eb32@wanadoo.fr>
Date:   Tue, 25 Jul 2023 23:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Add Silicom Platform Driver
Content-Language: fr
To:     Henry Shi <henryshi2018@gmail.com>, hbshi69@hotmail.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        hdegoede@redhat.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
References: <20230718160104.2716-1-henryshi2018@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230718160104.2716-1-henryshi2018@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/07/2023 à 18:01, Henry Shi a écrit :
> The Silicom platform (silicom-platform) Linux driver for Swisscom
> Business Box (Swisscom BB) as well as Cordoba family products is a
> software solution designed to facilitate the efficient management
> and control of devices through the integration of various Linux
> frameworks. This platform driver provides seamless support for
> device management via the Linux LED framework, GPIO framework,
> Hardware Monitoring (HWMON), and device attributes. The Silicom
> platform driver's compatibility with these Linux frameworks allows
> applications to access and control Cordoba family devices using
> existing software that is compatible with these frameworks. This
> compatibility simplifies the development process, reduces
> dependencies on proprietary solutions, and promotes
> interoperability with other Linux-based systems and software.
> 
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> ---

[...]

> +static int __init silicom_mc_leds_register(struct device *dev,
> +					   const struct led_classdev_mc *mc_leds)
> +{
> +	struct led_classdev_mc *led;
> +	int i, err;
> +
> +	for (i = 0; mc_leds[i].led_cdev.name; i++) {
> +		/* allocate and copy data from the init constansts */
> +		led = devm_kzalloc(dev, sizeof(struct led_classdev_mc), GFP_KERNEL);

sizeof(*led) is shorter.
Mostly a matter of taste.

Maybe even devm_kmemdup()?

> +		if (IS_ERR_OR_NULL(led)) {

if (!led)
is enough.

> +			dev_err(dev, "Failed to alloc led_classdev_mc[%d]: %ld\n", i, PTR_ERR(led));

This kind of message is useless and should be removed (checkpatch should 
warn about it)

> +			return -ENOMEM;
> +		}
> +		memcpy(led, &mc_leds[i], sizeof(*led));
> +
> +		led->subled_info = devm_kzalloc(dev, led->num_colors * sizeof(struct mc_subled),
> +						GFP_KERNEL);

Maybe even devm_kmemdup()?

> +		if (IS_ERR_OR_NULL(led->subled_info)) {

if (!led->subled_info)
is enough.

> +			dev_err(dev, "Failed to alloc subled_info[%d]: %ld\n",
> +				i, PTR_ERR(led->subled_info));

This kind of message is useless and should be removed (checkpatch should 
warn about it)

> +			return -ENOMEM;
> +		}
> +		memcpy(led->subled_info, mc_leds[i].subled_info,
> +			led->num_colors * sizeof(struct mc_subled));
> +
> +		err = devm_led_classdev_multicolor_register(dev, led);
> +		if (err) {
> +			dev_err(dev, "Failed to register[%d]: %d\n", i, err);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}

[...]

