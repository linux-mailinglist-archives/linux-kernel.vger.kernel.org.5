Return-Path: <linux-kernel+bounces-158753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4158B2481
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C541F2237E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DB814A606;
	Thu, 25 Apr 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wKYBk/3S"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3641EB36;
	Thu, 25 Apr 2024 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057380; cv=none; b=OkM/MjtVT6RScCIsqpxuf/hu0nc6nRhwbSOY6f6IiwHAKEXkwuWl+Zm5VAsDDnEY4KMk+836IFMaFj3vgcZJrgAQ9UwcFNejCuQ4l+9sjXHmSRe/HH0E5k+sCOJnCCkiRUKThj9mpf3HASSU6nDL84zJkQNfT4yLJaG70ZNwVM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057380; c=relaxed/simple;
	bh=QHS1yGQZXUoSnRDuHcZwrOIfl3A8NHeslgjGYpY0ZTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIVIS0iMnmb/SMbbGB5CSW7pDqfv5wm/4pn8nl6I0Xd9GQFO1EMiRTltYLuC9HJj8APBnqatrrQQIdTA85MqGk7uancJuq3n+pnp/VIe+ZGKPeJ1FOORSTvnN9z1DgMa4cP82YznFlic5FOW0vhUIpSeN6t4e82ZvoPjqZk2Yiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wKYBk/3S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zDQWAKJALiVi/PMdJAFbHeiKbsvm/Zf8NbphStNYkGk=; b=wKYBk/3SIgC7174xUmP7jgz6pG
	SmIw+57xyaLuR9+EhORyNkkxjBTpPWI5d/zpBmXmeWBrVGoxC7TLk1jl/8V1U9lgvqUFAqQeFmM7R
	8ucZZSc2Ft9nQNJzjvEpDSIG2KNmsyzzD0ya84rgkBiUKPqLhd7euPMtnf54PQEIzJ+4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s00ce-00DzkG-JG; Thu, 25 Apr 2024 17:02:52 +0200
Date: Thu, 25 Apr 2024 17:02:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kamil =?iso-8859-1?B?SG9y4Wss?= 2N <kamilh@axis.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: bcm54811: add support for BroadR-Reach mode
Message-ID: <feaa5d8f-f110-4ad2-be0e-94ddad9da719@lunn.ch>
References: <20240416123811.1880177-1-kamilh@axis.com>
 <3aaf1b82-247e-447d-a39c-c209105c2d7c@lunn.ch>
 <1b985a54-8c47-4f62-8971-e2a4d7976c03@broadcom.com>
 <4ddfdeba-cc85-47af-9762-b30143c4e606@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ddfdeba-cc85-47af-9762-b30143c4e606@axis.com>

> 1BR100 is really same as 100BASE-T1, in fact, the Broadcom's BroadR-Reach
> 1BR100 became 100BASE-T1 standard (IEEE 802.3bw). However, there is also
> 1BR10 to be implemented, which is neither 10BASE-T1S nor 10BASE-T1L.
> Thus, there would be 100BASE-T1 and the remaining BRR modes (1BR10, 2BR10,
> 2BR100, 4BR100), let alone the fact that it is questionable whether anyone
> would need the modes with more than one wire pair.
> So yes, for 100 MBit alone sure it would be better to make it 100BASE-T1 and
> it should be interoperable with another device using same link mode on
> non-Broadcom PHY.
> Note that the BRR modes are always full duplex
> 
> Shall we change the 1BR100 to 100BASE-T1 and leave the rest?
> 
> Option 1: 1BR10, 2BR10, 1BR100, 2BR100, 4BR100 (= leave as-is)
> 
> Option 2: 100BaseT1_Full, 1BR10, 2BR10, 2BR100, 4BR100
> 
> Option 3: 100BaseT1_Full, 1BR10 (= leave out the modes that are practically
> unusable)
> 
> In our application, 2-wire 10 and 100 MBit is used, the rest could be for
> someone else or just to map all PHY capabilities.

I would suggest you implement what you actually need. So option 3.

	Andrew

