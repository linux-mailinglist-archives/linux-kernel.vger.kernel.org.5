Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198157E9B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjKMLzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjKMLzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:55:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3BDD6D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:55:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43F621F6E6;
        Mon, 13 Nov 2023 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699876510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/5kYUV1rEFjHNEaAdgspwkitSoq5USt+2BcNwPIYOiU=;
        b=Yg/aw22Nos0HVsCb5HEK5E32aSCmR06EFnT4UpNQTWPjFJ7uQbsNMaZf+hEzbZ2bqmWtKC
        uv1odWRywV3JDpiZvxhPzfHu6gMJWNgT7BiYbEYeSlc267cU0l3OeZwXOZE3gAAIHehEo2
        HkG78RkdvantjYAuXd3CX/3KFlFei4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699876510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/5kYUV1rEFjHNEaAdgspwkitSoq5USt+2BcNwPIYOiU=;
        b=x8udOIrW2UzPgkn0PE4X5AnRwBJXxDyIFtjNi4s5+TctjDfGMmnBKr29duhBys4vMbXFnG
        sec97xrJuw4HAOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC15213398;
        Mon, 13 Nov 2023 11:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JL/9N50OUmVcVwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 13 Nov 2023 11:55:09 +0000
Date:   Mon, 13 Nov 2023 12:55:08 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     dri-devel@lists.freedesktop.org
Cc:     Sui Jingfeng <sui.jingfeng@linux.dev>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/loongson: Add platform dependency
Message-ID: <20231113125508.4dc755e8@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only offer the Loongson DRM driver as an option on platforms where
it makes sense.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
Changes since v1:
* Use the architecture dependencies suggested by Sui Jingfeng.

 drivers/gpu/drm/loongson/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-6.6.orig/drivers/gpu/drm/loongson/Kconfig
+++ linux-6.6/drivers/gpu/drm/loongson/Kconfig
@@ -3,6 +3,7 @@
 config DRM_LOONGSON
 	tristate "DRM support for Loongson Graphics"
 	depends on DRM && PCI && MMU
+	depends on LOONGARCH || MIPS || COMPILE_TEST
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select I2C


-- 
Jean Delvare
SUSE L3 Support
