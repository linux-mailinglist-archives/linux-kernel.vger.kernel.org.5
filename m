Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E447E0487
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377746AbjKCOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjKCOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:16:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D58D43
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:16:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so1322155f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699020993; x=1699625793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=evXjT31VfWFinCwS9eVIYPm4dsZFzW7Jc82ftHB3Fl8=;
        b=sYoD7m3IfiSNCdAv+BgbZwmreLPultYiIKz52RdIizVpRx7oU+gKMbuqcg58CY9t5c
         p/ZcpKMuFI+jFmljQ/aFAM34nh6rF/g+0j6UwWl93iyQ5e2AeaYsBumrdGnBVFksitsm
         9TM6n3uHtxxHjmg1QtWyHaV2jpc5LDhvFcBlQjpSTHa37r2fXc0fGAprUdjDu1QIPlrB
         AOo2t68y1x/DIBi6oXHLxE/mFRAdb7c7kY6JZvXj1ABXNCtlz8K96NeccpM3w7S6Oh25
         QuDUENiPE8R/bO9QjuOY0WrhLMfFm0SyuPyGS/b8tEFXaJowau3HcHLfC7zV3szP8Hv0
         hKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699020993; x=1699625793;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evXjT31VfWFinCwS9eVIYPm4dsZFzW7Jc82ftHB3Fl8=;
        b=bdKdmod9hqA4l8HYsgjtcSRlEnwGxpMRjd4aDDIxh3vYG9MM/mZkEV4PvkL9kCLlMA
         admLxZTORs4NRSOyVfRL/viEDWdzI0euallPhGzY6nHWAqyikH9G3F6MPdFhzqBapaED
         P4wWRH83QKHBsGipaDDjAyLfiD5Zq03vhKU4PK9RZx3oUdtmQGQKS8vaYz3loCzYaVU1
         peQ5ITI8DS9kENoiI8H5aScRR8zcI+S3MB6jx6fMXPnJ93esA46xT2qCazjhz1Ijt+R+
         cdfU5L6xgmmYY40JR3AllNDtpG114XahorqnHATcZjc+gcHPfDC3wz+uX3TINFlXT+0k
         lr4Q==
X-Gm-Message-State: AOJu0YztSJVZyiEk/vD+BY5yjuR+s9dzghzTABp11m8rf2DETIpIYg2G
        nh2/RL55BO2WLGxD6jytnZ1P1A==
X-Google-Smtp-Source: AGHT+IGn31m/dJNBXZFppXDkdzaC8uBqRWYSpLjgTz7gbjkVWnQc1uyK6AYeX85jvWMZ/DG4XpDYCg==
X-Received: by 2002:a05:6000:184:b0:32f:68ae:239c with SMTP id p4-20020a056000018400b0032f68ae239cmr3171736wrx.16.1699020993224;
        Fri, 03 Nov 2023 07:16:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id h17-20020adff4d1000000b0032d96dd703bsm1970175wrp.70.2023.11.03.07.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 07:16:32 -0700 (PDT)
Message-ID: <160752cb-7772-4b1d-9096-8be25e76213c@linaro.org>
Date:   Fri, 3 Nov 2023 15:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ASoC: codecs: wsa884x: check if set_stream is called
 for proper bus
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20231025144601.268645-1-krzysztof.kozlowski@linaro.org>
 <20231025144601.268645-3-krzysztof.kozlowski@linaro.org>
 <8b9db87b-0f61-4824-acf1-6b5ebdf45e63@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8b9db87b-0f61-4824-acf1-6b5ebdf45e63@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 17:03, Pierre-Louis Bossart wrote:
> 
> 
> On 10/25/23 09:46, Krzysztof Kozlowski wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> If multiple WSA8840 speakers, from two separate Soundwire buses, are
>> used in one codec DAI link, the set_stream() should ignore calls for
>> setting stream from other Soundwire controller.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  sound/soc/codecs/wsa884x.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
>> index bee6e763c700..91205e8c96f1 100644
>> --- a/sound/soc/codecs/wsa884x.c
>> +++ b/sound/soc/codecs/wsa884x.c
>> @@ -1775,6 +1775,12 @@ static int wsa884x_set_stream(struct snd_soc_dai *dai,
>>  			      void *stream, int direction)
>>  {
>>  	struct wsa884x_priv *wsa884x = dev_get_drvdata(dai->dev);
>> +	struct sdw_stream_runtime *sruntime = stream;
>> +	struct sdw_slave *sdw = dev_to_sdw_dev(dai->dev);
>> +
>> +	/* Check if this belongs to same bus */
>> +	if (sdw->bus->dev != sruntime->dev)
>> +		return 0;
> 
> Sorry, maybe I am really thick or need coffee, but I can't figure out
> why this is necessary. Each amplifier has its own "wsa884x_priv" context
> and should have its own DAI, not following why the set_stream would
> mix-up the two dais?
> 
> We've been using two buses for two amplifiers since CometLake (2019?)
> and I don't see what's different?

Let me start with some hardware representation in DTS.

We have two Soundwire controllers swr0 and swr3, each with two WSA884x
speakers (codecs):

-------------
&swr0 {
	status = "okay";

	left_woofer: speaker@0,0 {
		compatible = "sdw20217020400";
		reg = <0 0>;
		// ...
	};

	/* WSA8845, Left Tweeter */
	left_tweeter: speaker@0,1 {
		compatible = "sdw20217020400";
		reg = <0 1>;
		// ...
	};
};

&swr3 {
	status = "okay";

	/* WSA8845, Right Woofer */
	right_woofer: speaker@0,0 {
		compatible = "sdw20217020400";
		reg = <0 0>;
		// ...
	};

	/* WSA8845, Right Tweeter */
	right_tweeter: speaker@0,1 {
		compatible = "sdw20217020400";
		reg = <0 1>;
		// ...
	};
};
-------------

Now, for four-speaker playback, we have sound card with links like:

-------------
wsa-dai-link {
	link-name = "WSA Playback";

	cpu {
		sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
	};

	codec {
		sound-dai = <&left_woofer>, <&left_tweeter>,
			    <&swr0 0>, <&lpass_wsamacro 0>,
			    <&right_woofer>, <&right_tweeter>,
			    <&swr3 0>, <&lpass_wsa2macro 0>;
	};

	platform {
		sound-dai = <&q6apm>;
	};
};
-------------

We need to prepare the stream for all four speakers and two soundwire
controllers (so two different soundwire buses), however without the
patches here, the stream (sdw_stream_runtime *sruntime) right
woofer/twitter is set to swr0 (the other bus!). But it should stay as
swr3 (their bus).

Does it help a bit? I hope I am able to properly explain it.

Thanks for your feedback and review!

Best regards,
Krzysztof

