Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB087AF548
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjIZUer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbjIZUeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:34:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D0F13A;
        Tue, 26 Sep 2023 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695760476; x=1727296476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PJ0vHy+VWElc+eQ+Z+ltBYNwE2I0BJC0iW+pGuyscyY=;
  b=KGckI7BEjaM8qMYEunh/3b/FXZCdxtUTX1FXwDVU0hDEY3Me6h6xqgOg
   mCNYYLsM+q3y4PAsHO7GVAuYfv2qtf/nbACL3U5Pmx42DUFj2woLpa8a4
   cNVD/Jar8/eKIHAzGK4sEcyqvijg8KwdzkoiAmd8H8zidNHi0XkTNyy2Z
   nlQrW9/9GFl7+4flNbe1BNAo/hrm7Y+jwevasMoLyoHrPhuHousBsqg9g
   SwZ/FZQ6353U1s050eK171FJiHbRT+lPUeRfSzRl0m6xnv3WPnDbHC+Yz
   f16B3jSBMRpqsF9AIU9mFg79iRdI29m490/LQ0ca8f63KxQwr7zZFOKCS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412580983"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="412580983"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 13:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814611539"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="814611539"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2023 13:34:33 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlElK-0003LJ-35;
        Tue, 26 Sep 2023 20:34:30 +0000
Date:   Wed, 27 Sep 2023 04:33:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] trigger: ledtrig-tty: add new line mode to triggers
Message-ID: <202309270440.IJB24Xap-lkp@intel.com>
References: <20230926093607.59536-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926093607.59536-3-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on tty/tty-next tty/tty-linus staging/staging-testing staging/staging-next staging/staging-linus linus/master v6.6-rc3 next-20230926]
[cannot apply to pavel-leds/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Eckert/tty-add-new-helper-function-tty_get_mget/20230926-180154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230926093607.59536-3-fe%40dev.tdt.de
patch subject: [PATCH 2/2] trigger: ledtrig-tty: add new line mode to triggers
config: x86_64-randconfig-161-20230927 (https://download.01.org/0day-ci/archive/20230927/202309270440.IJB24Xap-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270440.IJB24Xap-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270440.IJB24Xap-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/leds/trigger/ledtrig-tty.c: In function 'ledtrig_tty_work':
>> drivers/leds/trigger/ledtrig-tty.c:362:3: error: a label can only be part of a statement and a declaration is not a statement
      unsigned long interval = LEDTRIG_TTY_INTERVAL;
      ^~~~~~~~


vim +362 drivers/leds/trigger/ledtrig-tty.c

   270	
   271	static void ledtrig_tty_work(struct work_struct *work)
   272	{
   273		struct ledtrig_tty_data *trigger_data =
   274			container_of(work, struct ledtrig_tty_data, dwork.work);
   275		struct led_classdev *led_cdev = trigger_data->led_cdev;
   276		struct serial_icounter_struct icount;
   277		enum tty_led_state state;
   278		int ret;
   279	
   280		state = TTY_LED_DISABLE;
   281		mutex_lock(&trigger_data->mutex);
   282	
   283		if (!trigger_data->ttyname) {
   284			/* exit without rescheduling */
   285			mutex_unlock(&trigger_data->mutex);
   286			return;
   287		}
   288	
   289		/* try to get the tty corresponding to $ttyname */
   290		if (!trigger_data->tty) {
   291			dev_t devno;
   292			struct tty_struct *tty;
   293			int ret;
   294	
   295			ret = tty_dev_name_to_number(trigger_data->ttyname, &devno);
   296			if (ret < 0)
   297				/*
   298				 * A device with this name might appear later, so keep
   299				 * retrying.
   300				 */
   301				goto out;
   302	
   303			tty = tty_kopen_shared(devno);
   304			if (IS_ERR(tty) || !tty)
   305				/* What to do? retry or abort */
   306				goto out;
   307	
   308			trigger_data->tty = tty;
   309		}
   310	
   311		if (test_bit(LEDTRIG_TTY_MODE_CTS, &trigger_data->mode)) {
   312			ret = ledtrig_tty_flag(trigger_data, TIOCM_CTS);
   313			if (ret)
   314				state = TTY_LED_ENABLE;
   315		}
   316	
   317		if (test_bit(LEDTRIG_TTY_MODE_DSR, &trigger_data->mode)) {
   318			ret = ledtrig_tty_flag(trigger_data, TIOCM_DSR);
   319			if (ret)
   320				state = TTY_LED_ENABLE;
   321		}
   322	
   323		if (test_bit(LEDTRIG_TTY_MODE_CAR, &trigger_data->mode)) {
   324			ret = ledtrig_tty_flag(trigger_data, TIOCM_CAR);
   325			if (ret)
   326				state = TTY_LED_ENABLE;
   327		}
   328	
   329		if (test_bit(LEDTRIG_TTY_MODE_RNG, &trigger_data->mode)) {
   330			ret = ledtrig_tty_flag(trigger_data, TIOCM_RNG);
   331			if (ret)
   332				state = TTY_LED_ENABLE;
   333		}
   334	
   335		/* The rx/tx handling must come after the evaluation of TIOCM_*,
   336		 * since the display for rx/tx has priority
   337		 */
   338		if (test_bit(LEDTRIG_TTY_MODE_TX, &trigger_data->mode) ||
   339		    test_bit(LEDTRIG_TTY_MODE_RX, &trigger_data->mode)) {
   340			ret = tty_get_icount(trigger_data->tty, &icount);
   341			if (ret) {
   342				dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polling\n");
   343				mutex_unlock(&trigger_data->mutex);
   344				return;
   345			}
   346	
   347			if (test_bit(LEDTRIG_TTY_MODE_TX, &trigger_data->mode) &&
   348			    (icount.tx != trigger_data->tx)) {
   349				trigger_data->tx = icount.tx;
   350				state = TTY_LED_BLINK;
   351			}
   352	
   353			if (test_bit(LEDTRIG_TTY_MODE_RX, &trigger_data->mode) &&
   354			    (icount.rx != trigger_data->rx)) {
   355				trigger_data->rx = icount.rx;
   356				state = TTY_LED_BLINK;
   357			}
   358		}
   359	
   360		switch (state) {
   361		case TTY_LED_BLINK:
 > 362			unsigned long interval = LEDTRIG_TTY_INTERVAL;
   363			led_blink_set_oneshot(trigger_data->led_cdev, &interval,
   364					      &interval, 0);
   365			break;
   366		case TTY_LED_ENABLE:
   367			led_set_brightness(led_cdev, led_cdev->blink_brightness);
   368			break;
   369		case TTY_LED_DISABLE:
   370			fallthrough;
   371		default:
   372			led_set_brightness(led_cdev, 0);
   373			break;
   374		}
   375	
   376	out:
   377		mutex_unlock(&trigger_data->mutex);
   378		schedule_delayed_work(&trigger_data->dwork,
   379				      msecs_to_jiffies(LEDTRIG_TTY_INTERVAL * 2));
   380	}
   381	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
