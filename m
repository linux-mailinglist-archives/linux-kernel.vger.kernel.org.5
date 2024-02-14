Return-Path: <linux-kernel+bounces-64939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D5B8544E5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B121C215E3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935612B8A;
	Wed, 14 Feb 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGX+vX+j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98112B6F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902354; cv=none; b=l9yEHIHhyL4ouVxB4HUnIeA4nejR6axAZZbPukQ0JKecIdVUjWGT8N2sZhbAykHPMm6kXAK8ye5dL81HrhiCYl4VIY2ip4Dyh8nl1S2AZct8e8PzDhDUWBG/AtK3ZT6qOszSNvyBbWQeDZaAjloyWm4gRcux5IwZqSRo34uyTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902354; c=relaxed/simple;
	bh=YCSAwDQum/HxDd2CoT/zfQABImWt9YwxCQNEzNNOs6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTJUqJTnXwB94vcb8KU7OeMT4P+y4BYOKzz2eSJYyU+ov5Dii2PsS9N7JcUQBmwnVu7FBzSiDxm5GoCflfdrNl6o2ViZjIybsudV6rPjJqrh2RR06QlzAd5UrFbnVtHQkBfsse+hiJZ6qC4v3eByA+kImi2torjtin4MeouPB88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGX+vX+j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D38C433C7;
	Wed, 14 Feb 2024 09:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707902353;
	bh=YCSAwDQum/HxDd2CoT/zfQABImWt9YwxCQNEzNNOs6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGX+vX+jqWd4FMHHYyQs7KvfeIWQXq1ET9WH4GMh4nM/EhaJ/n2zF99u0VXsLZgrj
	 3T16McQ+pNGc7vqJFEp2tPHoMRjrzaKwHisxxuPoZ5k2lFmj+W3A9ldEh7OXjlSdBS
	 N6f41/3AKiOQdCkLbbpUb+8oVxFYRI0G+KxGSnIkwPWFSAEuj7B24mL2r7plqCs4Od
	 z9ofPvVPtrQA/S4DWaWAfADk6auEhY2MHTXLNf72xShUkWCBBwmRsT5/rAKQkxVuGk
	 o64HlApoifdeC5kjuP/ahD/6L/E2o19Fq8owNeYIFs7d4svhK5Esdl64v0nsk04Qdl
	 na15RMV3D7Q9A==
Date: Wed, 14 Feb 2024 09:19:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: use KERN_INFO in do_trap
Message-ID: <20240214-exclusion-pluck-fcb6352a8393@spud>
References: <mvmh6ic1y75.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7nijc44WcYvCtDli"
Content-Disposition: inline
In-Reply-To: <mvmh6ic1y75.fsf@suse.de>


--7nijc44WcYvCtDli
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:59:58AM +0100, Andreas Schwab wrote:
> Print the instruction dump with info instead of emergency level like the
> rest of the output when printing the information for an unhandled signal.

I'm not entirely sure that this is true, __show_regs() prints with
KERN_DEFAULT, but this certainly is more consistent than it was before.
Dumping at EMERG doesn't make sense to me though, so
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  arch/riscv/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index a1b9be3c4332..142f5f5168fb 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -121,7 +121,7 @@ void do_trap(struct pt_regs *regs, int signo, int cod=
e, unsigned long addr)
>  		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
>  		pr_cont("\n");
>  		__show_regs(regs);
> -		dump_instr(KERN_EMERG, regs);
> +		dump_instr(KERN_INFO, regs);
>  	}
> =20
>  	force_sig_fault(signo, code, (void __user *)addr);


--7nijc44WcYvCtDli
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcyFjQAKCRB4tDGHoIJi
0ocxAQDIDrzXGnsjXbqIAyAI1TJRyReiKYUuA7v74VxwywCPJgD8DRsTyGfmrBJF
zc+tsX0xyLCpEcYQjJd9jXUpZ91/xgc=
=uk/t
-----END PGP SIGNATURE-----

--7nijc44WcYvCtDli--

