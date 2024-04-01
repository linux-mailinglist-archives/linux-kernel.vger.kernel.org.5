Return-Path: <linux-kernel+bounces-126717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8815893BED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3491C214B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB6647774;
	Mon,  1 Apr 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7svPTqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962C46B83;
	Mon,  1 Apr 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980606; cv=none; b=cL1mZjklxNEm0bU87WHbMMRSdupVcZ3MvWY5QDSmUBfxI3QN94fEzjNuzQuNbgwLl4HfAUjbXxHeGwIopOjzeS+VkLlSB4k6HwC35VE12klbjBLCyVwkjp0IrI2KtaYRqTw2aRNl1b4xyhb5mxcCqwGpaCf3yYqOH2WDGqz/gEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980606; c=relaxed/simple;
	bh=s+VMLYn4VwvUWk5qv97RydvWaUtFdZIEyPisNb4S4Ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHf5xIi0RgNbp7fTUtKFmu7Bz86QbdXLFXIB+594L81hmDc9UJrhCtgi+mROnn8MWZyHdAFN9WUJRpJRFwf5mDCWxstIW82O44Y3fshCDKI0zXSwnvY7jKD7uWJTX53hJkXJAQmv+lfM0uGwMp0uhtxGNetibkrBaapkLhrS8Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7svPTqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71FCC433B2;
	Mon,  1 Apr 2024 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980606;
	bh=s+VMLYn4VwvUWk5qv97RydvWaUtFdZIEyPisNb4S4Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7svPTqDIQnwmuUtReWYIvUDjQumRR1g+zU99K/irhaRI8DiavEYZRCyrAMwdD08J
	 Bh+oapgLvQxwYhxKjbY/pqpRjb9efyTgdTgzXQI7GKXNBXYgjgLMRio6NUzjcWY80h
	 CUfeKZnVav6YJ+ejhjd8lyLN4Ej/wwaxevM0JHxvtQ+Dq5avRyajMMSt/pFuAqTZNT
	 9R4pL2GiG+RFgFJR0bzYRLuQiaBJ4rPcKqcFQ2bha6ql+hQdrsmhdwdnw6f8Guuqr/
	 lN/+f/WLSrM6PMVptHA8uokbOWFEBf2KVV6OccQUXGiI9JE3nEy9vfadEwyJTXSaH7
	 ryQQ5XSPYt5rQ==
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
Subject: [PATCH 4/4] arm64: dts: uniphier: ld20-global: drop audio codec port unit address
Date: Mon,  1 Apr 2024 16:09:52 +0200
Message-Id: <20240401140952.97923-4-krzk@kernel.org>
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

  uniphier-ld20-global.dts:127.10-132.5: Warning (unit_address_vs_reg): /soc@0/i2c@58780000/tas5707@1b/port@0: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
index a4c86137f424..79f6db2455c1 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
@@ -124,7 +124,7 @@ audio-codec@1b {
 		PVDD_C-supply = <&amp_vcc_reg>;
 		PVDD_D-supply = <&amp_vcc_reg>;
 
-		port@0 {
+		port {
 			tas_speaker: endpoint {
 				dai-format = "i2s";
 				remote-endpoint = <&i2s_hpcmout1>;
-- 
2.34.1


