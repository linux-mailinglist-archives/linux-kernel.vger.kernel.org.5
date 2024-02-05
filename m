Return-Path: <linux-kernel+bounces-52666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2282849B32
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664B91F273C3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49AB2C1B8;
	Mon,  5 Feb 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Aa6kIfpv"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910FE25745;
	Mon,  5 Feb 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137710; cv=none; b=N21OZgDSHs8RidOTM602ba7biE6IMWTS5k7F3pnTI7WA+efUxhYqsOO9mTyrAiogllLahA1JjG9r+AxtKmGaQZomIDyxq0Qa3y7HgxJ4yYZ+8hzwiEG1+evvMtmboLXcJwJ7Jbea6rMr7wFSPVo2NLYPYesSZQauHUbO68XrVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137710; c=relaxed/simple;
	bh=ubxYnRTkDHR9gQ/MmRDSdOi510bYVVITttwnMFoHQBo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dpzRvDXZs3kO5fwiSXnPPJJzUyr3TIelBAhZFZ1YvLW+8glYy6j1ziFXjMyGozQCfcGcSyDEwgp3BRHCP021kEswQMjVZ3MV1j47mdRTxJ6ofgSkXycw9TDX0bmi3w3NajLH16E0vbTQjcuDm5csaISO41cr8XkgFdEoIVV5+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Aa6kIfpv; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707137668; x=1707742468; i=markus.elfring@web.de;
	bh=ubxYnRTkDHR9gQ/MmRDSdOi510bYVVITttwnMFoHQBo=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=Aa6kIfpvb253opFrQSAf9awwBYK1avsyqkrSFGALrUVQPhwSqaa8j5ob7qJ+/aMj
	 agaY40rOLo21Dwo6NTRKXoCRdNjXdqL6V0c5mf8v+3TpDTCRPAXgDsym1naj9Q2Me
	 k+4MDTHXip0epjZprK23EOLQ72h6j8Lo67iawQsdGUhV6t2MUcaLXZS7hYiYa0IOz
	 xL28g7QXxCAuEcSkkFp9WGGd2ZYEMh9yl4h6wjLhD29FXYFd+FnPeOJDM3AYeAU2V
	 4uvmDdn9L1RM5zVo8biFhe9NwhPxNDO4nlyT6FgCnCPyDaRn9m8Vhdh2KGvgFyBGM
	 STFEjlhy2yqCK6ub7w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml46y-1r9lhQ2xJs-00lklC; Mon, 05
 Feb 2024 13:54:28 +0100
Message-ID: <29e9dc0f-5597-4fee-be5c-25a5ab4fe2dc@web.de>
Date: Mon, 5 Feb 2024 13:54:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Gerhard Engleder <gerhard@engleder-embedded.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin <linyunsheng@huawei.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] tsnep: Use devm_platform_get_and_ioremap_resource() in
 tsnep_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vHzRAgSYM5kFE8q9ZgJf4a2rOZyWIl96TFDBb5SYZFTfE3kolAE
 rYzb/bg4F1yEXM9XiYZxDKia0/D2jkGB66sc2fxoswtsDQdMCVvzlMPh8M6X2ZHR9ej6y28
 BeORuWSl5QEWroybb/tYPaHbEmDEa4H0aaDLvaLvjKVCAVwzWFa1oAe9BXbCtF+NuptaTh+
 AxWVu+cWD4OTLbffmgdNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Yf5+cjo6St8=;bHOr7z08bxlZSe/lZ0lJhLOqphJ
 aZUwHMRBEwnJuCXU8v1E7VSeDNgIy7WH6RgIOdE1M9RD8kvI8pAixgMQLZGqFcZSgnj5ejxRV
 cRDawMA6JfOPBLF1pYSeG6/8BxiWMmKBgV6ohzbKkVht5VxezolJtsiq2QAdXfHw+hNoOagfT
 qWYN8LdXyIqeQBzTYpFAAK14/7E/e5mAAdQF+3JRRjoU4vrgOsPZ7wsaMliWMmlfI1uODKFPS
 Rvi9KTnUQyCX6tF14X1VB04vW+FzuqhUPP5ZiVlWhRnXSPqGxmBoJf8xMmtJM49HgL1VVevmW
 KJtaoOVSClivVDplBPECY9HOAlso/ZsmJuEc8lQVkJDwDsc7OMoDLO+aJEeFL1ElB3bHIC1uu
 7benc0h4Ny0Sfhqc0VwXZkCkiiDcNf2BwHosIEVlqZOKUUqNxjvttF+St35yI7UJLVQ4acjZS
 bH2jCO2NditzFDvpiaNkBlugaiB8jlwESIPMOVooRKstqtF0r8WvBA4jIYLiNnwPKxA9Xhzn/
 i2Lsz9NIOaabA8Xn9EWdozadLNQRBSYN8jW69V+ldR0/+iBqpFFuVy07gVGkdX+okFzjZPx9W
 NBQ7gnjb1/UV8hyZuhTVkeIExhrPgJZhqzr/ndpm7CZDAVkWQ+8/FQ2AUw15OgshYDTR45u6t
 PoHtpH/BKeC4nc21YYifFBSnHXPtRZUBbnDrEBnUH3W6NoCBNZJr8Aq9u+Gj6CxHpkc4WQCIz
 fE/i9kQGWlMlX6G4NvrRW/wVJbuMwMJR9gyWpN3z2gXOrYm02IRxDUgTE/MV+ZMqFOZxffybX
 5Vu6keUHvw9J5PaYmdQQvTXlANaNVOYHCGUa+tgPZStds=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 13:43:14 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/engleder/tsnep_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethe=
rnet/engleder/tsnep_main.c
index eb64118f5b18..498c4d47e0fa 100644
=2D-- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -2564,8 +2564,7 @@ static int tsnep_probe(struct platform_device *pdev)
 	mutex_init(&adapter->rxnfc_lock);
 	INIT_LIST_HEAD(&adapter->rxnfc_rules);

-	io =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	adapter->addr =3D devm_ioremap_resource(&pdev->dev, io);
+	adapter->addr =3D devm_platform_get_and_ioremap_resource(pdev, 0, &io);
 	if (IS_ERR(adapter->addr))
 		return PTR_ERR(adapter->addr);
 	netdev->mem_start =3D io->start;
=2D-
2.43.0


