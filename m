Return-Path: <linux-kernel+bounces-9634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405FE81C8C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C6C1C23791
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A8B17983;
	Fri, 22 Dec 2023 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eg4ADUhr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4231642B;
	Fri, 22 Dec 2023 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM9dLe2023587;
	Fri, 22 Dec 2023 11:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=/FYaBKtPH0tgnXy7Wvh2r7LXp3sE8okO7iF1J8MDHfo=; b=eg
	4ADUhrZzRzkBGkQacGqwu3O5/LBlEsxnL587Uje9A3bEzHWtSOso70Vo+Y7ByAgF
	xhHAeJU/uRC4bfsENu5BXE6GSwKeOPJDiA+BZltQd9IZJSG4Mwxkb9cFNVE0hyEB
	SQTejPB+PtLbtChHO/sHDgdkHo4ARN3X4bn7Qp9h9Y4JYZGEz7W2FZzXfJMO3aRZ
	NO5qEuIr67Wvw4te+X39bpp2Mz4U7T6nIO74lsn/Q34wMwmeLKLK46pchZ7mBgZ4
	DBTMbwTEHpr6HynAgcrS2JoDqFzx2nL/lfnCzO0uXCuvpkCm8rJfdlEaIjxWjPwE
	IrX+4juRuuUKitY9VEnA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v580sg93s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 11:07:22 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BMB7Jno019230;
	Fri, 22 Dec 2023 11:07:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3v14ymvpvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 22 Dec 2023 11:07:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BMB7JsX019221;
	Fri, 22 Dec 2023 11:07:19 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BMB7I9Z019220;
	Fri, 22 Dec 2023 11:07:19 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id E43FA5299C9; Fri, 22 Dec 2023 16:37:17 +0530 (+0530)
From: Ritesh Kumar <quic_riteshk@quicinc.com>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ritesh Kumar <quic_riteshk@quicinc.com>, neil.armstrong@linaro.org,
        quic_jesszhan@quicinc.com, sam@ravnborg.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_abhinavk@quicinc.com,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com
Subject: [v1 1/2] dt-bindings: display: panel: Add Truly NT36672E LCD DSI panel
Date: Fri, 22 Dec 2023 16:37:09 +0530
Message-Id: <20231222110710.19397-2-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231222110710.19397-1-quic_riteshk@quicinc.com>
References: <20231222110710.19397-1-quic_riteshk@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GXeXJK-z1UuCZ9YIf9iElw3QUG_WJ_bA
X-Proofpoint-GUID: GXeXJK-z1UuCZ9YIf9iElw3QUG_WJ_bA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220079
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Document Truly NT36672E FHD+ LCD DSI panel.

Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
---
 .../display/panel/truly,nt36672e.yaml         | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/truly,nt36672e.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/truly,nt36672e.yaml b/Documentation/devicetree/bindings/display/panel/truly,nt36672e.yaml
new file mode 100644
index 000000000000..39ab05c5b103
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/truly,nt36672e.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/truly,nt36672e.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Truly NT36672E LCD DSI Panel
+
+maintainers:
+  - Ritesh Kumar <quic_riteshk@quicinc.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: truly,nt36672e
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  vddi-supply: true
+  avdd-supply: true
+  avee-supply: true
+  port: true
+  reset-gpios: true
+  backlight: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vddi-supply
+  - avdd-supply
+  - avee-supply
+  - reset-gpios
+  - port
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "truly,nt36672e";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 44 GPIO_ACTIVE_HIGH>;
+
+            vddi-supply = <&vreg_l8c_1p8>;
+            avdd-supply = <&disp_avdd>;
+            avee-supply = <&disp_avee>;
+
+            backlight = <&pwm_backlight>;
+
+            port {
+                panel0_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+...
-- 
2.17.1


