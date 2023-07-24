Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8510075FE93
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjGXRzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGXRzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:55:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1819444AA;
        Mon, 24 Jul 2023 10:53:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666e916b880so2665084b3a.2;
        Mon, 24 Jul 2023 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690221188; x=1690825988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=09VDaxK56psBIcQ3p+KkL/r9s9OSq7jrm2adGBWzyKI=;
        b=oQQYUHIMHaQ+iTqyIPO8O53dHQy5kAboZJO6kf662+eW7q/ObrDDScRT3Dd931VQGR
         x56cS7RAk/j+JMz0+ZsaygddRfntaVW3BPKSLnHjVMOyo0+tC181yV34OVhxadWZWAnV
         7vnG4hn5iKCsA79hRFkDd1lvlbuBh1Yw0mXXdqJptgfiSAZ4N5PxGs/AURR5Hrd5Y8iq
         799s2DY0Zhbg/JAyPrqljfKqXSW98jXEmG6UbWNXh2RMdjWjcPlxjeB7sY2cIrdsleSm
         E2OlQtpQaysZUAv0KdwjuxUtebN6DCDu7lXjVvo0KyLIb5BiLEvDaFMzVqTcosX5ApEH
         3aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690221188; x=1690825988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09VDaxK56psBIcQ3p+KkL/r9s9OSq7jrm2adGBWzyKI=;
        b=Jk49ae42q3Hh5tCUqIjAp8rCz5nLER/5I0PFbGbyN4fbp50X4DczQFklavljr5Ja+V
         ToGOoGvuvSVx5s3XScYlT5V52bWFUw5ogkulNkC2kRwhhwrQ/ed/qgvQbx0H0UV4GmU4
         xah/LGHuJDQ0Q/BoqBXX0I9wTYA7wti2w64/mNkb6n7JxXh79+lurbjlxAlP+JGDrjiP
         Vmdp4yQOav/4kK80P6FkSQOL92x+N8RcG+4jvduIs+zs7397FvFqgS6/1VHiNp6Xwt1S
         jHuR0tWiWSTjvB6/hS8G+mrYTGOb6JJL2FP/qHuzuly7bxTy1BOsXERjFnNemVuu+dc5
         txAQ==
X-Gm-Message-State: ABy/qLbpUAs+FsJm5MXBVkcem5H+4lu8Ul3kULDbOq9dPVXF4zwGEI6Z
        X+kmUpsBicWiVL3/jF980QY=
X-Google-Smtp-Source: APBJJlFICbKfcU0+RJ6+we74AuAVQY/03hWGryjEpMNQSGW4qgnbOtdQPbGT7+R0JhLEm/3e4WSqyA==
X-Received: by 2002:a05:6a20:7d9f:b0:123:828f:68c with SMTP id v31-20020a056a207d9f00b00123828f068cmr9862379pzj.50.1690221187819;
        Mon, 24 Jul 2023 10:53:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j2-20020aa78002000000b0068659489a33sm7953771pfi.163.2023.07.24.10.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 10:53:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <34652b37-9e71-8f23-bd0b-12b6a8faa81b@roeck-us.net>
Date:   Mon, 24 Jul 2023 10:53:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 05/29] hwmon: (fam15h_power) Use topology_core_id()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
References: <20230724155329.474037902@linutronix.de>
 <20230724172843.988600888@linutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230724172843.988600888@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/23 10:43, Thomas Gleixner wrote:
> Use the provided topology helper function instead of fiddling in cpu_data.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-hwmon@vger.kernel.org
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Guenter Roeck <linux@roeck-us.net>

Assuming this will be applied as part of the series:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Please let me know if you want me to apply the patch through
the hardware monitoring branch.

Thanks,
Guenter

> ---
>   drivers/hwmon/fam15h_power.c |    7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --- a/drivers/hwmon/fam15h_power.c
> +++ b/drivers/hwmon/fam15h_power.c
> @@ -17,6 +17,7 @@
>   #include <linux/cpumask.h>
>   #include <linux/time.h>
>   #include <linux/sched.h>
> +#include <linux/topology.h>
>   #include <asm/processor.h>
>   #include <asm/msr.h>
>   
> @@ -134,15 +135,13 @@ static DEVICE_ATTR_RO(power1_crit);
>   static void do_read_registers_on_cu(void *_data)
>   {
>   	struct fam15h_power_data *data = _data;
> -	int cpu, cu;
> -
> -	cpu = smp_processor_id();
> +	int cu;
>   
>   	/*
>   	 * With the new x86 topology modelling, cpu core id actually
>   	 * is compute unit id.
>   	 */
> -	cu = cpu_data(cpu).cpu_core_id;
> +	cu = topology_core_id(smp_processor_id());
>   
>   	rdmsrl_safe(MSR_F15H_CU_PWR_ACCUMULATOR, &data->cu_acc_power[cu]);
>   	rdmsrl_safe(MSR_F15H_PTSC, &data->cpu_sw_pwr_ptsc[cu]);
> 

