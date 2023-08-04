Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07276FBA0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjHDIFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbjHDIE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:04:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB094684
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:04:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686b9964ae2so1349334b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691136296; x=1691741096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbV+gYNDujKbJYn2Rz5cAnqQGKoJDHNbW2fLENJYzXY=;
        b=FDTVqknY2GDfTRU6BHkEVEI+YIi8YxR1dTYObLysTNsJ+pi58EstB2nQBKMYV3Kqd4
         KhCHGimKFhUeuWMsHe/GTS00A/q4LlAW5ORHfo5WmYiQ9AGdiF/s9TPCH9GK8s/jVMG+
         LXoIzNW6d/uPxVauzggs3TsNAY4MzVQ0VyREuyM/bd4VIN/QdqnjyhWiNohnED9ZtZS/
         HQ6CRm0RM00k6KHcNbaCsq/blkgraad7p/J3+3bb2d9YTXf1ZkNQCbnxXeZCg5s66FN+
         5VzZIs//1YlYz1Zo1Iq/TnqRW6LFFVeVcXeb0ibBBTTHmqxu9ttKMs/uY6K/x/RvID5r
         pHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691136296; x=1691741096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbV+gYNDujKbJYn2Rz5cAnqQGKoJDHNbW2fLENJYzXY=;
        b=WjRzNjbiTMQl18ibGJ1oljdk/1LEbMOg5kQkZCxMmE8QEEG2cmG54uR9/obLCiJa5U
         gjwOk6HOZScDmB0p73TaA2LByLpOzsNaBI4n3lHBgvdphcEz0Twud0qBhcwva3RXuwRB
         +/2ubhGFCuk7w/WDB2YwqqGw3OgTYyjYkPhVzYxm+tuYwwxNWA2/NQ3EcnHTcJISFccd
         FvPlaxVxcNWiHQfl6xEYU8QbFHIFunizh0iXip/XQwbnhuPPqrX2CiArHWAGGrqvzVou
         lfp26TNIwklxG2ogXq8jOEf9yq1Sfi//OyuzpljA/ZTx3vQ9WdKkPQO4hKvUS98djCSJ
         NmoQ==
X-Gm-Message-State: AOJu0Yx3GWJHN62nfHoXAYcF/T+nTpmhQSX6fEElUOfAzsZki1YZcmeD
        2wlHIfw2cK5v/SlEL3mOvpk=
X-Google-Smtp-Source: AGHT+IF+z3baLyPsBoBifRMrSdMiWRiq01bLpw51R9+4NPbdIk8fjEHIm9UHz51UfDkd8oCW8x/gnw==
X-Received: by 2002:a05:6a20:7d8a:b0:132:cd2d:16fd with SMTP id v10-20020a056a207d8a00b00132cd2d16fdmr1123760pzj.38.1691136296389;
        Fri, 04 Aug 2023 01:04:56 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id u2-20020aa78482000000b00666b3706be6sm1023976pfn.107.2023.08.04.01.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 01:04:55 -0700 (PDT)
Message-ID: <277be798-9bd0-baa0-9e0d-8a7a9ac67f02@gmail.com>
Date:   Fri, 4 Aug 2023 17:04:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/27] ASoC: amd: acp3x-rt5682-max9836: Map missing jack
 kcontrols
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
 <20230802175737.263412-5-alpernebiyasak@gmail.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230802175737.263412-5-alpernebiyasak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/08/03 2:57, Alper Nebi Yasak wrote:
> This driver does not properly map jack pins to kcontrols that PulseAudio
> and PipeWire need to handle jack detection events. The RT5682, RT1015
> and RT1015p codecs used here can detect Headphone and Headset Mic
> connections. Expose the former two to userspace as kcontrols.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> Should the SND_JACK_LINEOUT be removed from the jack_new_pins calls?

I had patches to remove SND_JACK_LINEOUT and to add separate kcontrols, 
but I forgot them.

Mark Brown has a raised question if the jack is really not driven as a 
line output[1], but I never answered him (sorry for that!) I don't know 
if the hardware is capable, but I think we better to remove it for now 
since the codec driver does not handle it.

Mark, does it sound reasonable?

Regards,
Akihiko Odaki

[1] https://www.spinics.net/lists/alsa-devel/msg147970.html

> 
>   sound/soc/amd/acp3x-rt5682-max9836.c | 23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/amd/acp3x-rt5682-max9836.c b/sound/soc/amd/acp3x-rt5682-max9836.c
> index 0543dda75b99..3bf7e1e83c36 100644
> --- a/sound/soc/amd/acp3x-rt5682-max9836.c
> +++ b/sound/soc/amd/acp3x-rt5682-max9836.c
> @@ -28,6 +28,17 @@
>   #define DUAL_CHANNEL		2
>   
>   static struct snd_soc_jack pco_jack;
> +static struct snd_soc_jack_pin pco_jack_pins[] = {
> +	{
> +		.pin = "Headphone Jack",
> +		.mask = SND_JACK_HEADPHONE,
> +	},
> +	{
> +		.pin = "Headset Mic",
> +		.mask = SND_JACK_MICROPHONE,
> +	},
> +};
> +
>   static struct clk *rt5682_dai_wclk;
>   static struct clk *rt5682_dai_bclk;
>   static struct gpio_desc *dmic_sel;
> @@ -86,11 +97,13 @@ static int acp3x_5682_init(struct snd_soc_pcm_runtime *rtd)
>   	rt5682_dai_wclk = clk_get(component->dev, "rt5682-dai-wclk");
>   	rt5682_dai_bclk = clk_get(component->dev, "rt5682-dai-bclk");
>   
> -	ret = snd_soc_card_jack_new(card, "Headset Jack",
> -				SND_JACK_HEADSET | SND_JACK_LINEOUT |
> -				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> -				SND_JACK_BTN_2 | SND_JACK_BTN_3,
> -				&pco_jack);
> +	ret = snd_soc_card_jack_new_pins(card, "Headset Jack",
> +					 SND_JACK_HEADSET | SND_JACK_LINEOUT |
> +					 SND_JACK_BTN_0 | SND_JACK_BTN_1 |
> +					 SND_JACK_BTN_2 | SND_JACK_BTN_3,
> +					 &pco_jack,
> +					 pco_jack_pins,
> +					 ARRAY_SIZE(pco_jack_pins));
>   	if (ret) {
>   		dev_err(card->dev, "HP jack creation failed %d\n", ret);
>   		return ret;
