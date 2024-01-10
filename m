Return-Path: <linux-kernel+bounces-22328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6AD829C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D90C1F2572A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA04B5B6;
	Wed, 10 Jan 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8rvpcHO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7DC4CDE1;
	Wed, 10 Jan 2024 14:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CA2C433F1;
	Wed, 10 Jan 2024 14:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704896000;
	bh=ubT3JpCdUdX478eUAkGKG4N/VQnjYxl/ajam8KuCzW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8rvpcHO+s4fz4TNsN/HyfY+EIuzENurVJp3ihv32jRMWh3bE5uRVQ6yn6TDagupv
	 AK+L8u0WZmOWZeJKFpLzri36x03PmKAbtEsHTGABMWcA5CnL1Yao6Kh6m/kS/F5UFP
	 IJ5LBTyhV023i+Ds4OxmscnIxA0mja58bmWf7sszIrKcEjtp9A+oki/mICAftF25o0
	 vc+dOdx+Tk/A7zsoH9ASJXqLKcottwvx0Paqx/QHCtG8hweuQC/p9/0Dh8g2M94KOP
	 wxOAjGIw5oq+T5OGqRrrs5PeEkdml7/gM4bdYpuQL7KWSZaV4qLlw0tgu/8Z9w4WDG
	 osLhuF9hoT/0w==
Date: Wed, 10 Jan 2024 14:13:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: aou@eecs.berkeley.edu, chao.wei@sophgo.com,
	krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
	palmer@dabbelt.com, paul.walmsley@sifive.com,
	richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
	guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
	samuel.holland@sifive.com, Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v7 4/4] riscv: dts: add clock generator for Sophgo SG2042
 SoC
Message-ID: <20240110-sedative-reggae-389839cef8c4@spud>
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <25650372c373b15309cd9f3822306838e556d3c7.1704694903.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nm/CphfyKzDGNTF4"
Content-Disposition: inline
In-Reply-To: <25650372c373b15309cd9f3822306838e556d3c7.1704694903.git.unicorn_wang@outlook.com>


--nm/CphfyKzDGNTF4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 08, 2024 at 02:49:53PM +0800, Chen Wang wrote:

> +	cgi: oscillator {
> +		compatible = "fixed-clock";
> +		clock-output-names = "cgi";
> +		#clock-cells = <0>;
> +	};

Where does the name "cgi" come from and what does it mean?
Clock Generator Input? Does the sg2042 documentation call it that?

Cheers,
Conor.

--nm/CphfyKzDGNTF4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ6l+QAKCRB4tDGHoIJi
0qa+AQCAkXm3hnS/5roeUv9wiqA5TkGqnJfy0iNrxNKOnLioewEA+fTdCxQZM2mJ
WwMBMSTwB4ADTuG2ZWVcgoFa66ptYw4=
=MhZh
-----END PGP SIGNATURE-----

--nm/CphfyKzDGNTF4--

