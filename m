Return-Path: <linux-kernel+bounces-11130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2412681E1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9AD1F22153
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA952F91;
	Mon, 25 Dec 2023 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RA6P1cns"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87652F81;
	Mon, 25 Dec 2023 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703525892; x=1704130692; i=markus.elfring@web.de;
	bh=j0FKcxvxQfC448I2h8pj0eT4D4GEbJBlPEXrdpAO+2I=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=RA6P1cns5bH5XZAkWogysVVZpXDL1ov0hIdI0dFSrPlsRyIuZIfbGUCfsg4muGLu
	 TJWuZ08G/CTjYcRju2Ioh8wjetls2Bzi1MpREpq2PFGfRM1m/TfLvvT9no7InrjfM
	 ZmR2bKpHQqiWMTJbo22X/iIc8oWgcDs7xpN5e/+XuqI/P6duTzRHFYIom5USDcvvs
	 jGAsK+lFh/YWX4cqA58g+WS52yUecM3UyPCU6z4nGfqC+Ib0+vfebvYDcm5VHauMS
	 cWmXMY/CRJb2hT9UqEVoql+5D9m6x3U3unHpt5QJSHtsLam8KEM0ITOMBjAoCD9/H
	 /mmjw5Qnbl+ETXlDDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59nK-1rIupc0ws8-001dTT; Mon, 25
 Dec 2023 18:38:12 +0100
Message-ID: <644d3bff-5a21-47d2-9e36-06475d472253@web.de>
Date: Mon, 25 Dec 2023 18:38:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/7] EDAC/amd64: Merge two if statements into one in
 amd64_edac_init()
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
X-Provags-ID: V03:K1:0IDoyUT/jRJx6zuJyc7dROs6A+EuRf113hAyHyLWMNk2psUzfIS
 lvXFoI0/RHVmz5d7VHoNzISVCQ0DAj8CVtcrfZ5JRT6sZWv4ShYtb/sOpYe+9k+CDeQHKOJ
 zLSSnGl4ulTmfO0A38teQpm/1wAlWmg3hQ14Z+5TapRyVUpYirAq2Go+kcFl4816vUHcWfk
 6TCTgWKRI3sWk4kgXPc+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eOaklonjYc8=;Oz4K9nCLExNKL/flrq3Vuiou9BZ
 5FcXhLT2nr90iWusB8FZiCLXHhZL8CYzHLLoud/gPkFzCsVyu6pqNDyqqe3/H6zV7sRMrIUmb
 gy7C42jBqpLGslXnl5CVMTvGiteJdYrveFaRqUYW/bsXIp45mjIOWdnAqYcC1EE3SaZYqQ+9u
 EoTcJX5VPG/LjI7QPSv44vKSYUASIym1XyN0Q//n8iRc4tDGwTEqeis1ScivKEpXiYzkdsW2N
 dhBmZtF6zo9H3wHcnoxyksiYOiB0Q0phYBBU35VoxTjDzQnSWzAxheGYL53PXq4AhUKimq9to
 vpZ10WuZ7zVszRJlngNIGjf6dFvZ8l7gFfmJqjrpcQMb/W9xAk3z7o0CcYmDyLNDCvA5lCE8K
 Ks7ALexQW7bDXUFvPjbbOU/scVd4ulxUqpTcmumfNsA45G7+7rCN+2vaO2vY0Itpki2CqryWK
 Eo1Nz+nn7Wh00NzniVhOZVhzsE7WifAThccd6hqFeGyT5DUqw05DURVKp02xMoZYSULZfQxi9
 yUAXVoh5QVHCjEj3k6QFwWvRXza2P3EgogDs91Ajbyu8WuZXOOMybUzzKQrhWPFI1PkaNc6L/
 ZUrkDc6sp8Ekctw6xcq7V4yW3fWYX8irzXET7vgF/XKPbQIoBkDC+PlYJLXVmVfvbDvQ2mKkw
 Spzf9/OpAVDsK1aPSdvu47UHgHbrOjQ6bGvh7kJAvw1tQl13oy+cYq1dKN9UExurm5MRi52uW
 xI1xOPdCoDi8aq7kM39WlQ9O3LHF9Uw36kXXbrKrdu6Ren4xhUgfmEVT0nD7eXi97VlfoI8cV
 IBoW0u/chcni7viCbaQNqOMvIuqiUdv4kQuwqiAvzHTbGZAPBKtRzxbHiMJ2l5/BFo6Ut3fEZ
 g2me4qOyZPnsl4HOksOKc6sgcv9Zfm4/07S6ppuXvFlGCnOk1QAE7fO0cpu/jlIlqxdRZgBCf
 VMe70w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 16:45:37 +0100

Two if statements were connected with the same return statements.
Thus merge their condition checks into one statement.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 8a27a4af7121..49f3d9b54902 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4406,10 +4406,7 @@ static int __init amd64_edac_init(void)
 	if (owner && strncmp(owner, EDAC_MOD_STR, sizeof(EDAC_MOD_STR)))
 		return -EBUSY;

-	if (!x86_match_cpu(amd64_cpuids))
-		return -ENODEV;
-
-	if (!amd_nb_num())
+	if (!x86_match_cpu(amd64_cpuids) || !amd_nb_num())
 		return -ENODEV;

 	opstate_init();
=2D-
2.43.0


