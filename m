Return-Path: <linux-kernel+bounces-164540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA958B7F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA25286952
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369BD181CE8;
	Tue, 30 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUajm13C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB91180A65;
	Tue, 30 Apr 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498828; cv=none; b=tCHoUQ6EMZbzOa4/uftWXRz+kgK9WPvKTni/0JclUqX7rfvyg1KI4xMxdepSssCdz/jSXt2DnmsgZM+6enDJyKWfRcDk3rPqX/81xIp53Owba6Yz7qlJMY0gEjsgcMZ3Dk5TGqU7jY1CeObNZslUvdi5PwAGf7YgwUI1AGeKcbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498828; c=relaxed/simple;
	bh=A3daid6gt27LF6h7IJdI3WMp1fTrzwT7facaYskyd5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2Pd65cgCftaM4hnRKNVtgQSvFeztMdfDd57BvcjkhO0EiPODZrSH4AanG8xj53jlOTyfwkUP/QUUO7eOONJBNB+xmM2/YMt6fj2DUyG7ke9DeWkyCXkIC/bUDoNcV1XU3n9PmfXPY3LVI+k4orLWfq2/D2MuKeeCxalnl84bbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUajm13C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6515C2BBFC;
	Tue, 30 Apr 2024 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714498827;
	bh=A3daid6gt27LF6h7IJdI3WMp1fTrzwT7facaYskyd5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUajm13CSQwfI9glQZLtwzwDa8eF5mLGtIjRR2jLytylcPWrFVYQIADDDKT7kvq8X
	 WBEaxcJSMBnjL+pKVp/+mjIlzDNglcyKvWneIhNrk/QnrYq1tLLrYz2OeZKCQNKJk7
	 xBi0MYvSvCLdT+VZgwkqKPDsYMSzNbx+jSc/c5i3/E114uTMV4Qfv6gSGgDm5Pu3WW
	 pqld++E0uFp5DtzpN+aSV6lCOgkyOKj2ZUsxDeuUM1xTPYZBBczIuNewOBpVWebvAA
	 E2pFCNgKUdimYOZrxcVTmFiiVd++UltaDzXbRSW4PmHNVEYf+yodk7fj5syK5Jr4h9
	 FpFpaPjibyk0Q==
Date: Tue, 30 Apr 2024 18:40:24 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yamllint: Drop excluding quoted values with ',' from
 checks
Message-ID: <20240430-unsnap-eskimo-444052f98b7d@spud>
References: <20240426195438.2771968-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RPjVfbQMebod70Rs"
Content-Disposition: inline
In-Reply-To: <20240426195438.2771968-1-robh@kernel.org>


--RPjVfbQMebod70Rs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 02:54:37PM -0500, Rob Herring (Arm) wrote:
> From: Rob Herring <robh@kernel.org>
>=20
> Strings with commas were excluded from checks because yamllint had false
> positives for flow style maps and sequences which need quotes when
> values contain commas. This issue has been fixed as of the 1.34 release,
> so drop the work-around.

Hmm, is this a bit aggressive of an upgrade? I only checked Debian since
it is what this machine uses, and it only seems to be shipping 1.33 in
testing & unstable.

>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/.yamllint | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/.yamllint b/Documentation/=
devicetree/bindings/.yamllint
> index 358c88813937..fadbc6ad3c76 100644
> --- a/Documentation/devicetree/bindings/.yamllint
> +++ b/Documentation/devicetree/bindings/.yamllint
> @@ -7,7 +7,7 @@ rules:
>    quoted-strings:
>      required: only-when-needed
>      extra-allowed:
> -      - '[$^,[]'
> +      - '[$^[]'
>        - '^/$'
>    line-length:
>      # 80 chars should be enough, but don't fail if a line is longer
> --=20
> 2.43.0
>=20

--RPjVfbQMebod70Rs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjEtCAAKCRB4tDGHoIJi
0oFZAQD0JBzhXISrZJ4yB/rFSb4WQ9ET9q36W46JBQkBp3DuDwD9Fy+2z/xA/BqS
5K9c2nPGOH0eVUV/wZAlbDEuwRbcOgk=
=nE9f
-----END PGP SIGNATURE-----

--RPjVfbQMebod70Rs--

