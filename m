Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5757B7A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbjJDIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbjJDIdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:33:39 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFBEC9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:33:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so367782a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696408413; x=1697013213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESJK41d6OgR3seh2ygAk4MlFIHKl40A8SsuP64iwTcA=;
        b=jYhf+MF52bILhuLEoUu1mLqPNjCIC+W+TJae5eYCN0nlEZeim8Jzpctr6k6U7WGmyw
         15oWtSpHGF7Njob+3o+7WTgaJn4FfS2FiE7LQntORR5qkPeyNnELyFd0fOkzINWW9QrH
         C9Xlw92txGykMY+FyRfXzJZEq1SgvCf+idYYWCn32JbNeymJPb8gvwEOgaaT4tZb2pur
         7xOe0rFPB0ADTZbca0PEnPpT3Ep1oBpOLNIVhzi8DYH/SzNXmR/sDgmWzwZidXLUdYuk
         +iWRyy8PtllPa9O8VFIO6KIJN328mYIkYBEK38G/1GIIe7ye6BLo030clbtTyVauHTt+
         88tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408413; x=1697013213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESJK41d6OgR3seh2ygAk4MlFIHKl40A8SsuP64iwTcA=;
        b=eZ+YHduPARYHKgi4BmNrb1FUqEkgbgnA7ErC61t+Dp14ssTC/rGlO7rZ8uckI/pI4j
         wxbuJBhx9B1gWC2Hbyr1k0oB8MZNg+62dQPx6LfKuIS5sPdF3ufqxzlU/MgnsRoBlzlc
         P5woKjnDQDXVcg280OtxDXWlq+udmo7YnAXFPoKR3DFX9H4sqqKvf67B6BefV86H6Owb
         CcaeZrlFwvO/mBtdowmusAp4y0QYyLPgKj4R/c1fc9gMXIqNMSPUktrXF80zKluFLxd3
         o937LAdXNMXGLK6hVNUhZM4OvzvCIoLhRejv/9vEf95kH/pPhC3r22mv4Wqh7mVsAEPz
         0Cqw==
X-Gm-Message-State: AOJu0YyCxpqft9B+oSYzcqRX+/g4KdG3GT5TLUIJ/b6MDuTsrTJL7abH
        h5MFV0E5hus5oWWqf8aWWQLfyQ==
X-Google-Smtp-Source: AGHT+IHsdVSR3lB99ndZrLstTMj2simAYzH+/ZkHt3CEzPElAq0jjok3rxxGVIpBP3HZkwlLU0Q4TA==
X-Received: by 2002:a05:6402:1843:b0:522:580f:8c75 with SMTP id v3-20020a056402184300b00522580f8c75mr1245485edy.17.1696408412466;
        Wed, 04 Oct 2023 01:33:32 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id w9-20020aa7dcc9000000b00537708be5c6sm2069890edu.73.2023.10.04.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:33:32 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:33:31 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 -next 3/4] RISC-V: cacheflush: Initialize CBO
 variables on ACPI systems
Message-ID: <20231004-58af76b11b3db2e64a93fd55@orel>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-4-sunilvl@ventanamicro.com>
 <f4ab7464-3dfb-4d10-8bed-76e7084abd3e@sifive.com>
 <ZRzof1sH/GJNQp4V@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRzof1sH/GJNQp4V@sunil-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 09:52:23AM +0530, Sunil V L wrote:
> On Tue, Oct 03, 2023 at 02:50:02PM -0500, Samuel Holland wrote:
> > On 2023-09-27 12:00 PM, Sunil V L wrote:
> > > Using new interface to get the CBO block size information in RHCT,
> > > initialize the variables on ACPI platforms.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  arch/riscv/mm/cacheflush.c | 37 +++++++++++++++++++++++++++++++------
> > >  1 file changed, 31 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > > index f1387272a551..8e59644e473c 100644
> > > --- a/arch/riscv/mm/cacheflush.c
> > > +++ b/arch/riscv/mm/cacheflush.c
> > > @@ -3,7 +3,9 @@
> > >   * Copyright (C) 2017 SiFive
> > >   */
> > >  
> > > +#include <linux/acpi.h>
> > >  #include <linux/of.h>
> > > +#include <asm/acpi.h>
> > >  #include <asm/cacheflush.h>
> > >  
> > >  #ifdef CONFIG_SMP
> > > @@ -124,15 +126,38 @@ void __init riscv_init_cbo_blocksizes(void)
> > >  	unsigned long cbom_hartid, cboz_hartid;
> > >  	u32 cbom_block_size = 0, cboz_block_size = 0;
> > >  	struct device_node *node;
> > > +	struct acpi_table_header *rhct;
> > > +	acpi_status status;
> > > +	unsigned int cpu;
> > > +
> > > +	if (!acpi_disabled) {
> > > +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> > > +		if (ACPI_FAILURE(status))
> > > +			return;
> > > +	}
> > >  
> > > -	for_each_of_cpu_node(node) {
> > > -		/* set block-size for cbom and/or cboz extension if available */
> > > -		cbo_get_block_size(node, "riscv,cbom-block-size",
> > > -				   &cbom_block_size, &cbom_hartid);
> > > -		cbo_get_block_size(node, "riscv,cboz-block-size",
> > > -				   &cboz_block_size, &cboz_hartid);
> > > +	for_each_possible_cpu(cpu) {
> > > +		if (acpi_disabled) {
> > > +			node = of_cpu_device_node_get(cpu);
> > > +			if (!node) {
> > > +				pr_warn("Unable to find cpu node\n");
> > > +				continue;
> > > +			}
> > > +
> > > +			/* set block-size for cbom and/or cboz extension if available */
> > > +			cbo_get_block_size(node, "riscv,cbom-block-size",
> > > +					   &cbom_block_size, &cbom_hartid);
> > > +			cbo_get_block_size(node, "riscv,cboz-block-size",
> > > +					   &cboz_block_size, &cboz_hartid);
> > 
> > This leaks a reference to the device node.
> > 
> Yep!. I missed of_node_put(). Let me add in next revision. Thanks!
> 
> > > +		} else {
> > > +			acpi_get_cbo_block_size(rhct, cpu, &cbom_block_size,
> > > +						&cboz_block_size, NULL);
> > 
> > This function loops through the whole RHCT already. Why do we need to call it
> > for each CPU? Can't we just call it once, and have it do the same consistency
> > checks as cbo_get_block_size()?
> > 
> > In that case, the DT path could keep the for_each_of_cpu_node() loop.
> > 
> I kept the same logic as DT. Basically, by passing the cpu node, we
> will fetch the exact CPU's CBO property from RHCT. It is not clear to me
> why we overwrite the same variable with value from another cpu and
> whether we can return as soon as we get the CBO size for one CPU.
> 
> Drew, can we exit the loop if we get the CBO size for one CPU?

We want to compare the values for each CPU with the first one we find in
order to ensure they are consistent. I think Samuel is suggesting that
we leave the DT path here the same, i.e. keep the for_each_of_cpu_node()
loop, and then change acpi_get_cbo_block_size() to *not* take a cpu as
input, but rather follow the same pattern as DT, which is to loop over
all cpus doing a consistency check against the first cpu's CBO info.

Thanks,
drew
