Return-Path: <linux-kernel+bounces-18756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DDF82629A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B128A1F21E30
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEE617D8;
	Sun,  7 Jan 2024 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyacBoMw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A91388
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704590925; x=1736126925;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OxLF2393s7TfSw37Q+XtUBUI5q02bkmOSGUxZDsWJPg=;
  b=TyacBoMw0SDFJibQU86PqpQxqG27C0MUEauWTEuXCYa/y2YwIo7yyWf1
   wkQUD/RjD4EvbT7nzvvZYgMdTfv8SIH7MfVTWZ5T/LFVSFeCXWpnpsB8G
   fIoYM7Bp6iELyp+nUB1cCndwd5QMFNWdz4isY3eFvSpZMXjkb+kD9E4L6
   9ibr5APVkc8qQ4Yqn/th7UPISVeIl21WAArFXronP6523QX110SYdAEAx
   0b7b+i80N4fwDmbQ5O09WOd+Fzp62ervKghpjsNfc0MYJWTRbrD3Cw28B
   FQCD7MtW+SeqWKvC/CBsu7TDxOUg5dLFmTzXSfE89bgQT7r+esLE0H6fu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10945"; a="428875589"
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="428875589"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2024 17:28:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,338,1695711600"; 
   d="scan'208";a="23179112"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Jan 2024 17:28:43 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMHxx-0003F2-0Y;
	Sun, 07 Jan 2024 01:28:41 +0000
Date: Sun, 7 Jan 2024 09:28:34 +0800
From: kernel test robot <lkp@intel.com>
To: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: drivers/iio/adc/axp20x_adc.c:572:26: sparse: sparse: dubious: x & !y
Message-ID: <202401070901.68H00NFa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
commit: 8957e5344353e9cd3f6b1e3004942e35449fa0e8 iio: adc: axp20x_adc: Minor code cleanups
date:   10 months ago
config: x86_64-randconfig-121-20240106 (https://download.01.org/0day-ci/archive/20240107/202401070901.68H00NFa-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240107/202401070901.68H00NFa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401070901.68H00NFa-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/axp20x_adc.c:572:26: sparse: sparse: dubious: x & !y
   drivers/iio/adc/axp20x_adc.c:577:26: sparse: sparse: dubious: x & !y

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

