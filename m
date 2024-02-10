Return-Path: <linux-kernel+bounces-60472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B791850562
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE171F220C4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CDE5C8FD;
	Sat, 10 Feb 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="J5wKH7Gs"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D7E53815;
	Sat, 10 Feb 2024 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583546; cv=none; b=WepdmjkIsIIpkcN2ZJUIGXCu1gqOMqGbVTEk4yo5iVVK0LpAC4MTj8TicQZztFnit+Hh342dYd4U+zZshdcXzAffzXvyv279vbJ5XJOPPWxM46qQX2PpqTj8hNcJCIx6Hao6xqGrOGLuG7CrtLI9M+0VO4AMMnRJKCSygNtAAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583546; c=relaxed/simple;
	bh=4LyuSFtAH8dWWrZ0TdSmOR1VTioRfo0NSD7Xn7VGFGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c9u7atVSIp9bCXIaeStX69x+PxXnsABsN5/mSGd4bnunCrnNMFwbqLN7coMjnDUpG9UjTjN1S1Jqm9l5yD2Y7DXqC0Xd6h4RhVVjYsuMSBR19C4LUQsd8UmddMnpTdpi4RXmBg4gTSZ/hljQN7vCkt7fUVWfGjWUYwFq/Fj4Cl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=J5wKH7Gs; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1707583542; bh=4LyuSFtAH8dWWrZ0TdSmOR1VTioRfo0NSD7Xn7VGFGg=;
	h=From:Date:Subject:To:Cc;
	b=J5wKH7GsmmoA90iPoUjYjckXz+rIS0s3lrsdeo8Z6oaRchZovUxG/dMvuS8OhRhE9
	 gkTN/BtHgNwjfBTlVJNkIFWyryS7Wa0LemsmUgCXvS9Ht9ozBZVScLbY1CX6hZ4NPc
	 K8+ZOMSwTm9etD/mLV3O+4PSAqyopqhMiWAJfdtA=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 10 Feb 2024 17:45:40 +0100
Subject: [PATCH v3] ARM: dts: qcom: msm8974: correct qfprom node size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-msm8974-qfprom-v3-1-26c424160334@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIADOox2UC/32Oyw6DIBBFf8WwLoaHWuiq/9F0gThUFqKCGh/x3
 4smTbppl2dyz72zoQDeQkC3ZEMeJhts6yLwS4J0rdwLsK0iI0YYJ5QT3IRGyGuGe9P5tsEFlZq
 AMKyAEkWpVAFw6ZXT9aH1OmY+SpHSdMG6G42H/gh3Hoydz/XHM3Jtw9D65Xxmosf15+5EMcXym
 itFIAci+H3lbhjTeVnRUTWx/zqLOhdcapPRSgJ86/u+vwHuonN8GAEAAA==
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Eduardo Valentin <edubezval@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1645; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=peTVay4s/vEFP1xuIof2gqhA52otBBr/es0IRRtLLgo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlx6g1kxsk59DftR8bHzdIk0OfLUVwAx4GIsCB8
 m880mDOfleJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZceoNQAKCRBy2EO4nU3X
 VjoQEACHSyPAgR37KKm8sMLAWsYLyK+wcIPisBND9Kx6T+78GNNPMf/ZvJj6D7DEk8TjXYE2Nuw
 xWevyDHF6/Z0JjT/FoqXa+dMQ+VXOCm+xTZYPqcHsEmdGd9RPrZHujHSDod5tOeO3hTVYUWmO7v
 3GEdu4cH4GEgv3DlbnQJewDKdJtTYcCVmh/yKzDomSuFN7X5Sm0w11/6yjZwKbsoQ55aWhe1pos
 0RbN6iRHB3lkYTkYq1qHBVZaKBSBhAY/Bz+IA/Ro9WvpLbzZajxZeyVTlm/4F9vFSmf+/twe+bz
 qtiORq+j3KrCj6fMRAWYya5DcFluczRRN8Y5+pgkHopc/RqBvOSUJ03VRAMULLTbFSMIKrpiJHP
 v21f/CKSGN3GWHTOyoCnGcG7BvZOQZxJKEY66dgn0Zyh1GvDk2bdp4YjhAi1pCQ8J2Q9Uq1+ohC
 lOj0hK9SkK9iOr6gx99YGeSvTdXEsuYlCU0M9UWxb1Bn4NiQf0ElcBlCViATPMVYmOPxiRXGFw/
 FeZ2dLb2bapkxMa7ju+JyyHMM7aZlnh1z+gMIeVyw3fXB629CVogf27r/9uGl/GjWu7aypknLbZ
 Q6psbh8lS8KIRIPWaUptx27EbXHMJzE3IihcldaJ8fT5hpXLrK3NzMxTFhmRTCthA8G+lfAiYkv
 3layf8Pxk0qirOw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

From: Craig Tatlor <ctatlor97@gmail.com>

The qfprom actually is bigger than 0x1000, so adjust the reg.

Note that the non-ECC-corrected qfprom can be found at 0xfc4b8000
(-0x4000). The current reg points to the ECC-corrected qfprom block
which should have equivalent values at all offsets compared to the
non-corrected version.

[luca@z3ntu.xyz: extract to standalone patch and adjust for review
comments]

Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes")
Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v3:
- Update size from 0x3000 to 0x2100 (Dmitry)
- Link to v2: https://lore.kernel.org/r/20230130-msm8974-qfprom-v2-1-3839cf41d9ee@z3ntu.xyz

Changes in v2:
- Keep base offset but expand reg from 0x1000 to 0x3000 (Konrad)
- Link to v1: https://lore.kernel.org/r/20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index b1413983787c..083ab780ab7e 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -1234,7 +1234,7 @@ restart@fc4ab000 {
 
 		qfprom: qfprom@fc4bc000 {
 			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
-			reg = <0xfc4bc000 0x1000>;
+			reg = <0xfc4bc000 0x2100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 

---
base-commit: 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
change-id: 20230130-msm8974-qfprom-619c0e8f26eb

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


