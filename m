Return-Path: <linux-kernel+bounces-63760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B38853427
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C681283683
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E6B5FDD1;
	Tue, 13 Feb 2024 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RW5U5X5J"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DF58108;
	Tue, 13 Feb 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836570; cv=none; b=RjMqbWPrJLRDMW+Z+V8tYt4aI6dwTmpZOe4rUDP0wiq/+LsjBq5tR51WuzoG+GhgZ4lC95cl5Y4MayOLcwPpIQNC4wlsGR/VpOazRbEF1D3i0R+bFgNA/Bh5AkZVfQ77mS1j/4kp3bJEVCVYpjbGQSdeocTojH6SHMRPVFIbXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836570; c=relaxed/simple;
	bh=eEv8+8VvC86Bw7Uzhzb/XCZwOrbOPyVh+VvVVKoxqyM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MKUeCbXaQXB4tKR96Z1NKOWbN78xtEUajO46vibo8UjqjWTz4hYynHBgCbmOxwx7tWiEfxuppVgSItRaI6ADa5mpPhYKIcDXzCIMC4pqibBWdN2R/SBM3/97dtWvNd6+E9HC6CI+D7T49AmY9qdRqFFoJk6HGHjlL94/+x78ufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RW5U5X5J; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707836563;
	bh=eEv8+8VvC86Bw7Uzhzb/XCZwOrbOPyVh+VvVVKoxqyM=;
	h=From:Subject:Date:To:Cc:From;
	b=RW5U5X5JHjwOZzH44YpfCuXOVcUUlLHIWNRTX3iI6/5ddJ+8fo0fm0lnEmrzuSmLI
	 2soL9QJSTeS6pa4ufqbyycCFUUh7rp5PxyP9CH2sIlMJfpum0cm+fv1KmB5DztZ9uH
	 a+uC8ACYdi7GrCazaRADh3OrXYQpC52iVtT/qT81Doww6fRiMvBdyJEUr99u3V+zZi
	 ifHGixsc1ZYtPIVD5CpoIjv/9wnherQxp5QPeqicqav6PEDhoDKGO86Op5W1fsKWn6
	 Cx3Sw3Y1nk9bRv9jvu9rPT0Kd1lPauoZly7IZOolHhzSAbu+LjcFtlfewj5xi6GKpj
	 0c+HizhaYg3dw==
Received: from [192.168.1.42] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E18013780BFE;
	Tue, 13 Feb 2024 15:02:40 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 0/2] arm64: dts: mediatek: mt8186: Fixes for ssusb hang
 using defconfig
Date: Tue, 13 Feb 2024 10:02:36 -0500
Message-Id: <20240213-mt8186-ssusb-domain-clk-fix-v2-0-1f981d35f3fd@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI2Ey2UC/42NQQ6CMBAAv0L27BpaSC2e/IfhsJRFNgIlLRIN4
 e9WXuBx5jCzQeQgHOGabRB4lSh+SqBPGbiepgejtIlB57rMtdI4LlZZgzG+YoOtH0kmdMMTO3k
 jmUoxO1uUXQupMAdO+qjf68S9xMWHzzFb1c/+110VKtTGNZW9lIaouDk/DNT4QGfnR6j3ff8Cz
 Yfb/coAAAA=
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, 
 Eugen Hristev <eugen.hristev@collabora.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Allen-KH Cheng <allen-kh.cheng@mediatek.com>, kernel@collabora.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Two fixes in ssusb components (the power domain and usb controller) to
allow them to successfully probe and the mt8186 to boot using the
upstream defconfig.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Moved the XHCI clock from the power domain to the mtu3 node and to a
  separate commit
- Link to v1: https://lore.kernel.org/r/20240212-mt8186-ssusb-domain-clk-fix-v1-1-26cb98746aa3@collabora.com

---
Nícolas F. R. A. Prado (2):
      arm64: dts: mediatek: mt8186: Add missing clocks to ssusb power domains
      arm64: dts: mediatek: mt8186: Add missing xhci clock to usb controllers

 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)
---
base-commit: 2ae0a045e6814c8c1d676d6153c605a65746aa29
change-id: 20240212-mt8186-ssusb-domain-clk-fix-a691eec834fd

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


