Return-Path: <linux-kernel+bounces-160865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20CE8B43BA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 04:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273791C2221D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D5F38F96;
	Sat, 27 Apr 2024 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FP0EtNMW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973D383AC;
	Sat, 27 Apr 2024 02:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714183284; cv=none; b=uEE/PIsKtnMGKhx6xk17wM2I7jYTqYAW1GvyuIVvg/woDmCbE8InEuQJffbC8p4zJ1owkQR9Wfmyx4F0bJXr7X8WyIpKp0AMMEcEhs8gXAtL/+xmpuIpa0JMR+3dHQixfjo3e8AkGX6WRD3LvPWhQQDDHYWj8pJ5+IeVoE3tfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714183284; c=relaxed/simple;
	bh=tbM3qJEcK23uZ8eskoRum+w9bzq6V0BQvpSZbulwOFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjob16pPijTBGZmkRN2lqNuSyOM3en1muCIld+M4h53uT0y2gQJuzVGDF/qLPgt/mlYygGjJEK+YiPpruQWAc7pxlbLtm6PxXLWyfHdnDsuMUqX6luWwxR5y/hlwk+quvYMLoWeBsMXzIPyKiodavlO4pENAjNApLQit+8vvosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FP0EtNMW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714183283; x=1745719283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tbM3qJEcK23uZ8eskoRum+w9bzq6V0BQvpSZbulwOFs=;
  b=FP0EtNMWNN2gb8/OkWu/CzzGMEX7mnLaHL7A9YIqPfr4cKY38LaSj5Tw
   S85DvFex5iCdwIDGGAPe4d5IHCqLkiVXHa67KnDYCS1kmz/ajaf3nqJsG
   7KmZwIQp3S7fqB7C70FsqKvauXHwRCQ1WxyyiQ02nSHfK2nbYMwIjUxhr
   Z/2dUj7whOK4ivk6f+V7wmkRncw4DLBNKFjlioP5nW1U88T/iirjqQjC3
   AqP/c+asJsgOYzfwo5OsmsS/uruUziP1ZMjpjP6MfW8+A1s0YWeZTRhXP
   5h33nuDF4aTBsVeRxgtSAcMqa0vGzmP4SpuFH3vLz0b/tOxiz+xzSSTku
   A==;
X-CSE-ConnectionGUID: 8DIKCFWySzSkjcEWnFTDnw==
X-CSE-MsgGUID: kaxoBiJCQBWTN9OmiLNUlw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="32431791"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="32431791"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 19:01:22 -0700
X-CSE-ConnectionGUID: ZtEtPmaMRWujlZVaAiJULQ==
X-CSE-MsgGUID: bRqN7QnuRjeTxQXemnwzjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="56769640"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Apr 2024 19:01:19 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0XNN-0004Xq-0U;
	Sat, 27 Apr 2024 02:01:17 +0000
Date: Sat, 27 Apr 2024 10:00:49 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org, nuno.sa@analog.com
Cc: oe-kbuild-all@lists.linux.dev,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: Re: [PATCH 3/7] iio: imu: adis16475: Re-define ADIS16475_DATA
Message-ID: <202404270958.43fSMp4J-lkp@intel.com>
References: <20240426135339.185602-4-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426135339.185602-4-ramona.bolboaca13@gmail.com>

Hi Ramona,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.9-rc5 next-20240426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240426-215728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240426135339.185602-4-ramona.bolboaca13%40gmail.com
patch subject: [PATCH 3/7] iio: imu: adis16475: Re-define ADIS16475_DATA
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240427/202404270958.43fSMp4J-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240427/202404270958.43fSMp4J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404270958.43fSMp4J-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/adis16475.c:734:34: warning: 'adis1650x_timeouts' defined but not used [-Wunused-const-variable=]
     734 | static const struct adis_timeout adis1650x_timeouts = {
         |                                  ^~~~~~~~~~~~~~~~~~


vim +/adis1650x_timeouts +734 drivers/iio/imu/adis16475.c

fff7352bf7a3ce Nuno Sá 2020-04-13  733  
fff7352bf7a3ce Nuno Sá 2020-04-13 @734  static const struct adis_timeout adis1650x_timeouts = {
fff7352bf7a3ce Nuno Sá 2020-04-13  735  	.reset_ms = 260,
fff7352bf7a3ce Nuno Sá 2020-04-13  736  	.sw_reset_ms = 260,
fff7352bf7a3ce Nuno Sá 2020-04-13  737  	.self_test_ms = 30,
fff7352bf7a3ce Nuno Sá 2020-04-13  738  };
fff7352bf7a3ce Nuno Sá 2020-04-13  739  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

