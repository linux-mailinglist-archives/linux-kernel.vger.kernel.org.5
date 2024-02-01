Return-Path: <linux-kernel+bounces-47642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AECF845098
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C344A1F27B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF5A3C478;
	Thu,  1 Feb 2024 05:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XCDw34tk"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365B3BB4C;
	Thu,  1 Feb 2024 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764172; cv=none; b=OwqbNyyWAX1/P+6w8Ovs1JrgDJF7V0B122AzRiq2yknlFiX0gsjlFSoC2d5Tf9tlHuT9naFnS4GLvLkWXNMntVctjShymcXmdqaNqxGq4SXrHfOH7R2DWVmjIrggVjPziY9HNgOiZV6WvbMBE1NA+RjNyCIMvsZ3BUYIVCYi9+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764172; c=relaxed/simple;
	bh=dho0O/KBOIRgMEEFGI+xaY4Yy0CZlpx02gk/kCcdzxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAw2uPFt89gTC+tj1izYYJEMrZrcMiFj+5lyhl7nlr5XsbiUcoxaKtx6lIA9Iw32cJdBWyoNbqdYAtrSaZ4j1HQVIzsJNtcJ3YXZ8ctBe7aIolONXYrRMLv62SMPR5SP9wDECKR5MNcoeGWmPcNI4/UNlJgeOzhoB3KXtzdJUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XCDw34tk; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id EFB3EC317E;
	Thu,  1 Feb 2024 05:09:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C568D1BF203;
	Thu,  1 Feb 2024 05:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706764153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTp3u4G8bYxcdUintsTmxzq/KCyjPkpU4ReQdetZHak=;
	b=XCDw34tkRn207Hy8t5Y2QEDSiNzNZ3121T3xyIWCXfFKXdo9G617Eli5crrktpVAhizDzN
	F9L33D+HqSKhWtjBSy4/fj560nx89jdRSaao7p4Jz1tS+0nahj2WUcgB9s+H11J8G+7ZjU
	JOBRvGAP7ilJYU3iiX4BOf9Voy63AR6/1NThxrjEvWLwIN8dMvKYQxVEzwcALtjl5787wh
	FgZ5UMDCE/B9qfQkCeu2pEAd27Y2xLoOvKYweXqAvERNsQuX59BRa3r6Z/cwhuXOjby0AE
	nHPEdpa3pBaZGzA5aHNzoka5b0xu60ipi6ewaifY6YAdXxSwhU2JjPFH1AhiUQ==
Date: Thu, 1 Feb 2024 06:09:11 +0100
From: Kamel Bouhara <kamel.bouhara@bootlin.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jeff LaBundy <jeff@labundy.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
	hannah.rossiter@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH v5 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <20240201050911.GB3005@kb-xps>
References: <20231211121430.1689139-1-kamel.bouhara@bootlin.com>
 <20231211121430.1689139-4-kamel.bouhara@bootlin.com>
 <ZY5An58Rffrcpfpn@nixie71>
 <20240131171441.GA3005@kb-xps>
 <ZbqmN47QhI1LhWBT@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbqmN47QhI1LhWBT@google.com>
X-GND-Sasl: kamel.bouhara@bootlin.com

On Wed, Jan 31, 2024 at 11:57:43AM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 31, 2024 at 06:14:41PM +0100, Kamel Bouhara wrote:
> > On Thu, Dec 28, 2023 at 09:44:31PM -0600, Jeff LaBundy wrote:
>
> [...]
>
> > > > +	case AXIOM_TARGET_STATE_HOVER:
> > > > +	case AXIOM_TARGET_STATE_TOUCHING:
> > > > +		target_prev_state->insert = true;
> > > > +		update = true;
> > > > +		input_mt_slot(input_dev, slot);
> > > > +		input_report_abs(input_dev, ABS_MT_TRACKING_ID, slot);
> > > > +		input_report_abs(input_dev, ABS_MT_POSITION_X, target->x);
> > > > +		input_report_abs(input_dev, ABS_X, target->x);
> > >
> > > You do not need to explicitly report ABS_X and ABS_Y values, as calling
> > > input_mt_sync_frame() effectively takes care of this by way of pointer
> > > emulation.
> > >
> >
> > After double checking/testing this, it doesn't seems to
> > report ABS_X/Y values anymore, are you sure about this ? Maybe I missed
> > some extra flag in input_mt_init_slots() for that ?
>
> You are missing call to input_report_slot_state() before you start
> sending position data. You also should not conflate tracking ID and
> slot number. I.e. if you touch and release and touch again, you
> likely report through the same slot 0, but the tracking ID of the
> contact should be different.
>

Hi Dmitry,

Ok thanks for the clarification, I will check again but I think you are
right and target->index should be used as the tracking ID as it should
be different between reports.

This should be fixed in v8.

Thanks !
--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

