Return-Path: <linux-kernel+bounces-47673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BA084510D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024C21C26882
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213A80BE0;
	Thu,  1 Feb 2024 05:53:29 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2B7993F;
	Thu,  1 Feb 2024 05:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766808; cv=none; b=dU5r5jZSeWbMPW9fyBRkp25DpVUbGEtrsvrBW/kg2+jiQhztWmpo8Bx11qZvG7wMywg+oTDw0bdjM/dupPM9Pbl3pVgI+YAkz4fWL96ZhTFzDebttW/K10H522zagdpVFb3V2aoZLrAMoYqNL1kj0md0LfB2ke6oN753QaegF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766808; c=relaxed/simple;
	bh=8rs4SXT1RdMY2hz4SmXAvCeqlemYJ0BFWViUiuTs/jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLzgOclUUux34po3GuViLtbrBMIyiKXCHbKf6b4ipBD5BRlRlQJzjjTmIClBYMC532+nstL0sxYvGyY7ge6kTkSWqeCVRqz+meC8zQR4JrFLKd3DTT89DLYPTZHUH9xv2ksAzY40GQd2BTvdysX14k7tn8dED7u9p9/mOY0u4j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rVQ0k-008Uff-Kx; Thu, 01 Feb 2024 13:53:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 01 Feb 2024 13:53:31 +0800
Date: Thu, 1 Feb 2024 13:53:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: xingwei lee <xrivendell7@gmail.com>
Cc: syzbot+3266db0c26d1fbbe3abb@syzkaller.appspotmail.com,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] crypto: algif_hash - Remove bogus SGL free on
 zero-length error path
Message-ID: <Zbsx24dTqjQaUvKs@gondor.apana.org.au>
References: <CABOYnLx_8_TpFHS-nkrvF5dG_Ev6tgMi1dj_+4sSydM1wmD1XA@mail.gmail.com>
 <Zbsw1WDUg8mJ5s9e@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbsw1WDUg8mJ5s9e@gondor.apana.org.au>

Looks like this was picked up by syzbot too:

Reported-by: syzbot+3266db0c26d1fbbe3abb@syzkaller.appspotmail.com

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

