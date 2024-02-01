Return-Path: <linux-kernel+bounces-48028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4C4845674
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D8F1C262E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E3815D5AE;
	Thu,  1 Feb 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU9Dmkd3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F815B99C;
	Thu,  1 Feb 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788010; cv=none; b=azH9UXkOjNjX0YSlu5658UiDoV+2oxmob2KZIjLLwneHHqxSUi+nxsMjYeyRIz9ANo5MhWJF6fmJRHpVehEsd0Ki8a+e9LU6GcvSsbEMkEzbQaeJH6CCQezNWMQwFjbp3j4plWmLKfsSqgKmFq+B3MiUMvafc8/o/wOZWP7uxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788010; c=relaxed/simple;
	bh=B6kqzkRK4glDQvlEuCa9QVdBlMc7GkHgutxdKIuYASU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VsPV4hQef6Nl2LJLkFdBo/foKO4ybIrJowpM7ZSV7VVc4txlGa/c//YgpfWXeq9ozCuOwSr+Y4P1QXUpYR1LN3nEIrZk3Va8x/D3GJAFDi7UpWyPmCUbdxo7JWcPhzkLXyG4zGAt2B2dRx8YbCWfaXL9ABGb29r1fWp8yJZGh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU9Dmkd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BC0C433F1;
	Thu,  1 Feb 2024 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706788010;
	bh=B6kqzkRK4glDQvlEuCa9QVdBlMc7GkHgutxdKIuYASU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BU9Dmkd3b5PaBA9/hvqiJqUvtIzvUbxV+Gl5YTvyNJ+LpLHTKsI7NkCho6lTprxi/
	 C+nDFKDuNTxySZcwYmjmFP7/7rlyXytOWKq6E2C3JlWH/LvmRe+0sGL6RPxR2g2O3e
	 xa+3UZEUyNLM02j96GUksR4UnUPN4kDl53DYI1drM6zdIQbJQ0jtr6ZzwQLLYNWobr
	 23NNiexqgAtEzo7A/1dOtraNfEhXXEcFC1j/3e+zEZEUJhCIWKt1C6KmxcjzpEBpfb
	 iY/6OwaIB43ugX3lbPFWIpLSMETL0XkWi9UGtxuSqeMuVnQAx84gb4IrYBEdRShmI2
	 ZOOlxdUxVCPnw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240125-ktd2801-v5-0-e22da232a825@skole.hr>
References: <20240125-ktd2801-v5-0-e22da232a825@skole.hr>
Subject: Re: [PATCH v5 0/4] Kinetic ExpressWire library and KTD2801
 backlight driver
Message-Id: <170678800633.1338717.2755658439241529457.b4-ty@kernel.org>
Date: Thu, 01 Feb 2024 11:46:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Thu, 25 Jan 2024 16:30:52 +0100, Duje Mihanović wrote:
> This series adds support for the Kinetic KTD2801 LED backlight driver
> IC found in samsung,coreprimevelte.
> 
> Support is already upstream for the somewhat similar KTD2692 flash
> driver, and this series since v3 also moves its ExpressWire code into a
> separate library and converts the KTD2692 driver to use that library.
> 
> [...]

Applied, thanks!

[1/4] leds: introduce ExpressWire library
      commit: 25ae5f5f4168bbf91e7b6b126d24c30c91ef952e
[2/4] leds: ktd2692: convert to use ExpressWire library
      commit: e59a15af7aa690fa0997758df23069a9f0756c49
[3/4] dt-bindings: backlight: add Kinetic KTD2801 binding
      commit: 4ac621a418ce8f4c562b50ea6f676196bd5262da
[4/4] backlight: Add Kinetic KTD2801 backlight support
      commit: 66c76c1cd984c14660453dfa2118014817924375

--
Lee Jones [李琼斯]


