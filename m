Return-Path: <linux-kernel+bounces-100687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDE879BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3BB284AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD331420D0;
	Tue, 12 Mar 2024 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8YljozX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A98139572;
	Tue, 12 Mar 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269220; cv=none; b=cjaz7r2D11KJobqUTcV74ZYNSyNjMmKt3zyQ5kO505rWhCDvPjw0DvzrXf9t2LXKm6bLQKP19+CFcRZmeZsj5eT9rbpO6xbNJqNJkmkQFmi+tgI2/6mhNWZLsJIgQ56iI6z6YfnwMSoWrlAh0oD3E2TC+djcKgCywXPchGCkS04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269220; c=relaxed/simple;
	bh=ZleuLADETdxDZdP0Ta4Jv85GUl4W9m4R2acmNlfYAiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okqzyjSbLj7y69ZcxVB1t9Ra+8YeVdHJHcZD/95wBI/iQ0v8YeonVZ+1I95GFo8OUB5AxOzB0qJNU+NuXnpi72t2v9AwtlI3YdZmYraYBjOhe3DPhg4PbJUKpzz4u6JCY68MydfH4PaC/1/etUBL67Z0jktOQPW/8h5ZvMrZpSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8YljozX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7F7C433C7;
	Tue, 12 Mar 2024 18:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710269219;
	bh=ZleuLADETdxDZdP0Ta4Jv85GUl4W9m4R2acmNlfYAiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8YljozXxppFpBgGJoXkFdEEQvzY9FBxlCupNY6kWEMAM/o4NbPnPh9B/n8nOuHP2
	 fAHMKdc5xYMDwqVbdS1TA/NLkv03WCID3Bx9QeQmYB3OPlSCNRck/rPLj2CrFft1JP
	 442KVDsCgg8JvopYqs1f3iAbP6oUPcJNSG7XNIgWxa5QUt12Sv2nxnINTwgtFErp8P
	 GwQGuplZ128CtIezyqhK8+ACds92u+kIcFa6i7x7/9oiQbUqwoaYPVBHVSYAX7w2qw
	 fzDWeXSx7KkM5v0vH+TonF/9xiZ+aGzxnPLqpHL3HpvM4q932jdHjDw9afBWA5lamB
	 Mkcdf6LZ0JiNw==
Date: Tue, 12 Mar 2024 18:46:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: samsung: drop unused header with
 register constants
Message-ID: <20240312-disobey-playset-f3d451adf41c@spud>
References: <20240312164428.692552-1-krzysztof.kozlowski@linaro.org>
 <20240312-numbly-starfish-d2ebb32a222d@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o0HxiCWpzsHdxPd0"
Content-Disposition: inline
In-Reply-To: <20240312-numbly-starfish-d2ebb32a222d@spud>


--o0HxiCWpzsHdxPd0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 06:44:17PM +0000, Conor Dooley wrote:
> On Tue, Mar 12, 2024 at 05:44:28PM +0100, Krzysztof Kozlowski wrote:
> > The bindings header for Samsung pin controller DTS pin values (holding
> > register values in fact) was deprecated in v6.1 kernel in
> > commit 9d9292576810 ("dt-bindings: pinctrl: samsung: deprecate header
> > with register constants").  This was enough of time for users to switch
> > to in-DTS headers, so drop the bindings header.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> Have you checked whether U-Boot has also dropped use (or never did use)
> of this header?

nvm, I checked it myself and Caleb's series that moves things to use
upstream headers does't seem to use this either.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--o0HxiCWpzsHdxPd0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfCjHwAKCRB4tDGHoIJi
0hhyAQCEf6JD4mj5ZXW4GwHQXP/8jJHU2smedglO7gXQUtaq7QD/eOJInvwhBEF5
C6p9xGy/pp1Dlwyc5R820h4DCMuLsws=
=Zsuu
-----END PGP SIGNATURE-----

--o0HxiCWpzsHdxPd0--

