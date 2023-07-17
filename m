Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50654756002
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjGQKBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjGQKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:01:26 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367D710DC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:01:20 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E01E4240106
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1689588075; bh=12nb+rFwdgv0Wijomngor2Tznv5lsVGYBIEwRfZVf6g=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding:From;
        b=kbN5NJNYKj4q3ag033VW0ZLtLzeYFBVtBlGvaDaZqyLZ6Wk+sEr04TaJwUNfZ1xhB
         hyFI9zj/MIUYMjZuX8VHfPWTHWexZzXiD/QgjcVhkEW4K4b7LSfVlvsTFiCyLGDRFP
         KOCJCNhx2eIk3x7Ffqfu12shZnAVbOAXsCpZaLN4KjpWePVNutFG+l//VYh/dCfIRZ
         QUspObvuJkHO653AVN58TpJYFlzgH6NBXQlbgmZowaU95HZpBDXoLgwIEWyCfjOg+h
         jJvoB/1SmaKl/k2QRALLM9ApmwfZaeXoOzG0gJFu3FTs01n+Ky2DP4J/UNdYbrQ43+
         R+cIAmxnUS0HQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4R4HfK6ZRHz6tww;
        Mon, 17 Jul 2023 12:01:13 +0200 (CEST)
From:   Martin Kepplinger <martink@posteo.de>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 2/4] arm64: dts: imx8mq-librem5-r4: Bump up proximity sensor's near level
Date:   Mon, 17 Jul 2023 10:00:54 +0000
Message-Id: <20230717100056.4047292-3-martink@posteo.de>
In-Reply-To: <20230717100056.4047292-1-martink@posteo.de>
References: <20230717100056.4047292-1-martink@posteo.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

There is at least one Evergreen phone out there that reports levels
of 5-6 at rest: https://gitlab.gnome.org/GNOME/calls/-/issues/560

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
index 97577c0a77158..33f398b48119b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
@@ -23,5 +23,5 @@ &lcd_panel {
 };
 
 &proximity {
-	proximity-near-level = <5>;
+	proximity-near-level = <7>;
 };
-- 
2.30.2

