Return-Path: <linux-kernel+bounces-159465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CB8B2EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE61F230A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3D176C76;
	Fri, 26 Apr 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ0HtMw9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEFA762EF;
	Fri, 26 Apr 2024 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102228; cv=none; b=GDNP/kLw9GxSfOqzhPohwnsov16XxNydC2d2lHatyevQZwE6/wiBF52niQNfCxw7+UzFcZO1sbiz4SiaTk9tCvzvJGskIj+reyc8SpSVCzcdI6lqUFySy6tAlsDjnl1I3IK64S5X55uKqO3fifC6Kouq6vAdqfwtfjQJk6CVTmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102228; c=relaxed/simple;
	bh=EdgVL+mjeevOY833THEkV8ftpwKHklYo0/miJTIw3KQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nr5A0G0ar5lvqAir5GOrSzpTvJGGdtsT+JSQUjnMrm7ndau1jSMMxs3nwrUmQlkRl4qVaPrEv7enEyRTKywOXkbCf+9WiPMm/jDKx1Zl3L1Uy9n9gZm+SKJNUnd1OAHj9nPr1ldN21+2R3aZQE6CBo3bf7wkjbiAOIXwYXOg3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ0HtMw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13C99C2BD11;
	Fri, 26 Apr 2024 03:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714102228;
	bh=EdgVL+mjeevOY833THEkV8ftpwKHklYo0/miJTIw3KQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mZ0HtMw9qHyNqgn5EB/WWtrssN6O887nOeLt4cDOOborhaSqhSA0s74YIjFOlMw/O
	 voSjMh7bhhqgi7798goJKgWFo/rjO/u0dGqHmKCQYaYhF6wRnFYOFSqGUtNlCY8syV
	 XLayyNPSNLJyVQ4a+9Qv24qYO3qF/XfWakilaVK4EAu/YEjDTfZzmO7gBvekGfr/6d
	 UjMbs5MILVQ6cdZpy6fnAgPsFlLrKIEf2KNzSrPQ6lGU5EehnpB3jPL8y9qrSD2kFn
	 aqInyb7KNnjVBBekJ316yj6Oo1VWz6EUQjFLDmS72Uqbbw/Fyb9DQBvOJZhGsYJZ3K
	 XsRsPn2wi2/+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEEBFC595D2;
	Fri, 26 Apr 2024 03:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v11 00/10][pull request] net: intel: start The Great
 Code Dedup + Page Pool for iavf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171410222797.8197.8566659158199091850.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 03:30:27 +0000
References: <20240424203559.3420468-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240424203559.3420468-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, hawk@kernel.org,
 linux-mm@kvack.org, przemyslaw.kitszel@intel.com, alexanderduyck@fb.com,
 ilias.apalodimas@linaro.org, linux-kernel@vger.kernel.org,
 aleksander.lobakin@intel.com, linyunsheng@huawei.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, cl@linux.com,
 akpm@linux-foundation.org, vbabka@suse.cz

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed, 24 Apr 2024 13:35:47 -0700 you wrote:
> Alexander Lobakin says:
> 
> Here's a two-shot: introduce {,Intel} Ethernet common library (libeth and
> libie) and switch iavf to Page Pool. Details are in the commit messages;
> here's a summary:
> 
> Not a secret there's a ton of code duplication between two and more Intel
> ethernet modules. Before introducing new changes, which would need to be
> copied over again, start decoupling the already existing duplicate
> functionality into a new module, which will be shared between several
> Intel Ethernet drivers. The first name that came to my mind was
> "libie" -- "Intel Ethernet common library". Also this sounds like
> "lovelie" (-> one word, no "lib I E" pls) and can be expanded as
> "lib Internet Explorer" :P
> The "generic", pure-software part is placed separately, so that it can be
> easily reused in any driver by any vendor without linking to the Intel
> pre-200G guts. In a few words, it's something any modern driver does the
> same way, but nobody moved it level up (yet).
> The series is only the beginning. From now on, adding every new feature
> or doing any good driver refactoring will remove much more lines than add
> for quite some time. There's a basic roadmap with some deduplications
> planned already, not speaking of that touching every line now asks:
> "can I share this?". The final destination is very ambitious: have only
> one unified driver for at least i40e, ice, iavf, and idpf with a struct
> ops for each generation. That's never gonna happen, right? But you still
> can at least try.
> PP conversion for iavf lands within the same series as these two are tied
> closely. libie will support Page Pool model only, so that a driver can't
> use much of the lib until it's converted. iavf is only the example, the
> rest will eventually be converted soon on a per-driver basis. That is
> when it gets really interesting. Stay tech.
> 
> [...]

Here is the summary with links:
  - [net-next,v11,01/10] net: intel: introduce {, Intel} Ethernet common library
    https://git.kernel.org/netdev/net-next/c/306ec721d043
  - [net-next,v11,02/10] iavf: kill "legacy-rx" for good
    https://git.kernel.org/netdev/net-next/c/53844673d555
  - [net-next,v11,03/10] iavf: drop page splitting and recycling
    https://git.kernel.org/netdev/net-next/c/920d86f3c552
  - [net-next,v11,04/10] slab: introduce kvmalloc_array_node() and kvcalloc_node()
    https://git.kernel.org/netdev/net-next/c/a1d6063d9f2f
  - [net-next,v11,05/10] page_pool: constify some read-only function arguments
    https://git.kernel.org/netdev/net-next/c/ef9226cd56b7
  - [net-next,v11,06/10] page_pool: add DMA-sync-for-CPU inline helper
    https://git.kernel.org/netdev/net-next/c/ce230f4f8981
  - [net-next,v11,07/10] libeth: add Rx buffer management
    https://git.kernel.org/netdev/net-next/c/e6c91556b97f
  - [net-next,v11,08/10] iavf: pack iavf_ring more efficiently
    https://git.kernel.org/netdev/net-next/c/97cadd3d3ce3
  - [net-next,v11,09/10] iavf: switch to Page Pool
    https://git.kernel.org/netdev/net-next/c/5fa4caff59f2
  - [net-next,v11,10/10] MAINTAINERS: add entry for libeth and libie
    https://git.kernel.org/netdev/net-next/c/87a927efa7d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



