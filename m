Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48FD7F1FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 22:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjKTVtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 16:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjKTVsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 16:48:51 -0500
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 13:47:52 PST
Received: from mxe-1-ab7.seznam.cz (mxe-1-ab7.seznam.cz [IPv6:2a02:598:128:8a00::1000:ab7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9DED;
        Mon, 20 Nov 2023 13:47:52 -0800 (PST)
Received: from email.seznam.cz
        by smtpc-mxe-b7dc65f8c-crqsd
        (smtpc-mxe-b7dc65f8c-crqsd [2a02:598:128:8a00::1000:ab7])
        id 6abd72749449c0de6a33fc6c;
        Mon, 20 Nov 2023 22:47:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz;
        s=szn20221014; t=1700516871;
        bh=tV7rRu+hZULtUAqYXJOLdln7sRyZoCRG7oXpFuJMw7s=;
        h=Received:From:To:Cc:Subject:Date:Message-Id:References:
         In-Reply-To:Mime-Version:X-Mailer:Content-Type:
         Content-Transfer-Encoding;
        b=u2/Ex8R98G1Iz3VLJ9XczTtmYftQsCfeX3Zur2QyOqaN/Toh88WdGQjYSj5isUdb7
         WZ6FDaUE9l/2jlwQC4lc3LbjUIqqy3t2ptgIhoFCNKCUF75/s2oKEiCa8ILwtuFf/M
         8fButrOQJRynUJGudnWB6cfyJO6Frp813NSUZdmaICaElw+vFnB0HTpuPRdi+K76sy
         QZNn1ZmHh5xBPYB9Y24vem8bQk13AzBxMMd5rRig+urQt1CYk6iChniRgasIIDJxDy
         /+cQof90rmZwCiHsMpK3FDftA47T7bNkCoZsxgrDi85rN2yf3o2x1Z8z/E1ZiJ+MAE
         EWN07MR3JFzFg==
Received: from 184-143.gtt-net.cz (184-143.gtt-net.cz [82.144.143.184])
        by email.seznam.cz (szn-UNKNOWN-unknown) with HTTP;
        Mon, 20 Nov 2023 22:45:23 +0100 (CET)
From:   "Tomas Paukrt" <tomaspaukrt@email.cz>
To:     "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     <linux-serial@vger.kernel.org>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: =?utf-8?q?Re=3A_=5BPATCH_v3_2/2=5D_dt-bindings=3A_serial=3A_Add_o?=
        =?utf-8?q?ption_to_enable_RS485_mode_via_GPIO_?=
Date:   Mon, 20 Nov 2023 22:45:23 +0100 (CET)
Message-Id: <3Nk.ZZrp.5w3Yn0Ecy5C.1bMzDp@seznam.cz>
References: <VY.ZZnz.2Km1cHBSh2}.1bLIJa@seznam.cz>
        <476876ca-806f-a5ad-1eeb-435c8a3111a2@gmx.de>
        <2cZ.ZZqF.1YADr1CLFoQ.1bMn3d@seznam.cz>
        <5a0321ac-e1e6-45e9-9faf-153db8d34980@kernel.org>
In-Reply-To: <5a0321ac-e1e6-45e9-9faf-153db8d34980@kernel.org>
Mime-Version: 1.0 (szn-mime-2.1.33)
X-Mailer: szn-UNKNOWN-unknown
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree property "rs485-mode-gpio".

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documen=
tation/devicetree/bindings/serial/rs485.yaml
index 9418fd6..7a72f37 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -47,6 +47,10 @@ properties:
       later with proper ioctl.
     $ref: /schemas/types.yaml#/definitions/flag
 
+  rs485-mode-gpio:
+    description: GPIO pin to enable RS485 mode at boot time.
+    maxItems: 1
+
   rs485-rx-during-tx:
     description: enables the receiving of data even while sending data.=

     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.7.4
 
