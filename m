Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33A27B5355
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbjJBMg5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 08:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbjJBMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:36:55 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A55AC;
        Mon,  2 Oct 2023 05:36:52 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a1f00b75aaso84068577b3.2;
        Mon, 02 Oct 2023 05:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696250211; x=1696855011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9j0PpNIdrPUDtiR3cxgxShKWUlwOhB2yoLPPXuZS+o=;
        b=qo612oQLkfCv8FAxj7uOfw5mzS3yuOPNZ7FQsggpL2/xha/U2ngpIL4XbX0SZq9su3
         iCIw1TzRKMQxI57f3LTHOoZkVLLQ9xsE3s5vQhVqEQnSpwBxzRuk8ZES8oOg6caSaTAK
         9COjLNjMXZxm9AME8zIstqD72OGxVrbvgj3E+zGSlWqLSZVO+d2+jDvX52WZQXYwl4Ah
         wqy5nJ4DzcMW8akgxPFuG6wuJPHALPv1o6+t/gTo8KsZVCyWlHRgpg82feKu/3bgt9ij
         3TPu3lnsSa+yXE8t+hpoGoX5TdAS7fMY3AnlK9k32n00sLjv7TvgJWbPpYCNJrOpoSG0
         8xsg==
X-Gm-Message-State: AOJu0YxRvbhticg71WU6bUT4rtVH7eqsVD/sRfjOVnyPa0w3erNz2Wfn
        zSec9Wcco4rXx1p4wtUtFQP4gUrO1NRkDQ==
X-Google-Smtp-Source: AGHT+IGIQEyVkOFi0f9ckQusV9TVcCdn4dnHOQcVN3IVkvJrsy/p3A5iU6i576jsl/jzsFEUYQ6Psg==
X-Received: by 2002:a81:df11:0:b0:59b:dbb7:5c74 with SMTP id c17-20020a81df11000000b0059bdbb75c74mr9932795ywn.32.1696250211439;
        Mon, 02 Oct 2023 05:36:51 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id d64-20020a0df443000000b0059511008958sm7700588ywf.76.2023.10.02.05.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 05:36:51 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a1f00b75aaso84068407b3.2;
        Mon, 02 Oct 2023 05:36:51 -0700 (PDT)
X-Received: by 2002:a81:df11:0:b0:59b:dbb7:5c74 with SMTP id
 c17-20020a81df11000000b0059bdbb75c74mr9932772ywn.32.1696250210751; Mon, 02
 Oct 2023 05:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231002113441.19571-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20231002113441.19571-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Oct 2023 14:36:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXa7BBKzhLAcruCk7YKumNcCuRLk8bRfXAL+fKWOPkkOA@mail.gmail.com>
Message-ID: <CAMuHMdXa7BBKzhLAcruCk7YKumNcCuRLk8bRfXAL+fKWOPkkOA@mail.gmail.com>
Subject: Re: [PATCH RESEND] arm64: dts: renesas: r8a77990: Add Ebisu-4D board support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Mon, Oct 2, 2023 at 1:35 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Add initial support for the Renesas Ebisu-4D development board.
>
> The Ebisu-4D board is very similar to the Ebisu board, but the memory
> configuration is different.
>
>   - The memory map of Ebisu-4D board is as follows:
>       Bank0: 2 GiB RAM : 0x000048000000 -> 0x000bfffffff
>
>   - The memory map of Ebisu board is as follows:
>       Bank0: 1 GiB RAM : 0x000048000000 -> 0x0007fffffff
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [wsa: rebased]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> Resending this patch because I want to utilize all 2GB of memory on my
> Ebisu. Since nobody updated U-Boot to handle different RAM sizes on
> Ebisu in the last 4.5 years, let's add the Ebisu-4D as a seperate board.

This patch is not needed: TF-A passes the memory size to U-Boot,
which updates the /memory node in the DTB passed to Linux:

$ dtc -O ebisu/r8a77990-ebisu.dtb | grep -A2 -w memory
    memory@48000000 {
            device_type = "memory";
            reg = <0x00 0x48000000 0x00 0x38000000>;
    };

When booting:

    NOTICE:  BL2: R-Car Gen3 Initial Program Loader(CA53) Rev.3.0.3
    NOTICE:  BL2: PRR is R-Car E3 Ver.1.0
    NOTICE:  BL2: PLL1 nonSSCG Clock select
    NOTICE:  BL2: Board is Ebisu-4D Rev.1.0
    ...
    NOTICE:  BL2: CH0: 400000000 - 47fffffff, 2 GiB
    ..
    U-Boot 2022.04-rc4-00082-g54082b91f22f7a49 (Mar 25 2022 - 11:25:09 +0100)

    CPU:   Renesas Electronics R8A77990 rev 1.0
    Model: Renesas Ebisu-4D board rev 1.0
    DRAM:  1.9 GiB
    ...
    Booting Linux on physical CPU 0x0000000000 [0x410fd034]
    Linux version 6.6.0-rc3-ebisu-03722-g180199a69b82 (geert@rox)
(aarch64-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0, GNU ld
(GNU Binutils for Ubuntu) 2.38) #546 SMP Tue Sep 26 13:26:12 CEST 2023
    Machine model: Renesas Ebisu board based on r8a77990
    printk: debug: ignoring loglevel setting.
    efi: UEFI not found.
    Zone ranges:
       DMA      [mem 0x0000000048000000-0x00000000bfffffff]
    ...
    Memory: 1755932K/1966080K available (9088K kernel code, 2496K
rwdata, 4188K rodata, 3072K init, 17571K bss, 144612K reserved, 65536K
cma-reserved)

root@ebisu:~# hd /sys/firmware/devicetree/base/memory@48000000/reg
00000000  00 00 00 00 48 00 00 00  00 00 00 00 78 00 00 00  |....H.......x...|
00000010

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
