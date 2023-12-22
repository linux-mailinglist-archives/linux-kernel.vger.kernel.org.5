Return-Path: <linux-kernel+bounces-9689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0E81C9A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53322884B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFE6179AE;
	Fri, 22 Dec 2023 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="G2BJGfNc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE417985;
	Fri, 22 Dec 2023 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703246590; x=1703851390; i=markus.elfring@web.de;
	bh=+/jv+l30EGrAi9nYpLc4XLLYanHvltsf8lsVWJ+WBq8=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=G2BJGfNcZ5Dwi+GePNcsGfk9kf3cmYpUjdmzlUiup2V04tmzmrdaJE+HKtaTFDmy
	 C9iQp9rfhg2NQYHKZNgQPYZKwe2sjR/XOQ9ff5sUMWBk4s8JtFtxWTOhJ2cqublPK
	 Wzq5t9CQvJ7v6pb7gHoEv98ynTWEIBkX2FKA0XaFms5dxCldwO6SOcKV/rqtqJIoy
	 udnlc46e/2LZfWsyFyN/33aw7qhyWFuMuPBXEfX/qfXLk4IQfqBorrbtyS9e7qEII
	 S66iJC+xMmqwbX+gmL99MI0S0BJDZDilZ7LZFc6BL33RLf4/0yKhNtkIHk6jOwGnR
	 u9rnlK7rGD14fPUG8Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcpt-1rlbDS3zIx-00Vn85; Fri, 22
 Dec 2023 13:03:10 +0100
Message-ID: <01446ce9-c0e8-4467-8b2d-fd736bc5b8e4@web.de>
Date: Fri, 22 Dec 2023 13:03:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, kernel@pengutronix.de, linux-imx@nxp.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Kuan-Wei Chiu <visitorckw@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] clk: imx: scu: Use common error handling code in
 imx_clk_scu_alloc_dev()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BGjso6szF5OPPe6YkYQSGx3cbiFicSuxRzUDu9gXysZ9LBV5Tvq
 Z6cTffdqrv7UHIX6aoglrjMVMIeKP5pSDKLNvjntsxJd+mL17ws3IVG0GKYnF+pS6T67QvK
 gr8PeMjPqAqlHHGSTj0e9Sv+JKROzNQdbR0YdGn46YScqYKsul9MgsPDHwT9q9FqJxmvmSL
 MRCmKAbKnhmhhobSBf3Qg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C43S6QqDGms=;1AS+ngQDUXyBJhSI0PdTlWudgJL
 JisRmg3aLdq7ySUByZXyBe5ukinU/bozc+P/qge5y9ew5GD6hXlSanaVebEhIvK5moYeqaAyN
 jARiNJ8NQcxgL5JRcanHezbbpdhQauCgEfaO15WtywBI9L6/x2zhjYMhCJZzZTGtzt9a8aA+c
 IzsU18Tsew5MQZ1kKLmcWE5KK9WraLVAaOCzV2j4dd1SrfPHO1I+7LKYNX54eH3wjRgEokM0H
 cltYoCZ/ZQOINV0WjgYBJnK/41T4yBXRlY/jG+hffHdGCBp58di5Wm5Mnsa6yEDzezhx5g42o
 e+aVZlXPZCR5WFBKCiZc92bFrPTkLl8SMmS28l1/SzImDcxjIEAlJoj3cvZefNyesWt+d9YE8
 SY5xhEQKB9nKAbgbNhzXYxk1WqcgphKaXKwO5XPH6wjwBDqYA8L6dqh+9q2WzuMLMqLgevj+l
 guU5+wrpnwYus5cVqXlg602wFAg7k2EHbcCppeGzUxvSqJh5OhZNj1AE06NFw8aotxiljQkyp
 Ai3M13CeYSk3YtkA7oYLnsDxuyZlUa3QkTjHHRBkgv9ZOczKaCy0HLAhFGP+KHmjX1VJ+u2Bc
 SipmOzNgd0gKQog7Fb3Pp9SbjRWzuYe6B25KYb+Lgur8f82pJMzYzQ3c0NAyIP9bKenH/TWM8
 s4GEvRZlmLm/KqBNUsipS8f/JyLhHrlG1uQ+VEH1uMV+p+1MyLAXet8Fqo1kRaWhfXKKvKJgj
 a611lmi/E2kcO1J+mdPHaXo8EWR2fnD51ntCoonYMheu83cySK/J2XsB15IgGEeW1omMY1IZb
 rETu2YO1m6n3HTBmNc0u662Krt0AITpVXxvFAI6IuGxTSMcqKXAKU72osSR4sq4jARRe0qfi9
 qixcAizdkwON+ZXaKKztKXHISzLcATiSZzVAZfqyDIpoixdbaIltFsZpdU27izUtjh8ylcGkq
 JgjelfK58dYaRUc0BOsYkU4sjiU=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 22 Dec 2023 12:56:48 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/imx/clk-scu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index e48a904c0013..b1dd0c08e091 100644
=2D-- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -712,17 +712,13 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *nam=
e,
 	}

 	ret =3D platform_device_add_data(pdev, &clk, sizeof(clk));
-	if (ret) {
-		platform_device_put(pdev);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto put_device;

 	ret =3D driver_set_override(&pdev->dev, &pdev->driver_override,
 				  "imx-scu-clk", strlen("imx-scu-clk"));
-	if (ret) {
-		platform_device_put(pdev);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto put_device;

 	ret =3D imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
@@ -730,13 +726,15 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *nam=
e,
 			name, ret);

 	ret =3D platform_device_add(pdev);
-	if (ret) {
-		platform_device_put(pdev);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto put_device;

 	/* For API backwards compatiblilty, simply return NULL for success */
 	return NULL;
+
+put_device:
+	platform_device_put(pdev);
+	return ERR_PTR(ret);
 }

 void imx_clk_scu_unregister(void)
=2D-
2.43.0


