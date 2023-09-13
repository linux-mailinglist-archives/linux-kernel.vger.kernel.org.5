Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6E79E294
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239098AbjIMIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjIMIu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:50:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE9F196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:50:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so111843761fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694595021; x=1695199821; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0LhAnrh1Oujp6OYYPLbV5mE5o88DEDP4krLIDveaLy4=;
        b=WPlbyIuVwKuCvSHFpDQWND42Bnbg+cYo6zJplRPs9esVOfwYh4U8zuCAqjDLOMyKxQ
         erDlolcnT1KtGVjK8aip1QtAsFjPIaN5jOHfa+uqspyBhO/xt4mqV7TZlW8C7D+oU4RC
         ZCuohowUt3EAkGUMOIOfSNa/F8cHB3NN5inuvD88bggrj6x7CqzyXcS+8ruXECQoVNzp
         WiFUVAHzHL+jEOAbIYJ4Vx5RuCyGy+FLUuHVOYRHDlo0sNKM/RrMyt8aMUjDtapnrXXV
         edU/50MckyQHnIz3I2nza1KL/76l42eurPiwXWQzN1M/40EpcSsNHEQnt28FiyYIeQaT
         U3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595021; x=1695199821;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LhAnrh1Oujp6OYYPLbV5mE5o88DEDP4krLIDveaLy4=;
        b=tQiwRONgcZwlxUEdeF2D+z52bOOVMNCc9mtH//hTGlFy6kxFIbUlvVw1JliUs6Yhv2
         8WtDTRpjqCWfm1jOmJON2xDzD2PuEQID+h0KUa4PyyVPFw1t8TQsRUztY5XkzRJCaUTI
         XaY9+LRZKp3T2j1Y6mj0RT/CtONLOo7h1PUGncvtDYsXi4rw+aXon/Pf+gDbQEmqHY7A
         cGCAKfG6nV47eyA+hNvr1DD3Nl5Wr+Hoh6BgB2ZoZIZ9q3Oq3Jwv65ZmNTN0MObb91mH
         9z3nUOH1HONlYF04G3YaZqVg3yAbsUYU2T7hG4wO0aXuNnWeHpwQoaurwN1QtyBR7KtG
         QYQA==
X-Gm-Message-State: AOJu0Yxb6EEAX86RkxBcOw+UTcfqHVMuJYS2sPD0c3QPQEICv2Y1vBit
        gbaYMBQnZotNSyV8CxTFUrm6uw==
X-Google-Smtp-Source: AGHT+IHeC+Xy2rsh+UeTSfI7iki71Qj3cUtb2acZVYeFNAEIrdPI/KOAsMrelcLxZvZ3NrHB0atgtg==
X-Received: by 2002:a05:6512:1151:b0:500:ac71:f26a with SMTP id m17-20020a056512115100b00500ac71f26amr1952253lfg.57.1694595021103;
        Wed, 13 Sep 2023 01:50:21 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v5-20020ac25605000000b004ff91dde4b4sm2064622lfd.93.2023.09.13.01.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:50:20 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 10:50:19 +0200
Subject: [PATCH] pinctrl: nuvoton: Fix up Kconfig deps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-novoton-kconfig-v1-1-1c2dff14c0d2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMp3AWUC/x3MSwqAMAwA0atI1haiUn9XERdSYw1CIq2IIL27x
 eVbzLwQKTBFGIsXAt0cWSWjKgtw+yKeDK/ZUGPd4FA1RvTWS8UcTmVjb/rBuhY7ay0i5OoMtPH
 zH6c5pQ/tkdi7YQAAAA==
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have build errors due to missing dependency on OF.
Add the dependency and do it the same way for all three
Nuvotons while we are at it.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nuvoton/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/Kconfig b/drivers/pinctrl/nuvoton/Kconfig
index 612e7ba02238..2abbfcec1fae 100644
--- a/drivers/pinctrl/nuvoton/Kconfig
+++ b/drivers/pinctrl/nuvoton/Kconfig
@@ -2,8 +2,7 @@
 
 config PINCTRL_WPCM450
 	tristate "Pinctrl and GPIO driver for Nuvoton WPCM450"
-	depends on ARCH_WPCM450 || COMPILE_TEST
-	depends on OF
+	depends on (ARCH_WPCM450 || COMPILE_TEST) && OF
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
@@ -35,7 +34,7 @@ config PINCTRL_NPCM7XX
 
 config PINCTRL_NPCM8XX
 	tristate "Pinctrl and GPIO driver for Nuvoton NPCM8XX"
-	depends on ARCH_NPCM || COMPILE_TEST
+	depends on (ARCH_NPCM || COMPILE_TEST) && OF
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF

---
base-commit: c9336ebe87e77f92ed04a86c0131a0310d0e200d
change-id: 20230913-novoton-kconfig-895c60755500

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

