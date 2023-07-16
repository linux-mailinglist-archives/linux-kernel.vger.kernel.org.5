Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2869F754F9F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjGPQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 12:15:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5703186;
        Sun, 16 Jul 2023 09:15:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso2251494b3a.3;
        Sun, 16 Jul 2023 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689524128; x=1692116128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LBL5NqseIBukuSWtHPII+PsIomyDUgBgQDu+tUXCE2s=;
        b=InKsCFZ18PT0DK8VmhsOF9ruukaMaoZnEgHZq/BhpZV7jDRVreGDLu0iuIm2pQftnf
         o+Wr+ZQoimIkMEcUWg8dgfxMjFvQnhpatFJLXwE/yJFwRkVkmSaPHaiiMLdXYELadVkC
         JsoUzreRvLt0eb+UdLw0Xp/62xZXb31zA2L4OzogO5PncRJNQvaU/R5sJ5bYF6KgxEyR
         IBMj0mJJvHDI4L44qeUxE2uXs4TGl9zjHvgffpiHJTxxACU+yH0XCnvnRe6TPy5qTjQj
         CgFNjsp9loD3ypGusLrzP2fNsyplmHjBl6UfeUBw6kgeS9K2ad1QX7tGeTnyxON94GjL
         cFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689524128; x=1692116128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBL5NqseIBukuSWtHPII+PsIomyDUgBgQDu+tUXCE2s=;
        b=IQDywo41TYyw8o8Hgvi7UBkb62vcocDUv4D5zrMuuAU+bCbcUo8DIbqK51IEHztPvF
         DQfbFmk3FlVhWOBz7IElUstz4v/paKNTr+QFuG5gIO3U79Ee1si6HVxXfDloMLi0oXfw
         Dfw51z/iNCi6oslP0gRgfPov9R0tt88k5K00XHvDITyIqpC1pY/+RAXG2ui2PvU0KRlP
         h3XYK/XK8Z7EKm8Uz4zeUqcnliaef/UdU8K63YFrjLyVjcOTkRQ/qQv1JEm5oMO+KMpK
         nzBikhEvZXC9lNACktP1k3e6aOMOYhW9Bb8JyeI39RGMhygmYDhnD8+xTggVS6j/UlC7
         aVXg==
X-Gm-Message-State: ABy/qLYKVx280xeqG+HVWGsRm0iPCGFLrv7/3YyGUy2UopYfrI3UkSlp
        LnuI5vuD/k1RulR+wMvPKDE=
X-Google-Smtp-Source: APBJJlEqOxep6IWK22vhMAuDiadbdVm+M1ZMwwju5DfNRbiTIj/Rs/g23zRkWPK2336alBd+BGUy0A==
X-Received: by 2002:a05:6a20:a10b:b0:132:7fb3:3325 with SMTP id q11-20020a056a20a10b00b001327fb33325mr9830591pzk.59.1689524127841;
        Sun, 16 Jul 2023 09:15:27 -0700 (PDT)
Received: from localhost.localdomain ([113.251.0.121])
        by smtp.gmail.com with ESMTPSA id c24-20020a62e818000000b0067aea93af40sm10393829pfi.2.2023.07.16.09.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 09:15:27 -0700 (PDT)
From:   Hu Haowen <src.res.211@gmail.com>
To:     dan.j.williams@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, hdegoede@redhat.com, corbet@lwn.net
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] docs: ABI: sysfs-bus-nvdimm: correct indentations
Date:   Mon, 17 Jul 2023 00:14:42 +0800
Message-Id: <20230716161443.1375-1-src.res.211@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The identations from line 1 to 4 within sysfs-bus-nvdimm were wrongly
incompatible with the indentations of the following contents. Hence
correct them.

Discovered when I was executing "make htmldocs" and received the
following stderr output:

    /<... root dir ...>/Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.

Signed-off-by: Hu Haowen <src.res.211@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index de8c5a59c77f..8d048f8e3c39 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -1,7 +1,7 @@
-What:          nvdimm
-Date:          July 2020
-KernelVersion: 5.8
-Contact:       Dan Williams <dan.j.williams@intel.com>
+What:           nvdimm
+Date:           July 2020
+KernelVersion:  5.8
+Contact:        Dan Williams <dan.j.williams@intel.com>
 Description:
 
 The libnvdimm sub-system implements a common sysfs interface for
-- 
2.34.1

