Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98017A5166
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjIRR5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjIRR5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:57:41 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1142102
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695059850; x=1695319050;
        bh=JDjRiSWJTFYH8PD2dsxNGLZbrcHGdPkUJwg1xfwDJyE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=UiH8zlNQV4EfGcXtLn6o+BWQmdaIhHe4qkC+6PW4uRqWDrgWJSGYQSDSrmH/oh5gD
         +743EUp4OvrK7/ue6YqnjeHRLVe2B1CX1EZO6PdNf0Gk3aHDaAw7tIvQPRvQ2jtpXx
         7gIHr05bK6WuJ94pLuN6OXjUjWPYLslTC5lNqJ1/o2NwBQDtMs4ghs9cvXD2kT6+1Q
         38lzm2a2O59naRzFSwTWF6isgSuFE146udcUPlWi+Z2ioT53DCSGVg7811Y7ig8akz
         0sAFqzmU5cfcHYFBhvRRkvNLbIzN+nAwGyDNxqy0cD4MjeLxs9/lf8vix/RCFE90ie
         tNsRzgDnfc+LA==
Date:   Mon, 18 Sep 2023 17:57:10 +0000
To:     linux-mips@vger.kernel.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de
Subject: [PATCH 4/7] arch: mips: remove ReiserFS from defconfig
Message-ID: <20230918175529.19011-5-peter@n8pjl.ca>
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ReiserFS has been deprecated for a year and a half, yet is still built
as part of a defconfig kernel.

According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
filesystem is slated to be removed in 2025. Remove it from the defconfig
profiles now, as part of its deprecation process.

Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
 arch/mips/configs/fuloong2e_defconfig   | 1 -
 arch/mips/configs/jazz_defconfig        | 4 ----
 arch/mips/configs/lemote2f_defconfig    | 3 ---
 arch/mips/configs/malta_defconfig       | 5 -----
 arch/mips/configs/malta_kvm_defconfig   | 5 -----
 arch/mips/configs/maltaup_xpa_defconfig | 5 -----
 arch/mips/configs/rm200_defconfig       | 4 ----
 7 files changed, 27 deletions(-)

diff --git a/arch/mips/configs/fuloong2e_defconfig b/arch/mips/configs/fulo=
ong2e_defconfig
index 1843468f84a3..00329bb5de5a 100644
--- a/arch/mips/configs/fuloong2e_defconfig
+++ b/arch/mips/configs/fuloong2e_defconfig
@@ -177,7 +177,6 @@ CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
-CONFIG_REISERFS_FS=3Dm
 CONFIG_AUTOFS_FS=3Dy
 CONFIG_FUSE_FS=3Dy
 CONFIG_ISO9660_FS=3Dm
diff --git a/arch/mips/configs/jazz_defconfig b/arch/mips/configs/jazz_defc=
onfig
index fdf374574105..65adb538030d 100644
--- a/arch/mips/configs/jazz_defconfig
+++ b/arch/mips/configs/jazz_defconfig
@@ -70,10 +70,6 @@ CONFIG_FRAMEBUFFER_CONSOLE=3Dy
 # CONFIG_HWMON is not set
 CONFIG_EXT2_FS=3Dm
 CONFIG_EXT3_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dm
 CONFIG_XFS_QUOTA=3Dy
 CONFIG_AUTOFS_FS=3Dm
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemot=
e2f_defconfig
index 83d9a8ff4270..38f17b658421 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -229,9 +229,6 @@ CONFIG_EXT2_FS=3Dm
 CONFIG_EXT3_FS=3Dy
 CONFIG_EXT3_FS_POSIX_ACL=3Dy
 CONFIG_EXT3_FS_SECURITY=3Dy
-CONFIG_REISERFS_FS=3Dm
-CONFIG_REISERFS_PROC_INFO=3Dy
-CONFIG_REISERFS_FS_XATTR=3Dy
 CONFIG_JFS_FS=3Dm
 CONFIG_JFS_POSIX_ACL=3Dy
 CONFIG_XFS_FS=3Dm
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_de=
fconfig
index ae1a7793e810..6f8046024557 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -317,11 +317,6 @@ CONFIG_UIO=3Dm
 CONFIG_UIO_CIF=3Dm
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
-CONFIG_REISERFS_PROC_INFO=3Dy
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_JFS_FS=3Dm
 CONFIG_JFS_POSIX_ACL=3Dy
 CONFIG_JFS_SECURITY=3Dy
diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/malt=
a_kvm_defconfig
index c07e30f63d8b..16a91eeff67f 100644
--- a/arch/mips/configs/malta_kvm_defconfig
+++ b/arch/mips/configs/malta_kvm_defconfig
@@ -323,11 +323,6 @@ CONFIG_UIO=3Dm
 CONFIG_UIO_CIF=3Dm
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
-CONFIG_REISERFS_PROC_INFO=3Dy
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_JFS_FS=3Dm
 CONFIG_JFS_POSIX_ACL=3Dy
 CONFIG_JFS_SECURITY=3Dy
diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/ma=
ltaup_xpa_defconfig
index 0a5701020d3f..264aba29ea4f 100644
--- a/arch/mips/configs/maltaup_xpa_defconfig
+++ b/arch/mips/configs/maltaup_xpa_defconfig
@@ -323,11 +323,6 @@ CONFIG_UIO=3Dm
 CONFIG_UIO_CIF=3Dm
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
-CONFIG_REISERFS_PROC_INFO=3Dy
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_JFS_FS=3Dm
 CONFIG_JFS_POSIX_ACL=3Dy
 CONFIG_JFS_SECURITY=3Dy
diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_de=
fconfig
index 5c5e2186210c..08e1c1f2f4de 100644
--- a/arch/mips/configs/rm200_defconfig
+++ b/arch/mips/configs/rm200_defconfig
@@ -310,10 +310,6 @@ CONFIG_USB_LD=3Dm
 CONFIG_USB_TEST=3Dm
 CONFIG_EXT2_FS=3Dm
 CONFIG_EXT3_FS=3Dy
-CONFIG_REISERFS_FS=3Dm
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dm
 CONFIG_XFS_QUOTA=3Dy
 CONFIG_AUTOFS_FS=3Dm
--=20
2.42.0


