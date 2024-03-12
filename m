Return-Path: <linux-kernel+bounces-100683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C415879BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0797C28402B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964C1420D4;
	Tue, 12 Mar 2024 18:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPWwiS1M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFC1420A0;
	Tue, 12 Mar 2024 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269062; cv=none; b=tbBooeblsffO6xF0+nn93XdLopHFVfmZhh7+uVPmw7nBiKTOfRYTj7TYTzSrVPhHIoWdOzsD943V1itawrTndQZbhDpqGOht18RVRPAo0/NnRtTKgeME82JXgIhJFdaLOnUVgsLA9lUSnygr79lDtt/8zIxykUhLDbiiYwwIrW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269062; c=relaxed/simple;
	bh=iif1BcpHJlylfkDLhpmWtR2v886CVqkik2j3Twr6i7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL8WUfRBZ7Nh1cfVUWEs8TdYdRuPGAJIxgFEw9RVrKLn0UP/wMFy8aTgq6inGzSjTYE9WtP3AgfTsBStLG8T5NUQuHXpURgQ+T2jnpfht5C0fuZHzcxf0FAIYsm4T1CinZBpfBlrxQ+nSGTbfrqjs4Le/MQAoN5QcWyQJPceWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPWwiS1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC272C433C7;
	Tue, 12 Mar 2024 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710269061;
	bh=iif1BcpHJlylfkDLhpmWtR2v886CVqkik2j3Twr6i7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YPWwiS1M6R/G7R0mHrxXCMxrOnrdiOvRx5aFClbCSJxPfiPAfxxnVppEANkSLvzEi
	 ylJpfYhGwJm2ehIchTR9R4YoYiYzY3RBhp4Phyihw2k3/xPYfKYOUwSJcMvMZ5f6um
	 gC8B5DgwYquQLqLxO8Hd8rlwtLTTfQ8N7dGr+hwVaxrn8DUX9UQ0EJHubjXCVSMMV3
	 B6SJKLbrH2OGyuj0zcxJemu3tSjkaycwUDyuG1fKCvHg0OLtuZxJkMj+ZWShOtEUiM
	 KDkddlgSqfjqusyFze643otwyAoaF049DsYfZX+NGeDwwz5f2DcMqk8CjeF+TB/k/D
	 Kp15o6yauztPA==
Date: Tue, 12 Mar 2024 18:44:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: samsung: drop unused header with
 register constants
Message-ID: <20240312-numbly-starfish-d2ebb32a222d@spud>
References: <20240312164428.692552-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QI7TeHFffOqh17Ni"
Content-Disposition: inline
In-Reply-To: <20240312164428.692552-1-krzysztof.kozlowski@linaro.org>


--QI7TeHFffOqh17Ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 05:44:28PM +0100, Krzysztof Kozlowski wrote:
> The bindings header for Samsung pin controller DTS pin values (holding
> register values in fact) was deprecated in v6.1 kernel in
> commit 9d9292576810 ("dt-bindings: pinctrl: samsung: deprecate header
> with register constants").  This was enough of time for users to switch
> to in-DTS headers, so drop the bindings header.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Have you checked whether U-Boot has also dropped use (or never did use)
of this header?

--QI7TeHFffOqh17Ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfCigQAKCRB4tDGHoIJi
0ibxAP4uYhtwRngjKd5zBQnNrSStDnhSaLkEMD+VrmhwONJFRgD6A5+2Mq+tZls2
8YHckdS2ZCS1Z2X4vQM1RRqpSfNhhgo=
=8rKW
-----END PGP SIGNATURE-----

--QI7TeHFffOqh17Ni--

