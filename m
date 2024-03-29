Return-Path: <linux-kernel+bounces-123876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E5E890F23
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2FB1F238F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EE58479;
	Fri, 29 Mar 2024 00:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gfciA0XW"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF874EAE7;
	Fri, 29 Mar 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671706; cv=none; b=hLjTVklQXt31Gby3PVmztD1rNobA5KtCixhRN41Akg60181GBL7jnGJsghZin5POqu/typFaVQHv3BnFPTIqgauSmcOUY5Hk1YwSkFu6ElSa5JNoBua1vhcjFgbOE1Roi2N7LlDleOAPdYvDqR5zbl4usbkSCFSjPYQc59qNvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671706; c=relaxed/simple;
	bh=/Xgx1MTgqpKbtwbq2RLi95qdWuB4u1DxtYQC7TjuYmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJiDeHZN6dEc3E+szw7iH9psEIcFg0/c7yFBEQgdU164DayF53dQRmELwbUcslwR0s01lGtFTAGgC6xPWHOTdRzc4DTPw4Urgf0P+7dvCY2M1J5dN1f6De33Aa83KOmL2hszEVyoyJZNKxSYAjWGsBa3aTnTXTcr2Ix+94RIxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gfciA0XW; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711671690; x=1712276490; i=w_armin@gmx.de;
	bh=VePoPAG3s1qFRceqRmdqNDwvRYsoVhhw+FqWi8nzQqY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=gfciA0XWcVvBrzA2QWbk7zh9KMNjOQTmaKDnzWVBdXK11Z6awpNFcU1YJ4/hG0Ab
	 bV0qbnfdvZ8FKkJpkRLZPVkEIavHLPUSFdTvbpTnwYEbeovTLtPbFGc6nQ/PBxo3H
	 L1LT/9jVyvKJg3zLXBAILNj6xHSJsJNkszs2VauGw35ulpRuSB5YvP7hgoVf9QJmR
	 t7jGnCqQPK1zq9UKnKAtHq3d9vEpSQbsX8LAuO9JzhAOhTv+sf5jrL0FP8gUlV8z2
	 Gjg1IwqgFDFZhoHs/D0x8nMki8mtudMEzgILXKbPVvam/KqtQrMm/MfYvUdod2oDj
	 7eYT1npDhdQkZywcow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQnP-1s4cSq3V7d-00GtWW; Fri, 29
 Mar 2024 01:21:29 +0100
Message-ID: <da442a04-9db8-4951-98b4-3e149ea06415@gmx.de>
Date: Fri, 29 Mar 2024 01:21:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: panasonic-laptop: fix NULL dereference
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
 Kenneth Chan <kenneth.t.chan@gmail.com>
Cc: Len Brown <len.brown@intel.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Harald Welte <laforge@gnumonks.org>, Matthew Garrett <mjg@redhat.com>,
 Ivan Kapranov <i.kapranov@securitycode.ru>, lvc-project@linuxtesting.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328103518.169604-1-korotkov.maxim.s@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240328103518.169604-1-korotkov.maxim.s@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iJVFcrdsDGCUzr5SpY+dg04g4VAf8NURIS3hPWfCgCoIS3AuDw9
 CcLpTiSaR76bJaOhItDxpatQPOQlcnHln9ZfbM+me7w/EQKGlpQ35lnABcbwEFYYrQYvD3X
 jsTn+ojXDgpKcIsQENhu2LwAWFzmbbRfblfwfcq1SnDEluJLlGXi2McuPByUjaqwFNtKNC7
 +sM1pPeyXXGnfkLkQ87Bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I7U7Vx4SeWo=;202e9Q/64MPvxaDgdKBV440ZsLs
 SdeDKdNVgFCAgNtKDpWW05fxqO65JMomwrPFCdZjJHpYOjGKLO0xYgyPPjakBj++n1bsKnsQy
 WmuQ+1wnJ3eMS4L7BttnALB2UnrgKnWxyB30glz4o6tJhRgqAeRfGtyOK9DKRBmxY2QCbG1Xj
 5bP0hFMaa8MhIdBD81H0dLnV8CDQjYJxtleBFGjrC9PvDHLCT+hF8vK8/nR5XTV4AvkvvEibs
 eNa65k8ImYQo8f30rewXVyVXRqWQaFNjb9dfTaKRY6Y4IP2JePPf9C2Tb7DHkiecZhmwTBJ6L
 sE5aaZMoY7NWqbh7KJzIvhBIDW1rK5mqQudazEiDS1dGjcz8ylmIkMbMBirHnZ+cvjjC2Mk1P
 NvqPYtop/MSFR+DU9/XDcjS36ITLpTwCQJWLcmo3V5ZZk8pi1RzC6Iy6EY+CqjI/7L6MPTqWu
 AnWvxDq76u1MWECskOeAyuIa1IRf7JfEYUAw9nwK7S/x4DLZ0H3VMvxVYI9oRbkOINNSgA3P3
 6E3twvhlUyFOfGq9v4c7PiU1Xec1lUW8p8R2u6N9gWbF7Jg25w/rVQaQ+D4XyKmRfp1PwdLpm
 nmggYQCBYGbpaV0HEZI6gMjsSAFApAPHX5ahkYoKsGVCgK4I7fxDWZhWuRpxPgoHAG6BnVqPj
 Gt0mOA/INBVGPYd+KKcU0jSI0i0QHHfoP1KkR1pkv+UbwAngLNikCNODOWdVrGubxWy4CS9F2
 JUmCk4IEgGXsKsTPwJ/q2LRUkrqq+xb9JuPBNcBcCv0ZN4nK6Ai50QzE++XXDNMgQmFE0zeiT
 Rm6HP3N1IOqzj4B6tus2gjNIEBFSdI+8jynFAL06znRBA=

Am 28.03.24 um 11:35 schrieb Maxim Korotkov:

> When initializing the pcc by calling acpi_driver_data(), the "device"
> pointer was dereferenced without checking for NULL. This seems like
> a logical mistake.
>
> Added a pointer check to ensure that it is valid
> before using it for pcc initialization.

Hi,

is this check even needed? I think the ACPI driver core takes care
of passing a valid ACPI device pointer to acpi_pcc_hotkey_remove().

Thanks,
Armin Wolf

> Found by Security Code and Linux Verification Center(linuxtesting.org)
>
> Fixes: 709ee531c153 ("panasonic-laptop: add Panasonic Let's Note laptop =
extras driver v0.94")
>
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> ---
>   drivers/platform/x86/panasonic-laptop.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/=
x86/panasonic-laptop.c
> index cf845ee1c7b1..de29758b0384 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -1067,9 +1067,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device=
 *device)
>
>   static void acpi_pcc_hotkey_remove(struct acpi_device *device)
>   {
> -	struct pcc_acpi *pcc =3D acpi_driver_data(device);
> +	struct pcc_acpi *pcc;
>
> -	if (!device || !pcc)
> +	if (!device)
> +		return;
> +	pcc =3D acpi_driver_data(device);
> +	if (!pcc)
>   		return;
>
>   	i8042_remove_filter(panasonic_i8042_filter);

