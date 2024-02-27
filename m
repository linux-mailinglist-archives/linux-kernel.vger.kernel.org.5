Return-Path: <linux-kernel+bounces-83534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD0869AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E61C2849DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8CE1468FE;
	Tue, 27 Feb 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PPF3ki2s"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CA136659;
	Tue, 27 Feb 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048854; cv=none; b=Hsmwj2jMicm/TWCkjtGBiQcCnHwAA1cH+ZYzmyRB9MPCvmMKrjmlGPB7otKcvaDSwMrFtGATuAYkQ4ICaR1MFe1aMXN7JyVFAxtwGgQtRi4Om3lpo/QPDKEwbjpjFWcE7Dh/H1vFHlxMKtHRMTkaIGtfWGuTZtOaKNO1vHxTuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048854; c=relaxed/simple;
	bh=lXN46NGEbcCKn59kMAI0z9YkfJDVvy7ws4geEpz6PAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anFf+cgU4xEnjV7bG6s1s5ClZ7DTOed//VEDxOSS7e5MWl3dkWLOTCB9W0DOLHQEOb6vbdVw/2Or1MhdwGUJ5UkYKZLwqF/6K1++BtCg3P6kr3MfU6OGTsrpY+j/rWAEmEc/TK4xm+UgriRq21DalhnjVv8OZeFkEhCKMWcwKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PPF3ki2s; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lYddulhFN2kURdMxmy99JL6R5hRdVQ8by9hqaRfgvDw=; b=PPF3ki2sVwmyZVlyhpUdeYC1yF
	/fwRvSyPvATDPdvnUi1pGregQLbQ8kBxSoavgM6/TKznbfdB/ANgi3o3+FOUSOoIkw9ilB0gxRtti
	FbHAkAEPSKDbxmc/dOFSwyem2QXVwOuXicZZ9fFZP8FTMKk7CEmEbErZwDS3fdFG0C5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rezgI-008rkl-5D; Tue, 27 Feb 2024 16:47:46 +0100
Date: Tue, 27 Feb 2024 16:47:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com
Subject: Re: [net-next PatchV3] octeontx2-pf: Add support to read eeprom
 information
Message-ID: <28d5c5b8-bd8f-458a-a62e-bb233add4a2b@lunn.ch>
References: <20240227084722.27110-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227084722.27110-1-hkelam@marvell.com>

On Tue, Feb 27, 2024 at 02:17:22PM +0530, Hariprasad Kelam wrote:
> Add support to read/decode EEPROM module information using ethtool.
> Usage: ethtool -m <interface>
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
> V3 * remove redundant checks as stack is already doing it.

So still only access to the first 256 bytes, using the old internal
API.

Disappointing.

And the Signed-of-by: appear to be in the wrong order.

    Andrew

