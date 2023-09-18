Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA2D7A5168
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjIRR6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjIRR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:57:55 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C1819B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695059863; x=1695319063;
        bh=I+KgQHw8hJyaw6uzs72VPeTNHvbX24xU2dGCApKFeAY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ir6Sf8pqh4NJ2RuUSkDzy7LaLnRMiRCTJ/s7ocycKiKrNHTSWPDItcTujRIOkbkFX
         Vk2pX+enOpdPlTlwQ6kqr6dokgxl3rBcUsv8ZxSBgzk3xrHyztOOl+vHxIBiBpqwuK
         LNkszEU4TBgIaAyd82vnrU7TCjn6/ZRTftFdsyrpGNsHDe2toYRLoZL973gcdlbidb
         libz0mgCxFQXnVX6BxCZLgdsbCcgsCy5UN3ebKJqxjLL6lhF6yBpPRpKLqmU8gH8cS
         Z1NkSuBA0LZ4gJPN2/8nVfRbWUvoc7ZNc9vWb6T4nc7iWqU19hL/OKcL65Zl+1VEs9
         soYUNb1hqOoIA==
Date:   Mon, 18 Sep 2023 17:57:37 +0000
To:     linux-arm-kernel@lists.infradead.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk
Subject: [PATCH 6/7] arch: arm: remove ReiserFS from defconfig
Message-ID: <20230918175529.19011-7-peter@n8pjl.ca>
In-Reply-To: <20230918175529.19011-1-peter@n8pjl.ca>
References: <20230918175529.19011-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ReiserFS has been deprecated for a year and a half, yet is still built
as part of a defconfig kernel.

According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
filesystem is slated to be removed in 2025. Remove it from the pxa=20
defconfig profile now, as part of its deprecation process.

Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
---
 arch/arm/configs/pxa_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfi=
g
index 23c131b0854b..607420f7ea27 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -584,10 +584,6 @@ CONFIG_EXT2_FS_SECURITY=3Dy
 CONFIG_EXT3_FS=3Dy
 CONFIG_EXT3_FS_POSIX_ACL=3Dy
 CONFIG_EXT3_FS_SECURITY=3Dy
-CONFIG_REISERFS_FS=3Dm
-CONFIG_REISERFS_FS_XATTR=3Dy
-CONFIG_REISERFS_FS_POSIX_ACL=3Dy
-CONFIG_REISERFS_FS_SECURITY=3Dy
 CONFIG_XFS_FS=3Dm
 CONFIG_AUTOFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
--=20
2.42.0


