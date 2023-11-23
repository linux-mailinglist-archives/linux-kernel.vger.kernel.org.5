Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8924D7F6914
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjKWWmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAACCB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700779328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RNOblxCVZ5MmbuOKhDAArpLLJZp0p2DhC0r92TlF9VQ=;
        b=OX7EGaU2vwxeAdmOCcnLpfXg/AOM2yBJnNnZaqRzsYLLd/XlRLbszMXuityu9kI0YeuSaU
        dOXKV6MU1N/hN5Ce9dDCpf5GUb7kHulrJTcTAnyKpxVWUKauegZqulJmigMnFyzamw46Tf
        dlhMTKdlIOaur+Foo04qyBxsbITDtH4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-n0VOBdgUMuSC3P1jakl2Bg-1; Thu, 23 Nov 2023 17:42:07 -0500
X-MC-Unique: n0VOBdgUMuSC3P1jakl2Bg-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-421ac2bad66so2695721cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700779326; x=1701384126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RNOblxCVZ5MmbuOKhDAArpLLJZp0p2DhC0r92TlF9VQ=;
        b=U/UDKejuKAHeP7WMI76wMyyfRG4rViKKdj3IluUY6npt+JXp28xgyQLIaZAC/hpis6
         08U3LsrLOna2iOYr3FmKxfNsEvqu0gGGMSu/x7ea3PMwrRclfULNO3sk5GvUuBZBsCgg
         5BjNlFn2Y7UnJMTdfuK/Eu21XftcZD/ZLXOiSb+0/vWs4inFPE4oeqVonDc+Ik9vcHX9
         IKNfr0aZo4Amm09oqD4leca405bVN113EA8ToxvAa8uZp9Esw4cRxa8ZO5xk8Nu2uOdy
         WffmN+LMSJCmrJwAfj+UQpYuD3Ch1CNZc8rWBimrBrSaebHVZ80f0M5rX1GbLunlMnMr
         e+mQ==
X-Gm-Message-State: AOJu0YwPFCm3IRVyFR4JQqCyjk8BBSxQ5Jkef2cjK+msjIkkaVI3VUDC
        BKLnaeiB3KQk9O+JMl1xlTOe/hOxsKIQxtzwtAcrl/ONEjtz9rbmIiiBiBdw3Od0Gaa9ebJTKoz
        lVHN7OddMiGUBGBITSVVai2q3
X-Received: by 2002:a05:620a:17a9:b0:774:17d6:31f1 with SMTP id ay41-20020a05620a17a900b0077417d631f1mr861519qkb.4.1700779326606;
        Thu, 23 Nov 2023 14:42:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIHM2z03Sos/ggi1TVZ4Gq8krOSZyonckYQxXLL0O+5fXXP7i1/B0xHmsV9L9UeiSme61bOw==
X-Received: by 2002:a05:620a:17a9:b0:774:17d6:31f1 with SMTP id ay41-20020a05620a17a900b0077417d631f1mr861509qkb.4.1700779326284;
        Thu, 23 Nov 2023 14:42:06 -0800 (PST)
Received: from x1n.redhat.com (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id k18-20020a05620a143200b007743671a41fsm770555qkj.72.2023.11.23.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:42:05 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com
Subject: [PATCH] mm/Kconfig: Make userfaultfd a menuconfig
Date:   Thu, 23 Nov 2023 17:42:04 -0500
Message-ID: <20231123224204.1060152-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTE_MARKER_UFFD_WP is a subconfig for userfaultfd.  To make it clear,
switch to use menuconfig for userfaultfd.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/Kconfig | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..57cd378c73d6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1201,13 +1201,6 @@ config ANON_VMA_NAME
 	  area from being merged with adjacent virtual memory areas due to the
 	  difference in their name.
 
-config USERFAULTFD
-	bool "Enable userfaultfd() system call"
-	depends on MMU
-	help
-	  Enable the userfaultfd() system call that allows to intercept and
-	  handle page faults in userland.
-
 config HAVE_ARCH_USERFAULTFD_WP
 	bool
 	help
@@ -1218,6 +1211,14 @@ config HAVE_ARCH_USERFAULTFD_MINOR
 	help
 	  Arch has userfaultfd minor fault support
 
+menuconfig USERFAULTFD
+	bool "Enable userfaultfd() system call"
+	depends on MMU
+	help
+	  Enable the userfaultfd() system call that allows to intercept and
+	  handle page faults in userland.
+
+if USERFAULTFD
 config PTE_MARKER_UFFD_WP
 	bool "Userfaultfd write protection support for shmem/hugetlbfs"
 	default y
@@ -1227,6 +1228,7 @@ config PTE_MARKER_UFFD_WP
 	  Allows to create marker PTEs for userfaultfd write protection
 	  purposes.  It is required to enable userfaultfd write protection on
 	  file-backed memory types like shmem and hugetlbfs.
+endif # USERFAULTFD
 
 # multi-gen LRU {
 config LRU_GEN
-- 
2.41.0

