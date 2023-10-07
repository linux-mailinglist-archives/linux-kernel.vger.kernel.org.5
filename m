Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6E47BC8AA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 17:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjJGPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjJGPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 11:37:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76AFBA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 08:36:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317c3ac7339so2776787f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696693018; x=1697297818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xZba6X+aKTOLDEfwKhIa7yrx7NXyDPJ4bqJc+OxuDQ=;
        b=iM+oqokmR7r8fgcz6LM3DhKMU/wm6oKZvIDkT5F60yeZ6EycXh8DC79a/JdQy6H0fj
         wiex/NXBlyhJxL3sh+stoCYHibheCo3hw3PFUXXcx79Svyzk3JWXeRRcmwHpE75DFJYc
         u4ZKzOihHf5LxScZ84xiIe9aLIgdn4O5GY6yStk0tQNerFfr3t7nokS6rQYFRdZS8Pu7
         30yt0x89t1mvkpOyI4E7fQxvd3AjplL0GpFBLHCogcQ9v7DzItjBrwn4z2jyEgYGg6LS
         KaB6ZlOzDxSfPnn4wvSMqDn8vfa8YYF+9zKFhdWXfrezwRXIkeAsgGE0dt8EuaD/gHYJ
         5N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696693018; x=1697297818;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xZba6X+aKTOLDEfwKhIa7yrx7NXyDPJ4bqJc+OxuDQ=;
        b=YdRTkKGJoYbIo+hOipmhyGkctdKmihmy0KBNV4pSjI/HCpGZAjcMDa0vjN8wIDTlN4
         CnyJtqKbyIdES+AghlkYTS76D+c0pIJFZc8zCVSYQ8QjjjM1Cw5PVIzyq+tWsdpNPsFS
         rbqcctIlmG0Z5/zwxwbhJxbYjCPpjiXvwSkt7eGfdg/UWpGdvBJDeekX/wu5GhIM02Zf
         FoZHRiOCX35KA07RUobownSgDYK7xOP/6jGaUfLy+5MHfiKsSgyhvMEfmNyQwVClKveh
         a3qGD505Ya3ktoLYJVMY5khApL5ZEg6IJgIgBjkdQyU+88ATsJjPgm6xUcu4t5Nq4mlH
         E+0w==
X-Gm-Message-State: AOJu0YxrdBsCHCVMv/ps8oYxT4o21ssAtsqapZgPiXBRk57gJhE+Wr8K
        gXmQfcZ5a5ovfkKDdQNx0/x6BA==
X-Google-Smtp-Source: AGHT+IFe2rgb6dWE9FJ0bfkNFgsGR1xKXc24Vxh+YeI+CC3Wan0a0cZSzIvopTHGip0+1ymo6sFbtA==
X-Received: by 2002:adf:e8ca:0:b0:31f:e1b4:583d with SMTP id k10-20020adfe8ca000000b0031fe1b4583dmr11185601wrn.56.1696693018176;
        Sat, 07 Oct 2023 08:36:58 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id e8-20020adffc48000000b0031f3ad17b2csm4522101wrs.52.2023.10.07.08.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 08:36:57 -0700 (PDT)
Message-ID: <6b59155f-96d7-4d14-b08e-1ca1fa3c45ab@linaro.org>
Date:   Sat, 7 Oct 2023 17:36:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] media: i2c: Introduce a driver for the Techwell
 TW9900 decoder
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com
References: <cover.1696608809.git.mehdi.djait@bootlin.com>
 <857baa8073f0b8051720959ef8fb1d49a6161d36.1696608809.git.mehdi.djait@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <857baa8073f0b8051720959ef8fb1d49a6161d36.1696608809.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2023 18:25, Mehdi Djait wrote:
> The Techwell video decoder supports PAL, NTSC input formats,
> and outputs a BT.656 signal.
> 
> This commit adds support for this device, with basic support for NTSC
> and PAL, along with brightness and contrast controls.
> 
> The TW9900 is capable of doing automatic standard detection, this is
> implemented with support for PAL and NTSC autodetection.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>

...

> +
> +static int tw9900_check_id(struct tw9900 *tw9900,
> +			   struct i2c_client *client)
> +{
> +	struct device *dev = &tw9900->client->dev;
> +	int ret;
> +
> +	ret = tw9900_read_reg(client, TW9900_CHIP_ID);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret != TW9900_CHIP_ID) {
> +		dev_err(dev, "Unexpected decoder id(0x%x)\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	dev_info(dev, "Detected TW9900 (0x%x) decoder\n", TW9900_CHIP_ID);

dev_dbg
Do not spam log with simple success messages.

Why do you always print 0x0 (TW9900_CHIP_ID) here? It does not make
sense, drop.


> +
> +	return 0;
> +}
> +
> +static int tw9900_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct v4l2_ctrl_handler *hdl;
> +	struct tw9900 *tw9900;
> +	int ret = 0;
> +
> +	tw9900 = devm_kzalloc(dev, sizeof(*tw9900), GFP_KERNEL);
> +	if (!tw9900)
> +		return -ENOMEM;
> +
> +	tw9900->client = client;
> +	tw9900->cur_mode = &supported_modes[0];
> +
> +	tw9900->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(tw9900->reset_gpio))
> +		tw9900->reset_gpio = NULL;
> +
> +	tw9900->regulator = devm_regulator_get(&tw9900->client->dev, "vdd");
> +	if (IS_ERR(tw9900->regulator)) {
> +		dev_err(dev, "Failed to get power regulator\n");

return dev_err_probe()


Best regards,
Krzysztof

