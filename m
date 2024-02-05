Return-Path: <linux-kernel+bounces-52758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E2E849C5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05985B2656D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961FD24A19;
	Mon,  5 Feb 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HjTm0cjI"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA42C18E;
	Mon,  5 Feb 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141354; cv=none; b=hY6Cn5MgMU88MJ0xr5NUOB0LjtIIqVDlLqyu/LLJKX9albzKJoTkmH3kIOybUcJXIyn9T/VQhQxsdJ+DlY/GMDfk+pRVwRcmqUbVqJHQj7WTW3ARkKGgui1CjaPZkqZKAhZ9Rl8qUT/AYU8CH3wNBrGXKXrM+KkyYuycccO2s1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141354; c=relaxed/simple;
	bh=OCQlC6fsw7RMniTUmuvaoqgcVSnBwtdH0tkNLVCdCq8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=omj06vOZfhsorxkbTyx6LDacbwX80QISf04KGaSh7peY9gT7M22a2Tce5HoXhqV6ooWJQHWajEqnm6v5IhRwUseIAq+e4//UqQXQKmFQmZa4/qr3dTArLAmXGqvLFhWXn3E7g9XuW84nt1GSd5dq4GcumgSfCiFDTqvOJGthlzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HjTm0cjI; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707141327; x=1707746127; i=markus.elfring@web.de;
	bh=OCQlC6fsw7RMniTUmuvaoqgcVSnBwtdH0tkNLVCdCq8=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=HjTm0cjIhCbiMgsdEel77y7fv7NC6Nxsj7jv8GhO97SXEgb80r7lEmSsnvClOo2k
	 VRo9narPy0zxhHgqewR5nWaWe1/RFPO8uhNXot/GYfNXg4/mfx9qGOE7ipoctl/QT
	 7ouWHRyhDooc+FoR8S4frgEy+udQ/exFyhlmIvp4OhY7oI+cjSyUBEFxCxYvaQieB
	 LhkMTbxEPKAPTQTLXlPgAUB5eulc/PTD6LCMHpE5o70wlqNsuYvazVxq+KOFlXygY
	 cfCED3D1wd7mfkxSWusHEb0HtYz+uWXaizN6O6dBrhoL4x85vo3Y+nEkCkawfPi9J
	 0yKqqnj6ySiWnpd2fg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBS71-1rjsY53cFD-00CvRd; Mon, 05
 Feb 2024 14:55:26 +0100
Message-ID: <f87065d0-e398-4ffa-bfa4-9ff99d73f206@web.de>
Date: Mon, 5 Feb 2024 14:55:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Wei Fang <wei.fang@nxp.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] net: emaclite: Use devm_platform_get_and_ioremap_resource()
 in xemaclite_of_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HpdtEuakUvahbDKCQGbUBcJH36NhioRvkShEPpZoWqMQzGg2Udd
 /66drifHYG+/g/EHez/UbXsmBO6j0hVXMihQB7PpnVN3Kse2RaGRq1n1IJLo83c6UWHPt5s
 qikcEeE6Nn8vGJ6t1+LCL6V9QE0S+Zo0yGsJ8wCOWwtjU5U5+7xpxcjAUs2W2cQ7M0/MfYj
 x/Ow/w0rihGGsmWWtwGjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DX5qSgtT2yY=;FgO4dz25//lf7S/k9N4m/F1fSkO
 +78p+4kNPIMGJRtNflgVgoo8qWGIRjTl7v4YzqPB0omKxGZYcRQHS4noibbgO910/zBmyQ6gc
 2mRH8lIwjH5IniM5IZf3sV2O/z4nGGmc0GoJyZlXe/gCjTs+9+aA/f1RhSlXkcobxzD5HWRyQ
 pJbNLEYl8APxI7gnybKG85B7hepN1/dXB4enZK9uRd0DpJaY4qLZeR7Ob2MLGv4qwBR4zotGK
 aDtz5wbpYvPWsmgfDoKcP4og+HBncBXPmw+zbsyWTIp2uWUZwUhJcetr6I18EfgT0pHscP9+I
 MYgXJ/RFbIVd5PUtzwEAHQ4W9hyCH6BUHC3lQjhwI6mFwpSNldW4PEZTCyDQySY+WYIJhmTsE
 74KAAOXWXE+pW3aIy+TCbj9yiazBfFnxMf0hGhoxhpOzQXRx/RMD38+YMgKpdJRHMWcvWv2nT
 e7hjhAqw+QFlZgKLBpMl4PSddZcJdh+MQXTDuRt+Aqde2pMDtv84pJjDUH9n6bkJ8YMsQBS0S
 7LJa0LXIPbVChJ1NiaWXZGHw+YjaT08Ok840dYMU0oKOhcKud4fes9nw8OeF/4ypEYQDFYIaF
 v/nSLHcxZ4G9Xi86aUJJKztZ0KdsmRmkkww+4C5Ii0yn6PLacy5Hlfz9jB7knZN0GnjZSYhS9
 wf1sAJc1rlqg74WElTVpPg0hj6l9HfZblAFKXiDPYmemE7EG1oNTq+LI8JVeuutSZGCKkZSvm
 KV/+6fWej+r7PuND9xJSZZBJx2rHyaL+wgT+zGftwKBCACI0cSx74W8ryUsdwGrfUdibxRzlR
 ZbImIoeCr/Io+lMei6EJiEb/cjz8qOscxadJIpCqJ3DiA=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 14:44:20 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/e=
thernet/xilinx/xilinx_emaclite.c
index 765aa516aada..940452d0a4d2 100644
=2D-- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1114,8 +1114,7 @@ static int xemaclite_of_probe(struct platform_device=
 *ofdev)

 	ndev->irq =3D rc;

-	res =3D platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	lp->base_addr =3D devm_ioremap_resource(&ofdev->dev, res);
+	lp->base_addr =3D devm_platform_get_and_ioremap_resource(ofdev, 0, &res)=
;
 	if (IS_ERR(lp->base_addr)) {
 		rc =3D PTR_ERR(lp->base_addr);
 		goto error;
=2D-
2.43.0


