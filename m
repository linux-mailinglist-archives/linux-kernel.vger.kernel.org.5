Return-Path: <linux-kernel+bounces-96096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932BD875709
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAD8282FEF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB50613666A;
	Thu,  7 Mar 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELUoMbhz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA2A1BDDB;
	Thu,  7 Mar 2024 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839383; cv=none; b=iXdUbwU0KLN6KRYegBnq5370Q0E8/ARxO1RE3h9dZyGZTrl5xEeJHfW7Oc9V7fQnzpu+jmO9OnQ95uwNMkdJR0vuuYn3JO3FZmqPctvaqM2wH79812e5AGPj+TqJ8wBwj2DYFvb2b8OlcLrfqdoK5HivrSpU8BvlDngMua5VvmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839383; c=relaxed/simple;
	bh=YblulDO9X2q8t9DddMx1g+jH0EObHTszAuyRsHPwE2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkcqpPNPU64mCp71IpkHbFYYXW4zow3GmEz61IkmIVzUZ+Va3bsVo5EOyRXXyY6t5XQWiuF33c2eU4q7VMex1GJwDRlKe5Qf5TgSMF5r4le2pIPhYgOyoiFavfp4wPHte0tU01C1Ni0b+pukJvJ97HK43tHvAAW4gnRPsqPxRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELUoMbhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E75DC433F1;
	Thu,  7 Mar 2024 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709839382;
	bh=YblulDO9X2q8t9DddMx1g+jH0EObHTszAuyRsHPwE2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELUoMbhzMBbYClW9GaTdePwvD+O7oGPYLjW4aOCkR3ElnAUl1PWGb6E2bMSxZHF+C
	 UQoYM8JeeU3YQ1gpNjqHcJy/KlZAmZPKgPzNl9RTXNRi19geZ0NnYUYH9nhcuSeh36
	 6HzPkCSvZIZuvwzZHT6Lp5XUekI8RofrIVwpepKZE/anZL+BSASa3B3/LagWSq52C+
	 8oWqc+SCRFBMNs9Giri1uCZLRKIvnwHDKwKBSLOPPwFRTTPUi5sHNkZaO/00CZWHWu
	 4zEG8qpEdmSTxT1e1dRPM7+We0gqSipZBuiQhFYTKFfPYpkjn1kZoI70EePcsChXIG
	 WSIDPg1LgvX9g==
Date: Thu, 7 Mar 2024 19:22:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sakari.ailus@iki.fi
Subject: Re: [PATCH v4 1/4] dt-bindings: media: add Maxim MAX96717 GMSL2
 Serializer
Message-ID: <20240307-hardly-eligibly-f63c7849c265@spud>
References: <20240305152608.287527-1-julien.massot@collabora.com>
 <20240305152608.287527-2-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vxKKIyiziO9pkzS7"
Content-Disposition: inline
In-Reply-To: <20240305152608.287527-2-julien.massot@collabora.com>


--vxKKIyiziO9pkzS7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 04:26:05PM +0100, Julien Massot wrote:
> Add DT bindings for Maxim MAX96717 GMSL2 Serializer.
>=20
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
> Change since v3:
>  - Renamed file to maxim,max96717.yaml dropped the 'f' suffix

Same comments here :)

--vxKKIyiziO9pkzS7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeoUEQAKCRB4tDGHoIJi
0rd2AP9Jshe0QymJEY0cQbwN0VYYRGknVmKmLY8oMZkkLNTaTgD+IRZWFVuUF3ZO
jsXIyn1gEdSrL2D8wXC/oIbH9sPw2AM=
=MHPL
-----END PGP SIGNATURE-----

--vxKKIyiziO9pkzS7--

