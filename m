Return-Path: <linux-kernel+bounces-39300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 464FF83CE62
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF99B23CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9E13AA26;
	Thu, 25 Jan 2024 21:20:11 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6801745C6;
	Thu, 25 Jan 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217611; cv=none; b=SrywVIa9egYygywAZBRGcDEWsBB07NyOwzad5grxYV8ZpNCwvrER8gKh2GouH2/D0s7vyi125p2U/1bEwtMyOv75BUDMs4HQcv1MfayZIhqvpPNM2yqqyigzLCbx2UhQ0BQeoFWFp4N5aObIqSvwGj8CSF1XHhyVy2iUA8h0F0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217611; c=relaxed/simple;
	bh=mOMM0AlcwJN20oFyxvJYlFg9BiesT0qjlme8bhsDcwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toMy2+9dcv1kpgfklGXmKQ6cvlrFxoH36c/1T9nx325Hnt28ec+5dKNhgDEkSI9BmQrATNMlDdT/xasPzffCGb24oKeZU8XHcOKuL/Iryeb8vR90dmknSqD83tZRrY3hVg/rYTmsqpxBY2ZuGcDtamIwx7YiiTnR1mB+P/vIZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT71M-0002EX-Fe; Thu, 25 Jan 2024 22:12:24 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Stefan Nagy <stefan.nagy@ixypsilon.net>,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Increase maximum frequency of SPI flash for ROCK Pi 4A/B/C
Date: Thu, 25 Jan 2024 22:12:16 +0100
Message-Id: <170621707731.1872080.836694549079175950.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217113208.64056-1-stefan.nagy@ixypsilon.net>
References: <20231217113208.64056-1-stefan.nagy@ixypsilon.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 17 Dec 2023 12:32:08 +0100, Stefan Nagy wrote:
> The ROCK Pi 4A/B/C boards come with a 32 Mbit SPI NOR flash chip (XTX
> Technology Limited XT25F32) with a maximum clock frequency of 108 MHz.
> Use this value for the device node's spi-max-frequency property.
> 
> This patch has been tested on ROCK Pi 4A.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Increase maximum frequency of SPI flash for ROCK Pi 4A/B/C
      commit: fa16d7a820e42946c511e331cdd81dde579066b7

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

