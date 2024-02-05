Return-Path: <linux-kernel+bounces-53024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3656849F9B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120BC1C225F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7A446BD;
	Mon,  5 Feb 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b1RMH9tz"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA844C68;
	Mon,  5 Feb 2024 16:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707150957; cv=none; b=OzNCMqkL1cz90hdApZ6o6PZ3Hn4bCdQMrpaE6eUH2RPs/KNCTFB9eT/hxSxjo5zxEK/LUsGYP8G119btSxL3Rrni/G8XyCK77XE0X42TwYikIHEXzFXOUmkxNGWn5Wj87cTjab932e6kgeoVZEWsQyAvxVzQIXuK6K+jXmlOWmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707150957; c=relaxed/simple;
	bh=q50P4lGMt/9LVWTI3qIpeVb18lpaOUNXND5GHbwjdX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEaLpxgeU+5UVMCuW2HPaknY7CYZWp0Lb9iOVjf36zcP2q++pe95+Ixleer8tS4MyJMrbbH/ngUWPl2N0fTOFksAN7EyV5lmUl0V5elCJTY6OQPGoGSomoHLoTW374XlLDMsAdHBiVAMLpRwQ69h4GP+0heAYkXbuiw0vF+/AS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b1RMH9tz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C2DE2000C;
	Mon,  5 Feb 2024 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707150952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vq+7j5rxUfbX5WXgjjUMJLefHoCSzp73T0/QzZgsJQ0=;
	b=b1RMH9tzIEZtvIz/qE6IM+rZBJEFptCrP116L6aKsjBxZ484rRCOYnu6uxibhlNrchhW09
	WkDDsVhsWh1GKP4Nznz6+g9CWjpcRCJxrNQhkOr5EOlwa71KLMrKjPqQ+Sdcz7ue+fiEqM
	qmx8CEztbG97ao52gOnkOnO2oKCzhekdwOEEkwkmz1LFKMydDrhLMeTEHIlH+c1/4qhMZz
	aoz6csxFiWLYE9CkM/1NncamijP3au1So3PepP7zh3+T6wTMb5s55Dul2asYDf0T73nQmD
	mS8qDH9dtHEH0IodS1uriDqd4ZPNF/dyV2ZcyRlsId4LhlwXWXTYsfrrTR7ggg==
Date: Mon, 5 Feb 2024 17:35:50 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/6] net: wan: Add support for QMC HDLC
Message-ID: <20240205173550.2a6b8f20@bootlin.com>
In-Reply-To: <d174364c12366b1f5eeb616cba078f6682d629f5.camel@redhat.com>
References: <20240130084035.115086-1-herve.codina@bootlin.com>
	<20240130084035.115086-2-herve.codina@bootlin.com>
	<b1968b5c7e88edd448d5f55b57dfa40257b2b06c.camel@redhat.com>
	<20240205152208.73535549@bootlin.com>
	<d174364c12366b1f5eeb616cba078f6682d629f5.camel@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On Mon, 05 Feb 2024 16:49:33 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

[...
> > > 
> > > In general is quite bad that the existing infra does not allow
> > > leveraging NAPI. Have you considered expanding the QMC to accomodate
> > > such user?  
> > 
> > I cannot mask/unmask the 'end of transfer' interrupt.
> > Indeed, other streams use this interrupt among them audio streams and so
> > masking the interrupt for HDLC data will also mask the interrupt for audio
> > data.  
> 
> Uhm... I fear the above makes the available options list empty :(
> 
> > At the HDLC driver level, the best I can to is to store a queue of complete
> > HDLC skbs (queue filled on interrupts) and send them to the network stack
> > when the napi poll() is called.
> > 
> > I am not sure that this kind of queue (additional level between always
> > enabled interrupts and the network stack) makes sense.
> > 
> > Do you have any opinion about this additional queue management for NAPI
> > support?  
> 
> With such idea in place, what HDLC-level data will be accessed by the
> napi context? The RX interrupts will remain unmasked after the
> interrupt and before the napi poll right? That would be
> problematic/could cause drop if the ingress pkt/interrupt rate will be
> higher that what the napi could process - and that in turn could bring
> back old bad livelock times :(

Indeed.
So the best thing to do is to keep this driver without NAPI support.

Best regards,
Hervé

