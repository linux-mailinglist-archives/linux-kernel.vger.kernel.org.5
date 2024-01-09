Return-Path: <linux-kernel+bounces-21357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE4828E23
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351E91F25131
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4443D548;
	Tue,  9 Jan 2024 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="igPLvkdL"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308F3D3B8;
	Tue,  9 Jan 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 100BC2C1;
	Tue,  9 Jan 2024 19:44:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 100BC2C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704829482; bh=JrRTImpwqjMu8ndI1e7JDtYO7JM1fCfWbOsYmKSUr2Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=igPLvkdLcePpcMOIvmD1gySNx4M602WaoBmjkldd6//tO8kxCMoxijY1bWcWyvDxM
	 IOmJtSUAP4H/EFKRjHQL4vs0Zzt/DdcCMSYzXlf2WFuB+0PjbnmBezVwYv9AR8VL8l
	 W8aMlidrhhEB6mdL1LjiOabAt2AdvIIZw7iRb9DYD1qHxSuGB6u82paTFOuYf1kgxB
	 seopChC9p9uM/cgHMc8Ae8FRUw5i5mgzZSVTaMpMtR93e3mzWwchAguHJaZm+MZRRR
	 GdOM7eo7X7JNW7zepo1PghAGkb61vxABwrVwadkCXEqJHcKYuwHUQdlDL8l9eKJbRv
	 AekBMVieaJSwQ==
From: Jonathan Corbet <corbet@lwn.net>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, Muralidhara M K <muralidhara.mk@amd.com>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Begin a RAS section
In-Reply-To: <20240109183646.GAZZ2SPiMZv83J3f0a@fat_crate.local>
References: <20231102114225.2006878-1-muralimk@amd.com>
 <20231102114225.2006878-2-muralimk@amd.com>
 <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
 <87a5pes8jy.fsf@meer.lwn.net>
 <20240109183646.GAZZ2SPiMZv83J3f0a@fat_crate.local>
Date: Tue, 09 Jan 2024 12:44:41 -0700
Message-ID: <87wmsiqok6.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Borislav Petkov <bp@alien8.de> writes:

> On Tue, Jan 09, 2024 at 10:47:29AM -0700, Jonathan Corbet wrote:
>> I wish I'd been copied on this ... 
>
> linux-doc was CCed:
>
> https://lore.kernel.org/all/20231128142049.GTZWX3QQTSaQk%2F+u53@fat_crate.local/
>
> Or did you prefer you directly?

Lots of stuff goes to linux-doc, I can miss things.

Of course, I miss things in my own email too...you know the drill...

> I've been working to get a handle on
>> the top-level Documentation/ directories for a while, and would rather
>> not see a new one added for this.  Offhand, based on this first
>> document, it looks like material that belongs under
>> Documentation/admin-guide; can we move it there, please?
>
> Not really an admin guide thing - yes, based on the current content but
> actually, the aim for this is to document all things RAS, so it is more
> likely a subsystem thing. And all the subsystems are directories under
> Documentation/.
>
> So where do you want me to put it?

The hope with all of this documentation thrashing has been to organize
our docs with the *reader* in mind.  "All things RAS" is convenient for
RAS developers, but not for (say) a sysadmin trying to figure out how to
make use of it.  So I would really rather see RAS documentation placed
under admin-guide or userspace-api as appropriate.

Yes, there is a lot of existing documentation that still doesn't live up
to this idea, but we can try to follow it for new stuff while the rest
is (slowly) fixed up.

Make sense?

Thanks,

jon

