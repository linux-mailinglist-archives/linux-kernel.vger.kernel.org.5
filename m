Return-Path: <linux-kernel+bounces-78023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A8F860E10
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF8C1F265F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA922EF5;
	Fri, 23 Feb 2024 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="QoxcclqC";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="U8Qo2tdD"
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B25C8F9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680932; cv=none; b=pdPZEjj74VIJ9fSwjy+p+QLlNbtxVYIS2gPa6t2aLucI+K0xaSgr/VlUgz5ZWFfrVM1T6LhDDm08HccubUDGpxekJok/rePBIQv9ipsQGxRR9sZilBFEUXuH82HlTkcCSVe2G/L6m2pHEaqrk0VrBynJcHb4NEuqkJiJzIjY/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680932; c=relaxed/simple;
	bh=1AuFo9AfZZjMBhRnQTvCb4B3WDa1c0+Ea+mu6365uDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNTeFsi+R2VZJVy77DT7dmUxmOEl+prnrO4qCpJQGAYwV+QThB+3rNhD/XT1dGEumCy48zkXeAXI/CWCPjieJ7QQMzpHmWsO60Xu6z4VGGYpT8sAE6ZxVPV8ZJsuypSVJ2eW8CPn2kJLG6sABxSRC5Np47fSLZTk1L0vqGoAjFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=QoxcclqC; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=U8Qo2tdD; arc=none smtp.client-ip=46.30.211.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=b9DVkpvcR7/h1gy9vtR0pGRtWbblb47ZL60TRaWUHFQ=;
	b=QoxcclqCooYXSycrWqe51U/lHSyIwOxCt/eKvo59wzb5L7JwHuhwKzNGTJgAlRyxPphW0Jz/ezXcb
	 Ejl5fdHG6UU9+sd9iX+9TP06PegzHHpeXIPq7PCDJRVLPJd0y4QlBrWXEYUflLdgQ/Ed1duM00VMM+
	 GnrVsA8w1QiGjPPzIcbQxkmhqyf7YbUhS4OlRlLHGV9c8okHV7WWMaL2O6SiprK2CioyxvMm6CB67g
	 BuRocIt4V2JZFNHcwZ2wJg1ShNz8PwWNHmv/o+RDdetDlXR83uaFj3vT9sUo5pe0TFW/ifq7ZhWhub
	 wz52WkGZfb7lGCSZuEzoTVIBwVVBV+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=b9DVkpvcR7/h1gy9vtR0pGRtWbblb47ZL60TRaWUHFQ=;
	b=U8Qo2tdD2GOyZ4ktLKLjEgLf1Vv6OiJMJdBXIIP892Aej7Lx30DlYRqgc+7MUhvJsMTGKAqbj5AZ7
	 vRLGr3EAQ==
X-HalOne-ID: b5829225-d22e-11ee-a484-31e85a7fa845
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay4.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id b5829225-d22e-11ee-a484-31e85a7fa845;
	Fri, 23 Feb 2024 09:34:17 +0000 (UTC)
Date: Fri, 23 Feb 2024 10:34:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: sparclinux <sparclinux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: sparc: patch to fix parport_pc build on 32-bit
Message-ID: <20240223093416.GA2800152@ravnborg.org>
References: <4c4e2845-c7a8-4d0b-aa4a-7c5e3399b3dc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4e2845-c7a8-4d0b-aa4a-7c5e3399b3dc@infradead.org>

Hi Randy/Andreas.

On Thu, Feb 22, 2024 at 09:15:28PM -0800, Randy Dunlap wrote:
> Hi Andreas,
> 
> Please pick up this patch from June/2023. I have already replied to
> the patch with:
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> and I just rechecked it on linux-next-20240223 to make sure that it
> builds cleanly. It does; however, there is one trivial merge warning:
> 
> patching file arch/sparc/include/asm/parport.h
> Hunk #1 succeeded at 20 (offset 1 line).
> Hunk #2 succeeded at 252 (offset 1 line).
> 
> The patch:
> https://lore.kernel.org/lkml/alpine.DEB.2.21.2306190121540.14084@angie.orcam.me.uk/

I took a quick look at the patch. It does the minimal to fix the build
but the ebus_dma thing is only used by sparc64 an should not be visible
at all for sparc32.

I think the right fix is to make the current
arch/sparc/include/asm/parport.h sparc64 specific and use
asm-generic/parport.h for sparc32.

	Sam

