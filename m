Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F88793DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbjIFNeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjIFNeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:34:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E259410C7;
        Wed,  6 Sep 2023 06:34:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a603159f33so546082366b.0;
        Wed, 06 Sep 2023 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694007249; x=1694612049; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56hbImvN0tWOPSK8b3kJtpcVh9JT8NuzwIdGFkRK0HI=;
        b=BUTeQedr4U4McLnBF4Dsxqy2tTCyievJJYil5ruLLzzB4SbV3SWISfwtuDKfjy/PhM
         htyUpcXojZnWF0KaG8g/5vIwkbF+dbZCMTEFOnNEeHrCzKdb1F+Nt6+nnzTi5org8kVX
         Fq0sQOpwhk7NjQYrzB/pPdsQ3DOKGgFCIwntJzeAicp52MzskJL/DDwEHkiDmoXbaHpP
         ibT8FksTS64lFzCfU0Gkkjab31CCi40rTeQVeg8ETc2Z5ZQElAUoYCvKCobuv1Y/KPLU
         OA8iNZZ9D0MVEASnkfy/USqo1K7QpHKF9HWVC0d3LPbvONLZj5RLMbM9MPTdQJIGzNMx
         Psjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007249; x=1694612049;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56hbImvN0tWOPSK8b3kJtpcVh9JT8NuzwIdGFkRK0HI=;
        b=JM8RasQg/r94FX4h13IGy+lFhZeM66PEznzxvt1PzDusL0FYFCvEnAAT9eqFDRf1Th
         bRgMeWRpFq201CG1XWOZT7rYKIsycx0qka+ZrFy4SU0aqVm0gmCQDEQ4KWuzDNQZVWht
         kukgNuqRA+JiFHg23lydMhAndVTCTOVww/WkzAC5yUVAM00aYmb590DI/miJYd6/h5yn
         qyoJp+R40U7CczheY8wAn2rWLjwj+GrN+2BelE6tvRg/TE0BVeFtXGvzff/dZR8QribL
         EkM+B6t4QA4PDdCSY0C/UpPosvJL20hLm7niJ0XY2SlOQUYixbAyL9Q3fQK5XN6jAc7h
         skBA==
X-Gm-Message-State: AOJu0Yw5VhCQQQ9bYbwCtaxh6Nrb7buuzsIOMNXdgEBt40VWl7VvaiiP
        D4nxkbxnAnSBuzzI0omRDTUDcu7FNeklpg==
X-Google-Smtp-Source: AGHT+IGRbdi+OS6gHmZOYYdL+e6GJ8R6zG1FdukV+sdXVlrcraJiLXPmm+uR36H2+2m3Qd4MM87X7w==
X-Received: by 2002:a17:906:749b:b0:99b:4aa3:6480 with SMTP id e27-20020a170906749b00b0099b4aa36480mr2366063ejl.40.1694007248797;
        Wed, 06 Sep 2023 06:34:08 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41b4-ce80-9ba7-86a5-b5ba-d267.cable.dynamic.v6.surfer.at. [2a02:8389:41b4:ce80:9ba7:86a5:b5ba:d267])
        by smtp.gmail.com with ESMTPSA id c25-20020a170906529900b0099b42c90830sm9016659ejm.36.2023.09.06.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:34:08 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 06 Sep 2023 15:34:06 +0200
Subject: [PATCH v3] dt-bindings: rtc: mcp795: move to trivial-rtc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-topic-rtc_mcp795_yaml-v3-1-5262f1b39920@gmail.com>
X-B4-Tracking: v=1; b=H4sIAM1/+GQC/42N0Q6CIBhGX6VxHQ0wI7rqPVpz8POrbCgOzOWc7
 x561V1dnm/7zllIwugwkdthIREnl1zoMxTHA4FW9w1SZzMTwUTBFLvQMQwOaByh6mCQqqxm3Xn
 KOSuvqJS12pL8NTohNVH30OZ3//I+j0PE2r332OOZuXVpDHHe2xPf1l+ZiVNOLcoSCilNadi96
 bTzJwgd2YyT+MsisqVWBuszA6WM+ras6/oBR7f4TBUBAAA=
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Bartczak <emilbart@gmail.com>,
        Josef Gajdusek <atx@atx.name>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694007247; l=2540;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=0ufigzgdB3nUOdg3kxKfESsezXLuBs62lXx3kdgp5GI=;
 b=sIRbz4FCYwbPOBS2KZF6YkJwkJYmOuMty7JRCNG4PztIO6OHmFaY5K/7+MnnB8z0gxZomHwTb
 rqcT525QTGuB4nAO6cHOeJtalPJlbNEzR2zfFlx/X/Rb8rZ+Db+Ps7k
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current mcp795 bindings in text format do not support validation and
are missing the optional interrupt property that is currently supported.

Adding the missing property makes the bindings identical to the existing
trivial-rtc bindings.

Add maxim,mcp795 to the trivial-rtc bindings and delete current .txt
bindings

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
The current mcp795 bindings in text format do not support validation and
are missing the optional interrupt property that is currently supported.

Adding the missing property makes the bindings identical to the existing
trivial-rtc bindings.

Add maxim,mcp795 to the trivial-rtc bindings and delete current .txt
bindings
---
Changes in v3:
- Order the compatible property alphabetically
- Link to v2: https://lore.kernel.org/r/20230906-topic-rtc_mcp795_yaml-v2-1-f9bef40c99b9@gmail.com

Changes in v2:
- Move mcp795 to trivial-rtc
- Link to v1: https://lore.kernel.org/r/20230906-topic-rtc_mcp795_yaml-v1-1-de75c377b5b0@gmail.com
---
 Documentation/devicetree/bindings/rtc/maxim,mcp795.txt | 11 -----------
 Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt b/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
deleted file mode 100644
index a59fdd8c236d..000000000000
--- a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-* Maxim MCP795		SPI Serial Real-Time Clock
-
-Required properties:
-- compatible: Should contain "maxim,mcp795".
-- reg: SPI address for chip
-
-Example:
-	mcp795: rtc@0 {
-		compatible = "maxim,mcp795";
-		reg = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
index 9af77f21bb7f..0928495fa726 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -47,6 +47,8 @@ properties:
       - isil,isl1218
       # Intersil ISL12022 Real-time Clock
       - isil,isl12022
+      # SPI-BUS INTERFACE REAL TIME CLOCK MODULE
+      - maxim,mcp795
       # Real Time Clock Module with I2C-Bus
       - microcrystal,rv3029
       # Real Time Clock

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230906-topic-rtc_mcp795_yaml-11058e99ddad

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

