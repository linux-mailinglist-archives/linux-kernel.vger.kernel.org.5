Return-Path: <linux-kernel+bounces-16351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C6D823D28
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7171F2569C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1863E200CC;
	Thu,  4 Jan 2024 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpgwBssn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51686200BA;
	Thu,  4 Jan 2024 08:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D01CCC433C7;
	Thu,  4 Jan 2024 08:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704355581;
	bh=1vebKQJblrG86S5++1St1MqRaCI8CVymOg+fHMfgV6k=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=KpgwBssneyLNbHf9geF92QnI7yEhdEABRU6vXm/NIjsaV+PIzYk+q9CqhOH4xIS8I
	 MXdzPGtf7TGSvYZo1eEgQEIMEZdZepOi6p8zZvV27CHm7OYbX7qA6onWy1CM3dP7oD
	 Im84JRV28kuFV6mip3oTFY9gw/mRa4vOCC1sm5OLBLXS0KqE86ALEd4His3dGmVZwc
	 njLcplUkV+HqV5ysBWoTa8pHrJNbUatLAf0POIKySh17NFGBoxglrjBUobsxRwJXIp
	 sjy6RDlBseOPNjEpzAdMcYaJ0Hd4LtfpaJxAPrhQBqJoaLRuxtNUlQ7e6QpsqIYJDp
	 cFQYu9r6RPeIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B045EC47074;
	Thu,  4 Jan 2024 08:06:21 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Thu, 04 Jan 2024 16:06:15 +0800
Subject: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for gcc
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPdmlmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwNj3fTkZN2U/ORi3dKClMSSVN20RDMDE1Nzy1QTMwsloK6CotS0zAq
 widGxtbUAaVWelGEAAAA=
To: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704355580; l=1131;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=k5FTL0tX68N7q+lBdyKrIo31KP7acdzIrxYT2OyhZgc=;
 b=abrCFCuxmPSnsCJ/y93AtFGTJtZeBMF/Ug3F25N8p70GehtN+AlwjkWZ6xyxqiJwe88E62ByO
 1HXk03ySoYeD2BMgm1d61JWlTKQ+WvwsPE4zDk34U38oNGgJjycfQeK
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received:
 by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Property '#power-domain-cells' is required as per defined in qcom,gcc.yaml
so add it for ipq6018 gcc device node to eliminate following warning in
dtbs_check:

arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
	'#power-domain-cells' is a required property
from schema $id: http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 39cd6b76b4c1..54914912d610 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -386,6 +386,7 @@ gcc: gcc@1800000 {
 			reg = <0x0 0x01800000 0x0 0x80000>;
 			clocks = <&xo>, <&sleep_clk>;
 			clock-names = "xo", "sleep_clk";
+			#power-domain-cells = <1>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};

---
base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
change-id: 20240103-gcc-docs-update-fa604579e468

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>


