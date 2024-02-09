Return-Path: <linux-kernel+bounces-59706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B73E84FABB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3914B2709E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191F7BB19;
	Fri,  9 Feb 2024 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqXkuT5d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCCB7BAF4;
	Fri,  9 Feb 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498713; cv=none; b=N4h7oylOfSB01ImkfAJrWeoK4spQm9BdTco6Rz802YtZoEsMwuwyq7esH+qzByKYhNNgG+NMzBUR5tQ1f7ILRhatt2+iIu0hQnV1JzjDq1N5xyu88MDnPVwtjJM9OYmwvsxqeDtp1welQqdTi8dkCq62jOWP0IuwAPhVejQLrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498713; c=relaxed/simple;
	bh=TVN6AoYDGpCY0AXJRKxcSKPo6wonZIAnszqeZBEPtsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzFnf2eiiP1d98ZIIddbtDJwxBoF1fWV3vGRYLh7PPVdlpSpMtd6E29ayPk7tStUGi9+vttVmIggpVN654JXwXak7q7sBNCKvgsa3KXhA5VzaRsbnjywKENYaAomEOcfmfZkUnoBBZxuGyiwNHaBQBNpvzqNChTmGK1M2fyKwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqXkuT5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF6EC433C7;
	Fri,  9 Feb 2024 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707498712;
	bh=TVN6AoYDGpCY0AXJRKxcSKPo6wonZIAnszqeZBEPtsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FqXkuT5dLtmYHu/v3UHeZUzV4WjT53HNAiOawRTeMtzG6azLfeWzEW7XsfymG2JL2
	 aKIyQLmcDtx4Fq8K63tQd/Ja1ZEqeChBOEQbpm+kmz3IROErjVb1LpLaTpQDGKpMhb
	 jVeoj0gJRWhsQRQm59iOPpoYxfCcRDPlW6WgbOBLRJyyDR50pJ2chsii9r/z/ntENO
	 CkrL0CltgfB2pPAh75sWDxdeJgPDyZRFL4JsVaEuy3b0NiXP72SYXsBonXB6qw8Qgx
	 a/kOWeyslVe9CBIB8yYbrQV0c/XJCIZO+5JZZcdfnynfxvhJC1bDRqpyiwC9Wx6+wz
	 CebN7Sc4EXnbQ==
Date: Fri, 9 Feb 2024 17:11:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org
Subject: Re: [RESEND PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI
 TPS65224 PMIC
Message-ID: <20240209-blitz-fidgety-78469aa80d6d@spud>
References: <20240208105343.1212902-1-bhargav.r@ltts.com>
 <20240208105343.1212902-4-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dna+SjxlSwr7Px85"
Content-Disposition: inline
In-Reply-To: <20240208105343.1212902-4-bhargav.r@ltts.com>


--dna+SjxlSwr7Px85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 08, 2024 at 04:23:33PM +0530, Bhargav Raviprakash wrote:
> TPS65224 is a Power Management IC with 4 Buck regulators and 3 LDO
> regulators, it includes additional features like GPIOs, watchdog, ESMs
> (Error Signal Monitor), and PFSM (Pre-configurable Finite State Machine)
> managing the state of the device.

> TPS6594 and TPS65224 have significant functional overlap.

What does "significant functional overlap" mean? Does one implement a
compatible subset of the other? I assume the answer is no, given there
seems to be some core looking registers at different addresses.

Thanks,
Conor.


--dna+SjxlSwr7Px85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcZc0gAKCRB4tDGHoIJi
0lB3AP96KY07xT0eqyhknqStgg/xJs8nbUytoWWoPJdth7LwjgD/UXf7lbRiCCMR
E23eyu80aZqV2GBn/8cTKrtsQEdECQA=
=EYha
-----END PGP SIGNATURE-----

--dna+SjxlSwr7Px85--

