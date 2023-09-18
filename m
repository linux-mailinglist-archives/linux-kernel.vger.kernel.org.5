Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E97A515C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjIRR5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjIRR5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:57:08 -0400
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8E9121
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695059821; x=1695319021;
        bh=Yd0bvX5251WFX63UM6X0Z6EzVJZWkj+aXTGkJOfZu6U=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ofXoPLuUMhK4JdeUS4vvRz4GuIIRQp6MeRZvZbO+5A/X1NSr8my9m2nCu6xSqbkrK
         1yoMNxmQBnzHy5+KBI1I6WAz1ddCRbzHn8bdzxUgVGCkZtCnFvRUcWmcgm+iiWvzqH
         l9NOXeSD76DjzcoBlXur5aqWetOAxdmv7J2LEe1FVZwKdRMsNGg14jX4tZP6WLaHm4
         XA0T7LEIid/4w95Ze2bgM29aezmymfggU3oje3HtoC3Ln4t8qLUlAY93yQ4CwSMK6W
         GOaOKkb5UY0n3MZWMamAP/ypGPRtTRbdbz3AaBLfSlMiy5CKFN191xY9zGVWOpFe/t
         h9qMbkrpvsVPw==
Date:   Mon, 18 Sep 2023 17:56:55 +0000
To:     linux-sh@vger.kernel.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, jack@suse.cz,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arch: sh: remove ReiserFS from defconfig
Message-ID: <20230918175529.19011-4-peter@n8pjl.ca>
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
 arch/sh/configs/landisk_defconfig | 1 -
 arch/sh/configs/titan_defconfig   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_de=
fconfig
index 541082090918..af1ab25227e3 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -94,7 +94,6 @@ CONFIG_USB_SISUSBVGA=3Dm
 CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_REISERFS_FS=3Dy
 CONFIG_ISO9660_FS=3Dm
 CONFIG_MSDOS_FS=3Dy
 CONFIG_VFAT_FS=3Dy
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defcon=
fig
index 871092753591..50e378adc4c5 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -221,7 +221,6 @@ CONFIG_EXT2_FS=3Dy
 CONFIG_EXT3_FS=3Dy
 # CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
 # CONFIG_EXT3_FS_XATTR is not set
-CONFIG_REISERFS_FS=3Dm
 CONFIG_XFS_FS=3Dm
 CONFIG_FUSE_FS=3Dm
 CONFIG_ISO9660_FS=3Dm
--=20
2.42.0


