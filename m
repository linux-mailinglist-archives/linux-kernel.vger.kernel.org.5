Return-Path: <linux-kernel+bounces-37484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D883B0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB83287834
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3320712A162;
	Wed, 24 Jan 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wcbnsYDQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34877765D;
	Wed, 24 Jan 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119721; cv=none; b=QcFk7V0kR/hgYjEttfCQI2rxjzoB51bEddocKYY1BMGPnSqOVvkB/+8p/5R2zUIMAp9nqmqEa2qY4+9qCwRihWyJcewQG7LpnMy6whXsipnSSpgqrGfDe9gGVYNfo2oagGJVY26/xTBHBgZtTbNMeIRDOkZ832eKCevHw1oBpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119721; c=relaxed/simple;
	bh=tHOAqS07k9N0BYLxRMAX5QLYc0II/FnUt49MFugwFFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1fYf6EOKqyOEukC3aBIp6/CGxAf3pydnzmCaNd66wXpgJU6yRXtklcwNr08G27b88+JW3JlJ36rhouRpI+OkS5iHUdW7EN/Z5F94CmMsBfz72EEaykpygR7BJ++VEma+k4iAsXIXSqJkRI9kiqDt3rcGFsKGYx1upk+ZfdEQzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wcbnsYDQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zFtgHl594Mu0Zn9XavNEY0/YWD7WOji79U8hbCFvrl4=; b=wcbnsYDQE+lxAjxrlIONPB6qcx
	4IJa0UOXOzMohqxiXQ/TFmy2KZDER0rbv7L3tBjMEwmBKGXM1OTMUjPeGux+8jS2JSILBY0kNsFy0
	wsbF5b7gF613vyXl9FCNYOaXc/mvgvjoB5xOXSMoBF52Mm9Ki6DjeGMLuDRPaQRSLSqg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rShfp-0061F3-9A; Wed, 24 Jan 2024 19:08:29 +0100
Date: Wed, 24 Jan 2024 19:08:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor@kernel.org>
Cc: Philippe Schenker <dev@pschenker.ch>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Marek Vasut <marex@denx.de>,
	Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH net-next v1 1/2] dt-bindings: net: dsa: Add KSZ8567
 switch support
Message-ID: <359c32a1-3ffb-4bb2-9a46-802dff3812c4@lunn.ch>
References: <20240123135014.614858-1-dev@pschenker.ch>
 <20240123-ripening-tabby-b97785375990@spud>
 <b2e232de11cee47a5932fccc2d151a9c7c276784.camel@pschenker.ch>
 <20240123-atlas-dart-7e955e7e24e5@spud>
 <979b1e77b5bb62463d52e7b9d3f9ca1415f4006a.camel@pschenker.ch>
 <20240123-carpool-avatar-c1e51ab3cc32@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123-carpool-avatar-c1e51ab3cc32@spud>

> That sounds counter productive to be honest. Why does the driver not
> trust that the dt is correct? I saw this recently in some IIO drivers,
> but it was shot down for this sort of reason.

DT is software, therefore it contains bugs.

Say we ignore that the compatible does not match the hardware on the
board and just accept the DT has a bug in it and keep going.

That then makes the compatible pointless, and unusable for anything,
since there are boards out in the wild with incorrect compatibles. If
we later actually use the compatible for something, it might cause
regressions for those buggy DT blobs.

By erroring out then the compatible does not match the hardware avoids
such bugs.

The marvell mv88e6xxx driver takes a different approach. All the
compatible does is tell the driver where to find the ID
register. Marvell keeps moving it around, so there are three different
compatibles for the three different locations. If you use the wrong
compatible, its not going to find a device is knows about and errors
out. So this also avoids bugs in the compatible.

     Andrew

