Return-Path: <linux-kernel+bounces-10707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCFB81D907
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 13:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A44B212B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B88623CD;
	Sun, 24 Dec 2023 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3n1vTJij"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14F2101
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BO4cBcU030250;
	Sun, 24 Dec 2023 13:00:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=
	selector1; bh=ChpdCsWyAay6RJb9rD1FHOJqQQuXIx6a0mUEUWYCSc4=; b=3n
	1vTJijvATirIJj/YvlTEu8pERihJ9tKDj70qI5dZQbBE3475jlurmUYE2PWVUQFU
	onBfe3+pZTmhNQMHXjXl0O0C7rH0F9zWSOQxbxo9AMsv3Zi4nGb/FpHe68Y4816U
	VIQFD3RJIU8snQdbmLH/pKu3k123i4x5a7r/xs6z0ZiIMmQ04GnvGpUFGMnDCGD+
	c0B6UMly0/WOFNQhP0BoOuBRjadY49rcONaP9TWl47o28gNL4OXz03+yCpUZeqZv
	95OBgk3oYlvOf3LXC8D4QkDgL5972QLFuJb0QNp2f9rAfSt8J7GsqKNfqesuYs7N
	11N8+6dZBb3PLYi/TccA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v5nukk3pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Dec 2023 13:00:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1BB0A10005C;
	Sun, 24 Dec 2023 13:00:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10D042138EC;
	Sun, 24 Dec 2023 13:00:01 +0100 (CET)
Received: from [192.168.8.15] (10.252.24.226) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 24 Dec
 2023 13:00:00 +0100
Message-ID: <0e586f3d05a03bd5d9a8bfead55162e14a6aa4de.camel@foss.st.com>
Subject: Re: [Linux-stm32] [PATCH 12/13] irqchip/stm32-exti: Convert to
 platform remove callback returning void
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel@pengutronix.de>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Date: Sun, 24 Dec 2023 12:59:58 +0100
In-Reply-To: <ac551b89025bafadce05102b94596f8cd3564a32.1703284359.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703284359.git.u.kleine-koenig@pengutronix.de>
	 <ac551b89025bafadce05102b94596f8cd3564a32.1703284359.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-24_06,2023-12-22_01,2023-05-22_02

On Fri, 2023-12-22 at 23:50 +0100, Uwe Kleine-K=C3=B6nig wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>

Regards,
Antonio

> ---
> =C2=A0drivers/irqchip/irq-stm32-exti.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32=
-exti.c
> index 971240e2e31b..c61a97caafc9 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -898,10 +898,9 @@ static void stm32_exti_remove_irq(void *data)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_domain_remove(domain)=
;
> =C2=A0}
> =C2=A0
> -static int stm32_exti_remove(struct platform_device *pdev)
> +static void stm32_exti_remove(struct platform_device *pdev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0stm32_exti_h_syscore_dein=
it();
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static int stm32_exti_probe(struct platform_device *pdev)
> @@ -991,7 +990,7 @@ MODULE_DEVICE_TABLE(of, stm32_exti_ids);
> =C2=A0
> =C2=A0static struct platform_driver stm32_exti_driver =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D stm32_exti_probe,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D stm32_exti_remove,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove_new=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D stm32_exti_remove,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.name=C2=A0=C2=A0=C2=A0=3D "stm32_exti",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.of_match_table =3D stm32_exti_ids,


