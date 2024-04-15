Return-Path: <linux-kernel+bounces-145009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E68A4E18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A91C2B21BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97039679E5;
	Mon, 15 Apr 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="RbcNMVLx"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6185FBA3;
	Mon, 15 Apr 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181866; cv=none; b=lO6e2zUEXKtcpDlVK2R4tsEjsfYbHFXy9scMCn0WjoGE8mFA8sVpJKLh4kcBi7K6t+DiZi2GhBFMyV2woIrgqCnl6tPgEV5E8lN1t/JcdVkFRbgd4SRIyOBMsB+llsjjAN+bOuZNWMcQC7AFdtS4iQVtRIZQ0VvwJMFX8r6GY7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181866; c=relaxed/simple;
	bh=rKmkWc4e2EhEBiayogKPrTMTuUv8pY/OTgZiEvSpCqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=su+d8TTtqBVRLl0+OP1Kr8BeiBz7t2cfjtS2KSbRoPROlMhTzZiADGu0Tdl2RlLOIqHNKn+CXCKqejS5816+cagB8MrhqltpDYPHob61V2drj4gmw01YJBHf84tavhe+/giFUv6SoeVEX7q87rDSmtSGMy7uGGY3uKk/AGFx1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=RbcNMVLx; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 351C1108C941;
	Mon, 15 Apr 2024 14:51:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 351C1108C941
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1713181862; bh=EUA97dIpRpSS5ssM3JPMExLE+bnjf2A0BRQL9P73M7M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RbcNMVLxg0wDzOnqRW/mWGVBiKHiywl+M846Jnaa8GbJ/wu2RdXn+120So474KIrP
	 b39vvz2nD+tHmBO2oOVfME/cu5KMnyS2ubwdvHenwMv99nqDJKfOfRyuvVAZcwVnP4
	 GXuSHpFk1uDsS0IrCT7nAGnZnkiw0oBmZGQ1Yxys=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 3077F319A99E;
	Mon, 15 Apr 2024 14:51:02 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Michal Ostrowski <mostrows@earthlink.net>, Guillaume Nault
	<gnault@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com"
	<syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com>
Subject: [PATCH 6.6/6.1 1/1] pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Topic: [PATCH 6.6/6.1 1/1] pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Index: AQHajysw5WgBL16JkEKoSJihSXK1AA==
Date: Mon, 15 Apr 2024 11:51:01 +0000
Message-ID: <20240415115100.3914582-2-Ilia.Gavrilov@infotecs.ru>
References: <20240415115100.3914582-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240415115100.3914582-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/04/15 08:48:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/04/15 09:42:00 #24801259
X-KLMS-AntiVirus-Status: Clean, skipped

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

commit dc34ebd5c018b0edf47f39d11083ad8312733034 upstream.

syzbot reports a memory leak in pppoe_sendmsg [1].

The problem is in the pppoe_recvmsg() function that handles errors
in the wrong order. For the skb_recv_datagram() function, check
the pointer to skb for NULL first, and then check the 'error' variable,
because the skb_recv_datagram() function can set 'error'
to -EAGAIN in a loop but return a correct pointer to socket buffer
after a number of attempts, though 'error' remains set to -EAGAIN.

skb_recv_datagram
      __skb_recv_datagram          // Loop. if (err =3D=3D -EAGAIN) then
                                   // go to the next loop iteration
          __skb_try_recv_datagram  // if (skb !=3D NULL) then return 'skb'
                                   // else if a signal is received then
                                   // return -EAGAIN

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller.

Link: https://syzkaller.appspot.com/bug?extid=3D6bdfd184eac7709e5cc9 [1]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D6bdfd184eac7709e5cc9
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Link: https://lore.kernel.org/r/20240214085814.3894917-1-Ilia.Gavrilov@info=
tecs.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ppp/pppoe.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index ba8b6bd8233c..96cca4ee470a 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -1007,26 +1007,21 @@ static int pppoe_recvmsg(struct socket *sock, struc=
t msghdr *m,
 	struct sk_buff *skb;
 	int error =3D 0;
=20
-	if (sk->sk_state & PPPOX_BOUND) {
-		error =3D -EIO;
-		goto end;
-	}
+	if (sk->sk_state & PPPOX_BOUND)
+		return -EIO;
=20
 	skb =3D skb_recv_datagram(sk, flags, &error);
-	if (error < 0)
-		goto end;
+	if (!skb)
+		return error;
=20
-	if (skb) {
-		total_len =3D min_t(size_t, total_len, skb->len);
-		error =3D skb_copy_datagram_msg(skb, 0, m, total_len);
-		if (error =3D=3D 0) {
-			consume_skb(skb);
-			return total_len;
-		}
+	total_len =3D min_t(size_t, total_len, skb->len);
+	error =3D skb_copy_datagram_msg(skb, 0, m, total_len);
+	if (error =3D=3D 0) {
+		consume_skb(skb);
+		return total_len;
 	}
=20
 	kfree_skb(skb);
-end:
 	return error;
 }
=20
--=20
2.39.2

