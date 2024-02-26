Return-Path: <linux-kernel+bounces-81983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952BB867D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66AD1C2392A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A076212E1FB;
	Mon, 26 Feb 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gcPG/P4e"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5E12E1CB;
	Mon, 26 Feb 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966459; cv=none; b=r+scyJwaPd4Gw3tuxYqQ5//jGfwebmgS7+4jK8Y+NyopwtJuj+QEKlss3FreSypiH0WfuzuFfB4k7Ze9u94vdrJdqyTNVoJYYmYW+QFxHeXBTdlMZgCr7DZliPTsCGVXP1QsQuGeggLnQQaw667wgGbXnY2l/YZ5CTafhXbSbl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966459; c=relaxed/simple;
	bh=3pAkRdGtlYOz7HJDquQcaI1J/3jP0n1iGZ0pfQwYAXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzg7QcaWZ/Ye6wDyHjE2+x64j4WCIVgqzhhrdiujxLcN1vBTz65c/ny3csZTipBQmS3qx9aDY7I0qebocnTJoURdDsfQ6vCSc4hBnWxFM878Xgef+N6MfKyZp3sV/QIMmcw1iGGGS3PkE5dBtbnoMptUZfIXb4RH2pnnL3EIrWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gcPG/P4e; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MG4wbc7DHz6FYCvMV9uzBhi/7U22CVjramwqCyKSZ1E=; b=gcPG/P4eTjrt4/Tz1Urz+nKfng
	RA3QiQKhHHsC3mXPATb6luErmA1/w7BaNB9WCgKGr5XN0SCCdOSmlcEiTuLZtxFJU6ePvB46xgfQV
	mpF/roDpVfjHNh8exCy5XqacRaB5EfBIyWOVknwvB2E7sxHrDwo61PKWc9hsXPVjnHaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1reeFH-008kG6-OU; Mon, 26 Feb 2024 17:54:27 +0100
Date: Mon, 26 Feb 2024 17:54:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robimarko@gmail.com>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: add Amethyst specific SMI
 GPIO function
Message-ID: <64338119-3766-46cb-bd2b-21d2b8e86a0e@lunn.ch>
References: <20240224203349.1358064-1-robimarko@gmail.com>
 <cb5c185f-1946-4548-9918-01548e9dd9cf@lunn.ch>
 <CAOX2RU7xKM6ywGbzfB2ZCmYadJYG1uq=doTBfPGNnaYaocmG4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOX2RU7xKM6ywGbzfB2ZCmYadJYG1uq=doTBfPGNnaYaocmG4Q@mail.gmail.com>

> That sounds like a good idea, want me to send a v2 with the rename as well?

Yes please. 2 patches, and a cover letter.

    Andrew

