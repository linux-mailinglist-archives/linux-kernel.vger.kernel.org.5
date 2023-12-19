Return-Path: <linux-kernel+bounces-4851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92EC8182DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C351C23865
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9F7125BD;
	Tue, 19 Dec 2023 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrkGf0pj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1660914267;
	Tue, 19 Dec 2023 07:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E728C433C9;
	Tue, 19 Dec 2023 07:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702972761;
	bh=1sgQFykm1ORiXK1WhY/sR6/eTfRFdg3rNtcOzsoHBKg=;
	h=From:To:Cc:Subject:Date:From;
	b=TrkGf0pjjy7OyTZ9ESNpdiicydh7kvjb45AK0FcNKSwyLiax1pQevFk86Pc2tNFgO
	 R5qPdtNyGtT6wlHLV50hi9xgAsjX+IRbf0kvAe1WologqRjxbE7Zm9ujM7GV8aXoXm
	 OoxxIDFcP5N0sWCFCELaoT3kaDI9RCkAoV70DXd8an3Bam6ohnAQ5oaxXGU4Rq90jK
	 Jsfa0kuWeNbAQ1mftvb2jyk2guZSdYKvWLk3XtqyQYsdigllvbO/b8LOumrP84SGLB
	 aRcnHcN8RZY7QYftzBi/vyvfmb4xWEj8TG4TSBmtqJQ4vf9WmgVF2OfDkpjqE1nhjF
	 nj3d3vxHDSKyA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rFV0X-0006aU-2D;
	Tue, 19 Dec 2023 08:59:18 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: regulator: qcom,usb-vbus-regulator: clean up example
Date: Tue, 19 Dec 2023 08:57:49 +0100
Message-ID: <20231219075749.25308-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree node names should be generic; fix up the
qcom,usb-vbus-regulator binding example accordingly.

While at it, drop an unnecessary label and add a newline separator
before the child node to improve readability.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/regulator/qcom,usb-vbus-regulator.yaml          | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
index 89c564dfa5db..534f87e98716 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
@@ -36,10 +36,11 @@ unevaluatedProperties: false
 
 examples:
   - |
-     pm8150b {
+     pmic {
         #address-cells = <1>;
         #size-cells = <0>;
-        pm8150b_vbus: usb-vbus-regulator@1100 {
+
+        usb-vbus-regulator@1100 {
             compatible = "qcom,pm8150b-vbus-reg";
             reg = <0x1100>;
             regulator-min-microamp = <500000>;
-- 
2.41.0


