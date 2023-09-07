Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6FA797A96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbjIGRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245327AbjIGRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:45:37 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC731FF7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:45:14 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7926a450a0aso49920639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694108710; x=1694713510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKEBIhsBuPMIFoNFrg7e7FdSYJiWl4JlzcAiWAe6P/4=;
        b=qMcoXbUlBkzrQNzV53tCFs+sSo2LWMAt+zBICQd/xU5CwvPD61LcfwnRJP9iHQYc6l
         ldZUPVKrbrCNL4wn/HNyjACsJBqm+75zZLvQsAoRQ+2lb2dHF/LnYeGtQMsobNoBiC/I
         adkVV3swWvXQRJ1z8tVscMXIKLj5rcyoGJ63l1rIk4ewQ1NrC1/ZiCAJezEkXHTeYdxu
         uWuYCiMtCyMDOyaj02Kf56T27aufoj+Kl7I7/awmO2li8KQO6i7aSzeP4XlMdUD5KUxC
         eM9QxnYY99YwlJMtVpT/iL7/U99wdeMtVFvuj5T16hng3VNqzZjNq+/jlQbs1tVfwWiP
         vivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108710; x=1694713510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKEBIhsBuPMIFoNFrg7e7FdSYJiWl4JlzcAiWAe6P/4=;
        b=nd8+grO1h6vqEZU12fzQFrxJgPRP8ECb/ZqcdQMQEriU7f8B89XEM3Rfrzu1MGpUCv
         fuoC72jXvsBzNyNPELN4N7vxh0u829pZuxgzz/XZwtx6NC1i7/aSBmu7wx/O+5TjeTtQ
         1d3waV0eTe4WL5EFed+2NcFTkxf3BY+V1XUpb9tgbPkXfFw57vDtP4nSlZhRXeMBg5fW
         H90N4kzbzRE5r4CXnW3SosnZSZ0mkNHYgN3QyHlMiiEzaR56VfRuABo9oXaG3UJ16tpr
         ChQA4fyaITiVsOJLFSjYeLRxlcxmtJhuckEp0BfdCE9F+MngEq+wtuB3twB7wG4r/nzr
         5qmQ==
X-Gm-Message-State: AOJu0Yz5J4j7TAqG6SU4bZwpGlezlSx/GEoYTQB+wIZxfxi17Y48OUD4
        aMZu6oqxDTisWCWjJ5gM0I4b2Ob5wAjNXQ==
X-Google-Smtp-Source: AGHT+IHc+0aLZ2pC5b5XOj3At31tdt6+PUmNAXXs+nXSU+GgA8eM07yfJVw4IAcRVVLAQdSnm7WK+Q==
X-Received: by 2002:a5e:de43:0:b0:783:5fd9:3789 with SMTP id e3-20020a5ede43000000b007835fd93789mr473337ioq.1.1694108710305;
        Thu, 07 Sep 2023 10:45:10 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id b19-20020a5ea713000000b00783737db8ebsm5915154iod.38.2023.09.07.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 10:45:09 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Jim Cromie <jim.cromie@gmail.com>,
        apw@canonical.com, joe@perches.com,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 2/2] checkpatch: reword long-line warning about commit-msg
Date:   Thu,  7 Sep 2023 11:45:06 -0600
Message-ID: <20230907174506.593889-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The COMMIT_LOG_LONG_LINE warning complains about:
 1- possible unwrapped commit description
 2- line too long

The actual test is #2, so reword it to say that 1st.
This could reduce potential confusion for newbie users.

Cc: apw@canonical.com
Cc: joe@perches.com
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6aabcc1f66c1..6e789dc07420 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3272,7 +3272,7 @@ sub process {
 					# A Fixes:, link or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
-			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
+			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
 			$commit_log_long_line = 1;
 		}
 
-- 
2.41.0

