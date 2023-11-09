Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C83B7E6DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbjKIPn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbjKIPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909853845
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699544466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldTnN6NaoKpn3Pzj4ymAXo4AbMSJji+PzTFvbDmK2dY=;
        b=czST2gLaPtZdZoqvP3FQ+C7aE1S19alW13A4fUt4CTj8LDDuNj6DFahfU1r01Nln/FMk0q
        SzLguT1tyRnbnBoW5aoMG40qxobPPGs7MCdoqM7GMxBn/VQYnygXgCmz0IGE8/m+1ngmuY
        27O0y7MVjuuwmgXrh6xzM6EHSh+ew4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-X00qzuiiMfOdHIKjsJvICg-1; Thu, 09 Nov 2023 10:40:58 -0500
X-MC-Unique: X00qzuiiMfOdHIKjsJvICg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAECA81229D;
        Thu,  9 Nov 2023 15:40:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 17591202701E;
        Thu,  9 Nov 2023 15:40:53 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 25/41] afs: Remove the unimplemented afs_cmp_addr_list()
Date:   Thu,  9 Nov 2023 15:39:48 +0000
Message-ID: <20231109154004.3317227-26-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

