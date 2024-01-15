Return-Path: <linux-kernel+bounces-26272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C98882DDD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF71F22A91
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F617BD6;
	Mon, 15 Jan 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVngNTTM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD80D17BC7;
	Mon, 15 Jan 2024 16:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9F9C433C7;
	Mon, 15 Jan 2024 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705337118;
	bh=ViDfJVgPPtY9rthYpqceej159xuom9miTC+tJZsNboU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVngNTTMNIP4L6CU5fdgNjvv0Oo1gRZ1Is6CiKzne5UWuyW0DqTGU2+DN3MKVUcQa
	 rnUNKBQHsfgmUBfWCDMzbAvbgu8gxoToUN0ze8+oVpne9kBYwTSjStn1fJHhOzcoag
	 NditqqFyScWwP2uajbi4zzkAKu3S7LNqPjBQaM7dKDVrANUUWz86SDF9keMPrOJl5E
	 ZQ4jKNhEF/t1XoSqHbYDjMhm41NtUrPh0Nw79iKPY1AW69+Af9H7Je6lmGflg2Wi8Z
	 pXmDv5gkNhPKkvuNXyThTO0M/ylG5VM//Kwpzzx1GWqqeL7unf9yIuWczs+OPUtvwi
	 tYIA6yFx2Ho4A==
Date: Mon, 15 Jan 2024 16:45:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: KyuHyuk Lee <lee@kyuhyuk.kr>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jagan Teki <jagan@edgeble.ai>, Tianling Shen <cnsztl@gmail.com>,
	Andy Yan <andyshrk@163.com>, Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: rockchip: Add Hardkernel ODROID-M1S
 board
Message-ID: <20240115-elk-paralyses-e308f1d9cc2f@spud>
References: <20240112134230.28055-1-lee@kyuhyuk.kr>
 <20240112-granola-underline-36a525dc789c@spud>
 <dc4e9808-cd36-4b99-afd9-8dd4cd16a2a9@linaro.org>
 <20240112-headsman-concur-1d47da7e3e14@spud>
 <21a8feea-7306-4016-9a58-6e5bf8fe30a8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="riS/1QbGyvUIkYNO"
Content-Disposition: inline
In-Reply-To: <21a8feea-7306-4016-9a58-6e5bf8fe30a8@linaro.org>


--riS/1QbGyvUIkYNO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 06:43:33PM +0100, Krzysztof Kozlowski wrote:
> On 12/01/2024 18:26, Conor Dooley wrote:
> >>> if the vendor for this board is hardkernel...
> >>>
> >>>> +        items:
> >>>> +          - const: rockchip,rk3566-odroid-m1s
> >>>
> >>> ...why is the vendor prefix here rockchip?
> >>
> >> Uh, good catch. I missed it when acking their earlier mistake year ago
> >> :( Would be nice if they fixed that one too.
> >=20
> > Maybe they will if they got your email, they did not get mine
> > apparently:
> > <lee@kyuhyuk.kr>: host mx02.mail.icloud.com[17.57.155.34] said: 554 5.7=
=2E1
> >     [HM08] Message rejected due to local policy. Please visit
> >     https://support.apple.com/en-us/HT204137 (in reply to end of DATA c=
ommand)
>=20
> Uh, what did you do to Apple to be denied by their policy? Admit, you
> have an Android phone?

I do. I guess that puts me on -1 social credit score. I have a macbook,
but I run linux on it, so I guess that is a +1 -0.5 sorta deal, leaving
me negative overall.

Either way, not sure what causes it. Maybe the fact that I sign all my
mail is a contributing factor, but I may not be the only @kernel.org
address that KyuHyuk Lee is not receiving mail from.

--riS/1QbGyvUIkYNO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaVhGQAKCRB4tDGHoIJi
0uviAP4vY6e5kowaPAGO9WitJXCjm8YoC2PCKDXRVbYxWNgtCQD/XT84O8/v1mMh
C1CpXZDjrgNrmxMCmlEXsjq8g9mDEAo=
=gT6T
-----END PGP SIGNATURE-----

--riS/1QbGyvUIkYNO--

