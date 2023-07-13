Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC6751BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGMInP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjGMImh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:42:37 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008B33C28
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:39:26 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1p1l0CkJzBJcM1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:39:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689237562; x=1691829563; bh=8BBBUOQYlHrOA0abmFXS14YQVVp
        5Itw+Q01UdXxW2pI=; b=Waw/I/houGBvGg7Wc+Cjla7i3yp6OkMkBSK2aEycCgO
        Doa162BYNzVqP5bmMCZnO8uP55BH9WWSoWgbtiRSNmsimXwiOe6DdIZ/DnzOF9iZ
        1pzlZFdoEmBG1q4iKluG70yacaBsCkPq+e/732VI/cAN9dlGzDQKoRn0EPCKziMn
        WdAIFvI4vjoAbqftJ2QSzWFyxvYxvi4cBcQoMDrfNW2TosovJXZzCMhT+Kf7qGra
        XzR2DUjmYd6CPwDaNQfZEOpMxueTA1b8lfC/EUJmzk9tK373WEgmFEGOHyEKfW8D
        a5isvRwLkmTut2tayaEFU/YFkfgTw7yCoCnAGGQjvQA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NoNYVG00tqFy for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 16:39:22 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1p1k53SVzBJ8lM;
        Thu, 13 Jul 2023 16:39:22 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 16:39:22 +0800
From:   hexingwei001@208suo.com
To:     gerg@linux-m68k.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: coldfire: dma_timer: ERROR: "foo __init  bar" should be
 "foo __init bar"
In-Reply-To: <20230713081656.77057-1-panzhiai@cdjrlc.com>
References: <20230713081656.77057-1-panzhiai@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <0ed701a0d75f07e83f4a85617b2e33ae@208suo.com>
X-Sender: hexingwei001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix one occurrences of the checkpatch.pl error:
ERROR: "foo __init  bar" should be "foo __init bar"

Signed-off-by: Xingwei He <hexingwei001@208suo.com>
---
  arch/m68k/coldfire/dma_timer.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/coldfire/dma_timer.c 
b/arch/m68k/coldfire/dma_timer.c
index cbb289439606..91e6728f51ed 100644
--- a/arch/m68k/coldfire/dma_timer.c
+++ b/arch/m68k/coldfire/dma_timer.c
@@ -48,7 +48,7 @@ static struct clocksource clocksource_cf_dt = {
      .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
  };

-static int __init  init_cf_dt_clocksource(void)
+static int __init init_cf_dt_clocksource(void)
  {
      /*
       * We setup DMA timer 0 in free run mode. This incrementing counter 
is
