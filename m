Return-Path: <linux-kernel+bounces-161639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBB58B4EED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F96D281498
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7964CDF42;
	Mon, 29 Apr 2024 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS4rRd9f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB3DDCB;
	Mon, 29 Apr 2024 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350420; cv=none; b=hHO2Cy6/afsMbb1PDYjeBH0UZ0I62tS8Jc+kDaUQ3zuQj6426jgZCAaHWJiQNuw3DODjAlcY4qowv1/Dx928mnBqSxKSKINEZDglCEKFqir7SG939RwgeQGIpIm+hAzqLQvR4d3bQkze9EumIZtOaUIkvJ/1TjVDbXaRbIfvDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350420; c=relaxed/simple;
	bh=z5O26Wd/mN2CPMO2FozsGOCw0zDYK5WOLHYQMcySy8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WpYYYvENzwXM79/GQHnJQEU4xmsDxeNkv7JCjKBrCPHo++7qbkIf6o3Txbb7JPXN7oboo2Cgvm4HHEUg8ubYLMGxUwkIeHyOV4Cp7spZ6K6x2/Uh1DbwUtEtGGdS/kEIy7uUYzaWLWdMpzOOKlstDQ+qbJQyMWSibYcjhpHvN58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS4rRd9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A8A9C113CC;
	Mon, 29 Apr 2024 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714350420;
	bh=z5O26Wd/mN2CPMO2FozsGOCw0zDYK5WOLHYQMcySy8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pS4rRd9f538KuN952oyshxDxaZsPlJURFYl1hst+rQpnfTDu3dpXzXbKySKHverJs
	 zN8NNk3D9uly4RZ7QTncBMGZeJbATAyEYdqF8crFo/doiEIBlDonmD189Xt6uPNVIu
	 F9KR6nGtyp4VvI4IgHKlcgT9qczIF4Qx0I77lZ/PipaFbUi07M5JqW+EkbuMlPDe3Z
	 nOwhN6Aw6UgIoVc7BbWgoebHavBRLVQZKPfmtx9YmQ87npm76H0NUUfA2+0IXnuGc4
	 +J4lsYvVpI3q58AzXdF/J3e/mIR/eylOkDyvnHA1tlXS/PhUz8kr85LrbL7+8+0adJ
	 u/NYCRg0WVH/Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] riscv: dts: starfive: visionfive 2: add tf cd-gpios
Date: Mon, 29 Apr 2024 08:13:14 +0800
Message-ID: <20240429001317.432-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429001317.432-1-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per VisionFive 2 1.2B, and 1.3A boards' SCH, GPIO 41 is used as
card detect. So add "cd-gpios" property for this.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 910c07bd4af9..b6030d63459d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -303,7 +303,7 @@ &mmc1 {
 	bus-width = <4>;
 	no-sdio;
 	no-mmc;
-	broken-cd;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
 	cap-sd-highspeed;
 	post-power-on-delay-ms = <200>;
 	pinctrl-names = "default";
-- 
2.43.0


