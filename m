Return-Path: <linux-kernel+bounces-30294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E40A831CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D6CDB253C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383A5286B1;
	Thu, 18 Jan 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0nRYpd9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5841E88F;
	Thu, 18 Jan 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705592503; cv=none; b=MD230eN8YsD6lP4ezSHOVBIlM27SN6PoClVi4RfLB+2bOnFtHjOHRlbyp1IjZOzOQDLZQhCNQhtDlq6dJm9nZO+s73rhKO1gWseUR3z0a+SGkDZyJDUDEJkLOM89LiDfsDwxWxnVrHoWGB671+2V0plxbD4ELOgu7JNF6olgf10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705592503; c=relaxed/simple;
	bh=0dg8gCi027aqyQkkdyqr608rsf8Hv67e4dEkXVJeqxI=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=Cs8TA/XYIb5ZONkOVUdMJMNHK7SXSbI05Th37OXh45athwtDg01lQgHSCc/eC8Yq1nDqYXH6JIPFgQcXt2ydvdN2FslzvtJ01lFrpOhYCnTn3j7OP63FrfWd9upShA84dWhdxOmXYS9M966H8imUI77Cgbb9mldU7N5tEKqZle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0nRYpd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C458EC433F1;
	Thu, 18 Jan 2024 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705592503;
	bh=0dg8gCi027aqyQkkdyqr608rsf8Hv67e4dEkXVJeqxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0nRYpd9cOsm7r31YagIZUvR8FTkySKaPHDBJqnK76TqU1UKU3eRdYsu/R/CfUrqS
	 CCu5nmKhV+qK982KagjBWwwFot8c6UBgEEdbYnlr/0rZ8CC5g0iFYwir6RQ+iI/JAY
	 baeS58GFSqHw14sHSJ9oOg9LRMi11VqzaESfa94e/ecW9L3EYRKhRl+vqCv2s1OC+X
	 voa8yOOLT5sQ7Bx4tbEDCUlHta+b0Ru1UQb5kR8ls06RhpviHg/72xuDmV/R2kN5ez
	 MZjXYSLysNVASVpXbgT6uKLt2rPFIuu3g33U2zk0n9ZkLby4QZBmpsgMMisOC8wSx5
	 Xdj76HCdDDLDA==
Date: Thu, 18 Jan 2024 15:41:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Valentin Caron <valentin.caron@foss.st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: serial: stm32: add power-domains property
Message-ID: <20240118-sitting-stuffy-e0f6cfd9d0fa@spud>
References: <20240118091135.3314330-1-valentin.caron@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HsMrVQe1C4uOpd/T"
Content-Disposition: inline
In-Reply-To: <20240118091135.3314330-1-valentin.caron@foss.st.com>


--HsMrVQe1C4uOpd/T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:11:35AM +0100, Valentin Caron wrote:
> STM32 serial may be in a power domain.
> Allow a single 'power-domains' entry for STM32 serial devices.
>=20
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--HsMrVQe1C4uOpd/T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZalGsgAKCRB4tDGHoIJi
0kt1APoDLR0MN3FkK9xP/tGCyevBFisonRXWwOKvEjAyfkyBJwD/dm0PHjL1cCO8
0TyopCnBHeVYPHZhAt0+epTcY057qwI=
=Z8Oa
-----END PGP SIGNATURE-----

--HsMrVQe1C4uOpd/T--

