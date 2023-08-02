Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D2B76D892
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjHBUWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjHBUWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:22:18 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDDE10C7;
        Wed,  2 Aug 2023 13:22:16 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372IWJgr030377;
        Wed, 2 Aug 2023 20:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=a1qFwhdGLlotWt2azOSRVBZpAoKwOAAUyw4SiQNQcSc=;
 b=I5/0NHZEgbFwYkM0Wlx1VSHKOxwA9+RgmE2CHWoIWFbiYql3aHtYBAA+CNlxn/7ncs3z
 /vX1MWL2EU2wPZP6WNFNIb3/RaYXVvx1IsMgDcpurn29l7qD4SwEFU7UuBzwz7F3HH8g
 pZzHGKpb54e23tXTykDM3hiMIhnKFHWWTeWwbbF2BV8vkT7fMSMccYRtgrCMvXv3CmhH
 dwlr68biP/V+gtiMXGac80/Czee5QatI3J1ouCSmYW8HH+vdvJvAy0jhk8jld+C+zbIa
 yqZzYdJzfxyEpQAJP55FSHQYNats6W8I6z3SNnvHWDkDFk9di13msRkKV7q/RS+f6qow XA== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3s7rbntyph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 20:21:59 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 4A20B8047AC;
        Wed,  2 Aug 2023 20:21:58 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 4F5DF80F07E;
        Wed,  2 Aug 2023 20:21:57 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, nick.hawkins@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] MAINTAINERS: HPE: Add GXP UMAC Networking Files
Date:   Wed,  2 Aug 2023 15:18:24 -0500
Message-Id: <20230802201824.3683-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802201824.3683-1-nick.hawkins@hpe.com>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: moIPOT1-sUx_3HnJ-L7myeCB6O1afj5j
X-Proofpoint-ORIG-GUID: moIPOT1-sUx_3HnJ-L7myeCB6O1afj5j
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 spamscore=0 clxscore=1015 mlxlogscore=945 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

List the files added for supporting the UMAC networking on GXP.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v2:
 *Changed dt-binding net directory files to "hpe,gxp*"
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..c0bb534bec97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2243,6 +2243,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
 F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
+F:	Documentation/devicetree/bindings/net/hpe,gxp*
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	Documentation/hwmon/gxp-fan-ctrl.rst
@@ -2252,6 +2253,7 @@ F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/i2c/busses/i2c-gxp.c
+F:	drivers/net/ethernet/hpe/
 F:	drivers/spi/spi-gxp.c
 F:	drivers/watchdog/gxp-wdt.c
 
-- 
2.17.1

