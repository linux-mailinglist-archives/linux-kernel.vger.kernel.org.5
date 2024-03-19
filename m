Return-Path: <linux-kernel+bounces-108015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D758804D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681501C2272B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F34B33CCF;
	Tue, 19 Mar 2024 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU3T6tI6"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C4B2D05C;
	Tue, 19 Mar 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872882; cv=none; b=UMoBLaNMhpg0fE7qPZ8YeX2f4Yi0rqA/wudwCWfB6/2qNk4Vso6qATcAG5eH6ii4TyrqPYDthozLyIoFyC4x0JF8R+M/bAAi93zBB8b5ahvEMPn1m3NApcjK+ceXITlghVlopt/UJ98u6AYY3b3kMqiODgmDqhRxI4haUsM2Y2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872882; c=relaxed/simple;
	bh=abdnB0gyW3XwfLvq1h9H4CJRk5if6by9tOYHJk/rUZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArzbgNck9dhzRBTXsSdDbmJmYL3RPqeM/TLMi1M8jcX8D6ub3LKcTItIm+7fw8kswitL3bZYB9CoYwAwwrajQGQKVwII6hnKAtxJHcgLKje9dgZr4+eFcRtLZTg9NjgPHD2BplAWa41Dta1Exe2LlUZBKkqTdmPWAZdrZFZDTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU3T6tI6; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d27184197cso77855441fa.1;
        Tue, 19 Mar 2024 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710872878; x=1711477678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUKjW78EP4nHLFdEFyF1sz33PGb04BsnsgyPGWHjdiY=;
        b=HU3T6tI6u6xssI8bStmld/Sit5ZLuOdRinte3L9A2+A+ZxwQXTUFSEkMiFoH+/yEqv
         w7koj6b25k5JDBD/Hi2l3izC4xj/G0E6ziv2drCGSq21iPd+LVCqQ6ADlOs2xEST99mB
         VQ1khMD5j5sEBXhT3PIzFYvo8bSZagwqpONyrC1NXqefhwyqkmUaSsLZ5FVcc3eO3pVK
         jAdpxVNcHoG8IwZMS+tIZJ7e1YRAEVLs02+gRv78aZiOrCNTAdKjEw2pKyc+uyfD2mX+
         UQ5PuuM0ZG6glEGGaiOQNglZ4HKThPZZMxosLYZp8qswisnxdyvesCEvTMdTeTnauopU
         4EAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872878; x=1711477678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUKjW78EP4nHLFdEFyF1sz33PGb04BsnsgyPGWHjdiY=;
        b=EvEfBuMvEXGRrCodUV4EF+kcQsVSfDH0gbDO2AnXVIgeOFlj+dwSlDJdu7iSA6y5Ai
         rCObhZll6umRTedT+S0ShhOn23RzXOXdwTW6EFi5+N+WggvWYlRJiqcG9MOXbJhVEnw5
         QkMkI9tBhzNN7WpIf3p0/hQkxe+n1Pl8qAkyhrgR0Fy5owVCoezHBz2PEYfpUKgRdLJa
         48yCcDKXQHUj05AenwhE477uvmNoMf3xWU8HkTp94Wka4Gt7O/OOoR/lU3h7iZ3o9H/U
         BFJhFywduUxB8YFthvNZc/zsfisAMJtLS7uATgd7fIhFRj7bswscEvaecsyZeN3HoEmf
         prhw==
X-Forwarded-Encrypted: i=1; AJvYcCWRIz+i2VE8l9SUZoAFVlwhIT2UJE7cl2L0i7dw35vMo5gRLjcb3UUrWO/aDcORbILV84pESAKGnxEEVocBhfct0VR3drlw44iMnmVZDHYzud/svYnTgIxkJ5wljSxMXd+1MUA9+WTS9Q==
X-Gm-Message-State: AOJu0YxqQIVz88MCp5bcovJXBRjTD0UTeHjfOfHffqdO0eWcEgt8q96m
	LAgOpEwKkWptTCDnKADJAPKOp9IOSiW2QODXKXiElXWKgKr7yl2f
X-Google-Smtp-Source: AGHT+IFS7dXGsCRrzrfkP3DfhxFHZGiAlHX5aRWXJ333+GTCrqWr6bFU78pTHZZanczfFxZTNcnyeQ==
X-Received: by 2002:a05:651c:19a4:b0:2d4:6df2:12c0 with SMTP id bx36-20020a05651c19a400b002d46df212c0mr3113178ljb.34.1710872878182;
        Tue, 19 Mar 2024 11:27:58 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-76-118.kaisa-laajakaista.fi. [85.29.76.118])
        by smtp.gmail.com with ESMTPSA id d2-20020a2e3602000000b002d3f3da0702sm1846927lja.107.2024.03.19.11.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:27:57 -0700 (PDT)
Message-ID: <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
Date: Tue, 19 Mar 2024 20:29:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] ASoC: ti: davinci-i2s: Opitonally drive DX pin
 during capture streams
Content-Language: en-US
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-14-bastien.curutchet@bootlin.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240315112745.63230-14-bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 15/03/2024 13:27, Bastien Curutchet wrote:
> The McBSP's DX pin that outputs serial data during playback streams can
> be used during capture streams to repeatedly output a chosen pattern.
> For instance, this can be useful to drive an active-low signal during
> captures (by choosing <0> as output pattern).

Are there really any other use of this than to pull down or up the DX
pin (0 or 0xffff)?

If you just use the pin as GPIO then you don't need to change anything
in the driver, The playback would not erach the pin, so no need to block it.

> Enable this behaviour when the device-tree property 'ti,drive-dx' is
> present. DX pin is driven with the provided pattern every time a
> capture stream is launched.

It is an interesting use of the hardware... You are controlling an
external device (light an LED when capture is on)?

> This property is not compatible with classic playback stream so
> davinci_i2s_trigger() returns an error if a playback stream is started
> while 'ti,drive-dx' flag is present.

Propbaly add the .startup() callback and block the playback right there?

> 
> This has been tested on a board designed of a DAVINCI/OMAP-L138 where
> the DX pin is linked to the chip select pin of the converters of the
> capture side.

Isn't the DX will be pulled down as soon as the McBSP is enabled?
Can you just re-configure the PUPD_SEL for the pin group to make the pin
to be pulled the other way?

> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  sound/soc/ti/davinci-i2s.c | 74 ++++++++++++++++++++++++++++++++------
>  1 file changed, 63 insertions(+), 11 deletions(-)
> 
> diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
> index 13e349e7a6ec..e289a84bdd6a 100644
> --- a/sound/soc/ti/davinci-i2s.c
> +++ b/sound/soc/ti/davinci-i2s.c
> @@ -101,6 +101,9 @@
>  #define DAVINCI_MCBSP_PCR_FSRM		(1 << 10)
>  #define DAVINCI_MCBSP_PCR_FSXM		(1 << 11)
>  
> +#define PLAYBACK_CLOCK			1
> +#define CAPTURE_CLOCK			0
> +
>  enum {
>  	DAVINCI_MCBSP_WORD_8 = 0,
>  	DAVINCI_MCBSP_WORD_12,
> @@ -164,6 +167,8 @@ struct davinci_mcbsp_dev {
>  
>  	bool sync_err;
>  	bool free_run;
> +	bool drive_dx;
> +	u32 dx_val;
>  };
>  
>  static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
> @@ -187,6 +192,19 @@ static void toggle_clock(struct davinci_mcbsp_dev *dev, int playback)
>  	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, dev->pcr);
>  }
>  
> +static int davinci_drive_dx(struct davinci_mcbsp_dev *dev)
> +{
> +	unsigned int spcr;
> +
> +	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_DXR_REG, dev->dx_val);
> +
> +	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
> +	spcr |= DAVINCI_MCBSP_SPCR_XRST;
> +	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);



> +
> +	return 0;
> +}
> +
>  static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
>  		struct snd_pcm_substream *substream)
>  {
> @@ -194,6 +212,9 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
>  	u32 spcr;
>  	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
>  
> +	if (!playback && dev->drive_dx)
> +		davinci_drive_dx(dev);
> +
>  	/* Enable transmitter or receiver */
>  	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
>  	spcr |= mask;

if (dev->drive_dx) {
	spcr |= DAVINCI_MCBSP_SPCR_XRST;
	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_DXR_REG, dev->dx_val);
}

and no need for the davinci_drive_dx() function, plus it makes it
symmetric of what you do on stop()

> @@ -212,9 +233,17 @@ static void davinci_mcbsp_stop(struct davinci_mcbsp_dev *dev, int playback)
>  	/* Reset transmitter/receiver and sample rate/frame sync generators */
>  	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
>  	spcr &= ~(DAVINCI_MCBSP_SPCR_GRST | DAVINCI_MCBSP_SPCR_FRST);
> -	spcr &= playback ? ~DAVINCI_MCBSP_SPCR_XRST : ~DAVINCI_MCBSP_SPCR_RRST;
> -	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
> -	toggle_clock(dev, playback);
> +
> +	if (!playback) {
> +		spcr &= ~DAVINCI_MCBSP_SPCR_RRST;
> +		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
> +		toggle_clock(dev, CAPTURE_CLOCK);
> +	}
> +	if (playback || dev->drive_dx) {
> +		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
> +		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
> +		toggle_clock(dev, PLAYBACK_CLOCK);
> +	}
>  }
>  
>  static int davinci_i2s_tdm_word_length(int tdm_slot_width)
> @@ -408,6 +437,10 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  	}
>  	if (inv_fs == true)
>  		pcr ^= (DAVINCI_MCBSP_PCR_FSXP | DAVINCI_MCBSP_PCR_FSRP);
> +
> +	if (dev->drive_dx)
> +		pcr |= DAVINCI_MCBSP_PCR_CLKRP;
> +
>  	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
>  	dev->pcr = pcr;
>  	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, pcr);
> @@ -562,6 +595,9 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
>  		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
>  	}
>  
> +	if (dev->drive_dx)
> +		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(2);
> +
>  	if (params_channels(params) == 2) {
>  		element_cnt = 2;
>  		if (double_fmt[fmt] && dev->enable_channel_combine) {
> @@ -611,9 +647,9 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
>  	xcr |= DAVINCI_MCBSP_XCR_XWDLEN1(mcbsp_word_length) |
>  		DAVINCI_MCBSP_XCR_XWDLEN2(mcbsp_word_length);
>  
> -	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK || dev->drive_dx)
>  		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG, xcr);
> -	else
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
>  		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
>  
>  	pr_debug("%s - %d  srgr=%X\n", __func__, __LINE__, srgr);
> @@ -628,16 +664,21 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
>  	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
>  	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
>  	u32 spcr;
> -	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
>  
>  	davinci_mcbsp_stop(dev, playback);
>  
>  	spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
> -	if (spcr & mask) {
> +	if (spcr & DAVINCI_MCBSP_SPCR_XRST) {
>  		/* start off disabled */
>  		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
> -					spcr & ~mask);
> -		toggle_clock(dev, playback);
> +					spcr & ~DAVINCI_MCBSP_SPCR_XRST);
> +		toggle_clock(dev, PLAYBACK_CLOCK);
> +	}
> +	if (spcr & DAVINCI_MCBSP_SPCR_RRST) {
> +		/* start off disabled */
> +		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG,
> +					spcr & ~DAVINCI_MCBSP_SPCR_RRST);
> +		toggle_clock(dev, CAPTURE_CLOCK);
>  	}
>  	if (dev->pcr & (DAVINCI_MCBSP_PCR_FSXM | DAVINCI_MCBSP_PCR_FSRM |
>  			DAVINCI_MCBSP_PCR_CLKXM | DAVINCI_MCBSP_PCR_CLKRM)) {
> @@ -646,7 +687,7 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
>  		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
>  	}
>  
> -	if (playback) {
> +	if (playback || dev->drive_dx) {
>  		/* Enable the transmitter */
>  		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
>  		spcr |= DAVINCI_MCBSP_SPCR_XRST;
> @@ -659,7 +700,7 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
>  		spcr = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SPCR_REG);
>  		spcr &= ~DAVINCI_MCBSP_SPCR_XRST;
>  		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SPCR_REG, spcr);
> -		toggle_clock(dev, playback);
> +		toggle_clock(dev, PLAYBACK_CLOCK);
>  	}
>  
>  	return 0;
> @@ -672,6 +713,11 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>  	int ret = 0;
>  	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
>  
> +	if (playback && dev->drive_dx) {
> +		dev_err(dev->dev, "Playback is not allowed when drive-cs flag is set\n");
> +		return -EINVAL;
> +	}
> +
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:
> @@ -779,6 +825,12 @@ static int davinci_i2s_probe(struct platform_device *pdev)
>  
>  	dev->free_run = !of_property_read_bool(pdev->dev.of_node, "ti,disable-free-run");
>  	dev->sync_err = of_property_read_bool(pdev->dev.of_node, "ti,enable-sync-err");
> +	dev->drive_dx = false;

no need to initialize it to 0, dev is allocated with devm_kzalloc()

> +	ret = of_property_read_u32(pdev->dev.of_node, "ti,drive-dx", &dev->dx_val);
> +	if (ret && ret != -EINVAL)
> +		return ret;
> +	if (!ret)
> +		dev->drive_dx = true;

if (!ret)
	dev->drive_dx = true;
else if (ret != -EINVAL)
	return ret;

>  
>  	/* setup DMA, first TX, then RX */
>  	dma_data = &dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK];

-- 
Péter

