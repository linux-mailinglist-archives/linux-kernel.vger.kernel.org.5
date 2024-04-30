Return-Path: <linux-kernel+bounces-164720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240378B81A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9BD283A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19723129E72;
	Tue, 30 Apr 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcvAmx6W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46C61A0AEA;
	Tue, 30 Apr 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714509717; cv=none; b=O5pKhy5JRDEpRb5kMqGoKkvBcZgJ3HcOgYlPw3KVpG/fsBMxZP0sHFqo8vdrhjScM73bOMiqbWi7w97YTULRvu54JwzqlZxIxFc8sMZUQ8t5RXSCXfGUXOWk/n9x1n0dqQZf0zTeawR3UhLoUxVRMH8Dehnro4xZT2WUIt5zh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714509717; c=relaxed/simple;
	bh=6KkGmVGtEf1S9YCVVMjzBf8rNFUKRe7dKZ6pSfJJJPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igNzkvCcXu6jrLK/bO1bhpuYr35l3ZC3e/7uU36nabvhizaturNqWSYoQewHMbmjW/B53NqXbDyA6Vw/iebrB8Z1l3hu0NIqlVCjPAyW5vikbeCks3a86hssPc/aRHZaF+nBBL7nYZ+EUntXzeuIIbNwFBf+P3CJaJwJPpSmoGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcvAmx6W; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714509715; x=1746045715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6KkGmVGtEf1S9YCVVMjzBf8rNFUKRe7dKZ6pSfJJJPA=;
  b=TcvAmx6WNQ62iIW1awqRuWh2evjBN4FhHCtAUM8I2ocpn9DtkzIayz7u
   V9Q/eAyECf8UonqpFHHS8OlZ9mM/zzUmbqoYHDxD8UrknC6sFxwSjwVcZ
   zzdBx47k0Czh/IVye/u5nuQgQUEtLXG4kCRG9RCIYDbfT+AfU7WbOgI/B
   pvU/RXTmYOwPxblNg4Q5SY3OMown6kIxnNltL4xzg5QI+KRIbCsFGxy4N
   v+EL+9uDgQKmi9hoWnKQtWlXTCYv6ykS7NCYJX/tK+mKGA9ZqcJqJf1ir
   sfGM91D0suE7VdTSMlooGMiwqu3EuABZwoz9JnIty2ODsbdsEnEalKHXL
   g==;
X-CSE-ConnectionGUID: NBoqiOvjTiaMdcj7+nmHAA==
X-CSE-MsgGUID: J/PZ2xP7QqSltgGfhosPfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10088131"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10088131"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 13:41:54 -0700
X-CSE-ConnectionGUID: DoNSVnHNR7qo3OlcPeksNA==
X-CSE-MsgGUID: eTAAwBdGTzW6SRtK8slPDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31060846"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Apr 2024 13:41:52 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s1uIQ-0008WV-2e;
	Tue, 30 Apr 2024 20:41:50 +0000
Date: Wed, 1 May 2024 04:41:12 +0800
From: kernel test robot <lkp@intel.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: temperature: mcp9600: add threshold events
 support
Message-ID: <202405010420.2KNGPYh5-lkp@intel.com>
References: <20240430120535.46097-6-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430120535.46097-6-dima.fedrau@gmail.com>

Hi Dimitri,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v6.9-rc6 next-20240430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Fedrau/iio-temperature-mcp9600-set-channel2-member/20240430-200914
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240430120535.46097-6-dima.fedrau%40gmail.com
patch subject: [PATCH 5/5] iio: temperature: mcp9600: add threshold events support
config: i386-buildonly-randconfig-005-20240501 (https://download.01.org/0day-ci/archive/20240501/202405010420.2KNGPYh5-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240501/202405010420.2KNGPYh5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405010420.2KNGPYh5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/temperature/mcp9600.c: In function 'mcp9600_probe_alerts':
>> drivers/iio/temperature/mcp9600.c:407:28: error: implicit declaration of function 'irq_get_trigger_type' [-Werror=implicit-function-declaration]
     407 |                 irq_type = irq_get_trigger_type(irq);
         |                            ^~~~~~~~~~~~~~~~~~~~
>> drivers/iio/temperature/mcp9600.c:408:33: error: 'IRQ_TYPE_EDGE_RISING' undeclared (first use in this function)
     408 |                 if (irq_type == IRQ_TYPE_EDGE_RISING)
         |                                 ^~~~~~~~~~~~~~~~~~~~
   drivers/iio/temperature/mcp9600.c:408:33: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors


vim +/irq_get_trigger_type +407 drivers/iio/temperature/mcp9600.c

   382	
   383	static int mcp9600_probe_alerts(struct iio_dev *indio_dev)
   384	{
   385		struct mcp9600_data *data = iio_priv(indio_dev);
   386		struct i2c_client *client = data->client;
   387		struct device *dev = &client->dev;
   388		struct fwnode_handle *fwnode = dev_fwnode(dev);
   389		unsigned int irq_type;
   390		int ret, irq, i;
   391		u8 val;
   392	
   393		/*
   394		 * alert1: hot junction, rising temperature
   395		 * alert2: hot junction, falling temperature
   396		 * alert3: cold junction, rising temperature
   397		 * alert4: cold junction, falling temperature
   398		 */
   399		for (i = 0; i < MCP9600_ALERT_COUNT; i++) {
   400			data->irq[i] = 0;
   401			mutex_init(&data->lock[i]);
   402			irq = fwnode_irq_get_byname(fwnode, mcp9600_alert_name[i]);
   403			if (irq <= 0)
   404				continue;
   405	
   406			val = 0;
 > 407			irq_type = irq_get_trigger_type(irq);
 > 408			if (irq_type == IRQ_TYPE_EDGE_RISING)
   409				val |= MCP9600_ALERT_CFG_ACTIVE_HIGH;
   410	
   411			if (i == MCP9600_ALERT2 || i == MCP9600_ALERT4)
   412				val |= MCP9600_ALERT_CFG_FALLING;
   413	
   414			if (i == MCP9600_ALERT3 || i == MCP9600_ALERT4)
   415				val |= MCP9600_ALERT_CFG_COLD_JUNCTION;
   416	
   417			ret = i2c_smbus_write_byte_data(client,
   418							MCP9600_ALERT_CFG(i + 1),
   419							val);
   420			if (ret < 0)
   421				return ret;
   422	
   423			ret = devm_request_threaded_irq(dev, irq, NULL,
   424							mcp9600_alert_handler,
   425							IRQF_ONESHOT, "mcp9600",
   426							indio_dev);
   427			if (ret)
   428				return ret;
   429	
   430			data->irq[i] = irq;
   431		}
   432	
   433		return 0;
   434	}
   435	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

