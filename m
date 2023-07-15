Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99083754812
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGOJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:58:24 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DAD2701
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 02:58:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso3443185a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689415101; x=1692007101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bePB1F78473kJ9CARPNATqx/xVK93vtfpz7oAtehb7U=;
        b=m/vvlYF657X1K/r7/uop/7Pgi6IYdGhOH5GEYqTjzV4sUX/+6vaN2kVlLzDv4vQMn+
         Z6+FK64tHUKdaRAS02J1PMx+MV04lW4jOYFjgD9LTkj/dYb4Uawduz+soEmGiqCvbpxb
         ZUOPCuARV54XU6wfQFsoEWg5hcB54lvvMJtyUcEiphBtzdNC4t1ApTugmVqEs6ihcrwT
         ubuqJtiuWzWAyARmykvjEOxPCBnlLVtf48Qi6avz2PfOyzGEj8+N6/md1DlTK9ecOtyO
         UIbngmkr+f9QtIUWicw3XVhuhSaAJjt0hDusAwJb56OhQGuUCLKzOrUM5LuRQcKyVBD4
         mthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689415101; x=1692007101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bePB1F78473kJ9CARPNATqx/xVK93vtfpz7oAtehb7U=;
        b=MAY4iAvVmL9/zcnATS/oLim1ltUir+7VAWA+20+Rjh2ebz0sXJxL62CSXOPV6PLIDN
         KP/vQJ4QUBduKCZrbL/1BA5mXUK1xQIEVP1kXwQC+Vyecyt+SWZe7RYI25HSI2t354/r
         /EA5jIZwyoWv3GiHCi7W50nG6CgGLfIY/Ye67XhBhRwJDEuBNkqUed70afR64bQXQ3p3
         094XM+Bc6p7MdJEXgcFSdk5QpfBo0cjS/xLoskVCMiRnAJDXpAlrNLuHKnJikkkjqOrN
         nWB0fDjZ4hVA442yN/4Rvib2fCyJMi80vm1OvWqMuYeZC9iTREltZsVpFv1o5nebUELl
         5gDw==
X-Gm-Message-State: ABy/qLaajdxbMfcXADyRbDebOJssfhH/JTGFpek7PhStX8CeWHGyedmo
        ua1vEx1IBUE8ovFAtuahpxM=
X-Google-Smtp-Source: APBJJlFinYovNX9H2U36+E/ECeWoV88Bvit5r2rtedvfHMKBxEPDyVFDw2te4u9bOzrPbxAefVBzdQ==
X-Received: by 2002:a17:906:77cf:b0:994:4095:3abf with SMTP id m15-20020a17090677cf00b0099440953abfmr6321449ejn.14.1689415100739;
        Sat, 15 Jul 2023 02:58:20 -0700 (PDT)
Received: from localhost (dslb-094-220-187-252.094.220.pools.vodafone-ip.de. [94.220.187.252])
        by smtp.gmail.com with ESMTPSA id ci7-20020a170906c34700b009934707378fsm6585299ejb.87.2023.07.15.02.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:58:19 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: ignore /dev/null being added for file path checks
Date:   Sat, 15 Jul 2023 11:58:04 +0200
Message-Id: <20230715095804.14258-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In e.g. schema to yaml conversion patches, a file may be deleted,
causing checkpatch in strict mode to complain about files outside of the
bindings directory being modified:

  ./scripts/checkpatch.pl --strict --showfile 0001-dt-bindings-spi-convert-spi-brcm63xx.txt-to-YAML.patch
  dev/null:72: WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
  total: 0 errors, 1 warnings, 0 checks, 79 lines checked

Since this isn't a real file, skip any further checks based on the
file's location.

Fixes: 133712a2ec84 ("checkpatch: DT bindings should be a separate patch")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 880fde13d9b8..30de47909460 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2856,6 +2856,12 @@ sub process {
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
 			$in_commit_log = 0;
 
+			# "/dev/null" being added means a file was actually
+			# deleted, no need for further file location checks
+			if ($line eq "+++ /dev/null") {
+				next;
+			}
+
 			$p1_prefix = $1;
 			if (!$file && $tree && $p1_prefix ne '' &&
 			    -e "$root/$p1_prefix") {
-- 
2.34.1

