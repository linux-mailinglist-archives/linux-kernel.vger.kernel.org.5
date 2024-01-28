Return-Path: <linux-kernel+bounces-41650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DC183F5E1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6960D283A73
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A5D1F955;
	Sun, 28 Jan 2024 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VO8NY6o1"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8A210EC;
	Sun, 28 Jan 2024 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706452566; cv=none; b=DFPBdQgZd3WmpsfiLu2iEJqFWlL1JA0fU2ZKYTDSjO1E3sUSfkIcgPpP1sAYaLhGxx4A/7gOTqjRh0F1tUa/0uDlBqGX5lfnEE2ijya9w/y9fAHhHE4LIT44x6pvh3Q6ug8biuNB+7R20dTQUqZ888FJVVehFgOev5ypnm901mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706452566; c=relaxed/simple;
	bh=aDhTgz/lX7Bkp3K6CN8opRhhDbmP/3uNFck7LgFe5CU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=SHoJGbxpB9jKHkQs0Pu7ViYM1jI8HMTvc8kqVBPTZQR4Q4DbTYZjzBBshUrVlG8HlK9UQsLOgfTr4Hi0zvAc7Bn6MZIlVrDeqfJRByNEIERHoGwC3mNHdsHdI3sLMEOMywp3VlPKjE2NkzW6FoD32OSlmAvB9mtzMeNWfJ7WfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VO8NY6o1; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706452523; x=1707057323; i=markus.elfring@web.de;
	bh=aDhTgz/lX7Bkp3K6CN8opRhhDbmP/3uNFck7LgFe5CU=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=VO8NY6o1qfC2CM0mraF4vuZSgvoWdJoqLKjcPonwW4G3xN9mhhLA7klmNPWkdcRu
	 BuDCol+0gbX7dxft0pVjLcXbx90EUgQib0YZXNGT37h0/OTfxjzIVbVJ2BNBuJtpw
	 VOtlqmLf+p+MwdxBDdvzlucyi5Gt9YtlRjc2eLPeT/Lor8Y3UEZBBPGjTlNdIo59k
	 W2tuiZZ7Xl1o65QhoIgILPAW5opsS/nQtdjqoBc191VFHSIx+3YTJ7pgXWisiQn3i
	 81FZygEvhzTYbAktBEmnjWVcBhr7xXUy9WgjPOMde8QUoy8ouZ9jyDPDq9vLOHdCF
	 M6N85Nt9gJt6kU7hkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1qvJfO1p33-00ZKhY; Sun, 28
 Jan 2024 15:35:23 +0100
Message-ID: <e5d9404d-eb3b-4d35-a027-790229986cdf@web.de>
Date: Sun, 28 Jan 2024 15:35:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-arm-msm@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Amol Maheshwari <amahesh@qti.qualcomm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Cong Liu <liucong2@kylinos.cn>,
 Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] misc: fastrpc: Use memdup_user() rather than duplicating its
 implementation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zZMLk8SHPdlT/iFiSdZ96fIUhgyIRJ8/yu4u6XWi3ISKCeTji/X
 vMt3iqkqVdSwkBiDBsO/x+Ck7VH2nS3ezzOngZ0DIh7yee2GtGAz9PVLntmHT0RozzKwGyl
 eECNFurF6wnnyJSkZFsKew5FHOjE+liIy9+ZzZ90Jub/+vC1qiDKdlIbOI0egQcifDuRtw1
 MqiN+h5G2QU5coCXi2HHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nBeIRC6Gwa8=;SOz2uok6iiYTx+oo4qTbZNPc9z+
 XA9ypAbomu0MU5kJNtcwx+69odXvSk3UOsT+aB1bHPx8AWPDIebHl9o6Ux+NxLaw08bP/T3uB
 uzEZlo9Ug47s4A4VR1ChhfGRht8kLvJuxhvZLjFtP61q9SSgOx0os3s3kAUqAhm7hgt6Zrc0w
 6rVrU+6eSm+UdZQC2zZTtWfJOkHbBubCrs/NkTQwk4E+08Wy6C6f/q9Kj0jnvBPN7t3VqEbFu
 shT9Mkr4gyzRAGA6q1atE+gzzdPDPZKWDdgFcrmBxf5dXI7c1nFo2htop5hhPuiG6Thpn2cpl
 k9P2oEYQ+Mj8aBv4feQl7ONYNjCEdor0mqP2jUtKYhvN6kVWAqTD4d3KgDCEuatmSKsPlxPdt
 +uweEjw9Vq45Cdf8sdiSlqfXZaRqnn4FUEcJ9rec6ZmXzN+k6Qoag6IDqm9jUl7Gnq6XcSwtq
 4pa8Co6rvj4MNnrbSHZ5S/cNl13cleTWO3jH0cQpK+njtx76NOAZB+esdfEVPPOWnwBRuDYg5
 IoORNqAa2meEx8tea1hAVDcZiOsyvqTr6ZIa+01LPimEHjjPbjpoEVyeBKFiDA5MuaTO7yPWp
 pJTFQbQ2fcbzUAfeJ9+27h7fs+8QBUBMN62mUUGesmZ1Nbc1yFMU76haTBas4F5WFisWyjQxn
 x83c2w+y8N0n7NgdzA3i0ZMVu9wybfPoWho9G6HVqGmVXJ6XUyZnpJKWFmaJCVD4KumLQvi9H
 U1r91xuGWx5RTDFAXYF5yRWB3ucL1v8StYFavKAxiIZjEOn9DauUovoa2uKcQ1571gcR/R7Vl
 7Yp9IUgn1RUrJa95S3uz5xq+Evuat37N6AfAxv9nHJIpN6wG9d2AEzuz3EhUJ/kXnx6MnMQES
 VUbH3hlcJm4vjRpHcOZXRLqY7Wpj1dGPG/c0VREF0VSTS9EYNmXYkEXBhFtlq2TiWGOkXiOtR
 KcSBZNTSSbXksyR71YBE/Zn8M8M=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 28 Jan 2024 15:17:03 +0100

Reuse existing functionality from memdup_user() instead of keeping
duplicate source code.

Generated by: scripts/coccinelle/api/memdup_user.cocci

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/misc/fastrpc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1c6c62a7f7f5..83da6ad4e541 100644
=2D-- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1260,17 +1260,12 @@ static int fastrpc_init_create_static_process(stru=
ct fastrpc_user *fl,
 		goto err;
 	}

-	name =3D kzalloc(init.namelen, GFP_KERNEL);
-	if (!name) {
-		err =3D -ENOMEM;
+	name =3D memdup_user(init.name, init.namelen);
+	if (IS_ERR(name) {
+		err =3D PTR_ERR(name);
 		goto err;
 	}

-	if (copy_from_user(name, (void __user *)(uintptr_t)init.name, init.namel=
en)) {
-		err =3D -EFAULT;
-		goto err_name;
-	}
-
 	if (!fl->cctx->remote_heap) {
 		err =3D fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
=2D-
2.43.0


