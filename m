Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4578C3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjH2MFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjH2MFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:05:16 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD456A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:05:13 -0700 (PDT)
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0DE6A3F628
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693310712;
        bh=e70L7q75/5WAUdG1jNw50iq9wJAJmZ681cWtE6OE9ms=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=mPxmNXMGjgiZ38M8yhMrUONdA2iH6OEeazZt8LsrESgz2tjCt4kuAJqA6pLXj7CAe
         YCyqcgarvmwYALpz4owhXU4UnN/KpAdPl7+t6A2c6VxC2sHKp0/oIyraqBH0lu2uYL
         xdFxVtohYEJ1qfuiMsjjVQKSvhDeDBBq3IHF/yQpL0MpgUUAPqgnolvpjNBRo4Nx+/
         yUn+oc3mmEzIuiQbOXkZ1eE1fZGz3DCBGq2V9Aj0aM/RLQZAjzEUD5/Zlsv7kRwCFg
         M6UlZTZFTHwcElZ+m5RrH5eauY4mM96lClOF6+VQimzf7ec8czYIcUXYQmcBG/UNrQ
         8hRE4Q9VUGr9w==
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bcff05089cso31909691fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693310711; x=1693915511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e70L7q75/5WAUdG1jNw50iq9wJAJmZ681cWtE6OE9ms=;
        b=ePkgH2d9UqUZOtMS4m3f98BBLMW25D9dQIN02DUXJjriVlzWQM3xOrRVAToW2Y4Bzx
         9Slkh/lKVEDgc6cGDH1pzdI5xO5eCfTyl02mifmNWSDjw19FF0dkNxkfD3G5njxRzqcU
         BqxG2q3Jg5nOH556HTabtubtnzrpc1o6iC6mr+kPpSphh7lVKFyxBG8pcqZlQsDyV4rW
         fdRnVhDOB/sETG/SVWm+jfF9eSb/JS65YRmBgErVD66LI1hTkDhz6ABELYFbMUHTGwxG
         UE7zHWerhI04yaIps4z78bua2JvkakWgI6JbCArFA4THTcO1UDCY4XjTNjDRdTOQQzp9
         CVhw==
X-Gm-Message-State: AOJu0Yz/DwFZVs2oSnTnokDXA8Sj3UCkE/vgzp7AYzc+7ChXR8fc/O8H
        cnXDPQiCr7WyIAsHlEI6fzNnHc5GyaeDw6twqnH+VVrUc62J3NAxfyIyPkGnQdelIZn2u6YmyXq
        UynUUUT4gh36FECkPOgDnYblKSVMTlPfQSeJzukxAHw==
X-Received: by 2002:a05:6512:759:b0:500:97e4:587e with SMTP id c25-20020a056512075900b0050097e4587emr10936891lfs.44.1693310711399;
        Tue, 29 Aug 2023 05:05:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEda+04ncnF1Q8MrcWlY/pJUGUXUVbBjQys9oNLFNvCPVL/OooHkzRqK1N6E1fTNQ+Z0Us02w==
X-Received: by 2002:a05:6512:759:b0:500:97e4:587e with SMTP id c25-20020a056512075900b0050097e4587emr10936869lfs.44.1693310710937;
        Tue, 29 Aug 2023 05:05:10 -0700 (PDT)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-95-252-65-153.retail.telecomitalia.it. [95.252.65.153])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b009929ab17be0sm5865374eju.162.2023.08.29.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:05:10 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Nick Terrell <terrelln@fb.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] module/decompress: use vmalloc() for zstd decompression workspace
Date:   Tue, 29 Aug 2023 14:05:08 +0200
Message-Id: <20230829120508.317611-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using kmalloc() to allocate the decompression workspace for zstd may
trigger the following warning when large modules are loaded (i.e., xfs):

[    2.961884] WARNING: CPU: 1 PID: 254 at mm/page_alloc.c:4453 __alloc_pages+0x2c3/0x350
...
[    2.989033] Call Trace:
[    2.989841]  <TASK>
[    2.990614]  ? show_regs+0x6d/0x80
[    2.991573]  ? __warn+0x89/0x160
[    2.992485]  ? __alloc_pages+0x2c3/0x350
[    2.993520]  ? report_bug+0x17e/0x1b0
[    2.994506]  ? handle_bug+0x51/0xa0
[    2.995474]  ? exc_invalid_op+0x18/0x80
[    2.996469]  ? asm_exc_invalid_op+0x1b/0x20
[    2.997530]  ? module_zstd_decompress+0xdc/0x2a0
[    2.998665]  ? __alloc_pages+0x2c3/0x350
[    2.999695]  ? module_zstd_decompress+0xdc/0x2a0
[    3.000821]  __kmalloc_large_node+0x7a/0x150
[    3.001920]  __kmalloc+0xdb/0x170
[    3.002824]  module_zstd_decompress+0xdc/0x2a0
[    3.003857]  module_decompress+0x37/0xc0
[    3.004688]  init_module_from_file+0xd0/0x100
[    3.005668]  idempotent_init_module+0x11c/0x2b0
[    3.006632]  __x64_sys_finit_module+0x64/0xd0
[    3.007568]  do_syscall_64+0x59/0x90
[    3.008373]  ? ksys_read+0x73/0x100
[    3.009395]  ? exit_to_user_mode_prepare+0x30/0xb0
[    3.010531]  ? syscall_exit_to_user_mode+0x37/0x60
[    3.011662]  ? do_syscall_64+0x68/0x90
[    3.012511]  ? do_syscall_64+0x68/0x90
[    3.013364]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8

However, continuous physical memory does not seem to be required in
module_zstd_decompress(), so use vmalloc() instead, to prevent the
warning and avoid potential failures at loading compressed modules.

Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 kernel/module/decompress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 8a5d6d63b06c..87440f714c0c 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -241,7 +241,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	}
 
 	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
-	wksp = kmalloc(wksp_size, GFP_KERNEL);
+	wksp = vmalloc(wksp_size);
 	if (!wksp) {
 		retval = -ENOMEM;
 		goto out;
@@ -284,7 +284,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	retval = new_size;
 
  out:
-	kfree(wksp);
+	vfree(wksp);
 	return retval;
 }
 #else
-- 
2.40.1

