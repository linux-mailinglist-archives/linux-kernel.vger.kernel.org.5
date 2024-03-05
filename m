Return-Path: <linux-kernel+bounces-92733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C16872511
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C66C28E01F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F2512E6D;
	Tue,  5 Mar 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU42HUNX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5AFDDAD;
	Tue,  5 Mar 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658099; cv=none; b=RJu+jwE+swOfo6mdu8WfvQVYj28m9PpcvPqT6YklfdREKTzuMf+vBci22pveYS/22g9dA++iw9tGPNPURmDcBHjoNOco+3U1UcztC5iaGu0ygJF4W63Z43vbtsNJgX8AaK7U0BXhiKJSOZxR7Z0HoBq0INwpweaSVws3xHjMI88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658099; c=relaxed/simple;
	bh=4qZMQUT97qziMrbEkR0c+mNUfDn+AAkaDuZWbsUSINQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5C5JDGT5JzyROyx0VTFliLoW2ob8859BWdpgPMWnVSDwiRsU7NiV83rGVw1iZDQy5DKB5pr38/P1voOwRLYO7/1+JHmo4+iu0jixXaak/M4lAXVZh0zswjRnx7+aIR/x8emDHVIAJRodd8ITwa7Xcu6auddBWDuA3TmgQ3iOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU42HUNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F502C433F1;
	Tue,  5 Mar 2024 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709658098;
	bh=4qZMQUT97qziMrbEkR0c+mNUfDn+AAkaDuZWbsUSINQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fU42HUNXNJ2YEmsFtU0BPLIyXXoSJjZmBlfqPyEq1dHLm9X3835jn+VMyfHVT+/1y
	 A0ZCzfbXW9Se2xrf/Kn+gVNWPzxaENVbUSrIl2Bz64IKKGOaPa6u7gsTItt5XgOoPa
	 s5nyJ69oQhhZZazxcFpA6TGBUPhoUHusXjf+cD3thL+qWodMJ/YKtkckTvzMxhYarg
	 34zbBKhN1NBLTr0JU0x6hKmr7ktJeSDPSpAc9lZwSJk/UN7WgOxzktJKk1YVM5hJG2
	 GlOZgjF3qnO7l4Y7fgj+mk0hFBhLQrhhbFBQANDh9gaA1zuRbGZ1GhryE0Drl3k+a7
	 RL9pB9EDhaZ7A==
Date: Tue, 5 Mar 2024 17:01:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	dlemoal@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>, guoren@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] riscv: dts: add initial canmv-k230 and k230-evb
 dts
Message-ID: <20240305-shorten-disallow-eae65fdc8fdb@spud>
References: <mhng-f1aa91d4-211f-4eb4-a94d-a9d88b0d3f6a@palmer-ri-x1c9>
 <7A86D933-B85F-4B29-8D6D-AB414A42AC06@cyyself.name>
 <tencent_B2C1146D4947315C8018AE90EDC64F3E6207@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7/iNqzShui/y+tHK"
Content-Disposition: inline
In-Reply-To: <tencent_B2C1146D4947315C8018AE90EDC64F3E6207@qq.com>


--7/iNqzShui/y+tHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Just chiming so that things don't get misinterpreted.

On Wed, Mar 06, 2024 at 12:37:16AM +0800, Yangyu Chen wrote:
> > On Mar 6, 2024, at 00:22, Yangyu Chen <cyy@cyyself.name> wrote:
> >> On Mar 5, 2024, at 23:54, Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >> On Mon, 04 Mar 2024 13:06:00 PST (-0800), cyy@cyyself.name wrote:
> >>> - Svpbmt and T-Head MAEE both supported
> >>>=20
> >>> T-Head C908 does support both Svpbmt and T-Head MAEE for page-based m=
emory
> >>> attributes and is controlled by csr.mxstatus. If the kernel wants to =
use
> >>> svpbmt, the m-mode software should set BIT(21) of csr.mxstatus to zero
> >>> before entering the s-mode kernel. Otherwise, the kernel will not boo=
t as 0
> >>> on T-Head MAEE represent to NonCachable Memory and it will lose dirty=
 cache
> >>> lines modification that haven't been written back to the memory.
> >>=20
> >> So I guess we need the bootloader to just be accurate here?  ie: whate=
ver
> >> extension it tells S-mode kernels is enabled is how S-mode behaves, and
> >> then this should just work itself out.

Correct, the bootloader/firmware "just" needs to write this bit to match
what it passes to onwards in the devicetree.

> > Yes. Currently, I have patched OpenSBI to disable MAEE. Conor Dooley sa=
id
> > from a public irc group that he wants to control the enable of T-Head

(#riscv on libera, the usual location)

I also suggested that that, given we can use the standard extensions,
we should use them instead of the custom extensions/errata.

> > variation of zicbom and svpbmt from dts, in addition to mimplid or
> > something now.

Correct. I'm find with the impid =3D=3D archid =3D=3D 0 condition, given th=
at's
what we need to keep to avoid regressions, but if any future T-Head CPUs
want to enable MAEE (ERRATA_THEAD_PBMT) or the custom CMOs
(ERRATA_THEAD_CMO) these should be enabled from DT. Particularly when
these CPUs can be configured to either use the T-Head versions or the
standard extensions.

> > I think that will be a better way for the bootloader to tell
> > the kernel whether the T-Head MAEE should be enabled.

You've got three options I guess. You could patch the DT in the bootloader,
or use a fixed DT that matches the bootloader, or you could use the DT
passed to the bootloader and parse the extensions to decide whether or not
to enable MAEE or Svpbmt. Seems you're going for option 2.

> > Link: https://github.com/cyyself/opensbi/commit/b113c1c01d700314a4a6962=
97ec09031a9399354
> >=20
> > Furthermore, I wonder whether a CPU node like this would be acceptable.
> > I don't have any other details of how another CPU from K230 SoC works on
> > Linux.

A CPU node like what? It is not clear to me.

--7/iNqzShui/y+tHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZedP7gAKCRB4tDGHoIJi
0vlUAQDOzEPBUwFNFekPyZA1wxs/XJG2IBFzn18OERTkISZkDQEArky2FzLuZ9b1
IyeQgq4Qy6fuiT9qN796R8RzZPoXDwg=
=mHae
-----END PGP SIGNATURE-----

--7/iNqzShui/y+tHK--

