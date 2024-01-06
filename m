Return-Path: <linux-kernel+bounces-18517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C17F825E9B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A451A285267
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 07:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E704426;
	Sat,  6 Jan 2024 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mru3WfyA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651294401
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704524451; x=1736060451;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oYOsT336lCdx3s2dMMdOwe0GtlzeonWspWzGepLwwTA=;
  b=mru3WfyApSbl702DyTjqhNivlyOMaWZygk+TQTpipMG4ZFpz+Vsa6uFy
   keFJwQV4/e0UN1E+q82aJ2XDZkF7Np3kGZ/BtYL24IHefICjp25tdBVFU
   xDCv0UABjDuMlDD/WJfMjqsD7US1+p16gnz78eqt2KupplnihsU66lu3M
   9Vpih/yCUHPEw95JKHtPZ+GI4RxWBxCbDWXPXVRB3pVOM07NQ67dLhL7r
   hboPazvWVfYdqscKJeXG4G2APMDN7gSY7SgT1yNsSQA1jskRMS/LK5zv5
   ZgRTeVKgmj3CkSC5u6g9ES2PzsDh8Qi8Erzp0M3WspiYTCZOLRjxepzY6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="461940257"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="461940257"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 23:00:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="1027952889"
X-IronPort-AV: E=Sophos;i="6.04,336,1695711600"; 
   d="scan'208";a="1027952889"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jan 2024 23:00:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rM0fl-00028y-1y;
	Sat, 06 Jan 2024 07:00:45 +0000
Date: Sat, 6 Jan 2024 15:00:13 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Axtens <dja@axtens.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Dmitry Vyukov <dvyukov@google.com>
Subject: sound/firewire/dice/dice.c:120:35: warning: ') at ' directive output
 may be truncated writing 5 bytes into a region of size between 1 and 69
Message-ID: <202401061446.Vh6laz5V-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   95c8a35f1c017327eab3b6a2ff5c04255737c856
commit: 47227d27e2fcb01a9e8f5958d8997cf47a820afc string.h: fix incompatibility between FORTIFY_SOURCE and KASAN
date:   3 years, 7 months ago
config: x86_64-randconfig-014-20240106 (https://download.01.org/0day-ci/archive/20240106/202401061446.Vh6laz5V-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240106/202401061446.Vh6laz5V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401061446.Vh6laz5V-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/firewire/dice/dice.c: In function 'dice_card_strings':
>> sound/firewire/dice/dice.c:120:35: warning: ') at ' directive output may be truncated writing 5 bytes into a region of size between 1 and 69 [-Wformat-truncation=]
     120 |                  "%s %s (serial %u) at %s, S%d",
         |                                   ^~~~~
   sound/firewire/dice/dice.c:119:9: note: 'snprintf' output 21 or more bytes (assuming 89) into a destination of size 80
     119 |         snprintf(card->longname, sizeof(card->longname),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     120 |                  "%s %s (serial %u) at %s, S%d",
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     121 |                  vendor, model, dev->config_rom[4] & 0x3fffff,
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     122 |                  dev_name(&dice->unit->device), 100 << dev->max_speed);
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +120 sound/firewire/dice/dice.c

82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04   91  
732d153fbeac17 sound/firewire/dice.c      Takashi Sakamoto 2014-11-29   92  static void dice_card_strings(struct snd_dice *dice)
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04   93  {
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04   94  	struct snd_card *card = dice->card;
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04   95  	struct fw_device *dev = fw_parent_device(dice->unit);
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04   96  	char vendor[32], model[32];
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04   97  	unsigned int i;
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04   98  	int err;
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04   99  
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  100  	strcpy(card->driver, "DICE");
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  101  
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  102  	strcpy(card->shortname, "DICE");
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  103  	BUILD_BUG_ON(NICK_NAME_SIZE < sizeof(card->shortname));
7c2d4c0cf5bacb sound/firewire/dice/dice.c Takashi Sakamoto 2014-11-29  104  	err = snd_dice_transaction_read_global(dice, GLOBAL_NICK_NAME,
7c2d4c0cf5bacb sound/firewire/dice/dice.c Takashi Sakamoto 2014-11-29  105  					       card->shortname,
7c2d4c0cf5bacb sound/firewire/dice/dice.c Takashi Sakamoto 2014-11-29  106  					       sizeof(card->shortname));
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  107  	if (err >= 0) {
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  108  		/* DICE strings are returned in "always-wrong" endianness */
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  109  		BUILD_BUG_ON(sizeof(card->shortname) % 4 != 0);
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  110  		for (i = 0; i < sizeof(card->shortname); i += 4)
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  111  			swab32s((u32 *)&card->shortname[i]);
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  112  		card->shortname[sizeof(card->shortname) - 1] = '\0';
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  113  	}
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  114  
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  115  	strcpy(vendor, "?");
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  116  	fw_csr_string(dev->config_rom + 5, CSR_VENDOR, vendor, sizeof(vendor));
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  117  	strcpy(model, "?");
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  118  	fw_csr_string(dice->unit->directory, CSR_MODEL, model, sizeof(model));
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  119  	snprintf(card->longname, sizeof(card->longname),
cbab328ddc7858 sound/firewire/dice.c      Clemens Ladisch  2011-09-04 @120  		 "%s %s (serial %u) at %s, S%d",
cbab328ddc7858 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  121  		 vendor, model, dev->config_rom[4] & 0x3fffff,
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  122  		 dev_name(&dice->unit->device), 100 << dev->max_speed);
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  123  
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  124  	strcpy(card->mixername, "DICE");
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  125  }
82fbb4f7b47683 sound/firewire/dice.c      Clemens Ladisch  2011-09-04  126  

:::::: The code at line 120 was first introduced by commit
:::::: cbab328ddc78589233be8be2f1e6a5f9d97b81db ALSA: dice: fix device detection for other vendors

:::::: TO: Clemens Ladisch <clemens@ladisch.de>
:::::: CC: Clemens Ladisch <clemens@ladisch.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

