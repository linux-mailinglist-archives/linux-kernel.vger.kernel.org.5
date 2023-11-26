Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878B57F9350
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjKZPRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjKZPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:17:09 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB77107;
        Sun, 26 Nov 2023 07:17:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C07A85C012F;
        Sun, 26 Nov 2023 10:17:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 26 Nov 2023 10:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1701011835; x=
        1701098235; bh=XVtyE04XY4dqCT+UkfC1YCtGKiDywJpGnTG5uxs+pJY=; b=U
        LEoZG3l9iVHGOXiB9+KdBr/EjOFg11nHIoA1WQfnYd18Cru+9dKewmF3ncAnsUIJ
        i/BryN/+90xfvDSrjMGqqHq3P0TdVS5imP5ghTDygG7QtQjqo9vikAjiJDGHwobb
        auu3A4Z2CcHcRoDaQRLgRBaBx43jTbj53Lqz9oM4IkNyYq50kg69bWO8HiC2U+WD
        CzwoXq6GhlL8JGDu1wDjrsJd7jJrDI0cTx3uNLHJTWSmOXnRPOQZxD4ESkavdAXk
        br+1ChxRoI7efRhHEgWUpEx2Sp2+JWbtDP1Dq6KSU8tFYySmWUWIgwE61unoWgrn
        8UiAb6+9qP4xeBeeu6rpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1701011835; x=
        1701098235; bh=XVtyE04XY4dqCT+UkfC1YCtGKiDywJpGnTG5uxs+pJY=; b=Z
        nprjepqAr4U3ParLlXz8GJkUG+nzuNiY/otM03vH6IHOTsGQWDjLyz4GaeoRTaow
        QliTPim6vg2xUH2gNkYI/hzuaroxlmUAcFss93R6QAciB4XacP9sTD0TLxDu5NhW
        y39M330KxhRQ2aGm3HnGvb3aT4SkOwO7p1d2ph4ckQXOYclDV1sSeRiHTXfaZOS/
        6AjpakdieHRGipvuWYZ+KP5xTHE++5Y3ByQqm3WWEf0fUmFTJCiKjw7VKg92nhoM
        8RIKdAY65IcSlf1MErRca9l0uJL5TAvB3+0p9JbepyZCTPy2162WMQeqs/GaXlJ6
        xzw9csVnQCAeeUkwDeDEw==
X-ME-Sender: <xms:e2FjZc-jNl5sFzmAvu-Fx5t6FfphHCbp_mjHtEGqjdp33_o1vbUeNg>
    <xme:e2FjZUvVOQGEJbz5pn6YdurJofUsk-mZksK7vOtOpLxFOhAvYiQQFRIyKnwK5xS1G
    EFECBUmnI2F5HUgE4g>
X-ME-Received: <xmr:e2FjZSCLxR33f4KFII_TrkukROHwhSb2NbvZ9A0-8Zt_syLAGUw-u0lKNBZW4WokGkVI2YOEgC_vjuod-imsobIHeoHLCBfQuDTIMD-lvOlogxvLQ3VGjXrr0lo9iCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehledgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
    ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
    gvrhhnpeejieehheekgedvjefhveekjefguddtfefhteehtdeiffelkeeiuedufeelkeej
    geenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvh
    gvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:e2FjZcdofm7SGGsiHmiM0vpiVy-wwjHc8AgHiE3Kd1OrRYpWljatyw>
    <xmx:e2FjZRMrrQNq9BPX2q85YOKbM-4QfWiqd3Td0rh-DMkovra7ORic5Q>
    <xmx:e2FjZWkF2dWE8XnN1vUayfp9EidS1JFlQEjh8bCJsCNZle526PCwRA>
    <xmx:e2FjZXsJoFIrWDK_TExNlAjq-rAWetVzjpffXaBPeWtWxjaAPgmeYg>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 10:17:13 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
Date:   Sun, 26 Nov 2023 16:16:59 +0100
Message-Id: <20231126151701.16534-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231126151701.16534-1-sven@svenpeter.dev>
References: <20231126151701.16534-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This DART variant is found in the t8103 (M1) SoCs and used for the
USB4/Thunderbolt PCIe ports. Unlike the regular t8103 DART these support
up to 64 SIDs and require a slightly different MMIO layout.

Acked-by: Hector Martin <marcan@marcan.st>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 903edf85d72e..7adb1de455a5 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     enum:
       - apple,t8103-dart
+      - apple,t8103-usb4-dart
       - apple,t8110-dart
       - apple,t6000-dart
 
-- 
2.34.1

