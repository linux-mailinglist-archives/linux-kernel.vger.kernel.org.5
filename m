Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ADC7CEE80
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 05:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJSDw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 23:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSDwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 23:52:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D943BE;
        Wed, 18 Oct 2023 20:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697687571; x=1729223571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EyExOR9MjyPbtRHp0H6mdIrgW/PyQazk4lBJT1IkEiA=;
  b=OhBBvJqlOIBN4h8PuVnwIHIgy/+KMFiJch0MMNcQHTEAsGRa/ewW+zZS
   +0KyQGjdm3tN3CxYjKFyXNcVDFoSsKjhINGh3VPEyhz3jblaq1BDV1HLT
   YVpAdifJ86cb/WehfCpUuUgrq37mPLb8yOSiRxuP91qyVPut7TqEyjrVA
   yImeNnsM7Ax2Z6v1r9Z50J+ZOjTf37BKhtBAtJlDKeK2gsEyJMJL8Vos6
   xhNVpH8VkU3s2mlI/DvqwfCbZVmfltdlmbcK781O0/JW5tk1UPAh019ac
   EqENtPvZBvy1Nsg+IX5KMeJTQ3NsYrsAKQ/kyAEv3DJIGzKKZCNkL/F4b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7720241"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="7720241"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 20:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="900594508"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="900594508"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2023 20:50:40 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtK5U-0001Ya-0U;
        Thu, 19 Oct 2023 03:52:44 +0000
Date:   Thu, 19 Oct 2023 11:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        poyuan_chang@himax.corp-partner.google.com,
        jingyliang@chromium.org, hbarnor@chromium.org, wuxy23@lenovo.com,
        luolm1@lenovo.com, poyu_hung@himax.corp-partner.google.com,
        Tylor Yang <tylor_yang@himax.corp-partner.google.com>
Subject: Re: [PATCH v3 4/4] HID: touchscreen: Add initial support for Himax
 HID-over-SPI
Message-ID: <202310191116.ulMkjBrE-lkp@intel.com>
References: <20231017091900.801989-5-tylor_yang@himax.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017091900.801989-5-tylor_yang@himax.corp-partner.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tylor,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on dtor-input/next dtor-input/for-linus robh/for-next linus/master v6.6-rc6 next-20231018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tylor-Yang/dt-bindings-input-Introduce-Himax-HID-over-SPI-device/20231017-172156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/20231017091900.801989-5-tylor_yang%40himax.corp-partner.google.com
patch subject: [PATCH v3 4/4] HID: touchscreen: Add initial support for Himax HID-over-SPI
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20231019/202310191116.ulMkjBrE-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310191116.ulMkjBrE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310191116.ulMkjBrE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hx-hid/hx_plat.c:19:6: warning: no previous prototype for 'himax_rst_gpio_set' [-Wmissing-prototypes]
      19 | void himax_rst_gpio_set(int pinnum, u8 value)
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_plat.c:309:13: warning: no previous prototype for 'himax_ts_thread' [-Wmissing-prototypes]
     309 | irqreturn_t himax_ts_thread(int irq, void *ptr)
         |             ^~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_plat.c:461:6: warning: no previous prototype for 'hx_check_power_status' [-Wmissing-prototypes]
     461 | void hx_check_power_status(struct work_struct *work)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_plat.c:473:5: warning: no previous prototype for 'pwr_notifier_callback' [-Wmissing-prototypes]
     473 | int pwr_notifier_callback(struct notifier_block *self,
         |     ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/kernel.h:30,
                    from include/linux/cpumask.h:10,
                    from include/linux/mm_types_task.h:14,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/hid/hx-hid/hx_core.h:5,
                    from drivers/hid/hx-hid/hx_ic_core.h:6,
                    from drivers/hid/hx-hid/hx_ic_core.c:16:
   drivers/hid/hx-hid/hx_ic_core.c: In function 'hx_mcu_bin_desc_get':
   include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:508:9: note: in expansion of macro 'printk'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:508:16: note: in expansion of macro 'KERN_WARNING'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.h:64:24: note: in expansion of macro 'pr_warn'
      64 | #define W(fmt, arg...) pr_warn("[HXTP][WARNING][%s]: " fmt "\n", __func__, ##arg)
         |                        ^~~~~~~
   drivers/hid/hx-hid/hx_ic_core.c:1595:25: note: in expansion of macro 'W'
    1595 |                         W("hid_table_addr = %d, ts->hxfw->size = %lu!",
         |                         ^
   include/linux/kern_levels.h:5:25: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:427:25: note: in definition of macro 'printk_index_wrap'
     427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:508:9: note: in expansion of macro 'printk'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:12:25: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:508:16: note: in expansion of macro 'KERN_WARNING'
     508 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.h:64:24: note: in expansion of macro 'pr_warn'
      64 | #define W(fmt, arg...) pr_warn("[HXTP][WARNING][%s]: " fmt "\n", __func__, ##arg)
         |                        ^~~~~~~
   drivers/hid/hx-hid/hx_ic_core.c:1597:25: note: in expansion of macro 'W'
    1597 |                         W("hid_rd_desc_addr = %d, rd_len = %d, ts->hxfw->size = %lu!",
         |                         ^
   drivers/hid/hx-hid/hx_ic_core.c: At top level:
>> drivers/hid/hx-hid/hx_ic_core.c:2404:5: warning: no previous prototype for 'himax_zf_part_info' [-Wmissing-prototypes]
    2404 | int himax_zf_part_info(const struct firmware *fw, struct himax_ts_data *ts,
         |     ^~~~~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_ic_core.c:2598:5: warning: no previous prototype for 'himax_mcu_firmware_update_0f' [-Wmissing-prototypes]
    2598 | int himax_mcu_firmware_update_0f(const struct firmware *fw,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_ic_core.c:2693:5: warning: no previous prototype for 'hx_0f_op_file_dirly' [-Wmissing-prototypes]
    2693 | int hx_0f_op_file_dirly(char *file_name, struct himax_ts_data *ts)
         |     ^~~~~~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_ic_core.c:2746:6: warning: no previous prototype for 'himax_mcu_read_sram_0f' [-Wmissing-prototypes]
    2746 | void himax_mcu_read_sram_0f(struct himax_ts_data *ts,
         |      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_ic_core.c:2847:6: warning: no previous prototype for 'himax_mcu_read_all_sram' [-Wmissing-prototypes]
    2847 | void himax_mcu_read_all_sram(struct himax_ts_data *ts, u8 *addr,
         |      ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_ic_core.c:2905:6: warning: no previous prototype for 'himax_mcu_firmware_read_0f' [-Wmissing-prototypes]
    2905 | void himax_mcu_firmware_read_0f(struct himax_ts_data *ts,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/hid/hx-hid/hx_core.c: In function 'himax_boot_upgrade':
>> drivers/hid/hx-hid/hx_core.c:701:14: warning: variable 'fw_load_status' set but not used [-Wunused-but-set-variable]
     701 |         bool fw_load_status = false;
         |              ^~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c: At top level:
>> drivers/hid/hx-hid/hx_core.c:831:6: warning: no previous prototype for 'hx_hid_update' [-Wmissing-prototypes]
     831 | void hx_hid_update(struct work_struct *work)
         |      ^~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_core.c:890:6: warning: no previous prototype for 'himax_report_data_deinit' [-Wmissing-prototypes]
     890 | void himax_report_data_deinit(struct himax_ts_data *ts)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_core.c:940:5: warning: no previous prototype for 'himax_chip_suspend' [-Wmissing-prototypes]
     940 | int himax_chip_suspend(struct himax_ts_data *ts)
         |     ^~~~~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c: In function 'himax_chip_suspend':
>> drivers/hid/hx-hid/hx_core.c:942:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     942 |         int ret = 0;
         |             ^~~
   drivers/hid/hx-hid/hx_core.c: At top level:
>> drivers/hid/hx-hid/hx_core.c:983:5: warning: no previous prototype for 'himax_chip_resume' [-Wmissing-prototypes]
     983 | int himax_chip_resume(struct himax_ts_data *ts)
         |     ^~~~~~~~~~~~~~~~~
>> drivers/hid/hx-hid/hx_core.c:1212:6: warning: no previous prototype for 'himax_chip_deinit' [-Wmissing-prototypes]
    1212 | void himax_chip_deinit(struct himax_ts_data *ts)
         |      ^~~~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.c: In function 'himax_platform_init':
>> drivers/hid/hx-hid/hx_core.c:1271:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
    1271 |         int err = PROBE_FAIL;
         |             ^~~
   drivers/hid/hx-hid/hx_core.c: At top level:
>> drivers/hid/hx-hid/hx_core.c:1353:5: warning: no previous prototype for 'himax_spi_drv_probe' [-Wmissing-prototypes]
    1353 | int himax_spi_drv_probe(struct spi_device *spi)
         |     ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/asm-generic/bug.h:22,
                    from ./arch/xtensa/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/xtensa/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/hid.h:19,
                    from drivers/hid/hx-hid/hx_hid.c:16:
   drivers/hid/hx-hid/hx_hid.c: In function 'hx_hid_get_raw_report':
>> drivers/hid/hx-hid/hx_core.h:66:33: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      66 | #define D(fmt, arg...) pr_debug("[HXTP][DEBUG][%s]: " fmt "\n", __func__, ##arg)
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:345:21: note: in definition of macro 'pr_fmt'
     345 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '__dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call'
     269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:579:9: note: in expansion of macro 'dynamic_pr_debug'
     579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.h:66:24: note: in expansion of macro 'pr_debug'
      66 | #define D(fmt, arg...) pr_debug("[HXTP][DEBUG][%s]: " fmt "\n", __func__, ##arg)
         |                        ^~~~~~~~
   drivers/hid/hx-hid/hx_hid.c:264:9: note: in expansion of macro 'D'
     264 |         D("reportnum:%d, len:%lu, report_type:%d", reportnum, len, report_type);
         |         ^
   drivers/hid/hx-hid/hx_hid.c: In function 'hx_hid_set_raw_report':
>> drivers/hid/hx-hid/hx_core.h:66:33: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      66 | #define D(fmt, arg...) pr_debug("[HXTP][DEBUG][%s]: " fmt "\n", __func__, ##arg)
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:345:21: note: in definition of macro 'pr_fmt'
     345 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '__dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call'
     269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:579:9: note: in expansion of macro 'dynamic_pr_debug'
     579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.h:66:24: note: in expansion of macro 'pr_debug'
      66 | #define D(fmt, arg...) pr_debug("[HXTP][DEBUG][%s]: " fmt "\n", __func__, ##arg)
         |                        ^~~~~~~~
   drivers/hid/hx-hid/hx_hid.c:437:9: note: in expansion of macro 'D'
     437 |         D("reportnum:%d, len:%lu, report_type:%d", reportnum, len, report_type);
         |         ^
   drivers/hid/hx-hid/hx_hid.c: In function 'hx_raw_request':
>> drivers/hid/hx-hid/hx_core.h:66:33: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      66 | #define D(fmt, arg...) pr_debug("[HXTP][DEBUG][%s]: " fmt "\n", __func__, ##arg)
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:345:21: note: in definition of macro 'pr_fmt'
     345 | #define pr_fmt(fmt) fmt
         |                     ^~~
   include/linux/dynamic_debug.h:248:9: note: in expansion of macro '__dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:250:9: note: in expansion of macro '_dynamic_func_call_cls'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:269:9: note: in expansion of macro '_dynamic_func_call'
     269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:579:9: note: in expansion of macro 'dynamic_pr_debug'
     579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/hid/hx-hid/hx_core.h:66:24: note: in expansion of macro 'pr_debug'
      66 | #define D(fmt, arg...) pr_debug("[HXTP][DEBUG][%s]: " fmt "\n", __func__, ##arg)
         |                        ^~~~~~~~
   drivers/hid/hx-hid/hx_hid.c:621:9: note: in expansion of macro 'D'
     621 |         D("report num %d, len %lu, rtype %d, reqtype %d", reportnum, len, rtype, reqtype);
         |         ^


vim +/himax_rst_gpio_set +19 drivers/hid/hx-hid/hx_plat.c

    18	
  > 19	void himax_rst_gpio_set(int pinnum, u8 value)
    20	{
    21		gpio_direction_output(pinnum, value);
    22	}
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
