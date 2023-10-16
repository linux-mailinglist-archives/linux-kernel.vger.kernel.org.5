Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB3D7C9F77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJPG2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjJPG2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:28:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46009F7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:28:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D6A6F1FEAB;
        Mon, 16 Oct 2023 06:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697437726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rNX0BHA06/8Nsdx4Ml8n47rtnGq7y7Ylo5Rine36zkk=;
        b=ed1mpfG/OdNtnERvr+u0c/5UTTxcVdh9dCockRC8xxBjDyYoXSxtc546veqFCMPuApPqyY
        yQFuoDELuRLH4GV7uBNq23liBMDD8kapEMMsmP9CFILss5qIpbHjsVEokdBaq9Nn/lrxRi
        f1Q7JXSosDLutEXExiXohxy2p2r/7Tk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AAE61138EF;
        Mon, 16 Oct 2023 06:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id guxNKB7YLGWMQQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 Oct 2023 06:28:46 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH 2/7] xen/events: remove unused functions
Date:   Mon, 16 Oct 2023 08:28:26 +0200
Message-Id: <20231016062831.20630-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231016062831.20630-1-jgross@suse.com>
References: <20231016062831.20630-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.10
X-Spamd-Result: default: False [-3.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[5];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[11.11%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users of xen_irq_from_pirq() and xen_set_irq_pending().

Remove those functions.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/events/events_base.c | 30 ------------------------------
 include/xen/events.h             |  4 ----
 2 files changed, 34 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 0e458b1c0c8c..1d797dd85d0e 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1165,29 +1165,6 @@ int xen_destroy_irq(int irq)
 	return rc;
 }
 
-int xen_irq_from_pirq(unsigned pirq)
-{
-	int irq;
-
-	struct irq_info *info;
-
-	mutex_lock(&irq_mapping_update_lock);
-
-	list_for_each_entry(info, &xen_irq_list_head, list) {
-		if (info->type != IRQT_PIRQ)
-			continue;
-		irq = info->irq;
-		if (info->u.pirq.pirq == pirq)
-			goto out;
-	}
-	irq = -1;
-out:
-	mutex_unlock(&irq_mapping_update_lock);
-
-	return irq;
-}
-
-
 int xen_pirq_from_irq(unsigned irq)
 {
 	return pirq_from_irq(irq);
@@ -2026,13 +2003,6 @@ void xen_clear_irq_pending(int irq)
 		event_handler_exit(info);
 }
 EXPORT_SYMBOL(xen_clear_irq_pending);
-void xen_set_irq_pending(int irq)
-{
-	evtchn_port_t evtchn = evtchn_from_irq(irq);
-
-	if (VALID_EVTCHN(evtchn))
-		set_evtchn(evtchn);
-}
 
 bool xen_test_irq_pending(int irq)
 {
diff --git a/include/xen/events.h b/include/xen/events.h
index 23932b0673dc..a129cafa80ed 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -88,7 +88,6 @@ void xen_irq_resume(void);
 
 /* Clear an irq's pending state, in preparation for polling on it */
 void xen_clear_irq_pending(int irq);
-void xen_set_irq_pending(int irq);
 bool xen_test_irq_pending(int irq);
 
 /* Poll waiting for an irq to become pending.  In the usual case, the
@@ -122,9 +121,6 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 /* De-allocates the above mentioned physical interrupt. */
 int xen_destroy_irq(int irq);
 
-/* Return irq from pirq */
-int xen_irq_from_pirq(unsigned pirq);
-
 /* Return the pirq allocated to the irq. */
 int xen_pirq_from_irq(unsigned irq);
 
-- 
2.35.3

