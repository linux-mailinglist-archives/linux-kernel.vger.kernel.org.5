Return-Path: <linux-kernel+bounces-20130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFDF827A42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158A12842A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84CA5644C;
	Mon,  8 Jan 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGw7zeYl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35A5644F;
	Mon,  8 Jan 2024 21:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B1DC433C7;
	Mon,  8 Jan 2024 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704749696;
	bh=TbKhcaDX991KzdmgWtOOMq+69pB52opa1WG/z42fjVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGw7zeYlNKuhfc3QbUjT9b3DZcn4DgXX75R4CKVqbjUrumGlB1OBnzGdSUABVGIDs
	 QHiDoWscn6mTQfo2BE2e9PNDIWT1SKuDGH+ter0CuPZMVFcl8rtaMykN4Km8xn1YLq
	 hUVSIzxMTEqjjeOGYprtLQFq3nRE6Z+tFVxCnjiKPgiSkA0LDZ4+YyJUUT6SvEeY/i
	 noKtgG1bg3V4t7xoJwQ76yzhFWHs8lnjxFMgyFS33hGdW5ai6tI0I0ySOMLsQZX40C
	 ZIT5lcRYrXC3C3GFl5OJbjXkcVs9BfBFpz9ttaD8Ua51wBwNVyMlBx0pUAlozbBX5D
	 cFRnk5Qm/wmVQ==
Date: Mon, 8 Jan 2024 21:34:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
	johannes.holland@infineon.com, linux@roeck-us.net,
	andre.werner@systec-electronic.com,
	Andrew Geissler <geissonator@yahoo.com>,
	patrick.rudolph@9elements.com, vincent@vtremblay.dev,
	peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
	bhelgaas@google.com, naresh.solanki@9elements.com,
	alexander.stein@ew.tq-group.com, festevam@denx.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
	geert+renesas@glider.be, luca.ceresoli@bootlin.com
Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: System1: IBM system1 BMC board
Message-ID: <b09d6e54-66e9-482f-8f45-38381fa6b62e@sirena.org.uk>
References: <20240108204114.1041390-1-ninad@linux.ibm.com>
 <20240108204114.1041390-4-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rIaTAIoZgSKW9gCu"
Content-Disposition: inline
In-Reply-To: <20240108204114.1041390-4-ninad@linux.ibm.com>
X-Cookie: Best if used before date on carton.


--rIaTAIoZgSKW9gCu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 08, 2024 at 02:41:14PM -0600, Ninad Palsule wrote:

> +	regulator@60 {
> +		compatible = "maxim,max8952";
> +		reg = <0x60>;
> +
> +		max8952,default-mode = <0>;
> +		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
> +						<1050000>, <950000>;
> +		max8952,sync-freq = <0>;
> +		max8952,ramp-speed = <0>;
> +
> +		regulator-name = "VR_1.0V";
> +		regulator-min-microvolt = <770000>;
> +		regulator-max-microvolt = <1400000>;

A regulator labelled VR_1.0V can vary between 0.77V and 1.4V and has
exactly the same configuration as another regulator labelled VR_1.2V?
That seems...  odd?

--rIaTAIoZgSKW9gCu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWcanYACgkQJNaLcl1U
h9AQvAf/bBzl7TOXhykZugaGhrwTqbgUhCIJlcRYOC0WPtwpbxLratLbeJHqcSUj
29OZ0OuopB/FwVtUC2KBORlRBMEQRb/GUCZwNxjtqhrC3Bp9CYOTqJs/0jUD9ZCZ
IuvRBEKet3+4RpOyOgwplSHhCwwH1XmWfBb9xWNbCKd7r6NxrZ5z4+LiIrJT8Y/s
fopj53Dmk7MqpK1xl9yBW2CaHAPI2QiA3/Zbh5CJUNJu0zAfw7bASSjseh2pfre9
50Xg+lhn1TDW2Azid2S9Uzcmefsz1dScLfC4fCsblsSLomp1VJ6VNSJUDApod54N
xWK8ruqdyGOmlTQ5yd18SEwzEkM3WA==
=j/GH
-----END PGP SIGNATURE-----

--rIaTAIoZgSKW9gCu--

