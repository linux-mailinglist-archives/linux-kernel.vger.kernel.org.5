Return-Path: <linux-kernel+bounces-123368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84277890737
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8B91F25D65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BD280C13;
	Thu, 28 Mar 2024 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7CKwW0i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19A210EC;
	Thu, 28 Mar 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647088; cv=none; b=aM3wSwo3/DsUjVcvHiwLgN8d9S+O3ABIKSY9ObTnMiuVUGEUNkCDdf/AygEhlr0Zm5zo58kQevLnJQ5+mQET9mEHx3N9P/lJCTpweW9b8tMMNmksB/ys+QHoBqrNkpqQxN7JF3hAJ6EgiLkJRv2zD7/UAv/vn5AZcqh9UQ89g44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647088; c=relaxed/simple;
	bh=CflzFWQh3G9/XCdPqBoPfmOZwAkygYyYMrqOyjig4YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHZ0hrwSLroxTGHzU0xQLqmYABgZExnHOnVef17katyjF70qxgB9lybc7jw0VwWHABOcoyjx4YDpSg79WlWkiHpL36Y5vNylsAIATLyA1DKaUdACLDY8PLtag37umQtBLosdNAnsQoezO0htLRaqxglMkgfWGoRXIl6q7sT5YEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7CKwW0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427E3C433F1;
	Thu, 28 Mar 2024 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711647088;
	bh=CflzFWQh3G9/XCdPqBoPfmOZwAkygYyYMrqOyjig4YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7CKwW0igy/TGcZ71MLSuOwuJ3fS5eykSGJpBXKVXlSUtWOMtmLs+e0+wxtCp2imW
	 1eR75PLHDUSZ0e/yoOoJnicoQ9SYbGPGEkoX1b3k0pyknZA/W+kFUFaBf9UVhYL7N/
	 7lU91ZjkJe9EsNDguSswstsgC313gQMqBbvi/cCaV7eQGbIhQV0rsZKmfVRrK+Aufz
	 ylQcXRHmxw8a/CH2CHUkDZ+YMZ8v71ITaABVZBPMjxe624wj2kg+TcRaDyDeblMxs6
	 duCn3IVCK7YErOXT9y5XwRpbKG3uY1tdOAnKCFtqWYC52APUy5BF1+xsL3jbz+MYN3
	 oazqvDpxaKZXA==
Date: Thu, 28 Mar 2024 17:31:23 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] riscv: Kconfig.socs: Deprecate SOC_CANAAN and use
 SOC_CANAAN_K210 for K210
Message-ID: <20240328-persuaded-arbitrary-805f12ecfe18@spud>
References: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com>
 <20240328-daytime-hankie-41a57ad9fbce@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UcrsAOfCVzAaCjLs"
Content-Disposition: inline
In-Reply-To: <20240328-daytime-hankie-41a57ad9fbce@spud>


--UcrsAOfCVzAaCjLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2024 at 05:29:47PM +0000, Conor Dooley wrote:

> Please, if you don't completely understand what I tell you to do, ask me
> to clarify. Asking for more information on what to do is not a problem,
> it saves effort for everyone if you ask rather than submit another
> version.

I'm always on IRC, so you can always ping me or DM me there, I don't
mind. I'm conchuod in #riscv.


--UcrsAOfCVzAaCjLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgWpawAKCRB4tDGHoIJi
0u+wAP98BVScCz300OtHsu6ac1F9Gb4jC1iDLDZ7+TYfuDcO8gD9HiyZqmhfGKd0
jeCBdh9KSJWrMxr5ra61LsdIg7xSMgk=
=3yJ9
-----END PGP SIGNATURE-----

--UcrsAOfCVzAaCjLs--

