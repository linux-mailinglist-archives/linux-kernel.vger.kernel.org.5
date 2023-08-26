Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647F87894AA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjHZIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjHZIH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:07:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E92685
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:07:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-317f1c480eeso1384207f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1693037273; x=1693642073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fC4WZsMhyCohhKB9zSr+KT2wl5NJx/+h9RZP4Ctvhp0=;
        b=eOt95+E07ON6zeEGedPjyC1QMO71915I0XMuK8/WKOmzqvQMPYz9Bav8NYXv6TuSxf
         LlJ7b2OzmKVfy1szcDeH5Jzl88YTG5m3yGQ66552ll0BkUm8rtoKdEZZwD0Sudn1omM8
         3Y50icrJMQkH88wbl/RMvK+xizYYj61pWq1I5hGyvrErNJ3gnaODRS2OQI8D+K9OmQg6
         ygBWlTX7jym2bZsoyeyoPTD0a48AlDSpVxvN32zvZcodoQFQqin+tMYioFna0FioQGnT
         MGsYeJlwKJt+gPhHYH3nVLGbFCmH/JAe6rd0RhbYPTr5pcFVO1fE0nguulD1tPSK9cGn
         P8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693037273; x=1693642073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fC4WZsMhyCohhKB9zSr+KT2wl5NJx/+h9RZP4Ctvhp0=;
        b=aZQjee8EQ0lDEdQo6ERjLrmb9JbXuGwW9T8CK5nvOlC9C3bH5MCQ9qeNUsaT/kjRrK
         iQLo8Gge1GrSFljbNba0SVFz5xX/rdbLgkmfYU7R6QgAb0G44wp/gfZui+PqgDdBr7TI
         /eRcixkxWNRO3yj3rPSX9Je1qck9+lSPKuBH3/xZQWELZjFbm4TxcraNn/9CjUVa9x+D
         PUMid1tC2UiXlPbjNl9gN8wc36EOuO00FVStGksWJP12+wjM62/7JWTtI9WMyxcPyyn0
         9TVNDTPy0Xx7J/oHIM7QVl3xLEXM0eP9I8uqdTCcIsuH7LNC4AUpbvk1yURc0SGyB7MJ
         9pfg==
X-Gm-Message-State: AOJu0Yxbg6eZ3Vcchd/J5JByFfP3z1JnusOQvQKMe6AjOrFmbAKi1gqn
        6Ysi+bqnvh4aqKUwwFG8nFFSrXMc+cnF4bjPVn5stg==
X-Google-Smtp-Source: AGHT+IGMPGXDXtGgESddQTOeTJz31uVZuHV/5a/MONPOXhu6E1qGsm5fbdMkp074B6aPRGLH0/NLhQ==
X-Received: by 2002:a5d:630d:0:b0:31a:c6b2:8c63 with SMTP id i13-20020a5d630d000000b0031ac6b28c63mr14226802wru.21.1693037272127;
        Sat, 26 Aug 2023 01:07:52 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id m15-20020adffe4f000000b003195504c754sm4252498wrs.31.2023.08.26.01.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 01:07:50 -0700 (PDT)
Date:   Sat, 26 Aug 2023 10:07:50 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5] RISC-V: Show accurate per-hart isa in /proc/cpuinfo
Message-ID: <20230826-323be460a0dcd2a5fc2917b9@orel>
References: <20230825231139.1145522-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825231139.1145522-1-evan@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 04:11:38PM -0700, Evan Green wrote:
> In /proc/cpuinfo, most of the information we show for each processor is
> specific to that hart: marchid, mvendorid, mimpid, processor, hart,
> compatible, and the mmu size. But the ISA string gets filtered through a
> lowest common denominator mask, so that if one CPU is missing an ISA
> extension, no CPUs will show it.
> 
> Now that we track the ISA extensions for each hart, let's report ISA
> extension info accurately per-hart in /proc/cpuinfo. We cannot change
> the "isa:" line, as usermode may be relying on that line to show only
> the common set of extensions supported across all harts. Add a new "hart
> isa" line instead, which reports the true set of extensions for that
> hart.
> 
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---
> 
> Changes in v5:
>  - Documentation changes (only) (Conor)
> 
> Changes in v4:
>  - Documentation: Made the underline match the text line (Conor)
>  - Documentation: hanged "in question" to "being described" (Andrew)
> 
> Changes in v3:
>  - Add some documentation (Conor)
> 
> Changes in v2:
>  - Added new "hart isa" line rather than altering behavior of existing
>    "isa" line (Conor, Palmer)
> 
>  Documentation/riscv/uabi.rst | 12 ++++++++++++
>  arch/riscv/kernel/cpu.c      | 22 ++++++++++++++++++----
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/riscv/uabi.rst b/Documentation/riscv/uabi.rst
> index 8960fac42c40..a46017f57db2 100644
> --- a/Documentation/riscv/uabi.rst
> +++ b/Documentation/riscv/uabi.rst
> @@ -42,6 +42,18 @@ An example string following the order is::
>  
>     rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
>  
> +"isa" vs "hart isa" lines in /proc/cpuinfo
> +------------------------------------------
> +
> +The "isa" line in /proc/cpuinfo describes the lowest common denominator of
> +RISC-V ISA extensions recognized by the kernel and implemented on all harts. The
> +"hart isa" line, in contrast, describes the set of extensions recognized by the
> +kernel on the particular hart being described, even if those extensions may not
> +be present on all harts in the system. In both cases, the presence of a feature
> +in these lines guarantees only that the hardware has the described capability.
> +Additional kernel support or policy control changes may be required before a
> +feature is fully usable by userspace programs.

These last words imply that extensions listed in /proc/cpuinfo are all
potentially usable by userspace, but we also advertise extensions which
are only usable in S-mode (which is fine because of VMs). We should just
make that clear here.

Also, I frequently bounce between the words 'feature' and 'extension',
but, for documentation, I think we should try to be consistent. Or, we
could write somewhere that 'feature' == 'extension'.

Thanks,
drew

> +
>  Misaligned accesses
>  -------------------
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 7b793c4321bb..100fb382b450 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -197,9 +197,8 @@ arch_initcall(riscv_cpuinfo_init);
>  
>  #ifdef CONFIG_PROC_FS
>  
> -static void print_isa(struct seq_file *f)
> +static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap)
>  {
> -	seq_puts(f, "isa\t\t: ");
>  
>  	if (IS_ENABLED(CONFIG_32BIT))
>  		seq_write(f, "rv32", 4);
> @@ -207,7 +206,7 @@ static void print_isa(struct seq_file *f)
>  		seq_write(f, "rv64", 4);
>  
>  	for (int i = 0; i < riscv_isa_ext_count; i++) {
> -		if (!__riscv_isa_extension_available(NULL, riscv_isa_ext[i].id))
> +		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
>  			continue;
>  
>  		/* Only multi-letter extensions are split by underscores */
> @@ -271,7 +270,15 @@ static int c_show(struct seq_file *m, void *v)
>  
>  	seq_printf(m, "processor\t: %lu\n", cpu_id);
>  	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
> -	print_isa(m);
> +
> +	/*
> +	 * For historical raisins, the isa: line is limited to the lowest common
> +	 * denominator of extensions supported across all harts. A true list of
> +	 * extensions supported on this hart is printed later in the hart_isa:
> +	 * line.
> +	 */
> +	seq_puts(m, "isa\t\t: ");
> +	print_isa(m, NULL);
>  	print_mmu(m);
>  
>  	if (acpi_disabled) {
> @@ -287,6 +294,13 @@ static int c_show(struct seq_file *m, void *v)
>  	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
>  	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
>  	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
> +
> +	/*
> +	 * Print the ISA extensions specific to this hart, which may show
> +	 * additional extensions not present across all harts.
> +	 */
> +	seq_puts(m, "hart isa\t: ");
> +	print_isa(m, hart_isa[cpu_id].isa);
>  	seq_puts(m, "\n");
>  
>  	return 0;
> -- 
> 2.34.1
> 
