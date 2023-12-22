Return-Path: <linux-kernel+bounces-9915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BD781CD36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7001B2128B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA116250EE;
	Fri, 22 Dec 2023 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AKXU6OZL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4A7241EA;
	Fri, 22 Dec 2023 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703263071; x=1703867871; i=markus.elfring@web.de;
	bh=v9wsO4hBMKaYP4jfM0OembEpsGFWQxtzsw3ZTzzqTD4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=AKXU6OZLEN8VvHj8rNjOWKQyKiT0wyk1c4d7UmwymM6esWyG97jFAwalvuhYTx98
	 GeNBCXYHOnlMSH64LOXoHnXbhmFa8reXHRSfMsgBsm3RhXG43YP36oOKG18Q89B/C
	 m8NT+f8zdUDdBiU0j7HdKifjpS9VgXwpFf7Q7dztF5z5UlsRCZgQx/OP7u9Il8SJI
	 SLUoGRT9d2Tlgj70S9WUuetVelspUE9xv8PPgxd2CpCHQj4Sloz4y97agf+9Hv8t/
	 SVn30alM2FZlvDjgq5C6BnQbf5j4/C6vSIdL30gOtb/jGjXDyhpLjTJ+0GFOsJ6jy
	 yjNU/wb81xVNLP5yew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXoYQ-1rmczK2fvQ-00YFjv; Fri, 22
 Dec 2023 17:37:50 +0100
Message-ID: <6604590e-d0f7-4798-a1b9-b2f474f3a642@web.de>
Date: Fri, 22 Dec 2023 17:37:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] clk: imx: composite-8m: Delete two unnecessary
 initialisations in __imx8m_clk_hw_composite()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, linux-imx@nxp.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <1d494176-2238-4430-bc26-4e4c78fe4ede@web.de>
In-Reply-To: <1d494176-2238-4430-bc26-4e4c78fe4ede@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D+hRhIGTK8aStCOJ4/CTmR4XIynD0hvKNWsh/EXmXF5nGjX+fKy
 L1EIRb2Q/nJZKSH9LASVJyHGxATwbJMQKr4C8ZHDxTcdmoiwNBHHGD6dBHT++3Ige5U6L9J
 YbxrIKRvcckfvescYp7Sfekcy+soKVrs0KE++hlOa+MZVrmTMgtl3Mlkndhwn8/WJhM1FHd
 f0eySxAgXj3/ZW03A8HXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SujinENInQQ=;w2IzoUAeX5pp8p2u84Zb/qKh2i9
 zBTq3+IRxhpwyqD4mK24y6zREu8WH/sj+rZdtGcnwAdw04meKlf4kqwF0Iae36C9otmkC6PSF
 6uH6/7WlQRROqsXja8ax4rV1WY+ps4vtTZty7Hg+LGQZC8VWiIkV/uLwwZWy5spzWEV/OtX5g
 c0LVw+Vcz4kgTKQsbIcUVu34PLFtGfT5XUw7QCQlHeXU0C+zGFSjpL63l4N6uWk94LXKGyl2U
 fJV95dcDIjAejovxCHXOQHzXwDC5KCiaQSiE9TytieEk253ulVOQwmJnKEry7CwLLNrBNa7AN
 NFxE88sF2K0OubysXPVdJg5osqmG5tYNpCHbyBFr9xN9wcvdF6puV/g9jbInLwVBEvp6aurfS
 epr1Rniscpo9OhUz+SHsGf9nZzrqUuzs/yw/0FwWfmm+n1ONwI4vkD/AO73Ws9u+lYgudGSDg
 mXujF8s3duJcI4dsj6GnE5lROfB6B7268S4NW5GeQkHJhIf0kBVTEee2MqMR+NhnH+lLyB+E+
 GbARBgokg9V0+cNh0TA3cxrKOCh48rJK10qd9QmHdcpBzWYtNfKzyWvvZI5vaibnDXZIf8g1Z
 C7+gVBolPfP65ESBfje7TFqR8VsxW3ueO0TrwICuqzDoeSSm/ge05WzFwJSYj3lecAznkTYs0
 GYsTXsAiK0+ex9/OmZgQwzXTf3r0v6nXjpvw2W//NVi2+pzy/ghLB7k/AIZvUYjK1DlAAYqFM
 JjGg3FukiwaajfbZHRQoyoziibI1ruaFuTycSJgQGvz21LVf4ZwU+99nkcKxMTAVdrvltEutS
 YO8u6EytTiyS49mqTfr/misIK1puqMoz71K4thAo0NwQ81CRyqXE9PaSONxS+AZuvTVbQZIxD
 EIRaSjpMpacbk1PPVwd75LRlZ5DPZgsI1HgWZHcqcwJ2mghmreqeF7jUymx4IivU8qVNlx0KX
 nkXBOg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Dec 2023 17:11:03 +0100

Two local variables will eventually be set to appropriate pointers
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/imx/clk-composite-8m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-comp=
osite-8m.c
index eb5392f7a257..8cc07d056a83 100644
=2D-- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -212,9 +212,9 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *na=
me,
 {
 	struct clk_hw *hw =3D ERR_PTR(-ENOMEM), *mux_hw;
 	struct clk_hw *div_hw, *gate_hw =3D NULL;
-	struct clk_divider *div =3D NULL;
+	struct clk_divider *div;
 	struct clk_gate *gate =3D NULL;
-	struct clk_mux *mux =3D NULL;
+	struct clk_mux *mux;
 	const struct clk_ops *divider_ops;
 	const struct clk_ops *mux_ops;

=2D-
2.43.0


