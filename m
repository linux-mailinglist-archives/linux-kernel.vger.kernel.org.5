Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63457F3970
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjKUWsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjKUWsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:48:13 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F601AC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:48:10 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7b34e7c829fso25587939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700606890; x=1701211690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ha2zL2RliN6J5b2kLDdhsZ6GbGCv9fZnJqsfyqkrjz4=;
        b=EF0u/8wDYnDq/mzYotbx4SZuvWtpVHtc0ek0+++Sx9lKALxa2HhcfhftDPGHItrgYP
         mOvbWORLeqEA4gheTOrDU7tAbjmmJgVSFXLo8XgzgmBetIRdzViMesogDTINvoMJRq17
         W88e7rT6ODkMZDtlTPEzuDmKe+KiQlN7EHAEJ4biPGDWCRCXUmwCOHEMiZpnjM75WkfF
         pitJfwviqcoJZnV1EM8B892CvTA7p+eoRGbUE3wSGlOHtlB5F7TxMdaRkw3d/LswvwGw
         ahQD1ZFaYgy7OCnp8wjaWc/Ge3FUSpLYbAuCwUNrKJsFEUUrXFM9PvaTkOIaCeulf3dO
         xonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700606890; x=1701211690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ha2zL2RliN6J5b2kLDdhsZ6GbGCv9fZnJqsfyqkrjz4=;
        b=uMcWbKqN/dCYop7m77KnlbpTr6KlfhxR+ymUioFHyoD7LnYqyONWyTwF7eTpMDQ8DE
         FaBzQGIZFTKfmsjTMbopi6JfQW/pK03ZVe7yPpiKBcEip408FtqZgLgqnrAW93ofWiU9
         /nOqVRuHIdlsf/DYIQP/cu2t3+fD4CB1Il8DOl41rQBnRQFfue0xHY+Ox/8FNPjmt/vg
         CRZYavtiVOywlaO+nWjvmv+lWYEi+3k6M3aHIJ2C6mUgOhPsdejLDR4D2EfGBBHw6j3b
         4s+HzH4WDlY9bYEPWKNZN0tpF92oldNYwX4YlfRvly/NYMi4rJ4bJP3G3voBvAVqJOIm
         QNdw==
X-Gm-Message-State: AOJu0YxllJLvuFP5lcslCmhvSRO7Deri01MYShSM7n0sNp0k8wTMxr+G
        DoDVfNgVI9e84+tBY+WWyWY7BA==
X-Google-Smtp-Source: AGHT+IEqopk3WpneTwAJdQEga6tdFjb3hMHKJSSM4AtmRyuOtlB2pSKEyHj6RtL8C3xrT6bMg/cE5g==
X-Received: by 2002:a05:6602:c08:b0:7aa:125a:b0c4 with SMTP id fn8-20020a0566020c0800b007aa125ab0c4mr437169iob.5.1700606889842;
        Tue, 21 Nov 2023 14:48:09 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:3d43:c8e2:1496:e620? ([2605:a601:adae:4500:3d43:c8e2:1496:e620])
        by smtp.gmail.com with ESMTPSA id fj34-20020a056638636200b004290fd3a68dsm2835154jab.1.2023.11.21.14.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 14:48:09 -0800 (PST)
Message-ID: <fb72e212-711e-4be9-9b92-89b2dc121476@sifive.com>
Date:   Tue, 21 Nov 2023 16:48:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] RISC-V: Enable SBI based earlycon support
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-6-apatel@ventanamicro.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231118033859.726692-6-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On 2023-11-17 9:38 PM, Anup Patel wrote:
> Let us enable SBI based earlycon support in defconfigs for both RV32
> and RV64 so that "earlycon=sbi" can be used again.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/configs/defconfig      | 1 +
>  arch/riscv/configs/rv32_defconfig | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 905881282a7c..eaf34e871e30 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -149,6 +149,7 @@ CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_SERIAL_SH_SCI=y
> +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 89b601e253a6..5721af39afd1 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig

This file isn't used anymore since 72f045d19f25 ("riscv: Fixup difference with
defconfig"), so there's no need to update it. I'll send a patch deleting it.

Regards,
Samuel

> @@ -66,6 +66,7 @@ CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  CONFIG_HW_RANDOM=y
>  CONFIG_HW_RANDOM_VIRTIO=y

