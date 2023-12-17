Return-Path: <linux-kernel+bounces-2419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A2815CD7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC99A1F22265
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7EAA47;
	Sun, 17 Dec 2023 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdIMY0fm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60D7FE
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 00:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702773369; x=1734309369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sPRa6vdVIDAJ1/JjN1gkVqYUrglicfMoN5VWWI5vpDM=;
  b=BdIMY0fmNpj4dVJJvXpf616Ice4yjd74tfujmqR1odZeHHnSTAyWz1CE
   YGrdWyCkoDbBEfWwSuVuQjDYrujI50brHGbXjhSSaM5EZT2QhJQ6G6Mp0
   lWNVv6sSD8DRtgu7z1yhNC0jXmZT9rfMsp0tQzxYVdzKR8olteDcIxh+Y
   LTRHm34rCB7gr7UpcMZTplkccPj2SbPcKCroTRKFoHXM2zc0IIn/imyHg
   5/nj4okxikZr4LW7uN4WKgZiPlX/kbSEfCkU2XaxYprqvSquMe1C6OxjK
   2OSmnH9jehtYQmCoFQ/kNUZNeKS+JkygP9KQ0b6+0CM4a1UIuh6ocaA7h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="426525732"
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="426525732"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 16:36:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,282,1695711600"; 
   d="scan'208";a="23289680"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 16 Dec 2023 16:36:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEf8W-0002OU-18;
	Sun, 17 Dec 2023 00:36:04 +0000
Date: Sun, 17 Dec 2023 08:35:24 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Subject: scripts/kernel-doc: net/ipv4/udp_tunnel_nic.c:51: warning: Excess
 struct member 'entries' description in 'udp_tunnel_nic'
Message-ID: <202312170808.AQ2gRuVU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b8a9b2e6809d281890dd0a1102dc14d2cd11caf
commit: ef35bed6fad6eda8de0277eda77803c748f306d1 udp_tunnel: Use flex array to simplify code
date:   3 months ago
config: m68k-sun3x_defconfig (https://download.01.org/0day-ci/archive/20231217/202312170808.AQ2gRuVU-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231217/202312170808.AQ2gRuVU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312170808.AQ2gRuVU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: net/ipv4/udp_tunnel_nic.c:51: warning: Excess struct member 'entries' description in 'udp_tunnel_nic'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

