Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B389754A47
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGOQ6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjGOQ6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:58:36 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33462690;
        Sat, 15 Jul 2023 09:58:34 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3143b88faebso3315431f8f.3;
        Sat, 15 Jul 2023 09:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689440313; x=1692032313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0ZEhqbuJxiEuRYtK43zCpaGyHkFLckWte8MQnqghVM=;
        b=ALocOd9Tya6/FIK8b2vWmJ9kAex6YTp4TxO2wYANtfuY0xKUaCZ7VKplfASzM3AoCL
         mNvt42gn1bRClpsXDba1O7NBbefoBbJx+7XO/nlANzoPN/tdc0k5jYuavREYnCsyXMIK
         2lvwudNlIQMEPnd5eNjJb8WVeOf3Srja8+nzUFdVGOoAHChkN/032kMPIkFdjfQASMtd
         B2+6+lEY1ey+bM96Ua8U/012l80lA+50zq124zTpjon49lufbQ/fS66kQZwMCYijhOVH
         XxgjpHlPSXR5b0dBfEu+9EcZ2nE/oUFcxdRrs4RvBp+xA+fByjAAEt3x0SQSxwuW3RDW
         4DlA==
X-Gm-Message-State: ABy/qLaLuw7MebYiUs34vQE4+nPYI08zqi03cZXmIhZ8J1529CBIQiz6
        kTVNAZa1Gyq7GzrgSQr0jd1s89wNdPFh0A==
X-Google-Smtp-Source: APBJJlHvdAYwv6eluUMJ4s1zeAOJ89xhMBHhu19EvTAvGoizIt7ZLOVdHslNzQt0QZ9H+5g3S3L6lg==
X-Received: by 2002:a5d:678f:0:b0:316:f3cf:6f12 with SMTP id v15-20020a5d678f000000b00316f3cf6f12mr2135229wru.48.1689440313359;
        Sat, 15 Jul 2023 09:58:33 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id q3-20020a5d5743000000b003143c6e09ccsm14149781wrw.16.2023.07.15.09.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:58:33 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] docs: split to embedded interfaces and miscellaneous
Date:   Sat, 15 Jul 2023 19:58:25 +0300
Message-ID: <20230715165826.75152-1-costa.shul@redhat.com>
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
 Documentation/subsystem-apis.rst | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 7b086c89e2be..11c3d9f25937 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -71,19 +71,28 @@ Storage interfaces
    scsi/index
    target/index
 
-**Fixme**: much more organizational work is needed here.
+Embedded interfaces
+-------------------
 
 .. toctree::
    :maxdepth: 1
 
-   accounting/index
-   cpu-freq/index
    fpga/index
    i2c/index
    iio/index
-   pcmcia/index
    spi/index
    w1/index
+   peci/index
+
+Miscellaneous
+-------------
+
+.. toctree::
+   :maxdepth: 1
+
+   accounting/index
+   cpu-freq/index
+   pcmcia/index
    watchdog/index
    virt/index
    accel/index
@@ -91,5 +100,4 @@ Storage interfaces
    crypto/index
    bpf/index
    misc-devices/index
-   peci/index
    wmi/index
-- 
2.41.0

