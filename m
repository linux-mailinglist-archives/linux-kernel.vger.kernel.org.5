Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF50756E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGQUdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGQUdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:33:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA72E55
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:33:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e566b1774so6479754a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689626014; x=1692218014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAFiMNxdlmBtCViQChOk/XFJQ0JSC5fbUjtDK9wgAoM=;
        b=iSxMBi3rKH/6HnCc1X5leW3yiIjzjg9zHPJMFJaNMps+seelAPG9EAtxK3l1yY4qDb
         asU5cq9S/Umd+tNQSe8JyDEnf525Mw08c5m1GsZZFRGlF8qAR/KawcgLyZvUXZ4HmmG6
         5pXkdDbUkghcwnPJDykuc8PpUx4SSJE5xQhXz4f7PdcNnwApKkFFw0+9e1jDe+pu6MHB
         Q7BpMxlmArSR1g8YfcA92+b1JW33rEt3jE3O4XIudZ+A6LecoxZqkD+jKsqxjgx9UbLv
         GubpKQc8DVpVsnjOiMfaSP0mGB4r6yAr4cd7k5nXyYuDYdBnaSN2giEuGrwEmNQ9ow9B
         iPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626014; x=1692218014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAFiMNxdlmBtCViQChOk/XFJQ0JSC5fbUjtDK9wgAoM=;
        b=HKTjH4pl22IALwDaPz8Ofk/guQqkGx+GC01IrkeO2ydm5D0744xAb5YL3kvqcaA/Bj
         DigDkfZnUp3qDi/1Tg74leob5a0t4Nwa0Rer3D49zfhrGZwJCFlJXYFr11mx4TqTUwQO
         zuAX9E9nrLEO97PwJit3vuLJQ05+FaaDVCb0aWWd6uWbkXoR3i/GbDnPTdEOnAIwLk0f
         SypGHJHrfukK1EDojJPx8/45uBsHKS2TTqadZj985H1HpxzSzGAz6agRtdzJejNFwtRb
         M7D8MGm2bKFRWaGAkDwsFkHiEhPM4m8+3wG/1Ri8tKuvSAN1Ecd+MfLCA9Bvfh0gzQE9
         FeuQ==
X-Gm-Message-State: ABy/qLYigF2+fNPvJqdoyR8Tr5g6iuR7dvkB3p2Nuudzn4Iv33mCJtm4
        rqYKf50jiBwD1T06uhDVcVqLbQ==
X-Google-Smtp-Source: APBJJlFaEFzB40WLLllp7hDstkNtL0eOmE8wbJNRTUu6O38yJyr65Skc8hi6CYGIFXBli4PnnQ+sPQ==
X-Received: by 2002:aa7:df08:0:b0:51e:d4b:3c9d with SMTP id c8-20020aa7df08000000b0051e0d4b3c9dmr12513969edy.23.1689626014529;
        Mon, 17 Jul 2023 13:33:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e19-20020aa7d7d3000000b0051e2a6cef4fsm113320eds.36.2023.07.17.13.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:33:33 -0700 (PDT)
Message-ID: <0c534a51-dff3-84f1-34cb-41cae25d3871@linaro.org>
Date:   Mon, 17 Jul 2023 22:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 1/5] ASoC: codecs: Add i2c and codec registration for
 aw88261 and their associated operation functions
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.co, shumingf@realtek.com,
        herve.codina@bootlin.com, flatmax@flatmax.com,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, pierre-louis.bossart@linux.intel.com,
        kiseok.jo@irondevice.com, liweilei@awinic.com,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yijiangtao@awinic.com, zhangjianming@awinic.com
References: <20230717115845.297991-1-wangweidong.a@awinic.com>
 <20230717115845.297991-2-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717115845.297991-2-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 13:58, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> The AW88261 is an I2S/TDM input, high efficiency
> digital Smart K audio amplifier with an integrated 10.25V
> smart boost convert
> 

...

> +
> +static int aw88261_request_firmware_file(struct aw88261 *aw88261)
> +{
> +	const struct firmware *cont = NULL;
> +	int ret;
> +
> +	aw88261->aw_pa->fw_status = AW88261_DEV_FW_FAILED;
> +
> +	ret = request_firmware(&cont, AW88261_ACF_FILE, aw88261->aw_pa->dev);
> +	if ((ret < 0) || (!cont)) {
> +		dev_err(aw88261->aw_pa->dev, "load [%s] failed!", AW88261_ACF_FILE);
> +		return ret;

return dev_err_probe?

> +	}
> +
> +	dev_info(aw88261->aw_pa->dev, "loaded %s - size: %zu\n",
> +			AW88261_ACF_FILE, cont ? cont->size : 0);> +
> +	aw88261->aw_cfg = devm_kzalloc(aw88261->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
> +	if (!aw88261->aw_cfg) {
> +		release_firmware(cont);
> +		return -ENOMEM;
> +	}
> +	aw88261->aw_cfg->len = (int)cont->size;
> +	memcpy(aw88261->aw_cfg->data, cont->data, cont->size);
> +	release_firmware(cont);
> +
> +	ret = aw88261_dev_load_acf_check(aw88261->aw_pa, aw88261->aw_cfg);
> +	if (ret < 0) {
> +		dev_err(aw88261->aw_pa->dev, "Load [%s] failed ....!", AW88261_ACF_FILE);
> +		return ret;
> +	}
> +
> +	dev_dbg(aw88261->aw_pa->dev, "%s : bin load success\n", __func__);

Drop dev_dbg on simple probe success/failure. There is tracing
infrastructure for this.

> +
> +	mutex_lock(&aw88261->lock);
> +	/* aw device init */
> +	ret = aw88261_dev_init(aw88261->aw_pa, aw88261->aw_cfg);
> +	if (ret < 0)
> +		dev_err(aw88261->aw_pa->dev, "dev init failed");
> +	mutex_unlock(&aw88261->lock);
> +
> +	return ret;
> +}
> +
> +static int aw88261_codec_probe(struct snd_soc_component *component)
> +{
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> +	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	INIT_DELAYED_WORK(&aw88261->start_work, aw88261_startup_work);
> +
> +	ret = aw88261_request_firmware_file(aw88261);
> +	if (ret < 0) {
> +		dev_err(aw88261->aw_pa->dev, "aw88261_request_firmware_file failed\n");
> +		return ret;

Consider here dev_err_probe, to annotate possibility of probe deferal
(e.g. missing rootfs). I think component probe is called for device probes?

> +	}
> +
> +	/* add widgets */
> +	ret = snd_soc_dapm_new_controls(dapm, aw88261_dapm_widgets,
> +							ARRAY_SIZE(aw88261_dapm_widgets));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* add route */
> +	ret = snd_soc_dapm_add_routes(dapm, aw88261_audio_map,
> +							ARRAY_SIZE(aw88261_audio_map));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = snd_soc_add_component_controls(component, aw88261_controls,
> +							ARRAY_SIZE(aw88261_controls));
> +
> +	return ret;
> +}
> +

> +static void aw88261_codec_remove(struct snd_soc_component *aw_codec)
> +{
> +	struct aw88261 *aw88261 = snd_soc_component_get_drvdata(aw_codec);
> +
> +	cancel_delayed_work_sync(&aw88261->start_work);
> +}
> +
> +
> +static void aw88261_hw_reset(struct aw88261 *aw88261)
> +{
> +	gpiod_set_value_cansleep(aw88261->reset_gpio, 0);
> +	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
> +	gpiod_set_value_cansleep(aw88261->reset_gpio, 1);
> +	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
> +}
> +
> +static int aw88261_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct aw88261 *aw88261;
> +	int ret;
> +
> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&i2c->dev, "check_functionality failed");
> +		return -EIO;
> +	}
> +
> +	aw88261 = aw88261_malloc_init(i2c);
> +	if (!aw88261) {
> +		dev_err(&i2c->dev, "malloc aw88261 failed");

Do not print messages on allocation errors.

Also, there is little sense in moving one or two functions - kzalloc -
to separate function. It does not make the code easier to read.

> +		return -ENOMEM;
> +	}
> +	i2c_set_clientdata(i2c, aw88261);
> +
> +	aw88261->reset_gpio = devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(aw88261->reset_gpio))
> +		dev_info(&i2c->dev, "reset gpio not defined\n");
> +	else
> +		aw88261_hw_reset(aw88261);
> +
> +	aw88261->regmap = devm_regmap_init_i2c(i2c, &aw88261_remap_config);
> +	if (IS_ERR(aw88261->regmap)) {
> +		ret = PTR_ERR(aw88261->regmap);
> +		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
> +		return ret;

return dev_err_probe

> +	}
> +
> +	/* aw pa init */
> +	ret = aw88261_init(&aw88261->aw_pa, i2c, aw88261->regmap);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_snd_soc_register_component(&i2c->dev,
> +			&soc_codec_dev_aw88261,
> +			aw88261_dai, ARRAY_SIZE(aw88261_dai));
> +	if (ret < 0)
> +		dev_err(&i2c->dev, "failed to register aw88261: %d", ret);
> +
> +	return ret;
> +}
> +
> +#ifdef CONFIG_OF

Drop

> +static const struct of_device_id aw88261_of_match[] = {
> +	{ .compatible = "awinic,aw88261" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, aw88261_of_match);
> +#endif
> +
> +static const struct i2c_device_id aw88261_i2c_id[] = {
> +	{ AW88261_I2C_NAME, 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, aw88261_i2c_id);
> +
> +static struct i2c_driver aw88261_i2c_driver = {
> +	.driver = {
> +		.name = AW88261_I2C_NAME,
> +		.of_match_table = of_match_ptr(aw88261_of_match),

Drop of_match_ptr.


Best regards,
Krzysztof

