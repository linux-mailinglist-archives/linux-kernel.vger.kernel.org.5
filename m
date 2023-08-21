Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27808782EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbjHUQ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjHUQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:58:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C8CFB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:58:05 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:58:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692637083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+H63hXDfG2RDADCZfYUbL216RJ+SuyOEWncaSt9OE0=;
        b=A0jY3fFFUicvy6wnyBIJ7ymM1w89yTEcgHM7p2obt8IMjRb2XdHUuJwqbqVONcwN8lFppf
        wCXWxWaeP+WnHmyXVyGiUytym0fIVueHej4+g6+1ZdeBGhK7V83ndwKqmMCPfOBoveOBUb
        rDJUqQuXEXcR6rMaBeWkg8tpzNKS2GEZ9laKqbOpAttJoaVDnLH6+qOVYkxLhYrlQadGs3
        2GgRPVnrWf6ZsknWEfZMvTnXpzLDNV4SRn++mY+IvTAESemy6gzsmGW4C+bfK5VbO4KYXy
        P+3yfrP13fWEeTAkbdfknshv/BW6TBu9BjIXrblaeOmF0EfNgyH+o1PWeWXn3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692637083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d+H63hXDfG2RDADCZfYUbL216RJ+SuyOEWncaSt9OE0=;
        b=NW5jSCRcHRZPd2isEIr92iwM0Q64OuVQqVR0Kqsjjwts88OvWdChIAlPQViylYFVgKCLTC
        XBaBb7ublT8SgNDw==
From:   "irqchip-bot for Huqiang Qin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: Add
 support for Amlogic-C3 SoCs
Cc:     Huqiang Qin <huqiang.qin@amlogic.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230628091533.3884385-2-huqiang.qin@amlogic.com>
References: <20230628091533.3884385-2-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Message-ID: <169263708277.27769.11777865404305071407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2b709c6760ecf6d953ce15b2301ae0c24793cbe1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2b709c6760ecf6d953ce15b2301ae0c24793cbe1
Author:        Huqiang Qin <huqiang.qin@amlogic.com>
AuthorDate:    Wed, 28 Jun 2023 17:15:32 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Aug 2023 17:49:12 +01:00

dt-bindings: interrupt-controller: Add support for Amlogic-C3 SoCs

Update dt-binding document for GPIO interrupt controller of Amlogic-C3 SoCs

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230628091533.3884385-2-huqiang.qin@amlogic.com
---
 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
index e84e4f3..3d06db9 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
@@ -35,6 +35,7 @@ properties:
               - amlogic,meson-sm1-gpio-intc
               - amlogic,meson-a1-gpio-intc
               - amlogic,meson-s4-gpio-intc
+              - amlogic,c3-gpio-intc
           - const: amlogic,meson-gpio-intc
 
   reg:
