Return-Path: <linux-kernel+bounces-138861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612FF89FB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B06A28C898
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0132C16E882;
	Wed, 10 Apr 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b3M0VMCe"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1E16E869
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762074; cv=none; b=B2QZcCK0CeqwcSMF+EOZF2ZEdiQEC+yUOWw5q3ZNDLBMjw8RvH7a1r799jlcN+T1G9dLRN1UMqORiypMdfbS9dVUnMgUzTB1qycr5waNjaxh1wEnwgjUGRKaQdt7S/siEXrPO71EhZ1CgcBTzPpIZgd7M14Oi1Ecl4IAE4rl/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762074; c=relaxed/simple;
	bh=xJfhI9QPat0r98+lhtVmHv0dk3LFeZuD6e/my70ds9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgoxEi+UeEYWXN0JS4PqAlEIGSnNCXWbzTxT+XKjqIvyqk2OtXoSeEomcT9/cIaK4KUpOaRQnzYnjSyOi7enRp/Ch5K64Dojq2qYz7tvi6Nom0z9DyCzc6qTAlj0btTH0uIrYNq1sk4bFyZHTgc8mxTq59kYM0WJHl32VsD0TMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b3M0VMCe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3454fbdd88aso3821940f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712762071; x=1713366871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTWr7zCunTSu7yV6LyAJ4TilgZ8hrFbQ0RRY5+GeIDY=;
        b=b3M0VMCepZmZP7Nl75QXw13xlqXQdDX50hWB5MSbNZ/RV0U1dGT7aJDIif7sCnjVwv
         bX+OAkbrcfggDhQ5dXxPvWQE3v+3aFt4ZnQXznZlVAgv7zCgUYsDfkAfhiG0hvI222er
         hdP4BzBhYVhzAAryhx9Ih9+0W+TGb7JWNhrHnexSsTCyF+iYMWDeHqJ4PfkDXqQ19+mL
         A7Sp0Z4457LtmPeB5PV8jznZe/36rz7V6dtQJFg8vV3C0QJg+wlbG7UIJo00+7s42PaY
         GH767zZmkvqGIK001jf2KVBVTD42rv1KKUVokLbt6QiDMJwKIBzlOk9cdK5YnCCJkhSa
         uEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762071; x=1713366871;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTWr7zCunTSu7yV6LyAJ4TilgZ8hrFbQ0RRY5+GeIDY=;
        b=Nh9g3oFVz3d9YKKueP7G6PiOUoHAPZIIdwcGCS5wa+FtBmcYOJTjeTy8Gh50n9Mbqe
         0kfLh87mP+FimYVl3P5sii0geTDDO0w0AGhPgL9NVzoNBt7e1YJ6jRW6cg1tr641llNB
         Urc9Vd8bwepuVaVMKTsGnKcf0WLFw0LuxXIRiQ8mUdgxkyyQkZgkbWHEtf5LulF+H/S2
         qAFqmMqJoCH1TNQga2N6KhFMhyXxMfkiQ8XW5ugPt4pce3IHzrvHSh5QoUXMihqAlv1Q
         Yc9aAFTSnaWkvoRGpRSr+uKDLqzvOdbgt4qzVE9R3yDqL7BCAKnCK30DV4I+KQxoQ8ul
         f0JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdG9MXccFb91RYDuGI+od3b2Ba9B2NAKPSI3/r2u2eT8svjXV3IjBc4Pm9KBzfmkVOc2gYsqcUjQFSz2bdY7Mq/wWhXwdMsY3B+guY
X-Gm-Message-State: AOJu0Ywrg+hXUg/LGTWy7eii1tv1UxVn7H3XLXf7DHRGMM/VfIRB1oqs
	D30YEYWiLL1N7JaC63JLcFwGIpJzecS9923eqnhEOkkSoTROLx0A/vE/EKagA5A=
X-Google-Smtp-Source: AGHT+IHsg96eOL2a4LJhVDQUrGOMuFbwCCDLT+zKpSk4ARDLKr/ObMqBjfvII1zIu2uKlKh/jpN3ew==
X-Received: by 2002:a05:6000:2a5:b0:343:7b6b:dcc6 with SMTP id l5-20020a05600002a500b003437b6bdcc6mr2373938wry.30.1712762070970;
        Wed, 10 Apr 2024 08:14:30 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id d26-20020adfa35a000000b003469e7f5c52sm176322wrb.80.2024.04.10.08.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 08:14:30 -0700 (PDT)
Message-ID: <437bdabd-f16e-4a2d-b9c2-55c91b2e399e@baylibre.com>
Date: Wed, 10 Apr 2024 17:14:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/18] ASoC: mediatek: Use common mtk_afe_pcm_platform
 with common probe cb
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
 <20240409113310.303261-13-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20240409113310.303261-13-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Also done for mt8365-afe-pcm in my serie

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 09/04/2024 13:33, AngeloGioacchino Del Regno wrote:
> Since the mtk-afe-platform-driver generic mtk_afe_pcm_platform now has
> a common .probe() callback, there is no reason to keep duplicating this
> function over and over in the SoC specific AFE-PCM drivers: switch over
> to register with the common bits instead.
> 
> Note that MT8186 was left out of this because it is registering some
> extra sinegen controls in the AFE-PCM probe callback and needs extra
> cleanups to be able to use the common bits.

-- 
Regards,
Alexandre

