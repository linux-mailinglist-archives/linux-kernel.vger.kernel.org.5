Return-Path: <linux-kernel+bounces-11133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB181E1DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A6C1C21023
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3691652F9A;
	Mon, 25 Dec 2023 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BRgVjKbC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC252F81;
	Mon, 25 Dec 2023 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703526253; x=1704131053; i=markus.elfring@web.de;
	bh=RztvVJkiqN6k6MAkMSOfzbHfNuTEw4Oiqcl/UjOdytc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=BRgVjKbCkwimRPbV0xi6sn4JfyUN/SzJgjz8cOM5S2JoP1OXON/UwUFDpHauZHqm
	 tOeczZtc4kAH3h4oeMjhT3RatwqgHxRckDEQotpj7/t1W4nnTUE52FbQ4LPyWpwLF
	 Vj/4cq0CClA8GU9SDN/M7dktQakpZRwz4FQk2QPvjz/AKZJHJ4WwQcIIJwhypHHc0
	 g1cBzDutd44pLitRq4V5q90wCspsx6tQMOPRLqBst0+TlzyV1N68otNR18xCnFbpQ
	 AuaYYK/gZmuBQIcjmGDDk+Qzc1I467ySsCaA/X+9sZky8tToIjTWrA8EAbH9OEqiV
	 1dvx5Apk+4BxMxvZvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVaYw-1rjLj72n6y-00Re9o; Mon, 25
 Dec 2023 18:44:13 +0100
Message-ID: <d6e6c098-ccee-4cf0-9dbf-714989945196@web.de>
Date: Mon, 25 Dec 2023 18:44:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6/7] EDAC/amd64: Delete an unnecessary variable initialisation
 in probe_one_instance()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
References: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
In-Reply-To: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tguqig1/d9Gquv0duF+HYbD6u0Nq0ecs9k3puuWqEaduLqMP8OF
 G4a21omXnXOFpHBg2wi7+aR92clYLkKHm1+9XBeRYSheetn+JsHA9uKBjG0dgaq+zaaR3xY
 OtNVeH+++yTq54V7fXUILiAmNH9KD2CfeSSAN2G7H1ksOx+KX7WY1kSqHu5L+eu8PhfsrBn
 AZVC3bVkjhOI0ERjx1mhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XsXR/k+e8AY=;T5v8XO6GeyaX87PWrmzvSBStT/Z
 nLPSHKRzZdcS7j+BOOU6XYHJfHX1wiezd1OFxQpG04KJse2qPMYEBRJKh4nAI+bHvMxwVAIAB
 vjBwcnsnm5jDO2NosbNcJFc58yGMZm3GMJewRe9lG+yE20eM601t+CGiAMsCPdxiP7G6OrVHJ
 gsE22naXBT+dxpwcQjDQJL/xRol1qfyDWyiLAvDTmeZQ88DNjKogIyszaSqrEtpIMo/FK5TIo
 x0T2Odztm+LGQKYNH2MfiN71BIh28whLF9lK7LZCOuu2Ky5I4xplJSNsQtVstIDFSW65VE87P
 GSyfpghMAUhhgIP58YwemmIUADW4elWCCyzzhDd+kMJuZ+qx0eMksumHfknPMrJ6bg86T58GA
 5HZ4wpfDv/xTfxA8Fyu1X/ENw7SVc7iSi0A4ei4R93BpqO85dVatdGQxhHeLPqiQtbawtR4Fy
 Xm7/emiaHBOoXF0XotHtHcG9UphMCPmQGZ7pVPQd3WFARZtMUDs9ECXLDXnEc8frWyxduR6Ub
 hc3C7/sO71h/8MIonMNgBkdKaOeIBSryK9IE/c1uSCrbT7wtp2NgU4HCA2k7FefpYhCbSEYt3
 EPUgbU0ZEC0QOm62+IAvASGMbV93JXtKN3qto+mDHqwjVE0YbWwKFS/iIsRWqYqVioX1yJfqu
 4JtY1OKNFrN97jBU3/bYOZ7H/CO+nS1D44D5A8Va+dTAJBS8/TTRJwrkrW59VTQsQBj+1UitU
 FH6Qmyvlx76pVpTSySZyc1icdN4OprxM/R2IedGGIXOmJ8yEnnSA3EcYz+Mifc5hgqBHj4OK+
 GbW0U2f/bKMB/zbkuuOal0pBVgxSDpgkPdIOxZQdL3ASKerCoA954gVltfxLrRIPoqGCtghuy
 Y7PVG5mqy+L+fhAsbtG3KAl0KAsiNASLtXLzGErxqdu5epnuOdOMyKrK4FnyqgJ4L0rbVnoqO
 F4dysw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 17:34:35 +0100

The variable =E2=80=9Cpvt=E2=80=9D will eventually be set to an appropriat=
e pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 7536236df542..698cde573847 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4264,7 +4264,7 @@ static bool instance_has_memory(struct amd64_pvt *pv=
t)
 static int probe_one_instance(unsigned int nid)
 {
 	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
-	struct amd64_pvt *pvt =3D NULL;
+	struct amd64_pvt *pvt;
 	struct ecc_settings *s;
 	int ret;

=2D-
2.43.0


