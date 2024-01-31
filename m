Return-Path: <linux-kernel+bounces-47097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B38844915
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237CB1C2339F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C73381D5;
	Wed, 31 Jan 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ENa2o3JK"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C57374FA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733773; cv=none; b=T7maYDew5pGVEaSlmfSvvFt71/Ayy9WXvoc8crSg/sh4znCTHRlVF+I3QJUCxMOv7m+tLEF+InMi/xTIHri+eQkvuBD4NwMdlfRIFBSPSXlfp7DZp8z8wnhda+QYXkwa6lDT7OGOR5FIJDO2uNFx9WEMdaL5S3SZoi6K/10wVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733773; c=relaxed/simple;
	bh=0ttANtOrcttr7NXaqt/G0w+9AjfKy+c5thEW3pDhz3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/YhhAZ3jIvhhjmytvrWPtqamno6G81l0RP5tnhCwtgEBS8qpQE29yK9ynBvtb1vpCSdfaD5IStmDWOYZNK6fO4o584Un77Xz2b5gjiUBXUXE/B+qqbmLIu2HCgV1s7TJ575oAHeGO12g9PtPvOyJOsf2qrHTWEFUzehjAQ2Ca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ENa2o3JK; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2909a632e40so120713a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1706733772; x=1707338572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HikurBEOhu9euC7gl0ui3GG6XowXvyoYxK7m1zGW+s=;
        b=ENa2o3JK8jYa1RYoybqHhhajN7vXPeDGVwnPgMOyLNp2438iHE1aLCfbGsoBoRlcMr
         dk6dT2YyrH45ZE7R1Uz323TWe/Tcclgb8Q9er/zT2Mlmpy8wO8+92J+8F5Im4EBUzxKe
         14rf7XmzyXt9kUR2vEqHE8YYI5EZc24XCEi+0hSc0qQi0G/mAvR++ZyCA4cd/rN5iBIK
         Rge4ciJ0yNpP/tgYTHXGYiIeW/QwlbhRhXBBSRfJ09rSLVDaq0TqOOUYncnxfsPaY1Xy
         W9w50vs6qqh3wW476TzMrblmvTqMv5SAbrN9tcBohaB+Mh4cpGDLLcXwBEDzB+Fv+5lZ
         2Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706733772; x=1707338572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HikurBEOhu9euC7gl0ui3GG6XowXvyoYxK7m1zGW+s=;
        b=v6cyf5wadXpnUuRdNGrEPJS+nCNFVVWsx5mCN0JUlNNhS8PMGRG+/qZsLLaen2j1GX
         1rPVBRThFOehVn+oSuRhBsApjsiBfMc5NBO+iLVhuJfU8ZRaIclzpUu5IqEJXxcw3MdO
         /GmPI9KxCpVRxmxc0wzDVE3/GJeVNUq43LQJKOJ0jjLsvEEKkpoXeBzCFSHfazvBBAwb
         c9VLMSj56DS8c23xAdZ7KsS9Oh5M0GxpMxbE5nWdSYIBKClK+Rz56scGlAjlV3zmvOlQ
         SEeE4hligfYIDOCs2mXkz3ppev37fLIg9xgg3jcqdOJrlWjxrfvgIXfTGI526x/GKLpy
         6Ruw==
X-Gm-Message-State: AOJu0YyuNz6HNU5iabDfQAyNxUt6Fkc0nR1cnymJj97cBSJbLOX8ZbRw
	izVBJPI3PvCjEV73Scbf7hWg/RQTx1FcYtSYTHw6MyS07NI+riNQwR521Xk7MTs=
X-Google-Smtp-Source: AGHT+IFKgnjyHOHXjb8FWpmberef1nwD4qkIyOp+/vPJjvOfE+QEc5Mj2C0M+Fe+UDPDMwl9iwoIbw==
X-Received: by 2002:a17:90b:2406:b0:295:cf9f:a1de with SMTP id nr6-20020a17090b240600b00295cf9fa1demr2928435pjb.12.1706733771727;
        Wed, 31 Jan 2024 12:42:51 -0800 (PST)
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id db16-20020a17090ad65000b0029608793122sm225215pjb.20.2024.01.31.12.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:42:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rVHPz-000JNE-2o;
	Thu, 01 Feb 2024 07:42:47 +1100
Date: Thu, 1 Feb 2024 07:42:47 +1100
From: Dave Chinner <david@fromorbit.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: Re: [RFC PATCH v2 7/8] Introduce dcache_is_aliasing() across all
 architectures
Message-ID: <Zbqwx12WfXvZ6kk2@dread.disaster.area>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
 <20240130165255.212591-8-mathieu.desnoyers@efficios.com>
 <Zbm1CLy+YZWx2IuO@dread.disaster.area>
 <d30a890a-f64e-4082-8d8e-864bfb3c3800@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d30a890a-f64e-4082-8d8e-864bfb3c3800@efficios.com>

On Wed, Jan 31, 2024 at 09:58:21AM -0500, Mathieu Desnoyers wrote:
> On 2024-01-30 21:48, Dave Chinner wrote:
> > On Tue, Jan 30, 2024 at 11:52:54AM -0500, Mathieu Desnoyers wrote:
> > > Introduce a generic way to query whether the dcache is virtually aliased
> > > on all architectures. Its purpose is to ensure that subsystems which
> > > are incompatible with virtually aliased data caches (e.g. FS_DAX) can
> > > reliably query this.
> > > 
> > > For dcache aliasing, there are three scenarios dependending on the
> > > architecture. Here is a breakdown based on my understanding:
> > > 
> > > A) The dcache is always aliasing:
> > > 
> > > * arc
> > > * csky
> > > * m68k (note: shared memory mappings are incoherent ? SHMLBA is missing there.)
> > > * sh
> > > * parisc
> > 
> > /me wonders why the dentry cache aliasing has problems on these
> > systems.
> > 
> > Oh, dcache != fs/dcache.c (the VFS dentry cache).
> > 
> > Can you please rename this function appropriately so us dumb
> > filesystem people don't confuse cpu data cache configurations with
> > the VFS dentry cache aliasing when we read this code? Something like
> > cpu_dcache_is_aliased(), perhaps?
> 
> Good point, will do. I'm planning go rename as follows for v3 to
> eliminate confusion with dentry cache (and with "page cache" in
> general):
> 
> ARCH_HAS_CACHE_ALIASING -> ARCH_HAS_CPU_CACHE_ALIASING
> dcache_is_aliasing() -> cpu_dcache_is_aliasing()
> 
> I noticed that you suggested "aliased" rather than "aliasing",
> but I followed what arm64 did for icache_is_aliasing(). Do you
> have a strong preference one way or another ?

Not really.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

