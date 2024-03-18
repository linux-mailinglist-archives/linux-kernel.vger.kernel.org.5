Return-Path: <linux-kernel+bounces-106040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CEB87E839
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04772B21571
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D238F96;
	Mon, 18 Mar 2024 11:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8FOSeNk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE5364A5;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710760139; cv=none; b=gAH9NGIjzz5m8bDrnv+UP1LtHQsxagJFjVCy6l4P+R/87VkhpayD58uCYW6L+tk10YsblxlOAbZhVvs6XQGctikUVO7KzcSW1ra37Mr8GtvyZuTgQNIaxru6YPvziELYG5XYTc7GX64XdvydRYRbZDkwh7Wz8z8MCWL7wF/MGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710760139; c=relaxed/simple;
	bh=LbF5XXFvk6aEASRyo5T1oNgGQ0IDpAcetqWbVeoDdks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGBrSLlaD2suCdlWrLvyfImLAJMl7pbsCDuBNUaQJBV6DDmJqHubeji7js7ydKWvYujXbb1Ele0kDkPr+WUPXfiE5q8ICPm+HHPtcKcc6WDLCBuhR5DRyGwIQx4gT9UwdKFtLDCCSH8lDGOxFECOCYF2oVSbvO61xvgzQuv87aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8FOSeNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A968C433F1;
	Mon, 18 Mar 2024 11:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710760139;
	bh=LbF5XXFvk6aEASRyo5T1oNgGQ0IDpAcetqWbVeoDdks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8FOSeNk/y9r/aT7VpvidzMNJsY0MptShLWEY4zGfX2D4aeH51ltatmrwczSxNdJw
	 UarcT8igxfK4R/bT7kvyHolJyssS8Mr3GmpLVhiziX5cD69Eia2itbO0OShky9x9Yy
	 4WfwmurW1F4guk4F4WyQKKteP9mE9m+3IZfvWEcFlLV2lcz0nBvK+zbZgL+HoJSEPw
	 y8ICt14eIW0ufL+jxmZeneKjD4VlYAdQKfd/sntLw+0S7i1hDmmNYqx4q+/Y8CAKGV
	 8Fbf/vCPUF93L2E8zrlyvtTSrLDEHPL0R62qzBrHjsV9NYNSScI/MoctW6Beea/tx9
	 vwsXR67bWmAuA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rmArY-000000008Jl-34xm;
	Mon, 18 Mar 2024 12:09:04 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Doug Anderson <dianders@google.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: bluetooth: add new wcn3991 compatible to fix bd_addr
Date: Mon, 18 Mar 2024 12:08:52 +0100
Message-ID: <20240318110855.31954-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240318110855.31954-1-johan+linaro@kernel.org>
References: <20240318110855.31954-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several Qualcomm Bluetooth controllers lack persistent storage for the
device address and instead one can be provided by the boot firmware
using the 'local-bd-address' devicetree property.

The Bluetooth bindings clearly says that the address should be specified
in little-endian order, but due to a long-standing bug in the Qualcomm
driver which reversed the address some bootloaders have been providing
the address in big-endian order instead.

The only device out there that should be affected by this is the WCN3991
used in some Chromebooks. To maintain backwards compatibility, mark the
current compatible string as deprecated and add a new
'qcom,wcn3991-bt-bdaddr-le' for firmware which conforms with the
binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../net/bluetooth/qualcomm-bluetooth.yaml     | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index eba2f3026ab0..b6fce6d02138 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -15,18 +15,22 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,qca2066-bt
-      - qcom,qca6174-bt
-      - qcom,qca9377-bt
-      - qcom,wcn3988-bt
-      - qcom,wcn3990-bt
-      - qcom,wcn3991-bt
-      - qcom,wcn3998-bt
-      - qcom,qca6390-bt
-      - qcom,wcn6750-bt
-      - qcom,wcn6855-bt
-      - qcom,wcn7850-bt
+    oneOf:
+      - enum:
+          - qcom,qca2066-bt
+          - qcom,qca6174-bt
+          - qcom,qca9377-bt
+          - qcom,wcn3988-bt
+          - qcom,wcn3990-bt
+          - qcom,wcn3991-bt-bdaddr-le
+          - qcom,wcn3998-bt
+          - qcom,qca6390-bt
+          - qcom,wcn6750-bt
+          - qcom,wcn6855-bt
+          - qcom,wcn7850-bt
+      - enum:
+          - qcom,wcn3991-bt
+        deprecated: true
 
   enable-gpios:
     maxItems: 1
@@ -122,6 +126,7 @@ allOf:
               - qcom,wcn3988-bt
               - qcom,wcn3990-bt
               - qcom,wcn3991-bt
+              - qcom,wcn3991-bt-bdaddr-le
               - qcom,wcn3998-bt
     then:
       required:
-- 
2.43.2


