Return-Path: <linux-kernel+bounces-130600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E8F897A55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48E028A4C2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7615664D;
	Wed,  3 Apr 2024 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pyqIxHKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5914C5B3;
	Wed,  3 Apr 2024 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712178154; cv=none; b=XpoDmGCWuCWJa8xnwxap2xPUPjB0JGATHKuqcsSGH2UlW4DKKhflwq2G8eR5QpufonrndrNDBbZQkVV431b/michwFFu8OanMEWnlqrx7L/KJizsR363fFGVXao/nbAySZhXnekk6KUnnS1RoxQCn2TQnuQ+p3sjio6dumDf0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712178154; c=relaxed/simple;
	bh=Ka5S/o+PuGXyYozTDCBhkrVTP/HWO8pnb/sg7I29qMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrnI1OMPCUjb9paKZZKpSrEVrnq3azvu+lzHv00uZP746tBm64Iiiz2oYS06l/rqp9haN8u0AzPoR0d4AWQ5v8P9RTJw2UhAFQSlXMHrV0XRqHrBepYEhyukkrRsyiev+9iAZCYET2MGD5acVzj0mkWE1pqVtMEv2vF5+adfXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pyqIxHKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776C5C43390;
	Wed,  3 Apr 2024 21:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712178153;
	bh=Ka5S/o+PuGXyYozTDCBhkrVTP/HWO8pnb/sg7I29qMg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pyqIxHKFIrJmnwzJixTb2gwdLbGae7ctqEU2pSE+3GmE1HMfrTFCKNE2oz7JLigJp
	 XSn+jNUK4BDExZcbmUjbdaqvIlf39WboGln5Dnn0ixqpmGzkxnY9z5Yco05r0z9wC6
	 OA5C1uSVCQbr57fzOLMwB3WgnbIwRqB5eV4Wrn3xacrFiHxgnHBNLfImbQ/eGoZYNo
	 fuwMVmfOued93xgR38LDNysGMjrAbbaFtP8PbNp5sMCS9kU4QJdU4O8/vbvebzxm2N
	 5Gfl01ShCY+fGkV8zFEcW4ixD82M7m7nRfjbohTpblkEDj3GAW6FAiiW+zpOkeH+lK
	 r7t61sYgvFAvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 11AA7CE109B; Wed,  3 Apr 2024 14:02:33 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:02:33 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	lkft-triage@lists.linaro.org,
	linux-parisc <linux-parisc@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@surriel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: sh4: parisc: asm/cmpxchg.h:60:24: error: implicit declaration of
 function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
Message-ID: <7357cf3e-0a46-4672-bc8b-ee896ffacb87@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYvUwyf-5yB=xZVAPXrF3C9z==7bbhDYBnX9jdJ1PxzPnQ@mail.gmail.com>
 <20240403135205.7673001add2216e63db02d1e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403135205.7673001add2216e63db02d1e@linux-foundation.org>

On Wed, Apr 03, 2024 at 01:52:05PM -0700, Andrew Morton wrote:
> On Wed, 3 Apr 2024 13:23:23 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> 
> > The parisc and sh defconfig builds failed due to following build warnings
> > and errors on Linux next-20240402.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > parisc:
> >   build:
> >     * gcc-11-tinyconfig - Failed
> >     * gcc-11-allnoconfig - Failed
> >     * gcc-11-defconfig - Failed
> > 
> > sh:
> >   build:
> >     * gcc-11-defconfig - Failed
> >     * gcc-11-dreamcast_defconfig - Failed
> >     * gcc-11-tinyconfig - Failed
> >     * gcc-11-shx3_defconfig - Failed
> >     * gcc-11-allnoconfig - Failed
> 
> Is this a new failure?  If so, can we please identify a suitable Fixes: target?

This one is already fixed, but I am pulling the offending commits out
of -next for a few days in order to fix some additional casting issues
identified by kernel test robot.

Apologies for the hassle!

							Thanx, Paul

