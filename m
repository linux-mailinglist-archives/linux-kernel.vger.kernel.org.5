Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E217940DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242740AbjIFP5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjIFP5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:57:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746CD1733;
        Wed,  6 Sep 2023 08:57:32 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so399495e9.0;
        Wed, 06 Sep 2023 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694015851; x=1694620651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JsuWZMPlt8G6xLjmq4678LbFZ1wL4cyfQgEaRvh6t9o=;
        b=L5mUmlh+vzi31h4MfQPeN8GROPzUBwCa2+IZ5BrINdN7Y6Osh5+89jZ4B7nhuIDYEh
         TCekOZgy9Hru9UHR1176670Y+NERti7zk/q5riZbZj9V57nz49ZeRFMO6/VlTy74oBrh
         hiz6ayS2/jt5jqIdsC52ZNA7XZch4hJr5re7Rc3W/5vFECaXZuIIils/Vw9oLY1u5WDa
         edJng3ly0AWl9oSpUqyFOWHjKYNajMz91450gitG0Th1yzQ89htnEHEZltkhIPpllhMW
         3ixxH9VRZeLHI7LlfrI97M3djgOJv6Dcw3hupLUw7NPyucx6i+LVcCjgdroSnrqrkDZk
         mH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694015851; x=1694620651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JsuWZMPlt8G6xLjmq4678LbFZ1wL4cyfQgEaRvh6t9o=;
        b=AVLRfqTUH4bD1XsiDGMXWI5B2CtFbQ20JHXDptqS3q4uq4wcMogqjCvFc9MIj3oVGG
         b1s0fj/CDexXpQIKAgfGiDgTb5RI+MGWuLrgBHMyL2xxkIDqWGKoN7CfRUDsncH8hcdp
         HhwXE5tl+wYyW1b3Ty0AdZBQUvWI6BeGBLanRIGOBkeHVyAU6BqwOvZnr9TSDamFm1TB
         nmykQhJCZIZsKEAMhJ7s2Zh85U5vAaC+AW3V4lXBDbKj5wO4rMElk2u43heZk6nc2ckM
         Fum+RWuitlXmScJDRtpa+L6msLjKGRnxn3GXIhsEK8PaWrTQuHZ+5itKyg7QL5iSrHYY
         p9cQ==
X-Gm-Message-State: AOJu0YzAgSukONuKvGtlmTw8afHjwxT9N7nWjdxB21xSGwG1YX1dTCQi
        DPL6MozGj3wSBi23sASGQCZjbYmnGhtMhw==
X-Google-Smtp-Source: AGHT+IHrV7XSzdM89Pe/XFMHAhF8fRYERlymKSVl4VrKFK33vuz/lkjcnSzKqXPsTB7v0pCXOClm7Q==
X-Received: by 2002:a1c:7408:0:b0:401:b0f2:88cb with SMTP id p8-20020a1c7408000000b00401b0f288cbmr2690990wmc.31.1694015850537;
        Wed, 06 Sep 2023 08:57:30 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id 10-20020a05600c234a00b003fc06169ab3sm23243034wmq.20.2023.09.06.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:57:30 -0700 (PDT)
From:   "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alessandro Carminati <alessandro.carminati@gmail.com>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] verification/dot2k: Delete duplicate imports
Date:   Wed,  6 Sep 2023 15:57:03 +0000
Message-Id: <20230906155703.3917918-1-alessandro.carminati@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The presence of duplicate import lines appears to be a typo.
Removing them.

Fixes: 24bce201d798 ("tools/rv: Add dot2k")
Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
---
 tools/verification/dot2/dot2k | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 9dcd38abe20a..d4d7e52d549e 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -15,8 +15,6 @@ if __name__ == '__main__':
     import os
     import platform
     import sys
-    import sys
-    import argparse
 
     parser = argparse.ArgumentParser(description='transform .dot file into kernel rv monitor')
     parser.add_argument('-d', "--dot", dest="dot_file", required=True)
-- 
2.34.1

