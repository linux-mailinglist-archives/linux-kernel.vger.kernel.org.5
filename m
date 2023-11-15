Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9747ED207
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjKOUdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjKOUdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:33:19 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B175BC;
        Wed, 15 Nov 2023 12:33:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d81864e3fso58256f8f.2;
        Wed, 15 Nov 2023 12:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700080394; x=1700685194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WgFBYcGPQDYXf02NhQPzl84IFV9IxtNIfQLd6kXiIbY=;
        b=MmbnGpTZwAZzriduqTlOZxlb/2Sk1is2+eTW0eaqX84fo0aBfSyoLTP/LZqJbrq8vJ
         kECISRBKql+vWy5IvXcpuKufWhktwBGEDUwuXAcWO+KKCtP2UHAMbuOGg+fta51oDCH/
         /mZgcz7Wsr1xt1vZbXXb+q1E6okMufTIDkgE+ZyqOQ7oj+BLu371nrHmU7p+26xHXqQV
         6GIRDdOKx7tqUYVRZddJVqqBTrezF9OPPf0onQzL+3L50Css5DGn8sa2uqlE6EPg43mk
         p6GFE7Qy5jIOxqBaH1HeDsIjx85zep+vdjesoFfp5NBolcrB7Oo+lZ1zFydlpbqfKrhU
         9hjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700080394; x=1700685194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgFBYcGPQDYXf02NhQPzl84IFV9IxtNIfQLd6kXiIbY=;
        b=Bu42WUtLlplX3pYZjpi/MAEzmOQSlpmsztWs/TSLU3wVkzA6Z/JtcitFK5mWtFNd5k
         5MGuxj01YPUMelC3M29iePvFA5N1PKm1893NF7X3ooJkqGre/7jGUSXLnWouAAvsS0Ju
         +Ayt9GK3/ZnSFIk3VKRUsL6bOqFPiXueZpH5HjlNIHzhdpUxiZjjb5HDbFS37vxwuHJj
         SQweFfmeCOPuHidBlIcjlmxm8rL3OQJs4v6UBeXcLGmBfifNiZ6HzXZzYjSW53EOyH2n
         DLQ43dfnX8oL+tsTGMwONv1gBtIpcOO0ik3vNhxqIvyT9uVBdraP3qg5JDs3vj+hf79m
         omoA==
X-Gm-Message-State: AOJu0YwT26PRCMeRHH/KkO1it4XjTsjBR3GnljEnxzTJUpYJPy2FEU4b
        qirJwf+M5OgeYxKornMdfJE=
X-Google-Smtp-Source: AGHT+IG1hfi8DyYysteHnCViB3gjDSvmpwMQXy/6EOBx/h2ueo5MLt7Exxa/60WsDrxxN5BaXCEWYQ==
X-Received: by 2002:a5d:4bc4:0:b0:32d:825d:f153 with SMTP id l4-20020a5d4bc4000000b0032d825df153mr9417652wrt.61.1700080394391;
        Wed, 15 Nov 2023 12:33:14 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e8e:4851:e049:93fd])
        by smtp.gmail.com with ESMTPSA id dk14-20020a0560000b4e00b0032f7fab0712sm11437978wrb.52.2023.11.15.12.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 12:33:13 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: mmc: renesas,sdhi: Document RZ/Five SoC
Date:   Wed, 15 Nov 2023 20:32:54 +0000
Message-Id: <20231115203254.30544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The SDHI block on the RZ/Five SoC is identical to one found on the RZ/G2UL
SoC. "renesas,sdhi-r9a07g043" compatible string will be used on the
RZ/Five SoC so to make this clear and to keep this file consistent, update
the comment to include RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rcar-gen3-sdhi" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
index 7756a8687eaf..27cd985b1006 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
+++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
@@ -56,7 +56,7 @@ properties:
               - renesas,sdhi-r8a77980  # R-Car V3H
               - renesas,sdhi-r8a77990  # R-Car E3
               - renesas,sdhi-r8a77995  # R-Car D3
-              - renesas,sdhi-r9a07g043 # RZ/G2UL
+              - renesas,sdhi-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,sdhi-r9a07g044 # RZ/G2{L,LC}
               - renesas,sdhi-r9a07g054 # RZ/V2L
               - renesas,sdhi-r9a09g011 # RZ/V2M
-- 
2.34.1

