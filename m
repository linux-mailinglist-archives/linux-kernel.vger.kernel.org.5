Return-Path: <linux-kernel+bounces-29289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A63E830C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E7AB243AD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A703022EEA;
	Wed, 17 Jan 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l/2/DeRl"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348B22EE0;
	Wed, 17 Jan 2024 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705513327; cv=none; b=Dgz4Iv5DZ3lPgnVX9CWt9BP3Y2NT9I+EXU6T4tBINGEDF/oe3kPADinhwdxOpfq44ZoGfZbaFyo30Sp33uCIk5tF8ENy+lntVFugNpXMSQF2e9HaQ4IPV1hd/j2MZ76a1vVX91B0RZS+P72ZStvJ1XhdtofxBDB/3ZxzjbVduec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705513327; c=relaxed/simple;
	bh=qBn4g41fb2MsxxM0gYc5dVcwvdfo1oczPv1z+8LJprE=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:From:To:Cc:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=BtDUfgaqYbMeJ4kfWwiHbVK+gUnaHG+tc013pyBIKdDoc/Z4GIDH4FJedcCqjejJ/JDWfXQeE+3gnGiXkrkypDEKeJkpAZ8xgVbtrafw5rlH+PILMo+1tk0L1pEvG41QLBZaVcCFASgI9pAxnGxB1/HSaV+ZfsGpsRad/hnO2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l/2/DeRl; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705513308; x=1706118108; i=markus.elfring@web.de;
	bh=qBn4g41fb2MsxxM0gYc5dVcwvdfo1oczPv1z+8LJprE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=l/2/DeRlD4+1yr47PalGJ2WO0/tcWrgRzfqOuOQNT3btCikjX1Jayg3vLDdr1AGr
	 ixmsRJyLqaWKgeJ2Y3kcJ0AaPouJ34P+o+EamSI0XdimPZkiJ38weoP5rAeP0Xzb7
	 3efoixKB+bAZfSs2WtfvI2yh8jpaOHdd2KkBMLh/OLVKAWiVS0T2QXyZH/l9Uf/q8
	 +c8ONF0lL2oRpRRUwng6pwKvPEsCm+enHx3cqNXMPplih02yeqBW0bBXVHSHgKmQM
	 r3VdPGU4HYLN4VClvNkQQiSHkIFTgxPW+gV0uzzBhZdCCuyrkojqw4J/9OIhU5ClY
	 dq87w7caX0awOAQsiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1qjiEj1L9h-00jOPl; Wed, 17
 Jan 2024 18:41:48 +0100
Message-ID: <be06e4cf-2e36-4884-bcd0-5d5eb5f191cd@web.de>
Date: Wed, 17 Jan 2024 18:41:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] clk: versatile: clk-icst: Return directly after a failed
 kasprintf() call in of_syscon_icst_setup()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
References: <061aef8b-a41f-4346-af6e-560c7594b27b@web.de>
In-Reply-To: <061aef8b-a41f-4346-af6e-560c7594b27b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NDbGmkn44kT6EPNjOFh/z2sQKhLIGQisz4KddKtA81uJh8rFwM1
 Z+K9QMTIjfuFTWofHkYCfVrUYKxTGf1CQUzivIjm62B51PE50fl3yltVX11Pyfn3pQQZH5C
 N1FV4BmTJ+cET5rjb9opFFBePOk1oVx84BIsGhaT87rsLFSIvMa7Sz5Hj9VTJ89ScGyfH2R
 FuJ5tb576dfX1CsH0Pgvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MCdEgOisQlc=;2Ltz+7VFKKV6wYLiurTJ4Xz7xWp
 XO9AJ7SsFd+9QkXTVpbK8mq3fuepOOKScZduUT15kSykmD8mMVxZMdFtuozlKrhXaP+qcFsyJ
 SFF+IBo84eckhnSn3S0dwFiWh3apBdBNr/6e7zeDlUDZZY9hefWETc7h5kDaX3Is6yrbzOk0I
 bkmOzuSoRgxsZ6a/m1IIBR40/F9Pc81pAmrlQaJ2SUV+RLdaK7l8UIReGgN/+IUlk4P+gAPei
 rvm83OAjqA6Q7SvYb/iYD20Sl1x2z06FJe0ntHXth7tEUXB0Ozg8KOCGQcSeX6eEbzijwARSx
 z87SBGzgQXrJgmQj4y9rqahJIi2/IfHXQYnTQqrSH3YuHykxWks7vY13OEHhFvD8vGPPZacSl
 0vh4/BxR+h3Rg2NezAONCzdzD2h76e/POFYQxCL5rw7uefwZN/Q1nhHbx1+riCV3XhCT/IgSs
 z3Hf0qc5eLve/51Oxl9nyxnggaP4dLN9SArkHl3i7wybj7aMTlxpOaojQCxLGs2BH20fu5D/G
 eAKtq9EFkRWuoBjZQ+bbDoFgEhT8OiNnqv0p9ejUWGPpC7U8Dh58pNrpLJiLur4UA5id/Mw7T
 oKP7Mf/Vt93TN7hTMXKUDchonhdM+3mugMAQDLpS6N9w3gqQ8eeHYb2pLDXtTxo6xvmGx9GqU
 sPcpntjDKZEM/KvbCl1glNpHpLMl3MzRI+qVnWIgTQQTQnXnBAVvpFJyRVWc0RMM140CZ646H
 Ce/6bRuU9HGf6Aj8pAImgC5DA0+G07Zq2omhPrK9IfBeYAghvxUU2Ao782KBJgs0kKGCF6/U/
 jEo5EFT1Y/fM/BjCS8ejFX6yiC6eTnZNdxRq0Xf4ub07t7ptNgye90jItGqhLGZgA5lolXrSD
 PSJA2XzZF42SI6LXSJDoTW8pIAtqGrriVJmS5xjMp29Ftm0e1j70v0egG8CV+3DHnFJ7nFrC1
 dXVEtQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 17 Jan 2024 18:06:55 +0100

The result from a call of the function =E2=80=9Ckasprintf=E2=80=9D was pas=
sed to
a subsequent function call without checking for a null pointer before
(according to a memory allocation failure).
This issue was detected by using the Coccinelle software.

Thus return directly after a failed kasprintf() call.

Fixes: 1b2189f3aa50b ("clk: versatile: clk-icst: Ensure clock names are un=
ique")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/versatile/clk-icst.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-=
icst.c
index d5cb372f0901..c4cf50a48972 100644
=2D-- a/drivers/clk/versatile/clk-icst.c
+++ b/drivers/clk/versatile/clk-icst.c
@@ -537,10 +537,12 @@ static void __init of_syscon_icst_setup(struct devic=
e_node *np)
 		return;
 	}

-	/* Parent clock name is not the same as node parent */
-	parent_name =3D of_clk_get_parent_name(np, 0);
 	name =3D kasprintf(GFP_KERNEL, "%pOFP", np);
+	if (!name)
+		return;

+	/* Parent clock name is not the same as node parent */
+	parent_name =3D of_clk_get_parent_name(np, 0);
 	regclk =3D icst_clk_setup(NULL, &icst_desc, name, parent_name, map, ctyp=
e);
 	if (IS_ERR(regclk)) {
 		pr_err("error setting up syscon ICST clock %s\n", name);
=2D-
2.43.0


