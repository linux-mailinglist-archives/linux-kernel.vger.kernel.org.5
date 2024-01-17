Return-Path: <linux-kernel+bounces-28399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138CC82FE13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80D9B24DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 00:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA48D522D;
	Wed, 17 Jan 2024 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXxgvPL9"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBC4685;
	Wed, 17 Jan 2024 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705452408; cv=none; b=kL0M8Fwe44+bDNWuiVUL8jTBQ9HMQxqZVBF5bEFw1HUWKAKXPOyk82PZdJg0ximRTZd8tTb2J9zZ8Rq0+NaDwEmBQi9rqKtTEcwzUgzt84ag7afycxJnxmeUAOfg4/AG64as57qr6l+xMUh5M1iIuFjtKr0F4K349XLx1uUMaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705452408; c=relaxed/simple;
	bh=Rp5Mh0IN5g+mXkkdBQo6SGc/Tl24YpwvDJVIMMPS0jw=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KFQVjknxYY1prNYmt8TVLeL3dFuw9PUw5exb7nKEqo0re6pHEq4xl0e8Zl8q69XBd9WtK5A0ZD3NNdsy4FWYJWWrswMEunai/LRBx11X0q3zcqpmzPvMeGJQ0bgKJjuYHKvu51kj7e7v8J8t+AOINuoWsiZcUVNOA1mtzjGC7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXxgvPL9; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705452406; x=1736988406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rp5Mh0IN5g+mXkkdBQo6SGc/Tl24YpwvDJVIMMPS0jw=;
  b=FXxgvPL9XBXnmEt5hthUtiDFlZ3kyz3+DAlJgLpODtVer/GD/ePpyQ7h
   fNggDSXY0YnDTOeDLnNguJ+vmUhGZTx5vrEyeQMaC1rKpdgu3K0JeEOF6
   StZWFtpcMvksuBf8irz6/rS73c9mMBCE4ubejfpeducI1rmuU3kxSITZH
   Wp3jojgij/2LRwgMh9VSQmij94ManLZBT8PpfawqqFN4gVnlNF4x/KW7Y
   safk2abpuMhE8jQx7FHS8aW+pZh2pPP0j3OI4iD/g+2YldYEOGrHmE3Ns
   zwsiSB6vyMChhLKWbi4Txcy5Cemfa8KYS7wzxFGzJ4jFdVYOrbiioCwQq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="399701073"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="399701073"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 16:46:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="760373669"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="760373669"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2024 16:46:37 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPu4h-0001Pg-0f;
	Wed, 17 Jan 2024 00:46:35 +0000
Date: Wed, 17 Jan 2024 08:45:38 +0800
From: kernel test robot <lkp@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, 675146817@qq.com,
	story_19872006@126.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, seanjc@google.com, kim.phillips@amd.com,
	kirill.shutemov@linux.intel.com, jmattson@google.com,
	babu.moger@amd.com, kai.huang@intel.com, acme@redhat.com,
	aik@amd.com, namhyung@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
	LeoLiu-oc@zhaoxin.com, GeorgeXue@zhaoxin.com
Subject: Re: [PATCH 3/3] crypto: Zhaoxin: Hardware Engine Driver for
 SHA1/256/384/512
Message-ID: <202401170833.HWvPThMS-lkp@intel.com>
References: <20240116063549.3016-4-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116063549.3016-4-TonyWWang-oc@zhaoxin.com>

Hi Tony,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on tip/x86/core linus/master v6.7 next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-W-Wang-oc/crypto-padlock-sha-Matches-CPU-with-Family-with-6-explicitly/20240116-144827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20240116063549.3016-4-TonyWWang-oc%40zhaoxin.com
patch subject: [PATCH 3/3] crypto: Zhaoxin: Hardware Engine Driver for SHA1/256/384/512
config: hexagon-randconfig-r071-20240117 (https://download.01.org/0day-ci/archive/20240117/202401170833.HWvPThMS-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240117/202401170833.HWvPThMS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170833.HWvPThMS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/crypto/zhaoxin-sha.c:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/crypto/zhaoxin-sha.c:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/crypto/zhaoxin-sha.c:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/crypto/zhaoxin-sha.c:20:10: fatal error: 'asm/cpu_device_id.h' file not found
   #include <asm/cpu_device_id.h>
            ^~~~~~~~~~~~~~~~~~~~~
   6 warnings and 1 error generated.


vim +20 drivers/crypto/zhaoxin-sha.c

  > 20	#include <asm/cpu_device_id.h>
    21	#include <asm/fpu/api.h>
    22	#include "zhaoxin-sha.h"
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

