Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1E7A5156
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjIRR4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIRR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:56:51 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8088F114
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695059802; x=1695319002;
        bh=xVm1VEcG0Jf60xZTTkEDLftCnF2hja54aFLZBR2s6LI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=EI+Pcu4xlBcbm7xi8sQefjkznJb+t0yOcTzcR7GCwcbD/Bgq4r8qo9LND/1XqGsYE
         r6bwgq0KMGhpwo86vEFwMizDSnOH1UQyvzTgYeIBKKRT8/fAQ1E3pr9vigrUzsEFxd
         t1lo4Lx5FuoaCczvX8nIumi/sCzC5EouuckLXXUyaAf0EyPox3ZZEorp5NZa1MZSMS
         0AVS5ElXsCWPhdxkZ1DhDodgLLPOt/CbCMV+giomeLSozCHfJxaq0G8uFbg628dNT5
         WxSPpkbjG4CsDDdiuqLFQSptaLQ85qOuR7ZnGHP4dsq3WlNfKqlcn7u/h4AyqSjYEO
         hKTpuS5aqZiPw==
Date:   Mon, 18 Sep 2023 17:56:28 +0000
To:     linux-um@lists.infradead.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net
Subject: [PATCH 1/7] arch: um: remove ReiserFS from defconfig
Message-ID: <20230918175529.19011-2-peter@n8pjl.ca>
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
as part of a defconfig UML kernel.

According to commit eb103a51640e ("reiserfs: Deprecate reiserfs"), the
filesystem is slated to be removed in 2025. Remove it from the defconfig
profiles now, as part of its deprecation process.

Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
Acked-by: Richard Weinberger <richard@nod.at>
---
 arch/um/configs/i386_defconfig   | 1 -
 arch/um/configs/x86_64_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfi=
g
index e543cbac8792..9c9c77f1255a 100644
--- a/arch/um/configs/i386_defconfig
+++ b/arch/um/configs/i386_defconfig
@@ -61,7 +61,6 @@ CONFIG_UML_NET_DAEMON=3Dy
 CONFIG_UML_NET_MCAST=3Dy
 CONFIG_UML_NET_SLIRP=3Dy
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dy
 CONFIG_QUOTA=3Dy
 CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defc=
onfig
index 939cb12318ca..03b10d3f6816 100644
--- a/arch/um/configs/x86_64_defconfig
+++ b/arch/um/configs/x86_64_defconfig
@@ -59,7 +59,6 @@ CONFIG_UML_NET_DAEMON=3Dy
 CONFIG_UML_NET_MCAST=3Dy
 CONFIG_UML_NET_SLIRP=3Dy
 CONFIG_EXT4_FS=3Dy
-CONFIG_REISERFS_FS=3Dy
 CONFIG_QUOTA=3Dy
 CONFIG_AUTOFS_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
--=20
2.42.0


