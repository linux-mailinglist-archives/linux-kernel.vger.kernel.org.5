Return-Path: <linux-kernel+bounces-57873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBAB84DE71
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF721C22C40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E118E67E83;
	Thu,  8 Feb 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUgcpQKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6BE2E3F2;
	Thu,  8 Feb 2024 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388706; cv=none; b=VFaNlU9Dyt9xeOinkrn9iLurR4eaGa7hjXAybRqIJkr5yQ0Zcr5w3ewu+9hsrVP8bVH63ZJgQ37J+FtFWYJYpOVgcgKD6TJZ8qwwvsYZraTJEjAwgrutRm0Yra07nF95JLZvj1N+e9TvGglwfmTssikgL/p7IBnI1s52pdgLN4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388706; c=relaxed/simple;
	bh=3AETScruqkniEwNPSQ+NMaYC/8cwISq036PBk0cTtnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fkLrVqi+TYRGem9bn0ciCnXE1N7K4R7pSn9MVasbfQ1yBTwvTqdngP8YyK3HGPdx1J/D8WN6iNYREtBcY6vKfiXEMZAE9ZKiFZogegESxN1bGt6IX0LItk9mr/bPYUlSyv7TgGNmEHhcFa/U6tIjZSo5Cqo4YVtqbgDxsC+ICSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUgcpQKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50626C43390;
	Thu,  8 Feb 2024 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388705;
	bh=3AETScruqkniEwNPSQ+NMaYC/8cwISq036PBk0cTtnU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LUgcpQKRtuhjFJDiKTqdPWjCsggDpcTwYXQhj03kzMUMieEg6DLASSrp5Jjl5S8jM
	 auS6Q2sRso+iCGkthVdLHM+tfFixhfn90rBxv+nPxszTUUL9J1WvYt9GQ7CsbGdyWf
	 efkKt5wNFFRPBeZnuoqICx6JtNtNx8g6me+g08gm+hpr8Cc+vgUDb5ul88Wd74fmHb
	 2caj3zysLIDePMJTgWBjOvn6+lp9VJa/uSqBBmRp8GJiMuXe04QlY0RCTqq9Mn15mn
	 7N4AWuCIj4Smb5sD2KYetGz/DmVEFNhDQJgnBuILiEYB6y8r1E2G2EadPQO8K7tEPf
	 KxKWKNWvx7T0Q==
From: Lee Jones <lee@kernel.org>
To: sam@ravnborg.org, bbrezillon@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, lee@kernel.org, thierry.reding@gmail.com, 
 u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org, 
 Dharma Balasubiramani <dharma.b@microchip.com>
Cc: hari.prasathge@microchip.com, manikandan.m@microchip.com
In-Reply-To: <20240131033523.577450-4-dharma.b@microchip.com>
References: <20240131033523.577450-1-dharma.b@microchip.com>
 <20240131033523.577450-4-dharma.b@microchip.com>
Subject: Re: (subset) [linux][PATCH v5 3/3] dt-bindings: mfd: atmel,hlcdc:
 Convert to DT schema format
Message-Id: <170738870103.916068.17422553727568917627.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 10:38:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Wed, 31 Jan 2024 09:05:23 +0530, Dharma Balasubiramani wrote:
> Convert the atmel,hlcdc binding to DT schema format.
> 
> Align clocks and clock-names properties to clearly indicate that the LCD
> controller expects lvds_pll_clk when interfaced with the lvds display. This
> alignment with the specific hardware requirements ensures accurate device tree
> configuration for systems utilizing the HLCDC IP.
> 
> [...]

Applied, thanks!

[3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT schema format
      commit: 7dd93269787781869d3dbb23138ec1455d26b047

--
Lee Jones [李琼斯]


