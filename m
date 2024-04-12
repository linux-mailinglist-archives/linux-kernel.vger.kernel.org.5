Return-Path: <linux-kernel+bounces-142141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37E8A2802
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672332850B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055C4CE09;
	Fri, 12 Apr 2024 07:29:38 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2046BA0;
	Fri, 12 Apr 2024 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906978; cv=none; b=N7pDkT2BRIJvSVY3eQAx9VS+s8+MsoeUVXhQ88YNiNyc1Ceh1vJnffEYLiEeBwEyBnL8s0Q25TgJcyF5UxdvsrLZVsh+E5xHDU4gtlZptUzNbmDRq5IZsLJT/4OvfdkvkMQ9uBX4W0i3VeIytCE38C0Pj41INAKNT+VQcrUnRwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906978; c=relaxed/simple;
	bh=7M2kKvQTkEd4Mr3OVlA5FF2+9MMVPozcmy7NxnUF+cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olyE+ymWeVL9j/05JrHrMeWNSwBKfbnanoMtWXB9qE0h+MXX/3gmrw7H1uqmGCfgyD1ULRe0JB+a3xc0hZGkafeLjkS8ifz96iCowSm0vqTkTHp/Tj2L47lriaboqFVHJgxcjl6+5Jq3hIcR3Ba0cuHYCoKoG+tO5wSdmS4S3W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rvBLj-000lcD-F4; Fri, 12 Apr 2024 15:29:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Apr 2024 15:29:44 +0800
Date: Fri, 12 Apr 2024 15:29:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Xin Zeng <xin.zeng@intel.com>, qat-linux@intel.com,
	linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] crypto: qat: Fix spelling mistake "Invalide" ->
 "Invalid"
Message-ID: <Zhji6B90sRGAWKjs@gondor.apana.org.au>
References: <20240402081355.1365780-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402081355.1365780-1-colin.i.king@gmail.com>

On Tue, Apr 02, 2024 at 09:13:55AM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_gen4_vf_mig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

