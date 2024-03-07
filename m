Return-Path: <linux-kernel+bounces-96166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD38757F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E041F24C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4FE13848C;
	Thu,  7 Mar 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwYf4VUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A97D130AD0;
	Thu,  7 Mar 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842286; cv=none; b=lsAQWvYf73UPPh/S6hRXzbdTanvQEBk2BKdsnwxG/TWsA8+5QfOefpIDS6qYoYy57HDyCOv57qmLpWzrlPoWXLbwt0CdM3i/e8ZPj17M3EfEHe3G+zjeiozZIa0rEN1NKDsX+4xvwh1MFqCRIiOO3JpbjY14UJ0pKgA4plGcCVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842286; c=relaxed/simple;
	bh=PRBFZzxdnpbyh1YzxY3vy1NxVesh8HXasBP1ah/s4Iw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SUu4pbuTzMUpaA2gUtV08S74/XKGWeV1i2Wgbi3sLr6lL7myWVV/85JYP8u//1CivHmMFcCqnqxGcCrq+HWxvCBPikV0O9OM37c7HH/Lpe8bLCt6bQiW1N1tZMivFk2Yu+fDLlg0T+f4wy7L5ogIuLOb+A6V9dkZzl4X4wbn25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwYf4VUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAC9C433A6;
	Thu,  7 Mar 2024 20:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709842285;
	bh=PRBFZzxdnpbyh1YzxY3vy1NxVesh8HXasBP1ah/s4Iw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=dwYf4VUQ+8MNiFFZOdC5+Xg2Q6c6ZutnWss0KZMLp8KlC8GDhhSlnMpJbLNM/z6eV
	 IlXT0LgZE000dtOPKKG4nUzX4daZFcfjq81v3Z2KL6poa6s+aKSM9Y6zXp83bb1oLX
	 vf7H/wbVBC1SkcE1cV7c9XRVVcThE2GaFeAGxtKYgQAXvMLpJQC7lJuxf8znez1+nG
	 tE2kFPtPqel/nooorKOw1X+MuvznCTPh8UYE29mc4gbm6Th3I4tei7YmQXbyFngbKC
	 w/rlOojq3q9qQKvHj/LjNM7A0cm2xCrnL1WjF0nXIo0td7VBd5cfIXxpPvmqxgA+tQ
	 kHDV8NBkmu/hw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 22:11:21 +0200
Message-Id: <CZNSI4DXQMH4.2IYN7ZDJEBG59@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, <mpe@ellerman.id.au>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, <rnsastry@linux.ibm.com>,
 <peterhuewe@gmx.de>, <viparash@in.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/prom_init: Replace linux,sml-base/sml-size
 with linux,sml-log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-2-stefanb@linux.ibm.com>
In-Reply-To: <20240306155511.974517-2-stefanb@linux.ibm.com>

On Wed Mar 6, 2024 at 5:55 PM EET, Stefan Berger wrote:
> linux,sml-base holds the address of a buffer with the TPM log. This
> buffer may become invalid after a kexec and therefore embed the whole TPM
> log in linux,sml-log. This helps to protect the log since it is properly
> carried across a kexec with both of the kexec syscalls.

So, I see only description of the problem but nothing how it gets
addressed.

>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  arch/powerpc/kernel/prom_init.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_i=
nit.c
> index e67effdba85c..41268c30de4c 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1956,12 +1956,8 @@ static void __init prom_instantiate_sml(void)
> =20
>  	reserve_mem(base, size);
> =20
> -	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-base",
> -		     &base, sizeof(base));
> -	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
> -		     &size, sizeof(size));
> -
> -	prom_debug("sml base     =3D 0x%llx\n", base);
> +	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-log",
> +		     (void *)base, size);
>  	prom_debug("sml size     =3D 0x%x\n", size);
> =20
>  	prom_debug("prom_instantiate_sml: end...\n");

BR, Jarkko

