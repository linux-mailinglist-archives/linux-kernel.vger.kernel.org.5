Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0E7DA061
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjJ0S1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJ0S1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:27:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED0D54;
        Fri, 27 Oct 2023 11:23:47 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:23:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698430994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQJBBE1Pvow3UQ3JwDSMYhMMtOju0QFRH05Hw98Ud0A=;
        b=BXSSh3AsoW1uporNPn+8MILiyeF4PieKwbepT4/Babib13137cY+i6LoXsiYbIBdB1fQrw
        /IcbqvAsfxqU2bWUdgBAy831uWInVxhMr5c+UxeRBrZCfDpKTUMSe0inc8CYfL6XIHs23M
        FLiih+Dvm/X8XEZKqJll54DWjNQt/G70Kk9aQd1qq+vFFLqU+EDJIZaPaENLWhIEN/8HDX
        0FWBq+N58Q7jfojjIfSaHfO78TBqgi6AopoY/jp5q9tz2QxCHndQFxZVRxm+nGrR4md310
        i+zL/K3gh76MfeCTGH4E8pccWh6yb1FxyQ/F9JiYoPC9IsfVAeblyK3gARHiew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698430994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQJBBE1Pvow3UQ3JwDSMYhMMtOju0QFRH05Hw98Ud0A=;
        b=xi6TgA3wUFg6alCmpe0AHpIXA4arRLb42vZdTVkJf2oGgMt3P+gEp9S+8uUKSedPZwZEEv
        SNspGMgeJoF4Y/BA==
From:   "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: renesas,rz-mtu3: Document
 RZ/{G2UL,Five} SoCs
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230727081848.100834-4-biju.das.jz@bp.renesas.com>
References: <20230727081848.100834-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <169843099346.3135.1974252932039735352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     078a5babf2bc92eba04b8f9162e5fea7afc2749e
Gitweb:        https://git.kernel.org/tip/078a5babf2bc92eba04b8f9162e5fea7afc2749e
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Thu, 27 Jul 2023 09:18:46 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 11 Oct 2023 09:03:55 +02:00

dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs

Add MTU3a binding documentation for Renesas RZ/{G2UL,Five} SoCs.

MTU3a block is identical to one found on RZ/G2L, so no driver changes are
required. The fallback compatible string "renesas,rz-mtu3" will be used
on RZ/{G2UL,Five}.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230727081848.100834-4-biju.das.jz@bp.renesas.com
---
 Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index 670a2eb..3931054 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -109,6 +109,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-mtu3  # RZ/{G2UL,Five}
           - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
           - renesas,r9a07g054-mtu3  # RZ/V2L
       - const: renesas,rz-mtu3
