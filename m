Return-Path: <linux-kernel+bounces-133684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A51B389A755
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5713D28720C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E104722F0E;
	Fri,  5 Apr 2024 22:33:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE91CF8F;
	Fri,  5 Apr 2024 22:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356407; cv=none; b=jdDzhAXgtURG0ukWrgouVQBnYiHbtFlV5I1jjVB/DrS7j6x+LwPuK6/kXMHruPmsyEtgqK5ToiPNgUrC8O215n5xSdo1ZDa5Ly4ssv2bx/Y6V/o4aLXLP7CxJuIbRAzl6Zg0K2XLWUib09sfgoo7hivPObySEuxwhiPOhENekAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356407; c=relaxed/simple;
	bh=tOOBRSN4UD8iNmFPLqnELgrDuShaBqdXyEqgmPhWEHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emhrGhxQF8QR7TUP4WCCdJSjlJFEjrcK5cbu7nro7oYpuI+cOguZBLb4RPuMz1SyZlWPbQuZHoGyQ7fcbtklosOBQOsNBn3SCGsUrC4N1qLge5+eDSul3NGjHigZSPqMLPZrQF3hhXuTFd07GSQHptzSs3iJk1BEl5+Si+HADjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-CSE-ConnectionGUID: YOZbUO0fSbGoHoPAw5ipOg==
X-CSE-MsgGUID: qZdnhEV0RpWZaRrs8sxlVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7937167"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7937167"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 15:33:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="937088154"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="937088154"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2024 15:33:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 311554C5; Sat,  6 Apr 2024 01:33:22 +0300 (EEST)
Date: Sat, 6 Apr 2024 01:33:22 +0300
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tty: Handle HAS_IOPORT dependencies
Message-ID: <ZhB8MnWSeySAHGXG@black.fi.intel.com>
References: <20240405152924.252598-1-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405152924.252598-1-schnelle@linux.ibm.com>

On Fri, Apr 05, 2024 at 05:29:23PM +0200, Niklas Schnelle wrote:
> Hi Greg, Jiri, Ilpo,
> 
> This is a follow up in my ongoing effort of making inb()/outb() and
> similar I/O port accessors compile-time optional. Previously I sent this
> as a treewide series titled "treewide: Remove I/O port accessors for
> HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
> subset of patches merged I've changed over to per-subsystem series. These
> series are stand alone and should be merged via the relevant tree such
> that with all subsystems complete we can follow this up with the final
> patch that will make the I/O port accessors compile-time optional.
> 
> The current state of the full series with changes to the remaining subsystems
> and the aforementioned final patch can be found for your convenience on my
> git.kernel.org tree in the has_ioport branch[1]. As for compile-time vs runtime
> see Linus' reply to my first attempt[2].
> 
> The patch was previously acked[3] by Greg but given this was almost
> a year ago and didn't apply then I didn't carry the Ack over. That said
> I don't think there were non trivial changes.

Hmm... Can those drivers simply be converted to use ioreadXX/iowriteXX
instead?

-- 
With Best Regards,
Andy Shevchenko



