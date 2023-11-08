Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3207E4E88
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjKHBXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjKHBXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:23:35 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D020D10CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:23:08 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b3f6f330d4so3685803b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 17:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699406588; x=1700011388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kXOO76hl05hGJXvyn0Dlhgaia7Zq8+Y5vhNHIIQ2qOw=;
        b=b7VdTjgeEEZdOBD7nqm7qAy6KOxTPbx7q2rM4wDSJ1WjF7tdfLB2Eu/xalUPbOoPzM
         lFWtSAslqGjAC5LyOif89tXl3191dJ6A7Zh1x+sy2leS0r4jGBzSb0GzGhZTKGJmbtad
         3sN7Sg2CPxjVjOOlUbaB6izmbfvYNEb/8/7xU22qshWkRYUzhjbEyBnkzxGsH4AlRcHC
         yE8IHaodUjhnN1G4Wfg0V6mc1Z5ZWxz1A57BdsqZzT8NQDXuiUSb0/LLi6nLWgis8fnU
         zqRNlzobQvUi5jwkoCZgx6uwEjL2IsYfF6GHljWRKHd0C9T0EzsF0IKdX/lItGzNvI2p
         yaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699406588; x=1700011388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXOO76hl05hGJXvyn0Dlhgaia7Zq8+Y5vhNHIIQ2qOw=;
        b=Y3lMnBP5VtGOXUYV2YUO1Dp8bCP5kyQnA03jL6hfLVSJfPbV3iE3KMh5g358ftSU+9
         o9i7JnPXXyIAy581CXPaFc4Zd8Hxd0nsA10oS0cvy5bj3c0lFUPqXTNoxZ1DNNWQ1cT8
         zJdkcn1k9RtxlLvhZQIAa+a4q620Yvrz8tCh/6eZh1VP+/E7OGH7U2LyGccCoaQI0MTf
         Fucn41nCa91vAxtX5yvDM5JdU7zXQL8fjUoD/zGtC+LBORdQiyonPu7x71ZlgPPsBRIK
         g/RO4CTXySvodobfAtFe0HD4++tFCaGBqVFRTENSddu/vbPQoMj6xbCrVtODsXd7za8R
         WraQ==
X-Gm-Message-State: AOJu0YyTeAp3BSDaUqItxtqlagOB5Vt11BB0xielz7freq0IIXEx258R
        s+84Wy4z3QNiy1cwB6CUjgtCBg==
X-Google-Smtp-Source: AGHT+IFywJIqCXeozZV9JT47PnRA6v7pNChB5NLURo3ZsVZ1TcYPwMrJlqVhsbtia6tMCZWP0acv1w==
X-Received: by 2002:a05:6808:f03:b0:3a7:8f94:743a with SMTP id m3-20020a0568080f0300b003a78f94743amr873721oiw.10.1699406588131;
        Tue, 07 Nov 2023 17:23:08 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id g24-20020aa78758000000b006c003d9897bsm7762649pfo.138.2023.11.07.17.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 17:23:07 -0800 (PST)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     mhiramat@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v1] lib: test_objpool: make global variables static
Date:   Wed,  8 Nov 2023 09:22:48 +0800
Message-Id: <20231108012248.313574-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot reported build warnings that structures g_ot_sync_ops,
g_ot_async_ops and g_testcases should be static. These definitions are
only used in test_objpool.c, so make them static

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311071229.WGrWUjM1-lkp@intel.com/

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 lib/test_objpool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/test_objpool.c b/lib/test_objpool.c
index a94078402138..bfdb81599832 100644
--- a/lib/test_objpool.c
+++ b/lib/test_objpool.c
@@ -311,7 +311,7 @@ static void ot_fini_sync(struct ot_context *sop)
 	ot_kfree(sop->test, sop, sizeof(*sop));
 }
 
-struct {
+static struct {
 	struct ot_context * (*init)(struct ot_test *oc);
 	void (*fini)(struct ot_context *sop);
 } g_ot_sync_ops[] = {
@@ -475,7 +475,7 @@ static struct ot_context *ot_init_async_m0(struct ot_test *test)
 	return sop;
 }
 
-struct {
+static struct {
 	struct ot_context * (*init)(struct ot_test *oc);
 	void (*fini)(struct ot_context *sop);
 } g_ot_async_ops[] = {
@@ -632,7 +632,7 @@ static int ot_start_async(struct ot_test *test)
 #define NODE_COMPACT sizeof(struct ot_node)
 #define NODE_VMALLOC (512)
 
-struct ot_test g_testcases[] = {
+static struct ot_test g_testcases[] = {
 
 	/* sync & normal */
 	{0, 0, NODE_COMPACT, 1000, 0,  1,  0,  0, "sync: percpu objpool"},
-- 
2.40.1

