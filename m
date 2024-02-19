Return-Path: <linux-kernel+bounces-71424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823CD85A508
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B507A1C215DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE2A36B09;
	Mon, 19 Feb 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH6iZy9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7F36AF8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350153; cv=none; b=QNajzpW0A0pRAP+kPqsUa+0wQlqgCVrgYNcQN98LO1df4pQ1x09Ug7kSrlKXS2gl0o3sSJv/qlu2rhyGbbXwHCJVT14slxo2NFbJLTEHRbly3W4YObWH6MVqqI2180uEML4zfWUyZ1EtS+GyXTgp5c0o2i8I0fAdOrkiaCdbhtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350153; c=relaxed/simple;
	bh=ekWn96iKMNvp/I5xStdVDipFHjZ+JUmKFaqTXglCXl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8sjtISiMpg25233wipG4HxrGeBG8oxHF3YJVHLO8WGNniYan4pAAtoREAK1tysDHVftgq3fmLcjnM9JVP45Y6n/CbD5F94V/Aao8PL5NT2MyGxj8zEfEA/xA/PDq0nqu9/0Gj/Y5TAF7uxsPTr8Hsg/2OaCg5GqgYSnIcvPXfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH6iZy9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CBCC433C7;
	Mon, 19 Feb 2024 13:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708350153;
	bh=ekWn96iKMNvp/I5xStdVDipFHjZ+JUmKFaqTXglCXl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VH6iZy9rmngkiXVK3l1H6HZlB8jQwjtr6sl/oaIBMEQHC4TOEp7fb82NF3PBr6Lh0
	 7/4/om9OScHg7nqEFBAMhhfARQIpgNA8gMgmq/WHPi14/ID2sBAAkzej0REN8nZJV6
	 QmfhIXNZNcVxCtWmVO4UlbDqPCmU+FmGtPf2OJXeZbb7b9hfAwjixzSxH/+G6C1zMI
	 jYvnmAApZlMU70HbgYDuMvwqaYKJRzPsImnYoxRAQd2x1xO7xf93n7o3p2VvHQg7Hu
	 tfBRNzATvbRinOk+hR7w3t9VkHdfaaVi1XR61C+PBUcIu8H7I+uEvzHedQix2A6Tj9
	 ISCNK2goIOBXQ==
Date: Mon, 19 Feb 2024 13:42:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sysreg: Add register fields for ID_AA64DFR1_EL1
Message-ID: <6ec0f73f-cbac-44c5-a215-d3754ce6a5d8@sirena.org.uk>
References: <20240215065454.2489075-1-anshuman.khandual@arm.com>
 <d2722ae9-d29c-41f9-9eec-f829589adf6e@sirena.org.uk>
 <785e9bd7-f47b-4e8f-9291-0616aa87fa27@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m/O6pAuNP29MQ3iu"
Content-Disposition: inline
In-Reply-To: <785e9bd7-f47b-4e8f-9291-0616aa87fa27@arm.com>
X-Cookie: Kleeneness is next to Godelness.


--m/O6pAuNP29MQ3iu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 18, 2024 at 06:04:34AM +0530, Anshuman Khandual wrote:

> Just wondering - would something like the following make sense. Because
> 0b0000 signifies that the cycle counter would just ignore PMCR_EL0.FZS,
> where as it gets frozen with 0b0001.

> UnsignedEnum   55:52   DPFZS
>        0b0000  IGNR
>        0b0001  FRZN
> EndEnum

LGTM.

--m/O6pAuNP29MQ3iu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXTWsQACgkQJNaLcl1U
h9DhsAf+PgeKvGRhmcjsTA+KRwRFDLO8aDtLZVSK/lAH3JZi4ROmmipI0n3TpEKe
gjmzcVKdLKKLKq2qgJMvkAHskwe1pbfpwi/BW7NszdVESdO0DOMR855Tmxk0bzkg
RDLZHSp4vsEAcL4OzyoS1lb+lZBtIjX436vpz5a3kXjNrE6KPlfq/qZtbhREW+Ka
Z87RLrmDaHoP3rG57Kefrp1ljRlmPgcMg6m0TK+MaQZVoByC3Ds4iquRqM9X2lbx
IlFQ08NNa49Sy5cuWChMe20a2xsr+/fUS212LBKzZ88HtBsw21A2xK92NiPgOwI6
J5sQz2J1xkRToBYRqfi8t9jM2BRhwg==
=9eLA
-----END PGP SIGNATURE-----

--m/O6pAuNP29MQ3iu--

