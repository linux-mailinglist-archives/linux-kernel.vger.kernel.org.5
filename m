Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE3876D31C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjHBP5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbjHBP5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:57:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9B2E4C;
        Wed,  2 Aug 2023 08:57:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bc02bd4eafso143905ad.1;
        Wed, 02 Aug 2023 08:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690991858; x=1691596658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=N9wNAhPqFgTbxLDfrmmbpVuzhrbWWgtM2NDp+mcitMY=;
        b=QZgxZVXtdWxl4WWjLDKzIbJdAliyzaWxSLESrJszZdTcCo3INVM8UGhTS/jZAtsWeB
         +PGBRAPBd73e+2PsISFdKkE686unn2wpu2dpZGf+p+A9UjcjqhaxUsdjM7leHIvM0ngm
         3hvs41il3sA5uw3z45G99It0eWa8V66nPlksqD5NqUPMw+Exr4EocVDHcIdSbhTVQicV
         LOgrQymHnGftByApwhc93Osky56PGSBsCioOrVhlqYLyJO4mrj1TbyHdgNORMUEvNuYe
         onEVCpZsYOAA7LloUpoWpY1H+gMPoqbXK6uv8F6CkcTocjODDEOD9JZtqPbpKLq7Nsgt
         LhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690991859; x=1691596659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9wNAhPqFgTbxLDfrmmbpVuzhrbWWgtM2NDp+mcitMY=;
        b=C5ClcSGIhdotvBeJ/L3o9fdP4p94Rjpo0vOAheFjIZsAoh2/6ezQw2y5KKEMOorOeE
         nrPnx11KU4d6+QXq8WpZLFCLO10DeDu9arJPR3qCLqKlqBtGW8uqZQczBkwY9pPhJzp9
         uOx+abwvhMWWmCyZPhwdFnENAggzMLEFVCjDXYOWRuJCcqwjxwTtqcQMc4DJORJ9DO1H
         dCg1cXnTp0FL3NyoitoPp76/IqWhtNl2c0kvHC4gqrikdgTbKcFFXkMZuqICQRTzMtMG
         N/JhG4anfvZjHDTsNsHEfsNI3PzJ4kGNXa77Mh6eAu1M5pjd7PkKdTNCn+enBD/eGx6H
         zsJw==
X-Gm-Message-State: ABy/qLZzouguAslP04M63Lk5IS0s3NYvKdT9KogPd8ArpnZhOxxe2OPi
        9XfanCsK/8CVNSGo1QwfSBU=
X-Google-Smtp-Source: APBJJlHsebdUak/go0iiZG98GxtaXMG+Is9rWwsCfHOJpX7lNvEsHOO7pvzOnlUL1KDJ26juBEbwvg==
X-Received: by 2002:a17:902:ea09:b0:1b8:76ce:9d91 with SMTP id s9-20020a170902ea0900b001b876ce9d91mr19841513plg.1.1690991858140;
        Wed, 02 Aug 2023 08:57:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d31500b001b89891bfc4sm12608481plc.199.2023.08.02.08.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 08:57:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <65d29f18-8b1e-7f63-a377-a7520dc19b88@roeck-us.net>
Date:   Wed, 2 Aug 2023 08:57:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] sh: fix asm-generic/io.h inclusion
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230802141658.2064864-1-arnd@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230802141658.2064864-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 07:16, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent cleanup patch started using the generic asm/io.h header from
> the sh version, but unfortunately this caused build regressions in many
> configurations, such as:
> 
> include/asm-generic/io.h:636:15: error: redefinition of ‘inb_p’
> 
> I added some of the missing defines that are needed to keep using the
> sh specific implementations rather than the generic ones where they
> clash. I build all sh defconfig files to catch the various combinations
> of CONFIG_MMU, CONFIG_GENERIC_IOMAP and CONFIG_NO_IOPORT_MAP, this should
> cover them all.
> 
> A lot of the sh specific functions are equivalent to the generic ones
> and could in fact be removed, but it would be best to only do that with
> actual runtime testing.
> 
> In particular, the indirect ioport_map() implementation is only used
> for the "microdev" platform that appears to be broken beyond repair
> for as long as the git history goes, so removing both microdev and the
> custom ioport handling in favor of the asm-generic/io.h version would
> be a great cleanup, but this can be done another time if anyone feels
> motivated to clean up arch/sh.
> 
> Fixes: e41f1f7ff6c2b ("sh: add <asm-generic/io.h> including")
> Link: https://lore.kernel.org/lkml/09094baf-dadf-4bce-9f63-f2a1f255f9a8@app.fastmail.com/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Andrew, can you pick this up into the mm tree on top of the
> "sh: add <asm-generic/io.h> including" patch?
> ---
>   arch/sh/include/asm/io.h          | 24 ++++++++++++++++++++++++
>   arch/sh/include/asm/io_noioport.h | 14 --------------
>   2 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index 24c560c065ec7..f2f38e9d489ac 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -119,6 +119,10 @@ void __raw_readsl(const void __iomem *addr, void *data, int longlen);
>   
>   __BUILD_MEMORY_STRING(__raw_, q, u64)
>   
> +#define ioport_map ioport_map
> +#define ioport_unmap ioport_unmap
> +#define pci_iounmap pci_iounmap
> +
>   #define ioread8 ioread8
>   #define ioread16 ioread16
>   #define ioread16be ioread16be
> @@ -241,6 +245,26 @@ __BUILD_IOPORT_STRING(q, u64)
>   
>   #endif
>   
> +#define inb(addr)      inb(addr)
> +#define inw(addr)      inw(addr)
> +#define inl(addr)      inl(addr)
> +#define outb(x, addr)  outb((x), (addr))
> +#define outw(x, addr)  outw((x), (addr))
> +#define outl(x, addr)  outl((x), (addr))
> +
> +#define inb_p(addr)    inb(addr)
> +#define inw_p(addr)    inw(addr)
> +#define inl_p(addr)    inl(addr)
> +#define outb_p(x, addr)        outb((x), (addr))
> +#define outw_p(x, addr)        outw((x), (addr))
> +#define outl_p(x, addr)        outl((x), (addr))
> +
> +#define insb insb
> +#define insw insw
> +#define insl insl
> +#define outsb outsb
> +#define outsw outsw
> +#define outsl outsl
>   
>   #define IO_SPACE_LIMIT 0xffffffff
>   
> diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
> index 5ba4116b4265c..12dad91f41c1e 100644
> --- a/arch/sh/include/asm/io_noioport.h
> +++ b/arch/sh/include/asm/io_noioport.h
> @@ -46,20 +46,6 @@ static inline void ioport_unmap(void __iomem *addr)
>   	BUG();
>   }
>   
> -#define inb_p(addr)	inb(addr)
> -#define inw_p(addr)	inw(addr)
> -#define inl_p(addr)	inl(addr)
> -#define outb_p(x, addr)	outb((x), (addr))
> -#define outw_p(x, addr)	outw((x), (addr))
> -#define outl_p(x, addr)	outl((x), (addr))
> -
> -#define insb insb
> -#define insw insw
> -#define insl insl
> -#define outsb outsb
> -#define outsw outsw
> -#define outsl outsl
> -
>   static inline void insb(unsigned long port, void *dst, unsigned long count)
>   {
>   	BUG();

