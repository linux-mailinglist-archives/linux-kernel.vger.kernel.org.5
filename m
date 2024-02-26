Return-Path: <linux-kernel+bounces-81057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55346866F97
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49C61F27E4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B786C58217;
	Mon, 26 Feb 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gA80zArq"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5058210;
	Mon, 26 Feb 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939928; cv=none; b=uN20hVap2Wed8BKU6Ii/DhrnMqesKTrBvidyRs5cDP8wVB9poapPy97HZHkt3uHh6oqvQHaH48UxgvDX/Cn6J4/JSknq6vPSmw7ivZsbc6o/JZ40V+2+t30yzAnYjXjHKfDAB62juDPnedEGQN1oxnvcd74I0RWVO4w5NsYRBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939928; c=relaxed/simple;
	bh=Po8+iwR8b2R3RnTXoNqpB7PrLacZ0N1cHivXMdzH5sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9rujUSyO9WbgBN8nD5zDhNwW/weGXdhXeQ+/qTyPeGp86RWNRi1tQBag+moNVTfXgPbvqsLHv9RKBxgBNIyyuzoKhsZNQCMRj7X9NAPyaB9kPxGAiR6UCvUzxzFBKVpDO2YQsq9ntkCdCxcI2z0aHY7yU1tNgXMvPsH7wdVEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gA80zArq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yYySHCkB1fVu3TPhXHHVfFL4AcaC9fq3QRqpB04qwVw=; b=gA80zArq7rFCVuIfQpJX1WAPAV
	IKwfv/r/3V3paXcNj9IKgY7QWmZkXMQpSlf5ykbchsm+QCh4SzXiTPUJg/A+52pw7NFWHQ5vrxY9i
	884kKpvYHGyvungyo532wuwHlaMxnWxLjsAZFFO/TMwSzZH7xuMWO3W5lvdmnRDmNzcgt6+gQ6vd8
	7pLsKYpP+GdpdivRSZnijzpCmNCBi8WBKtUCHi1cbPJDX7xaXiYjME5vVuNASV3If6bl2xTUcVzpV
	fnWdeWAeW2lr47gWWbN2V+0BHiXLLjfQt4aJAWjAoc0wILIkiEueuAbMEFmuehjIRjnE5tIvixPdc
	fli9P6uQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39856)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1reXL0-0002fj-21;
	Mon, 26 Feb 2024 09:31:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1reXKx-0006Ju-TN; Mon, 26 Feb 2024 09:31:51 +0000
Date: Mon, 26 Feb 2024 09:31:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Steffen =?iso-8859-1?Q?B=E4tz?= <steffen@innosonix.de>
Cc: Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: mv88e6xxx: fix marvell 6320/21 switch
 probing
Message-ID: <Zdxah+wBafeTHzQ0@shell.armlinux.org.uk>
References: <20240226091325.53986-1-steffen@innosonix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226091325.53986-1-steffen@innosonix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 26, 2024 at 10:13:23AM +0100, Steffen Bätz wrote:
> @@ -649,6 +649,19 @@ static void mv88e6352_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
>  	}
>  }
>  
> +static void mv88e632x_phylink_get_caps(struct mv88e6xxx_chip *chip, int port,
> +				       struct phylink_config *config)
> +{
> +	unsigned long *supported = config->supported_interfaces;
> +	int err, cmode;
> +
> +	/* Translate the default cmode */
> +	mv88e6xxx_translate_cmode(chip->ports[port].cmode, supported);
> +
> +	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 |
> +				   MAC_1000FD;
> +}
> +

This looks identical to mv88e6351_phylink_get_caps(). Would that work
for you instead?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

