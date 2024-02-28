Return-Path: <linux-kernel+bounces-85052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B061886AFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AFD2894D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E3B14AD2A;
	Wed, 28 Feb 2024 13:02:53 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877E3BBCB;
	Wed, 28 Feb 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125373; cv=none; b=k6309/FSyWLMBKXxMvPy1e+GvlTBxwVFq1Uv0JrTdznTG7YVMYNxFCKuq2uPlTAn5nda0ZhelA8QtEWz0XDhb4bO495RmRT7TIJgMvIQtY553NKRzxdJoPqgwVObgLCGJ82tgrAgkPb3b24Sl+zBPrOVz+PPQo/exJMg4V3xs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125373; c=relaxed/simple;
	bh=A6sCBIj/Hz8ttw8hg7c2y5i5XtQi4gvu0IqGQ4aHpvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLonPwctJ8QSnTWGfFD5qu1ObMUqeIhSEwSXVD4omIpFlABloL7vLSl9woLvHZdstH+040XftkzEF8ywM2VaqQ4eRyPdtRBbaNoGJUcpo4sOm7qNhvkfgEB3s9Ltw9o0FwNoMLDuo7/9XfDRBy7LhTZIMgv42KOr+J2IZJtrU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rfJZz-00020N-IA; Wed, 28 Feb 2024 14:02:35 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 0/4] Add support for Theobroma-Systems Tiger SoM
Date: Wed, 28 Feb 2024 14:02:32 +0100
Message-Id: <170912529797.972844.5992915941484107870.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227164659.705271-1-heiko@sntech.de>
References: <20240227164659.705271-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 27 Feb 2024 17:46:55 +0100, Heiko Stuebner wrote:
> This adds support for the rk3588-based Tiger system-on-module from
> Theobroma Systems and includes support for the combination with
> the Haikou-baseboard.
> 
> Included is also a fix for the rk3588's i2s nodes to remove a
> yet-unsupported devicetree property that slipped in.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: rockchip: drop rockchip,trcm-sync-tx-only from rk3588 i2s
      commit: a8037ceb89649659831e86a87a9329d1bb43c735
[2/4] dt-bindings: arm: rockchip: Add Theobroma-Systems RK3588 Q7 with baseboard
      commit: c0263538c5ad8abd2053da6931e21878fa4ae58e
[3/4] arm64: dts: rockchip: add RK3588-Q7 (Tiger) SoM
      commit: 6173ef24b35b703078da8b714ba913bd78ee4d3d
[4/4] arm64: dts: rockchip: add Haikou baseboard with RK3588-Q7 SoM
      commit: f95d0903d0a5778822861411d441265b02ff3b31

Moved two status instances to the bottom of the list, where they belong.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

