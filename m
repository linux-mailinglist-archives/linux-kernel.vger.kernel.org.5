Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CFC78BD54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbjH2Doc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjH2DoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:44:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884BC132
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:43:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-68bee12e842so2666265b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693280638; x=1693885438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBg5ksTAsCd+g0ET5QVSOkD7LptBQg14yrQGHEpUrAU=;
        b=xrYVvmpsQyuIwCnDdVXu+PvqwVRHdnGg4o6UuJkCxMwehBhNjPEfO4GkNE5LWo/5lW
         fbJDCU9ARMXE4M2zbDDHK9eJeKSERiwHHy2xhgk7gr+sbN/CJ1Azh2xppCav4KfGlqCQ
         nJn5olKAVWHQHN9W8M5NwkNVcJ2jbrH38Wfrxl6Arv/BWfdfSk28sRH0DC5ixgCVglPO
         4XVKihiY+l6GhSwWktds7xHvmNAimsPpANGpwboKtzl9rrkWmjDHkA3YGTVOTVVF4xSJ
         vZ4FCVCW5DHOWIizGpWBZL8U0e6cv0czGKO2dA5xiyKExGwYnQ14FbGbWPWG9kCiJU4o
         0+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693280638; x=1693885438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBg5ksTAsCd+g0ET5QVSOkD7LptBQg14yrQGHEpUrAU=;
        b=L9lMz2vF4WC+1dnf97RSc1MQwz6NPoXcUPiDgBuw/xhbFDh0sdnkOiegQa+ZBmW67B
         Dp4oBCk4By+6W44wN4+qnSviMvqtq0cxgdQZ5VaOOfoWCVoAAiNV4nWQdT9J+vOaf4+m
         OpZ8gkGip4zbyh1PCgm5sAgcPN1IdTcLqeD4GmwsaXcgPokxHY0e4089LQtDTdS5hM/P
         apnh5vXvlB92zAykiIl56/L4jav7XJjfTRcn0li1qnShZAk1MpEoagLhS65NKnrdipmI
         UapRtZneADZ8EQYA0Ruv7oU6Cta8/edjbpc8G1bKOqml0XETXjtwQDlR4x+CU/ack5wT
         wp/g==
X-Gm-Message-State: AOJu0YzckpAeZ1pqEin4Rd3QALiSKOxUYpQcnO2qCOAn4IKaE+m0Mxra
        if4vwhm6Eu/xtM6ivV6/JZHfJg==
X-Google-Smtp-Source: AGHT+IEhhDIIc+y53CLBg1kbx0PF9tqFR1kHAGGmtoHDssJGtwyVRTqB9oF5Ygp+BTtorMqROA6kDA==
X-Received: by 2002:a05:6a00:2d8c:b0:68b:da4b:4626 with SMTP id fb12-20020a056a002d8c00b0068bda4b4626mr16690415pfb.32.1693280637795;
        Mon, 28 Aug 2023 20:43:57 -0700 (PDT)
Received: from nixos.tailf4e9e.ts.net ([1.202.18.10])
        by smtp.googlemail.com with ESMTPSA id x52-20020a056a000bf400b006875be41637sm7691801pfu.145.2023.08.28.20.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 20:43:57 -0700 (PDT)
From:   Xueshi Hu <xueshi.hu@smartx.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Mel Gorman <mel@csn.ul.ie>
Cc:     Xueshi Hu <xueshi.hu@smartx.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/hugeltb: fix nodes huge page allocation when there are surplus pages
Date:   Tue, 29 Aug 2023 11:33:43 +0800
Message-Id: <20230829033343.467779-1-xueshi.hu@smartx.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In set_nr_huge_pages(), local variable "count" is used to record
persistent_huge_pages(), but when it cames to nodes huge page allocation,
the semantics changes to nr_huge_pages. When there exists surplus huge
pages and using the interface under
/sys/devices/system/node/node*/hugepages to change huge page pool size,
this difference can result in the allocation of an unexpected number of
huge pages.

Steps to reproduce the bug:

Starting with:

				  Node 0          Node 1    Total
	HugePages_Total             0.00            0.00     0.00
	HugePages_Free              0.00            0.00     0.00
	HugePages_Surp              0.00            0.00     0.00

create 100 huge pages in Node 0 and consume it, then set Node 0 's
nr_hugepages to 0.

yields:

				  Node 0          Node 1    Total
	HugePages_Total           200.00            0.00   200.00
	HugePages_Free              0.00            0.00     0.00
	HugePages_Surp            200.00            0.00   200.00

write 100 to Node 1's nr_hugepages

		echo 100 > /sys/devices/system/node/node1/\
	hugepages/hugepages-2048kB/nr_hugepages

gets:

				  Node 0          Node 1    Total
	HugePages_Total           200.00          400.00   600.00
	HugePages_Free              0.00          400.00   400.00
	HugePages_Surp            200.00            0.00   200.00

Kernel is expected to create only 100 huge pages and it gives 200.

Fixes: 9a30523066cd ("hugetlb: add per node hstate attributes")
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
---
Change in v2:
- Correct the fix tag
- v1: https://lore.kernel.org/linux-mm/20230828233448.GF3290@monkey/T/#t

 mm/hugetlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6da626bfb52e..54e2e2e12aa9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3494,7 +3494,9 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	if (nid != NUMA_NO_NODE) {
 		unsigned long old_count = count;
 
-		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
+		count += persistent_huge_pages(h) -
+			 (h->nr_huge_pages_node[nid] -
+			  h->surplus_huge_pages_node[nid]);
 		/*
 		 * User may have specified a large count value which caused the
 		 * above calculation to overflow.  In this case, they wanted
-- 
2.40.1

