Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62A75C0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGUIBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGUIBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:01:01 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A912704
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:00:59 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6hnj00T2zBRDtX
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:00:56 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689926456; x=1692518457; bh=R7OWkFgo62IQSqeLiuqCwyNKzg8
        CO3vmJCNh4PIA6/Q=; b=Q6QWgLwBcQNkZUj+4ya4V+Cbi+0IQIyMCOk12fAuElm
        oWF8Lts0JGxXBEKw/L1fZUFZR2ypkztzvSuBVe6HJriRgUHg+N8lEPhJSmnyeSeK
        WZ/SvlRsHaHVnjcFGOaNUgwqkB8Pvu9UAAvIOOJohNUBJ7cguU8GNfPUhS+7A0dv
        QB9I2qD6BwByKphkeXtLfIekIhO+xH0fLiqxTeIUhf9N9drtWnkf7oqyTEXO4mRi
        0WTZHL1+GxUKF6WmIy9UuQP2oPTK1fpgJrc1Szc01Fecmbh9i+j0FmdXaJuQT6De
        /geO4tCAukvJGiH+ryi2PejcryA5RW7g0ORbd1AMJbw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6PFowdzpEZRz for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 16:00:56 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6hnh4TqxzBRDt0;
        Fri, 21 Jul 2023 16:00:56 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:00:56 +0000
From:   sunran001@208suo.com
To:     geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: Fix two occurrences of the checkpatch.pl error:
In-Reply-To: <20230721075949.5632-1-xujianghui@cdjrlc.com>
References: <20230721075949.5632-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <fcc5460f8a84680d6e7379d320ad0575@208suo.com>
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

ERROR: that open brace { should be on the previous line
ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/m68k/q40/config.c | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index c78ee709b458..62ed3634c0a4 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -146,9 +146,8 @@ static void q40_get_model(char *model)
  	sprintf(model, "Q40");
  }

-static unsigned int serports[] =
-{
-	0x3f8,0x2f8,0x3e8,0x2e8,0
+static unsigned int serports[] = {
+	0x3f8, 0x2f8, 0x3e8, 0x2e8, 0
  };

  static void __init q40_disable_irqs(void)
