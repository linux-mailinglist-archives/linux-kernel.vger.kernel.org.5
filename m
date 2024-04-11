Return-Path: <linux-kernel+bounces-140568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E98A1649
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406B4B2A537
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A17514D458;
	Thu, 11 Apr 2024 13:50:49 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FBC14BF8D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843449; cv=none; b=admJ/3D+BAkReqmZNsfF4EFbTFA7B/jYKgnUD9CJNnxUaY6pw8eHlWbR4+4TZH3B6DREzyI4Q5wpceevk9WitqjmExffX5oKME1BDBN/FtLSC9B/BQ5xiVaMO0flPrUTXG7ar49brtxQ9wv7u2FpiGmIsP+6U847frFT1wGos5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843449; c=relaxed/simple;
	bh=5tZzAQ3pT/J97nL1xvjN2jr8PRlgTWfwPZhAnSs4iTU=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=AqsmeciHKSQ8YfbPfkO6w/SJab0Fzp4X1V8IcSy08203swdBwF+OCltMMC1pi2QYlWa2jdkXKuYx6vSGmnt+ZPbG9fHMXGe+m+luvOhCNFcBeQQuw5wVu0ObFrhRGcN31PhDUtt57y8c29tEHkfZQAIhoczBCkUnsHxMmIRkelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4VFh0r6xSZzW8G
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:50:36 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4VFh0l6RqfzBRZ5q
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:50:31 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VFh0V5pn9z8XrRB;
	Thu, 11 Apr 2024 21:50:18 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
	by mse-fl1.zte.com.cn with SMTP id 43BDoDmT006048;
	Thu, 11 Apr 2024 21:50:13 +0800 (+08)
	(envelope-from li.hao40@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 11 Apr 2024 21:50:17 +0800 (CST)
Date: Thu, 11 Apr 2024 21:50:17 +0800 (CST)
X-Zmail-TransId: 2afa6617ea99ffffffffb9d-ff120
X-Mailer: Zmail v1.0
Message-ID: <20240411215017604oDcKsSipiLnfwd2SzAnsj@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <li.hao40@zte.com.cn>
To: <jirislaby@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB0dHk6IGh2Yzogd2FrZXVwIGh2YyBjb25zb2xlIGltbWVkaWF0ZWx5IHdoZW4gbmVlZGVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 43BDoDmT006048
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6617EAAB.000/4VFh0r6xSZzW8G

From: Li Hao <li.hao40@zte.com.cn>

Cancel the do_wakeup flag in hvc_struct, and change it to immediately
wake up tty when hp->n_outbuf is 0 in hvc_push().

When we receive a key input character, the interrupt handling function
hvc_handle_interrupt() will be executed, and the echo thread
flush_to_ldisc() will be added to the queue.

If the user is currently using tcsetattr(), a hang may occur. tcsetattr()
enters kernel and waits for hp->n_outbuf to become 0 via
tty_wait_until_sent(). If the echo thread finishes executing before
reaching tty_wait_until_sent (for example, put_chars() takes too long),
it will cause while meeting the wakeup condition (hp->do_wakeup = 1),
tty_wait_until_sent() cannot be woken up (missed the tty_wakeup() of
this round&apos;s tty_poll). Unless the next key input character comes,
hvc_poll will be executed, and tty_wakeup() will be performed through
the do_wakeup flag.

Signed-off-by: Li Hao
---
drivers/tty/hvc/hvc_console.c | 12 +++++-------
drivers/tty/hvc/hvc_console.h |  1 -
2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cdcc64ea2554..4f06aead690a 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -476,11 +476,13 @@ static void hvc_hangup(struct tty_struct *tty)
static int hvc_push(struct hvc_struct *hp)
{
 	int n;
+	struct tty_struct *tty;

 	n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
+	tty = tty_port_tty_get(&hp->port);
 	if (n <= 0) {
 		if (n == 0 || n == -EAGAIN) {
-			hp->do_wakeup = 1;
+			tty_wakeup(tty);
 			return 0;
 		}
 		/* throw away output on error; this happens when
@@ -491,7 +493,7 @@ static int hvc_push(struct hvc_struct *hp)
 	if (hp->n_outbuf > 0)
 		memmove(hp->outbuf, hp->outbuf + n, hp->n_outbuf);
 	else
-		hp->do_wakeup = 1;
+		tty_wakeup(tty);

 	return n;
}
@@ -739,11 +741,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 	poll_mask |= HVC_POLL_READ;

out:
-	/* Wakeup write queue if necessary */
-	if (hp->do_wakeup) {
-		hp->do_wakeup = 0;
-		tty_wakeup(tty);
-	}
+	/* Wakeup in hvc_push */
bail:
 	spin_unlock_irqrestore(&hp->lock, flags);

diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index 18d005814e4b..164ae2c82b98 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -36,7 +36,6 @@ struct hvc_struct {
 	struct tty_port port;
 	spinlock_t lock;
 	int index;
-	int do_wakeup;
 	char *outbuf;
 	int outbuf_size;
 	int n_outbuf;
--
2.25.1

