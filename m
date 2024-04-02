Return-Path: <linux-kernel+bounces-128573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468ED895C99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C9A283CA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B24515CD46;
	Tue,  2 Apr 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckwiEgyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974115B992;
	Tue,  2 Apr 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086321; cv=none; b=N7fvQSD318vjBUTyF/icsdp+r6opDPza8r/g6LP/lK/UcdKTdioG/4zUkT9fnkvpfNUlK1Iz7Kp8hI3qZmXhlt+nFefhbbbnpVgmp7EHQZGu2zimz896VPhmZH6Yo+vjYaTIPxtNpZugOuvmbZqGKLpU2+KyAZVgg1iNNja6OlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086321; c=relaxed/simple;
	bh=PLeOIeqIaa/TwSc4B5JiSeZgqRcfOviRG+cof7j36/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dDX7Ko+ak106rEmVbusHKKb1ofcShJ0w3xkuqNeJ0zupOH9lrs0x0VJrHqOynCacgEbksp9kBAHvoOI4+mqAI0oH89TAxCRudRZfpQN4FKhZvWt6PrvELG5vbH20V7S1qilBVrQUIeP9qZqGIgqVHsabSACCD8lOCoo++DCiSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckwiEgyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB96C43394;
	Tue,  2 Apr 2024 19:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712086321;
	bh=PLeOIeqIaa/TwSc4B5JiSeZgqRcfOviRG+cof7j36/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckwiEgyyBaxK8ljd6Fahhhwy/bUJhTQRIlXXS5XDxX09aQkmZMGe8rUrZGpJyK6mb
	 CrHZ0sUd75WOqgHi1amVFRsRdrL/DMDpcikag2Plgmjfc6z686e4z4x4l/sgHT4zBQ
	 /5M28BL6kziaaIYwg1Dt2uCsqYCRWMDCF+7ACFMhF+eSDGFVsyMI3H5W9JlP1BZclW
	 EOsTf18LZ7DkaXpDnnL3bC7PaoUmVeSxs6zQcK1+L3MxpuB3Nfy33VrrcS+8A9CDqt
	 ZgUSbLZdqJQ3dtoKK+kqJLEw6KHcNcFgsOkfDeltxFGNH9hNz912FtXSJ4yrIrwRbI
	 OaJOqn73DV7eQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/9] arm64: dts: hisilicon: hip05-d02: correct local-bus unit addresses
Date: Tue,  2 Apr 2024 21:31:41 +0200
Message-Id: <20240402193148.62323-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402193148.62323-1-krzk@kernel.org>
References: <20240402193148.62323-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct local-bus children unit addresses to fix dtc W=1 warnings:

  hip05-d02.dts:57.16-76.4: Warning (simple_bus_reg): /soc/local-bus@80380000/nor-flash@0,0: simple-bus unit address format error, expected "0"
  hip05-d02.dts:78.11-81.4: Warning (simple_bus_reg): /soc/local-bus@80380000/cpld@1,0: simple-bus unit address format error, expected "100000000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
index c4eaebbb448f..b7792d443189 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
+++ b/arch/arm64/boot/dts/hisilicon/hip05-d02.dts
@@ -54,7 +54,7 @@ &lbc {
 	ranges = <0 0 0x0 0x90000000 0x08000000>,
 		 <1 0 0x0 0x98000000 0x08000000>;
 
-	nor-flash@0,0 {
+	nor-flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "numonyx,js28f00a", "cfi-flash";
@@ -75,7 +75,7 @@ partition@1000000 {
 		};
 	};
 
-	cpld@1,0 {
+	cpld@100000000 {
 		compatible = "hisilicon,hip05-cpld";
 		reg = <1 0x0 0x100>;
 	};
-- 
2.34.1


