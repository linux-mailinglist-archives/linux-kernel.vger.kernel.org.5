Return-Path: <linux-kernel+bounces-167598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB78BABC2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3997F28496D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307615356D;
	Fri,  3 May 2024 11:38:54 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22289152E1D;
	Fri,  3 May 2024 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736334; cv=none; b=tfyXxrNEQlyCQOA0MpBsMsGkZBFAblgzEF033rTwuW+M9m0U4gKVzB7a2wtYIImjineWhy3bTZ04id6Eq+bXqQWdAujWz1PFYzi9nLp0ZsVT9dxasSRS6ZrNlirLA787sc5TBNH7TR+COb37qy4q68dG8zwPt/oW9ae10jA18wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736334; c=relaxed/simple;
	bh=Jway82AsPdhO04WhQYbW1WMsFZwfn5TxuGBO2IOOefk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwKQgXZ8x4/tgoQvUo5t9ryMtGWfxgm2lYL/LzcmdT0y9ofPncBjbn992dOc3iuglkxRSi85Bg09zs0Y4La45d4RBXmUdZlE38rasr+6VnoO/GQfOnbsIZIn+odubCpWs8Ua0WXJsb8SLb5XYVcVyWmjacIVB57Jy/WcPy5/IHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s2rFO-0000Tc-1q; Fri, 03 May 2024 13:38:38 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: rockchip: Add Radxa ROCK 3C
Date: Fri,  3 May 2024 13:38:19 +0200
Message-Id: <171473602992.3469033.3176474743011728197.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240428123618.72170-1-amadeus@jmu.edu.cn>
References: <20240428123618.72170-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 28 Apr 2024 20:36:16 +0800, Chukun Pan wrote:
> Changes in v2:
>   Collected Acked-by.
>   Drop cd-gpios for sdhci.
>   Add mmc-hs200-1_8v to eMMC.
>   Correct the spi max frequency.
>   Update model name and compatible.
>   Update regulator according to the schematic.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: add Radxa ROCK 3C
      commit: c0c153e341d2a82241bf0a0b78117ceeb29be3eb
[2/2] arm64: dts: rockchip: Add Radxa ROCK 3C
      commit: ee219017ddb50be14c60d3cbe3e51ac0b2008d40

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

