Return-Path: <linux-kernel+bounces-127037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBA189460F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3451E1F232D8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D65677C;
	Mon,  1 Apr 2024 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKoOSyJ0"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24153E2C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712003629; cv=none; b=eMJZXGUS/XkTYz0paEg/zSYSc4dI3CdV0TXRBqb0rRNHL++RUocQpyNp1gQm/KYpCjXbmLxX0+HzbgQRw8DDy3GvELvvBrm+gt1jLS1sb7uNBS83MUUGR6bJlpSDV9Y3DTLg3ExBnSh8ieKATPdSsSqfMxVW85X5BlgCrTkdpHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712003629; c=relaxed/simple;
	bh=6si3gBmbo9hW2Dn7hkIjEsjv5s2gkDHJdnkmLUy/Hlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aCXchyYNfJENofmdSVOAqaY77bb62FQ87IrE1IqEPvOtwiYNgSUwF//gt9otBBjby79cS+irUXwM0XYqG9j18f5sOmRDRaOIVynLlO6pMY8xL3LUE0+SpsvIcVcHP72sAWoi9PSQVZSmSEr2GQUY0+p29sW7vwEcdjn5yDGRlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKoOSyJ0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d4559fb4so5396297e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712003625; x=1712608425; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrjDE8MiuiJdDcIyM4PBx9cbplmfRZdA0Hz/5oAovCY=;
        b=UKoOSyJ0pIeFq/1LOkhGQtBCf5YEeKAems07eXZs47wux7MY6iJmgPr0fefiz1ZDNM
         AokYSxYapC+ByWMwW8sXrdTP830AHEkGlBvllZP+rHi9FAIToyBssT6H1U//3rpmRVal
         +j/48TQ1b/PNeJT2LfpcVwy/uYklLPfAx99NDb0+vBGX1xuS3Ql5mPu48C36BVjkqQu6
         U6rut0XASsXorE8HMcNy4vU2/WzG/6phiHcguvx6RDdFQwpSK4NgzPQrbkKEb0NlI8rS
         iVpPmusHdhirNVs6D8G6Q+MIMWsIpIu+AvwACBfHGZBd1KXlYm+Aznqrf+Yjr7+OS14x
         Az+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712003625; x=1712608425;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrjDE8MiuiJdDcIyM4PBx9cbplmfRZdA0Hz/5oAovCY=;
        b=USqAQgQGeTAALwNPEmVVKTVvk8RjmdNi8FGYk+mqmLPgdb2jg+VpRfeB24oPeturU1
         VTxEWyHuaWmH8XC035GMXVDSuz+PN86nTIVAWSN3Y+l01tMXltnGMuGNUWrpBMXOnoPy
         n0J7Bher+RsUIj++FrxwQSENVJbsUBD4acgfrnbmjcPuX9/w+hjZpVSPhXOxduLzHE8C
         H1xj1JWN9/Y87RalzphesOofuEON3T37JiBeYr/2UjGz9rWLVkYxiSVnYXPQOU1dfHwG
         Wz4Rf/hl5jx/2qPE1ia4j6XpEvCTer14yJH49b7dDVwC5gBCx688KlR9m81/xDDVR7Ne
         NPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWieLynnV8Nno/FjTdwcn/LZc4qjBUS3uOdJKdGMHOBwIImvSPD19fTqihHNtK30udX7mFsjrmONwIQep/Y1W36yvlLynugbMyEHBuo
X-Gm-Message-State: AOJu0YzTLCGuxmoCDaeeZcrC0kelSILFm2jPHCYKzpERtS7Dre7ayx6t
	VUDX9YNf0Um83rKqK6sRG9LYl8e706KjwnchERWH22TwTgO24avf+AiC8aHYZK0=
X-Google-Smtp-Source: AGHT+IFTQ6cw3uX8Whku4i3wIWWtcB1k+SumXZ+Mbmo/O1iXeOxOSsAApyKLIiFU45RbHBSh0X2nZg==
X-Received: by 2002:a05:6512:3e12:b0:515:d19b:babc with SMTP id i18-20020a0565123e1200b00515d19bbabcmr10200965lfv.68.1712003625659;
        Mon, 01 Apr 2024 13:33:45 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b00515a6e4bdbdsm1478342lfk.250.2024.04.01.13.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 13:33:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 23:33:43 +0300
Subject: [PATCH v3 4/9] arm64: dts: qcom: sm8250: add a link between DWC3
 and QMP PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-typec-fix-sm8250-v3-4-604dce3ad103@linaro.org>
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
In-Reply-To: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=6si3gBmbo9hW2Dn7hkIjEsjv5s2gkDHJdnkmLUy/Hlo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCxolUlGl/mYsMFMC55okIjV03JH+Q6Vosk/7Q
 j7wyxsBK/SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgsaJQAKCRCLPIo+Aiko
 1fDwB/sEkX+91a2HKqF3O27tZv7a++1/YnNenWI2oIlQkrGHri9mY+jayI1qeJj/UnemXJHOmG4
 da7QWHwv+/xjOfozZ+CnKiPXNW9ymwmDmmt7Iz50uYAIdXbxuLKv7I6pj+DNelidq26mh4Z59bI
 ZbCruPMOj7A/mCYfHjRxzx1WfS8VilNdjdlTm5EZzqTJq/UvJSX2CGfFgO1DSpxWZEXCjkaGh/R
 4SKZGNEXxklAsb7hGy9VxGEVimQLb/P9gxd5LQIavyMyYlxl/+rML423/YRnPT6Wa/R/S2GnFbf
 Okpo+36kHdw0Nz3ctI/C6kezzQStjBoyZwpX1DjTY/BFmOuT
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SuperSpeed signals originate from the DWC3 host controller and then
are routed through the Combo QMP PHY, where they are multiplexed with
the DisplayPort signals. Add corresponding OF graph link.

Reported-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 440bbb89bf8a..cfc07dd9d0ec 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3917,6 +3917,10 @@ port@0 {
 
 				port@1 {
 					reg = <1>;
+
+					usb_1_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_ss_out>;
+					};
 				};
 
 				port@2 {
@@ -4195,8 +4199,24 @@ usb_1_dwc3: usb@a600000 {
 				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
-				port {
-					usb_1_dwc3_hs_out: endpoint {};
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_1_dwc3_hs_out: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_1_dwc3_ss_out: endpoint {
+							remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
+						};
+					};
 				};
 			};
 		};

-- 
2.39.2


