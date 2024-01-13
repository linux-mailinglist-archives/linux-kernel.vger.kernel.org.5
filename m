Return-Path: <linux-kernel+bounces-25215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348582CA8B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 09:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3577284500
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 08:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40836185A;
	Sat, 13 Jan 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iX8HKc3R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BCC17E8
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 08:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249ADC433F1;
	Sat, 13 Jan 2024 08:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705135443;
	bh=U/1xCZ/+/48UFtpHyB+UWCjosRD4BxaKhhnQaITduXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iX8HKc3REtHpv3yl2jmZe3N6N2Otk2JX+ZhnBw+vyVMmE9pdb/Ivy2DO6ChdUoZ4l
	 qF6fzGJ9pAtCuCVRCPjyAh0pF4tikFFfG9Juw8obWmjD/sLAzs7kJUtinDT2PS/3se
	 RC6e3Munr+7Px0zoIsB+/kEUtCdyNn7PW/hGHvY4=
Date: Sat, 13 Jan 2024 09:44:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: Deliberately sending partial patch sets?
Message-ID: <2024011338-flammable-zoology-4686@gregkh>
References: <ZaFKvZg-MtZgbCKA@archie.me>
 <2024011247-caregiver-compacted-2e6b@gregkh>
 <ZaI04-HDHbBxKYbS@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaI04-HDHbBxKYbS@archie.me>

On Sat, Jan 13, 2024 at 01:59:47PM +0700, Bagas Sanjaya wrote:
> On Fri, Jan 12, 2024 at 08:37:10PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Jan 12, 2024 at 09:20:45PM +0700, Bagas Sanjaya wrote:
> > > Hi,
> > > 
> > > Let's say that there is a contributor who wish to send a patch set (e.g.
> > > 20-30 patches in the series) to LKML. But instead of sending the full
> > > series, he either do one of the following:
> > > 
> > > * Send only the cover letter (analogous to movie trailers)
> > > * Send only a few arbitrary patches in a series that are most important
> > >   (e.g. patch [01,04,11,18,23/30]) (analogous to match highlights)
> > > * Send only the first few patches in a series (i.e. subject of one of
> > >   patches says [09/30]) (analogous to sample book chapters)
> > > 
> > > The rest of patches are behind closed doors (i.e. not sent), possibly
> > > behind charm-priced (pay)walls.
> > > 
> > > Is the submission like above acceptable (when in review)?
> > 
> > No, kernel development is done in public.
> 
> That is, the submitter must send the full series, right? Why not partial
> like above?

What can anyone do with a partial patch series?  Why would anyone who
sent that think it would be material that anyone else should do work for
them and review it when they aren't even sending the whole series?

I'm confused as to why you would think that would be acceptable?  What
are you really asking here?  Hypotheticals only go so far, please point
at a real instance and we can talk about it there.

thanks,

greg k-h-

