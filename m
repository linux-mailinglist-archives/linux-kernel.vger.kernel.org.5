Return-Path: <linux-kernel+bounces-150477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772A08A9FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BA0284AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2A716F90F;
	Thu, 18 Apr 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OYjV0tlZ"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D4816F90E;
	Thu, 18 Apr 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457493; cv=none; b=E0560YnDdTkncR3GSS1zI9qBRSH2tgQZgOkzGU/kqAzeAZ7PyO9+DNKXT8ZsIVII8BTySKNqCk3EaUEbnYR58Ger65nCPNVVAalObn9II/7e/1EENQvNUUUF0LIVdpFO7wpl00fdrg8wmukeNfFboKUDslXpY34HrhfsLlDuGBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457493; c=relaxed/simple;
	bh=DbjXq4pJyTvVziXvUNSDua2fGdhfY5xnL5fNr9958LI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=smkjOdFeqAsZK/fCaR079xjWbv55+QrNGEWkp3vPZjb0jNfx0Oqssj6Ckrpyk+RLkzK1ImHtxNm1T7dXMr2TeaKMXV1WqY2wMy889JUGWGGovDMogO7T2BsBeUbSK1rYn/vgrl0Gm63gJpnx2awhliTQXN6mRwiyud8THrIUiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OYjV0tlZ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1713457465; x=1714062265; i=markus.elfring@web.de;
	bh=VJbd+pzZQijTTHJtcHc3eD4TbZ4PGNvmnMzb9lj7ksM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OYjV0tlZjEhljdLB8qMSLtDRrL0EuX2958PkTfl5+cTBSwk0HMjHX3v4d+Ujm+xg
	 SVUQBygJNR4KqpsoR8RafIfx+tRWrEqrnkIPz4P/D1XQ8hOUEqqxt9IleRemC7Vl9
	 lBMJ1gjvr/2HDU6J1cW/jG5x6oX0EKtiqwyrX6Xy8D9F84c6307sRJD1Glr0aqMba
	 jXsVg8is7Ds3Nhp6EsSE/jYyQIM3sudinz6zCQAsgHZAcQ5xD6bzqHIaWtTjQ3PDE
	 qRHX/eUVsyE0H879XAeJqAZF6LdeFcZUivDHKl5gmRP+nQgZOQMFySDKfQ6SYuvcH
	 6pJQMdeXxlUyRS6/rw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLE9-1sR58f44yr-00kAR6; Thu, 18
 Apr 2024 18:24:25 +0200
Message-ID: <29e1a687-99f5-4e9f-a8c5-50154312cac4@web.de>
Date: Thu, 18 Apr 2024 18:24:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vitor Soares <vitor.soares@toradex.com>, linux-pm@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org, kernel@pengutronix.de,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vitor Soares <ivitro@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20240418155151.355133-1-ivitro@gmail.com>
Subject: Re: [PATCH] pmdomain: imx8m-blk-ctrl: fix suspend/resume order
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240418155151.355133-1-ivitro@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/oCiH/JHJi2n0pqJF8inD5bHsFynG+pCawIauTrb9OI2hvhH28t
 gjjT/GOHMldhaZ0cBwtp5q8vUcWITbAuZoMK6kK9nf6WryTvVxnf/0lrscbMHYoSrgTsPjj
 n5cOrJGy/JXnIRvPsr15v50bjbvKcuRna77rvTWOc8ASNO6eFbcFNUWGQZ8vErIHXfhADDV
 +WwN5a3vQtpSibFO8PWIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gRkFTCmNWJQ=;6COwrFiZp9DOns+lAus10zZPYkA
 +Itb8ehwOrZlGnLpuAw9gy9X+IZR0SrImDhkqAxVa72T0bGfB5lceo36sTos9fzITy5XZ5IVd
 5dZ93g9lsyCfdSx8xlaOhyi9zmDNyRx4XHWOPugKzdtoLTlTHXxIR1a+NiIf6v07Go2OJ3S4Z
 Wb27B791noVlSF2Vl+M0W0W4egtlg80y+hiNjER46dYXa728ik4lQQNiKYm3O2qla3A+Mo53M
 quf+CvIlDPvv6bVbGooSh6B6Jrw9BGk/1xjd9e+MLI64HmDwfJVMDYCD30Eijte9y+gJS5vMK
 trvgu+oonniytmpMTgv4RfhDjc7dZXl9tp6rTqOucXqFAFqow2Lp5Fey9Fm51IF1WSROvahfN
 UIOFrokWIdAA6s7EMTplh7PL5oCFBNLyBUYRgR27yEYJ9I2n49YptgxtVlhNt7Eye3ftUMbiG
 z/bMsn8FdC5nKkztpb/H2Qwt9Tb2OgTzp0vyjUEn+mNuI15ipcQ8stfySwi95cOT6yDzJytdA
 stVqjFUfa9rkLR9R3B0A180zN0M5DwyvyBMOEDuEIblJqdG+75WSrquyQKka63v8yCp+Xs3bb
 k9GFGi1w9ql7HYR3bGC6JJZePjJH1ki+X3NDhJow53OcOf5zm2FlV0B/G7MoTxL4OsT7ryK2a
 N58wbWrskS7ti4zngt2h/INl6enrzkFvLqzOKem2lzpHrvrVFzudycVvVh6juW4tMtyi1Hu9W
 MBzqWFK8qZgDrgCFWKbRDsbAZAdbLZqPDowPW8e+uyv2eBCmErdKx05Jm1VCRfvQHVLoaxZFb
 EopcpViTHG6FBd8Gh4xnQRlviAL2LcdkKFugYgOXxzYqo=

>                                         =E2=80=A6, add a device link bet=
weem
> blk_ctrl and genpd power_dev. =E2=80=A6

I hope that a typo will be avoided in this change description for the fina=
l commit.

Regards,
Markus

