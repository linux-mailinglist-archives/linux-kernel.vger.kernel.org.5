Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65417774F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjHHXoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHHXoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:44:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FAF0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=aG8Y30PwCSThWsDEUczlXw9O6NJ4yxnIzNTeQ/Re6VE=; b=315zny3skUm3SJxNptuWnL+oWk
        wAi1xQCXr5MIKI/k/OINHtkRs/NY2qeJW6XOQvlI2nVdVymy3ffRji2Ju2GkY2IDGjXef4DAKhGVJ
        Lrou2g9/ltK69tdjuFrzUzs8JE7V/kpvrf15GpDAxrKarjcWOaHmMSkCAvuR1e8hGevamvZ4f7Mxb
        gKW0iiEIaNagEIVTAOudiT8VDvIlvurRaNkvyFrB1PbISLpwgvAcXloAvvD17RzVocOvJRHl9TLZP
        0zcd1o+sRCGIYOxMm4MQK/CD6RGd0oSQpdcz5Y4R3fv4/kxEFe/jJ/2hqnXC2mJwg/r+ZTECt90r7
        MzCCWnSQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTWMx-003gfH-27;
        Tue, 08 Aug 2023 23:44:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Subject: [PATCH] ARM: locomo: move kernel-doc to prevent warnings
Date:   Tue,  8 Aug 2023 16:44:06 -0700
Message-ID: <20230808234406.24414-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the kernel-doc comments for locomo_probe() to immediately before
that function instead of before __locomo_probe() to prevent
kernel-doc warnings. Adjust the documented function parameters and
make the return values compatible with ReST by adding bullets to them.
Add more possible return values to the list.

Prevents these warnings:

  arch/arm/common/locomo.c:368: warning: Function parameter or member 'me' not described in '__locomo_probe'
  arch/arm/common/locomo.c:368: warning: Function parameter or member 'mem' not described in '__locomo_probe'
  arch/arm/common/locomo.c:368: warning: Function parameter or member 'irq' not described in '__locomo_probe'
  arch/arm/common/locomo.c:368: warning: expecting prototype for locomo_probe(). Prototype was for __locomo_probe() instead

Fixes: 5eb6e280432d ("ARM: 9289/1: Allow pre-ARMv5 builds with ld.lld 16.0.0 and newer")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202308050851.zAvHe6y7-lkp@intel.com
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 6.5-rc5

 arch/arm/common/locomo.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff -- a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -350,19 +350,6 @@ static int locomo_resume(struct platform
 }
 #endif
 
-
-/**
- *	locomo_probe - probe for a single LoCoMo chip.
- *	@phys_addr: physical address of device.
- *
- *	Probe for a LoCoMo chip.  This must be called
- *	before any other locomo-specific code.
- *
- *	Returns:
- *	%-ENODEV	device not found.
- *	%-EBUSY		physical address already marked in-use.
- *	%0		successful.
- */
 static int
 __locomo_probe(struct device *me, struct resource *mem, int irq)
 {
@@ -479,6 +466,21 @@ static void __locomo_remove(struct locom
 	kfree(lchip);
 }
 
+/**
+ *	locomo_probe - probe for a single LoCoMo chip.
+ *	@dev: platform device
+ *
+ *	Probe for a LoCoMo chip.  This must be called
+ *	before any other locomo-specific code.
+ *
+ *	Returns:
+ *	* %-EINVAL	- device's IORESOURCE_MEM not found
+ *	* %-ENXIO	- could not allocate an IRQ for the device
+ *	* %-ENODEV	- device not found.
+ *	* %-EBUSY	- physical address already marked in-use.
+ *	* %-ENOMEM	- could not allocate or iomap memory.
+ *	* %0		- successful.
+ */
 static int locomo_probe(struct platform_device *dev)
 {
 	struct resource *mem;
