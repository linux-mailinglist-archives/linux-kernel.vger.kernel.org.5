Return-Path: <linux-kernel+bounces-25007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB9E82C5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3122F1C22866
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754A315E98;
	Fri, 12 Jan 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuPybr1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89912E79;
	Fri, 12 Jan 2024 19:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD828C433C7;
	Fri, 12 Jan 2024 19:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705088851;
	bh=fBzDLyIQ3fJTBbDm/TFgka0PJn37SFZfnksvNccdxT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GuPybr1DRD5IZro77uF8wImnf7qdSA6HfGJfWz625mjHTw/yj8rOSEECsZmp9KsTD
	 WTT/zsTa4CmqvKmdyfBaeNc048umOV7GEhgvdtBzG1j9dAy7+2uVx3PfEI+LBplIg4
	 zbxyxH9tddFRy2rkSGLLjM2AJc3ho35l+06s1JTHx6PqI7CbQKA2gqCqH4sEwTf/wa
	 YdTlqNLpWaUEB4V1sVhfZwuYmMW/E3FC/OriEff50Ln1DYKTtxFqdrqBSTh3v4MDJT
	 uudxmIPaHsYoh9YOjIusdIoT5ZNOHRJJ1vXf0WR60NQPVclYvWrvMYelGibczD1sGw
	 yNwTf/s+nv2DA==
Date: Fri, 12 Jan 2024 12:47:29 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Vlad Buslov <vladbu@nvidia.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Maor Dickman <maord@nvidia.com>,
	Roi Dayan <roid@nvidia.com>, masahiroy@kernel.org
Subject: Re: drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c:1833:4:
 warning: 'snprintf' will always be truncated; specified size is 80, but
 format string expands to at least 94
Message-ID: <20240112194729.GB3703896@dev-arch.thelio-3990X>
References: <202401102205.XmxWrS5y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401102205.XmxWrS5y-lkp@intel.com>

On Wed, Jan 10, 2024 at 10:55:22PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
> commit: 70f0302b3f2053b64a6a653a76a20cb95438dc85 net/mlx5: Bridge, implement mdb offload
> date:   9 months ago
> config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240110/202401102205.XmxWrS5y-lkp@intel.com/config)
> compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 7e186d366d6c7def0543acc255931f617e76dff0)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401102205.XmxWrS5y-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401102205.XmxWrS5y-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c:1833:4: warning: 'snprintf' will always be truncated; specified size is 80, but format string expands to at least 94 [-Wformat-truncation-non-kprintf]
>     1833 |                         NL_SET_ERR_MSG_FMT_MOD(extack,
>          |                         ^
>    include/linux/netlink.h:130:2: note: expanded from macro 'NL_SET_ERR_MSG_FMT_MOD'
>      130 |         NL_SET_ERR_MSG_FMT((extack), KBUILD_MODNAME ": " fmt, ##args)
>          |         ^
>    include/linux/netlink.h:115:6: note: expanded from macro 'NL_SET_ERR_MSG_FMT'
>      115 |         if (snprintf(__extack->_msg_buf, NETLINK_MAX_FMTMSG_LEN,               \
>          |             ^
>    1 warning generated.

I have not looked to see if this is a legitimate issue or not, as clang
does not understand the kernel's special %p modifiers, so it is a little
hard to tell at first glance. For this reason, I sent a patch turning
off the -non-kprintf warnings but it has not been picked up yet:

https://lore.kernel.org/20231002-disable-wformat-truncation-overflow-non-kprintf-v1-1-35179205c8d9@kernel.org/

Cheers,
Nathan

