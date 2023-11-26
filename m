Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005EB7F9211
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjKZKBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjKZKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:01:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0A910A;
        Sun, 26 Nov 2023 02:01:12 -0800 (PST)
Date:   Sun, 26 Nov 2023 10:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700992871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R638rDDj10jzdeR+s3rY0BIqraXp1U3EJ/HJcfq1tsM=;
        b=Rvbqc851odlCR7sQ03AFS3TwyMsKpUtuu93PRzgG9J3Zbbep8WQYvbx4i2jKfAfMLBM1ZN
        4I6Jvm+igqHA+NQPUVkhKKMpHcHU5Togm2ksbj1luAwpiYW2iHz4XpbA1raPIA9/SYZveh
        QlXyBDrLpPDduMUwbIRW+oU236WvO3VhrSeA+OIt/RmesdNa4XFV0pGcT0LaEXly5xn8cj
        rYqG26g/H4GxsMG1uVCBM93z5i2QCb75qGEJvFi2r3aKhrRZ++xf3CJF1pfIOF5GGqzeFV
        KyVlQTRxUZJZfFvigTlNt6fABPS4D2jkpNiNSVSll2RhpBa6UEPrq+8HYqMqWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700992871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R638rDDj10jzdeR+s3rY0BIqraXp1U3EJ/HJcfq1tsM=;
        b=Ay17crmMt02D9ycWqdJ+8xSFd91MOFvT7nCoqcZfBJFiFXucR2YNQdFZXoWbgRFaYdYa64
        cqs4r+9Ty/y4pbAQ==
From:   "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] MAINTAINERS: Add include/linux/lockdep*.h
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce722abd043e5de64d2acd28d581e4a952994a94e=2E17009?=
 =?utf-8?q?89248=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Ce722abd043e5de64d2acd28d581e4a952994a94e=2E170098?=
 =?utf-8?q?9248=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
MIME-Version: 1.0
Message-ID: <170099286957.398.270163389762223415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a0c8711b1da5cb62ba50b96b4e7991f03073f477
Gitweb:        https://git.kernel.org/tip/a0c8711b1da5cb62ba50b96b4e7991f03073f477
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sun, 26 Nov 2023 10:00:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 26 Nov 2023 10:53:29 +01:00

MAINTAINERS: Add include/linux/lockdep*.h

Have lockdep_api.h and lockdep_types.h match as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
