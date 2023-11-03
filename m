Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9D7E0AB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 22:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjKCVeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 17:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjKCVep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:34:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CE61A8;
        Fri,  3 Nov 2023 14:34:42 -0700 (PDT)
Date:   Fri, 03 Nov 2023 21:34:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699047281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RiF86Be91X7P83YcrsoVRYDLjX29bzYNes83tWpsBUE=;
        b=JydaAaPiOEAIK1y9Q2sEl0b2lHhxhGUcZYrBc5ELesED0fENOiTEtwDZO5wk4/NsEnoM/D
        GlwjLn54ji2r+Yr8zBIAK1idzrrVBLpap7Awvbvkepdqqpv4q8z8AI2VyWVe7JR2rcVjtt
        Pya2nPg1blKXvnNxtseGiBqlNuTueBdclGQXGklAep+1VIyJaKRkIeGRvkY50fuGq7LTX+
        qiY9st8QGkQ97dtt3bmwTY7OObyHgS1PDQa2hdEL3GtvyNG/4kPWtORxt84laHU3C6wkGC
        QHsive4dmNRe89gBeNgW9QLTAkS3v16VGmkBnIkqtLA3z6MRivAS/hxiG6S9+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699047281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RiF86Be91X7P83YcrsoVRYDLjX29bzYNes83tWpsBUE=;
        b=CuM/dZzldRVGLGFyYtOIJGKTejCli52PW2rMJuVoEjrOYkLWqvAuIut8izdhE3vSBpeo2G
        kbixNdzK/lELr9AQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] MAINTAINERS: Add Intel TDX entry
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169904728047.3135.10696109208721655124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c692800cb2ef7a4f4940c68d765cd4649aff3e46
Gitweb:        https://git.kernel.org/tip/c692800cb2ef7a4f4940c68d765cd4649aff3e46
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Thu, 02 Nov 2023 02:33:14 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 03 Nov 2023 14:27:21 -07:00

MAINTAINERS: Add Intel TDX entry

Add myself as Intel TDX maintainer.

I drove upstreaming most of TDX code so far and I will continue
working on TDX for foreseeable future.

[ dhansen: * Add myself as a reviewer too
	   * Swap Maintained=>Supported.  I double
	     checked Kirill is still being paid
	   * Add drivers/virt/coco/tdx-guest ]

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20231101233314.2567-1-kirill.shutemov%40linux.intel.com
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5de54..b697020 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23460,6 +23460,20 @@ F:	arch/x86/kernel/dumpstack.c
 F:	arch/x86/kernel/stacktrace.c
 F:	arch/x86/kernel/unwind_*.c
 
+X86 TRUST DOMAIN EXTENSIONS (TDX)
+M:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
+R:	Dave Hansen <dave.hansen@linux.intel.com>
+L:	x86@kernel.org
+L:	linux-coco@lists.linux.dev
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
+F:	arch/x86/boot/compressed/tdx*
+F:	arch/x86/coco/tdx/
+F:	arch/x86/include/asm/shared/tdx.h
+F:	arch/x86/include/asm/tdx.h
+F:	arch/x86/virt/vmx/tdx/
+F:	drivers/virt/coco/tdx-guest
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
