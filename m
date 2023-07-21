Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4787975C1BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGUId4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjGUIdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:33:54 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5C272E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:33:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6jWc73bQzBRRLC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:33:48 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689928428; x=1692520429; bh=2WtIbZPCnUuMSZagvUZ9HX3LoWK
        aD79EVzrQKVZC4Hg=; b=F2t8VW6OUmdUT16dArguUasONnp0UsprTKVhNNdo3+B
        NQkYh60VMmgkV1p19hQW4CgquRhw8m36yHlci56NpdYgP7s/4hhAjwN4QZ5Gi54J
        TYNIHjBDNTUmeOtCUDUVBtq2Um2PmHiJvQDVW6Hoshh9pdCAs5Ju6yClDAV8HmqX
        nkClPIWBYLYdFUyUDFv4ecNVEv6I5NGUD1zgAHzxXl/yWjKgvNEsnpxM/Ro9ATdN
        6G5pXc3OdKKxrfuPMZfg72m1XiN+d5Qpx7OMeswBzci/+tE39yOIDfA1M7eq3uaz
        uaX/eCtJm+y/nf1ZqASaZ2oXsA+7QOVcZnzG1lrScjg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mN2tT62Qes8s for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 16:33:48 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6jWc4yQbzBJnMj;
        Fri, 21 Jul 2023 16:33:48 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:33:48 +0000
From:   sunran001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/apic/msi: space required before the open parenthesis '('
In-Reply-To: <20230721083213.6036-1-xujianghui@cdjrlc.com>
References: <20230721083213.6036-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <1e0ccf1c75db4c62a22487b2e4a7d5c7@208suo.com>
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

ERROR: space required before the open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/x86/kernel/apic/msi.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 35d5b8fb18ef..cd565f253dcd 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -227,7 +227,7 @@ static bool x86_init_dev_msi_info(struct device 
*dev, struct irq_domain *domain,
  	}

  	/* Is the target supported? */
-	switch(info->bus_token) {
+	switch (info->bus_token) {
  	case DOMAIN_BUS_PCI_DEVICE_MSI:
  	case DOMAIN_BUS_PCI_DEVICE_MSIX:
  		break;
