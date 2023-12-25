Return-Path: <linux-kernel+bounces-11128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE881E1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF562824A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872C152F8B;
	Mon, 25 Dec 2023 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="r32ESMkz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7E2524CB;
	Mon, 25 Dec 2023 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703525780; x=1704130580; i=markus.elfring@web.de;
	bh=6YbgzX4IlCp5KaOe1RjzChWQs5gtWK+ZeLnQ6EfDZlc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=r32ESMkzGobCaa+TbXSVG8ctXjGd5HH5sZKeKPmp6YZK9Vw2Wp0MQHkwKI3TDsNt
	 7IBNMJLrbOIalQcTJPrbEqbDv9QxZR5lQSsVvD5dZN4MSZ+WFZxBjkVhh5AmNiphP
	 0U+6K/aM2e0VPZqo2NRrusfowrLH7dcB8SJDct12W8oVi4zgurjRFi8HFoXzUrq1u
	 wCg9e7D1umq9PmvcHnsaDuLv7UH5ad9srjeIOAwYcbCzCkEHlnVruzwZ7O3yHVrCW
	 9bndfhVeph5PcmClXTKu/cWNtOghOXHbscnMXGAaln4GuuUidfSGtVVF1poBIhx+7
	 p/qudgR5k1aYJEEpXw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKFD-1rcTt31g33-00PlHa; Mon, 25
 Dec 2023 18:36:20 +0100
Message-ID: <e4c0344e-81b0-47d0-b115-ca7f5590009c@web.de>
Date: Mon, 25 Dec 2023 18:36:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/7] EDAC/amd64: Delete an unnecessary variable initialisation
 in amd64_edac_init()
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
X-Provags-ID: V03:K1:Cwcco78JixBvWs3sejkpE1/Op33Uc5UEd2qPxoLTasMwqfRd/u+
 2Xe//62EaQWi/BGoga/Kf5B4juLF8Qja7neUpiUujsEqDaCDy3coL6clkDyV9/B96K8ipf6
 jHjPHn2JWPbTtFF1gE9lp+S3nzb47GmCCZAPyYQZDEdBRimYdI8j8uKnnfTfzMeK8Gjn7Fo
 TpIUegBgedkf08+kfVryg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KkYp2qCitf4=;2S7BX8fX6dNziIhWeaAu3J7ZMNO
 LvgHHGbUyT8spp1asXU8Dw0TJ/cd5uIM0cNisH4OvLet2BHItSg2egbsP9/0l/S4mtTQfrwpy
 qLEmImBwSJKw9bGcBFu9wYTHwG4FQTH8WjfJo8GKQXAQ+y/+Ebv10zc/3qO2K3qd7WOK4ikkj
 UQ8S8tO6XYjrMNNwvJWeL7ZkHQEjW8fMHewEJZkt/MjVYY75bfh2a40gi1hlPoiLdiTTKHbYn
 YhQB4FUHPHis10bZK713fqA8tY4hRY92fnUiWhtjXHAl2eckyGji+kLTGbBK/G97YofQIT0f4
 FzChciIrpGT3erPLBYe8f2nkEvb/nvltQ8nPF6FTEF/37WJTdFgT7Vfw2/r7UFx6sUy1iwr4i
 8T8HXhRgB/cCeyjqjss0ppeX2qsH9J8K2l5NiqAMvyM2rs5wauw9M61Ne5xpUwkL1n2+fOI8J
 ql042PMK06KBEJkND8/ju7Bpj2W9OI2ArYiQ3NCYLo4l6+g/A9VHnYLTbq2avlCtX7wS8bpCH
 EoNhMogMInwWuFqlEfNcxl4OMV09ktcSAq6GYDezhFFs+TZPXp9o51asbY02nVviDs55pCCTf
 4FP8QFd/WgzNnWBA6xhFdgMrH9absOWATDeRBXmlZEHxzqnc2k/u+W+85GWk+fwS5rAsQBDUo
 Hy9bs4xvm25eQM3jOqQkM5hz5MsHEZ0Ef5EgJHmK48KODaAreSA+b2kv8rpwJMnjUge2wtlpz
 J/QN9tzt/mKVkX1Z8UUw3VuVF+Vppkpt4svO4i9gDxh47Wj47B5daIx9X3LIIihn9NvZvSsmH
 WfoxAC0iublxZUjUemxuR+4aDP5PqPzoLWYJnUMmuj2t5uzgl8XbkSo2i1V+tb8+sYr+NKgUK
 VdpGcQMT7A7J0eE/CoJeZBEMKoHQtjcM0KMLfyTYWrQVF2WPpn390gYtluHA8AawOnSie5pAk
 0AIq0g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 16:33:22 +0100

The variable =E2=80=9Cerr=E2=80=9D will eventually be set to an appropriat=
e value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f912cbadefa4..8a27a4af7121 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4396,7 +4396,7 @@ MODULE_DEVICE_TABLE(x86cpu, amd64_cpuids);
 static int __init amd64_edac_init(void)
 {
 	const char *owner;
-	int err =3D -ENODEV;
+	int err;
 	int i;

 	if (ghes_get_devices())
=2D-
2.43.0


