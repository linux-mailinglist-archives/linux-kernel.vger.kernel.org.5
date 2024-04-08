Return-Path: <linux-kernel+bounces-134752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5228C89B663
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB9C281F0F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167691C3E;
	Mon,  8 Apr 2024 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/9DD+rN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A05228;
	Mon,  8 Apr 2024 03:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546789; cv=none; b=GF+CMiAXWiRj9LsXLtQhDBXzbP3QUPGXsRU9NrksROIfiNYa6SFMap7eTCjO/n5mLfe6jlVEyn1gh3Au8ZKIy+TOBqn/sxGU4ni2cUiMDJ3xLl21NdFFJcBASQSqLHLNu1wC51BgfFbGX3ryv4jwNCpHuIsl9E+T79Ho8LZsNM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546789; c=relaxed/simple;
	bh=y93CELgU798zozilMe740Pyai90Z6Y623ic13iToKHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aYtw6iFmUuEwjyGylNIOwZJ60bC9N73N/VLxIdirm6jZDHWcBWTgdNfBA0FY1lxtMZMbVFzLJL2UvCk2nK+g9rLfmWJoSyultZzz03fqqBprHe6ee7VWwJZkK885G8iPTlwoXTYyGQn9b/OcuP9Mxg7btyI5mg1jwK0Oyd9EVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/9DD+rN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8DC3C433F1;
	Mon,  8 Apr 2024 03:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712546788;
	bh=y93CELgU798zozilMe740Pyai90Z6Y623ic13iToKHw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=E/9DD+rNt/YgweHp6RiEO1cKky7kz5Kimv/ixIryQhNM8f3eB5cJn8nrMiv65jWPv
	 5nwbni9yOdgsadbpryIA2Y/MfxF//SgUD3yfxHcjC7/FT1JKhVMsTxMpdu5Zgx4DBx
	 iV8XCHdB8PkSqBDJBneI35jPDEDlrj3W8X1UQYS4NwMiWKwOPOAu+GLkApJOf8bu7C
	 2pRIJfSXf9qpy8xkPB52QkUOporfvBDOZBjOQTzmsE32hsen6NQjufIAZ1iRWHZ04d
	 mAtZmNgesL6BYAbGiY+GwuuE4wIL0slwt8kPjc1Yn91i4d024u4sYK4svlEZgKXlsi
	 CSLmbe6Sl6J9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2C6CD11C2;
	Mon,  8 Apr 2024 03:26:28 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 08 Apr 2024 11:26:25 +0800
Subject: [PATCH] arm64: dts: meson: fix S4 power-controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-fix-secpwr-s4-v1-1-01aa7ee72c52@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAOBjE2YC/x2MQQqAIBAAvyJ7bmELiewr0UFyrb2UuFCB+Pek4
 8DMFFDOwgqzKZD5FpXrbNB3BrbDnzujhMYw0GDJ0oRRXlTe0pNRLXrnYnQjBfIMrUmZm/D/lrX
 WDxnMTcFfAAAA
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712546787; l=1062;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=aYGam5atTvFCi6MANFq1gTnEWCmMJGBzGpQ68DNxd4s=;
 b=QOZasB9XfpjbYCM2NkQXMlQePi2brRVq25BtW9pZQ/O/LAgdf/E30jblrbUc47W0QCYLKqMCn
 Sd+AOKQpyePAuPOG9BkArADHL7TsnkikXqRDb0KtLIx1RUfQSqwjBEd
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

The power-controller module works well by adding its parent
node secure-monitor.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index ce90b35686a2..24d00dce4969 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -65,10 +65,13 @@ xtal: xtal-clk {
 		#clock-cells = <0>;
 	};
 
-	pwrc: power-controller {
-		compatible = "amlogic,meson-s4-pwrc";
-		#power-domain-cells = <1>;
-		status = "okay";
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+
+		pwrc: power-controller {
+			compatible = "amlogic,meson-s4-pwrc";
+			#power-domain-cells = <1>;
+		};
 	};
 
 	soc {

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240408-fix-secpwr-s4-a99ff960d0ae

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



