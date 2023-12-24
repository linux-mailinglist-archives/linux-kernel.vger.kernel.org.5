Return-Path: <linux-kernel+bounces-10772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3E81DB9E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5143F28201D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2755BCA6F;
	Sun, 24 Dec 2023 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="R3f2pxMt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D9C8C4;
	Sun, 24 Dec 2023 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703436732; x=1704041532; i=markus.elfring@web.de;
	bh=JVdUzdLpgaC7hin98rECoi2XLdapoOWFd5N0xpU61Ps=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=R3f2pxMtgGsapI2wHzZEJ6wtTmgobGpUwnMfkpJ4NY+T+PUQxcjMUTQrQ6C5WH72
	 Vc7AWqorzLtIxE8KsqCaPGzh7Bm0u3kxLd0jyQB5zTVRST4+g16ul3AxOTPHTg73J
	 +UnnY4brCUC++ti/y2xpawndiOX5prxyHzAKpUSo9ppJN/bq6fTMOGajdxC84qvAC
	 VkJ3jPVudtR/zTZNI2dKK+BZw6R2GMIaoRGhMvGuLw6Npochihs6XyxekF3zVHLhc
	 7bgaboOhIqxBi1QR/R7sLs9VkL1MvH0mm9/uWL+BXRkhux2ZriNes31ydTYzI/x5A
	 CccQ2nsGKhy/x6C3Eg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQgp0-1rf389465e-00O91k; Sun, 24
 Dec 2023 17:52:12 +0100
Message-ID: <8f58f1c4-3fdb-49ed-b747-5e1a4852875a@web.de>
Date: Sun, 24 Dec 2023 17:52:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 10/10] clk: ti: Delete an unnecessary initialisation in
 _ti_clkctrl_clk_register()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Tero Kristo <kristo@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
In-Reply-To: <20849a8e-e0f5-46df-ad8a-9eae6cbe337b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fgN0ExXBwyzGUMbTgjTQTsyg844rAOWLjjsZLqPYyF+g0El0wjS
 fpdJ3gzSpTdZjq3ca1tmrQTdzYiAQSHKYsU90V6eMg2QY36o/KHmAB+nJo40lWPx/hyclBB
 dFFLiAJETpj76bkIKBCB7lqaRwF9GFsMBiKg9quyxL/ojHx2GhbW9iEvjMHGQy4cZ8EhTrr
 26Phs5wT05dErm3m7QyvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m0YkNs4BJnc=;rLK0KQfeIZqGmWNAPNEF+Fnjc/+
 oIoU2FJwEEhd+GLZENUUL3z/llOdruLcq85PAZYcVTQYxKEkpP55ADk09wwocDbFDjHXyw8N8
 BK3CP5bZ5Q7s+0XOyEOy3Q197VJuugi7AE1xaE4WaxTu3x92HUdbnPhzBXpmHJukZrQ2acMQW
 Sr6dnLeliQMN1wCh24yKIiMwao4mAfofzfiaqCiQVNZSretEUX8psBH1lpvWIor+hDGayYo6T
 AJhZdDoNPctqvUlf9J02eGBrEzarYsrICUjd0CHEGetZpPJ74glzK82UouT//U9zldv0xQipQ
 t7Pzzww9z27xIaszolzIRn0OUA4Kn2nFfz8Um7tEm6q7yaDXQGtD53RmBPfaIcYjEcWsxKMbg
 HX4lpZnHVLy1v0DobKBKhhqkcancJZT0eByg2wPZGbgfyAXJJyTe7LRCLB14quu3WAiqSDaHf
 JdqX6ZJ2Slhh3srMA4GK2J0Co1XRnwB4hnTGXuQ1vdad/TL+aJCG/xnae7vGRcgK+9lsIsayu
 zTb6fjsnlM3Idk40ohL5HoexwHx6D6A02Z3xWi6vX3hP4niUQn7+v3KV3oUCKE+8aKl3x+vbE
 8C+IkVjk2guVTSrahTh0rOmoyz3uBDcQ8t+HOYb3y0ykJXEBvnwkDZUDg1frwWUtle30Rlkdb
 NyP/9CYeBxEbtrRX67KQA1MIRz1t5f/X5TCpb18XYqlu7vUAmIfYaBOhwhx7YCG5BCpF+iyUY
 VH/1qWQIIvBdkt5heHnXdS5NLJ02BxM3YEWo8Gk5BomVWKDogPIuLdOgE3NrtcKqe9Czj1L7G
 m6Ga35Eic9iqfZDBM1sVQhSC6qObIOIryqDUpur7KI1ut0z863hr3A/52l6+N6TxFBv9IEX5b
 ml8tZTKg/VgpedtZijJBMLo8IK5+sdmhEsjYDrSlFcrT/1R0UTZRX3cO7pfiNAaZK9JmSyyMI
 ROIhxg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 16:27:33 +0100

The variable =E2=80=9Cret=E2=80=9D will eventually be set to an appropriat=
e value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/ti/clkctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index cdc3cf1ddddf..b9df75c6cc50 100644
=2D-- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -291,7 +291,7 @@ _ti_clkctrl_clk_register(struct omap_clkctrl_provider =
*provider,
 	struct clk_init_data init =3D { NULL };
 	struct clk *clk;
 	struct omap_clkctrl_clk *clkctrl_clk;
-	int ret =3D 0;
+	int ret;

 	init.name =3D clkctrl_get_clock_name(node, clkctrl_name, offset, bit,
 					   ti_clk_get_features()->flags &
=2D-
2.43.0


