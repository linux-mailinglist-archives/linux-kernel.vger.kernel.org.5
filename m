Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFC478C35D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjH2LgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjH2Lfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1176E109;
        Tue, 29 Aug 2023 04:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 965DD60EAE;
        Tue, 29 Aug 2023 11:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED71C433C8;
        Tue, 29 Aug 2023 11:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693308942;
        bh=SEm+29cbjH0OCwAWFWoSuP1sSdbIL6i8Z3mrtpUFzk0=;
        h=From:To:Cc:Subject:Date:From;
        b=fxwwGSDQUQw4Q5QfZRDz+zr+x7HkaZksrDhPqVSYDf0eogzHxC0TIV37jg/+XENZf
         THvUDi8u6zWZAC9/j3G0VwQFVdCEnbZS0FN5CgNdfy11tujT0rGrYhaRoFLS11Yemw
         UuozUawY2Vma1IZqh6bze75GyzGZ6FOxD378v1V3A1OHNon5VxKMp1dIEs8oVKwuOd
         AK+ybmDLK8S28oeQSxQ0xH+/ohqHqxlpF7yIWBinJfjS1TuQ+Z9A7/oaQrQEQwXl9A
         vbcTCtugkxl4bjmlaIbewKYaih+Tc2A6EgjWHx6KrUvEReBb4FuZfguwK2WKc12jcX
         P4E1qMsfttemw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] kbuild: single-quote the format string of printf
Date:   Tue, 29 Aug 2023 20:35:31 +0900
Message-Id: <20230829113531.4004730-1-masahiroy@kernel.org>
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

Use single-quotes to avoid escape sequences (\\n).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile              | 8 ++++----
 arch/powerpc/Makefile | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 87a9eef3fb4b..d09600f7a036 100644
--- a/Makefile
+++ b/Makefile
@@ -1643,12 +1643,12 @@ help:
 	@echo  ''
 	@$(if $(boards), \
 		$(foreach b, $(boards), \
-		printf "  %-27s - Build for %s\\n" $(b) $(subst _defconfig,,$(b));) \
+		printf '  %-27s - Build for %s\n' $(b) $(subst _defconfig,,$(b));) \
 		echo '')
 	@$(if $(board-dirs), \
 		$(foreach b, $(board-dirs), \
-		printf "  %-16s - Show %s-specific targets\\n" help-$(b) $(b);) \
-		printf "  %-16s - Show all of the above\\n" help-boards; \
+		printf '  %-16s - Show %s-specific targets\n' help-$(b) $(b);) \
+		printf '  %-16s - Show all of the above\n' help-boards; \
 		echo '')
 
 	@echo  '  make V=n   [targets] 1: verbose build'
@@ -1684,7 +1684,7 @@ $(help-board-dirs): help-%:
 	@echo  'Architecture specific targets ($(SRCARCH) $*):'
 	@$(if $(boards-per-dir), \
 		$(foreach b, $(boards-per-dir), \
-		printf "  %-24s - Build for %s\\n" $*/$(b) $(subst _defconfig,,$(b));) \
+		printf '  %-24s - Build for %s\n' $*/$(b) $(subst _defconfig,,$(b));) \
 		echo '')
 
 
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index dac7ca153886..f49ac05eae20 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -353,7 +353,7 @@ define archhelp
   echo '  (minus the .dts extension).'
   echo
   $(foreach cfg,$(generated_configs),
-    printf "  %-27s - Build for %s\\n" $(cfg) $(subst _defconfig,,$(cfg));)
+    printf '  %-27s - Build for %s\n' $(cfg) $(subst _defconfig,,$(cfg));)
 endef
 
 PHONY += install
-- 
2.39.2

