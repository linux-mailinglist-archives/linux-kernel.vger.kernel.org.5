Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B31978E44C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbjHaB0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbjHaB0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:26:07 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C124E1A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:26:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rbk540csCz4f3l1x
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:26:00 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgDHVqkn7O9kTDn0Bw--.61999S3;
        Thu, 31 Aug 2023 09:26:01 +0800 (CST)
Subject: Re: [PATCH v2 1/8] crash_core.c: remove unnecessary parameter of
 function
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        samuel.holland@sifive.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-2-bhe@redhat.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <d00bf2e8-3022-64a1-0458-56497179d5aa@huaweicloud.com>
Date:   Thu, 31 Aug 2023 09:25:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20230829121610.138107-2-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgDHVqkn7O9kTDn0Bw--.61999S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr48Aw1kAF13XrykXw43ZFb_yoW8Cw4kpr
        y8JF45Cry5JF1vkw12yr93CrW8Aw4rAa43uF9akF1rKF9rKasxtr43Ww17Xr4UKr4Y93W2
        yr4SqFnIk3W0v3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/29 20:16, Baoquan He wrote:
> In all call sites of __parse_crashkernel(), the parameter 'name' is
> hardcoded as "crashkernel=". So remove the unnecessary parameter 'name',
> add local varibale 'name' inside __parse_crashkernel() instead.

Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>

> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  kernel/crash_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 90ce1dfd591c..f27b4e45d410 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -241,11 +241,11 @@ static int __init __parse_crashkernel(char *cmdline,
>  			     unsigned long long system_ram,
>  			     unsigned long long *crash_size,
>  			     unsigned long long *crash_base,
> -			     const char *name,
>  			     const char *suffix)
>  {
>  	char	*first_colon, *first_space;
>  	char	*ck_cmdline;
> +	char	*name = "crashkernel=";
>  
>  	BUG_ON(!crash_size || !crash_base);
>  	*crash_size = 0;
> @@ -283,7 +283,7 @@ int __init parse_crashkernel(char *cmdline,
>  			     unsigned long long *crash_base)
>  {
>  	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -					"crashkernel=", NULL);
> +				NULL);
>  }
>  
>  int __init parse_crashkernel_high(char *cmdline,
> @@ -292,7 +292,7 @@ int __init parse_crashkernel_high(char *cmdline,
>  			     unsigned long long *crash_base)
>  {
>  	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
> +				suffix_tbl[SUFFIX_HIGH]);
>  }
>  
>  int __init parse_crashkernel_low(char *cmdline,
> @@ -301,7 +301,7 @@ int __init parse_crashkernel_low(char *cmdline,
>  			     unsigned long long *crash_base)
>  {
>  	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> -				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
> +				suffix_tbl[SUFFIX_LOW]);
>  }
>  
>  /*
> 

-- 
Regards,
  Zhen Lei

