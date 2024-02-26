Return-Path: <linux-kernel+bounces-81361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAAE8674D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB70B24A28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863AA605CB;
	Mon, 26 Feb 2024 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WVEnr1VO"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE65FDC9;
	Mon, 26 Feb 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950425; cv=none; b=NvoudjKPSQPm9xnWY3Kp4pg4/dqgh+UTPBKkoatHIerN7HxPVZDjLj8hrskcY7CwOGa5EHyPW8JP+Apysk6q0YchlwnTtY3ZnFekAMLE2zYMVPvBGpbGdI1JjgREcaZV5RBioTSAjCUKh3VrHqgD/7QDicT06Q3BiL5FB1DHA7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950425; c=relaxed/simple;
	bh=AiTob3EyomDbHqxrhBdROP9px/lXNwdwN0SwFHxSlRo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=gmwKudiipnXYuughyf23mibFTov0TpFqX+Nf/Mq6dDh6Agp0G6voVI4lXQCgfvMWN7I8iOWSX6W8+HEgOcURP9pk8R89b4JKvPnAXKnkCJudEN3vdbyOQ+J0DRBpoAnzQO7KuOO3p+2cOujsDsL6qpogCgbSglLz9pkECAHRXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WVEnr1VO; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1708950388; x=1709555188; i=markus.elfring@web.de;
	bh=AiTob3EyomDbHqxrhBdROP9px/lXNwdwN0SwFHxSlRo=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=WVEnr1VOy9OmqfLrLvzSiPG79RUIqy3RDn3/9N/rX1b449uEfGtRSLXr+gwfWGxJ
	 Is7Mn4cgexiHpp88XYNL78IGqifZFQMxLYAd0bWNepUIw5cT68Bfk0RU67rebLrwf
	 FL+tn/aIZ/gCvqxas0FCAy3sKaeS0ehvVmtfj8gyoojas6MJYbP70HVOniAVniDDp
	 dt7sMFDcYpCMKE90qhEIET8JUt74sr2inkGjLSnQEgNkjfucsmTuU2Id/9I+qTjPq
	 JOfgv46V7CozGVawvowwQCtBc65QjnjusFVMbw2v4f8zuKV3U+fDWj9b9W3p9Dbac
	 T1PhxUnwiqWGMkexLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyO0u-1qg2v21sjc-00yjfO; Mon, 26
 Feb 2024 13:26:28 +0100
Message-ID: <6a64e7b3-b1ce-46c4-9c85-89f731aee592@web.de>
Date: Mon, 26 Feb 2024 13:26:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] clk: mediatek: clk-mt8173-apmixedsys: Use common error
 handling code in clk_mt8173_apmixed_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bm+GNw6iiB1HHEoqFeJwVo62AjB7FYz+H2KwR+YJafiQRiiUoxa
 daeyxI3TEr2cZRMFWSuX14vUsAto6LdUYXx20Gdp7oWXW1CnxcTpVPNuvGhWQ1/MZs80v4A
 UTmHhV+XZuBgnK/Q59kxJzrSOujRBIJwEWp/TeA/wAPC18hM1r1tizN3bGYjEKPLX2o9rbm
 vx3rgUlR53vh1gPCSgW8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mVXFJr6Rark=;DtHOcRN9Q898fo0ZyCJ9xyhJV0o
 qk60ihFXfSrxr7lunJN7IITYBYhL1HPLwyQz9UeOovSxg5PG0daQynupiTbx5Z3GiPegFG0B2
 O1WPXl41/Yowd+Zrh3RCrliLcZOmHSI708p1Ao+t5apXwX7lYAzuKi7vprrwQG7dT7eQnKx/Q
 /xxC9tvFyfXiJB9JcUmSVxNFFakzYbsbyJMI1nxKfQMaHBsB3wC6Ghy0XUrJrmLTpqpwVJQAO
 rGkcYCmBCQLAS/NY6m0JTBdjMe2FoauWcG9E7Surgsd/Bz4eeFMKfn2HD6CryGyTM7O7giGdf
 do+kFBMY9ixbXux5doJl5YClyG5VtHOuE26KPq4tUsKueMHLc6z1ikkKJzS2/QihnGLkQNIXm
 QYeHk+JdSdEjdaom56lomznxv9/FJQjA6EfYnhKwKgpaBma7KWaMkcNKcmV2z4SOA8Yqx7bCj
 khNCe+ZGacs9GKwSUf98VHN0mGRgQywnbsclVLM4QhIY5irpv1yIPeuyEPygtba93Tl+a66ge
 eJkdY22ZMFm8uLO9tjkaanIEOVsF+ndhVnyXOpKGmbBDzbeLF3gzhGQ28IK5/kxbJ/bclya7c
 YWFrNVU21pKGbvvjjtpL9oI1xzT4R4hU0WCDO1Gjfj4Spdqx2f98Qmc5l2wgUka16ORM55xDK
 uIJiEuOibfgbKy6fnD+nrnmo6ZlEs8MIBIvSwp82/8kaDPaW9I0oyGKRzArrbyZvl18/RjsPT
 OQbmVR6fXcol3ggDMn6iKLK7a3Efk07c9LB5WOfGBENmkwCxXf6eAMbmZuEbs6GAPnke4k2pQ
 CiWvTSkD9IaXIlHb+EtrNqPSIGoHhUzENnhF8a/UAnnFs=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 26 Feb 2024 13:10:37 +0100

Add a label so that a bit of exception handling can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/me=
diatek/clk-mt8173-apmixedsys.c
index 1bbb21ab1786..6cab483b8e1e 100644
=2D-- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -152,8 +152,8 @@ static int clk_mt8173_apmixed_probe(struct platform_de=
vice *pdev)

 	clk_data =3D mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (IS_ERR_OR_NULL(clk_data)) {
-		iounmap(base);
-		return -ENOMEM;
+		r =3D -ENOMEM;
+		goto unmap_io;
 	}

 	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
@@ -188,6 +188,7 @@ static int clk_mt8173_apmixed_probe(struct platform_de=
vice *pdev)
 				  ARRAY_SIZE(pllfhs), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
+unmap_io:
 	iounmap(base);
 	return r;
 }
=2D-
2.43.2


