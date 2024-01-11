Return-Path: <linux-kernel+bounces-23354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448582AB80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28E71F22149
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87312E56;
	Thu, 11 Jan 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UniYFP67"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107D12E47;
	Thu, 11 Jan 2024 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704967348; x=1736503348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aq7/NBSBsP1a6bhCozJ0konwlEKNIZaN14AkP6FPIOI=;
  b=UniYFP67RWvJa4DGpyOhDB3JuPOVyFZftxGtmvA4HVSARw8PB23Q0r3/
   TkpGmiPVL1LsX/KMPH+YBsBhmVv6N89LMSquSn954NG7bHudVKLjX4VTG
   OZdOq+hctFYRCoaNgH9q315YpxqzF80sC0/MboNwON2N4pp8RbpwztPWJ
   mLvU4C2O6N4sCbpO7sPF2bvXof/lpp/iZU6LGtB6rBYwYvMrORPSkHqle
   9Re2dIZ8pDmqoEk69npFTBGPdvEkRyinpgpdX9AJ/L5TyeIjrFmbqCOiJ
   ga/PtvHixuZs+mCslpkJBurkxXRiVkBcD1wPBQ1fd2NbFZvfGd/+Ce6z1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12157120"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="12157120"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 02:02:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="905898121"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="905898121"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Jan 2024 02:02:23 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNrtE-00086m-21;
	Thu, 11 Jan 2024 10:02:20 +0000
Date: Thu, 11 Jan 2024 18:01:43 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, robh@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	jirislaby@kernel.org, joe@perches.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	zbigniew.lukwinski@linux.intel.com, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 4/7] i3c: target: add svc target controller support
Message-ID: <202401111724.LiPgx2yU-lkp@intel.com>
References: <20240110175221.2335480-5-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110175221.2335480-5-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus robh/for-next linus/master v6.7 next-20240111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-add-target-mode-support/20240111-015711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240110175221.2335480-5-Frank.Li%40nxp.com
patch subject: [PATCH v2 4/7] i3c: target: add svc target controller support
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240111/202401111724.LiPgx2yU-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 9bde5becb44ea071f5e1fa1f5d4071dc8788b18c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240111/202401111724.LiPgx2yU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401111724.LiPgx2yU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:1084:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:186:1: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     186 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:176:10: note: expanded from macro '_SIG_SET_OP'
     176 |         case 2: set->sig[1] = op(set->sig[1]);                          \
         |                 ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/i3c/target/svc-i3c-target.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:1084:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:197:10: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     197 |         case 2: set->sig[1] = 0;
         |                 ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/i3c/target/svc-i3c-target.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:1084:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:210:10: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     210 |         case 2: set->sig[1] = -1;
         |                 ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/i3c/target/svc-i3c-target.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:1084:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:241:10: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     241 |         case 2: set->sig[1] = 0;
         |                 ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/i3c/target/svc-i3c-target.c:14:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:1084:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:254:10: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     254 |         case 2: set->sig[1] = -1;
         |                 ^        ~
   arch/powerpc/include/uapi/asm/signal.h:18:2: note: array 'sig' declared here
      18 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   drivers/i3c/target/svc-i3c-target.c:211:40: warning: no previous prototype for function 'svc_i3c_get_features' [-Wmissing-prototypes]
     211 | const struct i3c_target_ctrl_features *svc_i3c_get_features(struct i3c_target_ctrl *ctrl)
         |                                        ^
   drivers/i3c/target/svc-i3c-target.c:211:7: note: declare 'static' if the function is not intended to be used outside of this translation unit
     211 | const struct i3c_target_ctrl_features *svc_i3c_get_features(struct i3c_target_ctrl *ctrl)
         |       ^
         | static 
>> drivers/i3c/target/svc-i3c-target.c:268:63: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]
     268 | static int svc_i3c_target_queue(struct i3c_request *req, gfp_t)
         |                                                               ^
   drivers/i3c/target/svc-i3c-target.c:666:5: warning: no previous prototype for function 'svc_i3c_fifo_status' [-Wmissing-prototypes]
     666 | int svc_i3c_fifo_status(struct i3c_target_ctrl *ctrl, bool tx)
         |     ^
   drivers/i3c/target/svc-i3c-target.c:666:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     666 | int svc_i3c_fifo_status(struct i3c_target_ctrl *ctrl, bool tx)
         | ^
         | static 
   52 warnings and 5 errors generated.


vim +268 drivers/i3c/target/svc-i3c-target.c

   267	
 > 268	static int svc_i3c_target_queue(struct i3c_request *req, gfp_t)
   269	{
   270		struct svc_i3c_target *svc;
   271		struct list_head *q;
   272		unsigned long flags;
   273		spinlock_t *lk;
   274	
   275		svc = dev_get_drvdata(&req->ctrl->dev);
   276		if (!svc)
   277			return -EINVAL;
   278	
   279		if (req->tx) {
   280			q = &svc->txq;
   281			lk = &svc->txq_lock;
   282		} else {
   283			q = &svc->rxq;
   284			lk = &svc->rxq_lock;
   285		}
   286	
   287		spin_lock_irqsave(lk, flags);
   288		list_add_tail(&req->list, q);
   289		spin_unlock_irqrestore(lk, flags);
   290	
   291		if (req->tx)
   292			svc_i3c_fill_txfifo(svc);
   293	
   294		if (req->tx)
   295			writel_relaxed(I3C_SINT_TXSEND, svc->regs + I3C_SINTSET);
   296		else
   297			writel_relaxed(I3C_SINT_RXPEND, svc->regs + I3C_SINTSET);
   298	
   299		return 0;
   300	}
   301	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

