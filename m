Return-Path: <linux-kernel+bounces-24989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4810682C5B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4341C211A1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5D15AD9;
	Fri, 12 Jan 2024 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLAlPj/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5340115ACF;
	Fri, 12 Jan 2024 19:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A69C433F1;
	Fri, 12 Jan 2024 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705086145;
	bh=vav1G08pPczQLUs4pxX2No1Ea4YTbm5dWQe4xJVOXOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLAlPj/4qjA307LcTTzky+FHpjArA3w68HL2Qg1Vgm/xwOsvhh/JcLIkK5Jv1DWTI
	 I1SG3CrlfKtsAKyQj+aJ5PNFu4nbAFt3n7y/xvZD1omqDFbyojq7nqwZgBy6gSgzl4
	 HKNTV812YCbLZjxjWiKsr7RPgb9jD7RVVbo+KEYi3iUMousLLfXKingGAT3QPA6tyJ
	 GXnnudkV2UcxcuMHO+r0f7db73XFcPjZoIxpWZDsIgOJNf5VsYjGv274SyGTGR2uos
	 9hO3rdXAbbeVQ/feXDUPAH9H5qVWu7OfQTngcXsWV4e2DHkhu6dQZNBEwdrXGF/Gro
	 LrH3Rum39n94A==
From: SeongJae Park <sj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: SeongJae Park <sjpark@amazon.de>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>
Subject: Re: drivers/xen/xenbus/xenbus_client.c:134: warning: Function parameter or member 'will_handle' not described in 'xenbus_watch_path'
Date: Fri, 12 Jan 2024 11:02:23 -0800
Message-Id: <20240112190223.83762-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202401121154.FI8jDGun-lkp@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Jan 2024 11:41:50 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   22d29f1112c85c1ad519a8c0403f7f7289cf060c
> commit: 2e85d32b1c865bec703ce0c962221a5e955c52c2 xen/xenbus: Add 'will_handle' callback support in xenbus_watch_path()
> date:   3 years, 1 month ago
> config: x86_64-buildonly-randconfig-006-20240105 (https://download.01.org/0day-ci/archive/20240112/202401121154.FI8jDGun-lkp@intel.com/config)
> compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240112/202401121154.FI8jDGun-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401121154.FI8jDGun-lkp@intel.com/

Thank you for the report.  Just sent a fix with above tags:
https://lore.kernel.org/all/20240112185903.83737-1-sj@kernel.org/T/#u


Thanks,
SJ

[...]

