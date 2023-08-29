Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35EE78C763
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbjH2OVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjH2OVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:21:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857F41B9;
        Tue, 29 Aug 2023 07:21:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F0841F461;
        Tue, 29 Aug 2023 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693318890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yz8becST7wGmzsMDOT9jOFY8YWT6Ar12axqZ8QAijXs=;
        b=FkrErByljgknflatDxOPKH/tIPAWYMzo0czlau8YJAcPY5MHV+bHHb36f84KBwKfwb7Sna
        5CTx+WZRTQov7qEbxKmC976Iaji2Qkpcehbom7entHGpUgMosQMX4QPAzdjuvqXESs7pdM
        cwlQ8pyzOB3wEMTQdMLvTYich87N/0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693318890;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yz8becST7wGmzsMDOT9jOFY8YWT6Ar12axqZ8QAijXs=;
        b=FoCFGEf+3rbIt+IEwxkZ8ySp4XCfx4vWy696e6NK/yBFno+aUpeW+BdPRAcfbJJFciwmOt
        ABuvTeY7ZgHtWXCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14591138E2;
        Tue, 29 Aug 2023 14:21:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kMIXBOr+7WREewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 29 Aug 2023 14:21:30 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 7/7] fbdev/core: Clean up include statements in fbmem.c
Date:   Tue, 29 Aug 2023 16:15:46 +0200
Message-ID: <20230829142109.4521-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829142109.4521-1-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all unnecessary include statements from fbmem.c. Most of
them were for functionality that has meanwhile been moved into
other files.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 1a662a606ba6..fc206755f5f6 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -11,29 +11,12 @@
  * for more details.
  */
 
-#include <linux/module.h>
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/mm.h>
-#include <linux/mman.h>
-#include <linux/vt.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/console.h>
-#include <linux/kmod.h>
-#include <linux/err.h>
-#include <linux/device.h>
-#include <linux/efi.h>
+#include <linux/export.h>
 #include <linux/fb.h>
 #include <linux/fbcon.h>
-#include <linux/mem_encrypt.h>
-#include <linux/pci.h>
 
 #include <video/nomodeset.h>
-#include <video/vga.h>
 
 #include "fb_internal.h"
 
-- 
2.41.0

