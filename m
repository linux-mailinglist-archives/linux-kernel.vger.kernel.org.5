Return-Path: <linux-kernel+bounces-34972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF06838A12
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEFC1F25D47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860F25822D;
	Tue, 23 Jan 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibVNWuXQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02158ACE;
	Tue, 23 Jan 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706001322; cv=none; b=lHC61WI8NB0qJs0zhfwx7YFGtFCH5oSd5AOGwtn1fCOLZgQ2iiFdnPFr1538yzSKz0c3IU2oxfwu3SdbkZRN1oKMzuBycKRRVcEhCuv/r9vOlvIF7/xNmTVBEGG50GkTt6yo+Q8+CG6MZ90nkyc2lLB74hwPKQgJuldn1FRPhTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706001322; c=relaxed/simple;
	bh=C/q8o5kLPhhfSoji4iZJv2bCVDUdnPxN+hjpssNxaK4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=F+skL01WoIayh77wMBaeA24nFD7+/sN9htYQ/y0gL2OOZ3tbdxpCEIx9cHl8YKWS/AWH05phFOgdpCXMC0qagIkgvUPHbjE08N29R1fnZo6gFEhK0oxQe6yBFco3t/9m1F5w5QxQZ7ASy5+kA7+U2WxDgY8B9nWiD1kvzsy9x0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibVNWuXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646D4C43390;
	Tue, 23 Jan 2024 09:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706001321;
	bh=C/q8o5kLPhhfSoji4iZJv2bCVDUdnPxN+hjpssNxaK4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ibVNWuXQT2KYOYx801hv1IWlSYU1NThCA2PTo2RuwYKNESz41Xx6knxpitqpqtlpw
	 1AYTjNv1lnCD5wawBMm6LLGV1FCvn5LMvYdNC79EEdFpxBUQdfIit5x8l4lFpaWY54
	 8M2A/5Nc3TEbPRGW4+LnrUsi/1kM9995h3aUyP3zzWSZWFfUg5VkEVJDkHix5cUh1i
	 rOEDrwY6ocw2WmDjMmoJInkDYej3SSX9K1GArnxZNZcWfQ5sUo4LWaRXCRXi0UUXc1
	 PXKugZlQbCtoRCZVTmPGTFxAsSXdc09waRZeSvjzwrmW1eyULUM702YpGvuVfRnRx9
	 5pWCYXOytk2Eg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 09:15:16 +0000
Message-Id: <CYLYZT8Q5YPS.BF3JHG87K4EJ@seitikki>
Cc: "Dave Hansen" <dave.hansen@linux.intel.com>, "Thomas Gleixner"
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov"
 <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 <linux-sgx@vger.kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt"
 <justinstitt@google.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 22/82] x86/sgx: Refactor intentional wrap-around
 calculation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Kees Cook" <keescook@chromium.org>, <linux-hardening@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-22-keescook@chromium.org>
In-Reply-To: <20240123002814.1396804-22-keescook@chromium.org>

On Tue Jan 23, 2024 at 12:26 AM UTC, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
>
> 	VAR + value < VAR
>
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
>
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(), retaining the result for later usage (which removes
> the redundant open-coded addition). This paves the way to enabling the
> wrap-around sanitizers in the future.
>
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f185365=
94 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-sgx@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/kernel/cpu/sgx/ioctl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/io=
ctl.c
> index b65ab214bdf5..4b8f6c9f8ef5 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -350,16 +350,18 @@ static int sgx_validate_offset_length(struct sgx_en=
cl *encl,
>  				      unsigned long offset,
>  				      unsigned long length)
>  {
> +	unsigned long sum;
> +
>  	if (!IS_ALIGNED(offset, PAGE_SIZE))
>  		return -EINVAL;
> =20
>  	if (!length || !IS_ALIGNED(length, PAGE_SIZE))
>  		return -EINVAL;
> =20
> -	if (offset + length < offset)
> +	if (check_add_overflow(offset, length, &sum))
>  		return -EINVAL;
> =20
> -	if (offset + length - PAGE_SIZE >=3D encl->size)
> +	if (sum - PAGE_SIZE >=3D encl->size)
>  		return -EINVAL;
> =20
>  	return 0;

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

