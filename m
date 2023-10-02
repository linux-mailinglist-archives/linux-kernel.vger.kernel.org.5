Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324A67B53B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbjJBNMh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 09:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbjJBNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:12:34 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FDEB4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:12:32 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59f6e6b7600so139753087b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 06:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696252351; x=1696857151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sH/JE9V8CyScfvNbdP533tae/oPZjky+UiCYZoWPE1E=;
        b=QB0B2+XuFT9SDG2dFgvFyoihPX2Wb1gGUbKv0eOtewbDK+IR8TKGXzmhNxkBzo0xQO
         IxvoKWVGC4pbjxHVQkmGSPCTij/kuTcVRcpAeXE1M9WzQgWtiP4Lnm598bBWELroOIDQ
         +DsIruJZG4oLfjc1yBZ26rX7w22NN+SuWsiKDBfZyIuKHab8Dz7H+mpeRVbhblmNy0Zn
         72HDsGnR8vZKZZwg7sb+UYYh8dV/xv5XGQhK4zTZavOLr7XYDnhjCUe6nh7zs2zjxorf
         1VJJoZXGMe9Udj5jd4X7U3sFUGeTI/vanpEcuf4BwugmWMg8NaWoVjS1K7d+SdqetU4l
         aLsw==
X-Gm-Message-State: AOJu0Yy5oMBXFPmNjG0MWS9ST0feRT5jyI0qFhGjD/nifPYlsLkWPqoU
        W5YUhMZj5KL0Ellkfsu0bLU1ZhrHzrPjxw==
X-Google-Smtp-Source: AGHT+IGiFGlKdeki9k57Mdnq/CnF+IvyLvDVNjeSHVDLf9wAkl5AFjP9Y1F51wXpCzskpkN1h3ohtw==
X-Received: by 2002:a0d:cccd:0:b0:573:285a:967f with SMTP id o196-20020a0dcccd000000b00573285a967fmr12569519ywd.38.1696252350791;
        Mon, 02 Oct 2023 06:12:30 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id r76-20020a0de84f000000b0059beb468cb4sm7757198ywe.1.2023.10.02.06.12.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 06:12:30 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f4f80d084so159854877b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 06:12:30 -0700 (PDT)
X-Received: by 2002:a81:5305:0:b0:57a:8ecb:11ad with SMTP id
 h5-20020a815305000000b0057a8ecb11admr11166921ywb.43.1696252350020; Mon, 02
 Oct 2023 06:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230925155328.443664-1-arnd@kernel.org>
In-Reply-To: <20230925155328.443664-1-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Oct 2023 15:12:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWFCSQgsf_0qwdkkAif3zDXM2N-WEymJBa1eeT4N6Ezcw@mail.gmail.com>
Message-ID: <CAMuHMdWFCSQgsf_0qwdkkAif3zDXM2N-WEymJBa1eeT4N6Ezcw@mail.gmail.com>
Subject: Re: [PATCH] m68k: asm/io.h: mark mmio read addresses as const
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Sep 25, 2023 at 5:53 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Passing constant __iomem tokens into the readl() family of helpers
> or any of the others causes a warning on m68k:
>
> include/asm-generic/io.h: In function 'ioread8_rep':
> arch/m68k/include/asm/io_mm.h:375:44: warning: passing argument 1 of 'raw_insb' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>      375 | #define readsb(port, buf, nr)     raw_insb((port), (u8
>
> Add a 'const' modifier to the pointers to shut up the warnings here.
>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309251926.bPl23AhG-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for your patch!

> --- a/arch/m68k/include/asm/raw_io.h
> +++ b/arch/m68k/include/asm/raw_io.h
> @@ -17,15 +17,15 @@
>   * two accesses to memory, which may be undesirable for some devices.
>   */
>  #define in_8(addr) \
> -    ({ u8 __v = (*(__force volatile u8 *) (unsigned long)(addr)); __v; })
> +    ({ u8 __v = (*(__force const volatile u8 *) (unsigned long)(addr)); __v; })
>  #define in_be16(addr) \
> -    ({ u16 __v = (*(__force volatile u16 *) (unsigned long)(addr)); __v; })
> +    ({ u16 __v = (*(__force const volatile u16 *) (unsigned long)(addr)); __v; })
>  #define in_be32(addr) \
> -    ({ u32 __v = (*(__force volatile u32 *) (unsigned long)(addr)); __v; })
> +    ({ u32 __v = (*(__force const volatile u32 *) (unsigned long)(addr)); __v; })
>  #define in_le16(addr) \
> -    ({ u16 __v = le16_to_cpu(*(__force volatile __le16 *) (unsigned long)(addr)); __v; })
> +    ({ u16 __v = le16_to_cpu(*(__force const volatile __le16 *) (unsigned long)(addr)); __v; })
>  #define in_le32(addr) \
> -    ({ u32 __v = le32_to_cpu(*(__force volatile __le32 *) (unsigned long)(addr)); __v; })
> +    ({ u32 __v = le32_to_cpu(*(__force const volatile __le32 *) (unsigned long)(addr)); __v; })
>
>  #define out_8(addr,b) (void)((*(__force volatile u8 *) (unsigned long)(addr)) = (b))
>  #define out_be16(addr,w) (void)((*(__force volatile u16 *) (unsigned long)(addr)) = (w))

Shouldn't a similar change be made to rom_in_{8,be16,le16}()?

I can do that while applying...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
