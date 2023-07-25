Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E831B761AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjGYN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjGYN4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:56:11 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E02102;
        Tue, 25 Jul 2023 06:56:00 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7659db6339eso257706485a.1;
        Tue, 25 Jul 2023 06:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690293360; x=1690898160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88QG+EwF/eDKfWMz+zR4yw2Isf3lGky7V/U2bBHNF5o=;
        b=XP964ku1yxqdbpoD7JJLDdTOgIzA9ME5AKAS7k+xxrldqTy3BBZFbTbvTUmT2q5knn
         nUpQYOV3HGAhn+7/ND3iosIre+fAd445F1uG9QSoaPKR7AFPf0jRtWr9bn9CMn+1FUYm
         HKK6iQ6O9K7YEkeWHLk8xtyalYpoeeEhns3e445HH2dNdgck8ox0Zd34ZBD4v5J2e0Yq
         xgLL3+9pQyi+PF7QThbuSwynvN3cSb1S082SxzReXhvKUIPJMzb+GhsEZMvHzlxBel6+
         x7vKwnR2YDa2VL1K8HyGm0zaBacQxn9Szhq0ZidBtwJQmz/lW66Be8er39Qb2enZ77vJ
         H3/w==
X-Gm-Message-State: ABy/qLaqA4pud5Tkm8Kc7y4/JRPun3snPtKbHi8F/7fBN9CIcRGsGeIC
        TRH1oECW9Mv/Q8ZCASiyA8/IsuzPFLHIacYi
X-Google-Smtp-Source: APBJJlHjJYvouLEUKwC5K67LVNqpOUfHAQyg2Hzatnvf+//We1oa/BaWucDLiwV1hIfi940pFSbRhQ==
X-Received: by 2002:a05:620a:28cb:b0:767:dc46:eb6c with SMTP id l11-20020a05620a28cb00b00767dc46eb6cmr2954089qkp.0.1690293359653;
        Tue, 25 Jul 2023 06:55:59 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8930:2c90:cb9e:b154:73dc])
        by smtp.gmail.com with ESMTPSA id i16-20020a0cf390000000b0063646f1147asm4340406qvk.135.2023.07.25.06.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:55:59 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] docs: consolidate embedded interfaces
Date:   Tue, 25 Jul 2023 16:55:36 +0300
Message-ID: <20230725135537.2534212-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to make page Subsystems APIs more organized as requested

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/subsystem-apis.rst | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 90a0535a932a..7453586114d4 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -60,20 +60,28 @@ Storage interfaces
    scsi/index
    target/index
 
-**Fixme**: much more organizational work is needed here.
+Embedded interfaces
+-------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   iio/index
+   spi/index
+   i2c/index
+   fpga/index
+   w1/index
+   misc-devices/index
+
+**Fixme**: some organizational work is still needed here.
 
 .. toctree::
    :maxdepth: 1
 
    accounting/index
    cpu-freq/index
-   fpga/index
-   i2c/index
-   iio/index
    leds/index
    pcmcia/index
-   spi/index
-   w1/index
    watchdog/index
    virt/index
    hwmon/index
@@ -83,6 +91,5 @@ Storage interfaces
    bpf/index
    usb/index
    PCI/index
-   misc-devices/index
    peci/index
    wmi/index
-- 
2.41.0

