Return-Path: <linux-kernel+bounces-148747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989BB8A86E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8051F2244A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475FB146A7E;
	Wed, 17 Apr 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDUVvfqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEB141995;
	Wed, 17 Apr 2024 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366213; cv=none; b=DtfUyN4fpanY/5NS/NE3MS3kqW9QRlStUmJjb+ohr729uWoYNeKfRR7lyHjuiYfBFPex68csSbbaYivatXJioGpl2EXA+hcSyYAtYq2zjyiFtzOwjZvnjfajk8Tkb9gsT9sIbulZVvDi+ZSLZev0R6vGlgqfL/ZShiMPtZfSoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366213; c=relaxed/simple;
	bh=V2N7AMDuz9jYWqc6c9z+U9bVhSANzB8iVmzvJstXz54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ncv9aexvRvYNcOv6ltR7xgiSAgX0R/bOPH3bzqFEeaaiqZwwrZ8Nvo/889OUcPcupJDLLBssuNJFRtDDfUNzgUralKmXjSAsR7quj5iQx4nzCAiq0lzw1xtDnSMaL0T+BM2rlOk2bbmjdnD8RTwICdvRJgFxEKzMibiemiT55V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDUVvfqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF288C072AA;
	Wed, 17 Apr 2024 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713366213;
	bh=V2N7AMDuz9jYWqc6c9z+U9bVhSANzB8iVmzvJstXz54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDUVvfqDXkPFZHs5kX/STB9snvKkCQHuYgtX9Rq67q1sPgoY+IwTmpP3Aw7mYM63F
	 wucJybP+iLeqZZ46M1z4wB+WE/HMrsLAcmipEY9QQfGq3IYX4rQP8BRLMXjsiiHbm6
	 As/WgUi+j4LNNHu2tRyS3/XXuK7E6lLwmc7YSKScgof6ArrM8Ek3E3+saxUSygp9PA
	 AEyGWNy42dXB7jaLhn0wb3Qtt2ipz0uGEQAHT4Dqf8IaZri3bx1ByWDD2IeNfeObdp
	 moTWjTBvcfvTTIWjHN3wVTrjWL7xHMmynPdnOfPiXBKQvt/G9wQUTDJGov8f3ydGke
	 7uz+ttz8/U07g==
Date: Wed, 17 Apr 2024 16:03:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>, conor+dt@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add ArmSoM
Message-ID: <20240417-carefully-unknowing-418254f3e951@spud>
References: <20240416034626.317823-1-liujianfeng1994@gmail.com>
 <20240416034626.317823-2-liujianfeng1994@gmail.com>
 <13494460.uLZWGnKmhe@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g9rem694lJ5oQ4tu"
Content-Disposition: inline
In-Reply-To: <13494460.uLZWGnKmhe@diego>


--g9rem694lJ5oQ4tu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 10:21:17AM +0200, Heiko St=FCbner wrote:
> Am Dienstag, 16. April 2024, 05:46:24 CEST schrieb Jianfeng Liu:
> > Add vendor prefix for ArmSoM (https://www.armsom.org)
> >=20
> > Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
>=20
> [PATCH v3 1/3] dt-bindings: vendor-prefixes: add ArmSoM
> yesterday got a
>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> in
> https://lore.kernel.org/r/20240416-choosing-boney-33cf206d0f38@spud

Too many versions in a short space of time, guess I picked not the most
recent to respond to as it arrived in the <24h period that it usually
takes me to clear a patch from my queue.

--g9rem694lJ5oQ4tu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/kwAAKCRB4tDGHoIJi
0uHBAQCilZ3Gz5HIzFcim0yBLi4A8H51cTC9y0FJsztZxMzcFAD+NnNntnnK2Pny
VoYLwSxda8vNGpxqNVEhSU2O0ISRlQk=
=fxib
-----END PGP SIGNATURE-----

--g9rem694lJ5oQ4tu--

