Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477C07EB72A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjKNUBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjKNUBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:01:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA1CBC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:00:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A3BC433C8;
        Tue, 14 Nov 2023 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699992058;
        bh=ANs+VJoyEuUhOuZN7nC/BappPROTapJrbUv37+MySGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/5DpUtXVZbLEd5Lmo+ddDRITgpY+Nd+eAf9ggjovl3ePly0ZhDiK/vgdQYVnyBld
         p3/+Xvu4Fo7fsuKAHrHMZctCK3UxMykJ3QYs+tSZ9G3O2AvbIUwMERjLHk8m8e2J0A
         CkFYUoVVaIRV2GrzUPWnpB1dQ7DD/hQRZGF8G5RRRfqsfVSpPlmJ7oVMPfRLJxKg0y
         hXWYQbYrXVU6KAjPRdtTelZ5OUrzS6bBwDmTnEe2zimhT+MbeFsj9ZiOO1Q85El8Hr
         Iux7CugKytHynlHBpNG2tMdy4VAX3SfEp9WCf5UY0Z26ihWbwdQhqQiMFyCIqSwuqg
         JJ5qtSHpbSn9g==
Date:   Tue, 14 Nov 2023 13:00:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>, michal.simek@amd.com,
        gregkh@linuxfoundation.org, tanmay.shah@amd.com,
        mathieu.poirier@linaro.org, nava.kishore.manne@amd.com,
        ben.levinsky@amd.com, sai.krishna.potthuri@amd.com, marex@denx.de,
        robh@kernel.org, ruanjinjie@huawei.com, arnd@arndb.de,
        shubhrajyoti.datta@amd.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Izhar Ameer Shaikh <izhar.ameer.shaikh@amd.com>
Subject: Re: [PATCH v4 1/5] firmware: xilinx: Update firmware call interface
 to support additional args
Message-ID: <20231114200056.GA3377479@dev-arch.thelio-3990X>
References: <20231109070021.16291-2-jay.buddhabhatti@amd.com>
 <202311111439.Hxd4wZ6x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311111439.Hxd4wZ6x-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 02:47:06PM +0800, kernel test robot wrote:
> Hi Jay,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on driver-core/driver-core-testing]
> [also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus staging/staging-testing staging/staging-next staging/staging-linus linus/master v6.6 next-20231110]
> [cannot apply to xilinx-xlnx/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jay-Buddhabhatti/firmware-xilinx-Update-firmware-call-interface-to-support-additional-args/20231109-191827
> base:   driver-core/driver-core-testing
> patch link:    https://lore.kernel.org/r/20231109070021.16291-2-jay.buddhabhatti%40amd.com
> patch subject: [PATCH v4 1/5] firmware: xilinx: Update firmware call interface to support additional args
> config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231111/202311111439.Hxd4wZ6x-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111439.Hxd4wZ6x-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311111439.Hxd4wZ6x-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/firmware/xilinx/zynqmp.c:139:21: warning: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Wvarargs]
>      139 |         va_start(arg_list, num_args);
>          |                            ^
>    drivers/firmware/xilinx/zynqmp.c:129:57: note: parameter of type 'u8' (aka 'unsigned char') is declared here
>      129 | static noinline int do_fw_call_smc(u32 *ret_payload, u8 num_args, ...)
>          |                                                         ^
>    drivers/firmware/xilinx/zynqmp.c:179:21: warning: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Wvarargs]
>      179 |         va_start(arg_list, num_args);
>          |                            ^
>    drivers/firmware/xilinx/zynqmp.c:169:57: note: parameter of type 'u8' (aka 'unsigned char') is declared here
>      169 | static noinline int do_fw_call_hvc(u32 *ret_payload, u8 num_args, ...)
>          |                                                         ^
>    drivers/firmware/xilinx/zynqmp.c:349:21: warning: passing an object that undergoes default argument promotion to 'va_start' has undefined behavior [-Wvarargs]
>      349 |         va_start(arg_list, num_args);
>          |                            ^
>    drivers/firmware/xilinx/zynqmp.c:335:61: note: parameter of type 'u8' (aka 'unsigned char') is declared here
>      335 | int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u8 num_args, ...)
>          |                                                             ^
>    3 warnings generated.

FWIW, this is saying that num_args should be 'int' or 'unsigned int',
see commit be24b37e22c2 ("KEYS: trusted: fix -Wvarags warning") for
another instance of this problem.

Cheers,
Nathan

> vim +/va_start +139 drivers/firmware/xilinx/zynqmp.c
> 
>    119	
>    120	/**
>    121	 * do_fw_call_smc() - Call system-level platform management layer (SMC)
>    122	 * @num_args:		Number of variable arguments should be <= 8
>    123	 * @ret_payload:	Returned value array
>    124	 *
>    125	 * Invoke platform management function via SMC call (no hypervisor present).
>    126	 *
>    127	 * Return: Returns status, either success or error+reason
>    128	 */
>    129	static noinline int do_fw_call_smc(u32 *ret_payload, u8 num_args, ...)
>    130	{
>    131		struct arm_smccc_res res;
>    132		u64 args[8] = {0};
>    133		va_list arg_list;
>    134		u8 i;
>    135	
>    136		if (num_args > 8)
>    137			return -EINVAL;
>    138	
>  > 139		va_start(arg_list, num_args);
>    140	
>    141		for (i = 0; i < num_args; i++)
>    142			args[i] = va_arg(arg_list, u64);
>    143	
>    144		va_end(arg_list);
>    145	
>    146		arm_smccc_smc(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], &res);
>    147	
>    148		if (ret_payload) {
>    149			ret_payload[0] = lower_32_bits(res.a0);
>    150			ret_payload[1] = upper_32_bits(res.a0);
>    151			ret_payload[2] = lower_32_bits(res.a1);
>    152			ret_payload[3] = upper_32_bits(res.a1);
>    153		}
>    154	
>    155		return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
>    156	}
>    157	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
