Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409A27916FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352939AbjIDMRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIDMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:17:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E952ACC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:17:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bed101b70so217183566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693829865; x=1694434665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gko8S92UwKDakAjbzjQZ/sNmZx2tljlr3QwwqTw8dTw=;
        b=W2GXEiDFQbd2GOMkvDMGoTl+GiYFNT3SRJctr/7EJ1/Y3/ZkJIfTgeo2n4pJonqVLk
         Ef69Q4t0KCIsTTymrdW7smnSPnpY6amAjAVnhcmRjo4ihJlNcfrpXDRWWfMcMxSwfFCx
         oOVPNUL0xXsycQo12PTWkBpXiLbcWWXjjlKzeeDOgoqGnYqTSLOG2apRdHlWSF35MF7z
         9bqFkf6t7vLVz4bbqXZcb51mURoN1haimw/WaPaUNJpJLHDUZFHR5vZB2ZlWTJVvddmK
         cDnFlCUA6VNLilOOL3iOI3DO/qd1aFuWf5FFFJnG1/QxCeIu6TcMntCNyW6uA0dA0H7v
         aBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693829865; x=1694434665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gko8S92UwKDakAjbzjQZ/sNmZx2tljlr3QwwqTw8dTw=;
        b=UWQpUlxXjDhQmHZp5q4J64hoBB7/3tXCedBes/SrnM/HmuXaSF7CW8OoQTIGYJ0TFR
         x4Y0rSYAIizEZ1kkMTX9z7bkGG5Ws/psKZXmQFCHU7g+E8Et3lZ4Ii7Jvqc1WQEOnG0v
         o6nfXPpCBAy4i/bR9YmII/+je1S+RdigLDlJd9V+WKq6qfAlP9f/MP75crkcaGREV6Jd
         GNDdcw8T5XDjj5WIOPswtRCFkLTqfx/voo37R1xpyZEYUYyI/fdVQ/HxRtGAW/Vj32cO
         S1T5qSTWDx6k1xBtXNPdzNVBjkXGrPD/m6DR1aOQVHOIcWU3cJMjO355e/5NLvjs53QV
         g1Iw==
X-Gm-Message-State: AOJu0YyzXzoGWJYaW48b89VhpEFP2NodDaeHNRzL9ieygFF7zIL1OTwc
        MGQV7srfFBZBiec4dJ/QyE6ekw==
X-Google-Smtp-Source: AGHT+IEmnk0VrCde/RpXcTnJqLWkg8HN3gX0oQSn7T9cZd+70d9xlLecPSPO4/immxGbAA26YFLECg==
X-Received: by 2002:a17:906:1011:b0:9a5:a44a:86f3 with SMTP id 17-20020a170906101100b009a5a44a86f3mr8193805ejm.25.1693829865436;
        Mon, 04 Sep 2023 05:17:45 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id oz13-20020a170906cd0d00b00992f309cfe8sm6117340ejb.178.2023.09.04.05.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 05:17:45 -0700 (PDT)
Message-ID: <5ea76d3f-c9dd-10f5-4f9a-7b32b535ab5c@linaro.org>
Date:   Mon, 4 Sep 2023 14:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw87390 amplifier driver
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, herve.codina@bootlin.com,
        shumingf@realtek.com, rdunlap@infradead.org, 13916275206@139.com,
        ryans.lee@analog.com, linus.walleij@linaro.org,
        ckeepax@opensource.cirrus.com, yijiangtao@awinic.com,
        liweilei@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
References: <20230904114621.4457-1-wangweidong.a@awinic.com>
 <20230904114621.4457-4-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904114621.4457-4-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 13:46, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 

...

> +static void aw87390_parse_channel_dt(struct aw87390 *aw87390)
> +{
> +	struct aw_device *aw_dev = aw87390->aw_pa;
> +	struct device_node *np = aw_dev->dev->of_node;
> +	u32 channel_value = AW87390_DEV_DEFAULT_CH;
> +
> +	of_property_read_u32(np, "sound-channel", &channel_value);

NAK, there is no such property. It seems you already sneaked in such for
other codecs. Please do not repeat such patterns of work.

That's also why I expect full DTS example, not some reduced pieces.

> +
> +	aw_dev->channel = channel_value;
> +}
> +
> +static int aw87390_init(struct aw87390 **aw87390, struct i2c_client *i2c, struct regmap *regmap)
> +{
> +	struct aw_device *aw_dev;
> +	unsigned int chip_id;
> +	int ret;
> +
> +	/* read chip id */
> +	ret = regmap_read(regmap, AW87390_ID_REG, &chip_id);
> +	if (ret) {
> +		dev_err(&i2c->dev, "%s read chipid error. ret = %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	if (chip_id != AW87390_CHIP_ID) {
> +		dev_err(&i2c->dev, "unsupported device\n");

Why? The compatible tells it cannot be anything else.

> +		return -ENXIO;
> +	}
> +
> +	dev_info(&i2c->dev, "chip id = 0x%x\n", chip_id);
> +
> +	aw_dev = devm_kzalloc(&i2c->dev, sizeof(*aw_dev), GFP_KERNEL);
> +	if (!aw_dev)
> +		return -ENOMEM;
> +
> +	(*aw87390)->aw_pa = aw_dev;
> +	aw_dev->i2c = i2c;
> +	aw_dev->regmap = regmap;
> +	aw_dev->dev = &i2c->dev;
> +	aw_dev->chip_id = AW87390_CHIP_ID;
> +	aw_dev->acf = NULL;
> +	aw_dev->prof_info.prof_desc = NULL;
> +	aw_dev->prof_info.count = 0;
> +	aw_dev->prof_info.prof_type = AW88395_DEV_NONE_TYPE_ID;
> +	aw_dev->channel = AW87390_DEV_DEFAULT_CH;
> +	aw_dev->fw_status = AW87390_DEV_FW_FAILED;
> +	aw_dev->prof_index = AW87390_INIT_PROFILE;
> +	aw_dev->status = AW87390_DEV_PW_OFF;
> +
> +	aw87390_parse_channel_dt(*aw87390);
> +
> +	return ret;
> +}
> +
> +static int aw87390_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct aw87390 *aw87390;
> +	int ret;
> +
> +	ret = i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C);
> +	if (!ret)
> +		return dev_err_probe(&i2c->dev, -ENXIO, "check_functionality failed\n");
> +
> +	aw87390 = devm_kzalloc(&i2c->dev, sizeof(*aw87390), GFP_KERNEL);
> +	if (!aw87390)
> +		return -ENOMEM;
> +
> +	mutex_init(&aw87390->lock);
> +
> +	i2c_set_clientdata(i2c, aw87390);
> +
> +	aw87390->regmap = devm_regmap_init_i2c(i2c, &aw87390_remap_config);
> +	if (IS_ERR(aw87390->regmap)) {
> +		ret = PTR_ERR(aw87390->regmap);

ret is not needed here, so just:
return dev_err_probe()

> +		return dev_err_probe(&i2c->dev, ret, "failed to init regmap: %d\n", ret);
> +	}
> +
> +	/* aw pa init */
> +	ret = aw87390_init(&aw87390, i2c, aw87390->regmap);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(aw87390->regmap, AW87390_ID_REG, AW87390_SOFT_RESET_VALUE);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_snd_soc_register_component(&i2c->dev,
> +				&soc_codec_dev_aw87390, NULL, 0);
> +	if (ret)
> +		dev_err(&i2c->dev, "failed to register aw87390: %d\n", ret);
> +
> +	return ret;
> +}


Best regards,
Krzysztof

