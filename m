Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CF75DBE7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGVLdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjGVLdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:33:18 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F88171A;
        Sat, 22 Jul 2023 04:33:17 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-767ca28fb32so179414785a.1;
        Sat, 22 Jul 2023 04:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690025596; x=1690630396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahgHcjfaC7JFgkdJgmmVPFlcvZC6Fa3lzfqLhB0VQDE=;
        b=a+cSlQuh2W3NSx/TaTj+UpGf8PlVxz69K3V5hCmTlutaZcTQEo3H/Z3Z0S7s8dve89
         KhbkEdiJPywyHi4mDjerQDlIyA5uDNtrGpbztTVaSzZggBMNzUpeP7yU/5wvqBi+oQTA
         CJnpcg2tOt0mx9wNxYUHev3lzl2YwtestOGLHMvGK7lGiBLpqEL3/+m7ANu40RqdZceg
         D8IIWI8OhoFM9Dc6DHwKvdB6yqy1ItjluJSnbj+xhgdVeW2XFNxf/dpEoTlJozotQFl2
         R1o9lFZPU013PC4TBTfOTgNOICGVKmo4n0SpGGMkWuMtMc6uQjHaV50CQypZYPWA4MH1
         Hc1g==
X-Gm-Message-State: ABy/qLb4rLWFMOi8pLQH9wx8Bc4OahJ9VQ3lm1Yl3VpzLIw1j9h5tbf/
        7Xj1zGxEHaOCehYhdylMWFM=
X-Google-Smtp-Source: APBJJlGDzq74X5CWZ9GHH2tnVHa1R29HSzXTuxsFXli7g7QpSkFiPOy//6QBdGehKlWqxidmZ3wX8Q==
X-Received: by 2002:a05:620a:46a6:b0:76a:ca95:a607 with SMTP id bq38-20020a05620a46a600b0076aca95a607mr2905458qkb.9.1690025596212;
        Sat, 22 Jul 2023 04:33:16 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8930:2c90:cb9e:b154:73dc])
        by smtp.gmail.com with ESMTPSA id i27-20020a05620a075b00b00765a7843382sm1756425qki.74.2023.07.22.04.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 04:33:15 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v2 2/3] docs: consolidate peripheral interfaces
Date:   Sat, 22 Jul 2023 14:32:53 +0300
Message-ID: <20230722113253.1545231-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <874jlxc78i.fsf@meer.lwn.net>
References: <874jlxc78i.fsf@meer.lwn.net>
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

to make page Subsystems APIs more organized as requested

Changes:
v2: added pcmcia and subtitle

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---

Alternative consolidation of buses look more challenging.
Here are too many buses, so them should be split again.
Many of buses are specific for only x86 or only embedded computers.
Is SCSI generic bus or storage bus?
---
 Documentation/subsystem-apis.rst | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 90a0535a932a..5ace1c434977 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -48,6 +48,20 @@ Networking interfaces
    isdn/index
    mhi/index
 
+Peripheral interfaces
+----------------------
+
+except specific networking and storage interfaces
+
+.. toctree::
+   :maxdepth: 1
+
+   usb/index
+   PCI/index
+   hwmon/index
+   leds/index
+   pcmcia/index
+
 Storage interfaces
 ------------------
 
@@ -70,19 +84,14 @@ Storage interfaces
    fpga/index
    i2c/index
    iio/index
-   leds/index
-   pcmcia/index
    spi/index
    w1/index
    watchdog/index
    virt/index
-   hwmon/index
    accel/index
    security/index
    crypto/index
    bpf/index
-   usb/index
-   PCI/index
    misc-devices/index
    peci/index
    wmi/index
-- 
2.41.0

