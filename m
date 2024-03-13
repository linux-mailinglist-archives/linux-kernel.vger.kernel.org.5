Return-Path: <linux-kernel+bounces-101519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C28187A836
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDAA1C20BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65440860;
	Wed, 13 Mar 2024 13:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="WSrCbeXk"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE83C39;
	Wed, 13 Mar 2024 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336245; cv=none; b=dtkrxqVBAhPU3+po+xtngVY9K/u/9YOPE1WukB6hfzlNEmLsJq5qBgjpPVO6ADxRvusfsZuPLpqKZTUiTBiJe1U6iwcueThvd4lneJooEcqZztMDNsxfmiR6nZqJp8DQy2AUU49PAdpYaN3N6X94K+EojJvrlPO2gXMIpj0CY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336245; c=relaxed/simple;
	bh=yPqAe7ClhayYRrLN2CJq+cfkSc0n2HvZp2xKEfV+UR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D5KAQkHTKo0sI4LmCgzaR5SMSonPF/du4c6JtoJrfBTN/pfzZSKekRGVqq1UWjM7QP5d3b2bnPmOlfmjuTwHXQEZMd3lIbARtFwOvQOT7VlIEm9glMVCSGw13fCPj++xiOoU+Z106eT39izyhVLFsKfGrAM/M9A7zhTP7VjvE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=WSrCbeXk; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 3E84FDFACF8A1;
	Wed, 13 Mar 2024 16:23:45 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id H1TS0Fis9ARg; Wed, 13 Mar 2024 16:23:45 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id E9292DFACF89F;
	Wed, 13 Mar 2024 16:23:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru E9292DFACF89F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1710336225;
	bh=Q3mlrkprHQSqqe7ZzbpkZFoFX1OW7QRMBkhOjb+6+wk=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=WSrCbeXkAvXISeJK+KzWxdWYqFbr7juu33ozGTbEQ/MiuyQvMpNu9n2suLoizodtj
	 19BROhwGoadIkh3xPdQBcVmiMtmkM+VzIgo8yaG3bJIg9jObsF0pBHqQEajmwVx6rq
	 /H5yVc5YlMtP9aFqL+z3IsehxMWZrWXySKamnSlceKrRWHQSP6w4KwXhFRaFI7qimT
	 UXigrPTQ/BuKkJWlA+z3aZCN7ZlWXI6egbEhS8q0q8PSOO2fKafpBUlmUZMdJS9agS
	 CQ1xKsNuOM0lh9O74vhe8t1XjZ1xtiahR+Jq9WlV1NPYjgG4veybjLNNekvkfUyEM4
	 f8lQ4cUN45a/A==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id E4DEAnA0C_be; Wed, 13 Mar 2024 16:23:44 +0300 (MSK)
Received: from localhost.localdomain (unknown [62.217.186.174])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id A8892DFACF8A1;
	Wed, 13 Mar 2024 16:23:44 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Martin Schiller <ms@dev.tdt.de>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-x25@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x_25: Adding a null pointer dereference check to the x25_accept() function
Date: Wed, 13 Mar 2024 09:22:08 -0400
Message-ID: <20240313132214.48716-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To avoid the problem of dereferencing the null pointer in the x25_accept(=
)
function, you need to add an additional check that the pointer skb is
not equal to NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index f7a7c7798c3b..91bc5994cef6 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -896,7 +896,7 @@ static int x25_accept(struct socket *sock, struct soc=
ket *newsock, int flags,
 		goto out2;
 	skb =3D skb_dequeue(&sk->sk_receive_queue);
 	rc =3D -EINVAL;
-	if (!skb->sk)
+	if (!skb || !skb->sk)
 		goto out2;
 	newsk		 =3D skb->sk;
 	sock_graft(newsk, newsock);
--=20
2.43.0


