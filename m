Return-Path: <linux-kernel+bounces-39011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3083C9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8950289ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70331339B9;
	Thu, 25 Jan 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DatNNHTp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6541339AB;
	Thu, 25 Jan 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202571; cv=none; b=rMUtcOMnvyqNtdBoWf41iLAAZbvw2k/yZpTUJaz5m0VK3Fr+AXPPfFTcBJMuc5R4GK9iDMKAM0RUVJugZ9qpbgm3wTujiTNZPL1qyR3jsOZadGj+KLvkC8MKx2onL9uuN0vqmhT27pQ/4kPFuwnG2Xe5jegNMbzTxKIntttETeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202571; c=relaxed/simple;
	bh=pu8IV/oM2GXGcXE2FRrF9Az35Or5t0xaqQKFZwXlfCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWGYQ2KWAzDb0niKoBYCkOL8zMxWkCXkvvrmrIT/SWDsX+oHl2A0aIa12H01U324ARn6t1/JH59ol8KiY2zyUzwchlzQnNEUgHEoMFRfEDc42twYNeSXg8tHMSiwZTPhz4J3uagyzVCQTF+yfuI5PJw7H4TMDFxbg8lJzWDbSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DatNNHTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A36C43390;
	Thu, 25 Jan 2024 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706202570;
	bh=pu8IV/oM2GXGcXE2FRrF9Az35Or5t0xaqQKFZwXlfCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DatNNHTpMR3nUM8xW0u0Sza8gYNdNaU0vGnczxG30GBqGHudI0IEVdQIT2CwZ+n8z
	 Jdi+/bn2IlJ5yA0DRAlkljGe1aMgcpyPufzsCsRNdniNv4KvykSr9FftuNq1g0zOLO
	 Q+kpaQ8TxuE6v+pMFgcbyIOGPZ2Oq3h8SqTqRzreEZMZgQrpt26Zl2Xv6PcqBJZIJ0
	 e7QuP5gsVBH59vIpBkwiMBUZfxouEtCFlVKaesVGvQ6DInL/EsbJN5zE0BThiV6u3N
	 gdGA4uK4KOGztLePEZ6SaroUkOtzIljOgbQhdS3qm4rR1JPB3Do4BF2TigpxQXE8MJ
	 iP59zSeaGvJBw==
Date: Thu, 25 Jan 2024 17:09:25 +0000
From: Conor Dooley <conor@kernel.org>
To: Chen Wang <unicorn_wang@outlook.com>
Cc: AnnanLiu <annan.liu.xdu@outlook.com>, chao.wei@sophgo.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: sophgo: add watchdog dt node for CV1800
Message-ID: <20240125-gurgle-mute-03c6cad0b972@spud>
References: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
 <MA0P287MB2822D37F523A075320BDA99AFE7A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SIZWS90p3InuhLKb"
Content-Disposition: inline
In-Reply-To: <MA0P287MB2822D37F523A075320BDA99AFE7A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>


--SIZWS90p3InuhLKb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 25, 2024 at 08:15:32PM +0800, Chen Wang wrote:
> hi, Annan, I see another email with same title, any difference between them
> two? Which one you want us to review? Maybe you should void one of them.

This one I think, the other did not get sent to the mailing lists.

--SIZWS90p3InuhLKb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKVxQAKCRB4tDGHoIJi
0pF+AQDKYDVWZwKYqeMxVI0xdihLBxXitCKFLCCodXag9cndjgD/Wddnsu6w9uKh
uAAm31GYUWE0rEgZgKBpGRKH84OoyAY=
=cf4g
-----END PGP SIGNATURE-----

--SIZWS90p3InuhLKb--

