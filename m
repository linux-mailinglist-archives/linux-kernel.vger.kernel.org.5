Return-Path: <linux-kernel+bounces-148839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8E98A87F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB1E1C21A14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A613C668;
	Wed, 17 Apr 2024 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7Ggu7IW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F71474AF;
	Wed, 17 Apr 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368519; cv=none; b=AaM7FXu6iUSg+VP0CScDluSuurUyHjEOsGNDk6DR9Ru0jERTATnS5DcrfzG1PQcnzN2QyYSB7SeSdkKIVTz0xx5+9hxfL+6mUIHeu+moX1JLc+Ed/+UxJsrwtIu3IO2nPInP+O/I1OE1JWiy8ywZWqoR/Mij+Irl6PYfaJh/C0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368519; c=relaxed/simple;
	bh=X8tyzIwBha9q3PVkl2DqYe/3JNv+4UmdMfGkcEkyilM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BQVsGlq60mdXjz7/wa1kroVdjl+Vu6PtyG7DYMAIH7JwMAhe+lN5jIbtpASuRjlS/OHDS89u8YDtMHwDwhDDNHtEGJOK8UJGFvXRsBNTrXYg+Bt9GlvcF1chow5jnc052UyouoeoHIKpOUq2R02eE1pYan16CGPDF4wJ96WE3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7Ggu7IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96E7C072AA;
	Wed, 17 Apr 2024 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368519;
	bh=X8tyzIwBha9q3PVkl2DqYe/3JNv+4UmdMfGkcEkyilM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=B7Ggu7IWGOdXdvw6cVHhVTgYIqAcF3+TAvaiJNvkcPQyE5T3T1uNmpds/OjXZ8zlq
	 MjPPeSwgCG45H5zf72wpwXn1d7cnZtDpIJEOm0BToSvyDGgUl8hPvSrL/baY6FRP8n
	 8BNPjzCCNhisp+Q48STLYE5h9L0pEQlRauDnYsTKKW80MeYfdFVL86LFgc07/NXBdv
	 4lJ0LEJILNpJm0pcQbsCYGRlNjWVfT4ZoBbOP1NDqt+SOJFtp6TorI12ufwcwq2FrI
	 kCywSO0JSs+s7QFI+FPWmInZpKy0gEsD4nfaFzC3a3g42HLozi3c0XwMrbT+tMd4P8
	 zOqn57k8DrNgg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Apr 2024 18:41:56 +0300
Message-Id: <D0MIG62V6JNV.3OZB5M1T63T7@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v3 42/74] x86/cpu/vfm: Update tpm files
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Tony Luck" <tony.luck@intel.com>, "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <20240416211941.9369-1-tony.luck@intel.com>
 <20240416212202.9452-1-tony.luck@intel.com>
In-Reply-To: <20240416212202.9452-1-tony.luck@intel.com>

On Wed Apr 17, 2024 at 12:22 AM EEST, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/char/tpm/tpm.h          | 1 +
>  drivers/char/tpm/tpm_tis_core.h | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 61445f1dc46d..895f2dba266c 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -28,6 +28,7 @@
>  #include <linux/tpm_eventlog.h>
> =20
>  #ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #endif
> =20
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_c=
ore.h
> index 13e99cf65efe..c940fd18988e 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -210,7 +210,7 @@ static inline int tpm_tis_verify_crc(struct tpm_tis_d=
ata *data, size_t len,
>  static inline bool is_bsw(void)
>  {
>  #ifdef CONFIG_X86
> -	return ((boot_cpu_data.x86_model =3D=3D INTEL_FAM6_ATOM_AIRMONT) ? 1 : =
0);
> +	return ((boot_cpu_data.x86_vfm =3D=3D INTEL_ATOM_AIRMONT) ? 1 : 0);
>  #else
>  	return false;
>  #endif

Thanks!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

You want me to pick this?

BR, Jarkko

