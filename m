Return-Path: <linux-kernel+bounces-84133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9F086A2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E9728317F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B2255790;
	Tue, 27 Feb 2024 22:38:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F155766;
	Tue, 27 Feb 2024 22:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073483; cv=none; b=Q1I8n5g6MSk2KByRSjdLHxh3rzOpZe4j4mQmOqJLXNiS1OnHy5gx4H/j+mlSJc0ToNTBwUTMbJcRcWevu1XqjYxEK+t5Jes5FEQ8Vh42GVPF8+cV1aIXbSFXyRExJ/Han7bKA8irGNS9qQHmDayKNWJuk9qFwLQDS51HAYD4KME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073483; c=relaxed/simple;
	bh=+DlitPmYM0HC8EOJO9yn2RR3WbloWULPH0NZS9721WI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rw5wa/B9g1D22vWUNob/xbq9L9CE2n5HbUPuMgl9m1Z73jvanbyR3mGUsOcpJ6kcHiwW0lgtspRkbAR1ubKKOFf7iAOpvqKReWKQ5O7e3oPmK0mtbIxIOkS/JV/ZHmrDRYb4SN9UPVpaiSkzaeDuGsKPcnxOcpV9h3Bzon7EQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rf656-0001zj-70; Tue, 27 Feb 2024 23:37:48 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add HDMI0 PHY to rk3588
Date: Tue, 27 Feb 2024 23:37:46 +0100
Message-Id: <170907346109.770500.8777873527393464298.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240219204626.284399-1-cristian.ciocaltea@collabora.com>
References: <20240219204626.284399-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 19 Feb 2024 22:46:25 +0200, Cristian Ciocaltea wrote:
> Add DT nodes for HDMI0 PHY and related syscon found on RK3588 SoC.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add HDMI0 PHY to rk3588
      commit: 11d28971aaaf5de6f50790fb21f1113fee21d320

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

