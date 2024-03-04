Return-Path: <linux-kernel+bounces-91170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D27F7870A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDA1B23973
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB5F79932;
	Mon,  4 Mar 2024 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVDQGdi5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF078B73
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580115; cv=none; b=oMH0IPukKPV4QuE7Y4V3qrzvorFz48zGuw3fmBCanua5Ix93EFFWjStYN4h9ASe2db2BSxYc2kz5Vzo6B2E5jjHer/JBE35vrWHZY4pxAJcPJbBIpfYGM+iLajbULOiMhTXl16GeyBR9AwoBLqV8xW0ss8QKe9E1MwHCGIpUS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580115; c=relaxed/simple;
	bh=H5PqKdrGjVod2x5/bHqwhRA1EcdARgXVF0B4zM+jIvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXcBk5xn0JT//fSJhbFv3b6SLsWJXZVnbJndSLcYCvvj4Ogf1Sm/ONqu1aJmM8RbazFmv3cStVwts5gKLgaWyAz3WgBEddQ8v0Z+Nsrml9l38YtRxwWdKlVU95hhvCB90Ef7HmCDeiPeLrn4lQUddWhzJoQ/Y8asUAm0apTmrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVDQGdi5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50CEC433F1;
	Mon,  4 Mar 2024 19:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709580115;
	bh=H5PqKdrGjVod2x5/bHqwhRA1EcdARgXVF0B4zM+jIvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVDQGdi5/u2ZoVwqQBagbMsJFsSE1gWqfYoUDtLEmFCWbDzd9UMLcJLePnrkzTpah
	 DiqPMH/R0iI4bYI0cxC79ZtEzfV7vsCl80YIGM4z4FmHIrKhQ6GpaoGWD54/oxBQVm
	 OqNkq2YNmBWbWJuJIO3XcTMGPRJJP3AkMXwURuXTi/ko3/4/2vseOpw8m6eeow0MMI
	 zpCn3y1ydSuFq6qqyKqyM0vxONeCc6xvygYDZeo5BwACeJmY2PKxaLRLmQqRjrOnIB
	 KdZHwRXB3EUNfQez6VpeZCzSorMUTHXoWPW5cB2TzkGvjspzVl0RVPWlrqMhzzDfmV
	 ClLu/qsJTCTuQ==
Date: Mon, 4 Mar 2024 19:21:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: conor.dooley@microchip.com, daire.mcnamara@microchip.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] firmware: microchip: Fix over-requested allocation
 size
Message-ID: <20240304-rifling-nemeses-c830702266bc@spud>
References: <20240304101653.126570-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wMKfExtoszAhgpYP"
Content-Disposition: inline
In-Reply-To: <20240304101653.126570-1-dawei.li@shingroup.cn>


--wMKfExtoszAhgpYP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 06:16:53PM +0800, Dawei Li wrote:
> cocci warnings: (new ones prefixed by >>)
> >> drivers/firmware/microchip/mpfs-auto-update.c:387:72-78:
>    ERROR: application of sizeof to pointer
>    drivers/firmware/microchip/mpfs-auto-update.c:170:72-78:
>    ERROR: application of sizeof to pointer
>=20
> response_msg is a pointer to u32, so the size of element it points to is
> supposed to be a multiple of sizeof(u32), rather than sizeof(u32 *).
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403040516.CYxoWTXw-lkp@i=
ntel.com/
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>=20
> V1 -> V2:
> sizeof(u32)->sizeof(*response_msg)=20

Thanks for the quick respin. I'll send this as 6.9 material cos of the
proximity to the merge window and the fact that we just over-allocate
here. Thanks!

I added a Fixes: tag when I applied this, you should add those in the
future. I should've mentioned this earlier but forgot.

Thanks,
Conor.

https://git.kernel.org/conor/c/af1e0a7d39f98c0dea1b186a76fcee7da6a5f7bc


--wMKfExtoszAhgpYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYfTwAKCRB4tDGHoIJi
0rFuAQDxFJ5GT1qa5JLgA1JNpEJBkbxmIEMWJCYFlKSD4MOPwgD+PDtW+d26QimF
duEOvvqr8nkcTZl57I1xXjODkejCoAs=
=gP+N
-----END PGP SIGNATURE-----

--wMKfExtoszAhgpYP--

