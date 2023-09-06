Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FEF793CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbjIFMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238324AbjIFMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:48:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3450E1733;
        Wed,  6 Sep 2023 05:48:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52bcb8b199aso5207240a12.3;
        Wed, 06 Sep 2023 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694004498; x=1694609298; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rsE1sJuhI3+vAPSDY8OreHubYHG2pVwPaUCCeIf6A3c=;
        b=Cf14bEvLFIrit+rPL20H1ksAD5qcSkzUPjjRg6t025knet9SkvDCvihXPRO35C9aBu
         hPoL0seiy0YwKILr51I4AzrKnEaSmgr1gaVtoMthvwqPDeVTvGpiwewdgIm6cs6ftFJM
         U21BhgyiNv5ArSyyyIWSk9i9j29EVJycm5vLTAg7+KNNwJTa1iYRMNpEdxk12u/ZM5U6
         35GRrCnlHrFDCjicT4sXGz6VHLgKnLgr5DhfDZd3B+1r38jiS5Lp7DFnb8hyoS5tf+sp
         3wCtjwUbv8i/Qxj7A19L1GklMx7X/+qqpgtqTH4euJiRlL5AAMEadWvIAQqp9mBmfFxB
         zGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694004498; x=1694609298;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rsE1sJuhI3+vAPSDY8OreHubYHG2pVwPaUCCeIf6A3c=;
        b=IqL8h7409RT2dWL5v18SZ4Syi54iNeNVD0KMUumjBwfcQ02m3td8pHQ6o0RXLhLR5w
         CXQXsU2kZoeU1llUxOmrwg/I0oEgSbqNyz9KuGm4tnS+nP2sClYtdIWZoI31uD3CYk6J
         1/ubksLyjsc6KoPR1DR99NsGPOE0XhO81jm5vk1sWbZHh6nxmAYsrozY7FfRAMeDS+GH
         7Ll2N+Dxqmoct52nfPydFOPK117jujh4+rS8KBkFWSgkNYiK95GF2foMskHNKGam8Ogl
         C+0XZkdXymvQHatQBjzjjCxwywQZaDwhxVkxeQU6sOqf596ye7DQnTD1sT0oXfAeADbn
         zMNg==
X-Gm-Message-State: AOJu0Yx+knYeGoRM/jGclV+DLm+QFXoSCK0WYjBW+D5mwvvK2Vw32iPQ
        muQxWKI/eJx0utDwKn6yUqs=
X-Google-Smtp-Source: AGHT+IGUTzqcn12Bjvfufbj0dyXJDiPt8h1wWAslBvMpwzaDQMx7ryWqXpsFVbPl48RjKNUgVQIl3w==
X-Received: by 2002:a17:906:4e:b0:9a5:a0c6:9e8d with SMTP id 14-20020a170906004e00b009a5a0c69e8dmr2273405ejg.5.1694004498166;
        Wed, 06 Sep 2023 05:48:18 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41b4-ce80-9ba7-86a5-b5ba-d267.cable.dynamic.v6.surfer.at. [2a02:8389:41b4:ce80:9ba7:86a5:b5ba:d267])
        by smtp.gmail.com with ESMTPSA id se22-20020a170906ce5600b009a1dbf55665sm8972496ejb.161.2023.09.06.05.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 05:48:17 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 06 Sep 2023 14:48:16 +0200
Subject: [PATCH v2] dt-bindings: rtc: mcp795: move to trivial-rtc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-topic-rtc_mcp795_yaml-v2-1-f9bef40c99b9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAA91+GQC/4WNSwrCMBQAryJZG0laYowr7yGl5PNsH+RTklosp
 Xc39gIuZ2CYjRTICIXcTxvJsGDBFCs05xOxo44DUHSVScOalil2pXOa0NI82z7YSSrRrzp4yjk
 TN1DKOe1IbY0uQE3W0Y61jm/vq5wyvPBzzJ5d5RHLnPJ6vBf+s/82C6ecOpDCtlIaYdhjCBr9x
 aZAun3fv6orsHfPAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694004496; l=2370;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=zChXtySttk/deFixIOur9hQARtSdvouNz1smwQEmocY=;
 b=mcXKZze19ECtyzc8zDaf3IGATW+DWDRMVd79bz1zHSdn9SlujT1Bs4ACgBuYPHvNyHxXwmU1u
 RS56uMwiUr4BbeE5jFqQZUxFYCn711TbxhgsP8Cl/u3Fii8pd0VRHRr
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
index 9af77f21bb7f..ae4792bbde92 100644
--- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
@@ -49,6 +49,8 @@ properties:
       - isil,isl12022
       # Real Time Clock Module with I2C-Bus
       - microcrystal,rv3029
+      # SPI-BUS INTERFACE REAL TIME CLOCK MODULE
+      - maxim,mcp795
       # Real Time Clock
       - microcrystal,rv8523
       # Real-time Clock Module

---
base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
change-id: 20230906-topic-rtc_mcp795_yaml-11058e99ddad

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

