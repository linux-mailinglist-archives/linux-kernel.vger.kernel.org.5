Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5A3797BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbjIGS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjIGS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:27:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6861A8;
        Thu,  7 Sep 2023 11:26:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05DBA21864;
        Thu,  7 Sep 2023 08:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694076852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4B1OE7yKWqlV3goj2C/YTh/xuKA45lLwm9oARh4/H4=;
        b=PwNT75lztJ5BNelcSODug76J/bAGpitxTDk7mBKjhVutw7JDmHB25xN1HQDLuPRrA6S/rN
        nmCZgtdGHr/DNjWYk+aa3BW40//x6z8+a478JsXq6NmFpSVpCTyMrQnPU4DqrI4vezPP/U
        U85XMyvs0ZJgY2phMIkbjMcGFopM/LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694076852;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4B1OE7yKWqlV3goj2C/YTh/xuKA45lLwm9oARh4/H4=;
        b=0t0X/KyJEEcLFPyvD61i/HcmKEjl1DePe4g9Om0D5aoG0cPkyQos0RE9BPXfRIy4ypnsWL
        xBIa7X5qIHFmnPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD60C138FA;
        Thu,  7 Sep 2023 08:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WJQoMbOP+WT6JgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 07 Sep 2023 08:54:11 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 7/7] fbdev/core: Clean up include statements in fbmem.c
Date:   Thu,  7 Sep 2023 10:52:06 +0200
Message-ID: <20230907085408.9354-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907085408.9354-1-tzimmermann@suse.de>
References: <20230907085408.9354-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all unnecessary include statements from fbmem.c. Most of
them were for functionality that has meanwhile been moved into
other files.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Javier Martinez Canillas <javierm@redhat.com>
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
2.42.0

