Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EC67C9CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjJPBdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjJPBdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:33:08 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9CCDC
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 18:33:07 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B7F072C0733;
        Mon, 16 Oct 2023 14:33:05 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1697419985;
        bh=ko5T8oZxTS9rIyp1bVTVligc3kX9bo+JSpSRE33ApsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhYgZVE5mzOHTRTF/qyeXifd9fuLrkEsacshOLJ5gze9eEP7cszJ6BdreWlvrxmA6
         GmhwOJsQGTnMbY2glQZtdj63PMSQndKiMw8yyGSRerpeqi18naWry34mRwbxzDFMGX
         Djy9QLRXIAiA4kPrFlO/jYSXo18wNCDpjo+oQQWPViI9v1G6wpWx9p0WN1+MNw3F6d
         BjEq9QS0nwlNtrWvvmp7FC3IW3chRf2QAyrNfVzOgKwL5+XrkpWmPW/lum5YY0dI7A
         9yMplHdXZLu5hWi/mrBT3TMmi+/yfjYHkaDHqm+nk9IGmPiOuP7jEbPRuPP/1MzkgB
         qMTZk6+Tw2Lcw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B652c92d10000>; Mon, 16 Oct 2023 14:33:05 +1300
Received: from richardl-dl.ws.atlnz.lc (richardl-dl.ws.atlnz.lc [10.33.23.23])
        by pat.atlnz.lc (Postfix) with ESMTP id 9808813EDA9;
        Mon, 16 Oct 2023 14:33:05 +1300 (NZDT)
Received: by richardl-dl.ws.atlnz.lc (Postfix, from userid 1481)
        id 959D6520158; Mon, 16 Oct 2023 14:33:05 +1300 (NZDT)
From:   Richard Laing <richard.laing@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Laing <richard.laing@alliedtelesis.co.nz>
Subject: [PATCH] dt-bindings: serial: snps-dw-apb-uart: Add property to drain TX FIFO
Date:   Mon, 16 Oct 2023 14:32:07 +1300
Message-ID: <20231016013207.2249946-3-richard.laing@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016013207.2249946-1-richard.laing@alliedtelesis.co.nz>
References: <20231016013207.2249946-1-richard.laing@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L6ZjvNb8 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=bhdUkHdE2iEA:10 a=yJYUBcXGP3-BVwV7yiEA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An issue has been observed on the Broadcom BCM56160 serial port which
appears closely related to a similar issue on the Marvell Armada 38x
serial port.

Add a new property to force the TX FIFO to be drained before
changing the UART_LCR.

Signed-off-by: Richard Laing <richard.laing@alliedtelesis.co.nz>
---
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.ya=
ml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 17c553123f96..4266ef96832c 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -114,6 +114,12 @@ properties:
       register. Define this if your serial port does not use this pin.
     type: boolean
=20
+  drain-before-lcr-change:
+    description: Force TX buffer flush before LCR change. Make sure all
+    characters in the buffer are sent before reconfiguring. Define this =
if
+    the UART drops its FIFO when reconfiguring.
+    type: boolean
+
 required:
   - compatible
   - reg
--=20
2.42.0

