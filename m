Return-Path: <linux-kernel+bounces-78421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD40286133B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675DA286856
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6997F7D9;
	Fri, 23 Feb 2024 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn1mMn3a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ACC7F460;
	Fri, 23 Feb 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696154; cv=none; b=TfAgbySi7j/H2IT5ZFWnHviOCi1A+y+OnfG848Iajxi2VBkxgiVzsNzbQX9w77oS2bKBrO1vnLXgO+ObR9pjTfuWr7QxLTjuli/Gm/aSSAnUUmWjCvLSLZsAl05LYWTdO0l9HIwP5R11JHgM8byBeOPuGeTbIZ+1zzxXf/anvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696154; c=relaxed/simple;
	bh=8Rl1l2yFPG+lt29qbKzTpc6sXKmsDQCVh7f3P8VQjRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kA+BTyh+Y/1p/oL9z5zTYYPaWpwVthf+5bYLYIh+8wKz3T/jOTPJrP81STy0bWXLUui38E/K4cabPFKe7DB0YkQI5uP8L9okyU+Gl9ngCaRYpPaSWxc3pumASM1fsG+pfOzhlNTvNZpxHzuGRU10c06YB63LWZfyc9xbE34BXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn1mMn3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D578CC433F1;
	Fri, 23 Feb 2024 13:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708696153;
	bh=8Rl1l2yFPG+lt29qbKzTpc6sXKmsDQCVh7f3P8VQjRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qn1mMn3apX3+iCQRF7jvY1gWwlT8dR3Fg6RU8ULLQ1LMK9dH8EIwMzI0CY0u4AwuR
	 uk3KEDl7egdP/RiGTY8mLu9n0t0S8w7yxMY4P9KQvf7z4Ie16s/TFLaylhLKte84PI
	 l9IdjmQOVjLSl/p9wUnhziAKElzxUVLLY8pEcp4mdWQSMSzBJvsw9hcUyCyW3Rk4hK
	 vKuusjjeibhWA6JBK/P2MGrGyvh2vJ6ceY4DkdJO6o69uPrkaIetFcCjmc05Cq2ANq
	 J4dqKQhITHyqpPmfXIR0HLgcd6d972dDhEcWogMVn+aSDMTaRlYjuXT+62yWZyKecX
	 TWdGjXdYWpvRA==
Date: Fri, 23 Feb 2024 13:49:08 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	Flavio Suligoi <f.suligoi@asem.it>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [resend, PATCH v3 0/3] backlight: mp3309c: Allow to use on
 non-OF platforms
Message-ID: <20240223134908.GA1613065@google.com>
References: <20240208184313.2224579-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208184313.2224579-1-andriy.shevchenko@linux.intel.com>

On Thu, 08 Feb 2024, Andy Shevchenko wrote:

> Allow to use driver on non-OF platforms and other cleanups.
> 
> Changelog v3:
> - rebased on top of the last changes against this driver (Lee)
> - added tags to patch 2 (Daniel, Flavio)
> 
> Changelog v2:
> - rename pm3309c_parse_dt_node() --> mp3309c_parse_fwnode() (Daniel)                                             - add tags (Daniel, Flavio)
> - new patch 2
> 
> Andy Shevchenko (3):
>   backlight: mp3309c: Make use of device properties
>   backlight: mp3309c: use dev_err_probe() instead of dev_err()
>   backlight: mp3309c: Utilise temporary variable for struct device
> 
>  drivers/video/backlight/mp3309c.c | 88 ++++++++++++-------------------
>  1 file changed, 35 insertions(+), 53 deletions(-)

Sorry for the delay, I was on vacation and I've been fighting fires this
week.

This set still doesn't apply?

-- 
Lee Jones [李琼斯]

