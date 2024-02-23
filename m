Return-Path: <linux-kernel+bounces-78577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910C686154A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4679F1F255C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F0582866;
	Fri, 23 Feb 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h0rWbaEf"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF19F7175E;
	Fri, 23 Feb 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701070; cv=none; b=o4WmQx/McrKB0gUfwRVrSTuVTWHQippwqQHhkrf15cK3snkpp1zK6AeYCgp57m6h7yiszJtUvDyyGX5c9Q7DEZYylexklwiquUrYE83OcgVtZOXNyo0yF7OegOu+TJs2vHh6aR54YFwkhdzsMN0fBT1VfoIaVXaC//nKppN3ycI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701070; c=relaxed/simple;
	bh=PxYjF1RutTsLPmE3OJ6tcrJ1xcdHiw4brWhvRfjFA9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZl44I9q+ULpCJt+r3fM+RWowJGY0hWjCNiaLqPWccOeYA10zjC+2QTrj20LViW6Rh1V5woZTEeW5YP2Ar8tERsotNUHzyOXyEe5Rv9Qiceg9VlCZXqTsSaqP7FSp7+T+xYEizy4eXiY9qfLyTPnop4JDo2EBI7AAbPZdEzxd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h0rWbaEf; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 521E66000F;
	Fri, 23 Feb 2024 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708701060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydUaesQ0OVtKhYP+EhluA0cNkJa752d4qIXveokF4Ws=;
	b=h0rWbaEfcT+buqVA4TnEgUUD0EqapemsxttQSTkXQ6OUyOpLbKRlZXN4rlvZehSOdjNM2s
	aZ66FTmRsPx2ZxzDsA/+oo/8P36SoTYhFZBPDBDcaju++FI7SXuuwNuwCo8joKOtDwy9kk
	uLk9Zt54c9ZuqWydu6sYstr/ViV88dwYHSBzkU1ODNgZ/6OolZXLMYf60shZb7fzJCq1cH
	m6u/Zl57MpZzMkxAKXfBjBuXjNXELDhUV7QUmfZvNss+KkcJUQ+EgcsnnpGmMABEHNcZ5h
	G06t+0lWrWOmPrehhKUG+8m53b6YPxA3zGrnglio20vWJnnl5RYKrTPnStaouQ==
Date: Fri, 23 Feb 2024 16:10:57 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Bastien
 Curutchet <bastien.curutchet@bootlin.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: Add TI DP83640
Message-ID: <20240223161057.07b7aa5c@device-28.home>
In-Reply-To: <20240223160704.4018cac2@device-28.home>
References: <20240130085935.33722-1-bastien.curutchet@bootlin.com>
	<20240130085935.33722-2-bastien.curutchet@bootlin.com>
	<20240130-impulsive-widow-9142a069b7fd@spud>
	<20240131210521.GA2289883-robh@kernel.org>
	<20240131-tummy-imperfect-e6d6f0e245e9@spud>
	<a1e54836-51d2-4990-9444-56d9414eb28c@lunn.ch>
	<20240223160704.4018cac2@device-28.home>
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


> 
> I've missed that thread initially. I guess that if Fiber is to be used,
> this would be done through sfp, then we have all the regular interfaces
> to configure the phy_interface_mode, in that case that would be
> 100BaseX.
> 
> So, a sane behaviour could simply be to configure the PHY in copper
> mode by default, without relying on any DT property ? If anyone wants to
> use fiber mode, then they would have to implement the
> sfp_upstreamp_ops, which would take care of reconfiguring the MDI
> interface of the PHY in the correct mode.

I missed the fact that this isn't a new driver... So this would indeed
break existing setups who would have fiber-mode strapped-in but don't
use SFP for some reason :(

Maxime

> Maxime
> 


