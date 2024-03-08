Return-Path: <linux-kernel+bounces-96929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C1E876346
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348A6B228EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2957896;
	Fri,  8 Mar 2024 11:25:32 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216A56440;
	Fri,  8 Mar 2024 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709897132; cv=none; b=QjShj2OYJzUo7C8wM1ZZYtsAucHOnGG+5nGsXZOcxiW0P1uyA/31CrZOjHmnpfpSphYPxOpxK+aa6NYvmsejjInBM1yDw+8Kq/CKhDKqaauz+WdUqOVnIZO6aOQEkIfY3kMkjz3c/f3FJlmWJRRlqsb0EB0FZzwX6RaencBFxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709897132; c=relaxed/simple;
	bh=GZDuGnY3q9pjDak6rbG8aFmDtM8JDRnivU53kR2VR6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU2p2dFkdLDU0CCdMVefsj4JzoxiS52c31tcTRmgOwZt2e38koWQoN+IF4i5AliBCFEV79VOWv0Rp51FLng/8YPWULd5pBFM+iE8OO6zFFfk7NrgoyKb44z12k46Z758L9GG7YXsM4oPnYJhR8w0OvW2YEX+LUdL4QhNaOsbqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1riYLq-004tKa-NF; Fri, 08 Mar 2024 19:25:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Mar 2024 19:25:38 +0800
Date: Fri, 8 Mar 2024 19:25:38 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vladis Dronov <vdronov@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.de>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: tcrypt - add ffdhe2048(dh) test
Message-ID: <Zer1snDIGxoVv8KE@gondor.apana.org.au>
References: <20240229173603.10258-1-vdronov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229173603.10258-1-vdronov@redhat.com>

On Thu, Feb 29, 2024 at 06:36:03PM +0100, Vladis Dronov wrote:
> Commit 7dce59819750 ("crypto: dh - implement ffdheXYZ(dh) templates")
> implemented the said templates. Add ffdhe2048(dh) test as it is the
> fastest one. This is a requirement for the FIPS certification.
> 
> Signed-off-by: Vladis Dronov <vdronov@redhat.com>
> ---
>  crypto/tcrypt.c | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

