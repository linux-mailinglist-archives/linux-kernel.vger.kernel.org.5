Return-Path: <linux-kernel+bounces-134346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B4F89B086
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EA02827AA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E92200DB;
	Sun,  7 Apr 2024 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKsbdN24"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5417577;
	Sun,  7 Apr 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712487570; cv=none; b=DD0DyDYqHiRJ6/VlPcBpq7PuXlM3H/euXbXNyGJhNTPMmowJHWiqE7EINAJMZFnL2WOcZ7EIrNJyo1kNCFIy++ygf7LhqcU9m/Q48ZDFen0ktOTVAbXb9a/oVpXtJKH1X42hZfZ1dfkHvA0bBKFZ5C/Qf7SsU3ZfVM6i7VmKdvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712487570; c=relaxed/simple;
	bh=mUqwJvMwwddQUj3/Op3ujtR7UUXWdIvM3MJCfhjD1tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAcJiX7olEMOPzxxpEFt0EV6hL2HM+0Y42DkejoImb0cLrgv+pq/qcMHyQrGZ3i5v/kzaifmS7uywerMwhab6/flYfaRfs+HotyAX/zx0Ow2PWxTM1rwNdAPVHQCTVCGmJtg467+XwthZLMCc1ioSrJuiHaRKjY8PgxwE3Q5EOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKsbdN24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C51AC433F1;
	Sun,  7 Apr 2024 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712487570;
	bh=mUqwJvMwwddQUj3/Op3ujtR7UUXWdIvM3MJCfhjD1tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKsbdN24NetxsdAUdftzcQGHZxeRaoDejGMt7iJYzfdfSBOJW/NvlcrebKEceshmz
	 htEB+uslSRnpbNWvN//HFjN7AyG4NbtQtgUAR5rGmXSiXGHC89STlACMQQW9BdBTjD
	 eoyvlkR5FmpwUVF9dq5Fpwb1hs5dyfbyTo23+RlF6+2FlAGyb3E8RJHhDej8EsucF9
	 0VF1f2+fYuh0/tAk3+VtocRAVvG9cTdeLa4yWGdbY71DpEi1w9TVTQoXUo6SI9EYJk
	 22nqltABbRh5r4k1uQhqU4yQ+RhKOK88AVgssP7i3/OHJ3UyTfyOw4Xrx/qE5Bwz9d
	 FHvtFiZ+vpQhw==
Date: Sun, 7 Apr 2024 11:59:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: kbuild: Add separate
 target/dependency for processed-schema.json
Message-ID: <20240407-other-widow-399ec7ca8c8f@spud>
References: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
 <20240405-dt-kbuild-rework-v2-3-3a035caee357@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LrPBrqQ2Jt21+wkW"
Content-Disposition: inline
In-Reply-To: <20240405-dt-kbuild-rework-v2-3-3a035caee357@kernel.org>


--LrPBrqQ2Jt21+wkW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 05:56:03PM -0500, Rob Herring wrote:
> Running dtbs_check and dt_compatible_check targets really only depend
> on processed-schema.json, but the dependency is 'dt_binding_check'. That
> was sort worked around with the CHECK_DT_BINDING variable in order to
> skip some of the work that 'dt_binding_check' does. It still runs the
> full checks of the schemas which is not necessary and adds 10s of
> seconds to the build time. That's significant when checking only a few
> DTBs and with recent changes that have improved the validation time by
> 6-7x.
>=20
> Add a new target, dt_binding_schema, which just builds
> processed-schema.json and can be used as the dependency for other
> targets. The scripts_dtc dependency isn't needed either as the examples
> aren't built for it.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Yoo, that's pretty nice. 20 seconds cut off my dtbs_check build time on
riscv with this change :) As you point out, when you're not checking all
that many it is pretty significant - 48 seconds before and 28 seconds now
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--LrPBrqQ2Jt21+wkW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhJ8jQAKCRB4tDGHoIJi
0jngAP9fiiu62rotgAy0KbbE5nvYcdXtnLZ30d8vRNvq0TJFegEAlR0OmWLZUSHx
bsiXSS4PqQRiXrr6DDj0IaPJS2n/qw4=
=p86i
-----END PGP SIGNATURE-----

--LrPBrqQ2Jt21+wkW--

