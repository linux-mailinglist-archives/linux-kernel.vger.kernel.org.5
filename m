Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE8D7CABB7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjJPOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjJPOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:39:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B780EE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:39:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c8a1541232so39548665ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697467145; x=1698071945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0Sn/gKJWR6siX+0KJWM5lAESAe3sWf60qybDDt1Pys=;
        b=SyHIg9DzLy+zp4y+Yjhwxt7wJqC+tl1u18o8eoNRpREPgA952TWGap3RWoHe48fL/B
         lmPrS1T+aBpXzrmOxFFdrcwxUHbvE7dcFfK2m3qQPckUiVWb4eLDa+6NG1GMgzX8Lhtv
         Tl8DP06YSVWn5f2JDlapE7Je/kQQC73QZ0XpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467145; x=1698071945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0Sn/gKJWR6siX+0KJWM5lAESAe3sWf60qybDDt1Pys=;
        b=LPb1qFUAJLVrV/WNWslGqjXQoCqbZUDbOKEzznQzbMDf5PlSiIWJsjLQjvPvnf2psN
         /70H2bFV6oEsNrjicoxwJBgjI0ygQx7HzD+fjAx6HPKEtfAIbsJPezJoBRwE9L7h0uP7
         hqBCHWi4MXqpBE6guc9lzS1C0+DHzWiS4Cw+sZklT/HVU2YDY4s6IBqrG0BRt4pJopBn
         +Hj4ReWK+IJLmv4yeTQMEVAe6x1cQf41ox0fvtCVooj72U3J4/Az/kVRkyjevqJISu3R
         VhWagfGBV7+j2yyMPLLuJaYOhWvNyixc22aW/7jh6KAk4QqeNDnwtoBqD1P4XqWllTSK
         i1eg==
X-Gm-Message-State: AOJu0Yx512a2KFo+9JjVT+I8TXtlGKaHTO6qPKLSIZOY1P/5lqc/qFOc
        ebImlr4BUg4wHuD+fY0UXIeLwg==
X-Google-Smtp-Source: AGHT+IHQKvwpFIbGSIva7hn5sjCBlscbClIlMg0fHg4jXNaku6Zt8hbJMcw6wC8Uuvj5QeuKGPqvTA==
X-Received: by 2002:a17:90b:1fc6:b0:27d:4283:b8a2 with SMTP id st6-20020a17090b1fc600b0027d4283b8a2mr7510538pjb.14.1697467144783;
        Mon, 16 Oct 2023 07:39:04 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id nh24-20020a17090b365800b0026f39c90111sm5008030pjb.20.2023.10.16.07.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:39:04 -0700 (PDT)
From:   jeffxu@chromium.org
To:     akpm@linux-foundation.org, keescook@chromium.org,
        sroettger@google.com
Cc:     jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com, surenb@google.com,
        alex.sierra@amd.com, apopple@nvidia.com,
        aneesh.kumar@linux.ibm.com, axelrasmussen@google.com,
        ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com,
        dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com,
        joey.gouly@arm.com, corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: [RFC PATCH v1 6/8] mseal mremap
Date:   Mon, 16 Oct 2023 14:38:25 +0000
Message-ID: <20231016143828.647848-7-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

check seal for mremap(2)

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 mm/mremap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index e43f9ceaa29d..2288f9d0b126 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -836,7 +836,15 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
+	if (!can_modify_mm(mm, addr, addr + old_len, MM_ACTION_MREMAP,
+			   ON_BEHALF_OF_USERSPACE))
+		return -EACCES;
+
 	if (flags & MREMAP_FIXED) {
+		if (!can_modify_mm(mm, new_addr, new_addr + new_len,
+				   MM_ACTION_MREMAP, ON_BEHALF_OF_USERSPACE))
+			return -EACCES;
+
 		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
 		if (ret)
 			goto out;
@@ -995,6 +1003,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	if (!can_modify_mm(mm, addr, addr + old_len, MM_ACTION_MREMAP,
+			   ON_BEHALF_OF_USERSPACE)) {
+		ret = -EACCES;
+		goto out;
+	}
+
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-- 
2.42.0.609.gbb76f46606-goog

