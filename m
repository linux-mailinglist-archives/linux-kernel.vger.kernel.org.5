Return-Path: <linux-kernel+bounces-50298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F72884771D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528961C21D63
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0EA14C5B8;
	Fri,  2 Feb 2024 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="jhdQSz7C"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFA514AD35;
	Fri,  2 Feb 2024 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897375; cv=none; b=LJaiZem5+NWI7y0xCTVmGIx+dr1BiQijHtWGkw4V9bLIpJxBnkeum/353ZVpSqdQJF3kYjfxo0KxCxTpiVQEzQG+uoluMzz0++uC1rpNGz0v6h/VGQWGVtgzEIk/u+OAzzulw/HN8SGYBmNHVp1ArE/kyy2V4rkY+NvSbAJia7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897375; c=relaxed/simple;
	bh=x43XPOL1PbPilaYQ6MD0cbRYlkVgvCNk7kgF8R7Px9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMAC1i64Q8ura8tEuWAGwN3iSMvOsj4VF2r5rDDrxN1KpcFtDjFH8tr3JmPYZ5n89rSPTPipHXIdo/ouj0ReDsogRZohcJzu4xaKjc4oxMKHjafrwdevhYvNKZ0BWL/ep+OzsUK3HeQqvMp3rr6EQC3PUu79uX1VfFnOT6Pj7CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=jhdQSz7C; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BFAD41C0075; Fri,  2 Feb 2024 19:09:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1706897363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhXuiOTbJ28fQ5AS5PmmoNrqYc/K8PF6YpD9vw+3YLI=;
	b=jhdQSz7CrPhbI1Q3kJM2xE0wt1pW/KbasLXyc4hQcWpktvyuuQBKxWGFTBEWFhgH70WnNW
	xl0kwT7Cf7qI8aiibGrSamtxdfsQhULo/VTv6AQEvNc6r+8uJlftWk30oTPy9ZBm4fEuNy
	CEygw9YRd96RzVAH3rug0y2SIaortao=
Date: Fri, 2 Feb 2024 19:09:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: phone-devel@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	fiona.klute@gmx.de, martijn@brixit.nl, megi@xff.cz,
	samuel@sholland.org, heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: anx7688: Add driver for ANX7688 USB-C HDMI
 bridge
Message-ID: <Zb0v0va1A4SvlgCh@mobian>
References: <Zbt1dIByBZ2stzjm@mobian>
 <2024020126-emote-unsubtly-3394@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2024020126-emote-unsubtly-3394@gregkh>

Hi!

> > --- /dev/null
> > +++ b/drivers/usb/typec/anx7688.c
> > @@ -0,0 +1,1866 @@
> > +/*
> > + * ANX7688 USB-C HDMI bridge/PD driver
> > + *
>=20
> <snip>
>=20
> Did this pass checkpatch?  I need a spdx line for new files please,
> don't force us to go back and guess in the future, that isn't nice.

Thanks for the review. Fixing checkpatch issues is easy, but it looks
like closer look will be needed at the devicetree probing.

Also, what are the authors preferences about the license? I'd prefer
GPLv2+.

Best regards,
								Pavel

