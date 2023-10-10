Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019467BFFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjJJOwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjJJOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:52:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34747B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696949561; x=1728485561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JbOkmGE7Zp3VTl3c/W/bo8PYIhYgD0PoZ/IcICLZmso=;
  b=BGVmBG3MToSofZHE3v8Pbm320acsY33kf4sphCgzBk+OVk5KktSGdvHX
   UOfAwlu2+8nbPASV4t6PK1u4QnMEkQNSbWcndvPG111J9W0Rku+E+fLxP
   6rw2cdYaatA8RpQt+dcbRMYtquz0UW8t2KRgsUwdmRqPXyJz2oGvDKKHj
   4dyyUqdjwJbLGyUS57fjd5VfPRTAAD7cNAfYKweSiAYp66aFZup2+ql7h
   9Cll5C9E5WUqp1nAplA3xNUBkJSty5RRaAeHD4d/GS2F9FU79BaOvnj1h
   gRLCcb7qhL9XC9JeJC6UldUtqZG3hDitI0ACdqVUV/oKXnr5h63sEadX9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="374763983"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="374763983"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 07:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788609443"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="788609443"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2023 07:52:37 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 2/2] x86/sev: Drop unneeded include
Date:   Tue, 10 Oct 2023 17:52:20 +0300
Message-Id: <20231010145220.3960055-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010145220.3960055-1-alexander.shishkin@linux.intel.com>
References: <20231010145220.3960055-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 20f07a044a76 ("x86/sev: Move common memory encryption code to
mem_encrypt.c") forgot to remove the include of virtio_config.h from
mem_encrypt_amd.c when it moved the related code to mem_encrypt.c (from
where this include subsequently got removed by a later commit).

Remove it now. No functional changes.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/mm/mem_encrypt_amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 62dde75d41fa..a68f2dda0948 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/dma-mapping.h>
-#include <linux/virtio_config.h>
 #include <linux/cc_platform.h>
 
 #include <asm/tlbflush.h>
-- 
2.40.1

