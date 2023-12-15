Return-Path: <linux-kernel+bounces-1330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FF6814D80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E269F2844E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE633DBB7;
	Fri, 15 Dec 2023 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIj1LEp/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC43EA82
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702659003; x=1734195003;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vgZwlm3sVDXUzqdaqyONYJEGMEvvDJOC9JOXTv866Bc=;
  b=KIj1LEp/0cxBm3Lwm8OP3as5cOMPEy4KRMqOzUQTzx+w6RKrUeXJC0vM
   5uh9zgJOPZ6PSZIsZnXIJJLKMDgG35DfRml2PtpEVR6BF0grhoSHyZRpe
   g+JeXQhEXqt9GesMW/JsiiFYDyNDK+gyzwzR0Js+PHN7Zia8b+CUMK1Av
   rTEpkbeiLMCl0w90H3JTqj3tUJsCwm46PCeacqnj1Q/9NhQcqnJdJCA6a
   kbrj5yhW7174GPg03muK/gQRrBSb0wPv6f+rqQEDKd3YfKZD/nHO1a/AB
   mk06IQP+T/MGOKGDaHs0deIOruw1ZdsRzmdAB4u4FBKv4WNuHneN0sQcv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2468772"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2468772"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 08:49:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="768040193"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="768040193"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2023 08:49:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEBNi-0000Tw-0i;
	Fri, 15 Dec 2023 16:49:46 +0000
Date: Sat, 16 Dec 2023 00:48:48 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: scripts/kernel-doc: kernel/gcov/fs.c:103: warning: Excess struct
 member 'buffer' description in 'gcov_iterator'
Message-ID: <202312160030.CV8MHmM8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f7168591ebf7bbdb91797d02b1afaf00a4289b1
commit: fbd126f5a658b92c7f6af986a6d89cf5e5693268 gcov: annotate struct gcov_iterator with __counted_by
date:   8 weeks ago
config: arm-randconfig-002-20231215 (https://download.01.org/0day-ci/archive/20231216/202312160030.CV8MHmM8-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231216/202312160030.CV8MHmM8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160030.CV8MHmM8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> scripts/kernel-doc: kernel/gcov/fs.c:103: warning: Excess struct member 'buffer' description in 'gcov_iterator'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

