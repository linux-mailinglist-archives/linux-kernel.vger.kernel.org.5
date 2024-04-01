Return-Path: <linux-kernel+bounces-126729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AE1893C07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F97A281715
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08184778E;
	Mon,  1 Apr 2024 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5CGf00a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FD405CF;
	Mon,  1 Apr 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980695; cv=none; b=PSG2XBB25xgrv32PDEkfhHl2BYAktfjM1yzukIlSUIubdBlJZafy/9Ixu4KZr7Xxl+Y1jw2CGzw66nqUM9mSo4h68mqS/sx3ZOcT+kZnOjP1WJG3ErNwMDJz90j10hX9nl2gus/UGMTD69m6nJUkoSY/UPyCa27Z/aeFmoi0Cpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980695; c=relaxed/simple;
	bh=ELEimCAJYivsZ7IPc5OHR8wANqO9wmSh591TTJfMT58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ymeg0KmxhIQmXNQpviDGJnlKRBav2BFGFQtJtD2AXoBvLgp8Nrj0jYTouMCvpmjRUGQFtflnSZ53auPOTOC0EDo7iGRD0dz9862exYVTuNES5mUwi5jloR7EZfYE2KIRrfNCgWA1D9KuK21nQrOmNVknnubjQ+5fkNUb+lrjH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5CGf00a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1FAC433C7;
	Mon,  1 Apr 2024 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980694;
	bh=ELEimCAJYivsZ7IPc5OHR8wANqO9wmSh591TTJfMT58=;
	h=From:To:Cc:Subject:Date:From;
	b=G5CGf00amXQEfCAoSRK7IMZZ09QyeOlUvjLaoo8sFIJDrqvjAk+omjPDTLXWZjkhm
	 tGACT8tL/pxI1w1FvrqtuXXXhLnco9Ytr9Onk3kLt+82XS0uov2J9oB+9dqhh+OJhE
	 c/SvLKR6a5VJ4nWbpD7zfNwuKPYFCqECpmykYKa+l4ZeGebc3RkcLEGnrF31rzmcvW
	 0C+jdLvmpR1jDHQEmSj5QGv1wNAYxJwU1zhgbZTcaCS7losBjNLgdJo1yEqXQPedGc
	 CFVLNRiAb/e6fE3e6ht/6rGmNddGaEP+SzoRQ+7NVn7kjDewCTIkMAlGT6HbGJKnVM
	 wPDyXio6XzXjA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/5] arm64: dts: sc9860: add missing aon-prediv unit address
Date: Mon,  1 Apr 2024 16:11:24 +0200
Message-Id: <20240401141128.98317-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nodes with "reg" property are supposed to have unit address, as reported
by dtc W=1 warning:

  sc9860.dtsi:210.26-216.5: Warning (simple_bus_reg): /soc/aon-prediv: simple-bus unit address format error, expected "402d0000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/sprd/sc9860.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index e27eb3ed1d47..b933979c9eee 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -207,7 +207,7 @@ ap_clk: clock-controller@20000000 {
 			#clock-cells = <1>;
 		};
 
-		aon_prediv: aon-prediv {
+		aon_prediv: aon-prediv@402d0000 {
 			compatible = "sprd,sc9860-aon-prediv";
 			reg = <0 0x402d0000 0 0x400>;
 			clocks = <&ext_26m>, <&pll 0>,
-- 
2.34.1


