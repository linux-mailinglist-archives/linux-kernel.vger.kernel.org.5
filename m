Return-Path: <linux-kernel+bounces-127568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69F894DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA991F21BC6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4583E3EA98;
	Tue,  2 Apr 2024 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vn3LNAck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8E8BF6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047075; cv=none; b=XQSftSAhRMx/SVmALattOHVH7p4OzWSqIV2X+o0GktmrZWsBDsREhi4VXtL7bmB5n9aj7k7PfcJjetoLrnbxZe7qn/FaWuEqMwVOtHGk/aE6dhkC3L+yKxtEHZtGXNvKSZ3S1CFMJVDuVczHwY3iwb7pWeKJ2q+wdsiuORadLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047075; c=relaxed/simple;
	bh=inJ99hE/Mf813k3Tfykn0x5L5yLI7RdXPXS+Gkt/Kgk=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=SJdlF05qQS0dnVkTgUj52Js1cccAo35+ylhI1j1FVJlN9rDDU/Xb1opj4UYkDN49ZVjGeolD/TmMbvi519wEbyeTXR/0sRnthyQWxo8cOjyzme1Jy0ZF4yELcLvOipETavhrphikxkTTfqQMBcV8KMFliCNumNK6K8j/KdJRjl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vn3LNAck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3576C433C7;
	Tue,  2 Apr 2024 08:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712047075;
	bh=inJ99hE/Mf813k3Tfykn0x5L5yLI7RdXPXS+Gkt/Kgk=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=Vn3LNAck1ha6JMES3xjlC6FiOfJePTINlUicb30JPQmCwOW5qQE2u44Zlb7ifPWUK
	 ft9hd4wf9pXZ/fmUm6Awwv5yBwjqLch3FT0sqjzpSlsLQ+oA12AFxKgIUOGGQVFnjx
	 1l5QIpfCBX8gNhHHhgARUS1On5bYS9x73545xUFTuamIuCwtHx7k+5Y7sr/mhq25uH
	 xvy3NYVdtmoQj+FGwOhxNfk53kvzeYIXCTosDZqH7JQ0SoJTfwLzBJ9oxlBNRPPEcA
	 VsnYMY0SgFJmrDuVkN+L3y7pw++Wa5vKJx5bhx02s7v5igS7I4wFJkuVvEIRncG0ZP
	 vIKR8BiAWeBBQ==
Content-Type: multipart/signed;
 boundary=63f27cc5fa1fe89ab86d3832b559cff15cff5f1e4f21774b7a743d336de7;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Tue, 02 Apr 2024 10:37:51 +0200
Message-Id: <D09I1ASUM95C.26G9DXT9G6WST@kernel.org>
Subject: Re: [PATCH 2/3] nvmem: layouts: onie-tlv: drop driver owner
 initialization
Cc: <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>
X-Mailer: aerc 0.16.0
References: <20240329-module-owner-nvmem-v1-0-d700685f08e1@linaro.org>
 <20240329-module-owner-nvmem-v1-2-d700685f08e1@linaro.org>
In-Reply-To: <20240329-module-owner-nvmem-v1-2-d700685f08e1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--63f27cc5fa1fe89ab86d3832b559cff15cff5f1e4f21774b7a743d336de7
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Mar 29, 2024 at 5:13 PM CET, Krzysztof Kozlowski wrote:
> Core in nvmem_layout_driver_register() already sets the .owner, so
> driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Michael Walle <mwalle@kernel.org>

-michael

--63f27cc5fa1fe89ab86d3832b559cff15cff5f1e4f21774b7a743d336de7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZgvD3xIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/irogGAra8Ir0nSbppHrtyRbiXAhWIHINGYiE2P
eHrN2lwJW/gTYkKlKOu7+Ct4bSZSVYSkAYCoyF72CuS4SOfw0XOnafhbNtw9cZry
fQWtfmzVZUmzoQgBZ8ChK/cHQKIRfAyNkqc=
=o8rC
-----END PGP SIGNATURE-----

--63f27cc5fa1fe89ab86d3832b559cff15cff5f1e4f21774b7a743d336de7--

