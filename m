Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C167DE90B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 00:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346274AbjKAXeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 19:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346669AbjKAXeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 19:34:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201DD19F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 16:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698881606; x=1730417606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1AjRS2RYgzejs/fIJzkCjHgC5dFZAkYraaGawmqQUG0=;
  b=SxfxWMyyfs8790WpFcGHUqOBWJpolJrxtlOgTkkt/Wo5wA81ia1ndKUI
   X37ln8yOxj68xfpf8Tr7adL71THc3HTu6q9QZV3fRLdk1mT/AiAATVmw1
   QO58pyrM3kjHWErY5d5AGgruLYoHYXk4tKXm3mmzM00Q8MronYdoXqngt
   zZT0DFW9F989j4EIU/FggfjBnPz+NYQ/07YtRL3FfLbyp7ULqbG/3EEYX
   SglBGfBrofDXzE1qNeD7+2shPO3EjLQ3OKUYf71dVBQMINEmqypm2d0Z0
   IrWZLr5K3nSXyOl/uFkNNkXOLzgWi1yi85i2KtVp2EU7BlGK6N5enfvZn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="455081271"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="455081271"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 16:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="878043075"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="878043075"
Received: from bfahim-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.34.188])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 16:33:23 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 31C3F10A30E; Thu,  2 Nov 2023 02:33:20 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Add Intel TDX entry
Date:   Thu,  2 Nov 2023 02:33:14 +0300
Message-ID: <20231101233314.2567-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as Intel TDX maintainer.

I drove upstreaming most of TDX code so far and I will continue
working on TDX for foreseeable future.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7608b714653f..1cbec6b235f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23466,6 +23466,18 @@ F:	arch/x86/kernel/dumpstack.c
 F:	arch/x86/kernel/stacktrace.c
 F:	arch/x86/kernel/unwind_*.c
 
+X86 TRUST DOMAIN EXTENSIONS (TDX)
+M:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
+L:	x86@kernel.org
+L:	linux-coco@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
+F:	arch/x86/boot/compressed/tdx*
+F:	arch/x86/coco/tdx/
+F:	arch/x86/include/asm/shared/tdx.h
+F:	arch/x86/include/asm/tdx.h
+F:	arch/x86/virt/vmx/tdx/
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.41.0

