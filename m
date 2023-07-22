Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F175D9BF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGVEsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGVEsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5A03ABA;
        Fri, 21 Jul 2023 21:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E798560A58;
        Sat, 22 Jul 2023 04:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47903C433C9;
        Sat, 22 Jul 2023 04:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690001303;
        bh=cMGx1e3bJT94xzdbCntW6kEvaWujCMXDy0LRihc5JIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnAa9e+bbFLQ9QTWiAxYlX7jtdd0t90rvszunjXfUFFqB0prlfD+VXDhH8MGCsa6i
         AQQknk/x5+zKszJz2A9LkkzgEUnq321T8Fbt7e2K6vb0nv2rWY1ap5FzgnMwYJqTQh
         40Bl5569+R5cxcxgqJWpEfGowVsnj5PAGBGKlE0aVw2WW6UXLNEaPn9CtzUVouXdGK
         neY06HwkY+E3oHHZUjZnrDUThANqQTi9l5Wg0Kd9FcWHkKTdh3BJJRJiwfPCIYXI8L
         dFbWqiISLGNd04ghejk76ClpextopA702OvUFQtMYfRj0PHVBtLPVwlfTfVsk8YaRp
         Zy3Bs0irIIIoA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 06/19] kbuild: rpm-pkg: replace $__KERNELRELEASE in spec file with %{version}
Date:   Sat, 22 Jul 2023 13:47:53 +0900
Message-Id: <20230722044806.3867434-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230722044806.3867434-1-masahiroy@kernel.org>
References: <20230722044806.3867434-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

${version} will be replaced with the value of the Version field.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index 0befb4e2ac6b..a6a383aaaea7 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -81,12 +81,12 @@ $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
 	glibc package.
 
 $S$M	%package devel
-$S$M	Summary: Development package for building kernel modules to match the $__KERNELRELEASE kernel
+$S$M	Summary: Development package for building kernel modules to match the %{version} kernel
 $S$M	Group: System Environment/Kernel
 $S$M	AutoReqProv: no
 $S$M	%description -n kernel-devel
 $S$M	This package provides kernel headers and makefiles sufficient to build modules
-$S$M	against the $__KERNELRELEASE kernel package.
+$S$M	against the %{version} kernel package.
 $S$M
 $S	%prep
 $S	%setup -q -n linux
-- 
2.39.2

