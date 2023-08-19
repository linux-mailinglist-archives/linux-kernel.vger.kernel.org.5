Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED04078194F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 13:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjHSLoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 07:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHSLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 07:44:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA359EFE;
        Sat, 19 Aug 2023 04:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73EA261BED;
        Sat, 19 Aug 2023 11:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FC3C433C7;
        Sat, 19 Aug 2023 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692445386;
        bh=v4/hJHuxQjUWnPGAM1YGHOt/h9vD2azOqJ+JvQNLGas=;
        h=From:To:Cc:Subject:Date:From;
        b=JffwpfJhNF1TRsStEi588+ofvHki0RgSlMjMn4qoZKyWSGSlrvJ7IGwggWhjQwnI7
         AtjNFai1SS63VJteVCJ5uRxDOtQ4XakDBzt2JhMOnmGkZDxsxoSs0dj2SnsusSLUkX
         lgL1QqesPzQy1VrR/2+pABDBC7R0NP184il7CkYbAsDBuVDf+amqyLI3x9zm8fcret
         ieiZTBHnUjzcg8cVpIv+enxJu0Ob0fqlqBSZsGEaUeJHUWUfs0EB9F1nLDdBjUTzNm
         jwVo0GGI3T/6B9UpRo6+yDIucJYBKfF9aKUqtapuctbPFDjft7Hc6J7PwwV9sr8W2v
         1+6eHRz4ghSvw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: remove include/ksym from CLEAN_FILES
Date:   Sat, 19 Aug 2023 20:43:01 +0900
Message-Id: <20230819114301.3505878-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a remnant of commit 5e9e95cc9148 ("kbuild: implement
CONFIG_TRIM_UNUSED_KSYMS without recursion").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4425d87dd2fa..f451241d0feb 100644
--- a/Makefile
+++ b/Makefile
@@ -1596,7 +1596,7 @@ endif
 # make distclean Remove editor backup files, patch leftover files and the like
 
 # Directories & files removed with 'make clean'
-CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
+CLEAN_FILES += vmlinux.symvers modules-only.symvers \
 	       modules.builtin modules.builtin.modinfo modules.nsdeps \
 	       compile_commands.json .thinlto-cache rust/test rust/doc \
 	       rust-project.json .vmlinux.objs .vmlinux.export.c
-- 
2.39.2

