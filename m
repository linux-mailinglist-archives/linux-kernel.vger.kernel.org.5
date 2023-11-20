Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D445B7F0AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjKTD1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjKTD1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:27:48 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F52F2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:27:43 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SYXt80gPNz1P8bg;
        Mon, 20 Nov 2023 11:24:16 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 Nov 2023 11:27:41 +0800
CC:     <yangyicong@hisilicon.com>, <oe-kbuild-all@lists.linux.dev>,
        <dietmar.eggemann@arm.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <jonathan.cameron@huawei.com>,
        <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: Kconfig: Enable HOTPLUG_SMT
To:     kernel test robot <yujie.liu@intel.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <sudeep.holla@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <202311151900.K9xc6Xqz-lkp@intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <d2454857-009c-ffd3-26fa-a77853f5622d@huawei.com>
Date:   Mon, 20 Nov 2023 11:27:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <202311151900.K9xc6Xqz-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.177]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/16 12:59, kernel test robot wrote:
> Hi Yicong,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus arm/for-next kvmarm/next soc/for-next linus/master arm/fixes v6.7-rc1 next-20231115]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yicong-Yang/arch_topology-Support-basic-SMT-control-for-the-driver/20231114-120544
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20231114040110.54590-5-yangyicong%40huawei.com
> patch subject: [PATCH v3 4/4] arm64: Kconfig: Enable HOTPLUG_SMT
> config: arm64-randconfig-002-20231115 (https://download.01.org/0day-ci/archive/20231115/202311151900.K9xc6Xqz-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311151900.K9xc6Xqz-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Closes: https://lore.kernel.org/r/202311151900.K9xc6Xqz-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/cpu.c: In function 'cpuhp_smt_disable':
>>> kernel/cpu.c:2687:23: error: implicit declaration of function 'cpu_down_maps_locked' [-Werror=implicit-function-declaration]
>     2687 |                 ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
>          |                       ^~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 

cpu_down_maps_locked() is introduced by CONFIG_HOTPLUG_CPU, so CONFIG_HOTPLUG_SMT will need to depend
on CONFIG_HOTPLUG_CPU. Will add it.

> 
> vim +/cpu_down_maps_locked +2687 kernel/cpu.c
> 
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2672  
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2673  int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2674  {
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2675  	int cpu, ret = 0;
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2676  
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2677  	cpu_maps_update_begin();
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2678  	for_each_online_cpu(cpu) {
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2679  		if (topology_is_primary_thread(cpu))
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2680  			continue;
> 38253464bc821d Michael Ellerman 2023-07-05  2681  		/*
> 38253464bc821d Michael Ellerman 2023-07-05  2682  		 * Disable can be called with CPU_SMT_ENABLED when changing
> 38253464bc821d Michael Ellerman 2023-07-05  2683  		 * from a higher to lower number of SMT threads per core.
> 38253464bc821d Michael Ellerman 2023-07-05  2684  		 */
> 38253464bc821d Michael Ellerman 2023-07-05  2685  		if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
> 38253464bc821d Michael Ellerman 2023-07-05  2686  			continue;
> dc8d37ed304eee Arnd Bergmann    2019-12-10 @2687  		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2688  		if (ret)
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2689  			break;
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2690  		/*
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2691  		 * As this needs to hold the cpu maps lock it's impossible
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2692  		 * to call device_offline() because that ends up calling
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2693  		 * cpu_down() which takes cpu maps lock. cpu maps lock
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2694  		 * needs to be held as this might race against in kernel
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2695  		 * abusers of the hotplug machinery (thermal management).
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2696  		 *
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2697  		 * So nothing would update device:offline state. That would
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2698  		 * leave the sysfs entry stale and prevent onlining after
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2699  		 * smt control has been changed to 'off' again. This is
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2700  		 * called under the sysfs hotplug lock, so it is properly
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2701  		 * serialized against the regular offline usage.
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2702  		 */
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2703  		cpuhp_offline_cpu_device(cpu);
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2704  	}
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2705  	if (!ret)
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2706  		cpu_smt_control = ctrlval;
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2707  	cpu_maps_update_done();
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2708  	return ret;
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2709  }
> dc8d37ed304eee Arnd Bergmann    2019-12-10  2710  
> 
