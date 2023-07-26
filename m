Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786357635AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjGZLyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjGZLyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:54:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B3F1A8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:54:32 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCD086607122;
        Wed, 26 Jul 2023 12:54:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690372470;
        bh=bVTxpRsO9XpsEFLGwnoFCHc+RHZNn5Rr/3M/prdckKU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BQo8SfX6J0DvibVCKu8TFH25FWngQy2hEw5zZgzfDUudXSUbh+F4dWWpExATDeAYL
         L4+X6vSNB+wPYbDwcy95qnKxu9AeprMuztvX6m91Y8VUsuX24jBei7bjUFlU/P3dFc
         rN4DN48vV5nDettli6/oOwwt5T3yDk1F1QvEcGqellXCab8iLF0mZmcLi54DyhSspt
         iHYPao1c6WRPfWgRJARiBy6Gs7j6M631mTiLKlImoAHAz2OEL827DTIwwpZjmsRGtH
         bAzOC5R58fNGh30vD63bm+lix+C8ROeoXAyIchRz7gQf2FLDT78FOUP4unRJkyAZnd
         JGqArvywQLneg==
Message-ID: <82fb1e56-b271-0ba9-c23d-0c066dc51ef6@collabora.com>
Date:   Wed, 26 Jul 2023 13:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic
 pinctrl
Content-Language: en-US
To:     =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20230725035304.2864-1-trevor.wu@mediatek.com>
 <20230725035304.2864-2-trevor.wu@mediatek.com>
 <5314542c-9a99-fad1-93f6-4f72c8698715@collabora.com>
 <69690b530fb46d6adad1732d570c8cfad9c0f23c.camel@mediatek.com>
 <320ab7cc-32dd-79dd-b2ae-96d3608aeb9c@collabora.com>
 <b9e49c0a16bb59ed803fbb6102269b948be95ecc.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <b9e49c0a16bb59ed803fbb6102269b948be95ecc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/07/23 13:36, Trevor Wu (吳文良) ha scritto:
> On Wed, 2023-07-26 at 08:43 +0200, AngeloGioacchino Del Regno wrote:
>> Il 26/07/23 04:19, Trevor Wu (吳文良) ha scritto:
>>> On Tue, 2023-07-25 at 09:06 +0200, AngeloGioacchino Del Regno
>>> wrote:
>>>> Il 25/07/23 05:53, Trevor Wu ha scritto:
>>>>> To avoid power leakage, it is recommended to replace the
>>>>> default
>>>>> pinctrl
>>>>> state with dynamic pinctrl since certain audio pinmux functions
>>>>> can
>>>>> remain in a HIGH state even when audio is disabled. Linking
>>>>> pinctrl
>>>>> with
>>>>> DAPM using SND_SOC_DAPM_PINCTRL will ensure that audio pins
>>>>> remain
>>>>> in
>>>>> GPIO mode by default and only switch to an audio function when
>>>>> necessary.
>>>>>
>>>>> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
>>>>> ---
>>>>>     sound/soc/mediatek/mt8188/mt8188-mt6359.c | 21
>>>>> +++++++++++++++++++++
>>>>>     1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>>>>> b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>>>>> index 7c9e08e6a4f5..667d79f33bf2 100644
>>>>> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>>>>> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>>>>> @@ -246,6 +246,11 @@ static const struct snd_soc_dapm_widget
>>>>> mt8188_mt6359_widgets[] = {
>>>>>     	SND_SOC_DAPM_MIC("Headset Mic", NULL),
>>>>>     	SND_SOC_DAPM_SINK("HDMI"),
>>>>>     	SND_SOC_DAPM_SINK("DP"),
>>>>> +
>>>>> +	/* dynamic pinctrl */
>>>>> +	SND_SOC_DAPM_PINCTRL("ETDM_SPK_PIN", "aud_etdm_spk_on",
>>>>> "aud_etdm_spk_off"),
>>>>> +	SND_SOC_DAPM_PINCTRL("ETDM_HP_PIN", "aud_etdm_hp_on",
>>>>> "aud_etdm_hp_off"),
>>>>> +	SND_SOC_DAPM_PINCTRL("MTKAIF_PIN", "aud_mtkaif_on",
>>>>> "aud_mtkaif_off"),
>>>>>     };
>>>>>     
>>>>>     static const struct snd_kcontrol_new
>>>>> mt8188_mt6359_controls[] = {
>>>>> @@ -267,6 +272,7 @@ static int
>>>>> mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime
>>>>> *rtd)
>>>>>     		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
>>>>>     	struct snd_soc_component *cmpnt_codec =
>>>>>     		asoc_rtd_to_codec(rtd, 0)->component;
>>>>> +	struct snd_soc_dapm_widget *pin_w = NULL, *w;
>>>>>     	struct mtk_base_afe *afe;
>>>>>     	struct mt8188_afe_private *afe_priv;
>>>>>     	struct mtkaif_param *param;
>>>>> @@ -306,6 +312,18 @@ static int
>>>>> mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime
>>>>> *rtd)
>>>>>     		return 0;
>>>>>     	}
>>>>>     
>>>>> +	for_each_card_widgets(rtd->card, w) {
>>>>> +		if (!strcmp(w->name, "MTKAIF_PIN")) {
>>>>
>>>> if (strncmp(w->name, "MTKAIF_PIN", strlen(w->name) == 0) {
>>>> 	pin_w = w;
>>>> 	break;
>>>> }
>>>>
>>>> That's safer.
>>>>
>>>
>>> If w->name is MTKAIF, the strncmp expression will return 0.
>>> However,
>>> the result is not expected. I prefer to keep strcmp here.
>>>
>>
>> You could also do, instead
>>
>> if (strncmp(w->name, "MTKAIF_PIN", strlen("MTKAIF_PIN") == 0))
>>
>> ...solving your concern.
>>
>>
> 
>  From my understanding, strncmp is utilized to determine a string begins
> with a particular prefix while strcmp is used to compare a whole
> string. In this scenario, I wish to verify if the widget name is
> exactly 'MTKAIF_PIN', so I believe using strcmp would be more
> appropriate.
> 
> Using either strlen(w->name) or strlen("MTKAIF_PIN") may lead to
> incorrect results when w->name is either MTKAIF or MTKAIF_PIN1.
> 
> Thanks,
> Trevor

strcmp() and strncmp() are the same; except strncmp() compares *at most* `n` bytes,
where `n` is my `strlen("MTKAIF_PIN")`.

 From Linux man pages....
https://www.man7.org/linux/man-pages/man3/strcmp.3.html

Regards,
Angelo
