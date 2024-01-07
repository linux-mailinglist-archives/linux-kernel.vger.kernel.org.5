Return-Path: <linux-kernel+bounces-18753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721682628E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226B81C21040
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45FD17D8;
	Sun,  7 Jan 2024 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1o1rEaA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A802136F;
	Sun,  7 Jan 2024 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704589608; x=1736125608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BL/G2+DBgzyngkKxm1Okb/HyxO0E8Sb22Xv27tX30GE=;
  b=G1o1rEaAoiTz68/7FW5P5J7DYZpaV0UgiJ+Rj9kfnj8HAYm1exHQRC95
   R4LwBQ/XJV7W7nmUg0qIM5Hl9kwLzFc+HpugpNtvhXfDI94H/Q8YGla4Q
   sCeMvJZDfxgFTPIiKwZz451pJq1J2/FQaLnBJcHrJHZtyynmx5OC5Xv9E
   Q07sZ0h7fbI3ObEw8TsJjb2jN/dsQtk52OISKFr3Wo1U4Km+v7quytg6y
   /1qaTH0RfqNnp9NQgQpMZ9V08zCAjetyLYL7+4J5T4XGXQ+TXupUqn8i4
   BiJQLRd79IubFNY3/EXRRZQ/87/hmbHTIYs/YA9Gg2xoJiGt4WSiU5IgD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="382661489"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="382661489"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 17:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="899999269"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="899999269"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2024 17:06:42 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMHce-0003EK-0f;
	Sun, 07 Jan 2024 01:06:40 +0000
Date: Sun, 7 Jan 2024 09:06:33 +0800
From: kernel test robot <lkp@intel.com>
To: WANG Rui <wangrui@loongson.cn>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, WANG Xuerui <kernel@xen0n.name>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn, WANG Rui <wangrui@loongson.cn>
Subject: Re: [PATCH] LoongArch: Enable initial Rust support
Message-ID: <202401070815.6tdJWFme-lkp@intel.com>
References: <20240106065941.180796-1-wangrui@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106065941.180796-1-wangrui@loongson.cn>

Hi WANG,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rust/rust-next]
[also build test WARNING on linus/master v6.7-rc8 next-20240105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/WANG-Rui/LoongArch-Enable-initial-Rust-support/20240106-150902
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20240106065941.180796-1-wangrui%40loongson.cn
patch subject: [PATCH] LoongArch: Enable initial Rust support
reproduce: (https://download.01.org/0day-ci/archive/20240107/202401070815.6tdJWFme-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070815.6tdJWFme-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/rust/arch-support.rst:18: WARNING: Malformed table.

vim +18 Documentation/rust/arch-support.rst

    14	
    15	============  ================  ==============================================
    16	Architecture  Level of support  Constraints
    17	============  ================  ==============================================
  > 18	``loongarch`` Maintained

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

