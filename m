Return-Path: <linux-kernel+bounces-126732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F1893C0D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F362B20C72
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE4E53372;
	Mon,  1 Apr 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgFiZ5VV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44E651C5B;
	Mon,  1 Apr 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980703; cv=none; b=pvtbK+WvrPEWh/hkAomORTzvi1YX+jeQD7k6r/F0oFeRUuTAJJ0C77l8Zj+ya/V6SgpAfhJ9I4eHHNXTbJVlwaGGjo7Io0h2kqqeNgkI3T9OqA1DNDQL3YDWSQcLo5n/B3rFq80yA2nvHqsGxSUAxwB37BGoeiZ1ncGuvunEfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980703; c=relaxed/simple;
	bh=KCgc/CXjWRIM/iAqaJ/2RrnPGDgt+6QpRUFdTf9rL00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ENvc4IzQXLAHDgYBSiIl9CMLQ5LXRRPfO8oCVpTdGQ1+Fy2CHnyBioFcdaSSaaeIUsWpP4poG5+5hD82EzSI9uo4LCAmnFHbAoBQtS0LigAAFpDkbkn9wFWqMZyrvzf4R0km8vjMm/VGbJ4sVGaXZkRHg/J+l/SPv2NGrsIvy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgFiZ5VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFEDC43390;
	Mon,  1 Apr 2024 14:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980703;
	bh=KCgc/CXjWRIM/iAqaJ/2RrnPGDgt+6QpRUFdTf9rL00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DgFiZ5VVsneOsz/kyVVJKLLGrdMuYBk6tn8CrpZcCgKSn3a0LJnpwwT+35Jvn434U
	 mMYErrpdIE3TrY6jvUmZcoDrOIEFKT0ozoZq+D5rcbgxE5LFcSyJlTEoscJG8FDLcF
	 P6rf5l5v5VIQwBmky12+D8Zn0hX18+Ag5mOT6OLkBQpYI1eZTYPXYgHO4Llf7hgZtC
	 DgZfQh2ZY0zeRBI7hSi+0+E6r/xGYVOlhzxFT2HkPyF/2eY4nNrX8/++M/uiJodMGz
	 12+3wcnZixw0Pkbt2n0xnYJkY7gHymOIPg9r2sHkalkZLZabitCtSZiP5emEsuTij1
	 qaHj7d40PAnCA==
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
Subject: [PATCH 4/5] arm64: dts: whale2: add missing ap-apb unit address
Date: Mon,  1 Apr 2024 16:11:27 +0200
Message-Id: <20240401141128.98317-4-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401141128.98317-1-krzk@kernel.org>
References: <20240401141128.98317-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nodes with "reg" property are supposed to have unit address, as reported
by dtc W=1 warning:

  whale2.dtsi:67.10-116.5: Warning (simple_bus_reg): /soc/ap-apb: simple-bus unit address format error, expected "70000000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/sprd/whale2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/sprd/whale2.dtsi b/arch/arm64/boot/dts/sprd/whale2.dtsi
index fece49704b5c..7068bfd2f4c3 100644
--- a/arch/arm64/boot/dts/sprd/whale2.dtsi
+++ b/arch/arm64/boot/dts/sprd/whale2.dtsi
@@ -64,7 +64,7 @@ ap_apb_regs: syscon@70b00000 {
 			reg = <0 0x70b00000 0 0x40000>;
 		};
 
-		ap-apb {
+		ap-apb@70000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.34.1


