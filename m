Return-Path: <linux-kernel+bounces-158966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AE38B2778
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D5A1C235BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2314E2E7;
	Thu, 25 Apr 2024 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3rwQr1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA3514D715;
	Thu, 25 Apr 2024 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714065413; cv=none; b=ieVuYrGwFb1faE6Wvv0R4Dpvt4Lztg9BhQzcpceAd1dJXsRPHSlws3gFHqLEIgWJdm6gfYi3+u6lVCrgnsM7WD00GJchoGeL4f7ST4ijEW+7zH5wNtYM/HXdNfAehnuQxAi65VfovuvDKyAoTByschJEgzOMeWXUysKxI7uyLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714065413; c=relaxed/simple;
	bh=h3nuslD7o3VWJfas8RPx62jlgO84B3ru7Ne0t4ZCwWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H16hw+5XnQZUTQQalwk/euf//m0YTXlgN+D4dhwRGduCXkmSmM0m9TeJ9byhwwGASAzg2gV/ZE/ieeXP612cG9OInDSRzrHp9fJFzzVr3H7f8tV6secJ2s8yu5Izx8d8lI/CuSFsa3PR0oBOCVLM0P7QxWFy+deplr3T9vYDTJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3rwQr1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45ABAC113CC;
	Thu, 25 Apr 2024 17:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714065413;
	bh=h3nuslD7o3VWJfas8RPx62jlgO84B3ru7Ne0t4ZCwWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3rwQr1+fYZV/qTG7uDmYccAUXd/63FxMe5uciWqmaI9hW6mDDwpggQ3oomNLwTE6
	 FP/GNqBajwR+w9nBZensVdHrVoVwGf7G7OKcoa+RHAtyw1niecffkX86SFj4H2okGl
	 rK3GAvoUQ6QMQzA6G2PHOXR41GmWpsPs1n/zBpToKMHCtkekJ8j0l3OMaHyr1BSjKR
	 /WTqN/g7HkG/GL4Ij7LSPFlEPUvlQ4XyiuRH686nfy0vTD108h56S1MfdCgIFVRR26
	 kQ7uoKnpJDXoNKLpJLgxBXIOisV0OVHcGYXJPYuKfZCGUeR0H2WVvds+hz7rWSloTv
	 O26c82nConYxw==
Date: Thu, 25 Apr 2024 18:16:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Hari Nagalla <hnagalla@ti.com>, linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/4] dt-bindings: remoteproc: k3-m4f: Add K3 AM64x SoCs
Message-ID: <20240425-bribe-suitcase-1adc5b66021e@spud>
References: <20240424190612.17349-1-afd@ti.com>
 <20240424190612.17349-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aOAHaQZ3KdQOTFmk"
Content-Disposition: inline
In-Reply-To: <20240424190612.17349-2-afd@ti.com>


--aOAHaQZ3KdQOTFmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 02:06:09PM -0500, Andrew Davis wrote:
> From: Hari Nagalla <hnagalla@ti.com>
>=20
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU voltage domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
>=20
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
>=20
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Andrew Davis <afd@ti.com>
> +  mboxes:
> +    description: |

> +  memory-region:
> +    description: |

Not sure that either chomping operator is needed here, but that's a nit.
With the incorrect link fixed up,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--aOAHaQZ3KdQOTFmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiqQAAAKCRB4tDGHoIJi
0uyVAQCqBjDR1HNWDm/Ft288FX/CtCgwrAAwaYRV3CVSjfCgEAD+JrQLglCD8B37
8LYXCjdNLlQdR1B6Hs5HAhHIfZxW8gs=
=n4e7
-----END PGP SIGNATURE-----

--aOAHaQZ3KdQOTFmk--

