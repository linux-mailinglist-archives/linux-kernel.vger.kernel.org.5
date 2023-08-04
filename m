Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8776F7B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjHDCS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjHDCRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:17:47 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3DC469B;
        Thu,  3 Aug 2023 19:17:11 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b9cd6876bbso279453a34.1;
        Thu, 03 Aug 2023 19:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691115430; x=1691720230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvjkznDszZqE7QvOSaNpsSmQHBUNRFIIqmRMflSXq+w=;
        b=Lj6GRrciMXZjIS34LRXYQANWLUpLMFDPY8gWGVhOgxyEGqeYhaZJyb4GYDrWRApqHX
         mRF+RXGsw4RdV2NQMmmVn8zrlD5unKCHQd5yMZJnkn7nHgLr0Zq2HE1fRPZTvEFp3NpY
         9DnpdPb19OiO2aHng9mFMSUMSkK7HSc127PnFIN+YC/M9ippzbyYol5fmMN5/i6VZT9l
         AMUC7ZaLmeydW+LGf2ALF0htK8HB5J3VOZuLcDOm0t+Z5AuUi0cxbVMjvZm7/ur0Qamm
         Jhr9r1WuVDr62PhOY+cBA468Mo/Uc2OLWfvy33ZJB2k87MD/Fkpld7qQuvh6lWtkSEzm
         Bqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115430; x=1691720230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvjkznDszZqE7QvOSaNpsSmQHBUNRFIIqmRMflSXq+w=;
        b=PngVitdjhDN/oBgyJKwoB7z18qsG/cImsAXT/djTIdAl/Xsm/3KxJZx+aVD+XbbmsS
         1u4CtK/9cBQCR3rZqYt6kBkAmLEo6FcWOc6hb6K6OsHGBR4/itsakUZ8zOWpVUDO7ipP
         VFT7bhvRFEGNaOodMeA9DJBC4P+cCPBLh+tR5B2dqaGdr5qL3WoQsZQJ4Px0Q8tTCK7v
         Fz2FXpcfuyCXHM37pG3SAHVb69JOKiVww4mFOvkefWyXgJCho7Kys0mXnD/3OYYYaM+o
         tDDht6fkElBi/VdFjiXzXEHgpNCU9S078s9lPsmALFCgyIKkEoWiCLXg8kSWq4bk3drB
         fLqQ==
X-Gm-Message-State: ABy/qLYDtFQGO5Yz6YCSW0U/m6E3jOkhcguUi6QUlR6Qrcgax1ECn8tE
        m3pif1XK0lwY1YtDB2dmRAM=
X-Google-Smtp-Source: APBJJlGo+nbZpZ8ZxYp2K9Jj6APIoDZobDbAhe6Ey8699p0ZZmNMLXjivF8gb2mjGNr3nBSVqomLvg==
X-Received: by 2002:a9d:704c:0:b0:6bc:a5ef:bd3 with SMTP id x12-20020a9d704c000000b006bca5ef0bd3mr11813988otj.2.1691115430007;
        Thu, 03 Aug 2023 19:17:10 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:48ea:73bf:1876:eaf3])
        by smtp.gmail.com with ESMTPSA id j24-20020a9d7398000000b006b9cc007e87sm656171otk.20.2023.08.03.19.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:17:09 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     lee@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH] dt-bindings: mfd: bd71847-pmic: Remove unneeded LED header
Date:   Thu,  3 Aug 2023 23:16:57 -0300
Message-Id: <20230804021657.190700-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

There is nothing from <dt-bindings/leds/common.h> that is needed by
the binding example.

Remove the unneeded inclusion.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
index 7ab7b2c7f3e6..d783cc4e4e86 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
@@ -130,7 +130,6 @@ dependencies:
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    #include <dt-bindings/leds/common.h>
 
     i2c {
         #address-cells = <1>;
-- 
2.34.1

