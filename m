Return-Path: <linux-kernel+bounces-11135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1781E1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFC81F22069
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1AA537E5;
	Mon, 25 Dec 2023 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GiO7qeHC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220D52F6C;
	Mon, 25 Dec 2023 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703526384; x=1704131184; i=markus.elfring@web.de;
	bh=yZfNVyN4f4vfAqTUZd3nhSOWUqIAg4Bk9xRcEkmGZ5M=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=GiO7qeHCXutEbfDxFIdz4So3jEDLAuTIEVpxo6C6Hd7t9H3wD2azDaACSutB62aQ
	 YwqXdfHwqdzHRLMyn0Z2L1I+524QFb6MXZCjg7gR+CrtHia7VmbV6QlGEIxmjPM1w
	 3JJAj9p+eRGZ/kCBzT/Ma9GcDjJqa2X9FDKu/VdvBRaqolrAh32WOTUNASbU+mnLn
	 4L6GnoftHVl4140LMk7mGlMRx5csm6qinrSpYKkEEkoXZKr2ewbbu5yqZZqtqWYHl
	 GLBShQsPoandcv0O205o3ggQYErKlhypAoOb/Fl8vumw0Ra5luK1E4floSkx+i/B9
	 98H/MVwTv4CnuD3jyA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1rgJlD0Q8J-00TZ2O; Mon, 25
 Dec 2023 18:46:24 +0100
Message-ID: <15936ac5-5380-42fa-b13a-e6b2ccf92490@web.de>
Date: Mon, 25 Dec 2023 18:46:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?=5BPATCH_7/7=5D_EDAC/amd64=3A_Move_an_assignment_for_the_?=
 =?UTF-8?B?dmFyaWFibGUg4oCcRjPigJ0gaW4gcHJvYmVfb25lX2luc3RhbmNlKCk=?=
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
X-Provags-ID: V03:K1:66u+l/NmUncqbzV4DyhYiHKTFwdL8r80fp0lKBBqJ4Se1lKH36E
 GRmsALRYZzIW/mZQat/0+0+7qD1JqwkFqKB1IjRWouz9CCsUT3Q1Xn7MOSCIkdWAg0LlRPY
 fsTP51u3VQUz6c4p72SnFchlNUCxKVUE8v9BRvw3ZqJem/eJCNJIHoqdnUGko/13jb6Fh+Z
 mZXcmp6jjjDEZmDhtHGSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vZ18hv2qYMk=;dqmj3WTTTp6yGfjGEUHWNrWEOJU
 yt2QYNCgE0N5ixA/hQm26un+3Uzx029yhuNPS8eyYQw44Mb9/856Jvi328c4KjUHx5dyB31jR
 bmQ2FLL2iH/meS+Rh/adpIgGW/wu6NKPnCL1n9eLMFoMKLUiXz99Puwjz+1dL1O+HhzLz09RI
 A1KVzV80mW2YKtageXbFY1VuXlFlRTwBFlMVv9mfCYleqvgeZtSeicfXqAjxLWBC52umcmN6A
 VbfKqgIdcyB0RvK3WcxnhKqiSppA9Rj9NQHlNLOWFEfhgv7BYXr+yJsb33sEskYCjVOBQS3D8
 qOhCwOPRytdLEhbUcUKuE8lcCyrxrZh2Sd4onQBKsy14OIm5VEOqrmTDaGtuGL0v88whKKnZd
 cG5JQ+K1EVxYAxb/veAHWtOso9f8rcFMKdy7KVMcdI52hawN77L/rsBzhPcm2fkhnUl3WOadn
 oyEbKEYKCi0pKtThDZgALTSqvpXYbW5YlpPsr8xG8pIJUmW6hvVnjhDU10WW6kOfRg/BsLvcq
 9E/Mx9nbddgtpIySrnAlnZRBqJwx3Ifb9mNWZh3k74FGuyijm1pN44+kUspkS4aXRNfOZOVoL
 VdhYNpARcU7Bjwa8UuvZ8T2eG+rGoHQ4a/tr0JOLGYuFWqgD6/8PUXT0ZphRPRxu3oznk93/4
 dU89SApnK96KCVuqQyZxNc72NhFenzVvgyuHzktkaSUWEJoQuv1ianExWedXUF6deXzfPOBc8
 N/e7UX5+zQPnQ3lSs8t69XhGz7JuWprKS7yKoI6D4JI3NceCYFiQPmSuPfLVbNn1gmxnmODz8
 9/cHwOAKOz4buRNFxA7tQDa6NeDtKW+PuZHDGW5oHAPrn+ED9yrxpP+j/qe0UVwXjRGaCclnj
 j9s0TbFd4HatEHu3M2S5HVO+aJ3f4aVFFuaXI7lGhF7GL7TnHuUqnlMudtL//4VMqTBzw4xhY
 J/d6AQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 17:54:33 +0100

Move one assignment for a local variable so that its setting will only
be performed immediately before this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 698cde573847..91e0abdf762f 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4263,7 +4263,7 @@ static bool instance_has_memory(struct amd64_pvt *pv=
t)

 static int probe_one_instance(unsigned int nid)
 {
-	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
+	struct pci_dev *F3;
 	struct amd64_pvt *pvt;
 	struct ecc_settings *s;
 	int ret;
@@ -4281,6 +4281,7 @@ static int probe_one_instance(unsigned int nid)
 	}

 	pvt->mc_node_id	=3D nid;
+	F3 =3D node_to_amd_nb(nid)->misc;
 	pvt->F3 =3D F3;

 	ret =3D per_family_init(pvt);
=2D-
2.43.0


