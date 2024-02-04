Return-Path: <linux-kernel+bounces-51885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC18F849068
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4501C1F22526
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EAC286B3;
	Sun,  4 Feb 2024 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CItx1+7B"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7925561;
	Sun,  4 Feb 2024 20:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707079012; cv=none; b=O7NhdxghAk1jO7CdQzOXO2Lzk6GSvTSbybg+XZEtGXnyyhQhj//E/vvY/1prCH4e2XkhcqbsqsDLmmrdmM4Nc3iCiL/5P6Rv8UtSB6SbxSvsnVsOwDdMpEhVzahduCFUrM5F+rs1hQA/GGA1G12cAQSJyZGIu05s3tzLpjWnQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707079012; c=relaxed/simple;
	bh=Ilx1G8+/OD6Mgc6MdHQNSpZPOaKEMorfrU+BLjJ/kSA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qS7N/PxeatRqXjR5isJrHecm/Lip+0XaxExOxOvH6T6QJIcqod3tfsb0pHkXV0bDKyMsh9sNPM3HgM8BrBmhcIaUBo+dXMeFANXhb/cIKPfGmNVmf48HxPOgl5aOaj7zVz5etyqx1hPr6my4WltptZOfgSh13u/c8vz9G0TsH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CItx1+7B; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707078984; x=1707683784; i=markus.elfring@web.de;
	bh=Ilx1G8+/OD6Mgc6MdHQNSpZPOaKEMorfrU+BLjJ/kSA=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=CItx1+7BISU5EH0Lnu29RllhpcjGS8sK9oAhJagt58XV7T/AEmuRsxZWIIntmPzm
	 AjVapUsYjcmXZHFacOWDF2txJDLl25SwFolo6I8fPa+yPq4+d16hTMsHJtuFsb/1D
	 Zv8tbgOjzoTwtNvHcvEonOGdTq0+MQXEDDqd+utpUDl6PQQQ+XcA5R7BsAIfCKRwb
	 I+JoUGEbYI0bMcWPjfpbcMkucFVRCqzBhTOSxJunVqDoePM77aQImOt+HDykBFhXI
	 mz1yzfhnrgv0K7lZQAjybRgy8ojTkm1XyIECZmxni/2vvyVTNf2gzBlAcgSsvtbi1
	 /AdF58SAGyZGsqzD+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76bV-1rOByp0m1X-008URa; Sun, 04
 Feb 2024 21:36:24 +0100
Message-ID: <4fc017e4-c695-40d3-aed4-cbf34d44e6fa@web.de>
Date: Sun, 4 Feb 2024 21:36:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sparclinux@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andreas Larsson <andreas@gaisler.com>, "David S. Miller"
 <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] sparc: leon: grpci1: Use
 devm_platform_get_and_ioremap_resource() in grpci1_of_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SVJMfTPCnh3g7fnuQ8pj5748MRfDUayCBVjgfFWMNrfcUW1wCCM
 SC4GF9QzF8OSt1XLfcOQi4cj/j+jPT/dKPOii68qzna4ZUf231NjKZA7N+vCpCpxumZ8atr
 MP1oSlp9C57o8yJu+kbMP+Jv7+OnQthGMhM6cg4Rc1lqeZHclPKQ8OT2hpWUmR6JMJVXVLu
 xT5pI4MQb5w7vGrI6LVbg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rSHAwVOHKtU=;7buhA0WZXsvVc05bs/Ufqx9mSpL
 EgNbzdaLQgtPBpczJWhPKsW4VA2rrycH4S03mjm6sZcOex8W0cKleKYqt0G7hPltzakaxF5bW
 ehlAhrkWgnfTegULbGVFi7JgqPLuzk8Y3xZXYlmhAjFG0O+A1KG+llQgbShVd6u/Dy9KtSrcH
 kyOe7Y5bhH2hwnVommde0o6oTUhWyn2JUscLLnvXiFKjaxNnvEwbV7aK63o9q75JR7qT34Lrj
 J6oZigpUAb33ns2Op+Y3f57Da7unFmIp9myLbI/Stfa3SZlTGLbws9jh39UZaxvhCPzWYPDZa
 SEdOweSgNHBej32QVGpeH8pU/AjM22ybKGgTj8oDJArns/W8ZOB4m/WiIXpURD2Al6NIhL5T5
 uBKI1aguuGRLciEcSZTcsHQzWYhNh1IS9cO87g90QO8mhO4UMKUv2TR7rATC8tDkXvMdgpO8K
 Io91P7JrM+cxXKdQ3CwjEefpdcwoNS9Vbn95r38nKQEU/IRfQKO6NGySBYNpLv6v/Z0g8eW/q
 0jiOinKqisl25ctvnpqcM1mEfTgL0UDwYBwyqS5Y61F4csqz2tQmagRpXwBDK83neo4izV5Ek
 yfQBUBAD1xtQHQVhnvV5f3UZJYLXED5+J1f6owkjSNefaQiPCo3qb6+CI/24Mf1qrigfY7gZe
 yltwGqNztXliyrrITGwg1Bknqe+wzAYSSKqjqZvgSJYIvDc+FCfRjdkgOMRvfgMWBHcGJ6F2k
 BRtVl297tQDOrGvS/TyCIn4hCQMSxsyhB9Z82TbF5ILYZnwxvOkPKRzPIr2f9RrMAr26q+ALJ
 ZTPWi7L3wVtHw8BjK2mF8zrIYlFt8Tj3h+sSVZFI+0Vu0=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Feb 2024 21:21:31 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/sparc/kernel/leon_pci_grpci1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_pci_grpci1.c b/arch/sparc/kernel/leon_=
pci_grpci1.c
index 8700a0e3b0df..ed2fd7b10dfe 100644
=2D-- a/arch/sparc/kernel/leon_pci_grpci1.c
+++ b/arch/sparc/kernel/leon_pci_grpci1.c
@@ -537,8 +537,7 @@ static int grpci1_of_probe(struct platform_device *ofd=
ev)
 	priv->dev =3D &ofdev->dev;

 	/* find device register base address */
-	res =3D platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	regs =3D devm_ioremap_resource(&ofdev->dev, res);
+	regs =3D devm_platform_get_and_ioremap_resource(ofdev, 0, &res);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);

=2D-
2.43.0


