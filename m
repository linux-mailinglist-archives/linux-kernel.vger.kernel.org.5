Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D0A7F9C21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjK0Ixe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjK0Ix1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:53:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB561A7;
        Mon, 27 Nov 2023 00:53:32 -0800 (PST)
Date:   Mon, 27 Nov 2023 08:53:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701075210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mC17ffGRZAv3FROAjiSLZkjAg0UmydGQvIVapRt//5I=;
        b=DPTPLvV73YILa8FIASMFWkuTS5NMdNOj6YbfvUa6G+PQfn2Msan5/00iP3nDYfXRxMm9f8
        WEtxedeEF00Cy8lCME8nAYfPir8Te7ODJn60/sX4SudCCSY1ZocOaVZXq7RrsFHmjfAj1G
        up2Zt1fm5NE+8k14H48y6X2vEemoQw8GehK2vUEmfEtwL2tily3iZasETAEDH/5CjE7DZS
        LLZ17MUumX/OORfkWI5yoJHevXGiwoYr8gYml7+BLRS2mCyt6/3vXqWxw+FagyZO3SJqj2
        yzTvY9/Y7j+jMMk/oZG3KfDstIqCpISu6uZsvnaJ2erU1d7UjzJHIIKmxNgX+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701075210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mC17ffGRZAv3FROAjiSLZkjAg0UmydGQvIVapRt//5I=;
        b=YoFFwAY5sYUokCB2ORS2KeC8LEKW4VSuv5cHHJvrH1jn8xmjK9Gzz8Td+Vuak8MDOTlfSj
        tW/UZYv50/e67bBw==
From:   "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] MAINTAINERS: Add include/linux/lockdep*.h
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce722abd043e5de64d2acd28d581e4a952994a94e=2E17009?=
 =?utf-8?q?89248=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Ce722abd043e5de64d2acd28d581e4a952994a94e=2E170098?=
 =?utf-8?q?9248=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <170107520938.398.1207018848412197131.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     28a9466d75a861c26ba57b64a0a9a436a7c61e77
Gitweb:        https://git.kernel.org/tip/28a9466d75a861c26ba57b64a0a9a436a7c61e77
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sun, 26 Nov 2023 10:00:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 27 Nov 2023 09:46:39 +01:00

MAINTAINERS: Add include/linux/lockdep*.h

Have lockdep_api.h and lockdep_types.h match as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/e722abd043e5de64d2acd28d581e4a952994a94e.1700989248.git.christophe.jaillet@wanadoo.fr
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5..9834adc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12458,7 +12458,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
 F:	Documentation/locking/
 F:	arch/*/include/asm/spinlock*.h
-F:	include/linux/lockdep.h
+F:	include/linux/lockdep*.h
 F:	include/linux/mutex*.h
 F:	include/linux/rwlock*.h
 F:	include/linux/rwsem*.h
