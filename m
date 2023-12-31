Return-Path: <linux-kernel+bounces-13766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64C2820C43
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CEFCB20FCC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE1D944E;
	Sun, 31 Dec 2023 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZICg/2x8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212468F57;
	Sun, 31 Dec 2023 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704044654; x=1704649454; i=markus.elfring@web.de;
	bh=aLRR7U3/AFWimf4oVCx2OhgMuy/xKWfmXx3IC9naGIo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=ZICg/2x8jB8G+KIct6nZM1VB7yYS8bZKI8uVBgjZDgsHINnA996adoD4Yb6O60kS
	 f0g96Di7aDn+W/3ehNB0jrfNgrsWQTOE8+weRlUJrbbU8BeKbrrvc9HzUZLy5m2P8
	 WZILEv8b6f0sFodSLEhxztGhYr52mRXldwyRb27UBZYlLt9AyG5+bq8GiOBYoP/m4
	 U870N9NZd7T5TVgckvKpJum8Eqc4qzqfySSe6qokoQQRQPWqiKLQvBp3IKDt2/KZA
	 PUhIwVQLrjJiDv4kKMEN8e7ZWm2LkKmig5xL5bywy2yQpnRW76SU2/Y+Tdp6ClZPj
	 wUojxS92Rv5ST+hiaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgJK-1rOvng17Cs-00EAuA; Sun, 31
 Dec 2023 18:44:14 +0100
Message-ID: <223a61e9-f826-4f37-b514-ca6ed53b1269@web.de>
Date: Sun, 31 Dec 2023 18:44:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BPATCH_2/4=5D_netlink=3A_Move_an_assignment_for_the_var?=
 =?UTF-8?B?aWFibGUg4oCcc2vigJ0gaW4gX19uZXRsaW5rX2tlcm5lbF9jcmVhdGUoKQ==?=
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
X-Provags-ID: V03:K1:ksyD/iMiLeEsohqK+0cCAC5fthmh8rU3GpZGbK03fzCSWClI94G
 37s9Zn3bmBCTEv2pCWiDkyKTTAnUFupLBgaHD123O7VIh+wUSyNdMhI8snA5lb7pOIJe0+8
 CqUxbtM0vaAbEPtiBLJPNs1KNBKH1fJGNBUgeGPKqOZHjZtGdoEf24MwaFrJRCHVVHc+ewh
 FM6JFRq1R3r+r3aTKOBwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3vJBw6+nSHY=;FCw8Qqfha8upD8QrqFMCGDHpOeM
 FSFOuMqokXOUCvUYgZJDBwafuX59T1/hLY9Ibp6QO9aoqKI1xx+OA2urVj3EsmcWwQUnhOYle
 hsuamEAQPRDwNJAliMPJlF9PWoXvK33c9YXHffLpMpRfSyua0Jm4Zdq7ha1s5EMvp9OHmryyL
 EUscDbvHLIREli8RVjqi0hyNnN3z06nyRyYTkN3IHSjW6WZhM70TewhcSiS2lxbgdKdJLx7KE
 JKrtAQSTfKpwAo/lid9EanpneMSuJhFxKeWdUH/kyVT3rjdgtW6lIKdcBYRY7H6udc8p9pqjP
 KNQRtnVrpSlMQ8puURlQHiAeaVc7VN+DICpeDs2YEYJwCseyHoGyXhgZBB7cwb9EK6Ey37Jqx
 BSFGFZXyC5xGpU6lyR8JB4zuKXM6wRnzfayoU3dwO7DrGpkV22Gn85S2edDsfVd2kNqcht4X/
 zm9/LMdF3KNhFCzBpSGu+FW/ZWuc0lEiKxpg4USsXAeTKDDWlXnfnlpfCJJy3YX7mMrqIOV8E
 jQex9+H/lrvt2XXv02msanXiB5FytV/vH7CreghlX1Bmxk1eqA+2wx1IxLCh4eMAJ07H4BDNf
 kCzE7CIQ6fkxa4TzXhnhTD0uY2UYUTlvIuAIetCmYHWcPvycjI/+lgVTjEdIkpAxMBzORr4j/
 i663RPem2oGSHsZODzXYempljTIE4B9IXFnpSYCm/bOAiLzPYVwtRd2e3M4OfQtSP7If0v4db
 At2Se17pX2eBoj31ID5mtd1MiNNQ7034+rPmcTXNeQqf0sKYmFpxCgEPmEmOIDk7uW2ef8ZnA
 M7xKK4PCxMjhSBZYjbwmhpPdaH6DHDk6RsOPj+CuPsdx8yZFuJPlh78Hkz+LewzcYbAr4tkrP
 Yu/mHhZXugcOtmg6aGmtukzpL+lE0SrYIp4J7KrK0o+fJ1+YTsWCkHpSy5MaNajG3oGBfrpmd
 W7MQUw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 17:36:50 +0100

Move one assignment for the variable =E2=80=9Csk=E2=80=9D closer to the pl=
ace
where this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/netlink/af_netlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index c3f88015cacf..b71d9c21d15b 100644
=2D-- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2033,8 +2033,6 @@ __netlink_kernel_create(struct net *net, int unit, s=
truct module *module,
 	if (__netlink_create(net, sock, cb_mutex, unit, 1) < 0)
 		goto out_sock_release_nosk;

-	sk =3D sock->sk;
-
 	if (!cfg || cfg->groups < 32)
 		groups =3D 32;
 	else
@@ -2044,6 +2042,7 @@ __netlink_kernel_create(struct net *net, int unit, s=
truct module *module,
 	if (!listeners)
 		goto out_netlink_release_sock;

+	sk =3D sock->sk;
 	sk->sk_data_ready =3D netlink_data_ready;
 	if (cfg && cfg->input)
 		nlk_sk(sk)->netlink_rcv =3D cfg->input;
=2D-
2.43.0


