Return-Path: <linux-kernel+bounces-156876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE468B09C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52EDB26561
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5471E528;
	Wed, 24 Apr 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anduGsq3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2031DFF8;
	Wed, 24 Apr 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713962060; cv=none; b=Dpt91R99hQSfUSvaBZa1XxNq0k8AC32HK/sZYZxPUqjtkY9blHWxSyWAhMjSp6y0amu33K2MQYAiwWLI3ccSjNx8d0YVyDE7gGdYpgVXoxG5scpSi8SqbdOB0dw6n6bGskhnpb4+UFALjL14Q73hISx+Wk2M11/ZNK6vjSKfqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713962060; c=relaxed/simple;
	bh=RdEzfGHr6mIGf1fmDgMivz/m+lwL7VuuP84qTo4VLCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n++XyMaNwyqcxWbYPG/NoNTGAHwZBsUtPktLJOmK9gXGfhV3nVm+ijbBsrHp2B7S25j1EXlT8WvdMm63WuKJXyiBtnMEO79R0CYjxGw7jQIBH46kCQ7oSo+W1tu2tqZOroy+xDjavTrtG86Vn62cjgiyPehIgnj+UK97IM4h9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anduGsq3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713962059; x=1745498059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RdEzfGHr6mIGf1fmDgMivz/m+lwL7VuuP84qTo4VLCg=;
  b=anduGsq337SRfbmlA2MCkUFDibNWfvsh74GpWW33bXD0uG+vZcDSBilm
   HiquZ5CzdGe0C/NSxW9rmQ0EZDjTG47ghNHG5BWbYLqsCYQKz2SDD7K6u
   mnX7Ktk00STFYRIt9iSqAbXm1JWI9ZQnujBZKvKlSHm97xRFNY3gct6Mu
   2mbqD5uTU6ITio4OQ23zbajPxWOEK3YbrHy0M3Hu1Olc9DfKeTxyVc3Bi
   0VTiMrzwthYKLUl7CNL+eNZ0EcYh6nwB1S/6B6n4RB9lchWh/28c32AZZ
   KUSpL5y6FNDryjjF/PjaHRSIAPjnBuhOXdyTIhFlGBm+YN9IjSdRoXH8X
   g==;
X-CSE-ConnectionGUID: UYZd7slCSZaVzw1ZwzlpiA==
X-CSE-MsgGUID: EM/5tJCfQhKnje6r3TQoJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9811289"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9811289"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 05:34:18 -0700
X-CSE-ConnectionGUID: UXB9MMOrRbiJGz+VZuSSzg==
X-CSE-MsgGUID: /K5OmW/RRKu88J3t3Vt0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24585850"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 24 Apr 2024 05:34:12 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzbpB-0001Dq-2r;
	Wed, 24 Apr 2024 12:34:09 +0000
Date: Wed, 24 Apr 2024 20:34:03 +0800
From: kernel test robot <lkp@intel.com>
To: Aren Moynihan <aren@peacevolution.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Aren Moynihan <aren@peacevolution.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Willow Barraco <contact@willowbarraco.fr>
Subject: Re: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and
 power it off during suspend
Message-ID: <202404242057.PUDY5RB1-lkp@intel.com>
References: <20240423223309.1468198-4-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423223309.1468198-4-aren@peacevolution.org>

Hi Aren,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on sunxi/sunxi/for-next robh/for-next linus/master v6.9-rc5 next-20240423]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aren-Moynihan/dt-bindings-iio-light-stk33xx-add-vdd-and-leda-regulators/20240424-064250
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20240423223309.1468198-4-aren%40peacevolution.org
patch subject: [PATCH v2 2/6] iio: light: stk3310: Implement vdd supply and power it off during suspend
config: arm64-randconfig-001-20240424 (https://download.01.org/0day-ci/archive/20240424/202404242057.PUDY5RB1-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 5ef5eb66fb428aaf61fb51b709f065c069c11242)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240424/202404242057.PUDY5RB1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404242057.PUDY5RB1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/light/stk3310.c:10:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/light/stk3310.c:615:38: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
     615 |                 return dev_err_probe(&client->dev, ret, "get regulator vdd failed\n");
         |                                                    ^~~
   drivers/iio/light/stk3310.c:594:9: note: initialize the variable 'ret' to silence this warning
     594 |         int ret;
         |                ^
         |                 = 0
   2 warnings generated.


vim +/ret +615 drivers/iio/light/stk3310.c

   591	
   592	static int stk3310_probe(struct i2c_client *client)
   593	{
   594		int ret;
   595		struct iio_dev *indio_dev;
   596		struct stk3310_data *data;
   597	
   598		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
   599		if (!indio_dev) {
   600			dev_err(&client->dev, "iio allocation failed!\n");
   601			return -ENOMEM;
   602		}
   603	
   604		data = iio_priv(indio_dev);
   605		data->client = client;
   606		i2c_set_clientdata(client, indio_dev);
   607	
   608		device_property_read_u32(&client->dev, "proximity-near-level",
   609					 &data->ps_near_level);
   610	
   611		mutex_init(&data->lock);
   612	
   613		data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
   614		if (IS_ERR(data->vdd_reg))
 > 615			return dev_err_probe(&client->dev, ret, "get regulator vdd failed\n");
   616	
   617		ret = stk3310_regmap_init(data);
   618		if (ret < 0)
   619			return ret;
   620	
   621		indio_dev->info = &stk3310_info;
   622		indio_dev->name = STK3310_DRIVER_NAME;
   623		indio_dev->modes = INDIO_DIRECT_MODE;
   624		indio_dev->channels = stk3310_channels;
   625		indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
   626	
   627		ret = regulator_enable(data->vdd_reg);
   628		if (ret)
   629			return dev_err_probe(&client->dev, ret,
   630					     "regulator vdd enable failed\n");
   631	
   632		/* we need a short delay to allow the chip time to power on */
   633		fsleep(1000);
   634	
   635		ret = stk3310_init(indio_dev);
   636		if (ret < 0)
   637			goto err_vdd_disable;
   638	
   639		if (client->irq > 0) {
   640			ret = devm_request_threaded_irq(&client->dev, client->irq,
   641							stk3310_irq_handler,
   642							stk3310_irq_event_handler,
   643							IRQF_TRIGGER_FALLING |
   644							IRQF_ONESHOT,
   645							STK3310_EVENT, indio_dev);
   646			if (ret < 0) {
   647				dev_err(&client->dev, "request irq %d failed\n",
   648					client->irq);
   649				goto err_standby;
   650			}
   651		}
   652	
   653		ret = iio_device_register(indio_dev);
   654		if (ret < 0) {
   655			dev_err(&client->dev, "device_register failed\n");
   656			goto err_standby;
   657		}
   658	
   659		return 0;
   660	
   661	err_standby:
   662		stk3310_set_state(data, STK3310_STATE_STANDBY);
   663	err_vdd_disable:
   664		regulator_disable(data->vdd_reg);
   665		return ret;
   666	}
   667	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

