Return-Path: <linux-kernel+bounces-137278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9187189DFC8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA4A28930D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340313B290;
	Tue,  9 Apr 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNDkcxVr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56296136994;
	Tue,  9 Apr 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678166; cv=none; b=ku2HPV86IptAgc++GWtRJouYYgChOYxbM6J4pqnykh331ho7QlKAHCRgKA7GUcrAHkAzAAhm6ySjpXmZQ67InUUnGDqlTrqUIke9LXu1toWI8zZxd1Sb6JwLk9B+Lpr4hTXgTExkGPWiR5Qk4DnUzhhGG7LQkQ5Sv6zC8Lgg5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678166; c=relaxed/simple;
	bh=Byy7lFyOUCfqUTlTl6jtNWrd2XJGPDpCusSeZip+XgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhMoL+ZKxqYS2uP5h+jfgSWBJ5/wgCvtIjT628xKWJYn+pdcTWm1AOaMhWkA4LV+Ln1cUKuPC4LvEcYu+BHljPj6HYROdEkm6mTgb3sY/QACNO5RXcfxj/+SfCMSUmrKUGtd68TuOIiyrFgcFr6JwL3QIPKH+P+DB7NgSlZBg0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNDkcxVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC947C433F1;
	Tue,  9 Apr 2024 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712678166;
	bh=Byy7lFyOUCfqUTlTl6jtNWrd2XJGPDpCusSeZip+XgI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qNDkcxVruz1gzOyFcj5hJkmuoxp78rCudDxx9bAHvKtAxV7LiF+J5rXecptBiUK7v
	 pLf0TlewiKFi9BGw/sakBuHdDVfHz6PJXbaqF0G7d2ZFb+SFS6ilN9ONKBD57yJrXC
	 ucPJKCWKZ+zy5XawRBrBCpGxOQpxsO2O9qtJ7Y32MXktdEtDWJE+jCU4O6W29pJ8zV
	 falnJcDfHEGXTjj6q4if+tjY0u9xuymS2Qz8wfXEph9z7h1c42/pWtnhVFR6sqRBwG
	 GFPBOUi/0gfa+62i4cSKI52v9oVlKi6dNTV8dcj2830hnpHjBT/dIjN1vkroh4RJSS
	 uFnnBttFDXoZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8BE40CE2D22; Tue,  9 Apr 2024 08:56:05 -0700 (PDT)
Date: Tue, 9 Apr 2024 08:56:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2024.04.04b 59/65] controller.c:undefined
 reference to `cmpxchg_emu_u8'
Message-ID: <69d190ae-32c8-4064-b064-358acc2fa7c6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202404091402.CYa0g4R6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404091402.CYa0g4R6-lkp@intel.com>

On Tue, Apr 09, 2024 at 02:44:49PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.04.04b
> head:   e2a520f3f3921cb5d3c9631917fccf8c215991ce
> commit: 5ce37a62e3d207bd20d4c850c4547816c0dd9c22 [59/65] EXP arch/x86: Test one-byte cmpxchg emulation
> config: i386-buildonly-randconfig-006-20240409 (https://download.01.org/0day-ci/archive/20240409/202404091402.CYa0g4R6-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240409/202404091402.CYa0g4R6-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404091402.CYa0g4R6-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: drivers/platform/surface/aggregator/controller.o: in function `ssam_request_write_data':
> >> controller.c:(.text+0xcdf): undefined reference to `cmpxchg_emu_u8'

I believe that this is fixed in this updated version:

b8eb8a06afe1 ("EXP arch/x86: Test one-byte cmpxchg emulation")

But please let me know if I am missing something here.

							Thanx, Paul

