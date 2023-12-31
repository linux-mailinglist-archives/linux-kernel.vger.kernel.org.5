Return-Path: <linux-kernel+bounces-13767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2003820C46
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623121F219A4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659B944D;
	Sun, 31 Dec 2023 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="kgAISiG5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CBB8F48;
	Sun, 31 Dec 2023 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704044770; x=1704649570; i=markus.elfring@web.de;
	bh=zNxLcIyTelDfgCWbRzOiNYP/OsCyug4PyGLRPHXHIgA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=kgAISiG5TUD48eiMkvyLXJHBZaaqVgO1aqqr/bfgByJKmIxto6bfhEkQ4Jrih3eP
	 bqYsXbC5BYj3XVyN78DyWZg9MMaJsTJ++hkaC1w2wDD3wHkZSo01HOC2kFBgkXyhf
	 WrywTw1OhJrEtc29Z3zYyl6ximTGQ6YrJLMW+m1ANtdKggWvg+YLFHj5hK1l6P3Jd
	 a8X4MHkZMVGt3dfsn/EV3z2/01W7xZj0x05yu4kdi7f5CWxzwTgLWTZ9boixJdO/h
	 ovMITJwFeAlWP6FrTd5DWbJHclP571w0hXTFwKUrvfLsYHdQOSAzk6iwexJxEIqR6
	 QfdMFeW67zuZbhjmdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxQV-1rOeqf0ukl-00Dtmh; Sun, 31
 Dec 2023 18:46:10 +0100
Message-ID: <57779d2f-0d39-4c2e-8718-3c9242177013@web.de>
Date: Sun, 31 Dec 2023 18:46:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/4] netlink: Delete an unnecessary variable initialisation in
 __netlink_kernel_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <90679f69-951c-47b3-b86f-75fd9fde3da3@web.de>
In-Reply-To: <90679f69-951c-47b3-b86f-75fd9fde3da3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LYJBemVScIDnkTHCBaOU7X3PN9jEiJKMRkwsrbqrrh1trsJmQbL
 Xkz3LO9XKgdMqnZds9v3GlwhFnfWk3nX7DW/qzr6U29o2sZlj3RjMMo1HWeIvTNmfQfwWT2
 MRIDtjEgVlSHSqWN7kOw30XZYSOvDQL05WfCj/DDW6lJ6fZ1bYtPM+XMkw7l8Z0BhRVcJoK
 BmojJ6Yodgb75Ixa1fRUg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gjC212gal3M=;oZQAD3kGRYWDqKtckJnzDSnm7wh
 kgi/6vhcQYFeUNX+m1Rhf7I1MlYO++FJv/bbCDUWXIsLAgALPtWMJuMAWZaMl+bzebt1E/Xhn
 Gog+AgirnC1dOgvh1pH+gvtu3xfNxZFaAT0n8/0nCi1Db/3XWH+Oh8NdZ97hJWALa0zH5tlBW
 FaPN8oANtJHjTPLMzRfj12Rxxm27Ao3vuleWQ7v0/HwclwnXQz631GNvIpgrnX56G/po9a4bl
 TamdEFNRVr0qt+Njk3ozT7wpas56mTV9+ajJb0Y6Q7DDle2yZl+8LliatC/iUp3lt/ON52b8G
 YJpUWe9hcQ5ZTWHDZgqC9GcXmIqny9MYQLbuH4iNjzyHwxAEBDDv88HB7bwIsY4RcHW1dbnRl
 WDfzWwFfHd7/Atsz4uBOxDXFVyw/1xlIaOtEBy+uXJzKt5vKGZ08U/ltU3RA9yDftLB2EAJct
 SSmKxvUsa4heza1Gx80kLGbbjoRGi6ESOHFFY/vXHCJfu9MWROUFjG4/nhnjZVbdWrfUN3uLw
 VYar5n+aFMCvqFAcoD8d3QIEShkD2QOnDQix0uZh1Adk2BJT+5kLL70h63IzJTousjDLey6O9
 F9i+Sn67qkXhggNfzKwyIhvTHkXJ25AXXmNnOHUAR4mKxbHdOQAowf6MvM3bEr0i55x7broO8
 lN68vF4BTG3udAPgR5viuhWGdBid/bDBjI79ZJ+rFP2xeTXlypSG23BNIemvvP9D1SwdXBcZ/
 1arQXkSKpa2tdsWjgNYW+KcNoVtfg3vUUbkZB8EIT3vpXjoEaLqHD2NlOHi3iJsyPl8ZKcS61
 jh0zuxRRF9F00/O55JNdaAzZ5pQfE7LSLGu0RcWj17m/SRxC567Ogic2IMWa8r6g9vm63AraY
 A+0u5UHK9vtLwV3X571b6VWN8wpB4EnbXsb99gxuAXGrN1iujKvhMqSG5L+/YM10oex4MjfcV
 0eHUTQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 17:45:00 +0100

The variable =E2=80=9Clisteners=E2=80=9D will eventually be set to an appr=
opriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index b71d9c21d15b..cfddc9c6a376 100644
=2D-- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2018,7 +2018,7 @@ __netlink_kernel_create(struct net *net, int unit, s=
truct module *module,
 	struct socket *sock;
 	struct sock *sk;
 	struct netlink_sock *nlk;
-	struct listeners *listeners =3D NULL;
+	struct listeners *listeners;
 	struct mutex *cb_mutex =3D cfg ? cfg->cb_mutex : NULL;
 	unsigned int groups;

=2D-
2.43.0


