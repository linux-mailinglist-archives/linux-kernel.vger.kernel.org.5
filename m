Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5333759AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjGSQgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGSQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:35:59 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EF92110
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:35:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5WR60RBqzBRDrS
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:55:46 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689760545; x=1692352546; bh=LFEDYh0JMqGp6rUarOIArGk7b2Q
        G8UZlPPkIzQVpWNc=; b=BEJ0Fmc2458JeahFVty3gY8C9cjLYPLR2wSrg8QltkE
        D4GnUkawbQjMC2JNIqBgUhfV9HHbs/dSg33vXJxSIuskyfhJlAc9973kySKdPTXj
        FU4kM3M7wWrW91Wdkn593ht2yAUC7L8YidbzF9z3cX+/g+SrXud8xQcz6m/v/Gz1
        44/MNtDYMDRR5pT/vBHLm6ZYNmWGl0H96s5NEMwS8PFVq+8nulD08uKgYAzdiwBO
        oPPZNH2Lo9CRzfvnYFrRKxKvhu2BTYSKLSDLZojzXi6KStvsQ1rhSZHKdtUxfIy/
        qXZpY8CGl8h1MD4rZ4KbAd4fn3awrVJYt2BV2YAjvdg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oY50Qd57crBF for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 17:55:45 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5WR55JMvzBRDrH;
        Wed, 19 Jul 2023 17:55:45 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 17:55:45 +0800
From:   sunran001@208suo.com
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, leitao@debian.org, kuba@kernel.org
Subject: [PATCH] mroute6: Removed unnecessary 'return'
In-Reply-To: <20230719095159.415-1-xujianghui@cdjrlc.com>
References: <20230719095159.415-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <51869bfa45c4b6df4efe53b7345100f6@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpatch error as void function return statements are not
generally useful

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/linux/mroute6.h | 1 -
  1 file changed, 1 deletion(-)

diff --git a/include/linux/mroute6.h b/include/linux/mroute6.h
index 63ef5191cc57..4a6e3d28d636 100644
--- a/include/linux/mroute6.h
+++ b/include/linux/mroute6.h
@@ -60,7 +60,6 @@ static inline int ip6_mr_init(void)

  static inline void ip6_mr_cleanup(void)
  {
-	return;
  }
  #endif
