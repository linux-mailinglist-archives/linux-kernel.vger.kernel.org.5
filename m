Return-Path: <linux-kernel+bounces-166853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D46B8BA0DF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8E1F214EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30478176FB8;
	Thu,  2 May 2024 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNtG7Hdj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F1161304;
	Thu,  2 May 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714676639; cv=none; b=nDKYKaazrDsWpqwOCpqp8Y4NJYBEs8Acd5hobJk/2CiCHu1UnE6xUpbcGYTmTQoPWCzHJheUhIUaGia4chobVQh3Kx4IYbHGl3QZwzGhblmZrzs07iHZwAGjk2esCIn+JfMRN/AQ1z3+xrfosmN8Nq5JBa9bgtp4DPXRyyFX4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714676639; c=relaxed/simple;
	bh=EoWpaGahS9+7N/Tn7VrR0XBjpa7/lAxYqFMa8FhNZMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM7o5JIozO//mwuJvitrQ5g3ixf/7iqhh4LinQfkgFtvaRWVUXMSvZDEp+76lBbeXy2xbvMpQn/gb9PSqebCceM5TlbfBCUzpkdvi67ZK8F7VVivgTggh56hhILdmP2N1KTbxTP/Q3wRBkY6x3PYwBKcvfGmnlonXiI4qmlHBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNtG7Hdj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714676638; x=1746212638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EoWpaGahS9+7N/Tn7VrR0XBjpa7/lAxYqFMa8FhNZMQ=;
  b=HNtG7HdjMP1UJrDta3vc46HzKIDCgh271Ynb31QKtPwL6I4ekeeCfjGu
   u6LIMZaV74gKRi4eD1elJ037tP/ESsDdXFmHaYPEvsa3We/c4cGrkmXlJ
   YBP9mtGXzfMqhAxMwBy+00tJr6gBofjfAoHsczgw/D0amsJQ0mhDU48ZR
   QG201nI3yGX+nfn2CzbWrQfqgeOEFMv40XoCZzOHbUprJxMy8bp5ET/sp
   spvYucJEWwKm6hOEqgSXuiiRwpuSrAxqZvTE28grDqm8yGOWCU0Pcytju
   L1h+YWUorKpZ7i4HeWlmbOwVtn5QSAo5cTR1wuTZBoFdy5nvQVw3kvOek
   A==;
X-CSE-ConnectionGUID: 6FIU4BbMRY+agvDhufdh2Q==
X-CSE-MsgGUID: sPeGEydlQYuQ9EJm/hXhmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10399727"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10399727"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 12:03:57 -0700
X-CSE-ConnectionGUID: hIsS+t9vTdWnvfoomMjbOQ==
X-CSE-MsgGUID: pNk0L24ZSrGX7MRYoWkhkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27324360"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 May 2024 12:03:54 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2bii-000AuK-02;
	Thu, 02 May 2024 19:03:52 +0000
Date: Fri, 3 May 2024 03:03:18 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Denose <jdenose@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-input@vger.kernel.org,
	Jonathan Denose <jdenose@google.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeffery Miller <jefferymiller@google.com>
Subject: Re: [PATCH] Input: elantech - fix touchpad state on resume for
 Lenovo N24
Message-ID: <202405030210.izdCj8wZ-lkp@intel.com>
References: <20240501140231.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501140231.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6@changeid>

Hi Jonathan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus hid/for-next linus/master v6.9-rc6 next-20240502]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Denose/Input-elantech-fix-touchpad-state-on-resume-for-Lenovo-N24/20240501-220739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20240501140231.1.Ifa0e25ebf968d8f307f58d678036944141ab17e6%40changeid
patch subject: [PATCH] Input: elantech - fix touchpad state on resume for Lenovo N24
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240503/202405030210.izdCj8wZ-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030210.izdCj8wZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405030210.izdCj8wZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/math.h:5,
                    from include/linux/delay.h:22,
                    from drivers/input/mouse/elantech.c:10:
   drivers/input/mouse/elantech.c: In function 'elantech_reconnect':
>> include/linux/stddef.h:8:14: warning: passing argument 3 of 'ps2_sendbyte' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drivers/input/mouse/elantech.c:1509:75: note: in expansion of macro 'NULL'
    1509 |                 err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_DISABLE, NULL);
         |                                                                           ^~~~
   In file included from drivers/input/mouse/elantech.c:19:
   include/linux/libps2.h:64:63: note: expected 'unsigned int' but argument is of type 'void *'
      64 | int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout);
         |                                                  ~~~~~~~~~~~~~^~~~~~~
>> include/linux/stddef.h:8:14: warning: passing argument 3 of 'ps2_sendbyte' makes integer from pointer without a cast [-Wint-conversion]
       8 | #define NULL ((void *)0)
         |              ^~~~~~~~~~~
         |              |
         |              void *
   drivers/input/mouse/elantech.c:1515:74: note: in expansion of macro 'NULL'
    1515 |                 err = ps2_sendbyte(&psmouse->ps2dev, PSMOUSE_CMD_ENABLE, NULL);
         |                                                                          ^~~~
   include/linux/libps2.h:64:63: note: expected 'unsigned int' but argument is of type 'void *'
      64 | int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout);
         |                                                  ~~~~~~~~~~~~~^~~~~~~
   drivers/input/mouse/elantech.c: In function 'elantech_setup_ps2':
   drivers/input/mouse/elantech.c:2123:65: warning: '/input1' directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Wformat-truncation=]
    2123 |                 snprintf(etd->tp_phys, sizeof(etd->tp_phys), "%s/input1",
         |                                                                 ^~~~~~~
   drivers/input/mouse/elantech.c:2123:17: note: 'snprintf' output between 8 and 39 bytes into a destination of size 32
    2123 |                 snprintf(etd->tp_phys, sizeof(etd->tp_phys), "%s/input1",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2124 |                         psmouse->ps2dev.serio->phys);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ps2_sendbyte +8 include/linux/stddef.h

^1da177e4c3f41 Linus Torvalds   2005-04-16  6  
^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
6e218287432472 Richard Knutsson 2006-09-30  9  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

