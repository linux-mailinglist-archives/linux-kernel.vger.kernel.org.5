Return-Path: <linux-kernel+bounces-46054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813328439C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0746AB23FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8F012BF0D;
	Wed, 31 Jan 2024 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohMMVoOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831B12BF02
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690600; cv=none; b=ELV9eRj2UyDoA5bcOl4455llCPetZ8ZiyxQdTlGvAQLtAE7R7ITt3lcISuBncU6JLqHpWd1NT5F8al76msuCE3GTvwlFtq2nf7sDMxNgmJIVStY7+eHPs1t4KnvtUf0qu1UHzxK3N8boc2CkHbtT7ZsdAUdTAeshbgdeQIIqTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690600; c=relaxed/simple;
	bh=WJRAb5Q0qQXjV7SaWuZDaXL1s0bEk9w7Ko1XKjSZ4zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGNKD/KqxSVIc5MlESI8lE125rCmNeEwRxx5DeAhkqxmb7ENGywygcbjatVg1ac8tAmjIX4Mwh70lWKD12aeqiBoN5bhYANKnMq+PJAF5cs+UVMyqmqIk7vC171TbJQKFqKwiU9qjwpc/ny3/Lr2fEcxJvvXAw+yY2MzccLOSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohMMVoOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4351C433F1;
	Wed, 31 Jan 2024 08:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706690600;
	bh=WJRAb5Q0qQXjV7SaWuZDaXL1s0bEk9w7Ko1XKjSZ4zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohMMVoObrAoUopRKLHd1DPwQaDRpZVNxDLVfBtIdTXFfvdyIyV4LN3GQ15t44s9As
	 Ds08gmn31cX+Hnm96xNsNgv1XX9jXLZTEFsx0G1kYhUwN3fgyEI5j2uqbQeNTDmEpI
	 I4B2yXNVQwqzxXsz909sid27LUSGqTnU7XA7/nqI5DwxwLKHgl8i/Bu+fRPdbm7YE3
	 T9ZX2zcL7KlKzU0fJWbbsDKWMV9UkyWAVcDenzkSanN4H1CQtss5pB+4hhzsri8z42
	 Js3MYyFnkWMgIDp9njQqfJqompl/m76OFGa6+WFdLCGBHBbirGSU5LyVuZkqC4e7XL
	 SP0LCBz90yvRQ==
Date: Wed, 31 Jan 2024 08:43:13 +0000
From: Lee Jones <lee@kernel.org>
To: Manikandan Muralidharan <manikandan.m@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org, airlied@gmail.com,
	daniel@ffwll.ch, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hari.PrasathGE@microchip.com,
	Balamanikandan.Gunasundar@microchip.com,
	Durai.ManickamKR@microchip.com, Nayabbasha.Sayed@microchip.com,
	Dharma.B@microchip.com, Varshini.Rajendran@microchip.com,
	Balakrishnan.S@microchip.com
Subject: Re: [PATCH RESEND v7 3/7] drm: atmel-hlcdc: Define SAM9X7 SoC XLCDC
 specific registers
Message-ID: <20240131084313.GC8551@google.com>
References: <20240129092319.199365-1-manikandan.m@microchip.com>
 <20240129092319.199365-4-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129092319.199365-4-manikandan.m@microchip.com>

On Mon, 29 Jan 2024, Manikandan Muralidharan wrote:

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

>  2 files changed, 52 insertions(+)

-- 
Lee Jones [李琼斯]

