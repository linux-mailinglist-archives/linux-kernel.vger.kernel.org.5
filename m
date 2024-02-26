Return-Path: <linux-kernel+bounces-81762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB58679D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70181F303F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEC512C7F0;
	Mon, 26 Feb 2024 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j/wyto49"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D272C1BDD8;
	Mon, 26 Feb 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960064; cv=none; b=Z0DXkngAZ3oeiMz5aCnCwV22eYt2GffFY5oT+oHi9dfRbyhGuT+SvrMm9FYGn/fAs+A+iYmomOcVZz79Yjsltp7x9/76A5Rq7aeG+zgxPAud9CXXPoKFrS9VO7P15MD4X29LodcSno+YmQD+LjsF8tkqUMbvSizyAkGSBeXlXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960064; c=relaxed/simple;
	bh=M7isSVoISBnfAYmSdJfpU2svN/fglbkO/NWIZRmoyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/j67CK91kzkg0bNCUWCTJC8ppwWN5SX2MawtodxOKNbxi0QmK2jTlLITFIEH6FSfYXdGEecE6Vmfx+w52nMG9jeaBXOugPBSGSmG+2/AvFkN/HCN5T3ZhSqNNDmvs/FrAscbFwiL+79c0DUDuOAdqqqFcICRCub7IpC3XSszog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j/wyto49; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9097A1BF214;
	Mon, 26 Feb 2024 15:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708960060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KziltWlW/enUkzAKM/Tk7OteTNYodSmSK05UPd9lgds=;
	b=j/wyto49AhT8qkVrQVcz4QBLfaAh7ivuygjixxSQbqcEDQ3/hsBDFvEtfwV14Pkudhpa64
	Lk+yQk0uoIwvMfZ3otZ4Ta0h+eNBicOPlzjRqfQM1dm0vlpwd28nNZeY/qAMjWlc53pKxc
	tAn1r1BaFqUUGW4K7fHLWcl/VxrdxDxA8xaDBGXKzamJ9vBcsiXOFpjIPDb4yPoLLijG3a
	QsK4Y5j/Nd5ElZVPRh+1+3cBP+T865h8xvX/6ib9Aw9aPWx1d5fk+Nhfsbnd8+Bii+PFYE
	4O43RE4JyrxNFain1pyQJaxXuxZFRY4Pd5i7H65cb6g9yD8H8ksSvfEltOTDag==
Date: Mon, 26 Feb 2024 16:07:36 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next 2/2] doc: sfp-phylink: mention the
 mac_capabilities and supported_interfaces
Message-ID: <20240226160736.5a10733f@device-28.home>
In-Reply-To: <Zdx5v1UXDqsKsjW8@shell.armlinux.org.uk>
References: <20240220160406.3363002-1-maxime.chevallier@bootlin.com>
	<20240220160406.3363002-3-maxime.chevallier@bootlin.com>
	<Zdx5v1UXDqsKsjW8@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 26 Feb 2024 11:45:03 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Feb 20, 2024 at 05:04:04PM +0100, Maxime Chevallier wrote:
> > +   Fill-in all the :c:type:`phy_interface_t <phy_interface_t>` (i.e. all MAC to
> > +   PHY link modes) that your MAC can output. The following example shows a  
> 
> Technically, this should be "MAC and all PCS associated with this MAC".
> 

Given that PCS should be covered in the doc, that's true :) I'll add
that in V2.

Thanks,

Maxime

