Return-Path: <linux-kernel+bounces-63466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25426852FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58DF81C22896
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441AD383BD;
	Tue, 13 Feb 2024 11:53:11 +0000 (UTC)
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45A38DCD;
	Tue, 13 Feb 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825190; cv=none; b=E6NYLH9QyheUMFfyrdSzAxQ55hD1qzbBMweRxiRltOzY3svEhnZSTF6c/xOYS62XrhloiTzUABjFAnDRdqVT/VbB36SzwuQy1Ed4yCDYnLY9Rd5h3Xb3WpQ9w71di2+fZbHerVxfFPenAoxm4UG84057rXCff4lrKZ0uuBtpex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825190; c=relaxed/simple;
	bh=fkBcdfRB38Ddw/ZwR2iHOK6nOHVyppNnyNGJz41GirY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wbo7oZmVIm61VtyMsZsoD8htHO4LFKnCsn+s8WbGEUYh0WkN8YD8N5ZecjKjhG07CMEL5l0ZTA3zeWo7mCMeSkkM7DXAuL+Szl1BqT/0CvMDR3LvoIGhJjvrH3xmwEpFx7i8xqqts9j0Mgq0Aj2uVm59qgcp3JlN2wiGpCgH190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 7CFBEA01AB;
	Tue, 13 Feb 2024 12:53:05 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IUruqtVTJVN6; Tue, 13 Feb 2024 12:53:05 +0100 (CET)
Received: from begin (nat-inria-interne-52-gw-01-bso.bordeaux.inria.fr [194.199.1.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id ED475A01A6;
	Tue, 13 Feb 2024 12:53:04 +0100 (CET)
Received: from samy by begin with local (Exim 4.97)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1rZrLU-00000007DiE-2ER6;
	Tue, 13 Feb 2024 12:53:04 +0100
Date: Tue, 13 Feb 2024 12:53:04 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Tom Parkin <tparkin@katalix.com>
Cc: James Chapman <jchapman@katalix.com>, edumazet@google.com,
	gnault@redhat.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] PPPoL2TP: Add more code snippets
Message-ID: <20240213115304.3oyqkvkb3oqkauwd@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Tom Parkin <tparkin@katalix.com>,
	James Chapman <jchapman@katalix.com>, edumazet@google.com,
	gnault@redhat.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240212222344.xtv233r5sixme32h@begin>
 <ZctJnCeUCANJvxGj@katalix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZctJnCeUCANJvxGj@katalix.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)

Tom Parkin, le mar. 13 févr. 2024 10:51:08 +0000, a ecrit:
> > +        ret = ioctl(session_fd1, PPPIOCGCHAN, &chindx1);
> > +        if (ret < 0)
> > +                return -errno;
> > +
> > +        ret = ioctl(session_fd2, PPPIOCGCHAN, &chindx2);
> > +        if (ret < 0)
> > +                return -errno;
> > +
> > +        ppp_chan_fd = open("/dev/ppp", O_RDWR);
> > +        if (ppp_chan_fd < 0) {
> > +                return -errno;
> > +        }
> > +
> > +        ret = ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx1);
> > +        if (ret < 0) {
> > +                close(ppp_chan_fd);
> > +                return -errno;
> > +        }
> 
> I think we should drop the PPPIOCATTCHAN ioctl call here.
> 
> The input file descriptors are called out as being PPPoX sockets
> created as described earlier, in which case they should both
> already be attached to a channel.
> 
> It would make more sense IMO to call out the two ppp_chan_fd file
> descriptors as being input parameters alongside the PPPoX session file
> descriptors.
> 
> > +
> > +        ret = ioctl(ppp_chan_fd, PPPIOCBRIDGECHAN, &chindx2);
> > +        close(ppp_chan_fd);
> > +        if (ret < 0)
> > +                return -errno;
> > +
> > +It can be noted that in this case no PPP interface is needed, and the PPP
> > +channel does not need to be kept open.  Only the session PPPoX data sockets need
> > +to be kept open.
> 
> Is it true to say that the PPP channel file descriptors can be closed
> by userspace?

In our code we do it
https://code.ffdn.org/sthibaul/l2tpns/-/blob/kernel/l2tpns.c?ref_type=heads#L1295
and it works all fine indeed (and avoids that fd per session).

That's actually one of the reason why I made the snipped only take the
pppox sockets, and make it create the ppp chan fd only temporarily. AIUI
the pppox socket already has a ppp chan (returned by PPPIOCGCHAN), and
the ppp chan fd is there only for performing the bridging ioctl.

Samuel

