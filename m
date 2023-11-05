Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3037E1688
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjKEUsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEUsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:48:10 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C322DE;
        Sun,  5 Nov 2023 12:48:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0C8C65C00F4;
        Sun,  5 Nov 2023 15:48:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 05 Nov 2023 15:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mai.rs; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1699217286; x=
        1699303686; bh=XLZ6SnVnQDI1qdEKKgYVoKuUcFbr53JF8eoLrCGF150=; b=k
        Xghs0jGBGJH/yyVN2EQNXMy57z9xR2luVlL1OoSpZehZtfDLlcLGZTSJReaWmEVe
        BxKtMs2NeArqoYtxyBtXBcQSOdti8Ps4FcAlxLnq9I75YXCo2B11FNlZm48u0Dvf
        8iSSn1J0nER7qXq8YoVcVQVi8dnBGc3yZCbHVcddtyr9NIPAGThcR+RpR3JigtO0
        ALPgusVQZKm/em3mCnTUmhQXrkCz/pG1HWmQPJ73lFNxU4yOmrKn9XlopziXicw0
        EB4jApSGsqx7lOnMaqxVbK4bGYfbw8nXp0ll1a0aycq5tM0zNQaAnWPyCA33xiBK
        3pxx5/RegQsz5hEETcEgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1699217286; x=
        1699303686; bh=XLZ6SnVnQDI1qdEKKgYVoKuUcFbr53JF8eoLrCGF150=; b=J
        qI5Xo+jBHRfi4/Kbni3N9VsjgPaRF+blOa4DyUIcMq7v4ZJv12mPjk+V4YuKwlGW
        MKhDUDNlrEP2aSnVpAzEsaiOTEOcSnpy+vT/sWLUiWR5co2LoFmZiUj4+/74x1bA
        QZOz8+IZamGfmKHq71dfMRJWJR38tteC8JucqfrxLvNWdgekED7iswqcXGSinGF4
        AivQmaPk2QhjbvCxtFp+j0ugVihx6QiW/G0rWvbO/srST8vt4Y3toJOL11uFK6Il
        vtXU7xyquqoVJ41e51uGL4wi34tBDgp2fEWsgGgP6f0atvQ1iTkfCMtin2D4yhH3
        5wV2PddGI0N20EuymJajw==
X-ME-Sender: <xms:hf9HZXK8xgF3_9E91QGp_ev5CR_J6uVHsA_dONsJMfEyXI1ixjFOQg>
    <xme:hf9HZbLE-ivUGfnmPpWMVFRbXDvnoamucU3BN0KOg1wA3M6Io_-1hq19grE_5IAEo
    Ol2KB5vy3ISbavLqw>
X-ME-Received: <xmr:hf9HZfsD9q2oE6GpbV4qiIecnNwot5RQHJx4Eybqj0HG0uTyr6QYydlReFvpwYY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduvddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepuehrhigrnhhtucforghirhhsuceosghrhigrnhhtsehmrghird
    hrsheqnecuggftrfgrthhtvghrnhepffetieevteehteehhfejudetheegjeegleehgefh
    kefhjeeiueduudeiieelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghrhigrnhhtsehmrghirdhrsh
X-ME-Proxy: <xmx:hf9HZQagmrORhkrKWokn3JIz69qFBKY_42io6Q8hUcRLXk0QOxAzSQ>
    <xmx:hf9HZeZKZ1qSnqxgMyyGYVPze1u5DnLMQ4uPp_-Kn_kc7BKr-GjbpA>
    <xmx:hf9HZUAkNEyxqGvCEph1jVCJHEDmj_uDyeEDTPpiyZuZ3GMEEHmK6Q>
    <xmx:hv9HZQDHG20o4Nqpro587Bdd97BMHyMHpI4k2W69pgIoAFIzDS4sqQ>
Feedback-ID: i891b436e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Nov 2023 15:48:04 -0500 (EST)
From:   Bryant Mairs <bryant@mai.rs>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc:     Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 1/7] dt-bindings: input: melfas,mms114: add MMS252 compatible
Date:   Sun,  5 Nov 2023 21:46:16 +0100
Message-ID: <20231105204759.37107-2-bryant@mai.rs>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231105204759.37107-1-bryant@mai.rs>
References: <20231105204759.37107-1-bryant@mai.rs>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Weiss <luca@z3ntu.xyz>

Add a compatible for MMS252 touchscreen which appears to work fine with
the MMS114 driver.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Bryant Mairs <bryant@mai.rs>
---
 .../bindings/input/touchscreen/melfas,mms114.yaml           | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml b/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml
index 07f9dd6b1c9c..90ebd4f8354c 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/melfas,mms114.yaml
@@ -17,13 +17,17 @@ properties:
     pattern: "^touchscreen(@.*)?$"
 
   compatible:
-    items:
+    oneOf:
       - enum:
           - melfas,mms114
           - melfas,mms134s
           - melfas,mms136
           - melfas,mms152
           - melfas,mms345l
+      - items:
+          - enum:
+              - melfas,mms252
+          - const: melfas,mms114
 
   reg:
     description: I2C address
-- 
2.41.0

