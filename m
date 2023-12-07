Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E10807D12
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441911AbjLGA2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441852AbjLGA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:28:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C34D46;
        Wed,  6 Dec 2023 16:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701908895; x=1733444895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Aeiyg4qx7bpYJygKiaD67EIN+bTA3XdLMvUjVUJSJwI=;
  b=DLPRwAWJ6ydfFloGChDTvDGrXbnD6aKLOH6jq25AX3PA2EhQ+nmmZHCP
   gwkXoRAb96eUtDLnXa/j5/BS0v8llYXG+v1C4yu8Ud/CFQIg9Sk1lD6jm
   urq9QAHCsx0PfBvJzUzScF4gPcDhlXWqrjqi+0tT7051shJjfcT44FEi9
   duPz8m8V1OaWqBM+7Kc6tkuyuyYGUBuYcldc0ARGWNXO8L5fbp2jtM6o2
   Oo/EPb8D/Z26NeHV/s/O1u+xaLF0MGGp/gqKPqx/2Bzw9VqiaxEfCySDM
   QOFSPc3nTo1d1YyLfbNk8T5UX8172yD4TgVFYnF4jlT3k3I4hK1sMZ9Uk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="12863039"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="12863039"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 16:28:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1103009011"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1103009011"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Dec 2023 16:28:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rB2FN-000BdC-2r;
        Thu, 07 Dec 2023 00:28:09 +0000
Date:   Thu, 7 Dec 2023 08:27:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Allen_Lin <allencl_lin@hotmail.com>, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Allen_Lin <allencl_lin@hotmail.com>
Subject: Re: [PATCH v2 2/2] Input: Add Himax HX83102J touchscreen driver
Message-ID: <202312070838.oJSWv4T3-lkp@intel.com>
References: <TY0PR06MB56119F0D60142F4C1435767C9E84A@TY0PR06MB5611.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY0PR06MB56119F0D60142F4C1435767C9E84A@TY0PR06MB5611.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen_Lin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hid/for-next]
[also build test WARNING on dtor-input/next dtor-input/for-linus robh/for-next linus/master v6.7-rc4 next-20231206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Allen_Lin/Input-Add-Himax-HX83102J-touchscreen-driver/20231206-183804
base:   https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-next
patch link:    https://lore.kernel.org/r/TY0PR06MB56119F0D60142F4C1435767C9E84A%40TY0PR06MB5611.apcprd06.prod.outlook.com
patch subject: [PATCH v2 2/2] Input: Add Himax HX83102J touchscreen driver
config: sh-randconfig-r053-20231207 (https://download.01.org/0day-ci/archive/20231207/202312070838.oJSWv4T3-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312070838.oJSWv4T3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070838.oJSWv4T3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/hid-himax-83102j.c:2673:12: warning: 'himax_parse_dt' defined but not used [-Wunused-function]
    2673 | static int himax_parse_dt(struct device_node *dt, struct himax_platform_data *pdata)
         |            ^~~~~~~~~~~~~~


vim +/himax_parse_dt +2673 drivers/hid/hid-himax-83102j.c

  2672	
> 2673	static int himax_parse_dt(struct device_node *dt, struct himax_platform_data *pdata)
  2674	{
  2675		/* pid_fw_name size = length of default_fw_name + length of "_XXXX" +
  2676		 * length of ".bin" + null terminator.
  2677		 */
  2678		static char pid_fw_name[ARRAY_SIZE(default_fw_name) + 5 + 4 + 1] = {0};
  2679		int tmp = 0;
  2680		const int pid_prop_args = 2;
  2681		u32 data = 0;
  2682		int id_gpios[8] = {0};
  2683		int counter = 0;
  2684		int i = 0;
  2685		s16 id_value = -1;
  2686		int dts_irq = 0;
  2687		int err = 0;
  2688	
  2689		UNUSED(default_fw_name);
  2690		if (!dt || !pdata) {
  2691			E("DT: dev or pdata is NULL");
  2692			return -EINVAL;
  2693		}
  2694	
  2695		dts_irq = of_irq_get(dt, 0);
  2696		D("DT: dts_irq = %d", dts_irq);
  2697		if (dts_irq <= 0) {
  2698			if (dts_irq == -EPROBE_DEFER)
  2699				E("DT: dts_irq = -EPROBE_DEFER");
  2700			return -EIO;
  2701		}
  2702	
  2703		pdata->of_irq = dts_irq;
  2704		pdata->gpio_irq = -1;
  2705	
  2706		pdata->gpio_reset = of_get_named_gpio(dt, "reset-gpios", 0);
  2707		if (!gpio_is_valid(pdata->gpio_reset)) {
  2708			I(" DT:gpio-rst value is not valid");
  2709			return -EIO;
  2710		}
  2711	
  2712		I(" DT:interrupt=%d, reset=%d",
  2713		  pdata->of_irq, pdata->gpio_reset);
  2714		counter = gpiod_count(pdata->ts->dev, "himax,id");
  2715		if (counter > 0) {
  2716			for (i = 0 ; i < counter ; i++) {
  2717				id_gpios[i] = of_get_named_gpio(dt, "himax,id-gpios", i);
  2718				if (!gpio_is_valid(id_gpios[i])) {
  2719					I(" DT:gpio-id value is not valid");
  2720					return -EIO;
  2721				}
  2722				I(" DT:gpio-id[%d]=%d", i, id_gpios[i]);
  2723			}
  2724			id_value = 0;
  2725			for (i = 0 ; i < counter ; i++) {
  2726				gpio_direction_input(id_gpios[i]);
  2727				id_value |= gpio_get_value(id_gpios[i]) << i;
  2728			}
  2729			I(" DT:gpio-id value=%04X", id_value);
  2730			pdata->panel_id = id_value;
  2731		} else {
  2732			pdata->panel_id = -1;
  2733			D(" DT:gpio-id not found");
  2734		}
  2735	
  2736		// himax,ic_det_delay unit is millisecond
  2737		if (of_property_read_u32(dt, "himax,ic-det-delay-ms", &data)) {
  2738			pdata->ic_det_delay = 0;
  2739			D(" DT:himax,ic-det-delay-ms not found");
  2740		} else {
  2741			pdata->ic_det_delay = data;
  2742			I(" DT:himax,ic-det-delay-ms=%d", pdata->ic_det_delay);
  2743		}
  2744	
  2745		// himax,ic_resume_delay unit is millisecond
  2746		if (of_property_read_u32(dt, "himax,ic-resume-delay-ms", &data)) {
  2747			pdata->ic_resume_delay = 0;
  2748			D(" DT:himax,ic-resume-delay-ms not found");
  2749		} else {
  2750			pdata->ic_resume_delay = data;
  2751			I(" DT:himax,ic-resume-delay-ms=%d", pdata->ic_resume_delay);
  2752		}
  2753	
  2754		if (of_property_read_bool(dt, "himax,has-flash")) {
  2755			pdata->is_zf = false;
  2756			D(" DT:himax,has-flash");
  2757		} else {
  2758			pdata->is_zf = true;
  2759			I(" DT:himax,has-flash not found, load firmware from file");
  2760		}
  2761	
  2762		if (of_property_read_bool(dt, "vccd-supply")) {
  2763			pdata->vccd_supply = regulator_get(pdata->ts->dev, "vccd");
  2764			if (IS_ERR(pdata->vccd_supply)) {
  2765				E(" DT:failed to get vccd supply");
  2766				err = PTR_ERR(pdata->vccd_supply);
  2767				pdata->vccd_supply = NULL;
  2768				return err;
  2769			}
  2770			I(" DT:vccd-supply=%p", pdata->vccd_supply);
  2771		} else {
  2772			pdata->vccd_supply = NULL;
  2773		}
  2774	
  2775		if (of_property_read_bool(dt, "vcca-supply")) {
  2776			pdata->vcca_supply = regulator_get(pdata->ts->dev, "vcca");
  2777			if (IS_ERR(pdata->vcca_supply)) {
  2778				E(" DT:failed to get vcca supply");
  2779				err = PTR_ERR(pdata->vcca_supply);
  2780				pdata->vcca_supply = NULL;
  2781				return err;
  2782			}
  2783			I(" DT:vcca-supply=%p", pdata->vcca_supply);
  2784		} else {
  2785			pdata->vcca_supply = NULL;
  2786		}
  2787	
  2788		/*
  2789		 * check himax,pid first, if exist then check if it is single.
  2790		 * Single case: himax,pid = <0x1002>; // 0x1002 is pid value
  2791		 * Multiple case: himax,pid = <id_value0 00x1001>, <id_value1 0x1002>;
  2792		 * When id_value >= 0, check the mapping listed to use the pid value.
  2793		 */
  2794		if (of_get_property(dt, "himax,pid", &data)) {
  2795			counter = data / (sizeof(u32) * pid_prop_args);
  2796	
  2797			if (!counter) {
  2798				// default case, no id->pid mappings
  2799				if (of_property_read_u32(dt, "himax,pid", &data)) {
  2800					pdata->pid = 0;
  2801					D(" DT:himax,pid not found");
  2802					goto GET_PID_END;
  2803				} else {
  2804					goto GET_PID_VALUE;
  2805				}
  2806			}
  2807	
  2808			if (id_value < 0) {
  2809				E(" DT:himax,pid has no matched for id_value=%04X", id_value);
  2810				pdata->pid = 0;
  2811				goto GET_PID_END;
  2812			}
  2813	
  2814			for (i = 0; i < counter; i++) {
  2815				if (of_property_read_u32_index(dt, "himax,pid",
  2816							       i * pid_prop_args, &tmp)) {
  2817					D(" DT:himax,pid parsing error!");
  2818					pdata->pid = 0;
  2819					goto GET_PID_END;
  2820				}
  2821	
  2822				if (of_property_read_u32_index(dt, "himax,pid",
  2823							       i * pid_prop_args + 1, &data)) {
  2824					D(" DT:himax,pid parsing error!");
  2825					pdata->pid = 0;
  2826					goto GET_PID_END;
  2827				}
  2828	
  2829				if (tmp == id_value) {
  2830					I(" DT:himax,pid mapping: id=%04X => pid=%04X, matched!",
  2831					  tmp, data);
  2832					i = counter;
  2833				} else {
  2834					I(" DT:himax,pid mapping: id=%04X => pid=%04X", tmp, data);
  2835				}
  2836			}
  2837	
  2838			if (counter == i) {
  2839				E(" DT:himax,pid has no matched for id_value=%04X", id_value);
  2840				pdata->pid = 0;
  2841				goto GET_PID_END;
  2842			}
  2843	
  2844	GET_PID_VALUE:
  2845			g_fw_boot_upgrade_name = pid_fw_name;
  2846			pdata->pid = data;
  2847			snprintf(pid_fw_name, sizeof(pid_fw_name), "%s_%04X%s",
  2848				 BOOT_UPGRADE_FWNAME, pdata->pid, ".bin");
  2849			I(" DT:himax,pid=%04X, fw_name=%s",
  2850			  pdata->pid, pid_fw_name);
  2851		} else {
  2852			pdata->pid = 0;
  2853			D(" DT:himax,pid not found");
  2854		}
  2855	GET_PID_END:
  2856	
  2857		return 0;
  2858	}
  2859	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
