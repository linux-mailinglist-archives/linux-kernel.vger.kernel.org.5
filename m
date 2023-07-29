Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DEC767E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjG2LWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjG2LWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:22:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B435E6E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:22:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so31810165e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690629734; x=1691234534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFFnLWbiAASTwG9g6JIbmGpXHzsejEBtY6kS8fXW54Y=;
        b=uo8TjsgIf8ew2ldpBB/wyE+LXVyLMHjFckbMuyTC4NP0HAhl0fScoMGY/OI8WX/EZj
         REnumD54/hZH7TlDBDGMHHi0NFyuFkB5bXLRQ7/jufWLvhnibJN1P05BaVN2fNfM6IA4
         uwoqSBN4hcn75SFimJkGWZ5X/95f0U1TnSERST+KL1JYGY4p2L23kN3iziaX3L64KHpK
         bbT+quW8OHlIJZtmoriGRXfBYH/0ZnQIKkEUEWP4+Kn2GtVT/y8bttHl1g8qgeRWk2JM
         8yeZlvH+5iZt0nEjKLL4qQJGw7UyF2Ip+ChMph8FO9qwS3uSEMMK0J6jeCeEcqhL8BBC
         Xn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690629734; x=1691234534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFFnLWbiAASTwG9g6JIbmGpXHzsejEBtY6kS8fXW54Y=;
        b=HICesh0rscMb4tGWWky/uvBiGL2v5UbOUjPvBWS1b+CQSn//pPNeEShUv39VKbU/iW
         n0ye07NCWeDYoIzmXISvwMR2A1GaXbW2NVfeU+uzXy4QL3hBB/FC5G+I/3ChiGAygfXE
         DwcJYuW2xi6kn9M/HGUfpuaHaBhsv8jyF3pQ1btfOBdpx8kZ7o10MPhm6auUkJWHkaFw
         c6qYlh4J1uTekdKj7CKcE6fHGT5/1LHaG/gpoEeMIo0WcKdzg9uCJhGyN0rXy3CAZ0gu
         XNHjtU/YBRGZ7WrztMLfSX3guE+v4TzVa0HH6A7cha64emlyIBTNS1oiYP9j0NuskE9K
         VggQ==
X-Gm-Message-State: ABy/qLZwFmrO0mtSAlATNpflJBK3Akf82yAKtbHpLTxU6g2tOwRWRFAk
        mxh5GfoO52P1LgwAs9QI7N+4tg==
X-Google-Smtp-Source: APBJJlFEDyilq7HGdoCJmHpSP8r9K25PBw2ACJ//6QDGMNM1rZ1ZB8mH7EeVf6kPHbWdcI710Hw2CQ==
X-Received: by 2002:a5d:4c8e:0:b0:317:58a8:baa with SMTP id z14-20020a5d4c8e000000b0031758a80baamr3924860wrs.28.1690629734443;
        Sat, 29 Jul 2023 04:22:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7d055000000b0051e26c7a154sm2784738edo.18.2023.07.29.04.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 04:22:13 -0700 (PDT)
Message-ID: <4d822ff6-b7e6-20e2-6087-78941488a3cf@linaro.org>
Date:   Sat, 29 Jul 2023 13:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 3/5] ASoC: codecs: Add aw88261 amplifier driver
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, shumingf@realtek.com,
        ryans.lee@analog.com, 13916275206@139.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, fido_max@inbox.ru, povik+lin@cutebit.org,
        liweilei@awinic.com, yijiangtao@awinic.com, colin.i.king@gmail.com,
        trix@redhat.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
References: <20230729091223.193466-1-wangweidong.a@awinic.com>
 <20230729091223.193466-4-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230729091223.193466-4-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2023 11:12, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add i2c and amplifier registration for
> aw88261 and their associated operation functions.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  sound/soc/codecs/aw88261/aw88261.c | 517 +++++++++++++++++++++++++++++
>  sound/soc/codecs/aw88261/aw88261.h |  52 +++
>  2 files changed, 569 insertions(+)
>  create mode 100644 sound/soc/codecs/aw88261/aw88261.c
>  create mode 100644 sound/soc/codecs/aw88261/aw88261.h
> 


> +
> +static int aw88261_request_firmware_file(struct aw88261 *aw88261)
> +{
> +	const struct firmware *cont = NULL;
> +	int ret;
> +
> +	aw88261->aw_pa->aw88261_base->fw_status = AW88261_DEV_FW_FAILED;
> +
> +	ret = request_firmware(&cont, AW88261_ACF_FILE, aw88261->aw_pa->dev);
> +	if (ret < 0) {
> +		dev_err_probe(aw88261->aw_pa->dev, ret, "load [%s] failed!", AW88261_ACF_FILE);
> +		return ret;

That's not how you use dev_err_probe. Instead: return dev_err_probe

> +	}
> +
> +	dev_info(aw88261->aw_pa->dev, "loaded %s - size: %zu\n",
> +			AW88261_ACF_FILE, cont ? cont->size : 0);
> +
> +	aw88261->aw_cfg = devm_kzalloc(aw88261->aw_pa->dev, cont->size + sizeof(int), GFP_KERNEL);
> +	if (!aw88261->aw_cfg) {
> +		release_firmware(cont);
> +		return -ENOMEM;
> +	}
> +	aw88261->aw_cfg->len = (int)cont->size;
> +	memcpy(aw88261->aw_cfg->data, cont->data, cont->size);
> +	release_firmware(cont);
> +
> +	ret = aw88395_dev_load_acf_check(aw88261->aw_pa->aw88261_base, aw88261->aw_cfg);
> +	if (ret < 0) {
> +		dev_err_probe(aw88261->aw_pa->dev, ret, "load [%s] failed !", AW88261_ACF_FILE);
> +		return ret;

return dev_err_probe

> +	}
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
> +		dev_err_probe(aw88261->aw_pa->dev, ret, "aw88261_request_firmware_file failed\n");
> +		return ret;

return dev_err_probe

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
> +static const struct snd_soc_component_driver soc_codec_dev_aw88261 = {
> +	.probe = aw88261_codec_probe,
> +	.remove = aw88261_codec_remove,
> +};
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
> +	ret = i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C);
> +	if (!ret) {
> +		dev_err_probe(&i2c->dev, ret, "check_functionality failed");
> +		return -ENXIO;

return dev_err_probe

> +	}
> +
> +	aw88261 = devm_kzalloc(&i2c->dev, sizeof(struct aw88261), GFP_KERNEL);

sizeof(*)

> +	if (!aw88261)
> +		return -ENOMEM;
> +
> +	mutex_init(&aw88261->lock);
> +
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
> +		dev_err_probe(&i2c->dev, ret, "failed to init regmap: %d\n", ret);
> +		return ret;

return dev_err_probe

I asked you about this in your first version. I explicitly wrote "return
dev_err_probe", not some other syntax.


Best regards,
Krzysztof

