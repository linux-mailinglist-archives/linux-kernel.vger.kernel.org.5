Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB65758A22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGSAj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSAjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:39:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE1139;
        Tue, 18 Jul 2023 17:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689727164; x=1721263164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=momXZNfaJlA8MUVISZW1Spq3TD1TACCwtGXdLc1rSlk=;
  b=aHOo5kT9DOuLvnK+jP+pRKpInCS2pdHeE7ob1N1aSecus07ePGljikwS
   VmKX+Q7Bfi6CZepZimbJhhKoqSoLT1EggflU/ma++78hTVy50njhWzf1T
   2JcsC5DPUkt4GL3FWwX34ck2dmOAz3K2n+GVPrqns3SUj3Y3IzT4bLEGB
   gfQqHt9QkQjQSIYouE+SwuFazda0xs8zAKCWYxmSK0JXGv/wl0YvAmHVs
   qkJUtYurdsoePFiIuWziKrFB8Fvw+2vgpr0kejJBNtGOe2e71XYIp4P1l
   U3FDTYu5OvSS4aqmmxd5jr6tNsKlGgSeT+VbS5L3I6kbmZKtr2RziYuxB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345934271"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="345934271"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 17:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="793819356"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="793819356"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2023 17:39:22 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qLvDt-0003z7-1b;
        Wed, 19 Jul 2023 00:39:21 +0000
Date:   Wed, 19 Jul 2023 08:38:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Waqar Hameed <waqar.hameed@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     oe-kbuild-all@lists.linux.dev, kernel@axis.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: Add driver for Murata IRS-D200
Message-ID: <202307190824.LNgDNyW1-lkp@intel.com>
References: <39cfb5b9f58e26a9b348a03743d250249983ed35.1689683411.git.waqar.hameed@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39cfb5b9f58e26a9b348a03743d250249983ed35.1689683411.git.waqar.hameed@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waqar,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c]

url:    https://github.com/intel-lab-lkp/linux/commits/Waqar-Hameed/dt-bindings-iio-proximity-Add-Murata-IRS-D200/20230718-203520
base:   3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
patch link:    https://lore.kernel.org/r/39cfb5b9f58e26a9b348a03743d250249983ed35.1689683411.git.waqar.hameed%40axis.com
patch subject: [PATCH v3 3/3] iio: Add driver for Murata IRS-D200
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20230719/202307190824.LNgDNyW1-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307190824.LNgDNyW1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307190824.LNgDNyW1-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/proximity/irsd200.c: In function 'irsd200_irq_thread':
>> drivers/iio/proximity/irsd200.c:705:17: error: implicit declaration of function 'iio_trigger_poll_chained'; did you mean 'iio_trigger_poll_nested'? [-Werror=implicit-function-declaration]
     705 |                 iio_trigger_poll_chained(indio_dev->trig);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
         |                 iio_trigger_poll_nested
   cc1: some warnings being treated as errors


vim +705 drivers/iio/proximity/irsd200.c

   676	
   677	static irqreturn_t irsd200_irq_thread(int irq, void *dev_id)
   678	{
   679		struct iio_dev *indio_dev = dev_id;
   680		struct irsd200_data *data = iio_priv(indio_dev);
   681		enum iio_event_direction dir;
   682		unsigned int lower_count;
   683		unsigned int upper_count;
   684		unsigned int status = 0;
   685		unsigned int source = 0;
   686		unsigned int clear = 0;
   687		unsigned int count = 0;
   688		int ret;
   689	
   690		ret = regmap_read(data->regmap, IRS_REG_INTR, &source);
   691		if (ret) {
   692			dev_err(data->dev, "Could not read interrupt source (%d)\n",
   693				ret);
   694			return IRQ_HANDLED;
   695		}
   696	
   697		ret = regmap_read(data->regmap, IRS_REG_STATUS, &status);
   698		if (ret) {
   699			dev_err(data->dev, "Could not acknowledge interrupt (%d)\n",
   700				ret);
   701			return IRQ_HANDLED;
   702		}
   703	
   704		if (status & BIT(IRS_INTR_DATA) && iio_buffer_enabled(indio_dev)) {
 > 705			iio_trigger_poll_chained(indio_dev->trig);
   706			clear |= BIT(IRS_INTR_DATA);
   707		}
   708	
   709		if (status & BIT(IRS_INTR_COUNT_THR_OR) &&
   710		    source & BIT(IRS_INTR_COUNT_THR_OR)) {
   711			/*
   712			 * The register value resets to zero after reading. We therefore
   713			 * need to read once and manually extract the lower and upper
   714			 * count register fields.
   715			 */
   716			ret = regmap_read(data->regmap, IRS_REG_COUNT, &count);
   717			if (ret)
   718				dev_err(data->dev, "Could not read count (%d)\n", ret);
   719	
   720			upper_count = IRS_UPPER_COUNT(count);
   721			lower_count = IRS_LOWER_COUNT(count);
   722	
   723			/*
   724			 * We only check the OR mode to be able to push events for
   725			 * rising and falling thresholds. AND mode is covered when both
   726			 * upper and lower count is non-zero, and is signaled with
   727			 * IIO_EV_DIR_EITHER.
   728			 */
   729			if (upper_count && !lower_count)
   730				dir = IIO_EV_DIR_RISING;
   731			else if (!upper_count && lower_count)
   732				dir = IIO_EV_DIR_FALLING;
   733			else
   734				dir = IIO_EV_DIR_EITHER;
   735	
   736			iio_push_event(indio_dev,
   737				       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
   738							    IIO_EV_TYPE_THRESH, dir),
   739				       iio_get_time_ns(indio_dev));
   740	
   741			/*
   742			 * The OR mode will always trigger when the AND mode does, but
   743			 * not vice versa. However, it seems like the AND bit needs to
   744			 * be cleared if data capture _and_ threshold count interrupts
   745			 * are desirable, even though it hasn't explicitly been selected
   746			 * (with IRS_REG_INTR). Either way, it doesn't hurt...
   747			 */
   748			clear |= BIT(IRS_INTR_COUNT_THR_OR) |
   749				 BIT(IRS_INTR_COUNT_THR_AND);
   750		}
   751	
   752		if (clear) {
   753			ret = regmap_write(data->regmap, IRS_REG_STATUS, clear);
   754			if (ret)
   755				dev_err(data->dev,
   756					"Could not clear interrupt status (%d)\n", ret);
   757		}
   758	
   759		return clear ? IRQ_HANDLED : IRQ_NONE;
   760	}
   761	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
