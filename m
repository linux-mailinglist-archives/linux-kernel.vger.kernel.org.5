Return-Path: <linux-kernel+bounces-39869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A28183D6DC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5921C2667B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3D54BE3;
	Fri, 26 Jan 2024 09:00:59 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5255793;
	Fri, 26 Jan 2024 09:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259659; cv=none; b=rHWZKnuMZdOW3IBHgKTC0dsY2QVf0Ul5mlH9IEcsWMNoe8jEFgdzLxDBb44ec/R8NJCGMH/aM9UzqX3BdARYDDdwcNFpZTHqF3yIH98PAeHRmj7ubxmbQCRuTRCB9aPKDP1fyiVEMLNFHbrAnTzYOEK2iAlgEbKxjGhxgS3knmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259659; c=relaxed/simple;
	bh=KNc39Sy1zvoDM7Q0A2A6CjK0GfV3vdUIPYp7FnGGmmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moyQ5+qKJxicPDN8kzPyZrs1qrEcrfN632XpVhtqijJhkGS/QreUDJTJFKWyjRa9s3Sk+W9LtQd40tDfCy2a41y5ghiUL1KBD41LhUnd0PAoGVWiNeS+5OMeyQOUC0dLNP8X6/EsfFXczwe3hfn08Lu3VDx3KvQVsoIo9jM0abk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rTI4v-006Eez-2t; Fri, 26 Jan 2024 17:00:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jan 2024 17:01:01 +0800
Date: Fri, 26 Jan 2024 17:01:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Minjie Du <duminjie@vivo.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	"open list:INTEL IAA CRYPTO DRIVER" <linux-crypto@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] crypto: iaa - Remove unnecessary debugfs_create_dir()
 error check in iaa_crypto_debugfs_init()
Message-ID: <ZbN0zQwTzhBmD0W/@gondor.apana.org.au>
References: <20240109021916.20960-1-duminjie@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109021916.20960-1-duminjie@vivo.com>

On Tue, Jan 09, 2024 at 10:19:14AM +0800, Minjie Du wrote:
> This patch removes the debugfs_create_dir() error checking in
> iaa_crypto_debugfs_init(). Because the debugfs_create_dir() is developed
> in a way that the caller can safely handle the errors that
> occur during the creation of DebugFS nodes.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/crypto/intel/iaa/iaa_crypto_stats.c | 2 --
>  1 file changed, 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

