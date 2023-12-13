Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7419811229
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379057AbjLMMzU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 07:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378923AbjLMMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:55:05 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF111135;
        Wed, 13 Dec 2023 04:54:20 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9d6f8485eso881268a34.0;
        Wed, 13 Dec 2023 04:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472060; x=1703076860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crfJNz0NkMSgeWJLA+8VmC2tAn5+LLBTeE17x+YD3zU=;
        b=IBfaxsTw1YAxxZVBiqYcWshZomsbKgyB/093BsgmmFo3aSm3CxLFSqG9oO8qBJ3rkO
         MuKhx0VSrbaYFzpptWInZmJ6pLAsawC/VH3SSaKK8jTCqrL3fqk0eCNzCrZNm5C3Avbz
         rOUkxmZNHTcVUsZ3jdBh293I0NWddVpmsczN5opoCjZ4ySMHiHtE9VkqSLM4qvgc3I2f
         oIXG6dFks8qCYeuni41Yl5pU5Z2k0D8v3GJsHnkJPUjA+yn2oeCgtHcpOeVJp3a8M9YB
         KWOlYs7lANBs2RTzzog/+oyRpiZ1JYfhCrdwup8URtYVSV8MmDrgAPV7/x1ybqRJBZJd
         d5pQ==
X-Gm-Message-State: AOJu0YyFcVLxd84gLOQygcy3aPg6CY1E9UWjHsFdc+wREMSxaPMD1aCk
        vy6eZLw0H70QSwdzpVZpGzi5Z0KGKst7TDVBUWA=
X-Google-Smtp-Source: AGHT+IGTjq/sWv6/5ezFagRPcm/+m5+0/03bDruODCWo4EA6LeQXWlw8BBuzZ1wmN8iH4LPg+xKop62digTZ8Cldh6g=
X-Received: by 2002:a05:6870:1484:b0:1fa:f0ee:ba9c with SMTP id
 k4-20020a056870148400b001faf0eeba9cmr15174841oab.2.1702472059801; Wed, 13 Dec
 2023 04:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20231212214843.256622-1-arnd@kernel.org>
In-Reply-To: <20231212214843.256622-1-arnd@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 13:54:09 +0100
Message-ID: <CAJZ5v0jMcHCJpDBFO90217Q264JN1LLtc215oP5YQhBk8s1wVA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: arm64: export acpi_arch_thermal_cpufreq_pctg
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Gupta <sumitg@nvidia.com>,
        Srikar Srimath Tirumala <srikars@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:48 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The cpufreq code can be in a loadable module, so the architecture support
> for it has to be exported:
>
> ERROR: modpost: "acpi_arch_thermal_cpufreq_pctg" [drivers/acpi/processor.ko] undefined!
>
> Fixes: 310293a2b941 ("ACPI: processor: reduce CPUFREQ thermal reduction pctg for Tegra241")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/arm64/thermal_cpufreq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
> index d524f2cd6044..582854914c5c 100644
> --- a/drivers/acpi/arm64/thermal_cpufreq.c
> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/acpi.h>
> +#include <linux/export.h>
>
>  #include "../internal.h"
>
> @@ -18,3 +19,4 @@ int acpi_arch_thermal_cpufreq_pctg(void)
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(acpi_arch_thermal_cpufreq_pctg);
> --

Applied, thanks!
