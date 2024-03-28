Return-Path: <linux-kernel+bounces-122866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB9988FEB4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89081F28A87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882027EF07;
	Thu, 28 Mar 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spbsk7Pj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4337D416;
	Thu, 28 Mar 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627710; cv=none; b=WDktR2jbZavOqs3vkJqBKpDRXf/Iy89NQgqqLKZS/m2YhWCH2nhhEkRdRYImcaKJdECCIMHfmZDgJDDz/evYhRpacZuk13zeJ3ueH5rEzhjZMKSzqRmwAzJ4m8RlWZGDn2MgTQRABAGUtMk/XjRyrGevNW7uRukncxi2SN+HnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627710; c=relaxed/simple;
	bh=EOIqVbBIZHvmBl2nm/3zOxapkwwfi8FK8QI0I/jzM24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tA2oekhgdPOqHYLGq9l1snhtoIln6SxP9rPltNJa9iyJWOvnF2n2thH5mjNQJhmfBWs1ibVommE8JmdDYaokkyf1dyw8zs6hQmcL2kLNYlWnRb9LeepdhQuvPeghQV9T+0nt3OV26gn/K/Wmm8u5vVUgBF4t5X8AK2eczRohfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spbsk7Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEFBC433C7;
	Thu, 28 Mar 2024 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711627710;
	bh=EOIqVbBIZHvmBl2nm/3zOxapkwwfi8FK8QI0I/jzM24=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Spbsk7PjMKIKrWSHfhR2U6ayxxErjKwTza79sGUVMTiZm+8phYPhbzdHuQpuM7nKO
	 OHV2i6e0nxXj4T0sEBBRsFe7XzFIjecpGJPdijgToMeXY53AZ8XZlIzNS/gCYGTtuf
	 +BmDBbFlrgoUJwVhP/czcBIpPwN2TN47zg1PN0YeOITmPuw0NARTWLHmMMxlVhs1YU
	 YbTlsDQNCZVt0FpdnRq3oOdYZ5M5aKFB9wGhIVD5XoakV2jz++kC4g5x82fq/RbtDq
	 3vfPZbegZ95axifNinQCt8/aSmoIwQgDTxOdjQ0USBHkchxqooRQlWK0I2FobV4LIy
	 NB91Uw6Mr5wtg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, daniel.thompson@linaro.org, 
 jingoohan1@gmail.com, deller@gmx.de, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
In-Reply-To: <2024032805-putdown-mushy-a0f9@gregkh>
References: <2024032805-putdown-mushy-a0f9@gregkh>
Subject: Re: [PATCH v2 1/2] video: backlight: make backlight_class constant
Message-Id: <171162770830.1983471.4181539912129600848.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 12:08:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 28 Mar 2024 12:59:06 +0100, Greg Kroah-Hartman wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the backlight_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> 
> [...]

Applied, thanks!

[1/2] video: backlight: make backlight_class constant
      commit: 6683414cff25dc5b6e7dfe9dadf42b718384c892
[2/2] video: backlight: lcd: make lcd_class constant
      commit: d51564f749fe4e4efd570b0591f2d23696c90cc7

--
Lee Jones [李琼斯]


