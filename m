Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466E07F4A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbjKVPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344433AbjKVPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:33:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFBA10E3;
        Wed, 22 Nov 2023 07:32:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E940C433CB;
        Wed, 22 Nov 2023 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667172;
        bh=B/bJkVlPR23vUesozPLfwxv3id4Wa8uPw0GU0TIH/SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0FvZwdJtOdrZ3aBG9e6Mp56kOKvzGZpLp+sYrzJQYUT6M7ChU5DVhL8l9yPWtcEM
         moehMS8tHVF98qpJHGxxq7Pq29qT1APcVt7LzuA2jCuzBIfd9oyZueaoUonfJeDPKg
         CYVpXNMhTmEkBUfXl9egwU8tIWTfbC9KXfxMMvQtzGK6+qKizQ3KkG9qkKvZkXOXtW
         2J7ks71Nrbjq+maWiPc9PkLelXwCj6YAQjWVf6P5RBjeVSyYdkMCHxlKulIXdF4XRq
         Vf5rIzAlhflZEl/Q/guGLCQiZJ73OJGO19v6h1V42khZxwUbjD51EAq0ruDtqUzwtN
         p3eEkqCS52k2g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, deller@gmx.de,
        ndesaulniers@google.com
Subject: [PATCH AUTOSEL 6.6 12/17] linux/export: clean up the IA-64 KSYM_FUNC macro
Date:   Wed, 22 Nov 2023 10:31:41 -0500
Message-ID: <20231122153212.852040-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153212.852040-1-sashal@kernel.org>
References: <20231122153212.852040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

[ Upstream commit 9e0be3f50c0e8517d0238b62409c20bcb8cd8785 ]

With commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture"),
there is no need to keep the IA-64 definition of the KSYM_FUNC macro.

Clean up the IA-64 definition of the KSYM_FUNC macro.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/export-internal.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index 45fca09b23194..69501e0ec239f 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -50,9 +50,7 @@
 	    "	.previous"						"\n"	\
 	)
 
-#ifdef CONFIG_IA64
-#define KSYM_FUNC(name)		@fptr(name)
-#elif defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
+#if defined(CONFIG_PARISC) && defined(CONFIG_64BIT)
 #define KSYM_FUNC(name)		P%name
 #else
 #define KSYM_FUNC(name)		name
-- 
2.42.0

