Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0A7901C6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350488AbjIASDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbjIASDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:03:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90AB10F9;
        Fri,  1 Sep 2023 11:03:07 -0700 (PDT)
X-QQ-mid: bizesmtpipv603t1693591365tc0e
Received: from [IPV6:240e:398:5b8:6a10:659b:2f ( [255.196.164.7])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 02 Sep 2023 02:02:43 +0800 (CST)
X-QQ-SSF: 00200000000000907000000A0000000
X-QQ-FEAT: 2aB7Y8UOkmO/FWd+0tukTaBuCUc5B9Kpdp2CqVWh+UQ/JNBfPLOcOnR+zs8LL
        V9elXGHWGR06Jj4lb/4VZvGhB5t7IPWzAe1oFbhoLAT824Rr2X1zS7Q4t7+m3g9RJrkc2mO
        8cYFmPyjjdTGjDGWmVXDLO11dAnwmPjUnQt1GD/Zf4YeI3AQ4Kf39J0nYVO0Ymd9K/pukXf
        1p6w1n7OcXQyWcRbve9eX7Fe7WyyvDsyAfE/3Qgkqsfjr+KqYRpc7vnl86Mr96X+RmBsmgW
        XxAUQePGdKfG7Hq8F/JK7AB4DqoEwNEN+eRjkaftUIraQoNUQQPBs2c5XqHcB9mFW1QDiZ/
        iSkKcKO
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10417770983749050933
Message-ID: <068519AD74A8CD7C+60cefdac-3b62-4df4-b973-38210f95f630@tinylab.org>
Date:   Sat, 2 Sep 2023 02:02:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] kconfig: add dependencies of POWER_RESET for
 PowerMac
Content-Language: en-GB
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
Cc:     "linux@weissschuh.net" <linux@weissschuh.net>,
        "w@1wt.eu" <w@1wt.eu>, "falcon@tinylab.org" <falcon@tinylab.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1693535514.git.tanyuan@tinylab.org>
 <60cbfd566777a6d6e3664d7f29fa91424716c873.1693535514.git.tanyuan@tinylab.org>
 <420a82eb-f6ed-7daf-6ca9-f14de7078b0d@csgroup.eu>
From:   Yuan Tan <tanyuan@tinylab.org>
In-Reply-To: <420a82eb-f6ed-7daf-6ca9-f14de7078b0d@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=3.0 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_ILLEGAL_IP,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/1/2023 2:10 PM, Christophe Leroy wrote:
>
> Le 01/09/2023 à 04:43, Yuan Tan a écrit :
>> PowerMac's power off depends on ADB_CUDA to work. Enable it when
>> POWER_RESET is set for convenience.
>>
>> Suggested-by: Zhangjin Wu <falcon@tinylab.org>
>> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
>> ---
>>    arch/powerpc/platforms/powermac/Kconfig | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
>> index 130707ec9f99..9e633d7e8367 100644
>> --- a/arch/powerpc/platforms/powermac/Kconfig
>> +++ b/arch/powerpc/platforms/powermac/Kconfig
>> @@ -2,6 +2,7 @@
>>    config PPC_PMAC
>>    	bool "Apple PowerMac based machines"
>>    	depends on PPC_BOOK3S && CPU_BIG_ENDIAN
>> +	select ADB_CUDA if POWER_RESET
> ADB_CUDA depends on !PPC_PMAC64.
>
> What will happen if PPC_PMAC64 is selected ?
>
>>    	select MPIC
>>    	select FORCE_PCI
>>    	select PPC_INDIRECT_PCI if PPC32

I didn't notice that ADB_CUDA depends on !PPC_PMAC64. In the case where 
PPC_PMAC64 is set, ADB_CUDA indeed should not be enabled. Thank you for 
pointing that out.

I will fix it in v3 and check again in x86 and mips :)


