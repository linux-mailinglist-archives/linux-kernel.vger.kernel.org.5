Return-Path: <linux-kernel+bounces-107940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312808803D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D451F2224F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17952375B;
	Tue, 19 Mar 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGjDF4XU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D91CAB2;
	Tue, 19 Mar 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870373; cv=none; b=K7WL1uRU0XopQq8+S4PATy/6jndQhdcjDdWloR0nAJHmj9j3M+u17HJAvAGczPfHD/pCwSUYE5hBf5DTvpllduGwvqSEPqZlOv2Y92K4hYCbihL2W5zPWlYhnlNnRJ/NN46olRfOKP1+KHN3a3bM+xZbNIazrLNQg2exMqtWFRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870373; c=relaxed/simple;
	bh=fZ0QELwGTKD07yu3UczJUEharu+OHubpHxFZJAUTYUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0w4WYeHjGrBwpO0HsOgUKIhSccyRPO+1mqWdaYySTZ/KxqX4Y3MI/zTLJFzHCVTydHwCmhOPYsSe4PGg2o2q1KuHJrb9c8Boma47SbV/HlAWPlgZdCFo1MEY6008tZ3qeJoyxcp02EQBVBEL+n1L/2MP2Jx/h49pNGN0cjj5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGjDF4XU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B309CC433C7;
	Tue, 19 Mar 2024 17:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710870372;
	bh=fZ0QELwGTKD07yu3UczJUEharu+OHubpHxFZJAUTYUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGjDF4XUwEcd0DIpqubZHG1E9ca+QEbg+LZv+L1DruzpY8DkKAtPW+mx8gcqncrCK
	 aGSMqnimyyF9opVvsrMVQUB6aaQNWJnWzxH0Dsg1IiKY3rUGL4zUo+Gp0mD1yR/lrF
	 YUipTw5PgcvXtcuygqgyrPxTWZ22R0X+/dokUTmwau6naWroLE1CbWFFbyUOpZfSMd
	 4omkwfypp0zLalklXI0rebBgm3alw9BTx3zv/vrlPVvIHCqEoJ6nhQTxCyRephB0sg
	 ctYJrWX+aqsZe2jsPPA81mzFu3xeYXenYT0nHYgJJLWDRregqEYAKI9UMj8EzYA8Lf
	 HTolcnmTMgKuw==
Date: Tue, 19 Mar 2024 17:46:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Brandt <chris.brandt@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: timer: renesas: ostm: Document Renesas
 RZ/V2H(P) SoC
Message-ID: <20240319-value-nutmeg-f107f7ac2319@spud>
References: <20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240318160731.33960-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ic8LyRranNDuv8NG"
Content-Disposition: inline
In-Reply-To: <20240318160731.33960-2-prabhakar.mahadev-lad.rj@bp.renesas.com>


--Ic8LyRranNDuv8NG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 04:07:30PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Document the General Timer Module (a.k.a OSTM) block on Renesas RZ/V2H(P)
> ("R9A09G057") SoC, which is identical to the one found on the RZ/A1H and
> RZ/G2L SoCs. Add the "renesas,r9a09g057-ostm" compatible string for the
> RZ/V2H(P) SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Ic8LyRranNDuv8NG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfnPXwAKCRB4tDGHoIJi
0jWYAP9bu4Rs4V0ZMDUyuGoi71pY4Tx/K54RhA+b43wwtFiV8AD+NGtwyo/bwvqL
yKy84MjX2ffs142Ks+bJXs0ChqKC/A0=
=NvWw
-----END PGP SIGNATURE-----

--Ic8LyRranNDuv8NG--

