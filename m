Return-Path: <linux-kernel+bounces-65800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E29F855208
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C341F25A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46785128370;
	Wed, 14 Feb 2024 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaWBn2NC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447B84FC8;
	Wed, 14 Feb 2024 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935117; cv=none; b=CoyDD5bh3PP4R+SkpNGi2as4I1bSDoQopeoWVDSd0SFmS75z09URGkUWAiWNdvg2vIZxwP2zDKcrJqBRqUZ3rY8dJYdzna0t5frHYYlFwat1cK2SgkHshJ3YlwxUOyCjcmqLCaXB0Z1xWHWkIvKtQe/gIgHuGe0EXbls7igdsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935117; c=relaxed/simple;
	bh=Y7PdrERFt1ce10KdRlpn2u/7lalza48LMXp38SV9IhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBleN/ytPMCyeHvNcwOcYRD6Sbkffl635kMJsGEQmmFfI2Ig5rdJHNTdu8HHFrOC0ZLJzHc0fuqoCf+N0lAeSzHjxTbAIth+c49NP4aYP0u1QXxh2T6XESLt2jRWhfsiO7f+BNTYnUXOINq228BujR7nGsfCNrI6TFs5YRYier0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JaWBn2NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313A7C433C7;
	Wed, 14 Feb 2024 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707935117;
	bh=Y7PdrERFt1ce10KdRlpn2u/7lalza48LMXp38SV9IhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JaWBn2NClRT7Mryz5xOM5khcCJqqsnYqtbPR5X3QUsu7hmTp+nt0tV6dRuaGOojDL
	 ruaQBk9tVE+iSjdPxG6ms412Z6Ryo8h6ZWSBhSOVTnGXCQWhd4s3GZUBcShBObFn9K
	 qrUFdXfAbFF9zKSn+2/6xEVv3FZamlPyOLBzndP9QeUS5vU/mnB7c2yjJJPqbGBLuC
	 SvSd3gQ4vzsQPCkMkMxWA+wKs/iQbtr8iLQpe3DDqOG3igkKhntrv3YUfpJi/w9rSH
	 wFiJMWPGx6AVKyrjmDaIX8rT93SM+ReuY6NgWe1HhabkMBRJIHdskpqdNqZjlHiOj0
	 JNEs75+0TIeKA==
Date: Wed, 14 Feb 2024 18:25:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 03/12] dt-bindings: phy: add rockchip usbdp combo phy
 document
Message-ID: <20240214-duckbill-nimbly-4ca5ac491ec7@spud>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
 <20240213163609.44930-4-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nv81Ai6y9fSmboA+"
Content-Disposition: inline
In-Reply-To: <20240213163609.44930-4-sebastian.reichel@collabora.com>


--nv81Ai6y9fSmboA+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2024 at 05:32:37PM +0100, Sebastian Reichel wrote:
> +  rockchip,dp-lane-mux:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2
> +    maxItems: 4
> +    description:
> +      An array of physical Type-C lanes indexes. Position of an entry
> +      determines the DisplayPort (DP) lane index, while the value of an entry
> +      indicates physical Type-C lane. The supported DP lanes number are 2 or 4.
> +      e.g. for 2 lanes DP lanes map, we could have "rockchip,dp-lane-mux = <2,
> +      3>;", assuming DP lane0 on Type-C phy lane2, DP lane1 on Type-C phy
> +      lane3. For 4 lanes DP lanes map, we could have "rockchip,dp-lane-mux =
> +      <0, 1, 2, 3>;", assuming DP lane0 on Type-C phy lane0, DP lane1 on Type-C
> +      phy lane1, DP lane2 on Type-C phy lane2, DP lane3 on Type-C phy lane3.

>        If
> +      DP lane map by DisplayPort Alt mode, this property is not need.

You missed one of the nits I pointed out on the previous version:
"If DP lanes are mapped by" "not needed."

Otherwise, I think this looks okay to me..
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--nv81Ai6y9fSmboA+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc0FhwAKCRB4tDGHoIJi
0sOaAQDG8SsiQC7A5wr9bBBtBeBRIE8CtJgwfUKHyk2yVM5X6QEAguBGxJnbN2ef
vgyOk8oVaHzWaTJEN2h/FuMQnQB49gM=
=McaL
-----END PGP SIGNATURE-----

--nv81Ai6y9fSmboA+--

