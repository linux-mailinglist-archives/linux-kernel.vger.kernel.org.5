Return-Path: <linux-kernel+bounces-147012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970BF8A6E31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43701C20ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05400133416;
	Tue, 16 Apr 2024 14:25:47 +0000 (UTC)
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DD812DDBC;
	Tue, 16 Apr 2024 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277546; cv=none; b=rjBpHPkrSdUF0EtjcEdNUWRYz+mAjdFKIxMwaN+h0y0YUhMlEACeZSvyC3BDs3l/vUoy3L2sDDRA57TjlzR/2LhO/krTDG4QYTlP1IDhWlfz3b7gWg1bn/pkDy71+HzYe6wqmE6wz2KqVBNaFC7cc98xTPCvGdvLen9ztchrNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277546; c=relaxed/simple;
	bh=BgCWqjuUV/U6yFMacmAdrh5euU57EkQYY0MpxO+2sTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Trga4mJe1h2fxhJyqGJeRIMfqyUldCugYHvl86Re9miGK2NYxdSNZQw/D8CETO98P1yRjwMxGVLi9T/0O+TgkC2E93uNiGx7GJyIPWDoSVpLpeiR1EcnM0lDufsbbBeBHX6J45BGZlPP8+pZePFc+QkpA5cBkD77MGv+K+AJHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 94132E803C0;
	Tue, 16 Apr 2024 16:25:43 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 596F41602F7; Tue, 16 Apr 2024 16:25:43 +0200 (CEST)
Date: Tue, 16 Apr 2024 16:25:43 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: API break, sysfs "capability" file
Message-ID: <Zh6KZ7ynHuOd0mgQ@gardel-login>
References: <ZhQJf8mzq_wipkBH@gardel-login>
 <54e3c969-3ee8-40d8-91d9-9b9402001d27@leemhuis.info>
 <ZhQ6ZBmThBBy_eEX@kbusch-mbp.dhcp.thefacebook.com>
 <ZhRSVSmNmb_IjCCH@gardel-login>
 <ZhRyhDCT5cZCMqYj@kbusch-mbp.dhcp.thefacebook.com>
 <ZhT5_fZ9SrM0053p@gardel-login>
 <20240409141531.GB21514@lst.de>
 <d7a2b07c-26eb-4d55-8aa7-137168bd0b49@kernel.dk>
 <Zh6IpqnSfGHXMjVa@gardel-login>
 <b74f99e8-5a50-4e93-987f-0bcfc0c27959@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74f99e8-5a50-4e93-987f-0bcfc0c27959@kernel.dk>

On Di, 16.04.24 08:22, Jens Axboe (axboe@kernel.dk) wrote:

> On 4/16/24 8:18 AM, Lennart Poettering wrote:
> > On Di, 09.04.24 09:17, Jens Axboe (axboe@kernel.dk) wrote:
> >
> >> On 4/9/24 8:15 AM, Christoph Hellwig wrote:
> >>> On Tue, Apr 09, 2024 at 10:19:09AM +0200, Lennart Poettering wrote:
> >>>> All I am looking for is a very simple test that returns me a boolean:
> >>>> is there kernel-level partition scanning enabled on this device or
> >>>> not.
> >>>
> >>> And we can add a trivial sysfs attribute for that.
> >>
> >> And I think we should. I don't know what was being smoked adding a sysfs
> >> interface that exposed internal flag values - and honestly what was
> >> being smoked to rely on that, but I think it's fair to say that the
> >> majority of the fuckup here is on the kernel side.
> >
> > Yeah, it's a shitty interface, the kernel is rich in that. But it was
> > excessively well documented, better in fact than almost all other
> > kernel interfaces:
> >
> > ? https://www.kernel.org/doc/html/v5.16/block/capability.html ?
> >
> > If you document something on so much detail in the API docs, how do
> > you expect this *not* to be relied on by userspace.
>
> This is _internal_ documentation, not user ABI documentation. The fact
> that it's talking about internal flag values should make that clear,
> though I can definitely see how that's just badly exposed along with
> other things that document things that users/admins could care about.

The text begins with:

    "This file documents the sysfs file block/<disk>/capability."

So it makes very clear this is about the sysfs interface.

Are you saying that sysfs of the block layer should be considered an
*internal* kernel API? That's a wild definition, if I may say so.

Lennart

--
Lennart Poettering, Berlin

