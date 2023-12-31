Return-Path: <linux-kernel+bounces-13718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A29820B9C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3419D282503
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE48F49;
	Sun, 31 Dec 2023 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="rpeCS7dt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCD45665;
	Sun, 31 Dec 2023 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1704034143; bh=0N0OPAmBa1NtYEUHpBUQN1JVNKCFx25fN/ki65Os83I=;
	h=From:Subject:Date:To:Cc;
	b=rpeCS7dtFMdvIVZK97zguzX+LjeIgxq3WqGgUFvNhrngM4eS0Uuuo+AjOaUr3xg7Z
	 mM3t+yUfv7QdDssBzUyFTrs2iaxKOg0tkrlnQK4PIJcKruQzPNrrZTZh1dfqVDof5U
	 AeWiC1K1q0sjEz6VjhzekF/P97C84BIg4pE9TrSY=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/3] Convert qcom,hfpll documentation to yaml + related
 changes
Date: Sun, 31 Dec 2023 15:48:42 +0100
Message-Id: <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEt/kWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDINLNSCvIydGtTMzN0bU0MjNLMwCKmpkmKwE1FBSlpmVWgA2Ljq2tBQD
 dcCxAXAAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=0N0OPAmBa1NtYEUHpBUQN1JVNKCFx25fN/ki65Os83I=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlkX9RN3K/kYMXLHdIC4SvTq8UfhtScKacU2QAB
 i0PfNIPbweJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZZF/UQAKCRBy2EO4nU3X
 VpypEAC/64eLJdySn/HHH593Y+IvuWI+iuA0f3BT6BJlXMO3RFDkzy5J3ARrs6760vrZDpRU6bI
 lJBitKpY+PW308HB/z5Di1R/CZXs2u/OC9OX321u8FrnhjwCFx0j0mUr6Dd7gEAiUEW06pyvOEc
 RTc6ddUxseb/xHgSBfJokoROPMHCudd45uZMWo9+kysgg+TKET1aRpTxdDtA9ZI6g+WIA6ToeB8
 ow3z814bWYYEb/zSRFnd4HDwn5lAu3Sf6bNYKOGbO5ampOegDxXK3e4TXkiOuBWArVykOd5f7xD
 KxvX64vA9c4soYyzZrTVGcWRcHWsjwi5YRClRUeVqxlirModMTSPoozewW/DDhHc/qmz9haWtmZ
 3alBwxjw2TvqVgpMnK/uTpy+t8C3ASfLubzeT70ymLcS8gUZXfZzBiJAhk/ZeSqN69UPqcP/jnA
 tqOb4c7WfyoJ3PBABY294XFkaRlP3WlQ894ukbQnQxsvuWXGcUI0g0f/ca37yPfirwAWUfJOQKX
 KYCsuG497Krt+vKFHkxMRTzJ6mn6e0kbNDSx92+MmCEFbJRXHoAhc8D4YPZPscSlDOXPcxzLZ8A
 CEYFg18uIM4wNUMMjQHGwWWJDYVQcgBvGxCxAK0il2LHZP3/4JS/BGDd2DGLxQt4VGEGTuVQMUv
 usNqzBGeGlIun0g==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

Finally touch the hfpll doc and convert it to yaml, and do some related
changes along the way.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (3):
      dt-bindings: clock: qcom,hfpll: Convert to YAML
      clk: qcom: hfpll: Add QCS404-specific compatible
      arm64: dts: qcom: qcs404: Use specific compatible for hfpll

 .../devicetree/bindings/clock/qcom,hfpll.txt       | 63 -----------------
 .../devicetree/bindings/clock/qcom,hfpll.yaml      | 82 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |  2 +-
 drivers/clk/qcom/hfpll.c                           |  6 +-
 4 files changed, 87 insertions(+), 66 deletions(-)
---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231231-hfpll-yaml-9266f012365c

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


