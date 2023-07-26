Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB4762BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGZGoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjGZGoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:44:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16C4F3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 23:43:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C55166606FCD;
        Wed, 26 Jul 2023 07:43:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690353837;
        bh=ueP/nJT2Gh7HXLsoqgGPitlbPHdEBRo9/F4NVdXN5QA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CsHt+jjIa69g/AtpQwjI8k3S4eSG1xRx95L9zMP9Fg/TuGdhL5XxU/jV0xp9Ffgy7
         Tgz2FV3IUjx66DnpJZukyzx1qPFuedXqvyNPod35NArm0RsKMvMCedP2WLLTZBVbuK
         ulaCAuMWLQC3kYBg4cBSBDuZfiQ/TeI1YB81zPsMyrcTTn4C9k+vpuctNgNU5X7zcI
         HLI+p7H5SjvTtRfaHa0N2220nU30r85wRBaKULGJC7WLH/R06/fq5eRO+r4Z1eMAPM
         z9VKLJajCFy9djuweNxfzDQ4BMFZADBLBF+UPsgGcMyz8PxpO3GF1M/Pyk4065svq1
         pnI/N1aBM6Egw==
Message-ID: <320ab7cc-32dd-79dd-b2ae-96d3608aeb9c@collabora.com>
Date:   Wed, 26 Jul 2023 08:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic
 pinctrl
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
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <69690b530fb46d6adad1732d570c8cfad9c0f23c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/07/23 04:19, Trevor Wu (吳文良) ha scritto:
> On Tue, 2023-07-25 at 09:06 +0200, AngeloGioacchino Del Regno wrote:
>> Il 25/07/23 05:53, Trevor Wu ha scritto:
>>> To avoid power leakage, it is recommended to replace the default
>>> pinctrl
>>> state with dynamic pinctrl since certain audio pinmux functions can
>>> remain in a HIGH state even when audio is disabled. Linking pinctrl
>>> with
>>> DAPM using SND_SOC_DAPM_PINCTRL will ensure that audio pins remain
>>> in
>>> GPIO mode by default and only switch to an audio function when
>>> necessary.
>>>
>>> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
>>> ---
>>>    sound/soc/mediatek/mt8188/mt8188-mt6359.c | 21
>>> +++++++++++++++++++++
>>>    1 file changed, 21 insertions(+)
>>>
>>> diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>>> b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>>> index 7c9e08e6a4f5..667d79f33bf2 100644
>>> --- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>>> +++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
>>> @@ -246,6 +246,11 @@ static const struct snd_soc_dapm_widget
>>> mt8188_mt6359_widgets[] = {
>>>    	SND_SOC_DAPM_MIC("Headset Mic", NULL),
>>>    	SND_SOC_DAPM_SINK("HDMI"),
>>>    	SND_SOC_DAPM_SINK("DP"),
>>> +
>>> +	/* dynamic pinctrl */
>>> +	SND_SOC_DAPM_PINCTRL("ETDM_SPK_PIN", "aud_etdm_spk_on",
>>> "aud_etdm_spk_off"),
>>> +	SND_SOC_DAPM_PINCTRL("ETDM_HP_PIN", "aud_etdm_hp_on",
>>> "aud_etdm_hp_off"),
>>> +	SND_SOC_DAPM_PINCTRL("MTKAIF_PIN", "aud_mtkaif_on",
>>> "aud_mtkaif_off"),
>>>    };
>>>    
>>>    static const struct snd_kcontrol_new mt8188_mt6359_controls[] = {
>>> @@ -267,6 +272,7 @@ static int
>>> mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
>>>    		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
>>>    	struct snd_soc_component *cmpnt_codec =
>>>    		asoc_rtd_to_codec(rtd, 0)->component;
>>> +	struct snd_soc_dapm_widget *pin_w = NULL, *w;
>>>    	struct mtk_base_afe *afe;
>>>    	struct mt8188_afe_private *afe_priv;
>>>    	struct mtkaif_param *param;
>>> @@ -306,6 +312,18 @@ static int
>>> mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
>>>    		return 0;
>>>    	}
>>>    
>>> +	for_each_card_widgets(rtd->card, w) {
>>> +		if (!strcmp(w->name, "MTKAIF_PIN")) {
>>
>> if (strncmp(w->name, "MTKAIF_PIN", strlen(w->name) == 0) {
>> 	pin_w = w;
>> 	break;
>> }
>>
>> That's safer.
>>
> 
> If w->name is MTKAIF, the strncmp expression will return 0. However,
> the result is not expected. I prefer to keep strcmp here.
> 

You could also do, instead

if (strncmp(w->name, "MTKAIF_PIN", strlen("MTKAIF_PIN") == 0))

...solving your concern.

Regards,
Angelo

>>> +			pin_w = w;
>>> +			break;
>>> +		}
>>> +	}
>>> +
>>> +	if (!pin_w)
>>
>> Just a nitpick: you're checking for `if (pin_w)` later in this
>> function, so
>> to increase readability please do the same here.
>>
>> if (pin_w)
>> 	dapm_pinctrl_event(...)
>> else
>> 	dev_dbg(...)
>>
> 
> OK. I will update it in v2.
> 
> Thanks,
> Trevor


