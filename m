Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5531F805380
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442177AbjLELvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347030AbjLELvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:51:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB7812C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:51:26 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A5D141FB87;
        Tue,  5 Dec 2023 11:51:24 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 77ACD138FF;
        Tue,  5 Dec 2023 11:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id cYz3G7wOb2WSUwAAn2gu4w
        (envelope-from <jgross@suse.com>); Tue, 05 Dec 2023 11:51:24 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, Pry Mar <pryorm09@gmail.com>
Subject: [PATCH] xen: update PV-device interface headers
Date:   Tue,  5 Dec 2023 12:51:21 +0100
Message-Id: <20231205115121.11627-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of jgross@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=jgross@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         BROKEN_CONTENT_TYPE(1.50)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[suse.com,kernel.org,epam.com,lists.xenproject.org,gmail.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: A5D141FB87
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Xen PV-device interface headers in order to avoid undefined
behavior with flexible arrays being defined with one array element.

Reported-by: Pry Mar <pryorm09@gmail.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 include/xen/interface/io/displif.h | 2 +-
 include/xen/interface/io/ring.h    | 2 +-
 include/xen/interface/io/sndif.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/xen/interface/io/displif.h b/include/xen/interface/io/displif.h
index 18417b017869..60e42d3b760e 100644
--- a/include/xen/interface/io/displif.h
+++ b/include/xen/interface/io/displif.h
@@ -537,7 +537,7 @@ struct xendispl_dbuf_create_req {
 
 struct xendispl_page_directory {
 	grant_ref_t gref_dir_next_page;
-	grant_ref_t gref[1]; /* Variable length */
+	grant_ref_t gref[];
 };
 
 /*
diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index ba4c4274b714..4fef1efcdcab 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -95,7 +95,7 @@ struct __name##_sring {                                                 \
     RING_IDX req_prod, req_event;                                       \
     RING_IDX rsp_prod, rsp_event;                                       \
     uint8_t __pad[48];                                                  \
-    union __name##_sring_entry ring[1]; /* variable-length */           \
+    union __name##_sring_entry ring[];                                  \
 };                                                                      \
                                                                         \
 /* "Front" end's private variables */                                   \
diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
index 445657cdb1de..b818517588b5 100644
--- a/include/xen/interface/io/sndif.h
+++ b/include/xen/interface/io/sndif.h
@@ -659,7 +659,7 @@ struct xensnd_open_req {
 
 struct xensnd_page_directory {
 	grant_ref_t gref_dir_next_page;
-	grant_ref_t gref[1]; /* Variable length */
+	grant_ref_t gref[];
 };
 
 /*
-- 
2.35.3

