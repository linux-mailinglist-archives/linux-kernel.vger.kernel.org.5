Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A780760408
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGYAce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGYAcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:32:32 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBE4510EF;
        Mon, 24 Jul 2023 17:32:30 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8DxxPAdGL9kEHsJAA--.24128S3;
        Tue, 25 Jul 2023 08:32:29 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx3yMdGL9kkfE5AA--.51036S3;
        Tue, 25 Jul 2023 08:32:29 +0800 (CST)
Message-ID: <fbe94cf6-0fd0-fbb5-4308-e1730e3af214@loongson.cn>
Date:   Tue, 25 Jul 2023 08:32:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] ACPI: processor_core: LoongArch: Get physical id from
 MADT table
Content-Language: en-US
From:   bibo mao <maobibo@loongson.cn>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230717022258.2579631-1-maobibo@loongson.cn>
In-Reply-To: <20230717022258.2579631-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx3yMdGL9kkfE5AA--.51036S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr4xZw45KrW5XFWfXr1UArc_yoW5WrWxpF
        yUKas8Kw15WFsFqw1fXayrWFZ8Z3y8ua4SgFs3Gr9xtF18GryrXFW3Xry3WryDAF4Fk3y0
        vr40yaykGFW0vFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
        xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
        AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOdb8U
        UUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slightly ping :)

在 2023/7/17 10:22, Bibo Mao 写道:
> With ACPI Spec 6.5 chapter 5.2.12.20, each processor in LoongArch
> system has a Core Programmable Interrupt Controller in MADT table,
> value of its type is 0x11 in the spec and defined as enum variable
> ACPI_MADT_TYPE_CORE_PIC in Linux kernel. Physical id can be parsed
> from MADT table for LoongArch system, also it can be parsed from
> MAT table for hotplug cpu. This patch adds physical id parsing for
> LoongArch system.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> Changes in v2:
>  Refresh the changelog and add detailed description of acpi spec
>  about MADT table for LoongArch system.
> 
>  Add comments in function map_core_pic_id.
>  
> ---
>  drivers/acpi/processor_core.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
> index d6606a9f2da6..7dd6dbaa98c3 100644
> --- a/drivers/acpi/processor_core.c
> +++ b/drivers/acpi/processor_core.c
> @@ -132,6 +132,30 @@ static int map_rintc_hartid(struct acpi_subtable_header *entry,
>  	return -EINVAL;
>  }
>  
> +/*
> + * Retrieve LoongArch CPU physical id
> + */
> +static int map_core_pic_id(struct acpi_subtable_header *entry,
> +		int device_declaration, u32 acpi_id, phys_cpuid_t *phys_id)
> +{
> +	struct acpi_madt_core_pic *core_pic =
> +		container_of(entry, struct acpi_madt_core_pic, header);
> +
> +	if (!(core_pic->flags & ACPI_MADT_ENABLED))
> +		return -ENODEV;
> +
> +	/* device_declaration means Device object in DSDT, in LoongArch
> +	 * system, logical processor acpi_id is required in _UID property
> +	 * of DSDT table, so we should check device_declaration here
> +	 */
> +	if (device_declaration && (core_pic->processor_id == acpi_id)) {
> +		*phys_id = core_pic->core_id;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
>  				   int type, u32 acpi_id)
>  {
> @@ -165,6 +189,9 @@ static phys_cpuid_t map_madt_entry(struct acpi_table_madt *madt,
>  		} else if (header->type == ACPI_MADT_TYPE_RINTC) {
>  			if (!map_rintc_hartid(header, type, acpi_id, &phys_id))
>  				break;
> +		} else if (header->type == ACPI_MADT_TYPE_CORE_PIC) {
> +			if (!map_core_pic_id(header, type, acpi_id, &phys_id))
> +				break;
>  		}
>  		entry += header->length;
>  	}
> @@ -216,6 +243,8 @@ static phys_cpuid_t map_mat_entry(acpi_handle handle, int type, u32 acpi_id)
>  		map_x2apic_id(header, type, acpi_id, &phys_id);
>  	else if (header->type == ACPI_MADT_TYPE_GENERIC_INTERRUPT)
>  		map_gicc_mpidr(header, type, acpi_id, &phys_id);
> +	else if (header->type == ACPI_MADT_TYPE_CORE_PIC)
> +		map_core_pic_id(header, type, acpi_id, &phys_id);
>  
>  exit:
>  	kfree(buffer.pointer);

