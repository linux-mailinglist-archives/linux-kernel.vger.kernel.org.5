Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62167BC753
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343963AbjJGMBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343904AbjJGMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3749ABF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:48 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWrEsom1MiYuJZIpdvVJQ8pmhLSEsLhsLn9KPnUYdss=;
        b=LrzZq/0jExaJjx2i5CVf/szNyaBcaTaG3bB7NsiLa8/pFTlwrRAZGCJo94v1kfAhc9aUo6
        rJu0AlXuuEU+fiKYATsnapjJ6z47YcWFL16vTXgj7X8Z86DucjC/MNY7Iqrtq2EUQtVl0T
        ts7+velYVj2ESfTOTX9ltMONI8ycrMfs362Vvlf1IJpbFKTeJSm3TfClYuKt0ij3XrGPz1
        76rJArjYpP97bEsDMIv5U2hmEP9unxLPCJIsBxNc1RKnNBajtJ9frFno2sdh9oTMCkI876
        NvJoBTS4MKsp8zCc6xyKBltGJFWYnhZo7EukcvOk88Ng14kCzWly+WvZ+sPITg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EWrEsom1MiYuJZIpdvVJQ8pmhLSEsLhsLn9KPnUYdss=;
        b=ED0AbR12nAtpJcxV/CmDjOjyA92U4rzAwsKnZZH8DLWkg4e27SxF9Gn5IkU6KzNov8P28u
        fmXE5mF2criHChCA==
From:   "irqchip-bot for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] dt-bindings: interrupt-controller:
 arm,gic-v3: Add dma-noncoherent property
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20231006125929.48591-2-lpieralisi@kernel.org>
References: <20231006125929.48591-2-lpieralisi@kernel.org>
MIME-Version: 1.0
Message-ID: <169668004607.3135.14309219411980096360.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     5e5c636c69bdba04033161bbb111fbb6f1f6661e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5e5c636c69bdba04033161bbb111fbb6f1f6661e
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Fri, 06 Oct 2023 14:59:25 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:47:12 +01:00

dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent property

The GIC v3 specifications allow redistributors and ITSes interconnect
ports used to access memory to be wired up in a way that makes the
respective initiators/memory observers non-coherent.

Add the standard dma-noncoherent property to the GICv3 bindings to
allow firmware to describe the redistributors/ITSes components and
interconnect ports behaviour in system designs where the redistributors
and ITSes are not coherent with the CPU.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20231006125929.48591-2-lpieralisi@kernel.org
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
index 2bc3847..0f4a062 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -106,6 +106,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 4096
 
+  dma-noncoherent:
+    description:
+      Present if the GIC redistributors permit programming shareability
+      and cacheability attributes but are connected to a non-coherent
+      downstream interconnect.
+
   msi-controller:
     description:
       Only present if the Message Based Interrupt functionality is
@@ -193,6 +199,12 @@ patternProperties:
       compatible:
         const: arm,gic-v3-its
 
+      dma-noncoherent:
+        description:
+          Present if the GIC ITS permits programming shareability and
+          cacheability attributes but is connected to a non-coherent
+          downstream interconnect.
+
       msi-controller: true
 
       "#msi-cells":
