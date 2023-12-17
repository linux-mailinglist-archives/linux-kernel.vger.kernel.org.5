Return-Path: <linux-kernel+bounces-2575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DDC815EFE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9A7282E94
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1031332C86;
	Sun, 17 Dec 2023 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0nYcEbQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023B32C6C;
	Sun, 17 Dec 2023 12:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63F1C433C7;
	Sun, 17 Dec 2023 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702815992;
	bh=bMMSBOiuMZ0m56U4tRIOcLqQcXOJl6kzjOXKm4Kj58Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0nYcEbQtOtl3KPfOvTcx+B7FhNLdPnpwJtkOB2OJbZCpRWi8OAhy5a89Z+ruKM5h
	 QdupHmKWrGqWUQ3i4BBoKDvplk9ds0Sin3QX1De4naYFuPZTXSV2vGODK1jwKJLebI
	 0gL7ae/7fq0lMJBcRuCxlqq0qnT9+rMTsBSd2vZG7PgERWbNPCcKbgjBeFwij4/I52
	 Iuw7C5jXOb+zQbsjBEr0C4HOjEyrvwvIXl+XFtdXCfNoR2zHH7T5cbNv96ZJBovouS
	 juS+y/fg81cWV/RRrQXecm9PTMrxSnp+2uvQoK4ETo2epZLXM1lhmSxSa+z3VYuoju
	 U/oFlCOb4TzLg==
Date: Sun, 17 Dec 2023 12:26:27 +0000
From: Conor Dooley <conor@kernel.org>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
Message-ID: <20231217-wrist-flakily-db9974d8b515@spud>
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
 <20231217110952.78784-2-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OdLsfqhVywJgxuvx"
Content-Disposition: inline
In-Reply-To: <20231217110952.78784-2-qiujingbao.dlmu@gmail.com>


--OdLsfqhVywJgxuvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 17, 2023 at 07:09:50PM +0800, Jingbao Qiu wrote:

> +  reg:
> +    items:
> +      - description: data register
> +      - description: control register

> +    rtc@5025000{
> +      compatible = "sophgo,cv1800-rtc";
> +      reg = <0x5025000 0x1000>, <0x5026000 0x1000>;

Why are these two regions rather than just one, given they are located
next to one another?
Are they separate on one of the other devices in this family?

Thanks,
Conor.

> +      clocks = <&osc>;
> +      interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
> +    };


--OdLsfqhVywJgxuvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX7o8wAKCRB4tDGHoIJi
0haNAPsFYNZmM6Mo/NYopCKYD2j3+5K3GyDMMa1C3a6jTdlnKgEA6U5Z2UkuWvx0
JngeX5rzO1tn3afS6vFy8kGdWM55vAg=
=YuR3
-----END PGP SIGNATURE-----

--OdLsfqhVywJgxuvx--

