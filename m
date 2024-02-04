Return-Path: <linux-kernel+bounces-51614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B5848D3C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66002282849
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B5A22081;
	Sun,  4 Feb 2024 11:50:00 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BB22094;
	Sun,  4 Feb 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707047400; cv=none; b=b1KXmtcERi4WGLKxqTTa1fX/p2Hx1XwIUqew6HgFI89DqrV3xEU3GUlQDxw8GjUO9iYPcLsHehpv8rUA+4bYKKrE8ecoqbg7gcc0Yf0YxgvsKRxA/doMZJ004nj2OoFSxHUR4FAqD6ASE1849N5k0ixrV3zRVGQ8KBWjyCG9a1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707047400; c=relaxed/simple;
	bh=s9S8h1/2eSklTK7wU4q4viPGhMla9isvvs+OxGtXtlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1F8VcjfqkV2GmBUXCiISU9DKHfQXmmL1t4oBR60Q3NHBXLetniPfJCZKi6A5A0BUiNLlRY2vvoyjxe5K648cSBxj0ldEdtdHdU7TKNmDZWrWa2av1BVnk+xAltCVrPtkP2wqghP6lWQxENYvvmzX+xgnPpZ6wupx+hcKBoZbJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [185.175.219.2] (helo=phil.fosdem.net)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rWaUp-00051V-1q; Sun, 04 Feb 2024 12:17:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-rockchip@lists.infradead.org,
	robh+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi 4B
Date: Sun,  4 Feb 2024 12:17:05 +0100
Message-Id: <170704542189.2517832.10645480852416416649.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201121106.1471301-1-andyshrk@163.com>
References: <20240201121106.1471301-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 1 Feb 2024 20:11:03 +0800, Andy Yan wrote:
> Follow others rk3588 based boards, and u-boot only use mmc0/1
> as mmc boot targets, so aliase sdmmc as mmc1.
> 
> 

Applied, thanks!

[1/4] arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi 4B
      commit: a41f91b4da1490b90ae5859f3464e94d418fea2c
[2/4] arm64: dts: rockchip: aliase sdmmc as mmc1 for Cool Pi CM5 EVB
      commit: cebda3dd36bebb11d3e6df4d1944a1cdcf3cd4cf
[3/4] arm64: dts: rockchip: rename vcc5v0_usb30_host regulator for Cool Pi CM5 EVB
      commit: c7e8dbb3bc12f389d617e6c0e9537f11a1fa6eb1
[4/4] arm64: dts: rockchip: Fix the num-lanes of pcie3x4 on Cool Pi CM5 EVB
      commit: 5556a8c3af8b4ee648b0fd4cdb4a1356d92de07b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

