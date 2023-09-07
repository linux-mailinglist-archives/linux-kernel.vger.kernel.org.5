Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F496797DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbjIGVJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbjIGVJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:09:28 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1744C1BCA;
        Thu,  7 Sep 2023 14:09:21 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387H1xMs006282;
        Thu, 7 Sep 2023 21:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=GTxw/jfcBQkTByCYP+2APEihQLyx72ewkGzUOdjpTds=;
 b=iMFliCXOGHlNvxoiTy7/jXTgx8L+lkybP1RChlhX2qrb9ARiAJTDg1eIi0Vs/1SyDZQb
 6tN1r4oV8T6CcI8rD5zbsnISyTzOt9yltpUa024XgFXe6GINao+Zd53Ffy84iSKUqNM8
 qjdPNmWLIi7xxZG6474D6/nhrDUNr0dGCJJ5OUnAkJ3U2PPEr/f2MyQKy1FU+utQVEKB
 3vohNe5suqxmVTxJqM9/TgrKTy2t9kfTQ5m9rJfxWRO1iZrKAabjXlWT5JeFzTHPYa/S
 o4fQk+H3CEZj4p1ln9T0i+K1k40rj0LA7KOnWN3pq7T/+F31TgXmiUHPLELQWCFe4KpI Yw== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3syavw6tbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 21:09:07 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9AC5C13185;
        Thu,  7 Sep 2023 21:09:04 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1BC5A80B3BA;
        Thu,  7 Sep 2023 21:09:04 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richard.yu@hpe.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] MAINTAINERS: add USB HUB support for GXP
Date:   Thu,  7 Sep 2023 16:06:01 -0500
Message-Id: <20230907210601.25284-4-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230907210601.25284-1-richard.yu@hpe.com>
References: <20230907210601.25284-1-richard.yu@hpe.com>
X-Proofpoint-GUID: _qUHJu7mtFnHlD8IE_utZx5-ID8CdkmE
X-Proofpoint-ORIG-GUID: _qUHJu7mtFnHlD8IE_utZx5-ID8CdkmE
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=536
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

Add the usb hub driver and dt-bindinng documents.

Signed-off-by: Richard Yu <richard.yu@hpe.com>

---

v2:
 *Changed file to hpe,gxp-hub.yaml
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..e16b8b39d47f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2245,6 +2245,7 @@ F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
+F:	Documentation/devicetree/bindings/usb/hpe,gxp-hub.yaml
 F:	Documentation/hwmon/gxp-fan-ctrl.rst
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
@@ -2253,6 +2254,7 @@ F:	drivers/clocksource/timer-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/i2c/busses/i2c-gxp.c
 F:	drivers/spi/spi-gxp.c
+F:	drivers/usb/gadget/udc/gxp-udc.c
 F:	drivers/watchdog/gxp-wdt.c
 
 ARM/IGEP MACHINE SUPPORT
-- 
2.17.1

