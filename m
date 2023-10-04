Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961DC7B7712
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjJDEWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjJDEWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:22:38 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE528B4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 21:22:34 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79f95cd15dfso64251439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 21:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696393354; x=1696998154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ew3FEUrbn98SAij00MK4fNBMQRr8yEG76Zxf5H8HMB8=;
        b=PFg32twk3B3UUIr0qqcv4+HxwBnriAs6AfEE086gKLfKkZlNfmRWdWOrllxpVe68CD
         dVYWQozUw7ihQEsSZ3WkEPpFBcXvh950oiousZmfxfBUFM0tAls9dQm2Tc3xYsVEBka1
         J5LQKdfRv2pVqpUxjVCIaCxY2RnbQjwCrweD0RWVD3DnA35XRWPW7CtbfC8FPaIPQefY
         mHEf84l8jxxlQ9tWfjNFy5SuFPFtrAG/f5xz3z24stT5Z9CBN3Q6YydQoTZyCGG0+v7B
         mgHGeIiddSWgeQsUgypUeaFao6ulglYvFb5Xyqns8HtV6mGpBAjwHX4qP45h8A4TP0LX
         1ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696393354; x=1696998154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew3FEUrbn98SAij00MK4fNBMQRr8yEG76Zxf5H8HMB8=;
        b=RrinS4ZBvsT0a7IqL6TN5h2sH8JnXD4d9MokQB0LFNCfUq1qlj4xHk2exBpXLP4lMU
         6i5eTCsewFfJ97HQvgwl6xkiwQeqAYA2VaZp+GBmrnNA+Xd8IE7tdCFDU+XOPFA3o7ES
         T6GJrniSV1UsuJl/e/ztyNBUDYPZdjSiz8/rrUHei3iWoKHfN1PaqYyzahIJ2SkS2zpB
         uxZFU1Hy2IJx+qWw6NWfHHmcXKsWVLaKLLZZ4eCEyD40OgIOjGPmEKFKGxOodcc5e2Ru
         BX9ztKl0LBWz3AWt+nhzzZTrfeiUIlmdxLYw9uSSq/KcbTq0u4aB2IOthTiDnUku3uey
         rVIQ==
X-Gm-Message-State: AOJu0YwEmp08uJU1MP6EgRnpsdCYNOSnS/9kwxiarvDBJyTiNIVXJjIK
        FbpLlRNGeqVkJ/O9MP4NDB/DkRN1XQyJVbC56fI=
X-Google-Smtp-Source: AGHT+IE2Cb8xhdL0QFGsL31ie56dFxiRNfd0SJDXoxFJNEeXrWtrLrX9h9FOPQ4tHmue2X3/RdQE5w==
X-Received: by 2002:a05:6e02:11ad:b0:352:5e6d:b775 with SMTP id 13-20020a056e0211ad00b003525e6db775mr1028822ilj.27.1696393354243;
        Tue, 03 Oct 2023 21:22:34 -0700 (PDT)
Received: from sunil-laptop ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id x9-20020a92d309000000b00351268dfbd5sm762830ila.57.2023.10.03.21.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 21:22:33 -0700 (PDT)
Date:   Wed, 4 Oct 2023 09:52:23 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
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
        Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 -next 3/4] RISC-V: cacheflush: Initialize CBO
 variables on ACPI systems
Message-ID: <ZRzof1sH/GJNQp4V@sunil-laptop>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-4-sunilvl@ventanamicro.com>
 <f4ab7464-3dfb-4d10-8bed-76e7084abd3e@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ab7464-3dfb-4d10-8bed-76e7084abd3e@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 02:50:02PM -0500, Samuel Holland wrote:
> On 2023-09-27 12:00 PM, Sunil V L wrote:
> > Using new interface to get the CBO block size information in RHCT,
> > initialize the variables on ACPI platforms.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/mm/cacheflush.c | 37 +++++++++++++++++++++++++++++++------
> >  1 file changed, 31 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index f1387272a551..8e59644e473c 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -3,7 +3,9 @@
> >   * Copyright (C) 2017 SiFive
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/of.h>
> > +#include <asm/acpi.h>
> >  #include <asm/cacheflush.h>
> >  
> >  #ifdef CONFIG_SMP
> > @@ -124,15 +126,38 @@ void __init riscv_init_cbo_blocksizes(void)
> >  	unsigned long cbom_hartid, cboz_hartid;
> >  	u32 cbom_block_size = 0, cboz_block_size = 0;
> >  	struct device_node *node;
> > +	struct acpi_table_header *rhct;
> > +	acpi_status status;
> > +	unsigned int cpu;
> > +
> > +	if (!acpi_disabled) {
> > +		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
> > +		if (ACPI_FAILURE(status))
> > +			return;
> > +	}
> >  
> > -	for_each_of_cpu_node(node) {
> > -		/* set block-size for cbom and/or cboz extension if available */
> > -		cbo_get_block_size(node, "riscv,cbom-block-size",
> > -				   &cbom_block_size, &cbom_hartid);
> > -		cbo_get_block_size(node, "riscv,cboz-block-size",
> > -				   &cboz_block_size, &cboz_hartid);
> > +	for_each_possible_cpu(cpu) {
> > +		if (acpi_disabled) {
> > +			node = of_cpu_device_node_get(cpu);
> > +			if (!node) {
> > +				pr_warn("Unable to find cpu node\n");
> > +				continue;
> > +			}
> > +
> > +			/* set block-size for cbom and/or cboz extension if available */
> > +			cbo_get_block_size(node, "riscv,cbom-block-size",
> > +					   &cbom_block_size, &cbom_hartid);
> > +			cbo_get_block_size(node, "riscv,cboz-block-size",
> > +					   &cboz_block_size, &cboz_hartid);
> 
> This leaks a reference to the device node.
> 
Yep!. I missed of_node_put(). Let me add in next revision. Thanks!

> > +		} else {
> > +			acpi_get_cbo_block_size(rhct, cpu, &cbom_block_size,
> > +						&cboz_block_size, NULL);
> 
> This function loops through the whole RHCT already. Why do we need to call it
> for each CPU? Can't we just call it once, and have it do the same consistency
> checks as cbo_get_block_size()?
> 
> In that case, the DT path could keep the for_each_of_cpu_node() loop.
> 
I kept the same logic as DT. Basically, by passing the cpu node, we
will fetch the exact CPU's CBO property from RHCT. It is not clear to me
why we overwrite the same variable with value from another cpu and
whether we can return as soon as we get the CBO size for one CPU.

Drew, can we exit the loop if we get the CBO size for one CPU?

Thanks!
Sunil
