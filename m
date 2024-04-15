Return-Path: <linux-kernel+bounces-144731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603C28A49E8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A571F2499C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32D938390;
	Mon, 15 Apr 2024 08:11:49 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F412D054
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168709; cv=none; b=MnpawxWotj3xA40IIfyYUCJ7kSNXtuCW0QD7ahDyRBoqxtGwfQgu3VHy3UGgfWIVnFSTMxoI8lIyawj0f3Act5uYMg6omtmz11t1ovaflgKxv2Wj0OiMDyBWuvOISQ+OT9JT4KWvLyn5QHQSWuArcy+AzX06lVDd/AYPfHsQqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168709; c=relaxed/simple;
	bh=UP37WZdS0HSvhRjlqMIeT1RX0dGMZ5SUoT+7JEnJZak=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=qFNKdHC9hhvpGDIuLQ1W7+dJuTMpyc0oR9FPeJOqqsg+xR2mn3gRjWtoBiamN3kNY2jRggspey8GjdVsRx/PWU8L1E+Bi6AyBL9gBX5/FVMxulZIfVYVJff5kMFm5dQxLWuJSb6DTQCtzgbcY3yzXstoFObgN/quePkGdxuYZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4VJ0Hr1CMHz8XrXK
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:11:36 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4VJ0Hh3JRfz4x6Cv;
	Mon, 15 Apr 2024 16:11:28 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 43F8BAi3077398;
	Mon, 15 Apr 2024 16:11:10 +0800 (+08)
	(envelope-from li.hao40@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid31;
	Mon, 15 Apr 2024 16:11:12 +0800 (CST)
Date: Mon, 15 Apr 2024 16:11:12 +0800 (CST)
X-Zmail-TransId: 2af9661ce120659-9735b
X-Mailer: Zmail v1.0
Message-ID: <20240415161112945aW_GWw4iCWkUKN0lMSy-k@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYzXSB0dHk6IGh2Yzogd2FrZXVwIGh2YyBjb25zb2xlIGltbWVkaWF0ZWx5IHdoZW4gbmVlZGVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 43F8BAi3077398
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 661CE138.001/4VJ0Hr1CMHz8XrXK

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
this round's tty_poll). Unless the next key input character comes,
hvc_poll will be executed, and tty_wakeup() will be performed through
the do_wakeup flag.

Signed-off-by: Li Hao <li.hao40@zte.com.cn>
---
v2->v3:
According to:
https://lore.kernel.org/all/2024041531-caliber-overreach-2d4e@gregkh/
    no change,place version information below the "---" line
v1->v2:
Some fixes according to:
https://lore.kernel.org/all/75dff5cd-7b0e-4039-9157-8bf10cf7ba29@kernel.org/
    use tty_port_tty_wakeup() instead of tty_wakeup() to wake up tty

 drivers/tty/hvc/hvc_console.c | 10 +++-------
 drivers/tty/hvc/hvc_console.h |  1 -
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index cd1f657f7..cbd234847 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -480,7 +480,7 @@ static int hvc_push(struct hvc_struct *hp)
 	n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
 	if (n <= 0) {
 		if (n == 0 || n == -EAGAIN) {
-			hp->do_wakeup = 1;
+			tty_port_tty_wakeup(&hp->port);
 			return 0;
 		}
 		/* throw away output on error; this happens when
@@ -491,7 +491,7 @@ static int hvc_push(struct hvc_struct *hp)
 	if (hp->n_outbuf > 0)
 		memmove(hp->outbuf, hp->outbuf + n, hp->n_outbuf);
 	else
-		hp->do_wakeup = 1;
+		tty_port_tty_wakeup(&hp->port);

 	return n;
 }
@@ -739,11 +739,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
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
index cf4c1af08..6622f71ba 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -36,7 +36,6 @@ struct hvc_struct {
 	struct tty_port port;
 	spinlock_t lock;
 	int index;
-	int do_wakeup;
 	int outbuf_size;
 	int n_outbuf;
 	uint32_t vtermno;
-- 
2.25.1

