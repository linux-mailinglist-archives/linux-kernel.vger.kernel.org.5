Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87BE7CBDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbjJQIhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:37:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4A2B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:37:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4054f790190so57388505e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697531863; x=1698136663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fVCukcDlvPySj2NLX0qj8lhbtPyshCYJMi8M0ztHzn4=;
        b=B9lMZD77hiRfqc+IG+lBFILgmYB3Kock7O5dHCF9gJN8X73gsQncqknkmXwlpm29IO
         J7hkdItwE4MyeDyYWt4/RSLr4ZkC5ZGQk01DLX5NVQ1bPGbZDytJTdMu2PjUKuifwPcR
         F9Yt3+Gl3KCQup6Gy7gv/7e3gyluhLSWPr6yunyvMqGIEekSV9SWbni+93+HH7nW2O7g
         5S9XmTEbWZWyeROxVX9a+Mkc7c4IH5RyMQvK7OHe8Cy0xXIxemPEF4nxCCJtUy41bQNF
         ZO1XGJgtNW9y4+/xn1uUTh8PYBcqv88xkF4Zb/gAsUA3VdVoK6Gbkj26h9rkk5xweoUi
         lpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697531863; x=1698136663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVCukcDlvPySj2NLX0qj8lhbtPyshCYJMi8M0ztHzn4=;
        b=bhgLJDEkwNe0NOE3FebICeV7OUBmRh6aSHvvS/+Ywzsk4myRxOWDGqmpp4mgu3xp80
         7M4iA490CCRw2lQwsyM0EpDmIxg+F+2b7Yl5lmAUvQP4nJ4nKbpdALEyHgzE+ixD/XBQ
         vWM2Y9kg85lJHBzJoDb2wG4Q9pS+g1tM5mJA/CopJRW08NDQFaas5TZ9LVUngKqRc6Xy
         DTGyjkUBphhfhpmkpe3VFecvNSKV8rgItC8jNBfyh16eLHjJ2+uPQCld2KwpL9B74zkO
         KhFcC0owYKlDQ8X4n/MID+dPu11P4IZ45b1YVyKZ1krJRmnNU3Ui/wml1sE81ZlERPzR
         jHcQ==
X-Gm-Message-State: AOJu0YxZkEDtULEXNSSzvKsz0Uc5MOTW+QKiwvFzj8t8mtGptC0EqjbL
        cgFwd8Izo45TYZ3J/DNsmiMBws+MSurJw9YcDIo=
X-Google-Smtp-Source: AGHT+IH1PWLI/m2AVOajpYxFQu3mRvEQWpnL/AMckzMiIlODM9qdoJ15Ly+Sxs75jHhj0Cl/nYxzGw==
X-Received: by 2002:a05:600c:3595:b0:3ff:ca80:eda3 with SMTP id p21-20020a05600c359500b003ffca80eda3mr1141353wmq.10.1697531862996;
        Tue, 17 Oct 2023 01:37:42 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id s26-20020a05600c319a00b00405588aa40asm1258374wmp.24.2023.10.17.01.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:37:42 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:37:41 +0200
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
Message-ID: <20231017-b394a120094eeee31693e9a7@orel>
References: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
 <20231016164958.1191529-3-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016164958.1191529-3-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 10:19:57PM +0530, Sunil V L wrote:
> Cache Block Operation (CBO) related block size in ACPI is provided by RHCT.
> Add support to read the CMO node in RHCT to get this information.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/acpi.h |  6 +++
>  drivers/acpi/riscv/rhct.c     | 93 +++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index d5604d2073bc..7dad0cf9d701 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -66,6 +66,8 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
>  		       unsigned int cpu, const char **isa);
>  
>  static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
> +void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
> +			     u32 *cboz_size, u32 *cbop_size);
>  #else
>  static inline void acpi_init_rintc_map(void) { }
>  static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
> @@ -79,6 +81,10 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
>  	return -EINVAL;
>  }
>  
> +static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
> +					   u32 *cbom_size, u32 *cboz_size,
> +					   u32 *cbop_size) { }
> +
>  #endif /* CONFIG_ACPI */
>  
>  #endif /*_ASM_ACPI_H*/
> diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
> index b280b3e9c7d9..105f1aaa3fac 100644
> --- a/drivers/acpi/riscv/rhct.c
> +++ b/drivers/acpi/riscv/rhct.c
> @@ -8,6 +8,7 @@
>  #define pr_fmt(fmt)     "ACPI: RHCT: " fmt
>  
>  #include <linux/acpi.h>
> +#include <linux/bits.h>
>  
>  static struct acpi_table_header *acpi_get_rhct(void)
>  {
> @@ -81,3 +82,95 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
>  
>  	return -1;
>  }
> +
> +static void acpi_parse_hart_info_cmo_node(struct acpi_table_rhct *rhct,
> +					  struct acpi_rhct_hart_info *hart_info,
> +					  u32 *cbom_size, u32 *cboz_size, u32 *cbop_size)
> +{
> +	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
> +	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
> +	struct acpi_rhct_node_header *ref_node;
> +	struct acpi_rhct_cmo_node *cmo_node;
> +	u32 *hart_info_node_offset;
> +
> +	hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
> +	for (int i = 0; i < hart_info->num_offsets; i++) {
> +		ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
> +					rhct, hart_info_node_offset[i]);
> +		if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
> +			cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
> +						ref_node, size_hdr);
> +			if (cbom_size && cmo_node->cbom_size <= 30) {
> +				if (!*cbom_size) {
> +					*cbom_size = BIT(cmo_node->cbom_size);
> +				} else if (*cbom_size !=
> +						BIT(cmo_node->cbom_size)) {

No need to break the if line, we can go to 100 chars. And then, since both
the if and else if arms only have single statements, all the {} can be
dropped too. Same comment for cboz and cbop.

> +					pr_warn("CBOM size is not the same across harts\n");
> +				}
> +			}
> +
> +			if (cboz_size && cmo_node->cboz_size <= 30) {
> +				if (!*cboz_size) {
> +					*cboz_size = BIT(cmo_node->cboz_size);
> +				} else if (*cboz_size !=
> +						BIT(cmo_node->cboz_size)) {
> +					pr_warn("CBOZ size is not the same across harts\n");
> +				}
> +			}
> +
> +			if (cbop_size && cmo_node->cbop_size <= 30) {
> +				if (!*cbop_size) {
> +					*cbop_size = BIT(cmo_node->cbop_size);
> +				} else if (*cbop_size !=
> +						BIT(cmo_node->cbop_size)) {
> +					pr_warn("CBOP size is not the same across harts\n");
> +				}
> +			}
> +		}
> +	}
> +}
> +
> +/*
> + * During early boot, the caller should call acpi_get_table() and pass its pointer to
> + * these functions(and free up later). At run time, since this table can be used
                     ^ add a space here

> + * multiple times, pass NULL so that the table remains in memory
> + */
> +void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
> +			     u32 *cboz_size, u32 *cbop_size)
> +{
> +	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
> +	struct acpi_rhct_node_header *node, *end;
> +	struct acpi_rhct_hart_info *hart_info;
> +	struct acpi_table_rhct *rhct;
> +
> +	if (acpi_disabled)
> +		return;
> +
> +	if (table) {
> +		rhct = (struct acpi_table_rhct *)table;
> +	} else {
> +		rhct = (struct acpi_table_rhct *)acpi_get_rhct();

Not an issue of this patch, but it seems like acpi_get_rhct() should
return a struct acpi_table_rhct pointer instead of a struct
acpi_table_header pointer since it's specifically returning an RHCT.

> +		if (!rhct)
> +			return;
> +	}
> +
> +	if (cbom_size)
> +		*cbom_size = 0;
> +
> +	if (cboz_size)
> +		*cboz_size = 0;
> +
> +	if (cbop_size)
> +		*cbop_size = 0;
> +
> +	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
> +	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
> +	     node < end;
> +	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
> +		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
> +			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
> +			acpi_parse_hart_info_cmo_node(rhct, hart_info, cbom_size,
> +						      cboz_size, cbop_size);
> +		}
> +	}
> +}
> -- 
> 2.39.2
>

Other than the nits

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
