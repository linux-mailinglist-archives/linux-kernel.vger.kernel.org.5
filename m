Return-Path: <linux-kernel+bounces-109936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0F8857F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA52F2822A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E876F58207;
	Thu, 21 Mar 2024 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sd/8wlw5"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E1B5812A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019816; cv=none; b=AdsyY1q/tsrqZHWTin1XIFr+DfRjsFkvPUjxgfdLeeBVCUp9VsI57kjTmOkPtQEZLcceczsghIpOIeF3uwbozqqPDqLJ5a9sy1JiT2QWirbFg5nNC+npcysaCWxhhOCmbygEw7G4rVhAnlNBVOmEobV1Sm928vlGL4EsHN31Azw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019816; c=relaxed/simple;
	bh=IUhajlMiebMRXpZMv8IJ+rUpDu9cL/zwabR+phBMHXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhxxIZ0PQ+sjLuge2ZFZ6FlFX5kkmYOOkB7mctcFoP58akZw29DfUqaTNCwsPFAStOU0p5fhOwYqq5DNuXy9/oqtp9QGTksvKhspVwysnX3FsrthrCUsLXqDODtMlPwPUuoR6bAVom1wFlXCngnI3ywXTsJ1TFO8BFee992YTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sd/8wlw5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6f6d782e4so694387b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711019814; x=1711624614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpm9hzU7yRxndVe5Gx/goNXu2viD1OAzuL4ognrEobA=;
        b=sd/8wlw5O00twv0VLgHZuyESVrLwWXQ6Q0PgxJ1q6zY0d9nXoQ354qRa4USPRk08OK
         umeSb6Kgu9+H1yng/YNhGGuDar31g6gzbn8kT/6FPRnWhTZpWYIK17p+/QTrOHqMz56q
         +nyYnOUpKVawiSy2c2FnEtwlQb1VkUuNNp14hatSSN1qQrouZurIlUMAdfk147xQHFBp
         zAqNiD85rMKqrNlqXEor9nvwRlpEtvpGUeWgS80HYY8FCA1k5kHw+diRcWsXjGwMrvL5
         o23KBHk0MFArN2Swhv7uPrUhpkhqEXng0TLWQ+qzpADrEiTMgFlut6nCF5ZnLuiMBZGh
         4qxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711019814; x=1711624614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpm9hzU7yRxndVe5Gx/goNXu2viD1OAzuL4ognrEobA=;
        b=Yz8xOcssRJ7RoGeBx+SKX1Ojr6Y7ayH/2KM9pnDXE9q8QcRceMgmgVejzDChE9C3tX
         /RXJltxWzOkcyMqy5XTCmq3W+uYum3P6f8pVkm13hKqaC7oMKlN6VSEHHyjih9YXB7we
         yye5B+uFVlfeAB6WlbV3hU129EJ1bUQqgZ1eHQxoX1Sed7a1HrHlLzM1clMlRr/NrcQD
         ABCmorFrE8083FNgDdeHlh7bjzekpO4oeNWJrjNcYVH/PCkiA53gDhopfZYLqOJ35tdB
         3Wmkso9dvWoN2QOeKPeo4zlf69tRtpZp0zkZnx7rt37hQv68P3IDgyxydRFWL+G/9lkB
         GUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8pi9zxoc6loaeTR305x4jwLYqv68hbnfs/wCzL6y4CKGxsXmFdVp9XK72ZvFlmkOGOLeGmL3plS/eftvJLnUjK3CHk3JXV9eL2c7e
X-Gm-Message-State: AOJu0YxoQT0yiEBA/lxs8L3XSCTZYdXr9iQ442d8P3CaSzTLD7i/1Ywh
	9KuiJLBfrMtPfRymgzFIpjxNNURZ+91RGsTltT02oD8n4KW6NsrbUkGhhI3roA==
X-Google-Smtp-Source: AGHT+IFQb+EtsRBxl4QG/ciNRDtQvLa0vxCY7Ds0yjW248XVpLTakMgJOPT/Q1MjZ935yTTACov7+A==
X-Received: by 2002:a05:6a00:4f82:b0:6e8:c6d8:217f with SMTP id ld2-20020a056a004f8200b006e8c6d8217fmr2248910pfb.10.1711019814009;
        Thu, 21 Mar 2024 04:16:54 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:16:53 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:24 +0530
Subject: [PATCH v2 04/21] arm64: dts: qcom: sm8350: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-4-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=IUhajlMiebMRXpZMv8IJ+rUpDu9cL/zwabR+phBMHXo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcJkQBTU7cHMjQHCmaE8rE5vqzECiSajk6OF
 58uXgQKlRaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXCQAKCRBVnxHm/pHO
 9ar9B/4lkmGZ9w867Lq+7Ob1yb3R8dwMvftktOgUQSmPnhqRIvQc8Xs10jR1g9dEEhft8UfUTg0
 BUUTD3UDVxPZE5jGB+Q/Hy5It4wqPlfcVeadsi3W6AUk6eRWlTzAlZArG9g2ASEbJENOhl/kprZ
 IvU2axd9wH9oy2j2rPO3dTRgIcrKYYWRmrfL5PCz1gr2ztQI4jzHZ3T501tNMl85XikHvKvvntV
 3zYGzO3PN0ipEdoeLKrzL74DDNImbXnQjoHwycHXH4LvPNuVBY7SPDcFPoj84CJoT1Sx3k65LvN
 MiEHka6VZz7y7a/Y0WiekYEuFnOTbG4akpP5xzeTj6QgCAWT
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index a5e7dbbd8c6c..a7346b817400 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1572,6 +1572,16 @@ pcie0: pcie@1c00000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
@@ -1669,6 +1679,16 @@ pcie1: pcie@1c08000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie1_phy: phy@1c0e000 {

-- 
2.25.1


