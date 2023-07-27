Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAAD765E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjG0Vwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjG0Vw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:52:28 -0400
Received: from qs51p00im-qukt01071502.me.com (qs51p00im-qukt01071502.me.com [17.57.155.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631BE2D40
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1690494746; bh=+yMY0ohtegHsjd/hVfvS5lvwXcdsut+yxwy4BJPQo88=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=teVTo2CFfdpWb8jsL3Wll5BqBrXd1SGLPa1SQec5ZF8wvDTXshsC52ZpifSNWvuTa
         awHoGdcf3etmRrfVdt2G+AEyKuYdpQb3wNCZhLCfrtySAayKATJyxDKA/08MqJ9Id5
         luG2PM8p9kNYQlE6ZFufwParlwsUrZUoyjuSYdV1gcbOGG+k+fEo6bVvt186D0epCL
         Q+FNTvhnk8FPKTvpbLn0R9cNhlHzz5J5rtjRBLD7ina6DUTTO/aLTNFcGCVRPCiPUe
         /QIYmfx63kmFdt7GmG/RBRgc3O8y2GBTsiqy+E9m5TgsnbOQTcJTpK7gByNUyjghAT
         X3CV1JtsoPBxw==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01071502.me.com (Postfix) with ESMTPSA id 5B59B668068A;
        Thu, 27 Jul 2023 21:52:25 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alain Volmat <avolmat@me.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] dt-bindings: display: add st,stih418-vtg compatible for sti vtg
Date:   Thu, 27 Jul 2023 21:51:26 +0000
Message-Id: <20230727215141.53910-3-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727215141.53910-1-avolmat@me.com>
References: <20230727215141.53910-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UWnD-uZ5rLJpWTxkueyAUge1OYUeBQyH
X-Proofpoint-ORIG-GUID: UWnD-uZ5rLJpWTxkueyAUge1OYUeBQyH
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=606 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307270198
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible in st,stih4xx.txt in order to support sti vtg on
stih418 platforms.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 Documentation/devicetree/bindings/display/st,stih4xx.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/st,stih4xx.txt b/Documentation/devicetree/bindings/display/st,stih4xx.txt
index 6778b3e7ad5b..5450e1db8b8d 100644
--- a/Documentation/devicetree/bindings/display/st,stih4xx.txt
+++ b/Documentation/devicetree/bindings/display/st,stih4xx.txt
@@ -2,7 +2,7 @@ STMicroelectronics stih4xx platforms
 
 - sti-vtg: video timing generator
   Required properties:
-  - compatible: "st,vtg"
+  - compatible: "st,vtg" or "st,stih418-vtg"
   - reg: Physical base address of the IP registers and length of memory mapped region.
   Optional properties:
   - interrupts : VTG interrupt number to the CPU.
-- 
2.34.1

