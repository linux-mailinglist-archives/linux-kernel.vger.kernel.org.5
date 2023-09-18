Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E27A5159
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjIRR47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIRR46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:56:58 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A830FA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695059810; x=1695319010;
        bh=yq9UeYmObYCyPMoyaq+syuS2UL6T+9qzJZIQZU7xrf8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=isfSMEg+MN3XaiC8OKEvlCwLd382bQjD0+6gN0cdEJpc2AY3GpGF0C07JPDj184xi
         AzxEyp5A+AzfT8gJ+zDcTjS7FgaOb46a3pLSxAQj9rrY7AYr24obTzqcJ9V+rAHUnk
         JhU02KE7HE2m/x4xcmM0g1dDH+SZ5cMJ9Hj7g22MNBpDkFzazSpN+bpcethD6JNRMl
         FsmndLyZJ3EOC98vDNYIxXnwUtAbD0thcRgRRiDCyTizuaioyQjEt/1L+6DHDqths1
         CeEdzRdMch2+CVBFX2JSFeNa2fL73vztsawH0BWsrCrqPwnNzENAmzF8/kmJPj7f8o
         SqQwDGJI+7P8g==
Date:   Mon, 18 Sep 2023 17:56:43 +0000
To:     linuxppc-dev@lists.ozlabs.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] arch: powerpc: remove ReiserFS from defconfig
Message-ID: <20230918175529.19011-3-peter@n8pjl.ca>
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/powerpc/configs/44x/sam440ep_defconfig | 1 -
 arch/powerpc/configs/g5_defconfig           | 4 ----
 arch/powerpc/configs/ppc64e_defconfig       | 4 ----
 arch/powerpc/configs/ppc6xx_defconfig       | 5 -----
 4 files changed, 14 deletions(-)

diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/con=
figs/44x/sam440ep_defconfig
index 51499ee6366b..2479ab62d12f 100644
--- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -78,7 +78,6 @@ CONFIG_EXT2_FS_XATTR=3Dy
 CONFIG_EXT2_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS=3Dy
 CONFIG_AUTOFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dy
 CONFIG_JOLIET=3Dy
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_de=
fconfig
index 71d9d112c0b6..9215bed53291 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -202,10 +202,6 @@ CONFIG_EXT2_FS_SECURITY=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
-CONFIG_REISERFS_FS=3Dy
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dm
 CONFIG_XFS_POSIX_ACL=3Dy
 CONFIG_FS_DAX=3Dy
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/p=
pc64e_defconfig
index 624c371ffcc3..4c05f4e4d505 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -175,10 +175,6 @@ CONFIG_EXT2_FS_SECURITY=3Dy
 CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
-CONFIG_REISERFS_FS=3Dy
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_JFS_FS=3Dy
 CONFIG_JFS_POSIX_ACL=3Dy
 CONFIG_JFS_SECURITY=3Dy
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/p=
pc6xx_defconfig
index eaf3273372a9..f279703425d4 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -954,11 +954,6 @@ CONFIG_EXT4_FS=3Dy
 CONFIG_EXT4_FS_POSIX_ACL=3Dy
 CONFIG_EXT4_FS_SECURITY=3Dy
 CONFIG_JBD2_DEBUG=3Dy
-CONFIG_REISERFS_FS=3Dm
-CONFIG_REISERFS_PROC_INFO=3Dy
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_JFS_FS=3Dm
 CONFIG_JFS_POSIX_ACL=3Dy
 CONFIG_JFS_SECURITY=3Dy
--=20
2.42.0


