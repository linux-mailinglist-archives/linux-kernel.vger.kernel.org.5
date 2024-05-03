Return-Path: <linux-kernel+bounces-167540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4020F8BAB10
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716F41C225E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D7B1514EF;
	Fri,  3 May 2024 10:54:08 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865B17758;
	Fri,  3 May 2024 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733647; cv=none; b=hQvnw59hM/cti2Ip2aNemB4c+qb2cjGGq/JPz4cj9oeYlQmO0LgV2riYDCv91Qzv4FfBAtHfEUf1Yy6oZIhM5fTyofKPiFL9EMD5qcNUmVa39MgwFOhisCg2zGngbjTjFs6nmx06VkMVyWOWjK/72XI+89JGutUQTvxFcZObHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733647; c=relaxed/simple;
	bh=yk90lNH/yfw7q3++xQCcY4R0xvcacoRkdb/kdHegHGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n08Sqko0dOeX/oNBOJAQVe6y72MwU9b8o/Q0AjXLR+s9lXxdrGKSpTfYCeg6jp4jcIAkJcOrgfqb6BX3fkD/0rCwWp6kSJ1RMRIG2dDFXXwe2dLgY2fT451IPid3h6+IRfJ1Rj/GOFKOp2pxO9FcqtVnKgnWrL5mI2CoWBiE6zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s2qYD-009vWT-2X;
	Fri, 03 May 2024 18:54:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 May 2024 18:54:02 +0800
Date: Fri, 3 May 2024 18:54:02 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chenghai Huang <huangchenghai2@huawei.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, fanghao11@huawei.com,
	liulongfang@huawei.com, shenyang39@huawei.com,
	songzhiqi1@huawei.com, qianweili@huawei.com,
	liushangbin@hisilicon.com, linwenkai6@hisilicon.com,
	taoqi10@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/2] crypto: hisilicon - fix reg offset issue and cleanup
 dump information
Message-ID: <ZjTCSolBz4aNW_VA@gondor.apana.org.au>
References: <20240423011922.770693-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423011922.770693-1-huangchenghai2@huawei.com>

On Tue, Apr 23, 2024 at 09:19:20AM +0800, Chenghai Huang wrote:
> Fix for register offset and cleanup dump information of debugfs.
> 
> Chenghai Huang (1):
>   crypto: hisilicon/debugfs - mask the unnecessary info from the dump
> 
> Wenkai Lin (1):
>   crypto: hisilicon/sec2 - fix for register offset
> 
>  drivers/crypto/hisilicon/debugfs.c        | 29 +++++++++++++++--------
>  drivers/crypto/hisilicon/hpre/hpre_main.c |  2 +-
>  drivers/crypto/hisilicon/sec2/sec_main.c  |  6 ++---
>  3 files changed, 23 insertions(+), 14 deletions(-)
> 
> -- 
> 2.30.0

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

