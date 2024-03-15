Return-Path: <linux-kernel+bounces-104161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75A687C9EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADFD282F57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601B17555;
	Fri, 15 Mar 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Xn08gufH"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACB134CC;
	Fri, 15 Mar 2024 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710491376; cv=none; b=SJOon3cOGjx4TpQPB8eFLRwD9veogqxo9OGKrSO1+qSjgMU4/LE3t5VOEDD+CmUwRyjK01e9gFGBNPqHUYL0UPYNypEjaVculpSGxsUHNIGvpOIB50VQe133DGoA+K9HWhGD9jvGPCURBYmmzDuWgoqMNTNVZdHjKCYaG1RSVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710491376; c=relaxed/simple;
	bh=Y6lyqBU1YA79p4Z/zEQTqQb/TfOILkZ2ClmAhgEhMCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgH4wpPZt6WLh313Ac3OBvg3Tif8KvccXqefmWMpaC/RUV5L5FTl4CcUQpDKzqqW0dBEKeDyDEnoWVody1qwwo5m91Cu93aJZ8eaiSYQSOPeh306zV//8Khwuu9ztgkAFO3scHs2skg4R1EUnhLG29QCe98j893+pdnJ09P/Pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Xn08gufH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710491369; x=1711096169; i=deller@gmx.de;
	bh=DRERBXkYgd3InDo5KZv6bhRTudaIQNVFtDngTRSzu00=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Xn08gufHziucYRgya7yvPTp1MDtUmkz20u+S4xu2pu8c6ClHC9rt4cXUWSjKMa2R
	 zgZLok4wQZrvI1jl83B+1W5u7H7LeZmmfl9Vehc+oQ7Lz32JILQF0h3wLVWax0eMC
	 H8wm9/7v8RrDDl83qO2mOciK8ddIfaZCpUIjP0TsVvRQeMUkPwnuth9I1h1Y6TJLX
	 t31m6ITYcVMn31M1+19Abli9M3xnN0YzUsqO4ycXWQ2g0LsEsc4OeRKIuMyUzhQve
	 hytZfbz9+FpXIzmd5FGa9JZaxHsrRlQ08iGqALsI5u1hPh4iXIvomZZTL/5FQeu+4
	 MVCdWOy2xPwbpyHmkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.155.107]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhyc-1rYRkh23wg-00DmtN; Fri, 15
 Mar 2024 09:29:29 +0100
Message-ID: <a12e7880-6337-4172-9c2d-c44d90581d07@gmx.de>
Date: Fri, 15 Mar 2024 09:29:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev: uvesafb: Convert sprintf/snprintf to sysfs_emit
Content-Language: en-US
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240314095813.1326057-1-lizhijian@fujitsu.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240314095813.1326057-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xn68aHE0I10lrYhDuFJEntWUTBud3XFbNkHauGlzZ+JdzkYhLxB
 zqe/aUQon1nQJhj3c5fcrGQelUTd9J1fAUTes1tg5rwO5V0OI+yWUdM4kH+havHpXgPtlBi
 wqlNgaLX8RCejbEZ0pNfc2MnSUQGm4jDmB8QK3P6pB+EEVRHIezTzA2R2oFTFwtWcbgZOPv
 8ug6c09GDPmhEWRNeKSvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:izEPSAVtNgw=;eZZ++F8L5u+zJf/V0z6KJLTIC89
 NkBXErb+JK7pQxFB43UMsrMt9iDpSOHAcW1V0AiIY3qgAg8t0GHg57X6M/pSoWjwVTwirZLdM
 gXr87HKd1hL6kiJU7InuL+qiqCwtzI3/UNWe0SrQCBTHgModXX1/xXELkteaYzjUSbdYt1q6k
 N6uDkdHW7moYtztwrd3TaQ/v7Z2O0V/Ahox/4M/dnm0whcgq4c2pqbxFKRhC+bq00/3J3N+hT
 rRAiCOYfmTNKG2BNf7ZJ81N/3fXHH76G+lADof5kSXBUPxRdB5WHftfiQovMcB6QK7toyRbyV
 vD+xd6A/R976pP/m2Y4wjKc5AQ4GoOS6Zg/JvENgXVdyMGZWE6XRY+UQ+fVbvKHg375Hla1Xj
 dQaQh68FsDetkfvN+jtaAHXZyNLBsx6Pt/zxgKD3d9MjTaAFPv/ywBuOPFjqOXRPOZKt5h+6g
 XR/dwQRoRtDvzB+1isee1pUs6wjWvsCqqEvoiAn1sf6ulllYg2kGyP0KxJueBTVeksuCWDMy1
 JreNj0Gz2SHkIc+Gv3/IXSA1OWZCWS1k79gyRlPvpOq3msV1zHKQ5VoxtLs49/V22Bx21mLlY
 V6N4O0WLNBwsRaAEyBWkT3XpipjFNhYl79UI2A8Kdaeyd/B5B6aqDF0YYu6J4Syu2TylvbOYo
 9ynf/OhLXgPjCvvlOpHgziqh5K9anykPL4apWC1xMS/2XVDISD2iV1DMxzqtcr5oED7swcEvD
 ZbTB9jHzG9DvB/tjAYgPrCx+y8fvwFB+O+z+eeNEsSL2VedJT2zwQcVuSOsGtsnBgkB8hKn/1
 8nphAt1Y81aTAMlAOFvNu0XOJOIw6DqcEsBtUkNvEydYg=

On 3/14/24 10:58, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user spac=
e.
>
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
>
> sprintf() will be converted as weel if they have.
>
> Generally, this patch is generated by
> make coccicheck M=3D<path/to/file> MODE=3Dpatch \
> COCCI=3Dscripts/coccinelle/api/device_attr_show.cocci
>
> No functional change intended
>
> CC: Helge Deller <deller@gmx.de>
> CC: linux-fbdev@vger.kernel.org
> CC: dri-devel@lists.freedesktop.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

applied.

Thanks!
Helge


> ---
> This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
> Split them per subsystem so that the maintainer can review it easily
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fuji=
tsu.com/
> ---
>   drivers/video/fbdev/uvesafb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb=
c
> index e1f421e91b4f..73f00c079a94 100644
> --- a/drivers/video/fbdev/uvesafb.c
> +++ b/drivers/video/fbdev/uvesafb.c
> @@ -1546,7 +1546,7 @@ static ssize_t uvesafb_show_vbe_ver(struct device =
*dev,
>   	struct fb_info *info =3D dev_get_drvdata(dev);
>   	struct uvesafb_par *par =3D info->par;
>
> -	return snprintf(buf, PAGE_SIZE, "%.4x\n", par->vbe_ib.vbe_version);
> +	return sysfs_emit(buf, "%.4x\n", par->vbe_ib.vbe_version);
>   }
>
>   static DEVICE_ATTR(vbe_version, S_IRUGO, uvesafb_show_vbe_ver, NULL);


