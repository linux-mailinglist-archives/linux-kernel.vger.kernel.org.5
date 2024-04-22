Return-Path: <linux-kernel+bounces-154032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCA8AD663
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CFB2830E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CB31CAB7;
	Mon, 22 Apr 2024 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUP6Eqqa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84D1B800;
	Mon, 22 Apr 2024 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820443; cv=none; b=pW9FtSJE1aL/jBqA2bicl21gf5fSDfX59t4JKtQQVAlFH8eMFIBr13Nq1OdVSWXZqwZ7ixXiit7SOxzHpc+HkqoiIKKTytbqTJOe/b+pZVxBBS3ll1RndgCKW/LM5Hr47xw52DPrRBKrkkxNPOTZjZpIBw9UxnjfwHDN1IQ6Hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820443; c=relaxed/simple;
	bh=M1HU3NcHR+V7z527ipTqnEPQCknH+g/9xmWyg2Vvoxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuUNnGjOQe34b9D3iJNDchazh32QRNWa6oXvJyQHNQVsj43+jI3It/zFiGYrOt/BSZWpIf/3aDhWIoE1Iz1Kt4QK6SOhL8UDQaNWqpBTPLsaA/20uwIIIJsYDgOL198aEZRJqWAJdeqeHsM/AS23dUQTbrQKc06tIHth9PI1e+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUP6Eqqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D63C113CC;
	Mon, 22 Apr 2024 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713820442;
	bh=M1HU3NcHR+V7z527ipTqnEPQCknH+g/9xmWyg2Vvoxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUP6EqqaK1g2VTRsK1T8+wMXObCOL4qcohgRtT7xfdxg0ZPQ3okLvY6aQjG+Axx2a
	 sdu/Nb/rmKjnWlgxiWPeIV/Aex9j/epkHpWHiZ0xkOFL29ALKQBtupIJEXHcKjPMhW
	 6Vd93m50jJ4TsCcdPwCjvzb7KVXQko3lVw5R6LwIOONumz66JgMTrzxkOrKzBLs4tJ
	 23GczIIrRxxrQdH9+iuEosODnmKoGlr5OY1+JByV0EP7axXc3TKO1+cu7xu4jb+vyS
	 YoUEmvZ+YsclHJzNbaafbuS3yst20O12uhbSzwgLHa9+4kzyDMDKFUxE6TDZzv2CgF
	 GXir3b+q1eiPQ==
Date: Mon, 22 Apr 2024 14:14:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Karel Balej <balejk@matfyz.cz>,
	Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [linus:master] [crypto]  203a6763ab:
 Kernel_panic-not_syncing:Certs_selftest#:pkcs7_verify()=
Message-ID: <20240422211401.GA164618@sol.localdomain>
References: <202404221528.51d75177-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404221528.51d75177-lkp@intel.com>

On Mon, Apr 22, 2024 at 04:05:34PM +0800, kernel test robot wrote:
> [  235.998172][    T1] Kernel panic - not syncing: Certs selftest 0: pkcs7_verify() = -65

Thanks!  The problem is that CONFIG_FIPS_SIGNATURE_SELFTEST is missing
dependencies on the algorithms it uses.
https://lore.kernel.org/r/20240422211041.322370-1-ebiggers@kernel.org fixes
this.

- Eric

