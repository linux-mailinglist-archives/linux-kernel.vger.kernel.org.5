Return-Path: <linux-kernel+bounces-84750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BB086AB07
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FF81C216DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664D52E832;
	Wed, 28 Feb 2024 09:16:48 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B85B2C842;
	Wed, 28 Feb 2024 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111808; cv=none; b=LK327NT5d+qVP451aX4y9ESPaWyvkfMAj77FXRLqzysK+2xwvHGigso8ZtQ9MhY0gk+5ckTyvcDw9VLxnuudSzTE3HGELntp0dVL/b5BX3YaTYz2m+SHTexBdYHQ+aSu3aeYnRbc+M54qx/XzM6TFoJnEITzy2aR5kRxaWYeKAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111808; c=relaxed/simple;
	bh=lB9K5uApJy+tn2hGHqPrpGhuY93fnVhl1OJxa0CesEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT0WRN5sgYxD+jyuRE2Z5yVpHgVmu4/3IBnFK0rqpgud4NPKNLuYj7NtA0EBgRFKJNI0fmTe0/mvzi4NKDWJj80lEa3IJKtSFFq++hyqvq0u1D/zu1Mc5x4vU1pRjZF1bb65DaISEbpaApWQKQMcjnsCwuSZgJWbj3TWlLdQXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rfG3K-001CNA-8L; Wed, 28 Feb 2024 17:16:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 28 Feb 2024 17:16:53 +0800
Date: Wed, 28 Feb 2024 17:16:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: syzbot <syzbot+b6ce97de27db385d5cd7@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in aes_decrypt
Message-ID: <Zd76BRRjiokokLLg@gondor.apana.org.au>
References: <000000000000e0c9f206126d869f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e0c9f206126d869f@google.com>

On Wed, Feb 28, 2024 at 01:11:23AM -0800, syzbot wrote:
> 
> syzbot found the following issue on:
> 
> HEAD commit:    603c04e27c3e Merge tag 'parisc-for-6.8-rc6' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12bc1372180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b015d567058472
> dashboard link: https://syzkaller.appspot.com/bug?extid=b6ce97de27db385d5cd7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386

#syz dup: KMSAN: uninit-value in des3_ede_decrypt
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

