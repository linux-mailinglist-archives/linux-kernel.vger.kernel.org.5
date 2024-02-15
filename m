Return-Path: <linux-kernel+bounces-67412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6846856B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6348C1F23E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B571369A6;
	Thu, 15 Feb 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RKGW29ii"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5EF136661;
	Thu, 15 Feb 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018327; cv=none; b=iRMYOZ2GhZeWXDt+/6+2BglZ3nUp2sYP76OXvFBnNnITWEfSNV3VZHjRe4tQiqcNi6tCeZYL8sv/fcmuVKhYzNxxN3IHZlsKjPuhdYUz7zPLbsfNU9PcTDIl87tnglbmR69KD8l/RIGkx6q8Vj3ZAkOOj7stHVmOXetVP+d/BJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018327; c=relaxed/simple;
	bh=cLy4STSztjABnB16vjE6zqydydcrS4yhH458HL8fu6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7qmz3cotx+lOuULOKwjFJWNQ7oXEWDNSCwjo3jwmcLhB3b3BOFckpfMsDZqNxT1tEKktS2G0ol9B2cKkcpfooNHs959nfW3u8uE52158q+aG1V/NmPKbbEcZeq2A3EBVROsH6Bu3hdQDbBd0gI3WNHl+K/x+hj7yhV+GKRlQ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RKGW29ii; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AOSVGIvqcWZAqdtnlZXCkV1/mZi5KX8sCLFqpdoJE7A=; b=RKGW29ii+ZavC93ZoHpUKsCWWO
	SXfcyZiomVKfYuNiQZesp/XFTRwGw0ZSqw9HnBNNsmAx2SJr1lnC+g+EcWlAAGh4rJPHzPyY58eIN
	baHbLLm9r16EfqyvAlL9ZvfMs44vJyKrDLhOhCIL95/iwodmJ0/ebXh2X5PgkgrXeduk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rafag-007ueE-UP; Thu, 15 Feb 2024 18:32:06 +0100
Date: Thu, 15 Feb 2024 18:32:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Daniil Dulov <d.dulov@aladdin.ru>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] net: sfp: remove redundant NULL check
Message-ID: <4a7300f3-116a-4824-98c4-209a217a4a11@lunn.ch>
References: <20240211150824.3947-1-d.dulov@aladdin.ru>
 <Zc41kuP2iwK3AlWv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc41kuP2iwK3AlWv@shell.armlinux.org.uk>

> However, I'll go back to my original point: this is *not* something
> that automated tools should be identifying, and it is *not* something
> that should be used to throw patches randomly out, especially where
> the commit message doesn't include human analysis details.

Hi Daniil

Could you work on SVACE and make it dump how it decided it was safe to
remove the NULL check. I assume it found the path via
sfp_register_socket(), and the NULL check in that. So it should be
able to dump that info in some form. sfp_bus_add_upstream() seems more
interesting and it would be interesting to know why it though a NULL
from there was impossible.

It would be great if the tool dumped some text which could be
cut/paste into the commit message as a justification for the change.

	Andrew

