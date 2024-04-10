Return-Path: <linux-kernel+bounces-138547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B59089F338
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DAE1F2B018
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB6015E1E2;
	Wed, 10 Apr 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qo/aNGXx"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A315D5DB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712753896; cv=none; b=L/hpQpJAhm+8BWUN/g5TKNWZNd6UQGEg5MKn7PXXzm4ZnE0gCqt438giW9foMVtZXnuecC45yHv/Qjz81QDpKl20JDdvlVjaR4adYLzD2dUxwi1lreNeV1jeB2aJp9YkfPg4jzkF3PEhq4Z4Oas9+BrlmstqbDulHgU9B8OG4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712753896; c=relaxed/simple;
	bh=XvD5fOS/hQ7HPF9KYvW4fabBNiId/tBgRPWvKt02DhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CO+FRkstnIlMZh/8ze0LBjHKNFkQpJnJ2pzvhaHNevSkkbEnV2mJJsWqJdnygg2wtIePR3kPC2oDglb5N1fTNsj7B/GZXHy+/4CleJyWx3jUc9oc4E4CNJE8YaWlOLPNbJlhdJLxCi5Zgo6AO+a+jhfksckO5nX23DINei/iI1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qo/aNGXx; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34665dd7610so329509f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712753892; x=1713358692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAPCyLKBSHRTWSRRoqdJH1JxTgNtm+xffvG0gyEDWQ8=;
        b=Qo/aNGXxjrUKSLafOFe4kqGTXdywcDhIyb+D2RJoIL8MoP7akMSk1Mge0BuVmQQrpE
         KwRQAWfrHVtVfWFINSlOgPAhA4f9Vfq3os839cFuU0aSfvRx6Eg4hxippPBgbyudFq6x
         IDCyhs/jxVUs0IVXIOuTcfzwyzcsD6+zACc8BeYmW2rB4H/bdfkcnn1S39SnU7dlIMuI
         1TtQ1lRl/1cys3h25u5vJJtceF4PxApK+6BQMdyDlJLwkti/hKf7DBXCtM6coIFk8AXl
         VswfYJd1FxYFhUXinHRZ1VpcHd1eOzT+heN+JdkEeUkWh0tzUoKBLhixy+yRkjM5kjfV
         fqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712753892; x=1713358692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAPCyLKBSHRTWSRRoqdJH1JxTgNtm+xffvG0gyEDWQ8=;
        b=iBn89xW6Cutqlr91Qm05N8xtVR62mGy8uhXx7toGYtWF4q54OJHNd+mQTS/bq0uFm8
         M0g4KekYtVho43j1rSUQmWYP5trPTbc/uMxyzdwHGE6PRMs66K0jr+ZGaxB+HjkpA+wv
         7F2HHBx00s0LoNovht75vjieTm+QWNukzuFYIem/d7GQB9w6n0D07WNA8GmMUKk5coWk
         hgaW+3eB2OfrMLyAc9haihvB5EKCqy3YYWa2FeQiGtyX2G59PWeB/8c/W5O12berF5EO
         Q2xwQQhrn2qiy1VZS+2sWOw+R4MVOUPEULDPQJy1mK50wfQHEpFGWkRPVzFcV4E2AD09
         EvSg==
X-Forwarded-Encrypted: i=1; AJvYcCU9RLeoxZqMeGIMR0jtpqMX44EHfQOiJp46RRZTEsnDK5OjrdvP6yul0flp/Xl8AGTjGS+dqo/as79SooIq7Viq9+3TI8pIrr8WJXyV
X-Gm-Message-State: AOJu0YzqZYUbff20amRREyk7bovWlLm8Nkjy8ZbHF/yB5MVvDowRZghD
	ytEoWaqejk0TtB1jBuGZbOdfY6Q8BhvXsvHckzDXUFP6JEbaQU0L8pYpi2IuPac=
X-Google-Smtp-Source: AGHT+IHfa120qRAfspKcAyRMy5PXxHlCGJzmW0vlTzwyQGnoeYFwCg8fQKa0TokP1NrBdWntPAlpFg==
X-Received: by 2002:adf:ee8c:0:b0:346:47d6:5d17 with SMTP id b12-20020adfee8c000000b0034647d65d17mr1758280wro.57.1712753891611;
        Wed, 10 Apr 2024 05:58:11 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d4104000000b00343e392829dsm13404941wrp.97.2024.04.10.05.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:58:11 -0700 (PDT)
Message-ID: <4c43eafe-f173-4a35-962f-a5f5f020a587@baylibre.com>
Date: Wed, 10 Apr 2024 14:58:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/18] ASoC: mediatek: mt8188: Migrate to
 mtk_soundcard_common_probe
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
 <20240409113310.303261-4-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Similar changes has been done for mt8365, it works.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 09/04/2024 13:32, AngeloGioacchino Del Regno wrote:
> Add mtk_soundcard_pdata platform data for the MediaTek common sound card
> probe mechanism, including a driver/soc-specific probe extension (used
> for bits that cannot be commonized  hence specific to this driver), and
> change the probe function to mtk_soundcard_common_probe.

-- 
Regards,
Alexandre

