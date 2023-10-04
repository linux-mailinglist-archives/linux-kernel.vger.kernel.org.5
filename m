Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC077B7A38
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241743AbjJDIie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241715AbjJDIia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:38:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E1D83
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:38:26 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so1454301a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 01:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696408705; x=1697013505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppi0kBeOOweWlIZvfD7YuBHhh55A/ApHochAVYW2CEw=;
        b=DZu3xWC0dGADpy2d2SQk/KbZlvFm28HlFENrQHWyYgt2oyrDq5kK9zghnMYHzFjB20
         oFbprDeYsUy3Y5eH3qFujLJHRneosy1BdAnlPh24m7GvNdYvmJ3QEeoV+hfFBLWie1rD
         3owu0FRwoCOygjDCbGTowmYWaB1G2Q36Et+Bminem+Qq+c/3zLEht5ItwbFNV5Hp+bav
         rI4qn9u2UkQnk8KCbz7ng8ER1V6T4geNYVeZCQ2dcikKUIWq6E6WIUQ1j+33yRHosjKu
         zJ3wasUB1FoDCjpOsvE4b+9DFm0R/wI5DOHoMhzW1TKMH41zUnCkGnX4fehcpv3jhsr1
         irJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696408705; x=1697013505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppi0kBeOOweWlIZvfD7YuBHhh55A/ApHochAVYW2CEw=;
        b=FYyp0XBNzTRv94CePxrnGnMVLEIQt/eG1YxtrzHukSuZZMGCFhM9wW2Gt56RUc8icn
         43YSPwaDCnnIuMIdIo2D+5JCCOgtZ8Gd5J9bQ9DkEr5uTM8wZUR/8/Ntnr/EfAag9O0p
         i20/SjYwG4pnLLJnPcw8tWO87NqhHTh6fWoSJ1q16kqJndab+kgb7EANd6jbsbHLtj0M
         bD/iJ9jT3yvNYvYqU0nvGZgJMDJ0xQr8BnzZihVpm0QPgoXxiFs8QL4+6Hi1xuGN1mXa
         Cdl30M9+rB5K50bVSaresVwqA6oNNh8FGnlxaP5BumfWG4zX7urdXTaOUzsEyyzqNli1
         nX1A==
X-Gm-Message-State: AOJu0YzF19j8+r/S0oV5TGonfEddhPLVn8IylH4C+kFmy7uh7BMmW8BC
        GgdPhf6kDITU0/+dVE4zv5KjXg==
X-Google-Smtp-Source: AGHT+IEA0c4Rpr5fzXgEfRIFNS4InULkII64T3I3f9QRr7CnzN0XoS/8hb8DDlG5hrg2dBx+Uq8JWg==
X-Received: by 2002:a17:906:dac1:b0:9ae:705a:8451 with SMTP id xi1-20020a170906dac100b009ae705a8451mr4692777ejb.25.1696408704565;
        Wed, 04 Oct 2023 01:38:24 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906561500b009ad87fd4e65sm2369666ejq.108.2023.10.04.01.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 01:38:24 -0700 (PDT)
Date:   Wed, 4 Oct 2023 10:38:22 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v2 -next 4/4] clocksource/timer-riscv: ACPI: Add
 timer_cannot_wakeup_cpu
Message-ID: <20231004-4fb4dad9268b0c933550a21e@orel>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
 <20230927170015.295232-5-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927170015.295232-5-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 10:30:15PM +0530, Sunil V L wrote:
> The timer capability to wakeup the cpu irrespective of its idle state is
> provided by the flag in RHCT. Update the timer code to set this flag.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/clocksource/timer-riscv.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 9c8f3e2decc2..06f5bad3c3e0 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -225,6 +225,10 @@ TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
>  #ifdef CONFIG_ACPI
>  static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
>  {
> +	struct acpi_table_rhct *rhct = (struct acpi_table_rhct *)table;
> +
> +	riscv_timer_cannot_wake_cpu = rhct->flags & ACPI_RHCT_TIMER_CANNOT_WAKEUP_CPU;
> +
>  	return riscv_timer_init_common();
>  }
>  
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
