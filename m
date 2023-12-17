Return-Path: <linux-kernel+bounces-2698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6866B8160AF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1DDBB21A96
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DF045C06;
	Sun, 17 Dec 2023 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TVaplFky"
X-Original-To: linux-kernel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FBD45BF2
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1702833228;
	bh=vYfmc45KYCbJHfbcfljMiiQm/2uzx3kXTBBzeDQ8pLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TVaplFkykiavfcSje7TzPfx9BxhVZzW+FsEed+rurUhtlKG87qUsssTq3wkqxAn7M
	 tdpCPTKui1DkayL7alTCdblhA0Q4tvfWeNen5LPnUP4ee6+XMY1MKpGkHFd6cFESDi
	 NUYDdkCu92yffWlhEoPQMs2FpkASvBcfp2FQNQd0=
Date: Sun, 17 Dec 2023 18:13:48 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>
Subject: Re: include/linux/compiler_types.h:397:45: error: call to
 '__compiletime_assert_810' declared with attribute error: BUILD_BUG_ON
 failed: skb_ext_total_length() > 255
Message-ID: <3fb66648-5581-4371-b15e-23e52e6469ba@t-8ch.de>
References: <202312171924.4FozI5FG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202312171924.4FozI5FG-lkp@intel.com>

+Cc Arnd who was taking care of CFLAGS_GCOV in the past.

On 2023-12-17 19:39:34+0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
> commit: 5d21d0a65b573507bae774708199328b38dedfe6 net: generalize calculation of skb extensions length
> date:   4 months ago
> config: um-randconfig-r025-20230617 (https://download.01.org/0day-ci/archive/20231217/202312171924.4FozI5FG-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312171924.4FozI5FG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312171924.4FozI5FG-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from <command-line>:
>    In function 'skb_extensions_init',
>        inlined from 'skb_init' at net/core/skbuff.c:4848:2:
> >> include/linux/compiler_types.h:397:45: error: call to '__compiletime_assert_810' declared with attribute error: BUILD_BUG_ON failed: skb_ext_total_length() > 255
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |                                             ^
>    include/linux/compiler_types.h:378:25: note: in definition of macro '__compiletime_assert'
>      378 |                         prefix ## suffix();                             \
>          |                         ^~~~~~
>    include/linux/compiler_types.h:397:9: note: in expansion of macro '_compiletime_assert'
>      397 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^~~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^~~~~~~~~~~~~~~~~~
>    include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^~~~~~~~~~~~~~~~
>    net/core/skbuff.c:4800:9: note: in expansion of macro 'BUILD_BUG_ON'
>     4800 |         BUILD_BUG_ON(skb_ext_total_length() > 255);
>          |         ^~~~~~~~~~~~

[..]

This seems to be a compiler bug/configuration issue.

When I remove the entry for SKB_EXT_MCTP from skb_ext_type_len then the
error goes away. However this entry works the same as all other entries.

Also dropping -fno-tree-loop-im *or* -fprofile-arcs from CFLAGS_GCOV
makes the code compile as-is.

Or switching to a 64bit build...


Thomas

