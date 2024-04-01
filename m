Return-Path: <linux-kernel+bounces-126713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102E893BE4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AB6282374
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32643AC3;
	Mon,  1 Apr 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzvctBsn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E142075;
	Mon,  1 Apr 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980597; cv=none; b=pFlNgkNWk1+woQe0LU6Fhrnxm3NYU1/Y8+5mUsiwr+g3vX3JeOpykql/ceUeI6tYg2sDG5ldLfz6ygeaik8MzSy+jImXhpg6hl/Zvr3Lz1cFphgssXmLofUwSZE3UWwqdOGQ65WIiS9D8hb0Q/KHh68i6AXhz5AP3atgOHzzFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980597; c=relaxed/simple;
	bh=k2SfaJ6oovPsgz2i5jMEfgxA86C9n/bPoB8ZDiDXrmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DpqO1wlejCx4AdvmYMk1HvNJAIL8csWaOdJ9VzT8SwD16GxLS8NKkIc/ZYh7aBq6BFsji21zknNgGKqK2iPJwH0EBltZbcLm09uE1LupjVtQLGmEF4YKN+tHsgLYp+UHNmNvAvADrCaiUnxL4gWdIRaRLWPaPfly/A8sem5RT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzvctBsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333A6C433F1;
	Mon,  1 Apr 2024 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980597;
	bh=k2SfaJ6oovPsgz2i5jMEfgxA86C9n/bPoB8ZDiDXrmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=KzvctBsnRZzj/EzjHrsz9Og9/RgjRFJ+flnItHYyn6jcsWDjvy08Zens71ZKeVhD7
	 /LAiw+kQKcbddG4/62u9j5SHY74aBU1K3VQpAqTbgvEt7aLMYeVujzsnJXt8/o40Wl
	 5wE3oQSq3PSTlFh9hMaFTNfk51jg+lFOkZEnijZuimYT5bndtjfRogMU6SQoll79Pn
	 fGa+FmpYU5PzLc/+xuTAMkVBlZX05s6UwdoUjBW+capPe8lUUJwVfil3Q/VyI6FJ6G
	 aqImWW67Vl2iNrxT38eI13hbnTeFErFprqkqoA8ZeR4neK3fgfHJwL/zahhSgIrI4W
	 HgZq0H961NTeA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/4] arm64: dts: uniphier: ld11-global: use generic node name for audio-codec
Date: Mon,  1 Apr 2024 16:09:49 +0200
Message-Id: <20240401140952.97923-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree specification expects node names to be generic, representing
the class of devices.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index da44a15a8adf..2f88e81b7ee3 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -111,7 +111,7 @@ &comp_spdif_hiecout1 {
 &i2c0 {
 	status = "okay";
 
-	tas5707a@1d {
+	audio-codec@1d {
 		compatible = "ti,tas5711";
 		reg = <0x1d>;
 		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(23, 4) GPIO_ACTIVE_LOW>;
-- 
2.34.1


