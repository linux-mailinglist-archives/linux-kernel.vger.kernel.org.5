Return-Path: <linux-kernel+bounces-104587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D3C87D07E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38011C21C62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9E3F8E4;
	Fri, 15 Mar 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="TIws9gig"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD81D696;
	Fri, 15 Mar 2024 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517349; cv=none; b=OPkqEvoqd6aW/MuypVwHenjf5IiWB7xDlECehKYT08bdGRb3b4XtxpQkZ1YW83luFxh+iLn/ojjjQlmo+u2YCeM2Hv5W5ajju4Q2KtyDqK7pkJc2fqSLd5pVDzLGeGnfHtjoKcTTcvTZTM0k86yj0+Lby/lZ6dRq7kN0OsNbrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517349; c=relaxed/simple;
	bh=CjdJ+WEj2MA9v8r39+9eL+OCmudeA3ueuiM1DmhBbcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WduD1aC4GEGO+XGjSuhTooU50/bQp9pMGSMuaE6ZoIAbWUxx8efhySoblMH6iyhZtIwL1cCn7VsBr3nuhlBl0e5innSIl1g1eUK1MPdLpc/ESMMXjS69cfkBctb+OBqnpk4K7g6Mx2kVLffV2w+SVniz4o7VzfkRi/8J98jKEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=TIws9gig; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id A54981F9B2;
	Fri, 15 Mar 2024 16:42:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710517345;
	bh=tm4Qq5fRzvyQBmSwMUfO8tQG+syh+D1XaWyh1aCWsHo=;
	h=Received:From:To:Subject;
	b=TIws9gigbdbsJn7i8R67oxBiHZUcvageRWbfYWk6G4+X/XrbwHmScbAJsdhBCaxDp
	 bDTtKNFEELcRPgjvtaophXAqJAPT4WQtrx4SzPHxa/hcN0PGRBuFeX8aFMbV6y7+wW
	 IO+ov3ldPGJc92q/JdkkN4BW8oWXGDm9p3ijkIgivHRv1VzumAYUleVNeHduAOgUs3
	 406lLLf/4m2wUABYgfoKNte82Lv8QJtm6DxAV0Ljmj1HWwUovLlRpwEOFJr6Ag2BV7
	 wBFK3IJSxpeCiCMYKQwEhRJgOpxWNW5a8uzxCcEUe0fe/oy9wOP0bJPhUHSR1atH+d
	 OaeZBUhJ4GL2A==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 5C4617F820; Fri, 15 Mar 2024 16:42:25 +0100 (CET)
Date: Fri, 15 Mar 2024 16:42:25 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Rohit Fule <rohit.fule@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Geetu Naagar <geetu.kumari@nxp.com>
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on
 startup
Message-ID: <ZfRsYf8qhqmrGbkK@gaggiata.pivistrello.it>
References: <20240304170753.500074-1-neeraj.sanjaykale@nxp.com>
 <20240304192952.GA17410@francesco-nb>
 <PA4PR04MB96874E4B23D6C225AE1367F4E7282@PA4PR04MB9687.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96874E4B23D6C225AE1367F4E7282@PA4PR04MB9687.eurprd04.prod.outlook.com>

Hello,

On Fri, Mar 15, 2024 at 01:13:36PM +0000, Neeraj Sanjay Kale wrote:
> > On Mon, Mar 04, 2024 at 10:37:53PM +0530, Neeraj Sanjay Kale wrote:
> > > This sets the default power save mode setting to enabled.
> > >
> > > The power save feature is now stable and stress test issues, such as
> > > the TX timeout error, have been resolved.
> > 
> > I assume that the stability issue has been fixed in firmware, correct?
> > What's going to happen if running the updated driver with old firmware?
> > What about combo Wi-Fi/BT firmware files, were those updated? I'm
> > currently using this driver with this firmware [1]
> 
> There were some stability issues in the driver, that are fixed in previous patches.
> 
> As for FW, I have checked internally and there were no power save related
> issues reported for any combo FWs.

Thanks for the information,

Francesco


