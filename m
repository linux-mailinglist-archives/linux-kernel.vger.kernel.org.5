Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F575F24A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjGXKLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjGXKLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:11:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B30BE6C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:04:12 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8ad907ba4so19985055ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690193015; x=1690797815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=irnZK5VJVU/AvPnIudC2XTq+WREheiEIBR7LygQl+ws=;
        b=dHARKePIGkFra3NY1uluycCD9ycJKXO5I17JdpjU5HpCKHmSb5aPqN3JViWfR4Ysev
         TA/qFgnCJOTnTrrqa5icdHpNCmd2yrv+hX3tDDBvDyHTAd3xiT2UDg7oFIxb8gcA6lNS
         9snaI+UKGUZKLci864M/JSAcgWa/6EBBJ14VsGdMEipXA02PFBiRU0yA5vCrseAzeBMC
         wOqggx1Qg8Mvb2g+SHuDhtTbUrj3QFGzTDAwt93iWxwdNZ8xabNv9DeBz4RgwhVowrk3
         tOhHrSkKbs8qCMj6iDKykP6VK2d6sS6mjcVxgBw8xMuitnGv72ePVAIohj/6nv5ZXrxy
         goWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193015; x=1690797815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irnZK5VJVU/AvPnIudC2XTq+WREheiEIBR7LygQl+ws=;
        b=RKMmBknG5eqMwy1A70IN7x6upWB7cTcz1tZnDV2BJqj5YhInUXW0qrg3hfSP7i8klh
         MaIaOHl4tTmDwm3xOAVmF+4i5TUEg35P0nDurXaLA2FDScJF9cdqbHNp0wHbgGO+UAQd
         h3kBOxr/Jw9g1KQcRo62hDJ+r98tYO+5uPu7SO7e0+28hszoCiaNFfAA7C4J3xHJ4brN
         vr92BXnRRRsecf3u5MaiibcCMRnMvrC40TlXRkWJng0fHENv/f/cN+8UcAl4zpy6leL3
         tNAD2pdKMvLvXgafHT8gS0fs7ngiHIFL15Zsj0HZOduByoY8OqZKmxb4SEBQ7zmWUOOB
         QFYQ==
X-Gm-Message-State: ABy/qLbeYNNr8OoOV4DpYUE8tj0O8r4AqzJEo67OwVh4THpFYnYXMmQi
        mEjq60kWE9U05j1tp2CETJVDFg==
X-Google-Smtp-Source: APBJJlF1CQZ1cg59E54KGa9kDfKHQvta4M96RAu16e3sgfccxvBtqHeyaMZOqEeMWqY+XIDA7oJ05w==
X-Received: by 2002:a17:902:b188:b0:1b8:94e9:e7b0 with SMTP id s8-20020a170902b18800b001b894e9e7b0mr5741090plr.9.1690193014711;
        Mon, 24 Jul 2023 03:03:34 -0700 (PDT)
Received: from sunil-laptop ([106.51.190.25])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001b8a85489a3sm8442147pla.262.2023.07.24.03.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:03:34 -0700 (PDT)
Date:   Mon, 24 Jul 2023 15:33:27 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 -fixes] RISC-V: ACPI: Fix acpi_os_ioremap to return
 iomem address
Message-ID: <ZL5Mb65sejudi4Ri@sunil-laptop>
References: <20230723191758.1262960-1-sunilvl@ventanamicro.com>
 <20230724-phonics-earthling-d104ef807286@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724-phonics-earthling-d104ef807286@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:07:46AM +0100, Conor Dooley wrote:
> On Mon, Jul 24, 2023 at 12:47:58AM +0530, Sunil V L wrote:
> > acpi_os_ioremap() currently is a wrapper to memremap() on
> > RISC-V. But the callers of acpi_os_ioremap() expect it to
> > return __iomem address and hence sparse tool reports a new
> > warning. Fix this issue by type casting to  __iomem type.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202307230357.egcTAefj-lkp@intel.com/
> > Fixes: a91a9ffbd3a5 ("RISC-V: Add support to build the ACPI core")
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> > Changes since v1:
> > 	1) Removed enhancements from the fix patch.
> > 
> >  arch/riscv/include/asm/acpi.h | 2 +-
> >  arch/riscv/kernel/acpi.c      | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > index f71ce21ff684..d5604d2073bc 100644
> > --- a/arch/riscv/include/asm/acpi.h
> > +++ b/arch/riscv/include/asm/acpi.h
> > @@ -19,7 +19,7 @@ typedef u64 phys_cpuid_t;
> >  #define PHYS_CPUID_INVALID INVALID_HARTID
> >  
> >  /* ACPI table mapping after acpi_permanent_mmap is set */
> > -void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
> > +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
> >  #define acpi_os_ioremap acpi_os_ioremap
> >  
> >  #define acpi_strict 1	/* No out-of-spec workarounds on RISC-V */
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index 5ee03ebab80e..e6fdb9edcdd9 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -215,9 +215,9 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
> >  	early_iounmap(map, size);
> >  }
> >  
> > -void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> > +void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> >  {
> > -	return memremap(phys, size, MEMREMAP_WB);
> > +	return (__force void __iomem *) memremap(phys, size, MEMREMAP_WB);
> 
> Why's the __force needed? Does sparse complain about the cast too?
Nope, I think it is required only if the cast is other way. Let me remove
this in v3.

Thanks,
Sunil


