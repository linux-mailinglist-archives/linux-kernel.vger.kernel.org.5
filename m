Return-Path: <linux-kernel+bounces-126714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB9893BE6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD7B1F221BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958343AD5;
	Mon,  1 Apr 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwCpkuzQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36723446A1;
	Mon,  1 Apr 2024 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980600; cv=none; b=aTxEWgM9T9r9nkCJ4syeM3yiZJrrlMKLHIAM4dJAiwf3ln8HzLL4roXhUZofv+4XIPs0APlVG7uD7nFHnURofGWLwrcZt6U1VpiVC1tolHlIdMG/o5hOg6OoJ8/K8nc/J3s2pOKKQgfvtoH8QC+rRd640cCxmzrgJTaSZups0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980600; c=relaxed/simple;
	bh=T8cTpcPtbKL40bidcOqabYtbo+jPN9yb8umdMcHouc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ICNb03RVZDxMiIeWHaEgO/BsiJnovn1/ZnH1ONOgoVuctt994+0TSfRrhkGSf0mzl6k2wald3PCo0k0/1rOZSJj94nLzXSLikuG0HYd0qGbW81oaKwgnHfTHj+s26l7I/oT8c9TpatqbG2BmGJMLbMbiW2a1w807kJOIxEH9NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwCpkuzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16DEC43399;
	Mon,  1 Apr 2024 14:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980600;
	bh=T8cTpcPtbKL40bidcOqabYtbo+jPN9yb8umdMcHouc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwCpkuzQG+hmBPkxk0N6b3FEap7LId/CyWoqxRkChz44R3otwKpEjZo1CweZDGsxw
	 q55kzYyCdZTgSbOOBnx/V45zJLFfEzk1Vx0tnXcrHXxCS1H7jY9iCET7hfF87qPTi3
	 rfnCjI1zs1HJG1Qt4GDwwP6nSK6grYegDirhYb/gus3V7S0/pJoF4+WID2yLW47MnR
	 RSUwIeLrWF5ZADOFKyU+pWhHPnX1pdQFC0hh2ocZvLf5CPoVkF/tt5SyMXVvY1+J8L
	 J2Qt0Ze/2FdgvU2jx3EyX4xeTAP/0JLqJo+Ppu9JG/wVJ6VeMZEDYybOeW5duVf8sO
	 Rg5Jo3DiEeG1Q==
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
Subject: [PATCH 2/4] arm64: dts: uniphier: ld11-global: drop audio codec port unit address
Date: Mon,  1 Apr 2024 16:09:50 +0200
Message-Id: <20240401140952.97923-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401140952.97923-1-krzk@kernel.org>
References: <20240401140952.97923-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Audio codec port does not have "reg", thus it should not have unit
address, as reported by dtc W=1 warning:

  uniphier-ld11-global.dts:127.10-132.5: Warning (unit_address_vs_reg): /soc@0/i2c@58780000/tas5707a@1d/port@0: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 2f88e81b7ee3..a251c4343548 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -124,7 +124,7 @@ audio-codec@1d {
 		PVDD_C-supply = <&amp_vcc_reg>;
 		PVDD_D-supply = <&amp_vcc_reg>;
 
-		port@0 {
+		port {
 			tas_speaker: endpoint {
 				dai-format = "i2s";
 				remote-endpoint = <&i2s_hpcmout1>;
-- 
2.34.1


