Return-Path: <linux-kernel+bounces-128634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB91895D47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BA51F22621
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDA315DBC1;
	Tue,  2 Apr 2024 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pog0jFB5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691A15DBA3;
	Tue,  2 Apr 2024 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088478; cv=none; b=SaiwI16dlURM1rBhghJvgLeM0iQ730OcBNQOHVJgy2qQ0a2dSaAcH535YqiAOBd1SKg7aSlHtYNABNy6/cHbcLEcqwRbzyB9rNrKFmuzvBIueEMBc5qbBpXMZF2JFplXqNE+YLE5Akb/n2qlQo84YGlJR5IDc52RRqhPnjN5EvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088478; c=relaxed/simple;
	bh=xEvPY3lDzcEuW20z0qCcoQ3JHjnujFxc8KNG7ADF72c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lB7uO2G4g5pjt85tmtKjmLmrIiYGCyYbDuxyH23ruBdssw6ooNDILaxHCynDLe85hy0X6xd5cDQ5GBs7Hw5Yz7E1XyTdi07eUJqk6LqS/Pnw8mqW8bQoWslMhHOh6+ihHlybu6vO1uCoBZggTUiG20cLpN06VV4ZHvKim+4kMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pog0jFB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12D7C433F1;
	Tue,  2 Apr 2024 20:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088478;
	bh=xEvPY3lDzcEuW20z0qCcoQ3JHjnujFxc8KNG7ADF72c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pog0jFB522o5FNoHTsg7n7/25kRg90CspYe0LxyzlQxXuxebFVS6XF9dp9SWAHyYE
	 FCl+RDhNMK+Xzg9tT2TKFJGsTf4E5w3Vu+Bj7zJ5KZeb0BWSwbd4Y/O/+RxZdhTEQX
	 PwyDIxTUGJJv9FwsgphGtpe5anoIAL4dQceemWMHWD6G5tM5hrQwym/m1+SU1wszZU
	 7yXRUub5XpMGIt97wyxFxqub3qRJgMDbW5X9hO9+Wxqw05d85ZQL3ioBTnoxOw4X5T
	 WsF8dsU6dFlaKbpMb8ZHwEtthfekFI34MFsDuKnfvsZVcP5VuRWrsxqPnqlPY9Y9HS
	 htiK6fv1cqBVQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/5] arm64: dts: amazon: alpine-v3: add missing io-fabric unit addresses
Date: Tue,  2 Apr 2024 22:07:42 +0200
Message-Id: <20240402200744.79349-3-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402200744.79349-1-krzk@kernel.org>
References: <20240402200744.79349-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add io-fabric unit address, because it has ranges property.  This also
fixes dtc W=1 warnings:

  alpine-v2.dtsi:153.13-229.5: Warning (simple_bus_reg): /soc/io-fabric: simple-bus unit address format error, expected "fc000000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
index 3ea178acdddf..0ab40741f697 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
@@ -361,7 +361,7 @@ msix: msix@fbe00000 {
 			interrupt-parent = <&gic>;
 		};
 
-		io-fabric {
+		io-fabric@fc000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.34.1


