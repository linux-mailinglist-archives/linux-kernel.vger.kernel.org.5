Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DFE78FB10
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348869AbjIAJlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbjIAJls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:41:48 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1F910E2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1693560380; x=1696152380;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E+v9TbCau3GAYN6dDk8KioR/AKCEUyLQ6QMdiSo0STI=;
        b=EadiMG/tx/djANNSzS0yCZup6yVlSozqn2jUEjh4IcE9ygGd78SIjGjnQvaHKBdC
        jiUW8ahyy/kpF5OMueO2opS6ZM+uGFsy9u3mqWyc+m7rQDmHKXnXZbwqm8vK+vGF
        WCu63FRHh60GVAuXsxjW5sHDxU4OTTWPvg5Ue/e6i50=;
X-AuditID: ac14000a-923ff70000007ecb-fd-64f1ae3cb435
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D9.5A.32459.C3EA1F46; Fri,  1 Sep 2023 11:26:20 +0200 (CEST)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 1 Sep
 2023 11:26:20 +0200
From:   Yannic Moog <y.moog@phytec.de>
Date:   Fri, 1 Sep 2023 11:26:16 +0200
Subject: [PATCH 1/2] dt-bindings: arm: fsl: add phyGATE-Tauri-L board
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230901-tauri_upstream_support-v1-1-ed30c6df789b@phytec.de>
References: <20230901-tauri_upstream_support-v1-0-ed30c6df789b@phytec.de>
In-Reply-To: <20230901-tauri_upstream_support-v1-0-ed30c6df789b@phytec.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>,
        Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42JZI8nAo2uz7mOKwcPp+hZr9p5jsph/5Byr
        xcOr/harpu5kseh78ZDZ4lDzASaLTY+vsVp0/VrJbHF51xw2i9a9R9gt/m7fxGLxYou4Rfc7
        dQdej52z7rJ7bFrVyeZx59oeNo/NS+o9+rtbWD02vtvB5NH/18Dj8ya5AI4oLpuU1JzMstQi
        fbsEroyz/5wKHrJX7Hzcw97A2MXWxcjJISFgInFowk/GLkYuDiGBJUwS92feY4dwHjJKzO6a
        wwhSxSagIvH4xT1WEJsFyL5x9i5YXFjAVaLv/gQmEJtXQFDi5MwnLF2MHBzMApoS63fpg4SZ
        BeQltr+dwwxR4imx49YRFhBbCMie+buTHcTmFPCS+LfhCwvIXhGBF0wSx6b9YAVxmAVWMEps
        evwM6lRhifZFt5ggumUlXpzvZYeIy0tMO/eaGcIOldj6ZTvTBEahWUhumoVw0ywkNy1gZF7F
        KJSbmZydWpSZrVeQUVmSmqyXkrqJERRfIgxcOxj75ngcYmTiYDzEKMHBrCTCG2v2LkWINyWx
        siq1KD++qDQntfgQozQHi5I47/0epkQhgfTEktTs1NSC1CKYLBMHp1QD46Z4+9v1iavsHBMk
        n91babV50y83t/Bbf3gTX3uVrRLJ+CypcET0dmf8k2VbylynvPg7U9XZu4w7IPdektMqi79X
        /b6ZmV4z2qMkmvVDecUSeaHmF9YrbLQNZi2UfO5z5tRDcaUZDp6brmZX8fOtMpN5XWIC9HPL
        /1krzjwSWCfk/mXVvroVSizFGYmGWsxFxYkAb4I8rp0CAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt compatible for the phyGATE-Tauri-L board. It uses the
phyCORE-i.MX8MM SoM

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 2510eaa8906d..570794ce2813 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -974,7 +974,9 @@ properties:
 
       - description: PHYTEC phyCORE-i.MX8MM SoM based boards
         items:
-          - const: phytec,imx8mm-phyboard-polis-rdk # phyBOARD-Polis RDK
+          - enum:
+              - phytec,imx8mm-phyboard-polis-rdk # phyBOARD-Polis RDK
+              - phytec,imx8mm-phygate-tauri-l    # phyGATE-Tauri-L Gateway
           - const: phytec,imx8mm-phycore-som        # phyCORE-i.MX8MM SoM
           - const: fsl,imx8mm
 

-- 
2.34.1

