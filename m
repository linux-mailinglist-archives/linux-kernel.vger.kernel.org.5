Return-Path: <linux-kernel+bounces-53904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68E384A7DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799681F2B640
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251D413174F;
	Mon,  5 Feb 2024 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2jTGySi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83C45C1C;
	Mon,  5 Feb 2024 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164363; cv=none; b=pdNU5VXDhjOS9kdVQrIagg0QAgBptnS8BPQyebGkMWd453pAUhoMskC42MVyMLFHOyhDx5wPDuN81RgyJ/QSW3AdDRGfDHqqjZ92OW3lFAk92wuVtm127+IQgT8xP5DRLnY2xf4NdNkk8yz9CdfZwlrM1tU/gpJVXMCtYcbkSnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164363; c=relaxed/simple;
	bh=liupdPp9PpabKJrwTtmOwXRlraS5xdM8nIKa3B+TSt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdWpgGkjmCWKH3cMSKQD13VUUkwjtsfCtirBbgJpfoZvsUVIGoDf/sm63nQmKdsMEBUT6lwlg9QbJPe84VsXYhcD1psqNDqOoDDOtDnaYHj7n/BdtRRj5idnfp4OoVbOVPiZwZ+y4CCgCL1bag771OoGcA6FZfTEfrSVi4yHSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2jTGySi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62284C433C7;
	Mon,  5 Feb 2024 20:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707164362;
	bh=liupdPp9PpabKJrwTtmOwXRlraS5xdM8nIKa3B+TSt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2jTGySiO+5tIbSGAGnj+X1dKVpqXJNRIGBy8IhCrKXvRj/51qGS1fEjrdUDRJHgP
	 wlFuaLb7MAONOYgH8pidL8Sh6FCt+Bw0W5EIfa5RGq8RI5iLl+zQV9DHk0dYIHbH7n
	 pR2UUwJGbmtAOcBd2IrhnA8jb8OQF1sjVu2pw7nxOK0Lau2h0bPRwXZPjhOyb01irH
	 8xnbO0g3tonhFSyWySir8p6Z+lbqJsRb+soSn+TeUOqQNN6cBG/a/9KmnLaLbdEkQD
	 XXgrDSJfw4IudhIdwiXRE6YzXQHQpDD6fjm+sDe6LUya6OT9WjwERHppLkzi3Y5LGx
	 AhaXjZDXJvsYw==
Date: Mon, 5 Feb 2024 12:19:20 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Kshitiz Varshney <kshitiz.varshney@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Varun Sethi <V.Sethi@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>,
	Vabhav Sharma <vabhav.sharma@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Rahul Kumar Yadav <rahulkumar.yadav@nxp.com>,
	Nikhil Singla <nikhil.singla@nxp.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Enable config for sm3, sm4, polyval, xctr cipher test
 as built in module.
Message-ID: <20240205201920.GA2220@sol.localdomain>
References: <20240205112933.3084766-1-kshitiz.varshney@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205112933.3084766-1-kshitiz.varshney@nxp.com>

On Mon, Feb 05, 2024 at 12:29:33PM +0100, Kshitiz Varshney wrote:
> Issue:-
> Multiple crypto tests like sm3, sm4 xctr and polyval failing.
> 
> skcipher: failed to allocate transform for xctr(aes): -2
> alg: self-tests for xctr(aes) using xctr(aes) failed (rc=-2)
> alg: self-tests for sm3 using sm3 failed (rc=-2)
> tcrypt: failed to load transform for sm3: -2
> alg: hash: failed to allocate transform for polyval: -2
> alg: self-tests for polyval using polyval failed (rc=-2)
> 
> Resolution:-
> Enabling CONFIG_CRYPTO_SM3_GENERIC, CONFIG_CRYPTO_SM4_GENERIC,
> CONFIG_CRYPTO_HCTR2, CONFIG_CRYPTO_ARIA as module enables support of
> sm3, sm4, aria, polyval & xctr.
> 
> Signed-off-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>

This looks like an issue in tcrypt.  When algorithms are unavailable it should
consider the corresponding test cases to be skipped, not failed.

>  arch/arm/configs/imx_v6_v7_defconfig | 4 ++++

There should be no need to enable every crypto algorithm in every defconfig
file.  Can you consider fixing the underlying issue instead of doing that?

- Eric

