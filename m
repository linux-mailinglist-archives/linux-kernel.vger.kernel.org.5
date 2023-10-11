Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F328C7C54A6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjJKNCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJKNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:02:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E768B91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:01:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406553f6976so17417885e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697029317; x=1697634117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwgmh6+dGvGXg4dM1TwwbyonY61p5x8aIJa99FUZaaE=;
        b=c1tWXIuDijlNCti7LosAJv778aqkwrN4A2Ch/bJOD+Hw9j/zukYg/cfbHybA0jTNZL
         yR6CzqfW1ssC7IZginahZ3b2lWPShcSyI9ic0wJTVl5q+eK3GVXMCMYJzKClAPAO5k8C
         qkBlQ9TzPbcf/z0jHTofA93SQkzh/sYjIo4gp0HDfa4//Sms27S6FxbO10utVJM9GcrU
         MLzik6/FL3r0mQcpIQcZZq2hpXQyMku1YxGVPkdwR+Ax/4ObRAK0JKHklBcydhVaB3HW
         MaiWW/Y76EkJO+vL+H8iwNn2OlCHnoN90pMbhd5iyOVDB63/FPTZVV0r/YHZPUekSbHC
         QqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697029317; x=1697634117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwgmh6+dGvGXg4dM1TwwbyonY61p5x8aIJa99FUZaaE=;
        b=ZjS0bbF/OvB/LbQgLwcdhUkXVk2TH66fwzIdTVBT1CuEGs7fZyhyFkl03g/ahySHua
         X2MpuOM+KfiDqjR3owedME92pmLOzH/tFQhIn1oMVxjwo5vgBwnb5wo/2LoHYGW1Caf3
         7DmRQAa8UnUw5ahT+AAMQZKrSr7deFI/H2bk78cMc3b+mw4KdBJVJcK/U014CSaPux3O
         SMB2wylwKabDziKXvEZol2YdSba8zAC9EemMd2L+zwsa3ergByUL0dTmsScZYA51aYfe
         /hnl246ztNRNttChl8aKEEmE44b3R5QBvERRi/JWQZqlA0Jgo3t2VItGB63LVSwdHA51
         2qcw==
X-Gm-Message-State: AOJu0YylWlh8i1Uvqm7a3J1X1oHGNJY8Y8cTMGBVE37NjGyFrLhFKo3C
        ktfx5vTG9jCORECoqPL4/RIJ0Q==
X-Google-Smtp-Source: AGHT+IEhMkJ2UZs6Oq4f4tUpfy0l0nV4F52Qa2DFBj6+4HKIgbRMYasQqxe3N8vqkwv/ysHcS2lQQg==
X-Received: by 2002:a05:600c:1d03:b0:404:7606:a871 with SMTP id l3-20020a05600c1d0300b004047606a871mr18566318wms.2.1697029317191;
        Wed, 11 Oct 2023 06:01:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:9134:b302:d8b:a200? ([2a01:e0a:999:a3a0:9134:b302:d8b:a200])
        by smtp.gmail.com with ESMTPSA id x11-20020a05600c21cb00b00405bbfd5d16sm16970192wmj.7.2023.10.11.06.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 06:01:56 -0700 (PDT)
Message-ID: <7d8958a5-01cf-428d-bc40-efc06d1be8fe@rivosinc.com>
Date:   Wed, 11 Oct 2023 15:01:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, qemu_fw_cfg: Add support for RISC-V architecture
Content-Language: en-US
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Gabriel Somlo <somlo@cmu.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20231011114721.193732-1-bjorn@kernel.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20231011114721.193732-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Björn,

On 11/10/2023 13:47, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Qemu fw_cfg support was missing for RISC-V, which made it hard to do
> proper vmcore dumps from qemu.
> 
> Add the missing RISC-V arch-defines.
> 
> You can now do vmcore dumps from qemu. Add "-device vmcoreinfo" to the
> qemu command-line. From the qemu montior:

small typo here: monitor

>   (qemu) dump-guest-memory vmcore
> 
> The vmcore can now be used, e.g., with the "crash" utility.
> 
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>  drivers/firmware/Kconfig       | 2 +-
>  drivers/firmware/qemu_fw_cfg.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b59e3041fd62..f05ff56629b3 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -155,7 +155,7 @@ config RASPBERRYPI_FIRMWARE
>  
>  config FW_CFG_SYSFS
>  	tristate "QEMU fw_cfg device support in sysfs"
> -	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86)
> +	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
>  	depends on HAS_IOPORT_MAP
>  	default n
>  	help
> diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
> index a69399a6b7c0..1448f61173b3 100644
> --- a/drivers/firmware/qemu_fw_cfg.c
> +++ b/drivers/firmware/qemu_fw_cfg.c
> @@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
>  
>  /* arch-specific ctrl & data register offsets are not available in ACPI, DT */
>  #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
> -# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
> +# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV))
>  #  define FW_CFG_CTRL_OFF 0x08
>  #  define FW_CFG_DATA_OFF 0x00
>  #  define FW_CFG_DMA_OFF 0x10
> 
> base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5

I didn't know that qemu could generate vmcore files. BTW, whenever I
don't have 'crash' at hand, I often use them with gdb and vmlinux-gdb.py
debugging scripts. Anyway, works as expected:

Tested-by: Clément Léger <cleger@rivosinc.com>

Clément
