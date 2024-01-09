Return-Path: <linux-kernel+bounces-21040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252ED8288EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E931C24175
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6636339FDC;
	Tue,  9 Jan 2024 15:22:23 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EAB3A28B;
	Tue,  9 Jan 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaa.versanet.de ([83.135.90.170] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rNDvW-0003qY-KO; Tue, 09 Jan 2024 16:22:02 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Quentin Schulz <foss+kernel@0leil.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject:
 Re: [PATCH 1/2] arm64: dts: rockchip: add spi controller aliases on rk3399
Date: Tue, 09 Jan 2024 16:22:01 +0100
Message-ID: <2305627.1xdlsreqCQ@diego>
In-Reply-To: <685047b0-a907-49c6-919b-e46976d8ef7b@linaro.org>
References:
 <20240109-rk3399-spi-aliases-v1-0-2009e44e734a@theobroma-systems.com>
 <20240109-rk3399-spi-aliases-v1-1-2009e44e734a@theobroma-systems.com>
 <685047b0-a907-49c6-919b-e46976d8ef7b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Krzysztof,

Am Dienstag, 9. Januar 2024, 16:15:30 CET schrieb Krzysztof Kozlowski:
> On 09/01/2024 14:35, Quentin Schulz wrote:
> > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > 
> > There are 6 SPI controllers on RK3399 and they are all numbered in the
> > TRM, so let's add the appropriate aliases to the main DTSI so that any
> > RK3399-based board doesn't need to define the aliases themselves to
> > benefit from stable SPI indices in userspace.
> 
> But that contradicts the point that board should define aliases for
> exposable interfaces. Sorry, that's a NAK.

didn't we have this same discussion some weeks ago? ;-) .

I.e. spi2 on Rockchip socs is called spi2 in _all_ SoC documentation,
lines in _all_ schematics are also always called spi2_foo , so as before
I really don't see any value in repeating the very same aliases in
_every_ board.

Same for i2c, uart .


It is of course different for non-numerable interfaces - like the mmcX
aliases - where the controller is named sdhci, sdmmc, sdio ... and
similar cases. These get to stay in the board dts files of course.


Heiko

> > Cc: Quentin Schulz <foss+kernel@0leil.net>
> 
> No need to Cc yourself...
> 
> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > ---
> 
> Best regards,
> Krzysztof
> 
> 





