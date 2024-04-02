Return-Path: <linux-kernel+bounces-128498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87CE895BAB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B524284177
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C71115ADA2;
	Tue,  2 Apr 2024 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4MCHV42"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2E159919;
	Tue,  2 Apr 2024 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082236; cv=none; b=Ss+fOY8fE5oL1F0tTZCAYRy+JImZau1LKuIlgpdxPosO1/H8FG80QKCBWwFZ80gokWG6rhFAGh29of6Pv4cnwZxQMeFEdfPj+/4LvogB+zgnyc4nq8ptxarpyBj7DFp/3AOYI6+baYCDLqVj7BcTSNWQLDZ9TYDt4pL9OJdbMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082236; c=relaxed/simple;
	bh=Gia3PJ/pTbgS5Xu5S+L3NHjZx1rOFy/cQ21okp0HyKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+jNos2TcgANzgCpmiiWIwSH/PMstJI1ENzTnFsoj0DlAJuhvpEWV/1pJQE4yljUXx3ISYSNMt5DHUy8bjQsn48FBz8i5cJfAhgwwAmzp4s9hqxgbzFM7NlD781otQMz/5NLVg871FB+INmePuZa+PGZ8/tWekWGe/LKxmDNcJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4MCHV42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70379C433C7;
	Tue,  2 Apr 2024 18:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712082236;
	bh=Gia3PJ/pTbgS5Xu5S+L3NHjZx1rOFy/cQ21okp0HyKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q4MCHV42LW7nqwJSDTI+Ivu6GUpR8atPJKCL2zodHhgr5IrwOngaWu+EI9v70Ebq7
	 YziOddpg7xRx+0k8ISflaoFzHVQD7xluwQplriWaQSvIsLG9W1K/p/pXkY1J+Oa8xK
	 imau/oI0X3A7Wk2HzSvknq8wWrWG5R6N0vW3MaH7O/MeA0B1oy1ZA/68nUyHr8cnwQ
	 5LO2q+L2tHCkUR5Z9XnlzoH06xiL5N3a7oygjc4wnqk9QFo4aEzV9w8bIqU411p0zv
	 Ru/0iEio5LVENI/e7m1lTB1vvhMhQvK12/Fu2c50GpnnqsoHaHpBvoJQumpZ24nR52
	 Age9eRbyaJbyw==
Date: Tue, 2 Apr 2024 19:23:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rockchip: grf: Add missing type to
 'pcie-phy' node
Message-ID: <20240402-squabble-verbalize-eab2f023ab49@spud>
References: <20240401204959.1698106-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QHSzEAA4z92jaQnw"
Content-Disposition: inline
In-Reply-To: <20240401204959.1698106-1-robh@kernel.org>


--QHSzEAA4z92jaQnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2024 at 03:49:58PM -0500, Rob Herring wrote:
> 'pcie-phy' is missing any type. Add 'type: object' to indicate it's a
> node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--QHSzEAA4z92jaQnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxNOAAKCRB4tDGHoIJi
0kbNAP9PTPDNx46FKB4FfxwYJkXcJno9c3xbpSnu/rzH75pDqQEAioZJxLQHq7uf
NfEgWMGka5JijDJPseORnW26UuPh+AQ=
=2XGU
-----END PGP SIGNATURE-----

--QHSzEAA4z92jaQnw--

