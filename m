Return-Path: <linux-kernel+bounces-166046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C65DF8B9533
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685711F21BF2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AF7225DD;
	Thu,  2 May 2024 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjrqIG4y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07537819;
	Thu,  2 May 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634567; cv=none; b=catXJDuC19nV4Tk4m5FSBIf04NLBmAvqdGd1ZcFj4P/7EUyY/sWgJn194u5sE8ov3Vxf+VlWo5gWVua/dk8O3D5nzv3avaSNLCeBFWXIMCCyi/LASb2hQO2+m5RPJ40Cdwq0CCCaJfYtS+JcnySbwP4HVBArF/4ZI0jfnetGyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634567; c=relaxed/simple;
	bh=dYUwhMXgVlfaVtNX51nJ9f4iUba7AISPkGOpTHRC3Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJJXazoH3n3ehX1NB9eQBrGpEiwkiPqsux32tA5fNQio+r/il+hnkIXpCGohhCzfZ/OHyh4O93ZLIGTlo7J6LxQoUxBJlfCpJMCmwbvtkSAwse3g730iOjnm1gQ2TEr2/nlt/1MfpPa/mmxzj7Hes8cNjcnqyGZzJH0v4wCokDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjrqIG4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45668C113CC;
	Thu,  2 May 2024 07:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714634566;
	bh=dYUwhMXgVlfaVtNX51nJ9f4iUba7AISPkGOpTHRC3Tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjrqIG4yJ5hB09AEXtgo6cllzpZvQNIElLoebW08nYy8qyyUXovS8Q6TtTS9dNst7
	 r/OSNYpewZ46C5wN0BjfV4zU0CqtdI5jyVnu3tvKKv5R7BSVkMgC7C05AJcwgJ5xZL
	 EIoNyr75WetoTfYFH2F5LDleSQe+sukxjstj3wEB2LnomMykLUfz3KP1Z3j08zc0S9
	 FBPgubsGBve6FWJRuargAwMXwjMMXTPUAdTNZauSnPIzHH/ogD7r8O+b9T9odcM3hN
	 wiwNDImqn9nVcNiAnaWqADW/4g08dNGR/P6EwHUVT09ZvUt875HuoDC/z3OsMFEF9B
	 QjBrj5HQLJa5g==
Date: Thu, 2 May 2024 08:22:39 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-omap@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v2 00/19] backlight: Constify lcd_ops
Message-ID: <20240502072239.GD5338@google.com>
References: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>

On Wed, 24 Apr 2024, Krzysztof Kozlowski wrote:

> Hi,
> 
> Changes in v2:
> - Collect tags, including wrongly places Thomas' tag (which requires me
>   to manually edit 15 other patches to drop it).
> - Combine here checkpatch patch:
>   https://lore.kernel.org/all/20240414185440.288812-1-krzk@kernel.org/
> - Link to v1: https://lore.kernel.org/r/20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org

What's missing?  Are we good to go?

> Dependencies
> ============
> All further patches depend on the first patch.  Therefore everything
> could go via backlight tree (please ack) or via cross-tree pulls. Or
> whatever maintainer choose, just coordinate this with backlight.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (19):
>       backlight: Constify lcd_ops
>       backlight: ams369fg06: Constify lcd_ops
>       backlight: corgi_lcd: Constify lcd_ops
>       backlight: hx8357: Constify lcd_ops
>       backlight: ili922x: Constify lcd_ops
>       backlight: ili9320: Constify lcd_ops
>       backlight: jornada720_lcd: Constify lcd_ops
>       backlight: l4f00242t03: Constify lcd_ops
>       backlight: lms283gf05: Constify lcd_ops
>       backlight: lms501kf03: Constify lcd_ops
>       backlight: ltv350qv: Constify lcd_ops
>       backlight: otm3225a: Constify lcd_ops
>       backlight: platform_lcd: Constify lcd_ops
>       backlight: tdo24m: Constify lcd_ops
>       HID: picoLCD: Constify lcd_ops
>       fbdev: clps711x: Constify lcd_ops
>       fbdev: imx: Constify lcd_ops
>       fbdev: omap: lcd_ams_delta: Constify lcd_ops
>       const_structs.checkpatch: add lcd_ops
> 
>  drivers/hid/hid-picolcd_lcd.c            | 2 +-
>  drivers/video/backlight/ams369fg06.c     | 2 +-
>  drivers/video/backlight/corgi_lcd.c      | 2 +-
>  drivers/video/backlight/hx8357.c         | 2 +-
>  drivers/video/backlight/ili922x.c        | 2 +-
>  drivers/video/backlight/ili9320.c        | 2 +-
>  drivers/video/backlight/jornada720_lcd.c | 2 +-
>  drivers/video/backlight/l4f00242t03.c    | 2 +-
>  drivers/video/backlight/lcd.c            | 4 ++--
>  drivers/video/backlight/lms283gf05.c     | 2 +-
>  drivers/video/backlight/lms501kf03.c     | 2 +-
>  drivers/video/backlight/ltv350qv.c       | 2 +-
>  drivers/video/backlight/otm3225a.c       | 2 +-
>  drivers/video/backlight/platform_lcd.c   | 2 +-
>  drivers/video/backlight/tdo24m.c         | 2 +-
>  drivers/video/fbdev/clps711x-fb.c        | 2 +-
>  drivers/video/fbdev/imxfb.c              | 2 +-
>  drivers/video/fbdev/omap/lcd_ams_delta.c | 2 +-
>  include/linux/lcd.h                      | 6 +++---
>  scripts/const_structs.checkpatch         | 1 +
>  20 files changed, 23 insertions(+), 22 deletions(-)
> ---
> base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
> change-id: 20240414-video-backlight-lcd-ops-276d8439ffb8
> 
> Best regards,
> -- 
> Krzysztof Kozlowski <krzk@kernel.org>
> 

-- 
Lee Jones [李琼斯]

