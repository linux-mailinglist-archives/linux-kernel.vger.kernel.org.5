Return-Path: <linux-kernel+bounces-29648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C858831148
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C997FB20E80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2CD5247;
	Thu, 18 Jan 2024 02:09:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA42115;
	Thu, 18 Jan 2024 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705543753; cv=none; b=ej4d7ElJY/M0gG2UFAYJECbPPUcRWV0Zx5fRRha12G7bZ5K65o214/aT/XKi0GENT7rC1kEQ9AMLsoj9CzYX3xzmBqVFXUS5qwiZBr+i6fXFbEipStynkGoWFtxV9bFHjkfsz6/h8DNgprMz8VpFAefrpWh+otJEGCTXPyGgJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705543753; c=relaxed/simple;
	bh=z3G3oCbHidD8qynDWfVmNenXA6fw2hQV7eZGCKnPYyE=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:X-ns-mid:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=kpNAS1jXVZ/E25p6Ts3EdHPsmjzpWAEn8deAVsxM90f5HsuKXtCLlTETrJoSEzqbsltOUJ3qVymZMk0Mw1gwEunWCnLUA8WoOQrAcf5iu2OHtvSe0P36KOvKUAK3NzQE6bt5vaN8jtpYHrq0oZJIL9SC/7xGdNwRUfoDryZRTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 96769b9c0fbc46cd8ed79cbbd996c5c5-20240118
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ee66016e-655b-450a-83d8-1a213d165016,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.35,REQID:ee66016e-655b-450a-83d8-1a213d165016,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:5d391d7,CLOUDID:1b50787f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240118100344LP7I44R2,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|42|7
	4|64|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 96769b9c0fbc46cd8ed79cbbd996c5c5-20240118
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 696325700; Thu, 18 Jan 2024 10:03:42 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D0A45E000EB9;
	Thu, 18 Jan 2024 10:03:41 +0800 (CST)
X-ns-mid: postfix-65A886FD-772615417
Received: from [172.20.15.234] (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id 46FA7E000EB9;
	Thu, 18 Jan 2024 10:03:38 +0800 (CST)
Message-ID: <e583bcd5-cae6-4299-8800-80e862a6bd8f@kylinos.cn>
Date: Thu, 18 Jan 2024 10:03:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pstore/ram: Return directly after a failed kasprintf()
 call in ramoops_init_prz()
To: Markus Elfring <Markus.Elfring@web.de>, linux-hardening@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Joel Fernandes <joel@joelfernandes.org>,
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <groeck@chromium.org>, Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
References: <644f44ad-7e2b-4a1a-bbd7-ccc79d479242@web.de>
Content-Language: en-US
From: Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <644f44ad-7e2b-4a1a-bbd7-ccc79d479242@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Markus,
Thanks for your patch.

On 2024/1/18 04:24, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Jan 2024 21:09:22 +0100
>=20
> The result from a call of the function =E2=80=9Ckasprintf=E2=80=9D was =
passed to
> a subsequent function call without checking for a null pointer before
> (according to a memory allocation failure).
> This issue was detected by using the Coccinelle software.
>=20
> Thus return directly after a failed kasprintf() call.
>=20
> Fixes: 1227daa43bce1 ("pstore/ram: Clarify resource reservation labels"=
)
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   fs/pstore/ram.c | 3 +++
>   1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 88b34fdbf759..1a673a4af17c 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -595,6 +595,9 @@ static int ramoops_init_prz(const char *name,
>   	}
>=20
>   	label =3D kasprintf(GFP_KERNEL, "ramoops:%s", name);
> +	if (!label)
> +		return -ENOMEM;
> +

This part looks good to me.

Commit 1227daa43bce1 ("pstore/ram: Clarify resource reservation labels")
introduce another two more kasprintf in the ramoops_init_przs.

Could you fix it together?
>   	*prz =3D persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
>   				  cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
>   	kfree(label);
> --
> 2.43.0
>=20
--=20
Thanks,
   Kunwu


