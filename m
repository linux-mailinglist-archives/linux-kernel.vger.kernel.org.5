Return-Path: <linux-kernel+bounces-146380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07B78A6480
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868C01F222C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93084DEA;
	Tue, 16 Apr 2024 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uYYpoJTm"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D07EEFD;
	Tue, 16 Apr 2024 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251132; cv=none; b=Q8sEBSDiF6dCWwnkxz8z6t7SEq9F2oeYmA++DsD9TpbaVCp5qtfq3Cr46FLf9Gk5oj3Okf3rUiG1hIuJMl9SbuwrjwOmBXwcHlvMF4J7uf8awNAdBSuXvCdQHZx3uN6diTpd6QYS8ljuqJEK0qslwgpu/WGTB0fT+90mgua7r8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251132; c=relaxed/simple;
	bh=fpIr7vk9ma0F1Ajyvw7T8mvDHmQiafMnVUv8cVES/Q8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pbkEDZxhkZLvYoVyF910qvs5e34ZpDev5m6tO4WEyRpE99ImAQMo4mt3vfmbrn1oSv4t9QDWcKQApg2pxyn408c1PDGEqzR/zxC5SujK2CGlch7uwhFETBC7RddPugDRdvp3YYRON8Gs7RaYJ1u4SjQgDozAOjoqr02+2SU+p+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uYYpoJTm; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713251047; x=1713855847; i=markus.elfring@web.de;
	bh=11Y55v0AlzuRPO7ifOFiCZQ7lrJESQhpZwvX7xtpFpc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uYYpoJTmRqgk2fHBG3KnNz2CLPavpRrEfJtq6/fkxsSHPHo9hr9qcnbetfR4rbAv
	 WWYYcMCU5QC3KoHYZsERO/uCRV2oxChX6X+Rafq4yYRbQohsxFKvostPltnlOgZUZ
	 uF9kX12zxQQdi44vnDxMP2KDpxbIBaLpo5hqzClbmR4INeL93ovd+wCPNkORolTKA
	 RsWEq1pb7kj6jurgWDs/BjuRAGZTklJtZ686dqKAidxv8QQmS4EmEZg2pw3cisyw+
	 IuhR26xDJ4uJ6w3UN1gJ6I/LtVomRg8m99Raf/c0Fc4QVAeD0lf4ST2m6UyLR9hF4
	 nOhZqEsl8lmkPGi/9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvspv-1smFwO1js7-010uHt; Tue, 16
 Apr 2024 09:04:07 +0200
Message-ID: <e0377059-4073-4779-8385-506b9b39301e@web.de>
Date: Tue, 16 Apr 2024 09:03:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@chromium.org>, linux-media@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Abylay Ospan <aospan@netup.ru>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Dmitry Osipenko <digetx@gmail.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>,
 Jacopo Mondi <jacopo+renesas@jmondi.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Samuel Holland <samuel@sholland.org>, Sergey Kozlov <serjk@netup.ru>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Sylvain Petinot <sylvain.petinot@foss.st.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20240415-fix-cocci-v1-3-477afb23728b@chromium.org>
Subject: Re: [PATCH 03/35] media: uvcvideo: Refactor iterators
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240415-fix-cocci-v1-3-477afb23728b@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sHR+TeGSFgoxPZvFUHAPIEuDVzgT2GvvVwRx2R0bQhoUCLrY21q
 4aVwGDwLU20D7GafylHrOJidGYSPJoSoIzoqf+nPfG0K+ORf8VF8LHB5EhsUv86XaNhisus
 3kmBAPbDemt8Lc42bbQEjY39bQYWH3PtxU6pQC03uggivELLPehSfNoyDhXXBzC0UmXhKFx
 xJrtOT5azfeT6A+OIpOdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:03HI85af2Ns=;yQ8sKTONouBI76raH8Z58fLgdPG
 cDRdjqAFM/3eXwECjUZI9h4p6mlw8k+SOXiyN6GfwXod9KAZJOxaNqbO06huy2pgBzYXWcxaK
 1yvcUyUm5nteIAvRh5GEJ6k2V8yU4C8rRXv94JjainnOHsSdDuPbk0aZXSWp65ziquDFaUUDN
 YJZN7AsXSRRYZMDVispdvHubrvkMarfGAxoCn4+Sw/adTSJ9UOxI6QREc49RSDDGj50+NsVZA
 I9/YrIlsRw4OeLnNC7dBSfeh2gas2lmTVPAdeZE5dk0sIs7aiTx7Cpr5FEHhCUFXrkReal3EO
 gELP/4ATALLJIJbZL8oac+FZhSpqW5irTqlO//L3y6eUAaDcuOSIPWLoaYJ2J97IzS1c9eCBT
 dPZVw6RcJR7I1g+6lDJwbla9AWsE0cHKjE7xI2z8RiMQz8Rg1JfobeDUi4lCAeun4aY23r5ct
 YWwBdDrs6QXbNlkfk+vAwFpDgJQbH27hI7BnJLDoXByi4vvXAuZw1dpfEkQ80cUKCCCXCdn7X
 PvxRBpoBI4VG9b+hFjsF5IAAMMrnv9iTADoQIOgnuUIHJ96lnDCSfdzxHRFAWt2M+05cdkCb1
 Xd22EYiLsJxLnQ9xjjeW2wTuQRB2DVUy1LO2KuI3z2ZDeT+FU9j9vuFhJTTTlhlzwnv9ycOI2
 FCqhmVe/n6PxH/5bS4hKkm4lYwNU/GheqGDyJrBHSbogo2OEAjGtEGI1SveFeBPQ/PKRQkiQ8
 msmag1gLjDLzUZ3GnLIpmC2bTBr5sENz7Knm/uddln2TX5kDsFZDCPf9L9KYANSpzIuCxNgkh
 +sdpCGJrmyr6dMFVvuLSI8fFEJx9x6/qw+iAMnV+HSLrk=

I would find a hint for a variable change more appropriate in the patch su=
bject
instead of the word =E2=80=9Citerators=E2=80=9D.


=E2=80=A6
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
=E2=80=A6
> @@ -2175,16 +2177,16 @@ int uvc_xu_ctrl_query(struct uvc_video_chain *ch=
ain,
>  	int ret;
>
>  	/* Find the extension unit. */
=E2=80=A6
> +	entity =3D NULL;
> +	list_for_each_entry(iter, &chain->entities, chain) {
=E2=80=A6

I suggest to move this assignment into the definition for the affected loc=
al variable.


By the way:
I see another source code adjustment opportunity in this function implemen=
tation.
https://elixir.bootlin.com/linux/v6.9-rc4/source/drivers/media/usb/uvc/uvc=
_ctrl.c#L2165

Can it be nicer to use labels =E2=80=9Cfree_data=E2=80=9D and =E2=80=9Cunl=
ock=E2=80=9D (instead of =E2=80=9Cdone=E2=80=9D)?
How do you think about to increase the application of scope-based resource=
 management here?

Regards,
Markus

