Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F277704F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjHDPif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjHDPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3790A171D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691163465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sWUCadNhtS5nrUCHR//9fr6i9W+VBU3reP6ArzIMKD4=;
        b=IXgb4SEGI77dtLPfazeZyb8o4OIt5EX0rKx3Ymw8vmT0cOtpzk9FCHwKofKSPUKGPqgo27
        AbpEKS5x1RPkIClfAlQhHrr97ZgQkXQ4njrVL7+Qoxg76PVUu1rlCT1jcAbba/SMeaNq4r
        Z5zPk3k7jncUHKJ+AP1XGANyEmFneYA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-xTAwajXsO0OuR_KHSaGnUQ-1; Fri, 04 Aug 2023 11:37:44 -0400
X-MC-Unique: xTAwajXsO0OuR_KHSaGnUQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-763c36d4748so235191085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691163464; x=1691768264;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWUCadNhtS5nrUCHR//9fr6i9W+VBU3reP6ArzIMKD4=;
        b=AlIZ6j7ISvAzO5rooCjhsJk2M4++EwKlPC/ZJRePnTr2YvzHBLl9ZBU5w1wNyk4l7c
         nDUWVlad9uqqawFwF9kUqgBZKJ9OL7L1gXDWlvwkrXNKfQpUDh3u2qr1lSRQUX5ERLU3
         5BajKrIPZ6+8HZvEiWQMwvKDH273cZhIaK5zN0d3qVKIxbEQMrWs9ecsY7QuQK3qV+jz
         6s3EzptRiv9yVEA+Ofcw+TeVQl3umbU4cHl+aUajd585HzyWJakP5KRyj+FRl24cY/Q0
         tjf/H1Nm6zHU+vKkFIqv1Sf0DvYCtOhp7Vj5q3ZWNrI2fX8SPQ9MLwhSS96dotLGr8h0
         Ew0A==
X-Gm-Message-State: AOJu0Yw1clFU8+qAfCKWQdWYM+MN6663XSPAEsPeG+SUDUWeOi8AoByJ
        F/I4qQb67thOMHpSPWSyTqeq0wIonBWb8y6BpCf9W2EGKgbSPOTZ3O/Sm36EW7r6P7LYpiSpMjh
        lOfoBLIkgndBTBrCdjnWYa9j0
X-Received: by 2002:a05:620a:4116:b0:76c:9884:4dce with SMTP id j22-20020a05620a411600b0076c98844dcemr2754751qko.63.1691163463729;
        Fri, 04 Aug 2023 08:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESeoIlDIDyx7XJyX0j8/1BX2ln6R1WxXabBDCtJd/UHzVFZ/vkvY/Etd4WOnHu0SSFDWBpIQ==
X-Received: by 2002:a05:620a:4116:b0:76c:9884:4dce with SMTP id j22-20020a05620a411600b0076c98844dcemr2754733qko.63.1691163463425;
        Fri, 04 Aug 2023 08:37:43 -0700 (PDT)
Received: from fedora ([174.89.37.244])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a124400b0076c71c1d2f5sm723985qkl.34.2023.08.04.08.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:37:42 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:37:33 -0400
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
Subject: [PATCH] selftests: cgroup: fix test_kmem_memcg_deletion false
 positives
Message-ID: <edpx3ejic2cxolhoynxvwal2i4a35akopg6hshcfxker6oxcn7@l32pzfyucgec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test allocates dcache inside a cgroup, then destroys the cgroups and
then checks the sanity of numbers on the parent level. The reason it
fails is because dentries are freed with an RCU delay - a debugging
sleep shows that usage drops as expected shortly after.

Insert a 1s sleep after completing the cgroup creation/deletions. This
should be good enough, assuming that machines running those tests are
otherwise not very busy. This commit is directly inspired by Johannes
over at the link below.

Link: https://lore.kernel.org/all/20230801135632.1768830-1-hannes@cmpxchg.org/

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
 tools/testing/selftests/cgroup/test_kmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 67cc0182058d..7ac384bbfdd5 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -183,6 +183,9 @@ static int test_kmem_memcg_deletion(const char *root)
 	if (cg_run_in_subcgroups(parent, alloc_kmem_smp, NULL, 100))
 		goto cleanup;
 
+	/* wait for RCU freeing */
+	sleep(1);
+
 	current = cg_read_long(parent, "memory.current");
 	slab = cg_read_key_long(parent, "memory.stat", "slab ");
 	anon = cg_read_key_long(parent, "memory.stat", "anon ");
-- 
2.41.0

