Return-Path: <linux-kernel+bounces-56508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC3C84CB00
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C620E1F24492
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D65768F0;
	Wed,  7 Feb 2024 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Joxw6dC+"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C859178;
	Wed,  7 Feb 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311100; cv=none; b=JerZZzpe+NEUvVxOHG9yHMcLdaIgcfOC4xkq4jwMFoJTvp3ByAq4OTtDd7a5xtyX6JaYPsnLfQLbeXnmJaR1ExWcaLpVkLpxjfY1CKRPNmMG/tq20jKPdnHLrNwWONestIiUAYdI8QtW2EkxYto5GbGXdElL4/bBpSy/0WziX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311100; c=relaxed/simple;
	bh=ous0MH1KPZJPfO8wzVGi7xPdc7ON7llYysO4R/VPbGc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=EaZCHQAE4PRaSQ1cYy4YPRpR/2aS92id1pnMFd8oHcwNGSzpdruEKPAllHOq7gIG6ZwiOB+nC2C5O2mWRbCOOafjcy56qMh+AEKfkOlX8Y2fDfHoBD+QN+U3kCPpJFgE0npEY7jt8PzmHN4ttZrJ6v3VdCoCmugsnajYAc+qQtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Joxw6dC+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A38DEA27;
	Wed,  7 Feb 2024 14:03:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707311007;
	bh=ous0MH1KPZJPfO8wzVGi7xPdc7ON7llYysO4R/VPbGc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Joxw6dC+Kf6+vZVGbKclT283ZdQpJOdh2McfsJ7j9hSwJrzWJ0mCFzNp40kguAZSq
	 d+P3gY5wwbOHjQvgkliFGKw0g8lTBan1YyTzl+xYjrpsXfPv47FHTdEDMXXcu28wao
	 2h6QqHA042qlUNs3q14ux6pXti9Cj61yCoC2at9I=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZcKk6QJXfGGo2DH9@pengutronix.de>
References: <ZcFx7P30Su_Mx4AV@pengutronix.de> <20240206032301.6e4tmbvmk7vs72gg@synopsys.com> <ZcKk6QJXfGGo2DH9@pengutronix.de>
Subject: Re: duplicate requests on host side while streaming via uvcvideo gadget
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>
To: Michael Grzeschik <mgr@pengutronix.de>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Date: Wed, 07 Feb 2024 13:04:48 +0000
Message-ID: <170731108881.252503.6282895768429052406@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Hi Michael,

Quoting Michael Grzeschik (2024-02-06 21:30:17)
> On Tue, Feb 06, 2024 at 03:23:17AM +0000, Thinh Nguyen wrote:
> >On Tue, Feb 06, 2024, Michael Grzeschik wrote:
> >> Hi Thinh
> >>
> >> I found some strange situation while streaming via uvc-gadget to some
> >> usb host. It happens when some requests are missed due to higher load =
on
> >> the gadget machine. In some cases some requests will reach the host
> >> twice. In my special case, I added the following changes [1] for the
> >> host and gadget side.
> >
> >Does this only happen to some specific hosts?
>=20
> >Are all the data of the duplicate requests matching or just some bits of
> >the transfer? Were you able to confirm from some usb analyzer/sniffer
> >that the data out the wire is actually duplicate?
>=20
> Turns out, this duplicates are just misinterpretations.

I'm glad there's no deeper issue to worry about here.

> The linux uvcvideo driver will parse the uvc header payload twice. (If
> the FID was incremented inbetween). This led to those double misleading
> outputs. Although this means that there is a bug in
> uvc_video_stats_decode for incrementing the error count.

Do you plan/are you able to submit a patch to fix this?  Hopefully that
would prevent anyone else following the same rabbit-hole.

--
Kieran


>=20
> Anyway, so just ignore this whole thread and be thanked for even having a=
ny
> thoghts on this.
>=20
> Regards,
> Michael
>=20
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

