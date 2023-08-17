Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5490777F6B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350962AbjHQMsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350970AbjHQMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:48:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F402D62
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692276458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=27yOpoFS3kI6hX/wnm/PheNvRJtvVh2pmNTKVNiCv/U=;
        b=ZOkRhSn/zCJWcaEisK/qx2UpX15Sx4auUstXw/GHstn97CqFEYjaHyX/RWMZJPuFjdKRyH
        SfQYuIIfvAcwxfIToW8nvpceMQb26XWRF/Dz0rd0RApTik9n7gh+Mn3C5hpXiffsNiKgCf
        49aiFf9Npte/MwMxJw5zZuovI9hiYEA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-7YW3IUyoPI-PZ0oQ_a9gBw-1; Thu, 17 Aug 2023 08:47:37 -0400
X-MC-Unique: 7YW3IUyoPI-PZ0oQ_a9gBw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76d70d17e58so222812085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692276457; x=1692881257;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27yOpoFS3kI6hX/wnm/PheNvRJtvVh2pmNTKVNiCv/U=;
        b=F3AGadGLI5yFVh6LiIUYcRfBs7J80CI8C3tqsPKUc15GiD57KfkKbtShPOWz7qjcCJ
         Pf6E6UfmdfgihJbis1yXTA+KuJx3gPy73y1l3ASsK96xehGKEiKRn4IJWO/GGy9fUc7M
         AD5EzclZGxoMH5LljUzEKf9UBzVsT4Kx2l4uqfVNY5HO33hV3aJWJvbfNQ0MOJjBq0qx
         /nD2UtR3VpJ6gLFh5UolKkSk1Ij4Y8X+tm9v3zjUPPf6GytqVtakd6q80S3FHQ7iBAZf
         wQPVcTHHQs36c+p7ewbwadKNzpbHlelTbrDoSyeeXsnSlTrF36moYofXL4UaqT3nAhCD
         /qew==
X-Gm-Message-State: AOJu0YxWwvGg0UOwFyzXonb1brNiEkgl7o0HD3qybdAsSriB1SgcdywL
        YduIyimu6e8wXblK0lvDHbar2LrkRrtZHBML7ry6+l4Yw34HRcfazkEdoFxtUor4tTpLI2PgtWy
        IGaWTzMJvbU3wlglVpCCEUQLd
X-Received: by 2002:a05:620a:45a6:b0:76c:b43e:8f1d with SMTP id bp38-20020a05620a45a600b0076cb43e8f1dmr5898063qkb.25.1692276456908;
        Thu, 17 Aug 2023 05:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWut8Xykqo3qs/+z94GUgQ9h0MTPjPde/T7jPTNAC5kZOXlJnFvxDHlaQ9P4SPc1KB12mEfA==
X-Received: by 2002:a05:620a:45a6:b0:76c:b43e:8f1d with SMTP id bp38-20020a05620a45a600b0076cb43e8f1dmr5898038qkb.25.1692276456669;
        Thu, 17 Aug 2023 05:47:36 -0700 (PDT)
Received: from fedora ([174.89.37.104])
        by smtp.gmail.com with ESMTPSA id j7-20020a37c247000000b0076cc4610d0asm5128353qkm.85.2023.08.17.05.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:47:36 -0700 (PDT)
Date:   Thu, 17 Aug 2023 08:47:26 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: cgroup: fix test_kmem_memcg_deletion kernel
 mem check
Message-ID: <jnyjalhg43mdnn6su2a2kmwzqasdyjsfdvipim2i2hvqo7w6y2@st57sbo4bkxf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The combination of using slab, anon, file, kernel_stack, and percpu is
not accurate for total kernel memory utilization. Checking kernel within
memory.stat provides a more accurate measurement.

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 v1: https://lore.kernel.org/all/eex2vdlg4ow2j5bybmav73nbfzuspkk4zobnk7svua4jaypqb5@7ie6e4mci43t/

 tools/testing/selftests/cgroup/test_kmem.c | 25 +++++-----------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index ed2e50bb1e76..3ef979ee0edf 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -166,7 +166,7 @@ static int cg_run_in_subcgroups(const char *parent,
  */
 static int test_kmem_memcg_deletion(const char *root)
 {
-	long current, slab, anon, file, kernel_stack, pagetables, percpu, sock, sum;
+	long current, kernel;
 	int ret = KSFT_FAIL;
 	char *parent;
 
@@ -184,30 +184,15 @@ static int test_kmem_memcg_deletion(const char *root)
 		goto cleanup;
 
 	current = cg_read_long(parent, "memory.current");
-	slab = cg_read_key_long(parent, "memory.stat", "slab ");
-	anon = cg_read_key_long(parent, "memory.stat", "anon ");
-	file = cg_read_key_long(parent, "memory.stat", "file ");
-	kernel_stack = cg_read_key_long(parent, "memory.stat", "kernel_stack ");
-	pagetables = cg_read_key_long(parent, "memory.stat", "pagetables ");
-	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
-	sock = cg_read_key_long(parent, "memory.stat", "sock ");
-	if (current < 0 || slab < 0 || anon < 0 || file < 0 ||
-	    kernel_stack < 0 || pagetables < 0 || percpu < 0 || sock < 0)
+	kernel = cg_read_key_long(parent, "memory.stat", "kernel ");
+	if (current < 0 || kernel < 0)
 		goto cleanup;
 
-	sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
-	if (abs(sum - current) < MAX_VMSTAT_ERROR) {
+	if (abs(kernel - current) < MAX_VMSTAT_ERROR) {
 		ret = KSFT_PASS;
 	} else {
 		printf("memory.current = %ld\n", current);
-		printf("slab + anon + file + kernel_stack = %ld\n", sum);
-		printf("slab = %ld\n", slab);
-		printf("anon = %ld\n", anon);
-		printf("file = %ld\n", file);
-		printf("kernel_stack = %ld\n", kernel_stack);
-		printf("pagetables = %ld\n", pagetables);
-		printf("percpu = %ld\n", percpu);
-		printf("sock = %ld\n", sock);
+		printf("kernel = %ld\n", kernel);
 	}
 
 cleanup:
-- 
2.41.0

