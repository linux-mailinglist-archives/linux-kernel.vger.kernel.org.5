Return-Path: <linux-kernel+bounces-158362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6158B1ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6A81F25859
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D531272CB;
	Thu, 25 Apr 2024 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="NUq7/YHg"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404F126F02;
	Thu, 25 Apr 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039548; cv=none; b=Nq+Wd3JFSSd6cGzkL29VMpopfHXSJXF/lmgqFluwJMRjFWuS41c2OCgRIXoyi+u/c/RDw2+NjspzBFGIZI4qai0Vq1TwunGaUWtiPLKrF5fMaMbAqFNLkjH+E21uj8Rj8YcBkUpEP98S45zhj4sHee+0A4lKqQGEAel63Kfro44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039548; c=relaxed/simple;
	bh=OVGW6ZSbUoSt4wK/UxZJ+4JUS92rOYeNWMB93eVbbbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDUjdG4ILKeDmMQYY58pCasuQRARiCd7qfqs28BQ+z/lOGVoRvqZTdYzfAMhWntDcfDWKbU8r5NmbaCHozE6Wbwk1HJeTu0pQbcuxovo1gRn7/oq8DIvMdVChWwlvhPK+A7lF+uS/BU9maoqtk1B6xN481oq7UgYb+HmegcRcYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=NUq7/YHg; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714039521; x=1714644321; i=deller@gmx.de;
	bh=9LAsLycRaa4UvpIE+N25B3Hyg6P7VugQwtE6XKW1JEw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NUq7/YHglzS9guZu5d3QsHZpqWVFrXIrbVP4PbmxPAiZ8HZpcnSNX3qWh9ahmi46
	 JDaeqym8U2Cu4rsZCzACydl24BATKLl3FI7XGedDSL/y8hYTez0Q2Tkwkzt5uoAJi
	 DYSte92xsxPbYa/xYglLfHSd3Dnu+r7u4HNSwudzj3XsRBjG+fVM9mclYTRut9Jro
	 1HcG+Y6fRkDAS+zMyZ2e1RNvDI+rmQqw1RY0gDYUsEQBthvc7t7boFOLv9Y14NjoB
	 ygfeSNVd1VRDRDDaGwn9c5pKuXUuocCFWHq0nhUIPLNjB/SClUYLFie61QeLhlozg
	 F1IcfwqNnyvu+gz/+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MacOQ-1sWVZr1MDK-00cksP; Thu, 25
 Apr 2024 12:05:21 +0200
Message-ID: <1a3d30bc-130c-49ce-93ed-d380d5159dfa@gmx.de>
Date: Thu, 25 Apr 2024 12:05:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] fbdev: savage: Handle err return when
 savagefb_check_var failed
To: Cai Xinchen <caixinchen1@huawei.com>, adaplas@gmail.com,
 fullwaywang@outlook.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240416065137.530693-1-caixinchen1@huawei.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240416065137.530693-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Rj0/O/3HgrPriesmWkNSj08yYSK5pu+q5rlKaKeZ6coKrRlxkv
 0HSAP1F+yPL7thsGWeYagusE0D1a0wD1fZ9lrRL0M1UICM7Y3ppu5GHrypEJFjF9TJ5aSNV
 Eiwi4/wNQd00uYn1zy3urpL1tti5+cslOvShAVhfBtBx0+7iw6Cy8/e1FQAkcTqWO9sAmVr
 OpLk2j3xvsbim9PTym19g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fbn4asPLR6I=;oL8hMSrWljb6+vy8hfD0EJm16qx
 tK4gs8grql1KwmadUIm39IRmiGdZJX7ii+K6dhB3DMtZ2Bl6SxmuPnua33eq46rMX8P8rLwNj
 cSMwY8CCb9jkInqkvms/WiJZzYiAN/mHePCGV5UsddhvJdkAFPPgESutbYBR9W8JNcuA8l+QJ
 0gNjfyodhR6QVLKczcPPVYFNXzSRi/Pf9u6ERpVQAg0rDysbEzZ/6MR1pY6du0fsTh1ySNBdO
 VspWme+cqorwKCGcmIeN3mK1xsl8g15XXxslhn9SZJxLj2BiE+qKYYGoi84Le1xBalD9PRJHh
 1B7+zBoGvYb9NDFfw4qLFhKFoaUK7N9/nJQ9XY8sZ5qulDx8Pix3796nz0mEUEseHlAF87S7a
 kSq5BArOo9VO30SjXxhiD9TSCa8T69pgQrAbh3COT98u4bZG7FBfOFJL29Zk4WswA079jK86z
 G36PQabvvjqaZLv0WU/1phXauVQ6Z7mike0qKFE8NxANV2pQ/kqcfgD3ksT2cR7Lxv9K/7MBz
 jyq2rDjkb6nCyHYZETWMjmiguIzqQLzyvLpo2OSHquAMu7zmfuIANNWRA7rdUOT0KnFgjRzKu
 lxMH910h7F5Mv8N4z+O8mNS7EnPTpW61PmJxegp95A8l/OQp2algPDVBTR/lJoZb5fJzMHHCk
 mVJUuNptybM4+IdoLaGF5xRB/8uPMH63XMzo2g4GlmKA0SyKK5Gw1gFvEslx/M+hGAWeyr545
 R5qGGO7uA36RBe3tJ+1FAsTtM7jXFZNqXfZBDLaFwGWkly3IAoW44w/HVqkegPiHVeeUXVfBS
 XiLMZTnIvqNwDYwfrkQIMwMcBkFYY0eCn104bjUAmdRfU=

On 4/16/24 08:51, Cai Xinchen wrote:
> The commit 04e5eac8f3ab("fbdev: savage: Error out if pixclock equals zer=
o")
> checks the value of pixclock to avoid divide-by-zero error. However
> the function savagefb_probe doesn't handle the error return of
> savagefb_check_var. When pixclock is 0, it will cause divide-by-zero err=
or.
>
> Fixes: 04e5eac8f3ab ("fbdev: savage: Error out if pixclock equals zero")
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/video/fbdev/savage/savagefb_driver.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

applied.
Thanks!
Helge



>
> diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/vide=
o/fbdev/savage/savagefb_driver.c
> index ebc9aeffdde7..ac41f8f37589 100644
> --- a/drivers/video/fbdev/savage/savagefb_driver.c
> +++ b/drivers/video/fbdev/savage/savagefb_driver.c
> @@ -2276,7 +2276,10 @@ static int savagefb_probe(struct pci_dev *dev, co=
nst struct pci_device_id *id)
>   	if (info->var.xres_virtual > 0x1000)
>   		info->var.xres_virtual =3D 0x1000;
>   #endif
> -	savagefb_check_var(&info->var, info);
> +	err =3D savagefb_check_var(&info->var, info);
> +	if (err)
> +		goto failed;
> +
>   	savagefb_set_fix(info);
>
>   	/*


