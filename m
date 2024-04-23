Return-Path: <linux-kernel+bounces-155447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D8E8AEAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6F028A67F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88E13E405;
	Tue, 23 Apr 2024 15:15:50 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD813DDC4;
	Tue, 23 Apr 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885350; cv=none; b=ekiowB+F5r4sceIaOCmo5ZBKG3jPxsIbbEJd4NarL939fESU+J3JWqOPvXqSPtYdhuwy7TCKAjuaojQZcMM3T4bwWapxSpeV6bFJnTjz8r+XUT/Lsv75sz+vLamt7m1Ev3w5JtpTH0IoRtsOM4+vrqRfi3Ipk59wzH/0XclYWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885350; c=relaxed/simple;
	bh=sjp5JunMjDTPlz2EkpoFZUn15enj8itw3RntfFOyWqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LI6ZvXHWrGVggxmOhN2t3KA2kubCjy1LUOLQuhXdrSyo3ilzeys3bAtyfIWgm6CUz0C7gFUuVVTZYk04q/wIzyCcVO7GfKjPBNBbPxOs6/IzzLMPnEF4wrkqE4SarfgirRUNQhFi7dPQ1+oqS9pkuAgsY51LhVAxnpnp2bZFfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzHrw-0007PZ-DP; Tue, 23 Apr 2024 17:15:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzk+dt@kernel.org,
	amadeus@jmu.edu.cn,
	linux-arm-kernel@lists.infradead.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	robh+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Correct the descriptions for Radxa boards
Date: Tue, 23 Apr 2024 17:15:33 +0200
Message-Id: <171388532520.2652222.16202058595399007422.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
References: <1e148d6cd4486b31b5e7f3824cf6bccf536b74c0.1713457260.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Apr 2024 18:26:19 +0200, Dragan Simic wrote:
> Correct the descriptions of a few Radxa boards, according to the up-to-date
> documentation from Radxa and the detailed explanation from Naoki. [1]  To sum
> it up, the short naming, as specified by Radxa, is preferred.
> 
> [1] https://lore.kernel.org/linux-rockchip/B26C732A4DCEA9B3+282b8775-601b-4d4a-a513-4924b7940076@radxa.com/
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: Correct the descriptions for Radxa boards
      commit: d78084cdb5a959a5759efed9b3bc3182d005073c
[2/2] arm64: dts: rockchip: Correct the model names for Radxa ROCK 5 boards
      commit: 45e831033f7a00a14f64afa1e34c476a9ff0f9f0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

