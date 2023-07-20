Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5EC75A868
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjGTH6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjGTH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:58:02 -0400
X-Greylist: delayed 27235 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Jul 2023 00:57:59 PDT
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85763E53
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689839876;
        bh=an71WrnjLaD9cSQUXNnuN1K2s6fzkBRSP3DqyCAY7xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XGhfXM7HM+p2e+KJoOxKl17GNGwVANZElM+9mMnMIo7/MKGf84CoIqw2QDq/yYem/
         vEjZJDquWNpuybqnssF9iTeKARmKCQmT01p5QyACkdZh6im1PkVXbAIEL75RksY3mh
         RRtGlse+GVJTL/vBIvClZU4fjWUCLdLqIFTS5dew=
Received: from localhost ([101.224.148.235])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id E76282B2; Thu, 20 Jul 2023 15:57:54 +0800
X-QQ-mid: xmsmtpt1689839874tbsigx21x
Message-ID: <tencent_FE575E338FC3B44C77562783BE5FD632D808@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjT3DJfoi4fyUUCPWJcz8ja4/fTuCMsKEmIBzkjtxfpp///8HKy8
         JeImRTS16DdenGlzqldaLesVfJiWmZcHpcQBtNQCxvC3ZhSj3dpwcrEhZIIlfWwbIXdOiBosZNI/
         WsmcK+SqQpNXd2oewlwRYQMn47sIecnGMFjslUVMEpipfQLIuWA/mETKc3e2C5YPkJXmhXV1x6iN
         uYSSWp/I9BKTaEJQOQSJ4+Tnz2mMvr3vJ+6Jwsjyx40KkGZMMwhvmWs/em8MUgxkXMHD8U4/vrPm
         d6CIc35TLsS8xO+jRn+yUkbHigmdK89fY6OnJA8W4RjBDkab+b2ochMCkLxAcaPmUVXBtSYk18AG
         hMCl+NPP2e7k86C1z3XDHbuchgl6NVRHX137DJHtcErLJ9faPcTR4lSu7nnRgY7QCIrpQzodgEI4
         iN1oefZ3GS8wSR1XVXGnY/46kBr2V0MsJc0HfjEwrp0P7McjzVmOWs5+ByFrH/Yx/tj+aFOGZlUx
         i+//ONFwuQG2ASMfUoGmyem0snvjjSd1yp59CyLFcnIWWXmwDh8Tee/f4M/5CZtJAXhxwsFjwhJS
         7WS663GvrzP9YIOZaZ4BYrOFgghEvp5gEfLW62JstYVGlULHGDkKQblybp3QjLAy2S7ehQp+Wa1k
         479UZ0L6jQ/W/e5wIF7KD3FA7vOe8D5xDM8NHAfQ4/NpKgllZ4tVqgVVt1Q0hhLYXkYh7DgyLrfA
         nAB6tWisdmpYvizKW2uvDQ2xUQFCjyKPynmGstV+oFM4iw6iG4iiXxwQKU1bphR8hXBCFtOu0jfE
         yheVT8LYTrOcX58km7M3MeL8cF2JJii29u67wWUwH29yUTY04/JE7we1Nz8tcrRHvG3E/sVO7Vpg
         oYHOYyewSX4KJ0GRLTrM2rDyK2FdDotT9Lqhj6WgCfQ2dBf6Ag7a+C8qiRSWsTkyIwJbuE0hw3vk
         0wMrEaVXI6w4uzibrD2HhFbvFIzD2vwEj+D+IBkcRVeeNHTO7ni9S0lsLNN1BsBPnhcvRLLRSXaD
         qKq85Z4CtodVhCEyhwgAdCa7WWzVU=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
Date:   Thu, 20 Jul 2023 15:57:53 +0800
From:   Woody Zhang <woodylab@foxmail.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        ajones@ventanamicro.com
Subject: Re: [PATCH] riscv: add SBI SUSP extension support
X-OQ-MSGID: <ZLjpAbJlH/dV6qwY@dev>
References: <tencent_B931BF1864B6AE8C674686ED9852ACFA0609@qq.com>
 <20230720-speller-suffocate-29ee7cc0b1f6@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720-speller-suffocate-29ee7cc0b1f6@wendy>
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:31:42AM +0100, Conor Dooley wrote:
>Hey Woody,
>
>On Thu, Jul 20, 2023 at 08:23:19AM +0800, Woody Zhang wrote:
>> RISC-V SBI spec 2.0 [1] introduces System Suspend Extension which can be
>> used to suspend the platform via SBI firmware.
>> 
>> This patch can be tested on Qemu with recent OpenSBI with
>> `system-suspend-test` enabled like [2] in DTB.
>> 
>> [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
>> [2] https://github.com/woodyzhang666/qemu/commit/e4a5120133c1dc354e6ac437ec1f870f6c0f6d05
>> 
>> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
>> ---
>>  arch/riscv/include/asm/sbi.h | 10 ++++++++++
>>  arch/riscv/kernel/sbi.c      | 26 ++++++++++++++++++++++++++
>
>There's prior art here, that is seemingly more complete:
>https://lore.kernel.org/all/20230118180338.6484-2-ajones@ventanamicro.com/
>IIRC, the reason it is still in RFC status is that the 2.0 SBI spec is
>not yet frozen, so this cannot be merged.
>

OK. I didn't notice that. Drop this patch then.

Woody

>Thanks,
>Conor.
>
>>  2 files changed, 36 insertions(+)
>> 
>> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
>> index 5b4a1bf5f439..3b04016da671 100644
>> --- a/arch/riscv/include/asm/sbi.h
>> +++ b/arch/riscv/include/asm/sbi.h
>> @@ -30,6 +30,7 @@ enum sbi_ext_id {
>>  	SBI_EXT_HSM = 0x48534D,
>>  	SBI_EXT_SRST = 0x53525354,
>>  	SBI_EXT_PMU = 0x504D55,
>> +	SBI_EXT_SUSP = 0x53555350,
>>  
>>  	/* Experimentals extensions must lie within this range */
>>  	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
>> @@ -236,6 +237,15 @@ enum sbi_pmu_ctr_type {
>>  /* Flags defined for counter stop function */
>>  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
>>  
>> +enum sbi_ext_susp_fid {
>> +	SBI_EXT_SUSP_SYSTEM_SUSPEND = 0,
>> +};
>> +
>> +/* SBI suspend sleep types */
>> +enum sbi_susp_sleep_type {
>> +	SBI_SUSP_SLEEP_TYPE_SUSPEND = 0x0,
>> +};
>> +
>>  #define SBI_SPEC_VERSION_DEFAULT	0x1
>>  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
>>  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>> index c672c8ba9a2a..9a68959f9f18 100644
>> --- a/arch/riscv/kernel/sbi.c
>> +++ b/arch/riscv/kernel/sbi.c
>> @@ -9,8 +9,10 @@
>>  #include <linux/init.h>
>>  #include <linux/pm.h>
>>  #include <linux/reboot.h>
>> +#include <linux/suspend.h>
>>  #include <asm/sbi.h>
>>  #include <asm/smp.h>
>> +#include <asm/suspend.h>
>>  
>>  /* default SBI version is 0.1 */
>>  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>> @@ -520,6 +522,26 @@ static void sbi_srst_power_off(void)
>>  		       SBI_SRST_RESET_REASON_NONE);
>>  }
>>  
>> +static int sbi_system_suspend(unsigned long arg,
>> +		unsigned long resume_entry, unsigned long context)
>> +{
>> +	struct sbiret ret = {0};
>> +
>> +	ret = sbi_ecall(SBI_EXT_SUSP, SBI_EXT_SUSP_SYSTEM_SUSPEND,
>> +			SBI_SUSP_SLEEP_TYPE_SUSPEND, resume_entry, context, 0, 0, 0);
>> +	return ret.error;
>> +}
>> +
>> +static int sbi_system_suspend_enter(suspend_state_t state)
>> +{
>> +	return cpu_suspend(0, sbi_system_suspend);
>> +}
>> +
>> +static const struct platform_suspend_ops sbi_suspend_ops = {
>> +	.valid          = suspend_valid_only_mem,
>> +	.enter          = sbi_system_suspend_enter,
>> +};
>> +
>>  /**
>>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
>>   * @extid: The extension ID to be probed.
>> @@ -624,6 +646,10 @@ void __init sbi_init(void)
>>  			sbi_srst_reboot_nb.priority = 192;
>>  			register_restart_handler(&sbi_srst_reboot_nb);
>>  		}
>> +		if (sbi_probe_extension(SBI_EXT_SUSP)) {
>> +			pr_info("SBI SUSP extension detected\n");
>> +			suspend_set_ops(&sbi_suspend_ops);
>> +		}
>>  	} else {
>>  		__sbi_set_timer = __sbi_set_timer_v01;
>>  		__sbi_send_ipi	= __sbi_send_ipi_v01;
>> -- 
>> 2.39.2
>> 


