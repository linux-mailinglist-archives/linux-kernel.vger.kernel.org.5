Return-Path: <linux-kernel+bounces-69637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199CA858CA6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE86A1F222C5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB601773D;
	Sat, 17 Feb 2024 01:14:22 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3E14F70;
	Sat, 17 Feb 2024 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708132462; cv=none; b=POCvPMrliWvyc9ev33xNxBR5HfAueyqlKmqDbAoPZ6BQM+p3RxFv0LGtiAy3XC5CIHo0gTLw+jngc4fMrUSF7NHQN7wPGHAf2yWQYXlAG5AT928YvYOaN1DOUaCjufcxWSjNPTGebJdW0syKEWnjzwDF9Ke6iITPg9fQWAxgALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708132462; c=relaxed/simple;
	bh=eLT+arJ+8yFumTvJh48qRxmwSTAY308IM4WrOYdkfK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2rnLR2mmnQ5raXXhWnjTawdCPDInvos8RLAOIDp4msq3F5xJ/c6euXQ9r7tUT9+QdN8rAwr3ejVyNidaHkXlc/En3b1KFD+U448tgZjYRq7KmrdByh0w30o4L8N8G3y3oOAdPuEjZc20gpyqFVe1xEzp5c34zanMP2MMz7i7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rb9HN-00EePX-0C; Sat, 17 Feb 2024 09:14:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 17 Feb 2024 09:14:23 +0800
Date: Sat, 17 Feb 2024 09:14:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: adjust file entries after crypto vmx
 file movement
Message-ID: <ZdAIb0RFdY8KUp8z@gondor.apana.org.au>
References: <20240208093327.23926-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208093327.23926-1-lukas.bulwahn@gmail.com>

On Thu, Feb 08, 2024 at 10:33:27AM +0100, Lukas Bulwahn wrote:
> Commit 109303336a0c ("crypto: vmx - Move to arch/powerpc/crypto") moves the
> crypto vmx files to arch/powerpc, but misses to adjust the file entries for
> IBM Power VMX Cryptographic instructions and LINUX FOR POWERPC.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> broken references.
> 
> Adjust these file entries accordingly. To keep the matched files exact
> after the movement, spell out each file name in the new directory.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> v1: https://lore.kernel.org/lkml/20240129131729.4311-1-lukas.bulwahn@gmail.com/
> 
> v1 -> v2:
>   - address Herbert Xu's feedback:
>   keep the matched files exactly those which were in the vmx directory
> 
> Danny, please ack.
> Herbert, please pick this minor clean-up patch on your -next tree.
> 
>  MAINTAINERS | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

