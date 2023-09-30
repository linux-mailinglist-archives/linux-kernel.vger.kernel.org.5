Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965927B3DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 05:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjI3D4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 23:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjI3D4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:56:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6695EB;
        Fri, 29 Sep 2023 20:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696046193; x=1727582193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hZVCEshJL42nV27/fp4ItNiYdD2yoQb0af/3+hY1wDA=;
  b=MFbe0DgPWCA5H1wLoJh/i26kh60DtW6ziqO0qMJGExchsZBVtU8YdNkZ
   INxmWhInLtyoykRJZnj9+mh8lWqg95QU2aFGgDrj8KGTxvMTalAqLBFTl
   Ckw066GC1NpuRjqYwsEDUmMH6n7Ta8wGwACms/XkEp0JQyT5QXIq3vgvO
   WaRclATpmJUD/KhgZCwPJgNOnNuL95cAmWmLsTS95Xe1hvW32/DjLBspn
   Hkhrq+ByeVn39lsulPWkelYnhKcOf7FFMn2AOLz0MXBtRWDENgGzjmFwY
   4cir+PEnnVGKAPAUuMu0PZiC7kJAFZkUaE5aUWFXKrcnEQqRtwiWfiwiP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="362677811"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="362677811"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 20:56:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="820369067"
X-IronPort-AV: E=Sophos;i="6.03,189,1694761200"; 
   d="scan'208";a="820369067"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2023 20:56:29 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmR5f-0003fn-1I;
        Sat, 30 Sep 2023 03:56:27 +0000
Date:   Sat, 30 Sep 2023 11:55:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 26/27] staging: iio: resolver: ad2s1210: implement
 fault events
Message-ID: <202309301112.XWUnLqJ3-lkp@intel.com>
References: <20230929-ad2s1210-mainline-v3-26-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-ad2s1210-mainline-v3-26-fa4364281745@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5e99f692d4e32e3250ab18d511894ca797407aec]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/dt-bindings-iio-resolver-add-devicetree-bindings-for-ad2s1210/20230930-014031
base:   5e99f692d4e32e3250ab18d511894ca797407aec
patch link:    https://lore.kernel.org/r/20230929-ad2s1210-mainline-v3-26-fa4364281745%40baylibre.com
patch subject: [PATCH v3 26/27] staging: iio: resolver: ad2s1210: implement fault events
config: i386-randconfig-003-20230930 (https://download.01.org/0day-ci/archive/20230930/202309301112.XWUnLqJ3-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309301112.XWUnLqJ3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309301112.XWUnLqJ3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/staging/iio/resolver/ad2s1210.c:1452:34: warning: 'ad2s1210_of_match' defined but not used [-Wunused-const-variable=]
    1452 | static const struct of_device_id ad2s1210_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~
   drivers/staging/iio/resolver/ad2s1210.c: In function 'ad2s1210_read_raw':
>> drivers/staging/iio/resolver/ad2s1210.c:436:40: warning: array subscript 2 is above array bounds of 'u8[2]' {aka 'unsigned char[2]'} [-Warray-bounds]
     436 |  ad2s1210_push_events(indio_dev, st->rx[2], timestamp);
         |                                  ~~~~~~^~~


vim +436 drivers/staging/iio/resolver/ad2s1210.c

   390	
   391	static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
   392					      struct iio_chan_spec const *chan,
   393					      int *val)
   394	{
   395		struct ad2s1210_state *st = iio_priv(indio_dev);
   396		s64 timestamp;
   397		int ret;
   398	
   399		mutex_lock(&st->lock);
   400		gpiod_set_value(st->sample_gpio, 1);
   401		timestamp = iio_get_time_ns(indio_dev);
   402		/* delay (6 * tck + 20) nano seconds */
   403		udelay(1);
   404	
   405		switch (chan->type) {
   406		case IIO_ANGL:
   407			ret = ad2s1210_set_mode(st, MOD_POS);
   408			break;
   409		case IIO_ANGL_VEL:
   410			ret = ad2s1210_set_mode(st, MOD_VEL);
   411			break;
   412		default:
   413			ret = -EINVAL;
   414			break;
   415		}
   416		if (ret < 0)
   417			goto error_ret;
   418		ret = spi_read(st->sdev, &st->sample, 3);
   419		if (ret < 0)
   420			goto error_ret;
   421	
   422		switch (chan->type) {
   423		case IIO_ANGL:
   424			*val = be16_to_cpu(st->sample.raw);
   425			ret = IIO_VAL_INT;
   426			break;
   427		case IIO_ANGL_VEL:
   428			*val = (s16)be16_to_cpu(st->sample.raw);
   429			ret = IIO_VAL_INT;
   430			break;
   431		default:
   432			ret = -EINVAL;
   433			break;
   434		}
   435	
 > 436		ad2s1210_push_events(indio_dev, st->rx[2], timestamp);
   437	
   438	error_ret:
   439		gpiod_set_value(st->sample_gpio, 0);
   440		/* delay (2 * tck + 20) nano seconds */
   441		udelay(1);
   442		mutex_unlock(&st->lock);
   443		return ret;
   444	}
   445	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
