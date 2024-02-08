Return-Path: <linux-kernel+bounces-57879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF86384DE8F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4ADAB27DAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163036A8CF;
	Thu,  8 Feb 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSksu82l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E2F1DFCE;
	Thu,  8 Feb 2024 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389032; cv=none; b=XksdVYN4Ubu7aPvk9NQWrcalOpJBNANE9ftDpEPQdFtkbKYygxcBEdW1jl6l8g18vufbTACqAWqKn/lbvDPAnFC6DhuSkyCA90Kos9oCjf7E4E9on0xC9cnNrvaSu+d/4pzun9Fg4keSeq0p4MN5hd9XES22U971meJbHF02lfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389032; c=relaxed/simple;
	bh=zksSj6uCeVonDM34Te32vekuygLY7OZJA69vN03ifDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3cdKgmjDIsRZ07bzGKvlUu6iJN8cDhkrh8YyweGmQpciuORbRKotbEDyfTR7ulq3+z9PllYAQu+m1vyXt8rEzN1iy3vnxLO5JmDReQg0qabvUgGEZJO+//BTtolmZft+qm8Vp9YZP9gkBnnSc+YshUZ55ZC9iZjFtLlw1P8d5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSksu82l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCA3C43390;
	Thu,  8 Feb 2024 10:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707389031;
	bh=zksSj6uCeVonDM34Te32vekuygLY7OZJA69vN03ifDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSksu82lBUqtHcM2MfgxBnk1ct6U5KFcn9cLymXaK2gT43MzS783n3A96Be/M+d8F
	 TAMyKKibOepaa7Uc9+1JNuOStSYfJIilXbrwS1qFf1PWfCUEUgFtuaGk+eKZhc1SUf
	 XBVEa9s8H8d4WiKF1xjC32VfYLy6kdC10Km94Z/C0e0bXYnypBioEuO0loGyVTmvnH
	 qpvq0+r0abSDLqhDxCrTzmWO55gllsw7xrzRIIzDAaj7o5Ks97+yssJqJon5BGlclG
	 D2Di2/dGtjcgBQCDTSUgatFQXcl5tkOTtSdZaIYJ/7oEQ31YBP2cbjUDxjQxRxrIoX
	 bgrWrifGogNkw==
Date: Thu, 8 Feb 2024 10:43:44 +0000
From: Lee Jones <lee@kernel.org>
To: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org,
	Dharma Balasubiramani <dharma.b@microchip.com>
Cc: hari.prasathge@microchip.com, manikandan.m@microchip.com
Subject: Re: (subset) [linux][PATCH v5 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Message-ID: <20240208104344.GG689448@google.com>
References: <20240131033523.577450-1-dharma.b@microchip.com>
 <20240131033523.577450-4-dharma.b@microchip.com>
 <170738870103.916068.17422553727568917627.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <170738870103.916068.17422553727568917627.b4-ty@kernel.org>

On Thu, 08 Feb 2024, Lee Jones wrote:

> On Wed, 31 Jan 2024 09:05:23 +0530, Dharma Balasubiramani wrote:
> > Convert the atmel,hlcdc binding to DT schema format.
> > 
> > Align clocks and clock-names properties to clearly indicate that the LCD
> > controller expects lvds_pll_clk when interfaced with the lvds display. This
> > alignment with the specific hardware requirements ensures accurate device tree
> > configuration for systems utilizing the HLCDC IP.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
>       commit: 7dd93269787781869d3dbb23138ec1455d26b047

Replaced with v6.

-- 
Lee Jones [李琼斯]

