Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A220F7D1F84
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 22:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjJUUbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJUUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 16:31:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6881A3;
        Sat, 21 Oct 2023 13:31:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507f1c29f25so422754e87.1;
        Sat, 21 Oct 2023 13:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697920267; x=1698525067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUzFjMXPHIDNeKf77+KU3tuTHRivMKE8bgYMoK+njks=;
        b=hHLOLg2GYh5ELfbOMCCbDjdpmzcin11+paWp+Vi4Mvnpf9y2NhcyKgLRRB1m2UGKJW
         J2zwdCyMij4HwqLvjct0AaiLo6oC5AERWt0yoEIfuZSa3VQOOfEoJr+gPj0N1g9tDdkz
         ePO9/An2qjssUIwHtMNrkYc5abCtjDcFeCmWqUKlFxTbIyxmHRfa+mb6Qa7kwVAGgf5J
         zL4oompUOqIYsrW/1xtTvLjmxIwijoskoNeXDPti98fS3hhpypfxwdFfPZekyNmXIPQR
         lkf+EGedejUP1Ef6Nt551UEHk+J4lhcpZpsJzwuBQ8NfAY5HLZ167KNbv9eBy+L7ywnq
         s/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697920267; x=1698525067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUzFjMXPHIDNeKf77+KU3tuTHRivMKE8bgYMoK+njks=;
        b=P8fAxjzOzCBfuGLBcXmx81iV34+N3okKnjxERI5SFGdU39zfJhU/rq6ITCU264gz4f
         kSCcIEGrOb3t7KsJ6eDcGYcAokBMQhnEjRT9LxRP76ANWidNUbwGxXEXzKCtbr5ea5xk
         tVr450KpZaHTU1bl5aL4qhBOrJKz9WHk0n1JnszdXc9aOa+wS2cOZSk26gdegl2b54P0
         x6ovaOpHfawC0LLOLGK2ulSyjuy4Vbuk9Yd/PyFLRjIWDaXuW+Zy+jkenFVYlK9F44M7
         xUmU25BcJdcVqln5N70ohxDLz3PdZOGWdtUvs9HoLo0DZ2arYDIpntltNK4wkNzn7ECx
         3ymw==
X-Gm-Message-State: AOJu0YykI9ew51BV4+LwHHQ9dcSfY+TsUkFQqRoAKFfVxj6rTCBoPo6r
        87Cyhs8iNg3xY0hCFXQlKlY=
X-Google-Smtp-Source: AGHT+IH3so6o6xUoXx9Ha+ssWfbZ85yrJ41lQf0p5ggLtQvE6xQ7Gm1jbl8DqRQIKOAuqGvolyhF6g==
X-Received: by 2002:a05:6512:2085:b0:503:9c2:e44e with SMTP id t5-20020a056512208500b0050309c2e44emr3578426lfr.55.1697920266823;
        Sat, 21 Oct 2023 13:31:06 -0700 (PDT)
Received: from localhost.localdomain ([145.224.104.33])
        by smtp.gmail.com with ESMTPSA id xa17-20020a170907b9d100b009b913aa7cdasm4087536ejc.92.2023.10.21.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 13:31:06 -0700 (PDT)
From:   Luka Panio <lukapanio@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     luka177 <lukapanio@gmail.com>
Subject: [PATCH v4 1/2] From: Luka Panio <lukapanio@gmail.com>
Date:   Sat, 21 Oct 2023 22:30:49 +0200
Message-ID: <20231021203050.213949-1-lukapanio@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: luka177 <lukapanio@gmail.com>

dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)

Add a compatible for Xiaomi Pad 6.

Signed-off-by: Luka Panio <lukapanio@gmail.com>

---
Update commit message
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..1bfae1b237d2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -965,6 +965,7 @@ properties:
               - sony,pdx203-generic
               - sony,pdx206-generic
               - xiaomi,elish
+              - xiaomi,pipa
           - const: qcom,sm8250
 
       - items:
-- 
2.42.0

