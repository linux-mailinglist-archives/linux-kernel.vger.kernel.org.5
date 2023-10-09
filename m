Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E787BEA7E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378354AbjJITWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378273AbjJITWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:22:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3EC93
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:22:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b6559cbd74so895094666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696879359; x=1697484159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W213PjLTqM3JEmBmT6cQ0NV691A2RnRzmI4p6V+/cyA=;
        b=dAcMgpiN0LWvK66wLQsELTxUO3nl3flvQzKo216b7GkR2f/vq8ZAWjvuXCG32cH2pm
         32VkSc19Bwnn+CSlo9WnwzPVvHnL6Vjdr9bl5O7fSQLhSzK4Tog6rz7XG7T9BnzlhDad
         gtU+UhPWdNs9X+J0Aeqgs8+T80hfRaKP/Bi0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696879359; x=1697484159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W213PjLTqM3JEmBmT6cQ0NV691A2RnRzmI4p6V+/cyA=;
        b=bIHlhOmNHE6ychf82EWkgYFdBX/3gJLauWnUVqZbqHjOYheqof5aXjqNcUkahRfU12
         b+tjA3rROrRgRDxRf7M36KNDeB6Y8SXjSkXLgfH2o0QR+YTeXwYQxtiW1Twlk2gsWFkY
         eu4R3Ht3/go7zzrvAeWOg6ei2COi5/oA+3uHHPRdWyC+7F9Jb+k3JPyxeLjKlEx7aTNd
         lHqyFyYzzxsOPWeKTJr9quJrylYAEJXwo85jP/pGFEIkvGrm31SVluv5amv4WQ7WVg4w
         x3WYXWdiCrFdD9QUUeaEyoB6XYJxcMhFvgqemw/skzJAzv6gWequFkw923vhMqwXDAR4
         8cMw==
X-Gm-Message-State: AOJu0YynDxyY0paeqIITYR4ZqORCtMz2+3MLfj5Wc5Qd92FE/WLagu83
        ObLZbp25Ok5Zyv5wdwwlnqRVyx3s2ZL6Ucies/Vutg==
X-Google-Smtp-Source: AGHT+IHc7jcdlWh8LiRicdltTnLDX2OAGb0AbRSSrZm/5DGfpUC/nMASnv47R9hAghm2qceVMSwbZySZxRl5RqG6+zE=
X-Received: by 2002:a17:906:3012:b0:9ae:4054:5d2a with SMTP id
 18-20020a170906301200b009ae40545d2amr14184483ejz.16.1696879358971; Mon, 09
 Oct 2023 12:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230926194242.2732127-1-sjg@chromium.org>
In-Reply-To: <20230926194242.2732127-1-sjg@chromium.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Mon, 9 Oct 2023 13:22:21 -0600
Message-ID: <CAPnjgZ1WgOB08C32PWdhagP5CRuBou8Z0ZPfxdAmRKD5uxKQJw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] schemas: memory: Add ECC properties
To:     devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        linux-acpi@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 26 Sept 2023 at 13:42, Simon Glass <sjg@chromium.org> wrote:
>
> Some memories provide ECC detection and/or correction. For software which
> wants to check memory, it is helpful to see which regions provide this
> feature.
>
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v7:
> - Drop unnecessary |
> - Add a blank line between properties
>
> Changes in v6:
> - Use a number of bits instead of a string property
> - Fix inidcates typo
>
> Changes in v5:
> - Redo to make this property specific to ECC
> - Provide properties both for detection and correction
>
> Changes in v3:
> - Add new patch to update the /memory nodes
>
>  dtschema/schemas/memory.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
> index 1d74410..b3bf3c9 100644
> --- a/dtschema/schemas/memory.yaml
> +++ b/dtschema/schemas/memory.yaml
> @@ -35,6 +35,19 @@ patternProperties:
>            For the purpose of identification, each NUMA node is associated with
>            a unique token known as a node id.
>
> +      ecc-detection-bits:
> +        default: 0
> +        description: |
> +          If present, this indicates the number of bits of memory error which
> +          can be detected and reported by the Error-Correction Code (ECC) memory
> +          subsystem (typically 0, 1 or 2).
> +
> +      ecc-correction-bits:
> +        default: 0
> +        description: |
> +          If present, this indicates the number of bits of memory error which
> +          can be corrected by the Error-Correction Code (ECC) memory subsystem
> +          (typically 0, 1 or 2).
>
>      required:
>        - device_type
> --
> 2.42.0.515.g380fc7ccd1-goog
>

What is the status of this patch, please?

Regards,
Simon
