Return-Path: <linux-kernel+bounces-138748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B7C89FA76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521FBB29AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3872B15F3E1;
	Wed, 10 Apr 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R6qshOfs"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417DD15DBC4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759233; cv=none; b=V3BBf1hVVu07Jzwtezv9q7VdqE8KWLjGSJY55vQhzlqaZCBAjf04ThzA7majhWbui3NZTKA2+qyHMP03hR0dWDEaMwgFqZz9W0/ncXymwekZ/4okykB8SHD0t87pGsL0EDhIay1u1x4EdWMNYNbjg/1UA/PaoUlETHXlvEEh9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759233; c=relaxed/simple;
	bh=ZQv+Cv6FtAbS0T/V0OLwICdE4U3tkVtKCw2XykvAM6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiNSPQrv5Zs9gF1FV4+2gLol5YMiQCp4UQVZryaa1wu4GCTBQORmdfkktv6bW+NPrNf93TG5nb3QNNgvoWzt9BROHWYY5BjH8oXIRxdGQmqN9wtiVqN3XBYNg65OfwZa8Z/bw+Ozv0yO8Htp2pbMEnBggByV+mgsYQoYp/AXrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R6qshOfs; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so5034238f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712759228; x=1713364028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFeYAr3tgWzelp4Qc502/jt9QrT83vOai+OT7e3SF3I=;
        b=R6qshOfsJU7pmFY80xi8VFZwgh/Ivl7dRFAXLdXeoH97GbYFfhEgCAIOBN2XC+njzD
         H4/BFFZ/Lx/Xk4eaN50r+4MMGwYoLdzG3QuLjHRuRN4d6gRU/PeCgjc/d/U6LmWpMXq5
         UrZFHINvFfGnjNdCRi2JcyTyQiqjkZ8OSjgTG/DHdOttEGhhxR1AZY49IC1Mz6w4etow
         1mCdzlfHhT6p7lBDO2+DPZuAFfbItc6mNGnitd252x39LR5HMCqmRwFscdfhlNe9LfFl
         8D+jxh8S3L+Z4ZGX78QPU5Ijl5/Wgk0UjGmBcms4NkuN9kKTjYDsFyE8yAcaEzhaBt4X
         r1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712759228; x=1713364028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFeYAr3tgWzelp4Qc502/jt9QrT83vOai+OT7e3SF3I=;
        b=parCrWjjeMBayxJ/qbfxqXLI5xI8LsoFgtB0OsTdt3boUDYZoW/o2xl+tAVBdGsMOm
         1hzzQnW1EDQA2PVvMXrKpVKEzHjt70qxkC/nGrQNMqhBNEhNUzlZrKX6HB5Jk9FY6MZs
         IBcJlshRkrsv0AdjXiyloqHP9cbs7Fw0Pfnr5AyXgzBWX13nnJae+GqDhAr+5/wQvnJC
         Q3MO9oirlPprvYqK9izOQwPpcVyV++i6wFOON/ZDg/xBa8u9ZdF1scKu0hgZ5qg+wJlU
         ZYmll9/luH0opNr+uBcq1Z9pMrt5KGcHGWxvRIgFOmzr4mcgCK4zcjUtgqwF+Af7Vs1/
         dQdg==
X-Forwarded-Encrypted: i=1; AJvYcCWpwc94fewRGtyWibtlTkb9Y9gmJCq5Ny1uJxxQHbwTVPYrGmmCSJapH4urWAaKr49gDmRRqbeMBpUAGGvZEfhvlrP7dc2KKNSDS1nV
X-Gm-Message-State: AOJu0YwSgqnFsQwXbCzyWshiW+c5/Xkvl/lZksY5rJ83MKCBRHceY2A+
	Cl94mBQzmZlLmVht2aQndproc6Z2w3hfNVzED2XHqs6GJCui+txhyqt79c61V/s=
X-Google-Smtp-Source: AGHT+IGSvVBdvyjiYeq1pMtO732y4Er6q/giXpAXAVvEFvGgI0ZjYjMZMlOGyJUSQFXanGM+QGMBOw==
X-Received: by 2002:a05:6000:188a:b0:344:4bcc:ed28 with SMTP id a10-20020a056000188a00b003444bcced28mr3345746wri.32.1712759228609;
        Wed, 10 Apr 2024 07:27:08 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id b17-20020a5d40d1000000b00343cad2a4d3sm13846851wrq.18.2024.04.10.07.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:27:08 -0700 (PDT)
Message-ID: <d334ddc4-3c8e-49d7-8940-30f78bff823f@baylibre.com>
Date: Wed, 10 Apr 2024 16:27:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/18] ASoC: mediatek: Add common snd_soc_ops
 .startup() callback
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 broonie@kernel.org
Cc: wenst@chromium.org, lgirdwood@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
 trevor.wu@mediatek.com, maso.huang@mediatek.com,
 xiazhengqiao@huaqin.corp-partner.google.com, arnd@arndb.de,
 kuninori.morimoto.gx@renesas.com, shraash@google.com,
 nicolas.ferre@microchip.com, u.kleine-koenig@pengutronix.de,
 dianders@chromium.org, frank.li@vivo.com, allen-kh.cheng@mediatek.com,
 eugen.hristev@collabora.com, claudiu.beznea@tuxon.dev,
 jarkko.nikula@bitmer.com, jiaxin.yu@mediatek.com, alpernebiyasak@gmail.com,
 ckeepax@opensource.cirrus.com, zhourui@huaqin.corp-partner.google.com,
 nfraprado@collabora.com, alsa-devel@alsa-project.org,
 shane.chien@mediatek.com, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20240409113310.303261-1-angelogioacchino.delregno@collabora.com>
 <20240409113310.303261-8-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 09/04/2024 13:32, AngeloGioacchino Del Regno wrote:
> MediaTek platforms are typically setting PCM rate and channels
> constraints for playback, capture and HDMI/DisplayPort playback:
> commonize the startup callback by adding the PCM constraints data
> to the mtk_platform_card_data structure and by reusing the common
> mtk_soundcard_startup() function for all of them by getting back
> the parameters from the aforementioned struct.

-- 
Regards,
Alexandre

