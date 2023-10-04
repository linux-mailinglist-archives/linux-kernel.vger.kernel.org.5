Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30037B8484
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjJDQJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjJDQJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:09:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A967ABF;
        Wed,  4 Oct 2023 09:09:38 -0700 (PDT)
Date:   Wed, 04 Oct 2023 16:09:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696435777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tco2oLrQfsIAEtlgl8Nce5/Ay0Sr42yRCzzDGiBrR/Q=;
        b=xmvEdK1LeY9SnwT0MxVzAbsXBO2w3pW80AydelL8KdlB3VIcFO0h4vp1qnAm+uTUW4rqAM
        89wIXdF9Al3SiNX3EYp3PCL2yV5IPI1vQiKPOkrHvRsH5NTJSbMVjbEIBMTKChYHaAhPcx
        ynlLS1iG9ao77IUB+6n9S0V3YKwWriYte/Q5l2GrAiRVvAe8GXnsH9uVEmqQtVo+AmVLle
        iDoihTnilhO76HcgxsQQWdaS8erieWBOrLpfH99fsyiyxq6PkuCMRUHWMWwMV+9dKnTqxM
        34nZTdrdzIjX0BCabwSVhWFAQP7xbndrgRrBQPYymHchc9BVwJdksqQBOjSzXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696435777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tco2oLrQfsIAEtlgl8Nce5/Ay0Sr42yRCzzDGiBrR/Q=;
        b=+JlsNjIzx0e3wu1n2YiM46cZY6K2of5+o37DGo6vsQpyOJF7zV3AdgHGIwREsrUmX9K5xm
        csiA0CGqmk8XbCAQ==
From:   "tip-bot2 for Li zeming" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex/requeue: Remove unnecessary =?utf-8?q??=
 =?utf-8?b?4oCYTlVMTOKAmQ==?= initialization from futex_proxy_trylock_atomic()
Cc:     Li zeming <zeming@nfschina.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230725195047.3106-1-zeming@nfschina.com>
References: <20230725195047.3106-1-zeming@nfschina.com>
MIME-Version: 1.0
Message-ID: <169643577653.3135.1339527957884113798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     01a99a750a4f414c221781de2e5570e0ceae04b5
Gitweb:        https://git.kernel.org/tip/01a99a750a4f414c221781de2e5570e0cea=
e04b5
Author:        Li zeming <zeming@nfschina.com>
AuthorDate:    Wed, 26 Jul 2023 03:50:47 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Oct 2023 18:04:47 +02:00

futex/requeue: Remove unnecessary =E2=80=98NULL=E2=80=99 initialization from =
futex_proxy_trylock_atomic()

'top_waiter' is assigned unconditionally before first use,
so it does not need an initialization.

[ mingo: Created legible changelog. ]

Signed-off-by: Li zeming <zeming@nfschina.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230725195047.3106-1-zeming@nfschina.com
---
 kernel/futex/requeue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index a0a7995..16a3645 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -269,7 +269,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct fu=
tex_hash_bucket *hb1,
 			   union futex_key *key2, struct futex_pi_state **ps,
 			   struct task_struct **exiting, int set_waiters)
 {
-	struct futex_q *top_waiter =3D NULL;
+	struct futex_q *top_waiter;
 	u32 curval;
 	int ret;
=20
