Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D497077EC5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346717AbjHPV4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346661AbjHPV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:56:15 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4EB2713;
        Wed, 16 Aug 2023 14:56:13 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GK9ce8019826;
        Wed, 16 Aug 2023 21:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=dk5k6u/sI9iN3+yUtFn5EJMT5UPXLcBIp9iFZkAqb9E=;
 b=YZ0DnxWy+ZnU+0Fo1y/Q8C2sePjaKkyTGDl+JKpU6f5M2AqsEV9GzSsVbCIn+KQp7g9k
 sknaewy0R0uK/7Jrsl/YTPTAKDo1lzxOTImzfe6zvMVCFTannHGW1kwLAploe6AH3Fog
 m5HHFQuRb2hVxAf7TdLGeOUlJOY8GnoeXa9mVejSIAVSCCNoqXLIpJ1AWvEkCRNMxc9i
 29lSj/DL2isZjsVsa33my/H9ddy0CqVR9osEmxprHRu3U1FHTUtGhsDnEGutlPIHN45K
 RW9d3re/TGbaTTl2ddmXpBk+VdOjM4aNXto0bUuem17s2r4Q5y9lTyWFoDwu6+piL9UE wg== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3sh5880w89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 21:55:49 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 0276D80171B;
        Wed, 16 Aug 2023 21:55:49 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 2A0CD80BA10;
        Wed, 16 Aug 2023 21:55:48 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, nick.hawkins@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] MAINTAINERS: HPE: Add GXP UMAC Networking Files
Date:   Wed, 16 Aug 2023 16:52:20 -0500
Message-Id: <20230816215220.114118-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230816215220.114118-1-nick.hawkins@hpe.com>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: 8w6JR2cMxvQC3w6ckR4Y1JqMgnQZTf4Y
X-Proofpoint-ORIG-GUID: 8w6JR2cMxvQC3w6ckR4Y1JqMgnQZTf4Y
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=957 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

List the files added for supporting the UMAC networking on GXP.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v3:
 *No change
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

