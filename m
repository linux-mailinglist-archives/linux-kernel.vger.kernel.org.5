Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3775480B34C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 09:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjLIImv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 03:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLIImt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 03:42:49 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7B7D5B
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 00:42:54 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id BsvCrcsGt8sqPBsvCrXaRV; Sat, 09 Dec 2023 09:42:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702111372;
        bh=OL7jJBAHp3+DKzbCvIViVa6sqM1F9KNTat4GEYWo3l4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=f36WZ639mb34IksRNaZ5zgh56e30qvgeiG2HRFdG0qifwbk17zBUE5ybPQoK4APa/
         xbOQXM3oS8EEZG3+9TrPSXWbDFOYAUR5Ujf51ci7KTOcppfu5PD05hjq1c+qKtK7Tb
         k7G/NoiUyKnWc7qJBprEVoQLjAwaftR///q5FLcljBNG1UdCPBGYsfkABYnL96sAHx
         HEUGdL8lF5Zk7GorqLnf2l5dDaMnXSh8iSmxChgR9cf7H+FYQ1lIJtWHlJpXKJh2yT
         0HXQqCJjL0cRNQmksacxES8XH3nBxSYeN1RnzG3fpcQDbz7LaMV0Ka6rsnAqOM0Z+u
         1owR75wXIe9Xw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Dec 2023 09:42:52 +0100
X-ME-IP: 92.140.202.140
Message-ID: <02a2787a-1fb9-4238-820b-c3b1e8460e5a@wanadoo.fr>
Date:   Sat, 9 Dec 2023 09:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: typec: mux: add Qualcomm WCD939X USB SubSystem
 Altmode Mux driver
Content-Language: fr
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231208-topic-sm8650-upstream-wcd939x-usbss-v1-0-91d1ba680fe0@linaro.org>
 <20231208-topic-sm8650-upstream-wcd939x-usbss-v1-2-91d1ba680fe0@linaro.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231208-topic-sm8650-upstream-wcd939x-usbss-v1-2-91d1ba680fe0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/12/2023 à 16:27, Neil Armstrong a écrit :
> Qualcomm WCD9390/WCD9395 is a standalone Hi-Fi audio codec IC with a
> functionally separate USB SubSystem for Altmode/Analog Audio Switch
> accessible over an I2C interface.
> 
> It provides switching USB-C USB2.0 lines between USB and Audio Headphones
> speaker lines, and the USB-C SBU lines between DisplayPort AUX and Audio
> Headphones Microphone/Ground.
> 
> The Audio Headphone and Microphone data path between the Codec and the
> USB-C Mux subsystems are external to the IC, thus requiring DT
> port-endpoint graph description to handle USB-C altmode & orientation
> switching for Audio Accessory Mode.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

...

> +	usbss->sw = typec_switch_register(dev, &sw_desc);
> +	if (IS_ERR(usbss->sw)) {
> +		ret = dev_err_probe(dev, PTR_ERR(usbss->sw), "failed to register typec switch\n");
> +		goto err_regulator_disable;
> +	}
> +
> +	mux_desc.drvdata = usbss;
> +	mux_desc.fwnode = dev_fwnode(dev);
> +	mux_desc.set = wcd939x_usbss_mux_set;
> +
> +	usbss->mux = typec_mux_register(dev, &mux_desc);
> +	if (IS_ERR(usbss->mux)) {
> +		typec_switch_unregister(usbss->sw);

Already called at the 'err_switch_unregister' label below.

> +		ret = dev_err_probe(dev, PTR_ERR(usbss->mux), "failed to register typec mux\n");
> +		goto err_switch_unregister;
> +	}
> +
> +	i2c_set_clientdata(client, usbss);
> +
> +	return 0;
> +
> +err_switch_unregister:
> +	typec_switch_unregister(usbss->sw);
> +
> +err_regulator_disable:
> +	regulator_disable(usbss->vdd_supply);
> +
> +err_mux_switch:
> +	typec_switch_put(usbss->codec_switch);
> +
> +err_mux_put:
> +	typec_mux_put(usbss->codec);
> +
> +	return ret;
> +}
> +
> +static void wcd939x_usbss_remove(struct i2c_client *client)
> +{
> +	struct wcd939x_usbss *usbss = i2c_get_clientdata(client);
> +
> +	typec_mux_unregister(usbss->mux);
> +	typec_switch_unregister(usbss->sw);
> +
> +	regulator_disable(usbss->vdd_supply);

Based on error hadling of the probe: typec_switch_put() missing?

> +
> +	typec_mux_put(usbss->codec);
> +}

CJ

