Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48316785295
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjHWIWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjHWIOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:14:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AFF211B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:11:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so9730853a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692778269; x=1693383069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hWIUEdPk1CVzeFNa/lTLBisRtZ9LdCr03S42AI/HH6I=;
        b=jamh73z7UBix+rO6bWvxGUVSkOZJJKD1UJSMn8ibtA0Rv3csHU/EiiYHzEWM3DbehD
         A8imp5eCC/FPuwrG0+lT6rYyQjySYw5kRBS34ZabyJ0Tp0YULxN6hsPXYvG9jkBO9NiW
         6inOy+xUYdutuCWJVS6AxqWKBTzDKTK5U+PjToviW6AEUVpdHunm6spFG522c8Ojs0+h
         HDIkTNR/IROwNe+XgG6VvRipQC9YyfhQ3Rxd7bd+5CYDfthVkTQvHI+JyYuWxZiuCJFf
         STckr3JMIbffr6zCQsSXK4INDZddvVGRaUpWmzwdmkDBwJwhrJTBp6qnVbQnf2mhwtL4
         wr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778269; x=1693383069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWIUEdPk1CVzeFNa/lTLBisRtZ9LdCr03S42AI/HH6I=;
        b=SuCTPF5IKGMXaOf8OFM8gTfes1QRV43wFDS+eydn/mewxXHjeF6L4DDGAybcaNYI2w
         ksfEzxPB+4wgCK3CAwyPJ4vXy/eZhp3GNx3/3adPSfFOukZYNfYja3NfnB0OKERIwo2V
         HfvTqTc/BJ3ta0EDq8vML2FMDBK3arxMyR3ksjxOUuCWBmqIwneq7QowD2BZ01ISowy2
         FP95ffxeMGv8RyFAZPOO3onTYHPa0c2gpUB1qaNl32X1AO8xiC939/y6nr6ExWETbwoP
         KiBzwOQRcNqv7x5xNgqmVHoDJV6rHX9VbTUNz5o3UI7NUmvxcLB/baKSo0+yMRx1dPS/
         6NJw==
X-Gm-Message-State: AOJu0YyA5VPJVgAc8l3duhn6MzC/m8O1uBJQDOor8rnelLCZkiM6RdnE
        W+yYA0Ws8WOLH6B6yyTBc3KCGg==
X-Google-Smtp-Source: AGHT+IEPD1TV4eNUhdP63rhi8ljL5x6yk1Pd63+tV3rbw5htu/bhzg7Z3DlE3MJYIEBz7wcQVcTzYQ==
X-Received: by 2002:aa7:cf09:0:b0:523:37f0:2d12 with SMTP id a9-20020aa7cf09000000b0052337f02d12mr13737560edy.17.1692778269622;
        Wed, 23 Aug 2023 01:11:09 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id f11-20020aa7d84b000000b005257f2c057fsm8925329eds.33.2023.08.23.01.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:11:09 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: advantech,idk-2121wr: reference common panel
Date:   Wed, 23 Aug 2023 10:11:07 +0200
Message-Id: <20230823081107.82967-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference common panel bindings to bring descriptions of common fields
like panel-timing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/panel/advantech,idk-2121wr.yaml           | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml b/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
index 67682fe77f10..2e8dbdb5a3d5 100644
--- a/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
+++ b/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
@@ -19,6 +19,9 @@ description: |
   second port, therefore the ports must be marked accordingly (with either
   dual-lvds-odd-pixels or dual-lvds-even-pixels).
 
+allOf:
+  - $ref: panel-common.yaml#
+
 properties:
   compatible:
     items:
-- 
2.34.1

