Return-Path: <linux-kernel+bounces-41035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06DF83EA8A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373AC287289
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BADE11185;
	Sat, 27 Jan 2024 03:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xqH1Y6Kz"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046ECBA55
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706325696; cv=none; b=ipbxP6hoykGJqR/cANMxI1irl46rZE0tJ34t8y8zPLQFBG6jBIFH559vSHK+CxkyHgEftx9JK6PUBwTo6Zvoj4XY0RhdgFXxGyiQWk25eX1SBlGbafv333Iu1oCR7g/f0ZQn86d5Q66XuRVigycRIq4krqnc5f59qlQWVIFbgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706325696; c=relaxed/simple;
	bh=swUlTqvn833cLHhUHmUuWd12Cvnrh/3sSg3/RxNnToI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fU2qTD1klWADhXawpQ8lN++/uKHaDuDx+/X66PVHC2bTbYT1BxSpvTPvkjth7p9C/by6U9ZukNXsvbzNEZiKWd2zBCE06DzVW/o4IdyZd4Szj31DUUDl2xNZCzgOVSfRuHSdwUs+SqA2z9ZT//aOanS0W7+ek4vamRgZSTUFsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xqH1Y6Kz; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1706325687; x=1706584887;
	bh=zo7WPA6m4On219C49bdnFWajxsWtriZPFto+n7Ao+W0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=xqH1Y6Kz533PuiWbOUu3E5ICObl6Lj6ka2tsHXeVjgOmBofb0CcDTjh4x9EpOV6yS
	 yRJvVk4eC1OabSn1t/8Rg7G6s3AFGqd1BiSxuHDypK7dEPW8roasVpLunqzVonMIOk
	 ehLgtS/7EJ2O6UdU6MFTuIiwxWPxd4rjokIUPrXRpFD6bEoWkuNeI7H4+Q8ZX1ZgQ/
	 fgnwffdoBacsk6iQUgqhyE1xzMu+hsTdPTpIOYTLbLkyy0IXjgLFFcVJSiJrh9yBai
	 U1BivUVYPAj+A7kzcNOzPP98WwZuqMvgarsXszF7kCUe5JqelQu6JfIVWqTKkBbp+1
	 89Xn08yZfRX7g==
Date: Sat, 27 Jan 2024 03:21:09 +0000
To: tipc-discussion@lists.sourceforge.net
From: Carlos Ortiz <jmp0x29A@protonmail.com>
Cc: skhan@linuxfoundation.org, Carlos Ortiz <jmp0x29A@protonmail.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/tipc: Remove Documentation Warnings for `Excess struct member`
Message-ID: <20240127032058.3030-1-jmp0x29A@protonmail.com>
Feedback-ID: 24524753:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------8a7865ae482313782a62a2e5020667e351c62284c97e1e61b255d216c997144a"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------8a7865ae482313782a62a2e5020667e351c62284c97e1e61b255d216c997144a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Carlos Ortiz <jmp0x29A@protonmail.com>
To: tipc-discussion@lists.sourceforge.net
Cc: skhan@linuxfoundation.org,
	Carlos Ortiz <jmp0x29A@protonmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:TIPC NETWORK LAYER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/tipc: Remove Documentation Warnings for `Excess struct member`
Date: Fri, 26 Jan 2024 21:20:56 -0600
Message-ID: <20240127032058.3030-1-jmp0x29A@protonmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0

As far as I can tell,the struct `inputq` and `namedq` were never part of the `tipc_node`,
therefor removing the documentation comments this will make the warnings for ./net/tipc/node.c when
running `make htmldocs` to be gone.

For socket.c, and documentation comment was added on commit 365ad353c2564bba8835290061308ba825166b3a
but the struct member was not added in addition of removing `blocking_link` also move `dupl_rcvcnt`
documentations a few lines up to match the struct member order.

Signed-off-by: Carlos Ortiz <jmp0x29A@protonmail.com>
---
 net/tipc/node.c   | 2 --
 net/tipc/socket.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 3105abe97bb9..c1e890a82434 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -86,8 +86,6 @@ struct tipc_bclink_entry {
  * @lock: rwlock governing access to structure
  * @net: the applicable net namespace
  * @hash: links to adjacent nodes in unsorted hash chain
- *
 @inputq: pointer to input queue containing messages for msg event
- * @namedq: pointer to name table input queue with name table messages
  * @active_links: bearer ids of active links, used as index into links[] array
  * @links: array containing references to all links to node
  * @bc_entry: broadcast link entry
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index bb1118d02f95..a022719882ce 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -80,11 +80,10 @@ struct sockaddr_pair {
  * @phdr: preformatted message header used when sending messages
  * @cong_links: list of congested links
  * @publications: list of publications for port
- * @blocking_link: address of the congested link we are currently sleeping on
  * @pub_count: total # of publications port has made during its lifetime
+ * @dupl_rcvcnt: number of bytes counted twice, in both backlog and rcv queue
  * @conn_timeout: the time we can wait for an unresponded setup request
  * @probe_unacked: prob
e has not received ack yet
- * @dupl_rcvcnt: number of bytes counted twice, in both backlog and rcv queue
  * @cong_link_cnt: number of congested links
  * @snt_unacked: # messages sent by socket, and not yet acked by peer
  * @snd_win: send window size
-- 
2.43.0


--------8a7865ae482313782a62a2e5020667e351c62284c97e1e61b255d216c997144a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmW0dqQJEP/88erosmiBFiEEK5py9W+SnfjCVyLD//zx6uiy
aIEAAE3RAQDz1vnRwvq19AGgFyW2nVa6d0X9Nv5jXSb69oIW0An7EwEAujd9
ieOXKgSS2WIq3RyNkf+MmZc+8eEgsauBWE3nzgA=
=7v4p
-----END PGP SIGNATURE-----


--------8a7865ae482313782a62a2e5020667e351c62284c97e1e61b255d216c997144a--


