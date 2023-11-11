Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44F77E88C0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 04:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345730AbjKKDCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 22:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjKKDCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 22:02:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405BD449A;
        Fri, 10 Nov 2023 19:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Jd3dbI5OGBjKBW+7cOzwRrn7JY1+6AG5uhO4OH3lR4k=; b=FRbxmVQSM/vQbxXwlO3/8GjdIR
        YH4VKN2LWodCq68nLjxwR4fyLRjABZz02tpPD7Sgxf1fKuOhAImUT6agC8priqrfO4NCrfZz1oD6Q
        Aw+0VOHoFWc6B6Y2g+TWKek1IFc3SwkOPKRnxQt1NK0boq+Z4h744VJ/Utw9wNhPVPNow0mUgzZ/F
        WxUmmVbsaVRgRKQnVGUJUakA3jPbUGldLFyhKZaWt3wtp7XRFYZ+iAwuGWmMtqczisTRxoFDECTlH
        GpWq5TBcCdltp4qpm/QqAwTAEzGSkidpV6TC2CCX4I3QxxRgJiv8bcieKtDqeB10D4vDEhXMLEEWb
        9S7RT8Jg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r1eGE-009uCi-0H;
        Sat, 11 Nov 2023 03:02:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-mips@vger.kernel.org
Subject: [PATCH] MIPS: SGI-IP27: hubio: fix nasid kernel-doc warning
Date:   Fri, 10 Nov 2023 19:02:13 -0800
Message-ID: <20231111030213.31595-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ip27-hubio.c:32: warning: Function parameter or member 'nasid' not described in 'hub_pio_map'
ip27-hubio.c:32: warning: Excess function parameter 'hub' description in 'hub_pio_map'

Fixes: 4bf841ebf17a ("MIPS: SGI-IP27: get rid of compact node ids")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: lore.kernel.org/r/202311101336.BUL1JuvU-lkp@intel.com
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/sgi-ip27/ip27-hubio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/mips/sgi-ip27/ip27-hubio.c b/arch/mips/sgi-ip27/ip27-hubio.c
--- a/arch/mips/sgi-ip27/ip27-hubio.c
+++ b/arch/mips/sgi-ip27/ip27-hubio.c
@@ -21,7 +21,7 @@ static int force_fire_and_forget = 1;
 /**
  * hub_pio_map	-  establish a HUB PIO mapping
  *
- * @hub:	hub to perform PIO mapping on
+ * @nasid:	nasid to perform PIO mapping on
  * @widget:	widget ID to perform PIO mapping for
  * @xtalk_addr: xtalk_address that needs to be mapped
  * @size:	size of the PIO mapping
