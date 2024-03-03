Return-Path: <linux-kernel+bounces-89722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7134D86F4B7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6C7283B26
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1ADDD2;
	Sun,  3 Mar 2024 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="FxA46i5o"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D18D310;
	Sun,  3 Mar 2024 12:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709467683; cv=none; b=gVjagBfmN5x/T574RMfvlzEEPTpj4WkYsLu5D/0j7PfR/PiM3W2Ju+oSiELSROoCl+gQPyFV287FhiAtJYIynrf4AE80N7SpCQihaSeqwQMFqXpN34X3TcLxdWX+zA/EoIf5bgoK/mj5jtZKk+UDktP7KclHd5f6zmCANOWT/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709467683; c=relaxed/simple;
	bh=ZVzuIPJ2Spz42dW3z+sI1ANyF8EV1ajAg3ADQrGKUwI=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=STg/01HbGk63Wue524DnkB//I7UYrmc1gZQGb6iVuqWj2q7VKSLWnJg3TrcA720VuebasyPQf6+uCd0Kxi/yuFjJsQZiCXkEAN74BCvV8pQpvc1qeIX/PI3PfCBVV8Ag7OIo87HHS6lFokKGVujIqbv3GkZeeGBFwYJ/u7gg3YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=FxA46i5o; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:To:Reply-To:From:References:Cc:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=PJwJk2t8D6bGLaekvbSUAMPsqL9sh+IsbZwuA2V5S24=;
	t=1709467681; x=1709899681; b=FxA46i5osCuwnGbbi19rlrEtSrWLXkIzhSu1bvaK9IXZSlE
	F55cKfZD0cg0+HN3WNK2pHlfXCeMUYuMY7V+RUo9dlWid5HD00edkx6W1IcpdvE8lcO6ezhYJHiCs
	9HdiL37yFB5THeGZiNzURLKcNS0Y05+t1O3zHt8pQ/1HIr3dRhk8QE8tW40TRiO21adhk3MlaafKA
	Pb343cWoS3wpWxZLF5zbBF5zITEDWabMr/wyRiVAwBi/zSIb09QpOBm1b9b7mVGp8zeyR0QZK6Wji
	pK8Nyl8bX2nZ+g80YH+Rtw/PpupTWgVDXsHairDD1dleRapbBvp7NhiT0aAGcMcA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rgkdJ-0002Pq-0Q; Sun, 03 Mar 2024 13:07:57 +0100
Message-ID: <1270339f-3d35-4281-ba02-009005877877@leemhuis.info>
Date: Sun, 3 Mar 2024 13:07:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: keep DMA buffers required for suspend/resume
Content-Language: en-US, de-DE
Cc: Sid Pranjale <sidpranjale127@protonmail.com>,
 Sid Pranjale <siddharthpranjale127@gmail.com>,
 dri-devel@lists.freedesktop.org, ML nouveau <nouveau@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>
References: <20240229175822.30613-1-sidpranjale127@protonmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To: Timur Tabi <ttabi@nvidia.com>
In-Reply-To: <20240229175822.30613-1-sidpranjale127@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709467681;934e2524;
X-HE-SMSGID: 1rgkdJ-0002Pq-0Q

[adding a bunch of list and people as well as Timur Tabi, who authored
the culprit]

Sid Pranjale, thx for the report. FWIW, I'm just replying to add this to
the regression tracking to ensure it does not fall through the cracks.
Nevertheless let me mention two things while at it:

On 29.02.24 18:58, Sid Pranjale wrote:
> Nouveau deallocates a few buffers post GPU init which are required for GPU suspend/resume to function correctly.
> This is likely not as big an issue on systems where the NVGPU is the only GPU, but on multi-GPU set ups it leads to a regression where the kernel module errors and results in a system-wide rendering freeze.

These lines are too long, see
Documentation/process/submitting-patches.rst for details.

> This commit addresses that regression by moving the two buffers required for suspend and resume to be deallocated at driver unload instead of post init.
> 
> Fixes: 042b5f8 ("drm/nouveau: fix several DMA buffer leaks")

And that should be:

Fixes:  042b5f83841fbf ("drm/nouveau: fix several DMA buffer leaks")

> Signed-off-by: Sid Pranjale <sidpranjale127@protonmail.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> index a64c81385..a73a5b589 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
> @@ -1054,8 +1054,6 @@ r535_gsp_postinit(struct nvkm_gsp *gsp)
>  	/* Release the DMA buffers that were needed only for boot and init */
>  	nvkm_gsp_mem_dtor(gsp, &gsp->boot.fw);
>  	nvkm_gsp_mem_dtor(gsp, &gsp->libos);
> -	nvkm_gsp_mem_dtor(gsp, &gsp->rmargs);
> -	nvkm_gsp_mem_dtor(gsp, &gsp->wpr_meta);
>  
>  	return ret;
>  }
> @@ -2163,6 +2161,8 @@ r535_gsp_dtor(struct nvkm_gsp *gsp)
>  
>  	r535_gsp_dtor_fws(gsp);
>  
> +	nvkm_gsp_mem_dtor(gsp, &gsp->rmargs);
> +	nvkm_gsp_mem_dtor(gsp, &gsp->wpr_meta);
>  	nvkm_gsp_mem_dtor(gsp, &gsp->shm.mem);
>  	nvkm_gsp_mem_dtor(gsp, &gsp->loginit);
>  	nvkm_gsp_mem_dtor(gsp, &gsp->logintr);

To be sure the issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot ^introduced 042b5f83841fbf
#regzbot title drm/nouveau: rendering freezes with multi-GPU setup
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

