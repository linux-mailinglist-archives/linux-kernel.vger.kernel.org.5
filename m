Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068D6768A34
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 05:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGaDFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 23:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGaDFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 23:05:05 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C982E68
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 20:05:01 -0700 (PDT)
X-ASG-Debug-ID: 1690772696-086e23186b028e0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id JxPU5Z9VaPBfy4dB (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 31 Jul 2023 11:04:56 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 11:04:56 +0800
Received: from [192.168.111.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Mon, 31 Jul
 2023 11:04:55 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <5930f9bc-7a38-696e-231d-6d8b7ef55dbf@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.111.204
Date:   Mon, 31 Jul 2023 11:04:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwrng: add Zhaoxin HW RNG driver
To:     Martin Kaiser <lists@kaiser.cx>
X-ASG-Orig-Subj: Re: [PATCH] hwrng: add Zhaoxin HW RNG driver
CC:     <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
        <jiajie.ho@starfivetech.com>, <conor.dooley@microchip.com>,
        <mmyangfl@gmail.com>, <jenny.zhang@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <leoliu@zhaoxin.com>, <CobeChen@zhaoxin.com>,
        <YunShen@zhaoxin.com>, <TonyWWang@zhaoxin.com>
References: <20230726113553.1965627-1-LeoLiu-oc@zhaoxin.com>
 <20230726121301.kbkskd23mwoptvvx@viti.kaiser.cx>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20230726121301.kbkskd23mwoptvvx@viti.kaiser.cx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1690772696
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 9106
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.112103
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/26 20:13, Martin Kaiser 写道:
> Hi,
> 
> some quick remarks. Feel free to correct me if I misunderstood
> something.
> 
Thank you very much for your advice, I will fix them in the next version.

> LeoLiu-oc (LeoLiu-oc@zhaoxin.com) wrote:
> 
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
>> Add support for Zhaoxin HW RNG.
> 
>> Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
>> ---
>>   drivers/char/hw_random/Kconfig       |  13 +++
>>   drivers/char/hw_random/Makefile      |   1 +
>>   drivers/char/hw_random/via-rng.c     |  17 ++--
>>   drivers/char/hw_random/zhaoxin-rng.c | 116 +++++++++++++++++++++++++++
>>   4 files changed, 139 insertions(+), 8 deletions(-)
>>   create mode 100644 drivers/char/hw_random/zhaoxin-rng.c
> 
>> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
>> index e0b3786ca51b..3b3c00e87b7b 100644
>> --- a/drivers/char/hw_random/Kconfig
>> +++ b/drivers/char/hw_random/Kconfig
>> @@ -150,6 +150,19 @@ config HW_RANDOM_VIA
> 
>>   	  If unsure, say Y.
> 
>> +config HW_RANDOM_ZHAOXIN
>> +	tristate "Zhaoxin HW Random Number Generator support"
>> +	depends on X86
> 
> depends on X86 || COMPILE_TEST >
Thanks for your advice. I will add it in the next version.

>> +	default HW_RANDOM
>> +	help
>> +	  This driver provides kernel-side support for the Random Number
>> +	  Generator hardware found on Zhaoxin based motherboards.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called zhaoxin-rng.
>> +
>> +	  If unsure, say Y.
>> +
>>   config HW_RANDOM_IXP4XX
>>   	tristate "Intel IXP4xx NPU HW Pseudo-Random Number Generator support"
>>   	depends on ARCH_IXP4XX || COMPILE_TEST
>> diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
>> index 32549a1186dc..ef5b3ae0794d 100644
>> --- a/drivers/char/hw_random/Makefile
>> +++ b/drivers/char/hw_random/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o
>>   obj-$(CONFIG_HW_RANDOM_N2RNG) += n2-rng.o
>>   n2-rng-y := n2-drv.o n2-asm.o
>>   obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
>> +obj-$(CONFIG_HW_RANDOM_ZHAOXIN) += zhaoxin-rng.o
>>   obj-$(CONFIG_HW_RANDOM_EXYNOS) += exynos-trng.o
>>   obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
>>   obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
>> diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
>> index a9a0a3b09c8b..33a6e2fdacd1 100644
>> --- a/drivers/char/hw_random/via-rng.c
>> +++ b/drivers/char/hw_random/via-rng.c
>> @@ -135,7 +135,7 @@ static int via_rng_init(struct hwrng *rng)
>>   	 * is always enabled if CPUID rng_en is set.  There is no
>>   	 * RNG configuration like it used to be the case in this
>>   	 * register */
>> -	if (((c->x86 == 6) && (c->x86_model >= 0x0f))  || (c->x86 > 6)){
>> +	if ((c->x86 == 6) && (c->x86_model >= 0x0f)) {
>>   		if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
>>   			pr_err(PFX "can't enable hardware RNG "
>>   				"if XSTORE is not enabled\n");
>> @@ -191,13 +191,20 @@ static struct hwrng via_rng = {
>>   	.data_read	= via_rng_data_read,
>>   };
> 
>> +static const struct x86_cpu_id via_rng_cpu_ids[] = {
>> +	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_ids);
> 
>>   static int __init via_rng_mod_init(void)
>>   {
>>   	int err;
> 
>> -	if (!boot_cpu_has(X86_FEATURE_XSTORE))
>> +	if (!x86_match_cpu(via_rng_cpu_ids)) {
>> +		pr_err(PFX "The CPU isn't support XSTORE.\n");
> 
> doesn't support
> 
> Generally: Should we print an error message if our driver doesn't
> support this cpu? It seems that most other callers of x86_match_cpu
> simply return without an error message.
>Agree with you. I will remove it in the next version.

>>   		return -ENODEV;
>> +	}
> 
>>   	pr_info("VIA RNG detected\n");
>>   	err = hwrng_register(&via_rng);
>> @@ -217,11 +224,5 @@ static void __exit via_rng_mod_exit(void)
>>   }
>>   module_exit(via_rng_mod_exit);
> 
>> -static struct x86_cpu_id __maybe_unused via_rng_cpu_id[] = {
>> -	X86_MATCH_FEATURE(X86_FEATURE_XSTORE, NULL),
>> -	{}
>> -};
>> -MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
>> -
>>   MODULE_DESCRIPTION("H/W RNG driver for VIA CPU with PadLock");
>>   MODULE_LICENSE("GPL");
>> diff --git a/drivers/char/hw_random/zhaoxin-rng.c b/drivers/char/hw_random/zhaoxin-rng.c
>> new file mode 100644
>> index 000000000000..2e657b227c5b
>> --- /dev/null
>> +++ b/drivers/char/hw_random/zhaoxin-rng.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * RNG driver for Zhaoxin RNGs
>> + *
>> + * Copyright 2005 (c) MontaVista Software, Inc.
> 
> Should this be Copyright 2023 by you? >
OK, I will add Copyright information correctly in the next version.

>> + *
>> + * with the majority of the code coming from:
>> + *
>> + * Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
>> + * (c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
>> + *
>> + * derived from
>> + *
>> + * Hardware driver for the AMD 768 Random Number Generator (RNG)
>> + * (c) Copyright 2001 Red Hat Inc
>> + *
>> + * derived from
>> + *
>> + * Hardware driver for Intel i810 Random Number Generator (RNG)
>> + * Copyright 2000,2001 Jeff Garzik <jgarzik@pobox.com>
>> + * Copyright 2000,2001 Philipp Rumpf <prumpf@mandrakesoft.com>
>> + *
>> + * This file is licensed under  the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <crypto/padlock.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/hw_random.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/cpufeature.h>
>> +#include <asm/cpu_device_id.h>
>> +#include <asm/fpu/api.h>
>> +
>> +enum {
>> +	ZHAOXIN_RNG_CHUNK_8		= 0x00, /* 64 rand bits, 64 stored bits*/
>> +	ZHAOXIN_RNG_CHUNK_4		= 0x01, /* 32 rand bits, 32 stored bits */
>> +	ZHAOXIN_RNG_CHUNK_2		= 0x02, /* 16 rand bits, 32 stored bits */
>> +	ZHAOXIN_RNG_CHUNK_1		= 0x03, /* 8 rand bits, 32 stored bits */
>> +	ZHAOXIN_RNG_MAX_SIZE		= (128*1024),
>> +};
>> +
>> +static int zhaoxin_rng_init(struct hwrng *rng)
>> +{
>> +	if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
>> +		pr_err(PFX "can't enable hardware RNG if XSTORE is not enabled\n");
>> +		return -ENODEV;
>> +	}
> 
> Can't we check this when the driver is loaded? (This init function here
> is called when the rng becomes active.) >
The XSTORE feature has two related macro definitions,X86_FEATURE_XSTORE 
and X86_FEATURE_XSTORE_EN.Indicates that the XSTORE feature is present 
and enabled,respectively. X86_FEATURE_XSTORE has been checked when the 
driver is loaded. X86_FEATURE_XSTORE_EN is placed in the init function 
to check whether it is enabled.

This is also a reference to other driver, such as via-rng.c.

>> +	return 0;
>> +}
>> +
>> +static inline int rep_xstore(size_t size, size_t factor, void *result)
>> +{
>> +	__asm__ __volatile__ (
>> +	"movq %0, %%rcx\n"
>> +	"movq %1, %%rdx\n"
>> +	"movq %2, %%rdi\n"
>> +	".byte 0xf3, 0x0f, 0xa7, 0xc0"
>> +	:
>> +	: "r"(size), "r"(factor), "r"(result)
>> +	: "%rcx", "%rdx", "%rdi", "memory");
>> +
>> +	return 0;
>> +}
>> +
>> +static int zhaoxin_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>> +{
>> +	if (max > ZHAOXIN_RNG_MAX_SIZE)
>> +		max = ZHAOXIN_RNG_MAX_SIZE;
>> +	rep_xstore(max, ZHAOXIN_RNG_CHUNK_1, data);
>> +	return max;
>> +}
>> +
>> +static struct hwrng zhaoxin_rng = {
>> +	.name   = "zhaoxin",
>> +	.init   = zhaoxin_rng_init,
>> +	.read   = zhaoxin_rng_read,
>> +};
>> +
>> +static const struct x86_cpu_id zhaoxin_rng_cpu_ids[] = {
>> +	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 6, X86_FEATURE_XSTORE, NULL),
>> +	X86_MATCH_VENDOR_FAM_FEATURE(ZHAOXIN, 7, X86_FEATURE_XSTORE, NULL),
>> +	X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 7, X86_FEATURE_XSTORE, NULL),
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(x86cpu, zhaoxin_rng_cpu_ids);
>> +
>> +static int __init zhaoxin_rng_mod_init(void)
>> +{
>> +	int err;
>> +
>> +	if (!x86_match_cpu(zhaoxin_rng_cpu_ids)) {
>> +		pr_err(PFX "The CPU isn't support XSTORE.\n");
> 
> Yet again, is this really an error?
> 
Yes, as discussed above. I will fix it in the next version.

>> +		return -ENODEV;
>> +	}
>> +
>> +	pr_info("Zhaoxin RNG detected\n");
>> +	err = hwrng_register(&zhaoxin_rng);
>> +	if (err)
>> +		pr_err(PFX "RNG registering failed (%d)\n", err);
>> +
>> +	return err;
>> +}
>> +module_init(zhaoxin_rng_mod_init);
>> +
>> +static void __exit zhaoxin_rng_mod_exit(void)
>> +{
>> +	hwrng_unregister(&zhaoxin_rng);
>> +}
>> +module_exit(zhaoxin_rng_mod_exit);
>> +MODULE_DESCRIPTION("H/W RNG driver for Zhaoxin CPU");
>> +MODULE_AUTHOR("YunShen@zhaoxin.com");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.34.1
> 
> Best regards,
> Martin
