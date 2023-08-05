Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAFD7710B8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjHERDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHERDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 13:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581ECE4A;
        Sat,  5 Aug 2023 10:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E6E60C59;
        Sat,  5 Aug 2023 17:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EEC4C433D9;
        Sat,  5 Aug 2023 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691254995;
        bh=JqJIqpKc34gZt4m//nBt+Kgl1X7w/QGNlDztlnsggRA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=f3uHl0J1i7RPNNZYnks1/4K2g86NYfcVlDk8A8A1a6at+O65zGpRxug7SD1bEdC6D
         ivjQp8VH5w7Xq9emYGxzO5RbUvCHmdsnk5rdu4rbi6iz/4sAAR9k1rE8/8U1EkEpkD
         HDD7cmxn4VBpgZoONcoNldt1W6Rqpc0yv5oVptCn0L8svRYzVN1+G15Z8OOuCXreUk
         swRGAoCIiXTkPPittwWRcME2TCzF+3p7tNMigedWmACTXDhW7Yk4tLQSxeyIrJUPYT
         rjFqa3uIeUrIEdR8KBzlgMiLx7bj7TMIa2eTRIRpR5zZcwgHo53m8hyIOhqDGVwvh9
         NrCrtS2IbN7lQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 1A14DC04E69;
        Sat,  5 Aug 2023 17:03:15 +0000 (UTC)
From:   Xilin Wu via B4 Relay <devnull+wuxilin123.gmail.com@kernel.org>
Date:   Sun, 06 Aug 2023 01:03:11 +0800
Subject: [PATCH 2/3] dt-bindings: arm: qcom: Add Xiaomi Mi 11 Ultra
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230806-xiaomi-star-v1-2-0c384e8b5737@gmail.com>
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
In-Reply-To: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        Xilin Wu <wuxilin123@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691254992; l=706;
 i=wuxilin123@gmail.com; s=20230805; h=from:subject:message-id;
 bh=QFpbR6ARnfYdwD0jylrDmivrBMUENp37HGfNRpLwt+M=;
 b=5hqHLmqKu5bHc5YAFrMucQeSv18oFrlfAhYWIzNcpGsRFGE4pKXPEIq3CLu///C488gGYQX8N
 o2XmhzVVBMRBROnGsJucAgtITjmmOklK4BKGl/8scJwcWy+DVPmkbiR
X-Developer-Key: i=wuxilin123@gmail.com; a=ed25519;
 pk=OZIrHT2qWm7yEdp5fsVR7GsFx1wxciIii20H06Ud088=
X-Endpoint-Received: by B4 Relay for wuxilin123@gmail.com/20230805 with auth_id=73
X-Original-From: Xilin Wu <wuxilin123@gmail.com>
Reply-To: <wuxilin123@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xilin Wu <wuxilin123@gmail.com>

Add a compatible for Xiaomi Mi 11 Ultra (xiaomi,star).

Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..af69d05ae44a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -960,6 +960,7 @@ properties:
               - qcom,sm8350-mtp
               - sony,pdx214-generic
               - sony,pdx215-generic
+              - xiaomi,star
           - const: qcom,sm8350
 
       - items:

-- 
2.41.0

