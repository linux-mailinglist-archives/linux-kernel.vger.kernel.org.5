Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E017C8D71
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjJMTE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F3DA9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697223851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4XvnTft2MmJ8VY609+be7Cy1Q085UedMhCWzkSGYTRU=;
        b=TBtcE9QH46JvR4poJuijN3KH005HjZnmH6Yil2GQTMKAAt+yMJBG8hJSunHnWgpc9atTxk
        k0UMwY6uClBge74NH9BwJvq8FSBOzPlhzZrLVZdUlvNQIfUCZMZ7I7UYqGCe00LtDlUdQm
        WYhxVCbaGsItWBjPHhiyjND/WaYuby8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-eVID_ZQ_N8aIESBG-T1o-A-1; Fri, 13 Oct 2023 15:04:07 -0400
X-MC-Unique: eVID_ZQ_N8aIESBG-T1o-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D0CC801E62;
        Fri, 13 Oct 2023 19:04:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.33.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D69472157F5A;
        Fri, 13 Oct 2023 19:04:06 +0000 (UTC)
From:   Audra Mitchell <audra@redhat.com>
To:     linux-mm@kvack.org
Cc:     raquini@redhat.com, akpm@linux-foundation.org, djakov@kernel.org,
        vbabka@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] tools/mm: Update the usage output to be more organized
Date:   Fri, 13 Oct 2023 15:03:49 -0400
Message-ID: <20231013190350.579407-6-audra@redhat.com>
In-Reply-To: <20231013190350.579407-1-audra@redhat.com>
References: <20231013190350.579407-1-audra@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Organize the usage options alphabetically and improve the description
of some options. Also separate the more complicated cull options from
the single use compare options.

Signed-off-by: Audra Mitchell <audra@redhat.com>
---
 tools/mm/page_owner_sort.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/mm/page_owner_sort.c b/tools/mm/page_owner_sort.c
index 5a260096ebaa..e1f264444342 100644
--- a/tools/mm/page_owner_sort.c
+++ b/tools/mm/page_owner_sort.c
@@ -634,19 +634,26 @@ static void print_allocator(FILE *out, int allocator)
 static void usage(void)
 {
 	printf("Usage: ./page_owner_sort [OPTIONS] <input> <output>\n"
-		"-m\t\tSort by total memory.\n"
-		"-s\t\tSort by the stack trace.\n"
-		"-t\t\tSort by times (default).\n"
-		"-p\t\tSort by pid.\n"
-		"-P\t\tSort by tgid.\n"
-		"-n\t\tSort by task command name.\n"
-		"-a\t\tSort by memory allocate time.\n"
-		"-d\t\tPrint debug information.\n"
-		"--pid <pidlist>\tSelect by pid. This selects the information of blocks whose process ID numbers appear in <pidlist>.\n"
-		"--tgid <tgidlist>\tSelect by tgid. This selects the information of blocks whose Thread Group ID numbers appear in <tgidlist>.\n"
-		"--name <cmdlist>\n\t\tSelect by command name. This selects the information of blocks whose command name appears in <cmdlist>.\n"
-		"--cull <rules>\tCull by user-defined rules.<rules> is a single argument in the form of a comma-separated list with some common fields predefined\n"
-		"--sort <order>\tSpecify sort order as: [+|-]key[,[+|-]key[,...]]\n"
+		"-a\t\t\tSort by memory allocation time.\n"
+		"-m\t\t\tSort by total memory.\n"
+		"-n\t\t\tSort by task command name.\n"
+		"-p\t\t\tSort by pid.\n"
+		"-P\t\t\tSort by tgid.\n"
+		"-s\t\t\tSort by the stacktrace.\n"
+		"-t\t\t\tSort by number of times record is seen (default).\n\n"
+		"--pid <pidlist>\t\tSelect by pid. This selects the information"
+		" of\n\t\t\tblocks whose process ID numbers appear in <pidlist>.\n"
+		"--tgid <tgidlist>\tSelect by tgid. This selects the information"
+		" of\n\t\t\tblocks whose Thread Group ID numbers appear in "
+		"<tgidlist>.\n"
+		"--name <cmdlist>\tSelect by command name. This selects the"
+		" information\n\t\t\tof blocks whose command name appears in"
+		" <cmdlist>.\n"
+		"--cull <rules>\t\tCull by user-defined rules. <rules> is a "
+		"single\n\t\t\targument in the form of a comma-separated list "
+		"with some\n\t\t\tcommon fields predefined (pid, tgid, comm, "
+		"stacktrace, allocator)\n"
+		"--sort <order>\t\tSpecify sort order as: [+|-]key[,[+|-]key[,...]]\n"
 	);
 }
 
-- 
2.41.0

