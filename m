Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D7791DC3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjIDTnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjIDTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:43:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08761A9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:43:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68cbbff84f6so1079744b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693856608; x=1694461408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpgtqNc982jm6C77O91KC+VtBx5DYfDGNKAMWB7AFSc=;
        b=1UaigpSP2aqbSka9fFMZQrnGBtA4D7Ith1BgoWL0uskJBSs2sOisRV5lkV1F7XLRj9
         0B0SsssrT8T9YhysaxPf29NBf7PDy6QCvElghBXuEPkTKwn7rvaqxd1VxOQvBYzzwtAZ
         2MYWrQN3C9mhgOHmGU3aEcV+ULc7UJ7sCLDzAq02TeJPvRE3CPKnGmnkFYP4lHtabIlm
         CDD7rk9k+i+odQf2880180qDVrNCOctSvNJZtdsu/su75EnnfHQobNp6TOEX6GHudWe0
         UjSnz8gtBI03FEh+cMDke7qTub2SQp8AJ2n7DKt5ON2xrqIw00SEHAQiySdpTR2HhONh
         tJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693856608; x=1694461408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpgtqNc982jm6C77O91KC+VtBx5DYfDGNKAMWB7AFSc=;
        b=YR/MykK8QOHsMrLiPzSACXHnonOMAWEL4/MpypN911gDeznX/Exub8efEHrVI6hLCI
         lmU98Xpbg0lXf56okGK560UHAHIzUboZIRZQ/vkANtQU6CrejgjlRJ6q26OiOfkWZhle
         YD3bfDQ1qq548p80VAzqaWGzl4kBs28mgIRXrktN9FpQ/AOudpTXFucIDNZmjaTjipcq
         p+aFex7sOVVFgIK6RhqKeABnzkYjP4IDAZ4obY3ZT9kG7IQhGVRIIuVGw18f7geRMVCP
         oEDcrxoylDWHU/zYroilLdIgxzCdBWzlSPrKnOgZZCl4t+n8IaQgDHv3Ybq5cZ1/4D2G
         P2ig==
X-Gm-Message-State: AOJu0Yxb2kJEBX/bZF0nzsKFzSx5qBNV6gYYm0bDgpTdMaKcyjt0YyOt
        p46YwkgjCqFHrB94TWuSmCKWlg==
X-Google-Smtp-Source: AGHT+IGfcS2SDfogz0dRFnKhjncd+2SLbW5sc2UgXzdJiBdlv5fZg3HB0wO/3nWY6uYOWCJ5JMOBXg==
X-Received: by 2002:a05:6a20:441c:b0:14e:2208:d62f with SMTP id ce28-20020a056a20441c00b0014e2208d62fmr17267240pzb.22.1693856608420;
        Mon, 04 Sep 2023 12:43:28 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:5de2:2323:20de:e26d])
        by smtp.gmail.com with ESMTPSA id y14-20020aa7854e000000b00687a4b66697sm7962611pfn.16.2023.09.04.12.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 12:43:27 -0700 (PDT)
Date:   Mon, 4 Sep 2023 12:43:25 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 1/2] riscv: errata: fix T-Head dcache.cva encoding
Message-ID: <ZPYzXeYGyGCxJUuK@x1>
References: <20230827090813.1353-1-jszhang@kernel.org>
 <20230827090813.1353-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827090813.1353-2-jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 05:08:12PM +0800, Jisheng Zhang wrote:
> From: Icenowy Zheng <uwu@icenowy.me>
> 
> The dcache.cva encoding shown in the comments are wrong, it's for
> dcache.cval1 (which is restricted to L1) instead.
> 
> Fix this in the comment and in the hardcoded instruction.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Tested-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/include/asm/errata_list.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index fb1a810f3d8c..feab334dd832 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -100,7 +100,7 @@ asm volatile(ALTERNATIVE(						\
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
>   *   0000001    01001      rs1       000      00000  0001011
>   * dcache.cva rs1 (clean, virtual address)
> - *   0000001    00100      rs1       000      00000  0001011
> + *   0000001    00101      rs1       000      00000  0001011
>   *
>   * dcache.cipa rs1 (clean then invalidate, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> @@ -113,7 +113,7 @@ asm volatile(ALTERNATIVE(						\
>   *   0000000    11001     00000      000      00000  0001011
>   */
>  #define THEAD_inval_A0	".long 0x0265000b"
> -#define THEAD_clean_A0	".long 0x0245000b"
> +#define THEAD_clean_A0	".long 0x0255000b"
>  #define THEAD_flush_A0	".long 0x0275000b"
>  #define THEAD_SYNC_S	".long 0x0190000b"
>  
> -- 
> 2.40.1
> 

Tested-by: Drew Fustini <dfustini@baylibre.com>

I applied this on top of the emmc series [1] and the dma-noncoherent dts
patch [2]. SDMA is now working with this patch applied. Before this
patch, the filesystems on the emmc were corrupted after mounting. It
makes sense that problem is solved by the correct cache clean
instruction being used.

Thanks,
Drew

[1] https://lore.kernel.org/linux-riscv/20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com/
[2] https://lore.kernel.org/linux-riscv/ZOIBQI3L4kP7c%2FT1@xhacker/
