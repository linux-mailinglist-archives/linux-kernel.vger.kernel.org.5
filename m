Return-Path: <linux-kernel+bounces-49901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78959847132
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33699285B17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4824654F;
	Fri,  2 Feb 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="13CS27RR"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1E4643A;
	Fri,  2 Feb 2024 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880673; cv=none; b=GvhTWdmh1KEDAP+SlNWUgyj8sxZ3BvKMhJmhN4XCVdyMoFwFLG9pRHsRI9J0/KSOcJ3K0Pj0ubY6K1ygGMJLUqIoL1jRjQpceRn4p/DhEXsEr1+aTfChq2RF3V9I4yFbqnic7GnH98DicNjns+gQvqIlQMPqVjHAKBT68iwVTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880673; c=relaxed/simple;
	bh=wjIesRNRmTFPIurZUIwcdu/x+OKKFfccb8BJIDCLZoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM3xsPP0f24FrCwTluoeRu3RR9B2Td2sXIGOd9+wDmPTzPLpSUbWsVwTqcSjt8im0Bd1gxMYjrUFWnac0LdS1xd+uQ3x8UbtDT8RuaKO82C1pW7gWqfesu+OIF3q1G3aGwEc5i8ULhAr16qTzdSJYtLFfViAy5u3WQyFuadPnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=13CS27RR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UJtePW7G3zS/E7YKl1YdieFpwO+voJfGNG2qCQLfOqc=; b=13CS27RReCaCMvL2TvBp5duvQV
	zUaK75JRSZaaYaDQaOfl44auKpA/eceP68ecjbfnIqZkmMBOsLttVXaMHN8d4ZhWwK+Yo9m+GcZUT
	qUvmMJReymInZ03LuC8CWZJ4XwJ/xsTSafWWMq8dVke25ap8ivDunV7lZjoQxZkbyh4k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVtdD-006mqR-Hm; Fri, 02 Feb 2024 14:30:59 +0100
Date: Fri, 2 Feb 2024 14:30:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/8] Improve GbEth performance on Renesas RZ/G2L
 and related SoCs
Message-ID: <d76453e6-6b47-4f40-84dc-36c874e02da0@lunn.ch>
References: <20240131170523.30048-1-paul.barker.ct@bp.renesas.com>
 <953f6b82-c4b1-43f7-af68-e504d663f070@lunn.ch>
 <1daa9e95-df98-4a08-bc55-21838e555519@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1daa9e95-df98-4a08-bc55-21838e555519@bp.renesas.com>

On Fri, Feb 02, 2024 at 09:39:42AM +0000, Paul Barker wrote:
> On 31/01/2024 18:26, Andrew Lunn wrote:
> >> Changes are made specific to the GbEth IP, avoiding potential impact on
> >> the other Renesas R-Car based SoCs which also use the ravb driver. This
> >> follows the principle of only submitting patches that we can fully test.
> >  
> > Are you saying that Renesas does not have access to all Renesas RDKs?
> > 
> > I don't particularly like the way your first patch makes a copy of
> > shared functions. Is it not likely that R-Car would also benefit from
> > this?
> 
> We have the required RDKs. For the R-Car based SoCs, we need to confirm
> that gPTP still works if we change the poll/receive code paths - this
> will require an AVB-capable network switch and additional time to test.
> So our plan was to handle the GbEth code paths first without affecting
> R-Car, then follow up with another patch set for the R-Car code paths
> when we've done the required tests.
> 
> I discussed this with our team, and we're happy to do this in one go for
> both R-Car and GbEth code paths if that's preferred.

Hi Paul

I think it would be simpler, since you would then need to recombine
the code paths you have just split. Its better to not split them in
the first place if possible.

    Andrew



