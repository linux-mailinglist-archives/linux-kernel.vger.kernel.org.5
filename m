Return-Path: <linux-kernel+bounces-29918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F3831528
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738821C208A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B2B125C0;
	Thu, 18 Jan 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLMKorbi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACF81BC2E;
	Thu, 18 Jan 2024 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568080; cv=none; b=aXrt2WoOQU1lAVFl84bdBMb987eMSkBF6hn2ff+KEXsrgkDf49+RkOt3WZzEmPULvsA6fI9e0r4Fx5BVVGDVKqVFZVBoAqTw/HsirKa+AP4Nurxl46wg5Mb0irmxwGqZYQG61g0GtwUtCqNzefXHbYYjVhe7Vk4xGTyzPM5/XIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568080; c=relaxed/simple;
	bh=NvDgfWGKH3611urjnU880VyH0+2OEkUrzfs6WktS424=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=p8juIH98LNZr8btXWMYXop4G8epSi9m2G07gm85MCs2TWhD96JBEKwAG61uosFgBuQ4IXc3ai+BEIY1iN9bNpCuvjpJX+4yQAfGunM3jD9Y2w9ikiruiAAYxL3kD5dWM2BXDvfWCSns+S2qFaetwaAFTUs6BaXV8vRtiNOfNuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLMKorbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1043EC433F1;
	Thu, 18 Jan 2024 08:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705568079;
	bh=NvDgfWGKH3611urjnU880VyH0+2OEkUrzfs6WktS424=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLMKorbiRcg59HMkoHyJCr5ewM0nhzXX9zLT3fE3BdHariJL/proWpxBOyFV3TE0/
	 su5hR3bbEFVjswif9sOCTLKPU7jTYWFaIy1mN7ALW2mwRcWP0W7xxO+9EZeaJFnzyV
	 QtbVJffCzPcWTmQBQFqT5lIk08ys8CznvWpZ4xJU=
Date: Thu, 18 Jan 2024 09:54:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org,
	linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 31/45] tty: vt: use VESA blanking constants
Message-ID: <2024011857-anything-fascism-80f6@gregkh>
References: <20240118075756.10541-1-jirislaby@kernel.org>
 <20240118075756.10541-32-jirislaby@kernel.org>
 <39622a13-3999-4bf6-b8fc-f7a70c8cd5da@suse.de>
 <4976e06c-dffd-4b93-a828-34f998f2472a@kernel.org>
 <4ae60e8c-6a86-4895-b8fe-48de5b64b6c8@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae60e8c-6a86-4895-b8fe-48de5b64b6c8@suse.de>

On Thu, Jan 18, 2024 at 09:41:34AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 18.01.24 um 09:32 schrieb Jiri Slaby:
> > On 18. 01. 24, 9:30, Thomas Zimmermann wrote:
> > > Am 18.01.24 um 08:57 schrieb Jiri Slaby (SUSE):
> > > > There are VESA blanking constants defined in console.h already. So use
> > > > them in the console code instead of constant values.
> > > 
> > > These constants also exist in include/uapi/linux/fb.h. It would be
> > > nice to find a common header where they can be shared.
> > 
> > Hi,
> > 
> > see 32/45.
> > 
> > I actually don't know how to fix that nicely while keeping uapi happy.
> 
> Is it hard to get a new UAPI header accepted (honest question)?

No.

> There are a few things I'd like to split off from fbdev. But that
> would require UAPI headers.

That's fine, create them, but you can't just delete an existing .h file
as that will usually break things.

thanks,

greg k-h

