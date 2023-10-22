Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B423F7D21AC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 09:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjJVHoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 03:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjJVHoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 03:44:06 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE24EDF;
        Sun, 22 Oct 2023 00:44:04 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57e40f0189aso1240255eaf.1;
        Sun, 22 Oct 2023 00:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697960644; x=1698565444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZsTnRg8TjGx5sy3mpYtctS4QxSmgLmOrtEZDXRWDAo=;
        b=Kmq4U9JMwAHo2htsNFjFdsrGlIzouXlPkvRWFwCNBU4ROd2hM3LEi9pPT02qkPBOFt
         WgX+sY33aseM9HMOZjfn557Kdb0WPCp9Q2pqHDVNiDFLn6lTIorkFZBsqW8TH8bqmViB
         6WSQnwGx0CrMNtpugXoy8DeMpN26n26hoNSd7kpHVckIUj1WJsNrWUPBuEUvdcp1qI/V
         C6bHPs2NAvEm08RZVD4PB5zY46u96z4A1W2bMlTywfrV7p9nSxBnCc6222bB5l+tsLEG
         FH5NSUuPXOaVHO4gLGbzC13CYz0knmtCAt5CPrsYq7P1s3MT6MjAJe6gLfT2IzA7YZMF
         MYNA==
X-Gm-Message-State: AOJu0Yy0wR533gn1gId07b92sJ7V/mQaMfDtJBuG1UKF0mqnOq9GcqJS
        rU1OZCf2VkJcyn8ZwW9AAtlHqcM8hZ8=
X-Google-Smtp-Source: AGHT+IEd3GQ2Mv1/qm2NM9cEVr4z778zSPmjvDCPvEF9ACff5C0HtwLOCL4RFc8b5m1aZtrZrt3b/Q==
X-Received: by 2002:a05:6870:6710:b0:1e9:9179:4c6f with SMTP id gb16-20020a056870671000b001e991794c6fmr8397330oab.49.1697960643911;
        Sun, 22 Oct 2023 00:44:03 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a040:1a3:cb84:80fa:fd2e:974a:5c42])
        by smtp.gmail.com with ESMTPSA id bz18-20020ad44c12000000b0065b29403540sm2001404qvb.127.2023.10.22.00.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 00:44:03 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v2] docs: split embedded interfaces and miscellaneous
Date:   Sun, 22 Oct 2023 10:43:46 +0300
Message-ID: <20231022074346.4170388-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to make page Subsystems APIs more organized as requested

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

---
Changes in v2:
- removed misc from Embedded
- added group Miscellaneous

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/subsystem-apis.rst | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index 930dc23998a0..13b918fdae9b 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -62,18 +62,27 @@ Storage interfaces
    target/index
 
 **Fixme**: much more organizational work is needed here.
+Embedded interfaces
+-------------------
 
 .. toctree::
    :maxdepth: 1
 
-   accounting/index
-   cpu-freq/index
-   fpga/index
-   i2c/index
    iio/index
-   pcmcia/index
    spi/index
+   i2c/index
+   fpga/index
    w1/index
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
    hwmon/index
-- 
2.41.0

