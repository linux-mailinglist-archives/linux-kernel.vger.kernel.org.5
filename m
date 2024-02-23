Return-Path: <linux-kernel+bounces-78783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304398618C6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97E31F26137
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598612A154;
	Fri, 23 Feb 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mveeB0fM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007B4A1D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707881; cv=none; b=lgKuTlOR8ejtBQnq8+7xEwEysiXEPRQCEx6wandQx9qVArPVdbZlgFUBGeQ+gAyLIWcSNQCBw9KjmqvyVAU4bSp85+fFm/WdU9Ezh15I7esIQP1f4PCGfB1eb9bf0sBsKDjrg+cKm8Ote1UshpWaVAqCTr4Q10Ss07DqKu6A/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707881; c=relaxed/simple;
	bh=mVR7nata20NPPlFX99/revGNTN4OGrTKvTgLLiNYWxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCh4ZHew5TLgbQrXO10hCxv5f0CXqXj0xgBpd+NQxyWuWxJkW/1vgyiDLRDcFJK5B63QBb/HDgSkIrhYXdPs9Mef6s/muVqdo2NzWfohHZ8E84+DPCtLU1FAyTdNL2Dj2TdthNYHC+D9PiuuJIYylALi6HkJIFtOZvlZfDoIN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mveeB0fM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9928EC433F1;
	Fri, 23 Feb 2024 17:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708707880;
	bh=mVR7nata20NPPlFX99/revGNTN4OGrTKvTgLLiNYWxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mveeB0fMIRAy+kb67KBw+HRe3t8G2jOt8w1u/8A5SunLiKrwN5X+Z1+QxQSRE+xwT
	 ukPOU48Rbp3Bt93amFd8YQc2wCqTBtlI1fN5zEIHwHwJJcObNYtFb/BEW7P+Oo1NFF
	 lfWTldeyCf1Giko5E61KyDzcgBO69T3Qg3ki+OJy1I1HpyIAnhwLC7rQr87kwA2BTB
	 hzIGltTE4Wvg2NLaY+VdchHBJbnqWX80eDYJP2fFvZsa6j2Ud7ZJ6/Z1tOqD+CXAda
	 S4/culQPBPruKmHy6t1wenwCesBYImXjwKhgJETFU+tB7pL+I3vw5Yd+2WUmwmPy85
	 Xd1CKKyEXxhlA==
Date: Fri, 23 Feb 2024 17:04:33 +0000
From: Lee Jones <lee@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hari.PrasathGE@microchip.com,
	Balamanikandan.Gunasundar@microchip.com,
	Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
	Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
	Balakrishnan.S@microchip.com, Charan.Pedumuru@microchip.com
Subject: Re: [PATCH v8 2/7] drm: atmel-hlcdc: Define XLCDC specific registers
Message-ID: <20240223170433.GM1666215@google.com>
References: <20240221053531.12701-1-manikandan.m@microchip.com>
 <20240221053531.12701-3-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221053531.12701-3-manikandan.m@microchip.com>

On Wed, 21 Feb 2024, Manikandan Muralidharan wrote:

> From: Durai Manickam KR <durai.manickamkr@microchip.com>
> 
> The register address of the XLCDC IP used in SAM9X7 SoC family
> are different from the previous HLCDC. Defining those address
> space with valid macros.
> 
> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
> [manikandan.m@microchip.com: Remove unused macro definitions]
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h | 42 ++++++++++++++++++++

>  include/linux/mfd/atmel-hlcdc.h              | 10 +++++

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]

