Return-Path: <linux-kernel+bounces-135025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF6A89BA12
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A89F1C22699
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB837162;
	Mon,  8 Apr 2024 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e284onaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CE383BF;
	Mon,  8 Apr 2024 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564529; cv=none; b=Z4MpMX3yfEMeFWr2MJPKBVTlRqsYmdvc+mi0h7I4yHg01YHhGWmzZNT5XIEEio50XH+34w7YxjL7kTrRIEz4ExIFAlO8T0l+9SKoII1cHDg4BRWQiqP7gqyPBHF6YB+z1Zonsrjgv6sClQrfE0+//bd5xS2zShqJtguYX3dV9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564529; c=relaxed/simple;
	bh=B2Rx1fNaMKY8f98NWO2r36aff0MZPSma76qGnIBadfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXGDewARgS31ygSKbWIjgZRsHQrYojWeMWmlKJ3SgI57ktlt1iBfTUdvBehdRcQ8m4Kvg+Etq/dQ19BB2D+5euvGy6updzt46uCM7W14hO5shyPfLSVfrf+5fwLwjicCSXeqFQHCtZNp5PAM6/89MzYsmIOZ4fSZ63vdIWGcXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e284onaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEA1C43394;
	Mon,  8 Apr 2024 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712564528;
	bh=B2Rx1fNaMKY8f98NWO2r36aff0MZPSma76qGnIBadfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e284onaZX2LtwvM446cRTc0bcql4r1CP8PHC2I5ZJ/0fwevJO+tsWZseQRDJes6n2
	 BaxanYG/FCjHoIRXZ7TN7eHlcx/S10S1eXMPR4n5Zz85eOnw7Eh2LYeXIALdit1V5Z
	 xr+0nymQFtercGFZfPoJ/DI3SjltKzi7RzfjJrOSNuqOh1FQpUhw2oZ7jpSFA5yBpL
	 a0D7OmaBurZ/abxZ3o+6AutOvhOgGqub3F/FCU7dBb3eKD63e6B2DWgILftG31NGvk
	 vRn7HCeaF8BgvCK9cJZkiRBEqT5F1KfaNmZte3L5UNhl1mDl9Jr+5NGZgukIv6MJs+
	 /I5xkHCTrWB/Q==
Date: Mon, 8 Apr 2024 09:22:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v8 0/6] riscv: add initial support for Canaan
 Kendryte K230
Message-ID: <20240408-trimester-pusher-720882202b9e@spud>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XQccMBluk0Im+Wo1"
Content-Disposition: inline
In-Reply-To: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>


--XQccMBluk0Im+Wo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 12:26:58AM +0800, Yangyu Chen wrote:
> K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add initial
> support for it to allow more people to participate in building drivers
> to mainline for it.
>=20
> This kernel has been tested upon factory SDK [1] with
> k230_evb_only_linux_defconfig and patched mainline opensbi [2] to skip
> locked pmp and successfully booted to busybox on initrd with this log [3].
>=20
> Changes in resend v8:
> - Add missing cc to lkml and linux-dt list and correct Krzysztof's address
> - No change in content

=46rom v6:
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
https://lore.kernel.org/linux-riscv/mhng-08e43080-8679-43f8-80c5-b73304e4e6=
80@palmer-ri-x1c9/#t

No need to resend for this alone, but if you do resend, please add that
ack to all patches.

Cheers,
Conor.

--XQccMBluk0Im+Wo1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhOpKwAKCRB4tDGHoIJi
0iN8AP4n+raany0JpQbFuEWJXAZCl6cajeGZNnjZguEGfmy4yAEA8cPhneIJ509I
jVvZJAsAf8u5FhmXAOxmUaLDJ9NH+wM=
=wz0I
-----END PGP SIGNATURE-----

--XQccMBluk0Im+Wo1--

