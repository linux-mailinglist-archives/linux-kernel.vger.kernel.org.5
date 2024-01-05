Return-Path: <linux-kernel+bounces-18312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2584E825B59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 930161F21598
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F026D3608F;
	Fri,  5 Jan 2024 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CwIa9wnV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7E35F13;
	Fri,  5 Jan 2024 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704484819; x=1705089619; i=markus.elfring@web.de;
	bh=7tKN9THIKO8mzprnhNgRdQfDAhpFFaMZeNyl5X57Uk4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=CwIa9wnVA4pyddnDoXHRiF6n/xRqqyAEPRIdWC7MHKJRe/yjNQ1mIcatZ1Tc6GVG
	 KCeKgNrX3UNiE70xrYlABgOj+RlB7Lozhvz2Agf1Fm3vGvCIKMNRXCtpruk7+AVEW
	 h8vY9X3MRhlr/0OjqxRi9yLsoygYK7Pz0Vtv82cQQmtIwyXoRtXjrXBMH/S1k+oG0
	 oD9Do5ml16+xZkThoA/ijiUOzVv6y1bxllzISyYAW3DYMJ0C2wveEQkLq8DBZTE7Q
	 OeNeS9aHhGyACWVVy0DjY0clD5kvevTDKm7V7BqbbUJ0KUk+ArP5YlXRvRxtZfRJw
	 I5K5rCylCNF0UqwHgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtguh-1r41Ou11mp-00ujzR; Fri, 05
 Jan 2024 21:00:19 +0100
Message-ID: <b8aa03e0-a375-40cb-b12a-7a100a49247d@web.de>
Date: Fri, 5 Jan 2024 21:00:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: imx93: Fix an error code assignment in
 imx93_clocks_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 kernel@pengutronix.de, Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Zhanhao Hu <zero12113@hust.edu.cn>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230601033825.336558-1-zero12113@hust.edu.cn>
 <cf7b69f4-c4b2-5160-e19a-14c272b0dc6e@web.de>
In-Reply-To: <cf7b69f4-c4b2-5160-e19a-14c272b0dc6e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ix32BVSsWMwSZ6Vh5wdmlGvAtykyML3TrHZxPYOle17n3AW20uX
 X+uvlkuJHgff6iM3+VxV8y5npFJ0VopTxi92S6+mAx/UUXpF0OpHrfHidwB57yDfAMPMMhX
 UFzf2ZfEmVTFxIHTI7wl1hjviFq2DNlid7KHBLxqTGf9gUUp19DYWFK2rUKhP23BamJvr3g
 306mEbXRZbc31cmESO9Xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wFOxBD+xYDk=;IzyD/+s2SdULrl+/cVGgHxXVVdX
 pc9s8QrmnTN3LdZMtPCzXu944QwG4FwGrFJl9kwoVplzJWo6cEBD0i9srcGqktklicFKe8OYo
 WctTQKZZfsgVHzSIlsS2eJ7rQr6r38/2LtcTZKfsbu7E1SoObZYJh3vDx5AcSw1lHiAgaMAAs
 GeNaQTIdKcoYNPM6uzuAt49W7+a3phEtj2X1Gu99GsrygSqSIwyqmFSna9w7SMET5QjAEDX/X
 h4+syBqdERtceKqMabELRwi0zDUpAI5YZfo59lJC0Tfo7hjhoDM/XfWEtvIM5/3sIzd+LFH9G
 5XkE8GjgfS4Bft9U24NXrFtBvVoGiZ5l/4NN5ve5cyYTTLNIwXjfWlTz3P/ejiSb7UZSQUIup
 rMztxdmf9NRQsWy2BObLQkQETNsi78vnXqYaO/qdNFwBPt0nKYcvq044VYbOwEhqChW7/Rjgl
 9BbpaXRp7iyyl2Q2ytxkEHYm4s3FaghYMbsfuL7Tw5vAZ8u1FCsu8vhLFKy6omyPByng0cKI6
 8jgDoU/fIrVl3QGVIQ1Uiu5YcY6UI9qKHm95JMMKTzQog7heMSsE/dRfyrJKzlaKSbwDRMf0q
 TZdWmt2h9hGsVBhZ1D0vEQmEqJfYyT/TNgSsdSDnV0iLNLgoSxbStaaq0Om4ETPuDeXtNzJH6
 N/blfoiaJH5/f1vWennq8JbvqRTt5Mvidt92h5jwcLWqF70L4vfGzVJJ8/DfqTzK1HTb72rFp
 WN2cf8hfJjBoMtp4J3/aVaXkqOoTVVeNGKKSDG+G4rSW8gj9pfO1CBNae8hUR79VjfhIHBycv
 gxrIXtFLvq8HdLQLG1lLMpOvVtv2CoKkAKArMZn//kLqxnjq5Yszvim5c0MHQHGG2OsDf6LV4
 t2f2wNYNSIHwP8BgocNI25C0CnZ07fsZqfvl4TXR71FketuOr3bDtFqgLs57XmbkcsMBHhbDi
 1RKQD8rf/QT6JAwCrBa8R5kdEA8=

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 13 Jun 2023 21:50:50 +0200
>
> The variable =E2=80=9Cbase=E2=80=9D was passed to a call of the function=
 =E2=80=9CPTR_ERR=E2=80=9D
> in the implementation of the function =E2=80=9Cimx93_clocks_probe=E2=80=
=9D.
> Unfortunately, the variable was not assigned to an error pointer
> before this if branch.
> Thus use the variable =E2=80=9Canatop_base=E2=80=9D for an error code as=
signment instead.
>
> Fixes: e02ba11b4576 ("clk: imx93: fix memory leak and missing unwind got=
o in imx93_clocks_probe")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/clk/imx/clk-imx93.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index b6c7c2725906..44f435103c65 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -291,7 +291,7 @@ static int imx93_clocks_probe(struct platform_device=
 *pdev)
>  	anatop_base =3D devm_of_iomap(dev, np, 0, NULL);
>  	of_node_put(np);
>  	if (WARN_ON(IS_ERR(anatop_base))) {
> -		ret =3D PTR_ERR(base);
> +		ret =3D PTR_ERR(anatop_base);
>  		goto unregister_hws;
>  	}
>

Is this patch still in review queues?

See also:
https://lore.kernel.org/cocci/cf7b69f4-c4b2-5160-e19a-14c272b0dc6e@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-06/msg00016.html

Regards,
Markus

