Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDBA79EC9D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjIMPWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbjIMPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:22:50 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E201BEC;
        Wed, 13 Sep 2023 08:22:43 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38DDNbMk007131;
        Wed, 13 Sep 2023 11:22:25 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3t2y8f563g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 11:22:24 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 38DFMNpw004937
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 11:22:23 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 13 Sep
 2023 11:22:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 13 Sep 2023 11:22:22 -0400
Received: from daniel-Precision-5530.ad.analog.com ([10.48.65.230])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 38DFLmjC007886;
        Wed, 13 Sep 2023 11:22:16 -0400
From:   Daniel Matyas <daniel.matyas@analog.com>
CC:     Daniel Matyas <daniel.matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 2/4] dt-bindings: hwmon: Added new properties to the devicetree
Date:   Wed, 13 Sep 2023 18:21:32 +0300
Message-ID: <20230913152135.457892-3-daniel.matyas@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913152135.457892-1-daniel.matyas@analog.com>
References: <20230913152135.457892-1-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _z_s-ZBdPl4UijuCYQUZkHi74r9CjPEp
X-Proofpoint-GUID: _z_s-ZBdPl4UijuCYQUZkHi74r9CjPEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_09,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2309130125
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These attributes are:
	- adi,comp-int - boolean property
	- adi,alrm-pol - can be 0, 1 (if not present, default value)
	- adi,flt-q - can be 1, 2, 4, 8 (if not present, default value)
	- adi,timeout-enable - boolean property

These modify the corresponding bits in the configuration register.

Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
---
 .../bindings/hwmon/adi,max31827.yaml          | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
index 2dc8b07b4d3b..6bde71bdb8dd 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
@@ -32,6 +32,37 @@ properties:
       Must have values in the interval (1.6V; 3.6V) in order for the device to
       function correctly.
 
+  adi,comp-int:
+    description:
+      If present interrupt mode is used. If not present comparator mode is used
+      (default).
+    type: boolean
+
+  adi,alrm-pol:
+    description:
+      Sets the alarms active state.
+            - 0 = active low
+            - 1 = active high
+      For max31827 and max31828 the default alarm polarity is low. For max31829
+      it is high.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
+  adi,flt-q:
+    description:
+      Select how many consecutive temperature faults must occur before
+      overtemperature or undertemperature faults are indicated in the
+      corresponding status bits.
+      For max31827 default fault queue is 1. For max31828 and max31829 it is 4.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8]
+
+  adi,timeout-enable:
+    description:
+      Enables timeout. Bus timeout resets the I2C-compatible interface when SCL
+      is low for more than 30ms (nominal).
+    type: boolean
+
 required:
   - compatible
   - reg
@@ -49,6 +80,10 @@ examples:
             compatible = "adi,max31827";
             reg = <0x42>;
             vref-supply = <&reg_vdd>;
+            adi,comp-int;
+            adi,alrm-pol = <0>;
+            adi,flt-q = <1>;
+            adi,timeout-enable;
         };
     };
 ...
-- 
2.34.1

