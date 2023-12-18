Return-Path: <linux-kernel+bounces-3660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC8816F37
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E52286896
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9D58353D;
	Mon, 18 Dec 2023 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwzAKswz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486CC83509
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3365f1326e4so1627083f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702903621; x=1703508421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5uQmT85hN5Blw5wIPIAmzozo5Lx91qu3slA3GJ+h4s=;
        b=pwzAKswzF5b5UweXdai1h8GnKg5m5rbrN/9ngfvYLp5hgczWwPZQ5RdeIzEikwDdWP
         Z3ZWjLyVz+y0EthFK/kqhKeu9gb2qV1CSZCEGQjrXVierr10tTVr/UZfvUWAbYspFHzf
         Io088xrFjcybSV15o+j8HHg4FTE3HsNgMQ2LELv0CM0/xao8j/mm3+9CgbWJmFhLH+y9
         DadFqXvgsT5v2+1uhFI7qI4uHY10rgQcom/yi9pJkPWC6iAgQ1Akyae70meDIkrTCKxu
         yow4J/wZaWbBVHSji7zCtHGvj0I4Fh8/vnL2GXrVrUMZAkVFK0kV93X78U6hV0NkOFVh
         6c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702903621; x=1703508421;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5uQmT85hN5Blw5wIPIAmzozo5Lx91qu3slA3GJ+h4s=;
        b=A0cmtWMmWZDM9hS1gWjpsGNdKQW4YVPQxLzokcy23YgPnr3daOlB6UMButKcmrmAFY
         cBNoV/dMuRV154v6aHP0C3U0Pf2FGFtbqn7aehXlDcEKFLQEuIj3Ierfe9n0nfmfPFv5
         2M11RmOmdGpehDgdxtnxogLlm/x+WDEPdHrc9WnHuh0oDSvKyNNjeyfYShLP6j9RqTX5
         EvAWPm9cOe/DpO8100YjgG49lVh7hz3aLLsvIlv1LrI9UXreQjonZKvTwYgZhcnTKOxE
         DkOnZEinqerBGjYewUzJxFVjNMq0dilzM852mja+d//ohKypliNmY0u3mZkFFTigenhv
         Codg==
X-Gm-Message-State: AOJu0YzGrfHfpjfp8RwurPCt6RqI020TykbbiY/lb1wB9vnbwloBk6po
	xCvGBYcmIMl1FCCf2IwpXtS+mQ==
X-Google-Smtp-Source: AGHT+IGjNvhwKz+4urz8fJWawFyt8gyVA7ctsw/d4seUPcQuZw4GrukjuV5DkgYrHT38kyirqOKCjQ==
X-Received: by 2002:a05:600c:3c83:b0:40c:4aa6:75b9 with SMTP id bg3-20020a05600c3c8300b0040c4aa675b9mr6689035wmb.126.1702903621415;
        Mon, 18 Dec 2023 04:47:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id wn9-20020a170907068900b00a2362c5e3dbsm563527ejb.151.2023.12.18.04.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 04:47:00 -0800 (PST)
Message-ID: <fae1e6f8-f679-4266-95b6-5879c71683a4@linaro.org>
Date: Mon, 18 Dec 2023 13:46:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 RESEND 00/10] ASoC: fsl-asoc-card: compatibility
 integration of a generic codec use case for use with S/PDIF controller
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org,
 Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
References: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/12/2023 13:40, Elinor Montmasson wrote:
> Hello,
> 
> This is the v3 of the series of patch aiming to make the machine driver
> "fsl-asoc-card" compatible with use cases where there is no real codec
> driver.
> It proposes to use the "spdif_receiver" and "spdif_transmitter"
> drivers instead of the dummy codec.
> This is a first step in using the S/PDIF controller with the ASRC.
> 
> The five first patches add compatibility with the pair of codecs
> "spdif_receiver" and "spdif_transmitter" with a new compatible,
> "fsl,imx-audio-generic".
> Codec parameters are set with default values.
> Consequently, the driver is modified to work with multi-codec use cases.
> It can get 2 codecs phandles from the device tree, and the
> "fsl_asoc_card_priv" struct now has 2 "codec_priv" to store properties
> of both codecs. It is fixed to 2 codecs as only "fsl,imx-audio-generic"
> uses multiple codecs at the moment.
> However, the driver now uses for_each_codecs macros when possible to
> ease future implementations of multi-codec configurations.
> 
> The remaining patches add configuration options for the device tree.
> They configure the CPU DAI when using "fsl,imx-audio-generic".
> These options are usually hard-coded in "fsl-asoc-card.c" for each
> audio codec.
> Because the generic codec could be used with other CPU DAIs than
> the S/PDIF controller, setting these parameters could be required.
> 
> This series of patch was successfully built for arm64 and x86 on top of
> the latest for-next branch of the ASoC git tree on the 14th of December.
> These modifications have also been tested on an i.MX8MN evaluation
> board, with a linux kernel RT v6.1.26-rt8.
> 
> 
> We also have a few questions, following remarks made by
> Krzysztof Kozlowski in a previous email for patch 10/10:
> 
>>>>> The compatible list for this generic sound card currently:
>>>>> @@ -48,6 +51,8 @@ The compatible list for this generic sound card
>>>>> currently:
>>>>>
>>>>> "fsl,imx-audio-nau8822"
>>>>>
>>>>> + "fsl,imx-audio-generic"
>>>>
>>>> Generic does not look like hardware specific.
>>>
>>> Even if our end goal is to use it with the S/PDIF controller, this new
>>> support can be used with different hardware that doesn't
>>> require a codec. Thus, we don't really want to specify "spdif" in it.
>>>
>>> Is this compatible string not suitable ?
>>> Should we rename it to something else, like "fsl,imx-audio-no-codec" ?
>>
>> Maybe Mark or Rob will help here, but for me "imx-audio" is just way too
>> generic.
> 
> * Which generic name should we use ? Or how should we change it?

Compatible should be specific to one SoC, even if there is one driver
for entire family.

>  
>> Also, you add several new properties, so I really expect either
>> converting old binding to DT schema first or adding new device in DT
>> schema format.
> 
> * fsl-asoc-card.txt currently follows the old dt-bindings format.
> Should we update it to DT schema format in this patch series
> before adding my new properties?

You add six new properties, so from my point of view this cannot be in TXT.

Best regards,
Krzysztof


