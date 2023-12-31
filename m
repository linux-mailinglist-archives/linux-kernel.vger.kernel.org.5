Return-Path: <linux-kernel+bounces-13769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAB4820C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE818B20F45
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D748E9470;
	Sun, 31 Dec 2023 17:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZsebrwNL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB298F57;
	Sun, 31 Dec 2023 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704044892; x=1704649692; i=markus.elfring@web.de;
	bh=DxIaqkFvyCP4q3o29hYuSHbxCSE+JDd8CW1vm0ANeu4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=ZsebrwNLwowD6n33dhC0GiBXR9OauHocAJjcGlzGMjGmYSO/pTVzUOU6XyosUoMF
	 JqfGtcFR9+Fp0NlG1IOnrvV9T6xF7kN1yz1+xhytd6hjAOoBOE+s86ybPEPB/EBSw
	 29fJsCkopionzu9JIQmJWsHyZN3YyTH97xY7faCFlk/ljwaiQ5n/rtnS5bEDkIVkW
	 GCiDfTE/82OCDMuMYOOV/77hVo4haUwYIIUvBsRvJK8ZWWtj2sabkrwPusXNiY/Ge
	 QiVcAQ/8Yh/uV528tPOgZ+Ruh70t9/Nt5duRpXGoevQbJJH3Pj7qrbebddwWrelSX
	 OGcDcEHDIxtTf0+8Bw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MxHUC-1r08g81Ptg-00xmWS; Sun, 31
 Dec 2023 18:48:12 +0100
Message-ID: <d250255b-fd88-4ea9-aa08-bc8d911143af@web.de>
Date: Sun, 31 Dec 2023 18:48:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BPATCH_4/4=5D_netlink=3A_Move_an_assignment_for_the_var?=
 =?UTF-8?B?aWFibGUg4oCcY2JfbXV0ZXjigJ0gaW4gX19uZXRsaW5rX2tlcm5lbF9jcmVhdGUo?=
 =?UTF-8?Q?=29?=
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
X-Provags-ID: V03:K1:CQ9qMA/8hempdUNkAURlBEHPPhumiz+JPok0x077qDtK1n4Nn4M
 7e3Lq5moDaSVvvQmgPV1lD0bo/wZg2XRLt3vyiFHR5tvjWoDlmHkF2a4K+y+RLBSGuYX0NJ
 fsdQj9DNkVgA4UJeQdFSvXOmIUIDKGnf3qXsZ2H056HJM4IW/NMObVOU39TEsi/olm/0WDp
 sWUO3HS9ALwHQje3yWOOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:04G/Mo8NypI=;ESAuPWEakwRUjaQfehxGcf2D2Vk
 3begh/m05m7c7+oZ4sh68mPFNhtQV1WG3aXHBMfTiv6JHCFqLkIwgSXzkpBm1oyCduIuLH6Jt
 +RHlWub3yeOHJ+cnTpUgj8r6re7OlKfr8yIXsO1+LiCAfGswpSECXu4q24rItiEKrviaWiCmi
 rBctdCqP+1Tm7KXDuuPITAy4IAjZC8HNeFgei+mRISl0ISooRsM/Oan96iXML6L2JVPjbGicJ
 jJ8OZB0Ucu7qLn+fpZFk7lFLW7BVVQhACxwkt6X8vwewY0FdoNBfkTIv8l7oAfR6AWfkfwHYC
 2R/Gf4fHyQ74lYM/KhjX1UTkStDhT1xx2PdBRRp9q4MPh4eJqgFkK2xoxAsdT8vvYqRwbFCM4
 fGLgt3SjMhjIjRiawzhEowB9ppvNmVuilooi9Wx6dWmT/uVcM+Xq9Rdyi2MA8knPprmezd/tZ
 ZjLC5NN4HeRPNBHf+UNRyv50+VSu4zMLC0BA/1FP0YazhDq1bVqqdebrp/RWwS/+ZOqihCTfG
 rhqhxDd5Tlw1iaoab1lfRpGh+F7d/UVSOpmUn+uM02IeAyMQoo92tZnSBxqFw9LV9PsczX2nL
 QTuEbqxrpn1ukn3H+ezUgh28yIwAb4LPzbSPGz8HKEkQHiEQHf8ElH5aZjYIaISl8blcILsBF
 MFoKSztGoIszzodIQDENpVvaM4qTB8sV1cL+WfPMchmJTWCzcH/uh7DB7+kGzQ/CCWFqmjYSG
 qGvOdD5BvC9v8Izin4IH4gDkEAfsqBGsoYx7qOL8NvJL8RpeW4UPDHHERTaLFfnPh+u8XYZPg
 4LyCEOPqQbJ0cBIdCtDAx878ohZN8Q3iCtutSUC7WeZVI8Si4B9so9a8lmJ3aBdRoZsDQYQN7
 URNGLtvS9OtyAIxWXBY5s0rmEfmKB+IsEonZUoAWa5nOOtcQAlVGUF8uwnXOZIYytPsofO7Rh
 lnxJBJALSR7ayDmPgtuLX5qr3Ro=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 18:16:26 +0100

Move one assignment for the variable =E2=80=9Ccb_mutex=E2=80=9D closer to =
the place
where this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/netlink/af_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index cfddc9c6a376..12a0b6f8be19 100644
=2D-- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2019,7 +2019,7 @@ __netlink_kernel_create(struct net *net, int unit, s=
truct module *module,
 	struct sock *sk;
 	struct netlink_sock *nlk;
 	struct listeners *listeners;
-	struct mutex *cb_mutex =3D cfg ? cfg->cb_mutex : NULL;
+	struct mutex *cb_mutex; /* Serialize data processing with callbacks */
 	unsigned int groups;

 	BUG_ON(!nl_table);
@@ -2030,6 +2030,7 @@ __netlink_kernel_create(struct net *net, int unit, s=
truct module *module,
 	if (sock_create_lite(PF_NETLINK, SOCK_DGRAM, unit, &sock))
 		return NULL;

+	cb_mutex =3D (cfg ? cfg->cb_mutex : NULL);
 	if (__netlink_create(net, sock, cb_mutex, unit, 1) < 0)
 		goto out_sock_release_nosk;

=2D-
2.43.0


