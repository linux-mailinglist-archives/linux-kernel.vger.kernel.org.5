Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD878214F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjHUCKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHUCKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:10:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B92F9C
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 19:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=oAtWfAs0fV1At8kVOPZodHjIhKWjuN/cdRfvxtRQhl8=; b=UX1sJPIkClvg0QSEmOE87aCXVX
        rsEQIhwUm8F7TM3zQNYBwt4Ecwe22700mUQrw43w2phQvJvoGwQ9MbqGvsLHzuWe9jMWqQrwidpjY
        b8ulsvrb3tXryG8tgO+JZjKuJslb8hGKLI4KFUBYkgvZQubZ2G1XOmcUB3JETT08IH2wagd07986n
        +vkK/6hvGoqmx6hnBpjKxaXr4lcPu8sLyjUXx5Oi8dovVFZSvJIOsdQO6LYYQ2jjS/3WQAOWG3W2c
        lfNIAjbYzJHdHhSfkpXwe/m9ORXLIk422oiwuGUr9HFUUZ1/tjPgqnJp5oOEJKEZo619bTO6WB3R+
        mo+Nh2ZQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qXuNO-00Cqqy-0I;
        Mon, 21 Aug 2023 02:10:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Subject: [PATCH] ARM: sa1111: fix sa1111_probe kernel-doc warnings
Date:   Sun, 20 Aug 2023 19:10:38 -0700
Message-ID: <20230821021038.6590-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document only the platform_driver probe entry point in kernel-doc
to prevent kernel-doc warnings:

sa1111.c:802: warning: Function parameter or member 'me' not described in '__sa1111_probe'
sa1111.c:802: warning: Function parameter or member 'mem' not described in '__sa1111_probe'
sa1111.c:802: warning: Function parameter or member 'irq' not described in '__sa1111_probe'
sa1111.c:802: warning: expecting prototype for sa1111_probe(). Prototype was for __sa1111_probe() instead

Also, use ReST list format to enumerate the return values.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202308112255.SK1J0rze-lkp@intel.com/
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
KernelVersion: 6.5-rc6

 arch/arm/common/sa1111.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff -- a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -785,19 +785,6 @@ sa1111_init_one_child(struct sa1111 *sac
 	return ret;
 }
 
-/**
- *	sa1111_probe - probe for a single SA1111 chip.
- *	@phys_addr: physical address of device.
- *
- *	Probe for a SA1111 chip.  This must be called
- *	before any other SA1111-specific code.
- *
- *	Returns:
- *	%-ENODEV	device not found.
- *	%-EBUSY		physical address already marked in-use.
- *	%-EINVAL	no platform data passed
- *	%0		successful.
- */
 static int __sa1111_probe(struct device *me, struct resource *mem, int irq)
 {
 	struct sa1111_platform_data *pd = me->platform_data;
@@ -1108,6 +1095,20 @@ static int sa1111_resume_noirq(struct de
 #define sa1111_resume_noirq  NULL
 #endif
 
+/**
+ *	sa1111_probe - probe for a single SA1111 chip.
+ *	@pdev: platform device.
+ *
+ *	Probe for a SA1111 chip.  This must be called
+ *	before any other SA1111-specific code.
+ *
+ *	Returns:
+ *	* %-ENODEV	- device not found.
+ *	* %-ENOMEM	- memory allocation failure.
+ *	* %-EBUSY	- physical address already marked in-use.
+ *	* %-EINVAL	- no platform data passed
+ *	* %0		- successful.
+ */
 static int sa1111_probe(struct platform_device *pdev)
 {
 	struct resource *mem;
