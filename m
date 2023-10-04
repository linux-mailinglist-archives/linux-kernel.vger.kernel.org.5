Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CBA7B84A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbjJDQLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbjJDQK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:10:58 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63239DC;
        Wed,  4 Oct 2023 09:10:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E79DF60009;
        Wed,  4 Oct 2023 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696435854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2M+32849Tx+dqNVRkLeeEYLB/CoHX0gof98iAjJ75Jc=;
        b=oz+oIwM+20+krXSAk6TkymvOyLYexgraxaJceDR6rYOEMnyXRRutCNE/9DFoMsloF22niG
        a+Ww7+oPAFBCZsPXAMh1WCoe10L5pmpy9hV2v33mUU/IcPKg7/biRquqrF7EAaSBGQ6Xe+
        7LLbt0K21xIVAxxbMo5Rjvtm3EXszwVK5lBB1U//wXpIRS0HuuTE9zAuOe4Zh3s0vj5I26
        1xdyIwNwrAS7DqpvDvj8l2lI7zW30jTO2uMWjP28r7KxPANPRmKy6ofSuXbqZM+f4Roe3S
        Q2Vb12uXpPlEzGlS/u/2amjS2L8KPHdouXJOxF9uRohNMGhwSOC7njyWiSxATg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 05/11] dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor Core
Date:   Wed,  4 Oct 2023 18:10:32 +0200
Message-Id: <20231004161038.2818327-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004161038.2818327-1-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPS Warrior I-class I6500 was announced by Imagination
Technologies in 2016 and is used in the Mobileye SoC EyeQ5.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/mips/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mips/cpus.yaml b/Documentation/devicetree/bindings/mips/cpus.yaml
index cf382dea3922..87fd2842ba68 100644
--- a/Documentation/devicetree/bindings/mips/cpus.yaml
+++ b/Documentation/devicetree/bindings/mips/cpus.yaml
@@ -39,6 +39,7 @@ properties:
       - mti,mips24KEc
       - mti,mips14KEc
       - mti,mips14Kc
+      - mti,i6500
 
   reg:
     maxItems: 1
-- 
2.40.1

