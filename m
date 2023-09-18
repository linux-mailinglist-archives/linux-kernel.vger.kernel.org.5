Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7742A7A3FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbjIREEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbjIRED5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:03:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B820FF
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:03:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-577fb90bbebso2762759a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 21:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1695009831; x=1695614631; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkj+ilWgLWNJQbtZF0y92BH3EfaM8mYrGUt+ZNYlBcA=;
        b=W/nLxAil9CWx9JnkEq1UDWPvDUb7SRbscy/uiZiKggWF8EyCITE89q0h65Ru2pxUOt
         aO+3RnCG14nvENQJNZWcSuRadDkeeKw8WwDVL4nMCG2MLmne62tyClkI+C6q4ud2lD7J
         FmVFvxKYKggItMRlWlRRi3JJyuEBg9HIN3cO9pWju6s9gmFFcqcpWdOQxpWqRswJHf+e
         ydIAYL66GNhU6prKttO3xXwJfjsBTcKdz6IGg2YyYozuE02reMfUth+Cp8Yk6XtHclSj
         /UzkcSoXMRTh5aWRZRblOSQLrzKNciQqI3mhcFLzzjSIAvrYsqqigBbdnhUbHIvwjk6q
         dOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695009831; x=1695614631;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkj+ilWgLWNJQbtZF0y92BH3EfaM8mYrGUt+ZNYlBcA=;
        b=sM4Tgew1BxNgx0WSV25ECS8MYpL5JiQZ2qfDnHbj8LjRQ3Yewndn/KoFsI2QD5XoWS
         /gWmE774rYmqXmu8WquoWaEcGxKUdss4Dz2lbM8LbRW3nWDlUlvT/wkHi9bOgIgI9kxe
         lNkltUA5bYy6SaYJcfTkzDUf++tqkFiIiFupD4vmTGqHZnIzvXlZUZoXEsarrK/Na1kF
         g6fUw2Kxw7w8FMxJ4LLbHiajpMjbVw+79E14CGUTilfSOGLSkJqTsguLUVfxWAvLbIyU
         HLseUn/BuNOM9JH1fG4VUhHxaOh/KN1ugTDBEnfwFtJgY5Lh1xnhHIgcpRo8vGkXRqFv
         4LrQ==
X-Gm-Message-State: AOJu0YzYvwLVb4aq15H2FC5GHV7N/T5XaIjvJH2OXiVJw9ipZ4mSH4xe
        MXtrbC2L1HRB6CsSvlb/tMZkOg==
X-Google-Smtp-Source: AGHT+IESuVmEAOWn1XKQO9o0uYHbdIHCu/swCuCFd6oTlQVftKoIQLIFB7z8L2ugvPM+bSUBJhJocA==
X-Received: by 2002:a05:6a20:8f0c:b0:14c:5dc3:f1c9 with SMTP id b12-20020a056a208f0c00b0014c5dc3f1c9mr9545279pzk.49.1695009831597;
        Sun, 17 Sep 2023 21:03:51 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id v2-20020a62a502000000b0066a2e8431a0sm6314133pfm.183.2023.09.17.21.03.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2023 21:03:51 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        <rafael.j.wysocki@intel.com>
Cc:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Mario.Limonciello@amd.com>,
        "'Swapnil Sapkal'" <swapnil.sapkal@amd.com>, <Ray.Huang@amd.com>,
        "Doug Smythies" <dsmythies@telus.net>
References: <001701d9e9ae$02438120$06ca8360$@telus.net> <002301d9e9e2$13424090$39c6c1b0$@telus.net>
In-Reply-To: <002301d9e9e2$13424090$39c6c1b0$@telus.net>
Subject: [PATCH v3] tools/power/x86/intel_pstate_tracer: python minimum version
Date:   Sun, 17 Sep 2023 21:03:54 -0700
Message-ID: <002401d9e9e5$248f3d50$6dadb7f0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adnp5IxFciJ5SBfmQOq9Nt1eFtgl9g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Doug Smythies <dsmythies@telus.net>

Change the minimum python version from 2.7 to 3.6.
Remove a 2.X backwards compatibility line.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---

v2 -> v3: Try to fix mess that was v2.
v1 -> v2: Fix careless typos.

---
.../x86/intel_pstate_tracer/intel_pstate_tracer.py   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index ec3323100e1a..38cfbdcdedb7 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 # -*- coding: utf-8 -*-
 #
@@ -11,11 +11,11 @@ then this utility enables and collects trace data for a user specified interval
 and generates performance plots.

 Prerequisites:
-    Python version 2.7.x or higher
+    Python version 3.6.x or higher
     gnuplot 5.0 or higher
-    gnuplot-py 1.8 or higher
+    python3-gnuplot 1.8 or higher
     (Most of the distributions have these required packages. They may be called
-     gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, ... )
+     gnuplot-py, python-gnuplot or python3-gnuplot, gnuplot-nox, ... )

     HWP (Hardware P-States are disabled)
     Kernel config for Linux trace is enabled
@@ -23,7 +23,7 @@ Prerequisites:
     see print_help(): for Usage and Output details

 """
-from __future__ import print_function
+
 from datetime import datetime
 import subprocess
 import os
@@ -562,7 +562,7 @@ if __name__ == "__main__":

     # Temporary (or perhaps not)
     cur_version = sys.version_info
-    print('python version (should be >= 2.7):')
+    print('python version (should be >= 3.6):')
     print(cur_version)

     # Left as "cleanup" for potential future re-run ability.
--
2.25.1


