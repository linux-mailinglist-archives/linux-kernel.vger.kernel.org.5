Return-Path: <linux-kernel+bounces-13121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6ACB820000
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628B72846B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC1E11C9D;
	Fri, 29 Dec 2023 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="d/uXZ7WM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1D11C80;
	Fri, 29 Dec 2023 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1703860499; x=1704465299; i=wahrenst@gmx.net;
	bh=64bsxHGjua8zwqQmTu/Y+W8szQNBOQRjMZB0v3ML914=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=d/uXZ7WMs5j6SUQkqPpYMXA3CNk5EPQdWOZtoIcyKhvJdNQPVu1SHfBMhHPK/uS7
	 euQaVd+jtQ96neu3AjYWrQztLzZ5EUArT/wlZjzyj3rQjcMJT7Oq9hYOkle9ilptp
	 tselip+T14KBXeY17lG2V6EXKbYIhn4zJsqywuQ5nP/57tNZaZ6Ln92fKGm5I6O4e
	 IyXxtu5iRH5eWlP3UlgbB+dji4S3ZJcidqclw6GTADJAmZ0GIhKnvjrBXvmo2W01L
	 e7PIXKvmv9NoSiJVcE1NuVin/L6gx3YMsq4J1KHFgwe7FNvHrM4KT+aTQtClCgSo+
	 knWlVFoTzxxvPpZRog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiaY9-1qmu042AhL-00fn83; Fri, 29
 Dec 2023 15:34:59 +0100
Message-ID: <838abf56-e2b1-474b-977a-8671a31053ed@gmx.net>
Date: Fri, 29 Dec 2023 15:34:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Fix smatch errors
Content-Language: en-US
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
 haibo.chen@nxp.com, ulf.hansson@linaro.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20231229130207.3539334-1-hardevsinh.palaniya@siliconsignals.io>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231229130207.3539334-1-hardevsinh.palaniya@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oxhusAzUB3LrMAp+zjTHuN8CWcmh5nO2uxSHDPV7++PxxgRAhJX
 kTDHXhG+iN6lfLd6nX2QtnD8O5cQGkDIIYDZWj7EfQn/D7nvejUmUBIUVAH/fZ8kmT2aszs
 V3JZk6+hhd4NtdPAHhUSMsG6EoPU/k5u4N15CQXty+nIegOU/7uETOl0x4ac2qXYsa1ToO5
 XZur1I75jnBPo9mbQP+Og==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qwtbHYET9Uo=;aCEAr1UMuLD7V6SR8uGZrErjKer
 S0tcO4VqwIampsd8m9pZMLAgoEiIbpPrwx5MXoqMRKiUktpiwQGprLaFpStI0+/wBfVJjgjd2
 9p7bA/bzEN5hXwrzhaHDgDlUuMv2wHyoGi74PgszoyRu7kTbL6nJ91WxHiYX4QfQZ7+uBSTvr
 yYfZZy2+r4U2jdQmd4ykqlcgKfU3bklUtkKnmsGxWB4HxgmV+zoLRQ13aWZ6G3b4mQ1PF5W28
 7RgXZOFNmgJhHlOLLEKwPMBFKPnbXaOKntoEKpANFHRnPlfRybv5829FHn/D4qkHCyRr7bkEE
 3Ph2leiRMr8hZrk9RvFc8nYSlmelGjeWY8Iwdyu6jyd4oIbX9pMOxNoqagUTM3Pv3XlapE5yr
 M1PdrGNlFk0dKRgRIfsNNWiHIwFomEFMazNQwA2yVwuZS2e96j6MjszsLfLpqL9+7WnQzfK56
 TrJqhbE0cfqk3aUpJB7wX/u6C6yF/zyc2MaBFdfMI1CqIGHFXFqmF4gqX9d9geV8wnpg1XRme
 Qw/RVV/8lubmODTTvmxfvKV8NPq8DSspmI/ztmN9VxSBDW/FmqXUYePCT06x6D60xpmwSd9Oi
 vcDmMLQUWMosVcCaeRUVuUqbeN1DeTp50G1NWoqzWqYAih+UfIHzryirHqRcv4slgp631XADA
 vYHMXDqSVaqc2fvlfca8t1xxRw6GQlGhMekAyiBE0NXmDgcw/USOfWE7qyxmA91H5MsFwkmSa
 hCZkhUDFohiVI9dWFujNw1xBt88QMH5BF7iglUgcOq5E6zsf8AVwvJEUV0NBPllNW8gBHfknn
 jIw7AXnGmMu/pcB72AEYFxqhNsCsIYLSI+asry5aFEwj2jTt6nBAgXEzxCNL5CGC5nFDl/Snk
 S1vx/d5Z40+6AVhSGvxDdyfXrX1R0JrTSt/6ylXB63sVtC7pzaSHWiUpuqtV4xUZtyMcxm4bm
 D0ISK/EFFxi/0waPbh0Hk7HcGa7eNWbnYnEn3eEH9xn0Zybx

Hi Hardevsinh,

the patch subject is a too generic. Maybe something like "fix
initialization of target_min/max"

Am 29.12.23 um 14:02 schrieb Hardevsinh Palaniya:
> Resolve smatch errors in esdhc_executing_tuning()
>
> esdhc_executing_tuning() error: uninitialized symbol 'target_min'
> esdhc_executing_tuning() error: uninitialized symbol 'target_max'
I think this deserve

Fixes: 541a95e64d76 ("mmc: sdhci-esdhc-imx: optimize the manual tuing
logic to get the best timing")

Thanks
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.i=
o>
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci=
-esdhc-imx.c
> index 40a6e2f8145a..839b60138f04 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1166,6 +1166,8 @@ static int esdhc_executing_tuning(struct sdhci_hos=
t *host, u32 opcode)
>   	min =3D ESDHC_TUNE_CTRL_MIN;
>   	max =3D ESDHC_TUNE_CTRL_MIN;
>   	target_win_length =3D 0;
> +	target_min =3D 0;
> +	target_max =3D 0;
>   	while (max < ESDHC_TUNE_CTRL_MAX) {
>   		/* find the mininum delay first which can pass tuning */
>   		while (min < ESDHC_TUNE_CTRL_MAX) {


