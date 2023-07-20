Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E5B75A6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGTGkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGTGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:39:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30AC35AD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:39:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15C61618C9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7C8C433C8;
        Thu, 20 Jul 2023 06:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689835127;
        bh=JUczBgKxXZiHONsdlYXF6A80Z7d/kbeRft7c934WaD0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NxJd/81KtsyKg/wa11OhHkXzaEsTFhth/WuAbQtTnr1brzjJrc2zJvQc5yIVsiMqg
         2CVsemVq8+V/2Jz5LhBbWDQ224CQUTfzR5CYugjGB8F7xt5l7aIIemG/sb8LAZ+QbG
         ZOgbfouoypCS5fmjNHoeZfAO9nEcOwO81Ewmpljl7tIGcs1yQdX040NRsbLe0QWxhR
         12wXpInVUbtI9WEgf62AXOHuQaaQAspWnsEAVGkOCDsefAWEY9uFdo4r9imscLPIdQ
         gDsR2Yi/wiegRPEog/A/1V1TD+pzJAxpsZQslxBMYpwRnpQZomV/+UfbTiOSSuRC6c
         686yLmeSNbQDg==
Message-ID: <c26d029e-dabc-9ad2-ed42-bb6ee276e3fb@kernel.org>
Date:   Thu, 20 Jul 2023 08:38:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/11] RISC-V: drivers/iommu/riscv: Add sysfs interface
Content-Language: en-US
To:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <610abe685f90870be52bc7c2ca45ab5235bd8eb4.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 21:33, Tomasz Jeznach wrote:
> Enable sysfs debug / visibility interface providing restricted
> access to hardware registers.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> 
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>  drivers/iommu/riscv/Makefile      |   2 +-
>  drivers/iommu/riscv/iommu-sysfs.c | 183 ++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.c       |   7 ++
>  drivers/iommu/riscv/iommu.h       |   2 +
>  4 files changed, 193 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/riscv/iommu-sysfs.c
> 
> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
> index 38730c11e4a8..9523eb053cfc 100644
> --- a/drivers/iommu/riscv/Makefile
> +++ b/drivers/iommu/riscv/Makefile
> @@ -1 +1 @@
> -obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-pci.o iommu-platform.o
> \ No newline at end of file
> +obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-pci.o iommu-platform.o iommu-sysfs.o
> \ No newline at end of file

You have this error in multiple places.

> diff --git a/drivers/iommu/riscv/iommu-sysfs.c b/drivers/iommu/riscv/iommu-sysfs.c
> new file mode 100644
> index 000000000000..f038ea8445c5
> --- /dev/null
> +++ b/drivers/iommu/riscv/iommu-sysfs.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IOMMU API for RISC-V architected Ziommu implementations.
> + *
> + * Copyright © 2022-2023 Rivos Inc.
> + *
> + * Author: Tomasz Jeznach <tjeznach@rivosinc.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/compiler.h>
> +#include <linux/iommu.h>
> +#include <linux/platform_device.h>
> +#include <asm/page.h>
> +
> +#include "iommu.h"
> +
> +#define sysfs_dev_to_iommu(dev) \
> +	container_of(dev_get_drvdata(dev), struct riscv_iommu_device, iommu)
> +
> +static ssize_t address_show(struct device *dev,
> +			    struct device_attribute *attr, char *buf)


Where is the sysfs ABI documented?


Best regards,
Krzysztof

