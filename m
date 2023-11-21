Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998117F354B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjKURvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjKURvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:51:13 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8912C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:51:09 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a98fdeaac7so233337039f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700589068; x=1701193868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F3VZHmlNlu0O99ZtiO5dO2f9VsPMxl7hcUKuMcRux78=;
        b=AAdhhZrGqtO9WX/0FJiROZuuVxqztoHrrSFtt+2EpVaGInKdHxws/PoOYU2IsaOInz
         hGBl/OuVtxzzGzrfbSYTqmia6mywEVuhl1HQtSw5h3+7ydK7fIK3WKvZkdlH27VmqDlJ
         zV//3P5p51mo48JT+JZeH3fCKjTtSaILwEHwoxAOpZOBzuVDJl9zkm0GpeMryT0QNAU7
         uGH8WCu9cqfFfgQWBt4SDGKLB08+7UWZZosv3kKzEydhTcI6YTFBTRMwzlOrKR0gZtlv
         3te1yyRC0hfjEwnStAXjVLzjibVChSauDsEl4Ueu9c0Cobi+r7vOZE3HEQWZyx6W3lBD
         yJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700589068; x=1701193868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3VZHmlNlu0O99ZtiO5dO2f9VsPMxl7hcUKuMcRux78=;
        b=dDl7TSHtFNw/KDLHDurknaAWZEEdBLOYkondz+Yo3BAmHDE9XhSojIyQFoFR+2f+mk
         lGbA6m52s/NLyj2yJpp/hjUZ+axyP8dhNBAGU80Ki5p5kUhuohd1g/MGS1AXshZuYNFA
         RKyUsNDaO9IKzKlRNXa+QBYUY06x6lRaCCZyrBRvL6tHxWM2ph96M4phfc5bzcDCHz4N
         nIbcNennkSJ0gXgY2xMsY4MM6964CQREFjrBwiM2HALzoR4suOsiz1BRmq3vw2AxuBcF
         WRN0BqH6rFYUCWzCTsEYnXNYHdA1g+UYjHhY6CaJpAPmJhDaB2BFETkdF3B26qUEgXxf
         yKyQ==
X-Gm-Message-State: AOJu0YwESCdO5K0QVCICXHl2lWyq9qoS0N5hbbFX/p8kICw03lOF/oul
        d4Nfa9eEOUfJmjwCzYxuvr45CVFRv7RIwL88WwU=
X-Google-Smtp-Source: AGHT+IEIMVbZd/opiVLMX9t1gte/ruLkANfduOCEUWfGVPu+dBFO4cz1YKq267xfZYCyskPVuqaPog==
X-Received: by 2002:a05:6602:4f44:b0:79f:d4e6:5175 with SMTP id gm4-20020a0566024f4400b0079fd4e65175mr69374iob.16.1700589068654;
        Tue, 21 Nov 2023 09:51:08 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:9465:402f:4b0a:1116? ([2605:a601:adae:4500:9465:402f:4b0a:1116])
        by smtp.gmail.com with ESMTPSA id t5-20020a056638204500b00466526e1e02sm1663632jaj.135.2023.11.21.09.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:51:08 -0800 (PST)
Message-ID: <218f068c-40b5-4f93-b26a-c300054be11e@sifive.com>
Date:   Tue, 21 Nov 2023 11:51:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: add dependency among Image(.gz), loader(.bin),
 and vmlinuz.efi
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Simon Glass <sjg@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
References: <20231119100024.2370992-1-masahiroy@kernel.org>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231119100024.2370992-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-19 4:00 AM, Masahiro Yamada wrote:
> A common issue in Makefile is a race in parallel building.
> 
> You need to be careful to prevent multiple threads from writing to the
> same file simultaneously.
> 
> Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> generate invalid images") addressed such a bad scenario.
> 
> A similar symptom occurs with the following command:
> 
>   $ make -j$(nproc) ARCH=riscv Image Image.gz loader loader.bin vmlinuz.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     GZIP    arch/riscv/boot/Image.gz
>     AS      arch/riscv/boot/loader.o
>     AS      arch/riscv/boot/loader.o
>     Kernel: arch/riscv/boot/Image is ready
>     PAD     arch/riscv/boot/vmlinux.bin
>     GZIP    arch/riscv/boot/vmlinuz
>     Kernel: arch/riscv/boot/loader is ready
>     OBJCOPY arch/riscv/boot/loader.bin
>     Kernel: arch/riscv/boot/loader.bin is ready
>     Kernel: arch/riscv/boot/Image.gz is ready
>     OBJCOPY arch/riscv/boot/vmlinuz.o
>     LD      arch/riscv/boot/vmlinuz.efi.elf
>     OBJCOPY arch/riscv/boot/vmlinuz.efi
>     Kernel: arch/riscv/boot/vmlinuz.efi is ready
> 
> The log "OBJCOPY arch/riscv/boot/Image" is displayed 5 times.
> (also "AS      arch/riscv/boot/loader.o" twice.)
> 
> It indicates that 5 threads simultaneously enter arch/riscv/boot/
> and write to arch/riscv/boot/Image.
> 
> It occasionally leads to a build failure:
> 
>   $ make -j$(nproc) ARCH=riscv Image Image.gz loader loader.bin vmlinuz.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     PAD     arch/riscv/boot/vmlinux.bin
>   truncate: Invalid number: 'arch/riscv/boot/vmlinux.bin'
>   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13: arch/riscv/boot/vmlinux.bin] Error 1
>   make[2]: *** Deleting file 'arch/riscv/boot/vmlinux.bin'
>   make[1]: *** [arch/riscv/Makefile:167: vmlinuz.efi] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>     Kernel: arch/riscv/boot/Image is ready
>     GZIP    arch/riscv/boot/Image.gz
>     AS      arch/riscv/boot/loader.o
>     AS      arch/riscv/boot/loader.o
>     Kernel: arch/riscv/boot/loader is ready
>     OBJCOPY arch/riscv/boot/loader.bin
>     Kernel: arch/riscv/boot/loader.bin is ready
>     Kernel: arch/riscv/boot/Image.gz is ready
>   make: *** [Makefile:234: __sub-make] Error 2
> 
> Image.gz, loader, vmlinuz.efi depend on Image. loader.bin depends
> on loader. Such dependencies are not specified in arch/riscv/Makefile.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
> Changes in v2:
>   - Fix commit log
> 
>  arch/riscv/Makefile | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>

