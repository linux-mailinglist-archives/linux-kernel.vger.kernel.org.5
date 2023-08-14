Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5477B3DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjHNIU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjHNIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:20:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3007EFA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:20:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe934c4decso5341474e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001203; x=1692606003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tra7RWmhIVxqoFzDFfNLsbeWJO4ZzdD6VE2wxxtsSVI=;
        b=VamzQLk/DHPtC0PLvMob7ogQt60oiH+XoTuTIRMY+OlH1AFeP9AQcL9LsLwehXAgUg
         H0NmD8v5IxyDtVFRtETFeRMHnjzPyie+UdjXEc6qNk41/cLJOR/RNeD8GBOPPlcHFpvn
         23m+rsC0g9grPksdyHVI6Z4xqz4fOfb6bvJMC9d3GKgBVXduDBnWmi8bUywEUf5TzXtg
         c1OouCW1V6+oblkHFiB2WDq6Mc6YHt4F2ApNhih0f++ogi++QNzmk79DpGIHNsV4i7Bh
         VD8SJW9LdITIH0+FSg1f8yaoyVaoBJD3pEHpfkhqzXRD/HJXuDD4vwRwu8B7AxgMc7KU
         8exQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001203; x=1692606003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tra7RWmhIVxqoFzDFfNLsbeWJO4ZzdD6VE2wxxtsSVI=;
        b=LHRexz8XtdPWZwJKVnIdTaFuL5gcGK2awY/vihiBKCIiILKjytkuf3srjlGW3zzlNz
         0noJVq9YXihPRR0lziOdMFWM+c2jng4CvKnfUHEKkQapNJSajz1ix2Me5QNa/C4pRH/E
         k4uL4BTr6FKNNV9mTU5tUd1FuBBKxIUXDyUhNNZfkbLgaI1PkgQVUF5/TUUMhDTc28bs
         AVn9t1nI9txC2XLL6/KSgL4sSDwEv5C3uMM1U0PZS/KKrxJ7ocHlopXHxjsqia64mOWQ
         +s9r7/xr6yHrOU6Cik97ROB9ugLvIf/nih2NhifwQ8LLNHNstei//lVSh/fL79yynbpt
         3qYw==
X-Gm-Message-State: AOJu0YwZz5w8ij+J2tk4pQjHFUsNNG1nIauxQRe3+L8gbI277LYV/Izb
        ZjLOsU2ko7qMxd+ArHwQjJoI/Q==
X-Google-Smtp-Source: AGHT+IEUDGNhapDnqEKRyu0BOUAZIuLA6tdPHUswoo3LM6LPRWGE+71nlPzp3dC2kcbhqiTEYrSCYg==
X-Received: by 2002:a05:6512:e9b:b0:4fb:73ba:5d9c with SMTP id bi27-20020a0565120e9b00b004fb73ba5d9cmr6400283lfb.17.1692001203423;
        Mon, 14 Aug 2023 01:20:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b003143ba62cf4sm13661259wrw.86.2023.08.14.01.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 01:20:02 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 14 Aug 2023 10:19:53 +0200
Subject: [PATCH v3 2/3] dt-bindings: interrupt-controller:
 arm,versatile-fpga-irq: mark oxnas compatible as deprecated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-topic-oxnas-upstream-remove-v3-2-e2ba579a49d3@linaro.org>
References: <20230814-topic-oxnas-upstream-remove-v3-0-e2ba579a49d3@linaro.org>
In-Reply-To: <20230814-topic-oxnas-upstream-remove-v3-0-e2ba579a49d3@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=iIFIXjnWTeOoN7hFY1KWDR9lWXrCUvjNLnCbxWgiFxo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk2eOvefaw2oBFYXbACVEBz/RByKuSOHLpugXRIN4n
 vXKgjbKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZNnjrwAKCRB33NvayMhJ0TQgEA
 CCLQa1goqS4f0B8Py0syMxsNTzksBJ0cjds9VA++bNLPUbrZWITdoNkh/8y1gJR+EqMhc3Le7ji2z9
 uGNPkCPUm8+FEfoegW2xleSPTRRKEUG04YT5l0fulAxyQnfhJRYT1UI6A40u80pWciWRsCTBsaQ4VI
 65dbjBR0yxyjhtQKtqFgR3Cr2HIDwjWHxJULwbsZdqgqXhZ4oI1oMh3LrSysrUOyUfKICgFqkcn5Wh
 Jac4v68p90beCLumYODRElquaF0ZKNXXGGkTdBeUmcM01ip7vcoy+xRz/t+deoN9XfekzuUvdJg4XT
 V+XD3UYABCxegu8QWdykEda2bIRgDLNb/jn9nPqZFXhZ9SrOzg2AraCXc9f7MEmj/XRHuyddmIaGcS
 c4I83R6boC7vXvZ7Gjv1wmxpMRJ9M4F1u6Ra0rZaYB6FLOypUN4M7eAm0LBO84JFudlMGD+/4EKSO+
 8Gkszdq0rqSka37E643/crkB2j7HYOXo+NkUEUmuHwcFsB2lZVEqWNFLz8r79g32AuJJQq3RgMm78Q
 l6I0EBxOKbBl/A+GTIg4EKjr7gYDzRp2VzgGf1lSgFIeusggAHT4kgrNDp7XSon92bSz7MVPqOoVUo
 HNXhBNPruvRrP9z28doFennccTpxt1nwdjDL3eO/v5U9cXis4AYax2n3jJHg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, mark the
OX810 and OX820 IRQ compatible as deprecated.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/interrupt-controller/arm,versatile-fpga-irq.txt          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
index 2a1d16bdf834..ea939f54c5eb 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
@@ -6,7 +6,7 @@ controllers are OR:ed together and fed to the CPU tile's IRQ input. Each
 instance can handle up to 32 interrupts.
 
 Required properties:
-- compatible: "arm,versatile-fpga-irq" or "oxsemi,ox810se-rps-irq"
+- compatible: "arm,versatile-fpga-irq"
 - interrupt-controller: Identifies the node as an interrupt controller
 - #interrupt-cells: The number of cells to define the interrupts.  Must be 1
   as the FPGA IRQ controller has no configuration options for interrupt
@@ -19,6 +19,8 @@ Required properties:
   the system till not make it possible for devices to request these
   interrupts.
 
+The "oxsemi,ox810se-rps-irq" compatible is deprecated.
+
 Example:
 
 pic: pic@14000000 {

-- 
2.34.1

