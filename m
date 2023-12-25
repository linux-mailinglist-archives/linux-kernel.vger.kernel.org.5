Return-Path: <linux-kernel+bounces-11181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBBD81E296
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89DD2822B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CF5249E0;
	Mon, 25 Dec 2023 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lv6opiQ9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECB1E519;
	Mon, 25 Dec 2023 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703543411; x=1735079411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VZijdm+s99r/mcXuRKAdDmXlGPgpA23M2I+QEOi/82I=;
  b=lv6opiQ9lbmID4eGQStOxbJxyrnENgIUAg0rNF+9ucOZ5KNqhSdF9B/V
   kZyY+y/+SUz5IWb4NFVFm+uBcTzambyiqPTaouXdLTmh4q/ikn+O8Kd8h
   PtumyBwgjl6b5HxaJTix+qyQqILM4CARdvEFLI1ZVEeFk2bqus1Z6jynD
   XhkiFQ5sJ4HitM802Jx7Mh4tTMeHiAI6A8syQoUmFpBME/BvqsxjP1nSe
   ldmX+cnpFu/9/W1KcMKu8nATY5qKAANgGNIcC3PaNePcfiTVtDsHv6WF+
   UThBN+0dM9LbrBX7NT2WiA+DIZh7VXN3W5E9hV8dUTP32J2nGOrbADsHa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3137316"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="3137316"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 14:30:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="812108244"
X-IronPort-AV: E=Sophos;i="6.04,304,1695711600"; 
   d="scan'208";a="812108244"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Dec 2023 14:30:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHtSV-000Diy-0Z;
	Mon, 25 Dec 2023 22:30:03 +0000
Date: Tue, 26 Dec 2023 06:29:55 +0800
From: kernel test robot <lkp@intel.com>
To: Lino Sanfilippo <l.sanfilippo@kunbus.com>, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, u.kleine-koenig@pengutronix.de,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	cniedermaier@dh-electronics.com, hugo@hugovil.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>, stable@vger.kernel.org
Subject: Re: [PATCH v6 6/7] serial: omap: do not override settings for RS485
 support
Message-ID: <202312260601.aT9SYjjo-lkp@intel.com>
References: <20231225113524.8800-7-l.sanfilippo@kunbus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225113524.8800-7-l.sanfilippo@kunbus.com>

Hi Lino,

kernel test robot noticed the following build errors:

[auto build test ERROR on ceb6a6f023fd3e8b07761ed900352ef574010bcb]

url:    https://github.com/intel-lab-lkp/linux/commits/Lino-Sanfilippo/serial-Do-not-hold-the-port-lock-when-setting-rx-during-tx-GPIO/20231225-193833
base:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
patch link:    https://lore.kernel.org/r/20231225113524.8800-7-l.sanfilippo%40kunbus.com
patch subject: [PATCH v6 6/7] serial: omap: do not override settings for RS485 support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231226/202312260601.aT9SYjjo-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231226/202312260601.aT9SYjjo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312260601.aT9SYjjo-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/tty/serial/omap-serial.c: In function 'serial_omap_probe_rs485':
>> drivers/tty/serial/omap-serial.c:1501:36: error: 'serial_omap_rs485_supported' undeclared (first use in this function); did you mean 'serial_omap_request_port'?
    1501 |         up->port.rs485_supported = serial_omap_rs485_supported;
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                    serial_omap_request_port
   drivers/tty/serial/omap-serial.c:1501:36: note: each undeclared identifier is reported only once for each function it appears in
   drivers/tty/serial/omap-serial.c: At top level:
>> drivers/tty/serial/omap-serial.c:1537:34: warning: 'serial_omap_rs485_supported' defined but not used [-Wunused-const-variable=]
    1537 | static const struct serial_rs485 serial_omap_rs485_supported = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1501 drivers/tty/serial/omap-serial.c

  1485	
  1486	static int serial_omap_probe_rs485(struct uart_omap_port *up,
  1487					   struct device *dev)
  1488	{
  1489		struct serial_rs485 *rs485conf = &up->port.rs485;
  1490		struct device_node *np = dev->of_node;
  1491		enum gpiod_flags gflags;
  1492		int ret;
  1493	
  1494		rs485conf->flags = 0;
  1495		up->rts_gpiod = NULL;
  1496	
  1497		if (!np)
  1498			return 0;
  1499	
  1500		up->port.rs485_config = serial_omap_config_rs485;
> 1501		up->port.rs485_supported = serial_omap_rs485_supported;
  1502	
  1503		ret = uart_get_rs485_mode(&up->port);
  1504		if (ret)
  1505			return ret;
  1506	
  1507		if (of_property_read_bool(np, "rs485-rts-active-high")) {
  1508			rs485conf->flags |= SER_RS485_RTS_ON_SEND;
  1509			rs485conf->flags &= ~SER_RS485_RTS_AFTER_SEND;
  1510		} else {
  1511			rs485conf->flags &= ~SER_RS485_RTS_ON_SEND;
  1512			rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
  1513		}
  1514	
  1515		/* check for tx enable gpio */
  1516		gflags = rs485conf->flags & SER_RS485_RTS_AFTER_SEND ?
  1517			GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
  1518		up->rts_gpiod = devm_gpiod_get_optional(dev, "rts", gflags);
  1519		if (IS_ERR(up->rts_gpiod)) {
  1520			ret = PTR_ERR(up->rts_gpiod);
  1521		        if (ret == -EPROBE_DEFER)
  1522				return ret;
  1523	
  1524			up->rts_gpiod = NULL;
  1525			up->port.rs485_supported = (const struct serial_rs485) { };
  1526			if (rs485conf->flags & SER_RS485_ENABLED) {
  1527				dev_err(dev, "disabling RS-485 (rts-gpio missing in device tree)\n");
  1528				memset(rs485conf, 0, sizeof(*rs485conf));
  1529			}
  1530		} else {
  1531			gpiod_set_consumer_name(up->rts_gpiod, "omap-serial");
  1532		}
  1533	
  1534		return 0;
  1535	}
  1536	
> 1537	static const struct serial_rs485 serial_omap_rs485_supported = {
  1538		.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
  1539			 SER_RS485_RX_DURING_TX,
  1540		.delay_rts_before_send = 1,
  1541		.delay_rts_after_send = 1,
  1542	};
  1543	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

