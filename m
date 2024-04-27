Return-Path: <linux-kernel+bounces-160876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE3A8B43E4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16BC1F227F7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 03:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763453BBF9;
	Sat, 27 Apr 2024 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSv8HwzL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A4F1F93E;
	Sat, 27 Apr 2024 03:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714187186; cv=none; b=IbbnT/t6pnC+BrFwadMlji6WhMklWHkWb1rN62nothCBuA5M+umX0+IjApGORxuzeUv/4KkE86fNzLpgNCAMaDyZThDgrgLncbYHQ/R2LsdT41oL8J6oSMRPCnHfQLpVweloG3J0bTFdiBehiS/ki8ajYF2fu4ytmiP0HGZTA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714187186; c=relaxed/simple;
	bh=5s9RUz2MFkTGAYQJ26h2TnEAa/zhOjqbrB7VANRk3lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPHLdEFrUV/G2WfBAyPTDKiJdc61+mqDPfmw5ugnI+xgX6rqFsY/aljqjweNnywKoTWeU9tnip0l4hl1KSXJxpDsY3qBH/1kM+G+ZffrEpSD25GVAMimVyoLMdzYnGJ2Lg0odgND5p9zCylODKp8baY7yMsfMtS3L00aU5SDqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSv8HwzL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714187185; x=1745723185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5s9RUz2MFkTGAYQJ26h2TnEAa/zhOjqbrB7VANRk3lA=;
  b=SSv8HwzLvFuZLHaplno6KDuXk542fxOtj4tbNISshFgycwsJDGLgf4ux
   2XbWZXxbDryD/JWjT+kQ5RgNZUwSgCVxGMjTZUrSCMk9pe8UD5Pp3NlUL
   pJrXEQZ0w5s5bvdbGywZBpz+7e6XuVoj41iT7Anllu/XVAnm4HDJd9g+s
   uFsuWETMfXqoJ0b7aICIXsx7ExjWrQNa+Xx5wDaE8nOT+G8VoWnsyoRwv
   8e1KkILRrieLhaGN3iZfV0RBxjQV2jMfHreWtocuNjc8YV9mcAcKTJCyh
   InOhG6Mx8iLcACKjeFV9LDXGsDIENs0HL7761v0nHELt4VjqM9nfzIX+E
   Q==;
X-CSE-ConnectionGUID: 2Io5EqItQ/uh2atP6tpBDg==
X-CSE-MsgGUID: 6aqgQIWBTw+JmGktHyDgmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10468292"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="10468292"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 20:06:24 -0700
X-CSE-ConnectionGUID: MynFAFYcTw6hsFAehSytYg==
X-CSE-MsgGUID: nka30g3MRzqwzZjNc2Gf2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="56778167"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 26 Apr 2024 20:06:21 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0YOJ-0004ba-1x;
	Sat, 27 Apr 2024 03:06:19 +0000
Date: Sat, 27 Apr 2024 11:05:34 +0800
From: kernel test robot <lkp@intel.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org, nuno.sa@analog.com
Cc: oe-kbuild-all@lists.linux.dev,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: Re: [PATCH 4/7] iio: imu: adis_buffer: Add buffer setup API with
 buffer attributes
Message-ID: <202404271027.ySHRhuOH-lkp@intel.com>
References: <20240426135339.185602-5-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426135339.185602-5-ramona.bolboaca13@gmail.com>

Hi Ramona,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.9-rc5 next-20240426]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ramona-Gradinariu/dt-bindings-iio-imu-Add-ADIS16501-compatibles/20240426-215728
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240426135339.185602-5-ramona.bolboaca13%40gmail.com
patch subject: [PATCH 4/7] iio: imu: adis_buffer: Add buffer setup API with buffer attributes
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20240427/202404271027.ySHRhuOH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240427/202404271027.ySHRhuOH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404271027.ySHRhuOH-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/imu/adis_buffer.c: In function 'devm_adis_setup_buffer_and_trigger_with_attrs':
>> drivers/iio/imu/adis_buffer.c:207:51: error: passing argument 7 of 'devm_iio_triggered_buffer_setup_ext' from incompatible pointer type [-Werror=incompatible-pointer-types]
     207 |                                                   buffer_attrs);
         |                                                   ^~~~~~~~~~~~
         |                                                   |
         |                                                   const struct attribute **
   In file included from drivers/iio/imu/adis_buffer.c:19:
   include/linux/iio/triggered_buffer.h:31:69: note: expected 'const struct iio_dev_attr **' but argument is of type 'const struct attribute **'
      31 |                                         const struct iio_dev_attr **buffer_attrs);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/devm_iio_triggered_buffer_setup_ext +207 drivers/iio/imu/adis_buffer.c

   176	
   177	/**
   178	 * devm_adis_setup_buffer_and_trigger_with_attrs() - Sets up buffer and trigger
   179	 * for the managed adis device with buffer attributes.
   180	 * @adis: The adis device
   181	 * @indio_dev: The IIO device
   182	 * @trigger_handler: Trigger handler: should handle the buffer readings.
   183	 * @ops: Optional buffer setup functions, may be NULL.
   184	 * @buffer_attrs: Extra buffer attributes.
   185	 *
   186	 * Returns 0 on success, a negative error code otherwise.
   187	 *
   188	 * This function sets up the buffer (with buffer setup functions and extra
   189	 * buffer attributes) and trigger for a adis devices with buffer attributes.
   190	 */
   191	int
   192	devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis, struct iio_dev *indio_dev,
   193						      irq_handler_t trigger_handler,
   194						      const struct iio_buffer_setup_ops *ops,
   195						      const struct attribute **buffer_attrs)
   196	{
   197		int ret;
   198	
   199		if (!trigger_handler)
   200			trigger_handler = adis_trigger_handler;
   201	
   202		ret = devm_iio_triggered_buffer_setup_ext(&adis->spi->dev, indio_dev,
   203							  &iio_pollfunc_store_time,
   204							  trigger_handler,
   205							  IIO_BUFFER_DIRECTION_IN,
   206							  ops,
 > 207							  buffer_attrs);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

