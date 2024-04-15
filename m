Return-Path: <linux-kernel+bounces-145208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA66E8A50D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31BA7B2445A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC07F7A141;
	Mon, 15 Apr 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiokVn3p"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D60745E1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185886; cv=none; b=fyN4xA2Cg0bqrjGhcT9IWPsaqgDUL8GJnZhw0tED+43fObrB9pQxL5vxkhbBi+SJJgFc4m0VO/ihEtciYWkqR+h7j43tL3VaQ8UqUo63zJOJhdrWwl4rk+Jp7vXuHE1xCDWvnJNfrboAuK64BzVN0inGdZ9qxKUGMTCuxC6iXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185886; c=relaxed/simple;
	bh=JuY8Z9SFKAjd485RmpEzDICfCQ5m1DLNGhij0gfh/6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGmb406IyZdON5a11rUL3keO8BGlPWOv/HMwPm97tcdAM45nYuYs+l+JDJdZx935RrK+tdb8H58ykXgzyGnYfsXubdNMxtWa3F8iOsCMZ0RRVOx3KbT1bCTbgaahUxvInbtFlEmJtrxwf4JpPXZom8NtlWgnUiIEIK1n5HscH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AiokVn3p; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so22649725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185883; x=1713790683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLf6fjTVo3wUpV33VREESp7KlEYlqmXsy5vGMydSZn8=;
        b=AiokVn3p5J7rw6aHxKGQ4DO0ZtXqAG1EQ/RcKvpwk3/FaLLKAb5HVvqqxaAqie6oy7
         AZlO1P6MdMUCEfya+KJEdzzVjP72OP17GzKVbNyVbgvea5G685QIT7f0NgKfn2QHYDH/
         rZgaYT1LE0wcvSIJp7fgzD3d9RcCxocKDGaa8eFTwP9DJdRGiTyU7OAcs3kNIRKR99JZ
         nXzqPcAFHxpRF94VNnGUnwKb9JgnzeFrs7TIKO/Sg4mt3vupA4sXxrjHVIF6ICMni3t7
         95u5xfDfFY+jZdiv4njyD9hd3sTxdfQiKNSWNNJXm3BvGJl0Ru3Q0tq2ntg2822UzMrV
         h1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185883; x=1713790683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLf6fjTVo3wUpV33VREESp7KlEYlqmXsy5vGMydSZn8=;
        b=csHx4HLd5hNSyzVOvy7p4zUZUU4gDgBNyoE3HYUagN8huotrQ7qPx2M4d/3K9BH+56
         iqBtahM2gpJPpIOcqI/OYMixZhF5KvAgIiKXsy8/K2iH2SBfHbdUoLlwcXvS6Cf1Uai/
         Wj4MST762bdAHw6RmXEL06iWcpmJbB6aHa6ZjsWsh6VC87E1eZKgZmOlHh/9+qRsSLIH
         syAKBov45SdHlEEF2HhEpO6p9bpbFs4Aor8+6rNeNVFpRvNvHqqyHLpS8SQJrlPWpalA
         dJfbkeQM4VRl3wnT5FAQZ+Zt83fn7NOSbf/vbnw2yg+rt/4uFchtLOZ2+8hwBTloqFv7
         YXeg==
X-Forwarded-Encrypted: i=1; AJvYcCVQxZrtSLKXMd6Mn/Fh7iHtf4P47X9MqrUE9MPZFlRzOgc+UIa0TQuyETbNwa6jp4mY3wPkKUB3rG0sibSQXVH5J+9PhZ3Avt/dxayu
X-Gm-Message-State: AOJu0Yxglcc8Tkz5gcDpfEGBlqJaHrJVHrAKFEUwRKBH5pRfQLIl9wE8
	gt9W32K9r/T1bYYotGpj2tkVCnKRAlsfrSaUBMWJJa/f2MD8Esm4hxm7qpoSlmo=
X-Google-Smtp-Source: AGHT+IEAm03/mAgN/wD9H5pLJe3fIVolEbWIhU988XB39qknEhlAzrxruGN5U/LF93zzxG0bYawaFQ==
X-Received: by 2002:a5d:595b:0:b0:345:e750:6d6c with SMTP id e27-20020a5d595b000000b00345e7506d6cmr7277507wri.30.1713185882741;
        Mon, 15 Apr 2024 05:58:02 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id f18-20020adfe912000000b00343d6c7240fsm12032238wrm.35.2024.04.15.05.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:58:02 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:58:00 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
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
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 00/18] backlight: Constify lcd_ops
Message-ID: <20240415125800.GO222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:35:58PM +0200, Krzysztof Kozlowski wrote:
> Hi,
>
> Dependencies
> ============
> All further patches depend on the first patch.  Therefore everything
> could go via backlight tree (please ack) or via cross-tree pulls. Or
> whatever maintainer choose, just coordinate this with backlight.

Thanks for the tidy up.

I've added my Reviewed-by: to all the backlight patches (for Lee) and
I'm happy with the other patches too... but I didn't want my R-b on the
HID and fbdev patches to be confused for an ack.


Daniel.


> ---
> Krzysztof Kozlowski (18):
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
>  19 files changed, 22 insertions(+), 22 deletions(-)
> ---
> base-commit: 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39
> change-id: 20240414-video-backlight-lcd-ops-276d8439ffb8
>
> Best regards,
> --
> Krzysztof Kozlowski <krzk@kernel.org>
>

