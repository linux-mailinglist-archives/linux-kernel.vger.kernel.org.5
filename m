Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0707811392
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379303AbjLMNvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441914AbjLMNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:50:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37FB10F4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702475446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldTnN6NaoKpn3Pzj4ymAXo4AbMSJji+PzTFvbDmK2dY=;
        b=S9OMfbcklWnYkUbRUPqPSOG4l9dgrgI6UveZm5iUduvXSHnIUAASbmd0Wt60YyVmZFtzV7
        +8PMQVAmWS/Tsj3kZMWocVEXg2uB3d5A/oQ+JVHLwmSDW2bM031/9DlrB9MPSGjqa8bp0/
        TMEvSLxaErlwQEfX9pgUgrN5PKvPdwI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-YEpkbhlmOCyZaM5FVkfGtA-1; Wed,
 13 Dec 2023 08:50:44 -0500
X-MC-Unique: YEpkbhlmOCyZaM5FVkfGtA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EDBD29AC03C;
        Wed, 13 Dec 2023 13:50:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C56791C060B1;
        Wed, 13 Dec 2023 13:50:42 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/40] afs: Remove the unimplemented afs_cmp_addr_list()
Date:   Wed, 13 Dec 2023 13:49:45 +0000
Message-ID: <20231213135003.367397-24-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove afs_cmp_addr_list() as it was never implemented.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/addr_list.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/afs/addr_list.c b/fs/afs/addr_list.c
index 18c286efa3a5..6d42f85c6be5 100644
--- a/fs/afs/addr_list.c
+++ b/fs/afs/addr_list.c
@@ -244,19 +244,6 @@ struct afs_vlserver_list *afs_parse_text_addrs(struct afs_net *net,
 	return ERR_PTR(ret);
 }
 
-/*
- * Compare old and new address lists to see if there's been any change.
- * - How to do this in better than O(Nlog(N)) time?
- *   - We don't really want to sort the address list, but would rather take the
- *     list as we got it so as not to undo record rotation by the DNS server.
- */
-#if 0
-static int afs_cmp_addr_list(const struct afs_addr_list *a1,
-			     const struct afs_addr_list *a2)
-{
-}
-#endif
-
 /*
  * Perform a DNS query for VL servers and build a up an address list.
  */

