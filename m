Return-Path: <linux-kernel+bounces-137283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F2189DFE5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB4728367A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA55137937;
	Tue,  9 Apr 2024 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCr/P827"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CBF135A6C;
	Tue,  9 Apr 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678405; cv=none; b=JkWvu49cs5TSiJJ3YRgaNqcykTow80Vo08cQxBUbd0rg2sNnhzWS5QvJ+2/8hD7ViHV5JaxqFwyTcODidR4Meok0S/8GcHnvklZ/XbA36McV7WVBmDHJ0/QAZU7tHRoaACYD+yP8YNYl9WntcpxngJqJ39FS08YIiJErEDmWj0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678405; c=relaxed/simple;
	bh=Imb3C4vpp1D0w3rjX86j5aQFa1wiZZ4Mney1e/DlfPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=podVTy5nsUOQMeooiFyPxUl1n6paop+MVB8wbK3NnmC4xs9dmN4+jC5or5tc4tpazCWF6Aj6vjPGd9p9DZyhMFDAj9lULVU9jaKp7CQN/tBr5Gi1egI6A5S1BBzDhC1YFUeQZAvjn8I7vHaDQsTJ4J2wrv3roGDhYh0kUgXfZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCr/P827; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC1BC433C7;
	Tue,  9 Apr 2024 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712678404;
	bh=Imb3C4vpp1D0w3rjX86j5aQFa1wiZZ4Mney1e/DlfPg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CCr/P827b4dfsdZsCyYGTzQePrrEMBjvGijOUuXPgUvVwUfIHglPWUfMXahZTJMDc
	 3z2qn+QczQb6NMSa/UsN6EradUXPBD5i+9L5NOQVfbXd4bnAc039UO+xpjRjMdOk8y
	 vPTQkbvLEV9Ged3WPv3V77m/ca40lZ/NUNuei+CJYT0m9chJQCnTZ4E2OaDEmox1XO
	 fkHVj3YkggF4Hj5rnfnEzygVMi+8dcE3OC/L5yJsBYVYJnMHz08Z8H1r+UfszNJc6S
	 468Az/QvH4+lUF4MNx2QDp4Se3p54/iS1n32fYHyInGCcZT7X1L15qAOkqkTADvLTi
	 dq/e6l7D2MLWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 42410CE2D22; Tue,  9 Apr 2024 09:00:04 -0700 (PDT)
Date: Tue, 9 Apr 2024 09:00:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2024.04.04b 59/65] controller.c:undefined
 reference to `cmpxchg_emu_u8'
Message-ID: <1e4d7011-7dda-4384-96d5-2eedcf9383fd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202404091402.CYa0g4R6-lkp@intel.com>
 <69d190ae-32c8-4064-b064-358acc2fa7c6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d190ae-32c8-4064-b064-358acc2fa7c6@paulmck-laptop>

On Tue, Apr 09, 2024 at 08:56:05AM -0700, Paul E. McKenney wrote:
> On Tue, Apr 09, 2024 at 02:44:49PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.04b
> > head:   e2a520f3f3921cb5d3c9631917fccf8c215991ce
> > commit: 5ce37a62e3d207bd20d4c850c4547816c0dd9c22 [59/65] EXP arch/x86: Test one-byte cmpxchg emulation
> > config: i386-buildonly-randconfig-006-20240409 (https://download.01.org/0day-ci/archive/20240409/202404091402.CYa0g4R6-lkp@intel.com/config)
> > compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404091402.CYa0g4R6-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202404091402.CYa0g4R6-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    ld: drivers/platform/surface/aggregator/controller.o: in function `ssam_request_write_data':
> > >> controller.c:(.text+0xcdf): undefined reference to `cmpxchg_emu_u8'
> 
> I believe that this is fixed in this updated version:
> 
> b8eb8a06afe1 ("EXP arch/x86: Test one-byte cmpxchg emulation")
> 
> But please let me know if I am missing something here.

OK, what I am missing is my failure to have changed ARCH_NEED_CMPXCHG_1_2_EMU
to ARCH_NEED_CMPXCHG_1_EMU.  On it!  And yet again, thank you for your testing
efforts.

							Thanx, Paul

