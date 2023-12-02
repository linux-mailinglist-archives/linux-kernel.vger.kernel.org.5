Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3C7801E83
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 21:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjLBUej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 15:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 15:34:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A21C1
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 12:34:44 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F055A1FDC5;
        Sat,  2 Dec 2023 20:34:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B867E13A23;
        Sat,  2 Dec 2023 20:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id M60RK+KUa2W6KQAAD6G6ig
        (envelope-from <jdelvare@suse.de>); Sat, 02 Dec 2023 20:34:42 +0000
Date:   Sat, 2 Dec 2023 21:34:41 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND] drm/logicvc: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20231202213441.62397e81@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: ++++++++++
X-Spam-Score: 10.03
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of jdelvare@suse.de) smtp.mailfrom=jdelvare@suse.de;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none)
X-Rspamd-Queue-Id: F055A1FDC5
X-Spamd-Result: default: False [10.03 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_SPF_SOFTFAIL(4.60)[~all];
         RCPT_COUNT_FIVE(0.00)[5];
         HAS_ORG_HEADER(0.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-0.999];
         NEURAL_SPAM_LONG(3.50)[1.000];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.06)[60.83%];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
Already sent on: 2022-11-21, 2023-01-27

This is one of the only 4 remaining occurrences of this deprecated
construct.

 drivers/gpu/drm/logicvc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-6.6.orig/drivers/gpu/drm/logicvc/Kconfig
+++ linux-6.6/drivers/gpu/drm/logicvc/Kconfig
@@ -1,7 +1,7 @@
 config DRM_LOGICVC
 	tristate "LogiCVC DRM"
 	depends on DRM
-	depends on OF || COMPILE_TEST
+	depends on OF
 	select DRM_KMS_HELPER
 	select DRM_KMS_DMA_HELPER
 	select DRM_GEM_DMA_HELPER


-- 
Jean Delvare
SUSE L3 Support
