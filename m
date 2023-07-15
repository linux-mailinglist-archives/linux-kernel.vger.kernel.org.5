Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E60B754A45
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjGOQ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGOQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:58:09 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE5270A;
        Sat, 15 Jul 2023 09:58:04 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso26584795e9.0;
        Sat, 15 Jul 2023 09:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689440283; x=1692032283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T37BqkNyYsJjxAzhg2da3lHJoJewjBeyNs3en05W3Uw=;
        b=mF55CKURBAfkJT4XCXBiVFD/We5Ms5UdY0zkx5Y+THucnMJU0lfnRZlh3HwVkKfKGe
         BlJMhfz76fPUt0AvHZ9bEBgyQ36cBzqCm/quFbhJKui5h1ETGkmp9n0AhmPBeH5rmJxb
         sVBC1NPcaek8bFOMemezxt/DM66zaYa6kSHcP+GH9TUIpJETiR5PHMFkLK2iuwwH3XYV
         7g1oV7QzWho8Smt7EWt4KT5Al5DoYOJSByz9PdXDsKRZwDHSGFzqUgvj71qcIYdv0BJ7
         GN1W1Ph73yMy+u9k60Bh6viJ6ln55Zwy/tyRbfSdiFxY5pl4SbcLpnWWkR+E8pfYwK/2
         Woow==
X-Gm-Message-State: ABy/qLY8WcDaG6ik621qE2pIpHYnZExagjPZ7+OtU82BiRHCWzODPseU
        oTqs0/pCafpZHry8BXOmcfg=
X-Google-Smtp-Source: APBJJlHYnsfr8rzt2IDyH6qUzpw27oj6zi8WD9al7cmzppUR0gzHTlS2jlOI9UH4AHpav9rHizDezQ==
X-Received: by 2002:a05:600c:ad4:b0:3fb:b05d:f27c with SMTP id c20-20020a05600c0ad400b003fbb05df27cmr6006420wmr.34.1689440282883;
        Sat, 15 Jul 2023 09:58:02 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:1a3:c11b:3ae6:1732:e587:a81f])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00313e4d02be8sm14240655wrp.55.2023.07.15.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:58:02 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] docs: consolidate peripheral interfaces
Date:   Sat, 15 Jul 2023 19:57:58 +0300
Message-ID: <20230715165759.74901-1-costa.shul@redhat.com>
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
 Documentation/subsystem-apis.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 90a0535a932a..7b086c89e2be 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -48,6 +48,17 @@ Networking interfaces
    isdn/index
    mhi/index
 
+Peripheral interfaces
+----------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   usb/index
+   PCI/index
+   hwmon/index
+   leds/index
+
 Storage interfaces
 ------------------
 
@@ -70,19 +81,15 @@ Storage interfaces
    fpga/index
    i2c/index
    iio/index
-   leds/index
    pcmcia/index
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

