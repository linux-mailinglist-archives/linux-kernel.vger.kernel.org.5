Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD7754A43
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGOQ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGOQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:57:50 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D0123;
        Sat, 15 Jul 2023 09:57:49 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3143b88faebso3314960f8f.3;
        Sat, 15 Jul 2023 09:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689440267; x=1692032267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ug0bAU2a7Om6W32fM4EAdrQFwmfB/WZfYPsUmK+80bQ=;
        b=QFfbqSzF52j+i1Dm7yU3kL+JWTKIhk98XiQBavNuIiUHpIKNdiYqaYKyREkwPDQyl7
         hOhIRmTtwrPR3Gck9WOCHSEjrOW3JTeA665E9xSVFFDl4MoOku7IV1hZJnsgnSphsud4
         kDqA1rcEFLyXH7WKRTyFXVCt6atleeppmgo0vCb2e/9eu3/JI0b9Q9lIxEc67Wawc/Ew
         0OfxFuGOj/oyhBDJhpWuRxboaim40+ccZI7L+ACTiErVSckxQ9GOYe4LQDPpDBpWyFgM
         tRAzskNw60Eej7LYV6kMKu6R7fFcRGpAOhydZs4bpEAPHmYJsDv99PjEM6MoMWjHUYgX
         GbXw==
X-Gm-Message-State: ABy/qLYCxyUgc2Mz0GvsRWBjik76wEQ/QIWGMDoaNGd3GXqdzkc+VSpB
        CQdpBQtwi260mTFR93+XLJk=
X-Google-Smtp-Source: APBJJlGMZUMUsHxxSafCCeAMWP25eekW5pCgG1xShpj+zitI3/ItTaH1y8QuUsbRAyMsL2GC6trhKQ==
X-Received: by 2002:adf:e7c1:0:b0:315:8f65:91a6 with SMTP id e1-20020adfe7c1000000b003158f6591a6mr8098191wrn.18.1689440267080;
        Sat, 15 Jul 2023 09:57:47 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d53c5000000b002fb60c7995esm14316454wrw.8.2023.07.15.09.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:57:46 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] docs: consolidate networking interfaces
Date:   Sat, 15 Jul 2023 19:57:36 +0300
Message-ID: <20230715165736.74816-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to make the page more organized as requested

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/subsystem-apis.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 8664b05777c3..90a0535a932a 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -36,6 +36,18 @@ Human interfaces
    gpu/index
    fb/index
 
+Networking interfaces
+---------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   networking/index
+   netlabel/index
+   infiniband/index
+   isdn/index
+   mhi/index
+
 Storage interfaces
 ------------------
 
@@ -58,11 +70,7 @@ Storage interfaces
    fpga/index
    i2c/index
    iio/index
-   isdn/index
-   infiniband/index
    leds/index
-   netlabel/index
-   networking/index
    pcmcia/index
    spi/index
    w1/index
@@ -76,6 +84,5 @@ Storage interfaces
    usb/index
    PCI/index
    misc-devices/index
-   mhi/index
    peci/index
    wmi/index
-- 
2.41.0

