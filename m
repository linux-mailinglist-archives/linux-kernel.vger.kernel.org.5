Return-Path: <linux-kernel+bounces-158005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054EF8B1A04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7956A283033
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFF139FE5;
	Thu, 25 Apr 2024 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE7fWK8L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E635F0C;
	Thu, 25 Apr 2024 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714020501; cv=none; b=IJgkaJJmC/SGqapakHZB0m/Owygd2xXM5GJYO1TqPTLnIzrL2E3hNE3dt02l8fiIYtrIMjlyam3haUn+6DWPfd1CSgkjJ9HAH0wnTwgyUPOS3agSFYtMnXkp7HkEJLqiyi31u2Mef6Q7tpdF+DwlVxbbE5BCF9AXHpW5vf1c9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714020501; c=relaxed/simple;
	bh=N0fWpzpqQhKoXcrRNMKIEbA2taNqTuDY6Kw85Strf/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qSiRNdS/lleJpAWd/Ol9rXrneYhgmqnGxUz8AS2M5fiHLk8KQZlDouSGJoW9uUzbaTga0aK0RiaNAohmigh2dqLElzTHwOXnHTND5Eju74W37kfzhKOaDsAHv/bCvI32oqtb9BW0SVlB24KNTl4n4n1sIf7eRGoLR5heuqvqrWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE7fWK8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC12DC113CC;
	Thu, 25 Apr 2024 04:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714020501;
	bh=N0fWpzpqQhKoXcrRNMKIEbA2taNqTuDY6Kw85Strf/8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ZE7fWK8LiRoxobTQShGT2MHn3A92vGIt7B4BC4Q109IoiK1RWRu1BjpyATQbBHiTi
	 EnrSZPZQlCc1I4SrouS/ymjYlmcJkErG6vpV2we5DN1RjfU5AJu00jR3w6afj4HJPI
	 OZnrvxht4DMOwwf7frSkhhwJ6pbXJQVec6m0bNnDgs90DCn+h0PF6StaAf36HpT68L
	 W/VwIw5MFIaL/Zo1SGwqY1ACUw3CRzGGWBPJveWsfAq5joW7ZETVZdeiGDI1YYJehH
	 2luc/rOwgxfCa8MnqRK+JPhJj/3UHoqxeuCOoyhv8gNB/xRN8Ng76vyKENNXN78IUq
	 hMA7R0Q914x6A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Apr 2024 07:48:17 +0300
Message-Id: <D0SXK2EUPF4G.M74BAD7ZDET9@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH v4 01/71] tpm: Switch to new Intel CPU model defines
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Tony Luck" <tony.luck@intel.com>, "Borislav Petkov" <bp@alien8.de>,
 "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <20240424181245.41141-1-tony.luck@intel.com>
 <20240424181444.41174-1-tony.luck@intel.com>
In-Reply-To: <20240424181444.41174-1-tony.luck@intel.com>

On Wed Apr 24, 2024 at 9:14 PM EEST, Tony Luck wrote:
> New CPU #defines encode vendor and family as well as model.
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm.h          | 2 +-
>  drivers/char/tpm/tpm_tis_core.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 61445f1dc46d..7b38ce007bdc 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -28,7 +28,7 @@
>  #include <linux/tpm_eventlog.h>
> =20
>  #ifdef CONFIG_X86
> -#include <asm/intel-family.h>
> +#include <asm/cpu_device_id.h>
>  #endif
> =20
>  #define TPM_MINOR		224	/* officially assigned */
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

+1

BR, Jarkko

