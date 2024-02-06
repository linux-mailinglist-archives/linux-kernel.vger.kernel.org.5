Return-Path: <linux-kernel+bounces-55261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3447684B9DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA1B1F22B75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EB1339AF;
	Tue,  6 Feb 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cOQ0SDQJ"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82011132C1B;
	Tue,  6 Feb 2024 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234054; cv=none; b=OgXF71P9YXdLfg6bDJIrZA9J40i/hNw6OzJpE9NsljBYl9vjKQ7tJfmRNgVC/CGYEqyw7TNNukwiW2neBcBtED23KUV3YuKGmKyrZujWmCISNRecmbJaasHsmzcVdt8Er9ZK/Z/0h4pSsUt+OsCjxDcLr2AjPe51LG6vbcEdaxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234054; c=relaxed/simple;
	bh=7eaZzjz+wMCUEjnyDUB3tK901K9kXxGQ/BL0sTc923A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rKYrivgI24lk0nav2VKfUEnnlBHM9dogJKEiwVV9B76MNQ7Pl8vj+/9qahipx5njmBYs1uXqqmfJ8wD7VI5Yet6/waYX/0bLKaSSUbg1zLb9PoEzXHDJoVK3N5Cy+Zm13e580zIBGLQAwWB5t6qfo45hxc1fWZeEkgdgFc+CtBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cOQ0SDQJ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707234025; x=1707838825; i=markus.elfring@web.de;
	bh=7eaZzjz+wMCUEjnyDUB3tK901K9kXxGQ/BL0sTc923A=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=cOQ0SDQJMGw6cB+eoiYjY1HUTQgSn/XZm/c0ffcAKYO5cFpdpIRopiIc8CLezkIW
	 7jnl73aWjDtJ/Up4KHDhjdUTlel1Dl85PpeYWTqIyLnrUs8pvGaG8R3gmGneBuiHZ
	 5ZaWUr0xVRIePqmvbWd3JQCPaUoQ7DIWlnp+dBie9NuNjUyXXz5phD46iixCzn8gm
	 jPO0wKzm2Ar7JEMx+Xs3KEDn9AHCkd19keNOzsfPyoceOz5803tj3dk5cV1quUmgc
	 WQ+ZWgC+KRcC0+ATkdH4sVI57ZZLXjqWVFscTA4jddnVM3Ch9PJtDMJYHFr/qspjM
	 SUZ8WLRLuFqCUek6uA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkElZ-1r9dVw33mL-00kNmR; Tue, 06
 Feb 2024 16:40:25 +0100
Message-ID: <e4585b03-3629-4bd7-a349-f5471ebd8685@web.de>
Date: Tue, 6 Feb 2024 16:40:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] sparc: leon: grpci1: Use devm_platform_ioremap_resource()
 in grpci1_of_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: sparclinux@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>, "David S. Miller"
 <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4fc017e4-c695-40d3-aed4-cbf34d44e6fa@web.de>
In-Reply-To: <4fc017e4-c695-40d3-aed4-cbf34d44e6fa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:delG0OP3p85cu5vnIQwdHsvL/LKQZkLgZh9jHMmoyj2Z2ieh6lG
 8/dT9mLr/M+pNYBTkNChAYflEc1ItFeq/D/kvRuf2/e7N2j4GeZPqwlb1hQwHbq4FwMjBxe
 Zv94gYPqjexmo5puO4ySl7u3KZJt71vLMpUNFMN8eptVvmi4NbWiYtCO+yqTcQ4HqVftt2A
 UIoUZ1FDZ8dWPhidHpnZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cWb4CakeEFE=;GWpIyvQCZXa8OBC1L6tHGGyQvDw
 fDypwyDhiClo+6+q47h+fOgversLTaVVeehc+0ELLDL9++VJIyKswhBM1mUGSEpWrJUubT6o/
 WTzi+bUpwz1zEA75WEeay9M05+d4Cz8sUVVYKF3aZLhL+9CiCyw4dMD0L763LvwEc8h74efm9
 PcjzOGDqAeqK7H8LZ3KrFOLcK45/sG+lCGaCNord8Lb7zOAGbRpqyTd+q6yte8ylOUInuuuiq
 Se/IlSLj9GP12mbQcF3NfeBk2Z68s57jCDwGelr8JoU0X2VPa84ZZjKuJjUOulzsVm2O/IK0p
 oBUbjHSsXYqjuV6T4qcLpLxs+XND/XSPSGuCHVLwx42z4F/8tnoMCz2DQ6QGJN8XVdXrQk6A/
 Ex4FcP7g39r/EC+Xc92BZIm6D9kRt3cHecBVzFEmonkyu2ocTv21K9JfZgvnGASoEBm2MLR+8
 Vgv3+iLSlrkym48EJAksrk3FCI6u/gj+rUv/RtXZZTsVaD+QONe2LRhzDcAn5SdIdenvGho1I
 dYlp61T1r+qRLqBXXlnN7HRS3eK1bX6R9U9CAWOq3nC3ByakMQRIqh9EZgWhiDT2vhfsdNbGc
 V4HrY0QTVd3PXO1nSlPh7biirEpMUF18thxjPLkYh5PQh0EgKEOscb14VkxYPFn6N+/D1ZOzq
 Jg69j7PAgVvmciKwmSzUczSChUUimbmurLoqRNNa1oWlNjLPhuqUlN9AUG+kuNkJAOd5I7qsm
 sOxlRJulUAcMShIg3BKw0nbkDJBADdYqmnZFW7V6zAW61nBcimWPiZqjH9HCZ1nPIB5ZY1Xvi
 ecnrJtTgzansC4SlW3h/KqBRlN+l/scmcwp2JVDFUIIyo=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 6 Feb 2024 16:30:15 +0100

A wrapper function is available since the commit 7945f929f1a77a1c8887a97ca=
07f87626858ff42
("drivers: provide devm_platform_ioremap_resource()").

* Thus reuse existing functionality instead of keeping duplicate source co=
de.

* Delete a local variable which became unnecessary with this refactoring.


This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
The transformation pattern was adjusted based on advices by known contribu=
tors.

Examples:
* Doug Anderson
* Geert Uytterhoeven
* Robin Murphy


 arch/sparc/kernel/leon_pci_grpci1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_=
pci_grpci1.c
index 8700a0e3b0df..a01ecee18e1e 100644
=2D-- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -516,7 +516,6 @@ static int grpci1_of_probe(struct platform_device *ofd=
ev)
 	int err, len;
 	const int *tmp;
 	u32 cfg, size, err_mask;
-	struct resource *res;

 	if (grpci1priv) {
 		dev_err(&ofdev->dev, "only one GRPCI1 supported\n");
@@ -537,8 +536,7 @@ static int grpci1_of_probe(struct platform_device *ofd=
ev)
 	priv->dev =3D &ofdev->dev;

 	/* find device register base address */
-	res =3D platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	regs =3D devm_ioremap_resource(&ofdev->dev, res);
+	regs =3D devm_platform_ioremap_resource(ofdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);

=2D-
2.43.0


