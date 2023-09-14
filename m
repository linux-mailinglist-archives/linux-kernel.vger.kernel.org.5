Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3367A0657
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbjINNqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbjINNpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:45:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F922707
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:37:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-404314388ceso7971715e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694698653; x=1695303453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtEDLGrLEJ6Yf0BlzG31NFuV4f9+Z2ng7sP9jomSPgM=;
        b=pIWuhaNBIDi7szqefVU+F+ne+2YflreFExbq95b6zRS+uaqcP4l34xMBi/0klcbhCB
         drE1R1fPaeDqJ4zEZee3kcb1AgWtzKOW8jQwvF1+ygUmSldOVPf+N637rurUd5srFVkl
         dX5DY9RN9cjdPC5UxVTjgaM4wml9o6eRuLvptAoI82UZf6uWOWgFR9dVsQaZtVvsBBtg
         fSbF1IjHsHwOI1NY1NJYBFunLf8fCcFvERtkgOeMgKR2O2xOOHZC+lailtlbkL7zlfdn
         kWLq3enmIUZcfGhQEWUf26by9KhBzn6CfoWDASWVcJCdLpvVqGhMLdvPozOnqY1Gz/zu
         AunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694698653; x=1695303453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtEDLGrLEJ6Yf0BlzG31NFuV4f9+Z2ng7sP9jomSPgM=;
        b=aDCqIX0u96AywQzGmaOGQ3yOrvG3YfYueOlJQQnXgczu8MFrb1ItIy+djbpnTyBLvV
         nT+zLfHxrABqtQW31ylFL9/ouO/Xc828tZB34i5TiuuFgbXF3TBZQBPz5VWAzNU6ufJn
         FW5/fA3nJgUFgWBRo0zPpGrXlYF7W12At9AraBAzR2f84WzF6khGTocvOS7sHdqq4Ofc
         N2NkPe67uOfMA4bGpIlm87UxRySx1HvEzQDbViJaa9jKVi5h5dR1nfF83oq0MdxT/wVQ
         ChVaDviq9YebsLaZe4s/q8/4dJPXDoqu4kXhpkoJSNFpUuWuhUg5R12jvEUZdk2EbIHW
         ecSw==
X-Gm-Message-State: AOJu0Yyt5ztewRFnVj0BjNXfrdlSOLeVjEpMZBjbFMRGrlCTwyPw2i58
        AeW2cSGyIkCE8UilJo0yhIFidQ==
X-Google-Smtp-Source: AGHT+IEpMsWeTM1Aa8jmxIP5P65K/mbegu/VOKs43KIrqswYDTztiwkAzB/UX/3KB10SAajS1EkwbA==
X-Received: by 2002:a7b:c44b:0:b0:3f7:f2d0:b904 with SMTP id l11-20020a7bc44b000000b003f7f2d0b904mr4478679wmi.8.1694698652704;
        Thu, 14 Sep 2023 06:37:32 -0700 (PDT)
Received: from ta2.c.googlers.com.com (206.39.187.35.bc.googleusercontent.com. [35.187.39.206])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d4ace000000b0031c5dda3aedsm1824865wrs.95.2023.09.14.06.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:37:32 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        corbet@lwn.net
Cc:     linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 1/2] docs: pstore-blk.rst: use "about" as a preposition after "care"
Date:   Thu, 14 Sep 2023 13:37:28 +0000
Message-ID: <20230914133729.1956907-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reword the sentence to "care about the {oops/panic, pmsg, console} log."

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 Documentation/admin-guide/pstore-blk.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
index 2d22ead9520e..1df5d4f93219 100644
--- a/Documentation/admin-guide/pstore-blk.rst
+++ b/Documentation/admin-guide/pstore-blk.rst
@@ -76,7 +76,7 @@ kmsg_size
 ~~~~~~~~~
 
 The chunk size in KB for oops/panic front-end. It **MUST** be a multiple of 4.
-It's optional if you do not care oops/panic log.
+It's optional if you do not care about the oops/panic log.
 
 There are multiple chunks for oops/panic front-end depending on the remaining
 space except other pstore front-ends.
@@ -88,7 +88,7 @@ pmsg_size
 ~~~~~~~~~
 
 The chunk size in KB for pmsg front-end. It **MUST** be a multiple of 4.
-It's optional if you do not care pmsg log.
+It's optional if you do not care about the pmsg log.
 
 Unlike oops/panic front-end, there is only one chunk for pmsg front-end.
 
@@ -100,7 +100,7 @@ console_size
 ~~~~~~~~~~~~
 
 The chunk size in KB for console front-end.  It **MUST** be a multiple of 4.
-It's optional if you do not care console log.
+It's optional if you do not care about the console log.
 
 Similar to pmsg front-end, there is only one chunk for console front-end.
 
@@ -111,7 +111,7 @@ ftrace_size
 ~~~~~~~~~~~
 
 The chunk size in KB for ftrace front-end. It **MUST** be a multiple of 4.
-It's optional if you do not care console log.
+It's optional if you do not care about the console log.
 
 Similar to oops front-end, there are multiple chunks for ftrace front-end
 depending on the count of cpu processors. Each chunk size is equal to
-- 
2.42.0.459.ge4e396fd5e-goog

