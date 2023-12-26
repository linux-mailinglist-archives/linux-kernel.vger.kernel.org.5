Return-Path: <linux-kernel+bounces-11316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464D581E47C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 03:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BAE282ABF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 02:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D43EA9;
	Tue, 26 Dec 2023 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amE/Ir//"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B1A28
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703556352; x=1735092352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=akg2x1JF6e0Hxo1P6nrdMwAyUhKGNi9x14Dcp8AxMNg=;
  b=amE/Ir//YGHGbAwC4Kd4d1jfPr2u17F/HNzMLZ9zy0IPzpFlUixIs8eJ
   Vw6D06GqtXk1M/KoZgqA/mKLhwR9KUTzN9b6cV7F0ZtyKIHz8ef/EqHlW
   sj6DY8CULooLruz5EgUjgBGLkRSlUBQ6EDJIHp/rwE34e87SOMcNSA4gW
   vpzwWDa9c7ADnB7TDx10rgi4dkPtBD/qcUQlELV2E8gdTCGS+E98g5Wyv
   TvopZf196N9H+C/GwoajdGrwCHE4vulPaPAX4WEDZq0XNoSImwcpCFFeh
   y+RrOGm3erHSd1dzAFamSoz+dlWzQ1486Nql5YPZl8OUuA7z3n5sP41nP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="482491113"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="482491113"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:05:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="26172467"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Dec 2023 18:05:49 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHwpG-000DsL-2m;
	Tue, 26 Dec 2023 02:05:46 +0000
Date: Tue, 26 Dec 2023 10:05:36 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Masney <masneyb@onstation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Marc Zyngier <maz@kernel.org>
Subject: kernel/irq/irqdomain.c:985: warning: Function parameter or member
 'd' not described in 'irq_domain_translate_twocell'
Message-ID: <202312261019.ZvgAHhpI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: b5c231d8c8037f63d34199ea1667bbe1cd9f940f genirq: introduce irq_domain_translate_twocell
date:   4 years, 10 months ago
config: x86_64-alldefconfig (https://download.01.org/0day-ci/archive/20231226/202312261019.ZvgAHhpI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312261019.ZvgAHhpI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312261019.ZvgAHhpI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/irq/irqdomain.c:66: warning: expecting prototype for irq_domain_alloc_fwnode(). Prototype was for __irq_domain_alloc_fwnode() instead
   kernel/irq/irqdomain.c:104: warning: Function parameter or member 'fwnode' not described in 'irq_domain_free_fwnode'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:914: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onecell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:933: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_twocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'd' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'ctrlr' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'intspec' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'intsize' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_xlate_onetwocell'
   kernel/irq/irqdomain.c:956: warning: Function parameter or member 'out_type' not described in 'irq_domain_xlate_onetwocell'
>> kernel/irq/irqdomain.c:985: warning: Function parameter or member 'd' not described in 'irq_domain_translate_twocell'
>> kernel/irq/irqdomain.c:985: warning: Function parameter or member 'fwspec' not described in 'irq_domain_translate_twocell'
>> kernel/irq/irqdomain.c:985: warning: Function parameter or member 'out_hwirq' not described in 'irq_domain_translate_twocell'
>> kernel/irq/irqdomain.c:985: warning: Function parameter or member 'out_type' not described in 'irq_domain_translate_twocell'
   kernel/irq/irqdomain.c:1564: warning: Function parameter or member 'domain' not described in 'irq_domain_alloc_irqs_parent'
   kernel/irq/irqdomain.c:1583: warning: Function parameter or member 'domain' not described in 'irq_domain_free_irqs_parent'


vim +985 kernel/irq/irqdomain.c

   972	
   973	/**
   974	 * irq_domain_translate_twocell() - Generic translate for direct two cell
   975	 * bindings
   976	 *
   977	 * Device Tree IRQ specifier translation function which works with two cell
   978	 * bindings where the cell values map directly to the hwirq number
   979	 * and linux irq flags.
   980	 */
   981	int irq_domain_translate_twocell(struct irq_domain *d,
   982					 struct irq_fwspec *fwspec,
   983					 unsigned long *out_hwirq,
   984					 unsigned int *out_type)
 > 985	{
   986		if (WARN_ON(fwspec->param_count < 2))
   987			return -EINVAL;
   988		*out_hwirq = fwspec->param[0];
   989		*out_type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
   990		return 0;
   991	}
   992	EXPORT_SYMBOL_GPL(irq_domain_translate_twocell);
   993	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

