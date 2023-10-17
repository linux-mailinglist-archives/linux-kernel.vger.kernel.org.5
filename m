Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D067CC969
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbjJQREA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjJQRD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:03:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9339EA4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:03:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so903212066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697562235; x=1698167035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXhmtE1WCmBrDAGjS0eBWsd0E/xae41wf+MbBCU4NSA=;
        b=ZJKznrg01URFJOx24FRLzL90+8MD2HSRRNmb3Gipx1Bt/D5PiUQujAUil/ZdQIf2gI
         JNHx4CA6bLlOf6SzMV86Ws2c6/pEvvk9gJgwJVMfQQ+c/V3qizqW9BPkPtMc4He0KWK+
         sdbGydcDOq3q2U/eI55N5q881yBILk5aKE5TQrIQ15VZmQAId9kr2ikASPsw3wYmZwJr
         OXAabz13sTGQlWqwW9SjjStX6MSjvNTu+A7TjX2t7937g2MCXOQ+JWciGQ9eEW9QEbjI
         pdsuZLef/zpln/B1aaq7H6SHGH/+C5obSZptDVCxjEM1iSoZaehqcS7aCiCuayXPbkl7
         gz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562235; x=1698167035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXhmtE1WCmBrDAGjS0eBWsd0E/xae41wf+MbBCU4NSA=;
        b=TIjSfESy48gqG/MwJgDZgn6AtrneHp3Ouac+FKsr85CnywTlptVQoBNdmN32Hlta8r
         08ajfIoq0yHiGzAGyHjmdDB6wXdlk/PsUSui/8uAv4EE/iFYHwoOkITmXny4PQplxZSL
         H+hbaDjIBHmLsCkWU9oeK7HiWy5EXXFvXpc6Zngl/VxoSPAVQXfkqCHK7Tk/aSI7DxoO
         enmMicGTnd0ADxHGZfir151KUmLdGMzFw4Sah+BerOctnxoqITK+EsMQg2oUIY5QALT5
         xlqrEYUlp/KbNPZJtI+Tbi23fwqNBSdun2rdlA9AoOKx3Tl0TYRQj1D5gC6XlCHSI2I/
         zMlA==
X-Gm-Message-State: AOJu0YyoPSsBqyV8phRY9IIVxsZbPTo9Lod4HePjx+WFCqcKbZ44wQM9
        RqbM6VLZxgt0qMKIBfqyQK+Tlg==
X-Google-Smtp-Source: AGHT+IGSL1p1dW58mi53fADPrMS0amj8i+XSKhwo/9G/kLwvyqkWgWFskajXHp22eZHGdYu7upCp7w==
X-Received: by 2002:a17:907:2d0f:b0:9c1:edd8:43c1 with SMTP id gs15-20020a1709072d0f00b009c1edd843c1mr2248045ejc.51.1697562234710;
        Tue, 17 Oct 2023 10:03:54 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id gz21-20020a170906f2d500b009ae0042e48bsm144903ejb.5.2023.10.17.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 10:03:54 -0700 (PDT)
Date:   Tue, 17 Oct 2023 19:03:53 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 2/3] RISC-V: ACPI: RHCT: Add function to get CBO
 block sizes
Message-ID: <20231017-3518118151d433af9905238f@orel>
References: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
 <20231016164958.1191529-3-sunilvl@ventanamicro.com>
 <20231017-b394a120094eeee31693e9a7@orel>
 <ZS6qq1Y9bLZ868KI@sunil-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6qq1Y9bLZ868KI@sunil-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:09:23PM +0530, Sunil V L wrote:
> On Tue, Oct 17, 2023 at 10:37:41AM +0200, Andrew Jones wrote:
> > On Mon, Oct 16, 2023 at 10:19:57PM +0530, Sunil V L wrote:
> > > Cache Block Operation (CBO) related block size in ACPI is provided by RHCT.
> > > Add support to read the CMO node in RHCT to get this information.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >  arch/riscv/include/asm/acpi.h |  6 +++
> > >  drivers/acpi/riscv/rhct.c     | 93 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 99 insertions(+)
> > > 
> > > diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> > > index d5604d2073bc..7dad0cf9d701 100644
> > > --- a/arch/riscv/include/asm/acpi.h
> > > +++ b/arch/riscv/include/asm/acpi.h
> > > @@ -66,6 +66,8 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  		       unsigned int cpu, const char **isa);
> > >  
> > >  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> > > +void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
> > > +			     u32 *cboz_size, u32 *cbop_size);
> > >  #else
> > >  static inline void acpi_init_rintc_map(void) { }
> > >  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> > > @@ -79,6 +81,10 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
> > >  	return -EINVAL;
> > >  }
> > >  
> > > +static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
> > > +					   u32 *cbom_size, u32 *cboz_size,
> > > +					   u32 *cbop_size) { }
> > > +
> > >  #endif /* CONFIG_ACPI */
> > >  
> > >  #endif /*_ASM_ACPI_H*/
> > > diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
> > > index b280b3e9c7d9..105f1aaa3fac 100644
> > > --- a/drivers/acpi/riscv/rhct.c
> > > +++ b/drivers/acpi/riscv/rhct.c
> > > @@ -8,6 +8,7 @@
> > >  #define pr_fmt(fmt)     "ACPI: RHCT: " fmt
> > >  
> > >  #include <linux/acpi.h>
> > > +#include <linux/bits.h>
> > >  
> > >  static struct acpi_table_header *acpi_get_rhct(void)
> > >  {
> > > @@ -81,3 +82,95 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
> > >  
> > >  	return -1;
> > >  }
> > > +
> > > +static void acpi_parse_hart_info_cmo_node(struct acpi_table_rhct *rhct,
> > > +					  struct acpi_rhct_hart_info *hart_info,
> > > +					  u32 *cbom_size, u32 *cboz_size, u32 *cbop_size)
> > > +{
> > > +	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
> > > +	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
> > > +	struct acpi_rhct_node_header *ref_node;
> > > +	struct acpi_rhct_cmo_node *cmo_node;
> > > +	u32 *hart_info_node_offset;
> > > +
> > > +	hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
> > > +	for (int i = 0; i < hart_info->num_offsets; i++) {
> > > +		ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
> > > +					rhct, hart_info_node_offset[i]);
> > > +		if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
> > > +			cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
> > > +						ref_node, size_hdr);
> > > +			if (cbom_size && cmo_node->cbom_size <= 30) {
> > > +				if (!*cbom_size) {
> > > +					*cbom_size = BIT(cmo_node->cbom_size);
> > > +				} else if (*cbom_size !=
> > > +						BIT(cmo_node->cbom_size)) {
> > 
> > No need to break the if line, we can go to 100 chars. And then, since both
> > the if and else if arms only have single statements, all the {} can be
> > dropped too. Same comment for cboz and cbop.
> > 
> Yeah, it is a side effect of working on repos with different coding
> standards. It is interesting that checkpatch didn't recommend to remove
> the braces. Let me fix it in next revision. Thanks!.

I think checkpatch is OK with single lines that get broken into multiple
lines having braces around them. In fact, it may even be preferred. My
suggestion is to not break the line though, so checkpatch would likely
complain after turning these lines into true single lines.

Thanks,
drew
