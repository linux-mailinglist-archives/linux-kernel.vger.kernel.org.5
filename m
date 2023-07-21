Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0F75C1E9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjGUIoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGUIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:44:36 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C614CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:44:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6jlv6QcDzBRRLh
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:44:27 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689929067; x=1692521068; bh=n4NHMNhgcBJ+Cu+TPvqm+w/BK+8
        KMC4JqD9hhGz2mpE=; b=P72239ClSaZ3KzFY13WLdI2ceL/u7JDJfeLKroHsmfG
        yJe7oovWmy3GenBP2H3oWI8U40CR9b4uovx+xVakbyAw1xGm5xe6Vy4ToIOrx9Ir
        X9fkO9bMgMa7YlqFcb0vnt5HYlq5pO2tKXq9vyPZK5oI68vyiw/vUSbgBJhWRJO9
        sEWITpVba43IdouiZ0twGLpjKEIFVAKIDCXMU8iUcoywshp5VlV86DhiWejtxQ/q
        WNGPBv4BBV6GSseSHK2pEdyaMgGDhe3LrFeScaqS7gbZRyR3CH6U266gmpAxdjUQ
        AUOXoBqzjCZKaMYdgZfEddE+aPTOqQJ4Ngx1FDcxntQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bfiC2QFWyu7i for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 16:44:27 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6jlv2V8DzBJnMj;
        Fri, 21 Jul 2023 16:44:27 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:44:27 +0000
From:   sunran001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/apic: Do not initialise globals to 0
In-Reply-To: <20230721084245.6128-1-xujianghui@cdjrlc.com>
References: <20230721084245.6128-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <2ea849847ae4bda204192b00cc6fb87d@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:

ERROR: do not initialise globals to 0

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/x86/kernel/apic/apic.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index af49e24b46a4..8d46733ad94b 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -202,7 +202,7 @@ static struct resource lapic_resource = {
  	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
  };

-unsigned int lapic_timer_period = 0;
+unsigned int lapic_timer_period;

  static void apic_pm_activate(void);
