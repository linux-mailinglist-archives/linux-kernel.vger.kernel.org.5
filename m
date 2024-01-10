Return-Path: <linux-kernel+bounces-22576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A5D829FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAF128AA57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82A4E1AB;
	Wed, 10 Jan 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ak/oainG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E34E1A9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704909258; x=1736445258;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gtvsdoAJOoObIN3HaFddrGHg0dn7/+7yx2T6oMJotJ8=;
  b=ak/oainGe0J837nRQ2NOmaSwxDyM8lz+5VuLbrdfw1q+g2OODu3zSXJB
   Uqbl/GYvUyyELy42DkN11driAjOzvKui834Rc1pTqGzQz/J848p+B2Bbe
   CdwKxhMOI4sVjqeApaIMw/YIkujArrV3UCFCGNQp/DFPEh/FRZA7ma9od
   2J3WQsdWr2EpTntRAdOid0G37M5IlPQ2lRBXamHcKJoWuewJqwG9EFJiU
   AlH0KVrpJ+pH9J4SxaXnloa+McUlYrq5PL3s0dqvOULPT8em1HBEj0FQV
   AemNQ3OoXuZcMWuKEjJdojUsOQNPA9P54ABz99Whgs+ymCC9rd0lk/0Vz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="20087892"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="20087892"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 09:54:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="901222722"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="901222722"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jan 2024 09:54:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNcmH-0007Lu-2x;
	Wed, 10 Jan 2024 17:54:09 +0000
Date: Thu, 11 Jan 2024 01:53:40 +0800
From: kernel test robot <lkp@intel.com>
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: drivers/iio/adc/axp20x_adc.c:572:26: sparse: sparse: dubious: x & !y
Message-ID: <202401110159.j4qEZUPp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ab27740f76654ed58dd32ac0ba0031c18a6dea3b
commit: 8957e5344353e9cd3f6b1e3004942e35449fa0e8 iio: adc: axp20x_adc: Minor code cleanups
date:   10 months ago
config: csky-buildonly-randconfig-r006-20230413 (https://download.01.org/0day-ci/archive/20240111/202401110159.j4qEZUPp-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240111/202401110159.j4qEZUPp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401110159.j4qEZUPp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/axp20x_adc.c:572:26: sparse: sparse: dubious: x & !y
   drivers/iio/adc/axp20x_adc.c:577:26: sparse: sparse: dubious: x & !y
   drivers/iio/adc/axp20x_adc.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h, ...):
   include/linux/page-flags.h:246:46: sparse: sparse: self-comparison always evaluates to false

vim +572 drivers/iio/adc/axp20x_adc.c

   551	
   552	static int axp20x_write_raw(struct iio_dev *indio_dev,
   553				    struct iio_chan_spec const *chan, int val, int val2,
   554				    long mask)
   555	{
   556		struct axp20x_adc_iio *info = iio_priv(indio_dev);
   557		unsigned int regmask, regval;
   558	
   559		/*
   560		 * The AXP20X PMIC allows the user to choose between 0V and 0.7V offsets
   561		 * for (independently) GPIO0 and GPIO1 when in ADC mode.
   562		 */
   563		if (mask != IIO_CHAN_INFO_OFFSET)
   564			return -EINVAL;
   565	
   566		if (val != 0 && val != 700000)
   567			return -EINVAL;
   568	
   569		switch (chan->channel) {
   570		case AXP20X_GPIO0_V:
   571			regmask = AXP20X_GPIO10_IN_RANGE_GPIO0;
 > 572			regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO0, !!val);
   573			break;
   574	
   575		case AXP20X_GPIO1_V:
   576			regmask = AXP20X_GPIO10_IN_RANGE_GPIO1;
   577			regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO1, !!val);
   578			break;
   579	
   580		default:
   581			return -EINVAL;
   582		}
   583	
   584		return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, regmask, regval);
   585	}
   586	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

