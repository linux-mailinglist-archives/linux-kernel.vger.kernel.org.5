Return-Path: <linux-kernel+bounces-131791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A64898BD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA601F23A19
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7B112BEBC;
	Thu,  4 Apr 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twOljwbZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007712AAE1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246816; cv=none; b=idiZ++e+5lz8VEC4ef0Vwdr/7ZL+wnsn9ZmpcHDePT6BW5kFJm/GY0PfnY34r9VPxjlCwYDOozJ2aBwpiFDLZAnwl56Ir8sGVwsdQR2cb43ltj1XgH/StkLa3wfBP2j26TOriB9RJUcEzhHzU68TBCKa8xpDyereEkQA9IDkhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246816; c=relaxed/simple;
	bh=tm8+FXhH2jeA1ChsBYxkJGWhFcDL7NhzCQe0eMRIEPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6PHv++cvd+wmqaOSxMMBFDpINEo4hGttMSMTS6vF2ov1TxCR3h5ZZSXbiPrf4f+Aud8g3rx2XcGgbqEH0a40fC2rvuKiRj/eAB+vwRJa7y8mtvwM5qxy2e7mumfxh4vabZeboyh0/pvDsj/6x1aWA4aB6e8uWbxGzg0FR6Hy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twOljwbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C05C433F1;
	Thu,  4 Apr 2024 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712246815;
	bh=tm8+FXhH2jeA1ChsBYxkJGWhFcDL7NhzCQe0eMRIEPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=twOljwbZ0bR+ovWV+rHBST+6WBcax329s1c/aF3FAK55ayzBQ6d5xqL93JkQGTopf
	 aUYp0f6qVrSsj5lvv5O6W5Zwfq9tI0YXWFwKqjHDKKDvp7QFm0S7v/DG0kS6aEGwjz
	 GvxtNn2jxpbk2Yqe3qWomREMfBm97xJY+z8U9o2edO6DIO4MXFP0QpUXz5kEGf+0Q7
	 spzr+RgscH+ssdcgllP3ckKUZV4eDhOs1nJbhLEHDHyQFbSqQv/tALjSC3OxxlTOdM
	 Nxf6lnC/AWJ/c06DFIIeJ4b3KrdG0z/58VCZRjYrThHWUVzdt5SQMC4nYaBbb+Pihi
	 Hj266/LhZZymw==
Date: Thu, 4 Apr 2024 17:06:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Cooper Qu <cooper.qu@linux.alibaba.com>,
	Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
	Huang Tao <eric.huang@linux.alibaba.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Qingfang Deng <dqfext@gmail.com>, Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v2 1/2] riscv: thead: Rename T-Head PBMT to MAEE
Message-ID: <20240404-pastime-reassign-2d23a6ea6265@spud>
References: <20240329121414.688391-1-christoph.muellner@vrull.eu>
 <20240329121414.688391-2-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BrV3yln9SR0qE3lm"
Content-Disposition: inline
In-Reply-To: <20240329121414.688391-2-christoph.muellner@vrull.eu>


--BrV3yln9SR0qE3lm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 01:14:13PM +0100, Christoph M=FCllner wrote:
> T-Head's vendor extension to set page attributes has the name
> MAEE (MMU address attribute extension).
> Let's rename it, so it is clear what this referes to.
>=20
> See also:
>   https://github.com/T-head-Semi/thead-extension-spec/blob/master/xtheadm=
aee.adoc

If there's a resend, make this a Link: tag please.

> Signed-off-by: Christoph M=FCllner <christoph.muellner@vrull.eu>
> ---
>  arch/riscv/Kconfig.errata            |  8 ++++----
>  arch/riscv/errata/thead/errata.c     |  8 ++++----
>  arch/riscv/include/asm/errata_list.h | 20 ++++++++++----------
>  3 files changed, 18 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 910ba8837add..2c24bef7e112 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -82,14 +82,14 @@ config ERRATA_THEAD
> =20
>  	  Otherwise, please say "N" here to avoid unnecessary overhead.
> =20
> -config ERRATA_THEAD_PBMT
> -	bool "Apply T-Head memory type errata"
> +config ERRATA_THEAD_MAEE
> +	bool "Apply T-Head's MMU address attribute (MAEE)"
>  	depends on ERRATA_THEAD && 64BIT && MMU
>  	select RISCV_ALTERNATIVE_EARLY
>  	default y

Since this defaults to enabled, changing the name should be fair game.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--BrV3yln9SR0qE3lm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg7QGgAKCRB4tDGHoIJi
0gcZAP9ItztlZzPf4E1lK7affDvrYgtHKd4cijE1tFM7HjQ/qgD9FFW82jeSY3G2
3r0w1gIiw/SCsdFNti2fabZZZvI9JAY=
=ibXE
-----END PGP SIGNATURE-----

--BrV3yln9SR0qE3lm--

