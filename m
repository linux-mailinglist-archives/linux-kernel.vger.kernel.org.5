Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03913771C2C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjHGIUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHGIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:20:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9982710EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:20:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-522462d8416so5784737a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691396425; x=1692001225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/3aPcv01OzN39IUD/aX9hP4XVkcpINkY5fZPomzhTU=;
        b=PVv4YJO4RBn7OA3++k0468r7BbExuUQyBP+0fuCyf8NiGwU9ulLb0NuvXxuUQDex5u
         0Ko3JrFQFM2kHrnHIjA1iCVnbvwOdAdiJaMQ5GT2SoZpqReMRSTlQWML9Pv1V3QdFt7x
         Go93snSTsJEnD3CEU5BvZ69yag3oJPHpoEc0BmgXh2pzeQNKdJEVmuhwBFyUxGi0rv87
         vi+XnRTq3DmeNAe4YeJkvuJvhQ8hFYlvhRxF/0KVQDYOTES/x9jbBnSSJWv3My5YhGew
         kKYg9qqVAo3QlGLYApMbN6PaJyWWeZJO5wxoACI+N+x/Ucem551AzjiZT6HP+Awc4yzH
         eMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691396425; x=1692001225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/3aPcv01OzN39IUD/aX9hP4XVkcpINkY5fZPomzhTU=;
        b=VcVAvuxe1MCt97CVMLDh4n2urkh0V73IV4x+sv/aXVxJ0c/uZP1UDCf1PbCsyowsfT
         bybQmqwcrCYjCNoxjO6Y9Q4qIxZ1VP0KlzeJFyjUVdGdlz0XeXGmajfrkkBJn937nJTL
         LvQiLq1j47U6JfUx7KmaPvrSp9gs5vsQOy+uYQbd++GRwUSVAOvvSGQGVARJ5nvIXWx8
         UG9uHiTh2BoO9iiAiazx2F1RWZhc9WZEu5S0KarMSbHdRRJFVZR6XH0Da6Stt1vQh4IT
         QXv6lPNDSo7BR+CQKS5Ca2jfLMnDK2l3ULrCaujbyheNThp4V3KXnDYWrDWry4XTqlnI
         QBPw==
X-Gm-Message-State: AOJu0YweJeoidWuJyKlS6OM9wP2EyJyCHddNuEFxGTR6XU7a6AmGK2id
        E9m6PLaFlh+USreKhJQ/SId/mQ==
X-Google-Smtp-Source: AGHT+IG6bTLsou3LPOGQGdFM9cCRg9PxjTO2zzfPl5N+ZCSlyhpUhGftqSn9l1/Ee8JS/rtN2WArPg==
X-Received: by 2002:a17:907:1dc3:b0:99b:f44e:6daa with SMTP id og3-20020a1709071dc300b0099bf44e6daamr6734142ejc.62.1691396424949;
        Mon, 07 Aug 2023 01:20:24 -0700 (PDT)
Received: from localhost (212-5-140-29.ip.btc-net.bg. [212.5.140.29])
        by smtp.gmail.com with ESMTPSA id k19-20020a17090666d300b00991dfb5dfbbsm4837363ejp.67.2023.08.07.01.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 01:20:24 -0700 (PDT)
Date:   Mon, 7 Aug 2023 11:20:20 +0300
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [RFC PATCH v1 03/21] RISC-V: ACPI: Fix acpi_os_ioremap to return
 iomem address
Message-ID: <20230807-4fa96c8f505a601dd758ec2e@orel>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-4-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803175916.3174453-4-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 11:28:58PM +0530, Sunil V L wrote:
> acpi_os_ioremap() currently is a wrapper to memremap() on
> RISC-V. But the callers of acpi_os_ioremap() expect it to
> return __iomem address and hence sparse tool reports a new
> warning. Fix this issue by type casting to  __iomem type.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307230357.egcTAefj-lkp@intel.com/
> Fixes: a91a9ffbd3a5 ("RISC-V: Add support to build the ACPI core")
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/acpi.h | 2 +-
>  arch/riscv/kernel/acpi.c      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index f71ce21ff684..d5604d2073bc 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -19,7 +19,7 @@ typedef u64 phys_cpuid_t;
>  #define PHYS_CPUID_INVALID INVALID_HARTID
>  
>  /* ACPI table mapping after acpi_permanent_mmap is set */
> -void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
> +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
>  #define acpi_os_ioremap acpi_os_ioremap
>  
>  #define acpi_strict 1	/* No out-of-spec workarounds on RISC-V */
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 5ee03ebab80e..56cb2c986c48 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -215,9 +215,9 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
>  	early_iounmap(map, size);
>  }
>  
> -void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>  {
> -	return memremap(phys, size, MEMREMAP_WB);
> +	return (void __iomem *)memremap(phys, size, MEMREMAP_WB);
>  }
>  
>  #ifdef CONFIG_PCI
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
