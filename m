Return-Path: <linux-kernel+bounces-70578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C688B859969
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A581C20B9D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C396745DF;
	Sun, 18 Feb 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="8Hc7Boa2"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E97319A;
	Sun, 18 Feb 2024 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708289870; cv=none; b=bSDtDSUAqyZwiywBiXmWEXq3EW7Hby1GqcZo3C5kUr1aMLhdMg1jR63G5cOFLivfBg6WPdfcCfrbfRMJXFaUgUpobi9+nbPgDwI/PoywhiBctfLDyHzqHRRDEm0lzfJeXGnXl/EhFKKgdCOYLB+eqceFIihBaPWol0Sopdr6nPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708289870; c=relaxed/simple;
	bh=FbkJK8KP8fVR1wliKk7mxVvhgXKJxa9Ji9IBlEF0ETA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUQBWcwKC7zx2mm8pB1QGfx6bSiucjsuOkODICX1ZHuxct0NWvho3CWIahuyGeB+4vW1g6Xv4OyJc/dwg5WJHUtqf7AQMxPwDAa/vVF9E/pPTSmVk1XWB68SzKqNBPH4DuAhAHW8Rf0H6OqCsSeChap0rUDzLMnqoslLuNCtCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=8Hc7Boa2; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1708289862; bh=FbkJK8KP8fVR1wliKk7mxVvhgXKJxa9Ji9IBlEF0ETA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=8Hc7Boa29PCYATFm256xiyFwtFy2RkWl76LAXKpQ7c/YpFJ5DLhh/iWinqEbGe35m
	 2Y0T7DG022Y8QaALkm+ST1huVSNgejYt+RJYLYdx0jGjzFHD7jq1emQEDY7qWRBamT
	 Dn40w9uxAhs9uW0CpHYTadyhAdbQX4LcGYB+6+38=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sun, 18 Feb 2024 21:57:27 +0100
Subject: [PATCH v2 3/3] arm64: dts: qcom: qcs404: Use qcs404-hfpll
 compatible for hfpll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-hfpll-yaml-v2-3-31543e0d6261@z3ntu.xyz>
References: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz>
In-Reply-To: <20240218-hfpll-yaml-v2-0-31543e0d6261@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=FbkJK8KP8fVR1wliKk7mxVvhgXKJxa9Ji9IBlEF0ETA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl0m9DFSHnv8N1X57By7ByakwyQxJA4pzi7unkB
 dvvjGLP2XaJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZdJvQwAKCRBy2EO4nU3X
 ViJEEADDuKfjYmUXCQcLGZpab4fDTRewdX0yGz0Iq0LOgKM8jvdSqEyiKMVhoS14yVQLS/mqD4a
 aEP3CBMO7Qg9XzfI7KvbTcN3JIPvjfbIOXAPrxc+vWpvgS/ZIrhYLpzjx6yZrWnWaYPO0mb5UvZ
 isATINToAh4Np3KJZcl6KIty/RuYrrqMcD++SjAePVOkFeXRUN6SakXO0Z+WMzIrxxKGg9LKa3a
 8Zh/6S51lQfnGTxJvBEQoAPAbu/aLDgJe9va9/jxkI8GQrSwEH8zlhupT6gYORYCglUDoZU6tHj
 4rcTv6EPcWaV/uDwv5q52hXWlc2ImQpZqvP/BR8nNY2wpys0y6z0zweiUB8tSdLsUmWNVqKzVm1
 hIhO6ELjmpphucuKcLIxaCLTYLdKPcmbOmoU4YBNqXj31RLvW02cy9vQOuqE1bBs1FoSk68CLtd
 +mpailVuavvaX7AwFw8X/9+iqLg1+cDmJPzw69ghN9t6xSLjcVCOP8rw+5NZj6LUdikkkpmF9S+
 qeOFRK72c1KbVjlle7qWXNiyKUoQ0OoHL+IMpNtcvXdn1D7+S7oDkc23ZFzoTJxdvKlwJfSE/g4
 sTUxu0y5hE41qmh1p5Wai+I1+YLE44g6vhBN2WHmPk9EZUAc0apKzKQGz/96esQjNQokTDprgOU
 RhNRstJ/I9gMgOA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Follow the updated bindings and use a QCS404-specific compatible for the
HFPLL on this SoC.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Please note that this patch should only land after the patch for the
clock driver.
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 2f2eeaf2e945..4133d5a19deb 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1308,7 +1308,7 @@ apcs_glb: mailbox@b011000 {
 		};
 
 		apcs_hfpll: clock-controller@b016000 {
-			compatible = "qcom,hfpll";
+			compatible = "qcom,qcs404-hfpll";
 			reg = <0x0b016000 0x30>;
 			#clock-cells = <0>;
 			clock-output-names = "apcs_hfpll";

-- 
2.43.2


