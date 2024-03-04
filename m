Return-Path: <linux-kernel+bounces-91244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD23870BAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23AFB237B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BA8E542;
	Mon,  4 Mar 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NciIjyYJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AFDF6C;
	Mon,  4 Mar 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584509; cv=none; b=eSz7zZ4NC1d0s4Md/FmSFJJJQwj2+cU0FN+BlmDeDiznesVB1HYub5m0Aap45/HZA4vja6wQ+ZhKvGUThz7XVQ60ZfHV5ypYpq41DcveIZgbH+iFmrHeKQUlx9HT98xZku/j1Lj0qUtYQmTovGvpunYDvZYsG0R1++ALnB8VOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584509; c=relaxed/simple;
	bh=NJDANWRGqAfFUEhKbR3uU6wp4qNAJ2qDc7OSyP9otQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3cv0a9mH6QzCIcuOWdIaB+vEJsRuqPKx3cRp8Cmm1x0Tb0VMr28ob+1Hfi0hRQcJQQq1gvYzR5kXTxBzi5k5uIeETDxABplzg0Db8QeSGhaV/2jFz0i5JBk228jPrQWntpdIwalNONGRXq+N7nHOB5rlrGohsYu09XqYH123uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NciIjyYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912F0C433C7;
	Mon,  4 Mar 2024 20:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709584508;
	bh=NJDANWRGqAfFUEhKbR3uU6wp4qNAJ2qDc7OSyP9otQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NciIjyYJlyEGnplFPM3wx9LGv8TOaJiDLLY4GqwleDW2qaZzFcIEcAZNbK2k+SLyF
	 4yLrMPxpNKsqHzyD5iSmsJ8pQGf3vY8QchZWbTkiLmOa3jqP9vCVT/uFnas+H6CSOj
	 Lk5cbL6jtIRy0DNgJyyknD10pTbD0J5mZSms4dr2XDLbOMoawlgwhQ83X579p163M/
	 KBpKTi4a98vy/wD128VqoqIuYGPogM0Pr4e77DIP6smZZ44ASuhXdPgtcODahGou7D
	 qY/5+WdqOrAuG+KWxq2Xu3CR5Ox28B9eQbgB1crEw/hHwm57CLRfnTZuXbX2OFuEt2
	 BxU3o33LZ3Dug==
Date: Mon, 4 Mar 2024 20:35:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] riscv: dts: add initial canmv-k230 and k230-evb
 dts
Message-ID: <20240304-outnumber-tapeless-b916970a3307@spud>
References: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
 <tencent_1352FBDA710F572F663E44B9B19BAF453005@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D394WKXK63iejAQo"
Content-Disposition: inline
In-Reply-To: <tencent_1352FBDA710F572F663E44B9B19BAF453005@qq.com>


--D394WKXK63iejAQo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 04, 2024 at 11:16:25PM +0800, Yangyu Chen wrote:
> Add initial dts for CanMV-K230 and K230-EVB powered by Canaan Kendryte
> K230 SoC [1].

I left some more comments on the v1 before I realised you'd sent another
version. Can you apply the comments from there please?

--D394WKXK63iejAQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYweAAKCRB4tDGHoIJi
0uoBAP9bvUqhubnsIr9kZg3/Ja1q/24TYzVui/yAyehAUYqU7wD/QSpy30wbJOYB
3M1gKYPUDXxSXfFp5qZ7mSSz9WMd5gs=
=x2SJ
-----END PGP SIGNATURE-----

--D394WKXK63iejAQo--

