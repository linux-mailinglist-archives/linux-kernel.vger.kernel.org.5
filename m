Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733807664C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjG1HE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjG1HEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:04:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BC6268B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:04:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fa455cd94so1062153a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690527889; x=1691132689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wrwpb7rVTyYgrDu2LzfWhd5QBSrpJqCmxUGFCtGyRxE=;
        b=HnNBF9FNxGUGcdq72feS4vzTAgz0S2xFrpjfptHFXDmIUUMf0+rsfFDBqC2ScjUbKz
         umiiQMv2yfwN/+2EI2WvRogXyZJdWr6bLFFsUu3iSptlbMQawDUr7bHclNJPap/lp0kD
         kGz6QmaoOBFvXiNpicfwfM93W5ym8He5JnV+XRbLknn+OJltHWHesQIhVqS7KUQ44fxC
         up4WV6A7BcSSto/oqS+D1YE1nZ6jPVDvDx4cocNpgn0bAztE0SaLeo/DCjamR0zH4GvK
         2zNMASq10UNnA4vVGokkrN8MvD2HG17cKKJphE9dD7L+MFm09drbK7kMQfIMVZiJPeop
         X3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690527889; x=1691132689;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrwpb7rVTyYgrDu2LzfWhd5QBSrpJqCmxUGFCtGyRxE=;
        b=hIqLDRSORMM9I6ewzvnaDC4M+p0IF+VWeLNEPdKGYE/Z4SBGnUz9XhhkFAlJF3Hckg
         xpnbkPxdXa8GWYj7sVjArFTlr4C12zrOUYvZN7m4maJt9g6WEUvr09FYlylNJQUk+y9U
         kc0uaDos9LJkghrJDZg9sN6SWHvbWYI5XT/uPfNz5GLE8MPYk95en3XGrgB1FtNoffJR
         IMLKYr1efCv+pWBq4EjYuNpbBa5E8ckXiGd35IXeV4GTnKsTGfY/ST8SMq7tu8wPB9CO
         pab+hHu0eEDjQxEhjzj6TuaDMAy7FJeRihzhj3OL1pe74LRKHOqih8d5B6gPiY6XJOL4
         JjRw==
X-Gm-Message-State: ABy/qLZNItoD3rlz2xfEnSzOV71mv6HUGd5tXTkC11rJGEYJ0awjHvpX
        AkxAx0c00XKMz3QLzQizyNzaCA==
X-Google-Smtp-Source: APBJJlE+60gGNtiTwkvVvvyxDJd0BPxR2w6cPhZ0ordld8aOmQaaiK95ErAlh1vP12HcALZGJ8odjQ==
X-Received: by 2002:a05:6a20:968d:b0:12f:a373:ba95 with SMTP id hp13-20020a056a20968d00b0012fa373ba95mr611563pzc.19.1690527888967;
        Fri, 28 Jul 2023 00:04:48 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:dacb:3a1a:fcaf:c0fc])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b001bb750189desm2778063plg.255.2023.07.28.00.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:04:48 -0700 (PDT)
Date:   Fri, 28 Jul 2023 00:04:46 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Xi Ruoyao <xry111@linuxfromscratch.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <ZMNojqwLxcG8FcHN@x1>
References: <20230617161529.2092-1-jszhang@kernel.org>
 <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
 <20230725-unheard-dingy-42f0fafe7216@wendy>
 <ZL/jMYL3akl78ZZN@xhacker>
 <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
 <ZME1J4mpVf5yth32@xhacker>
 <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
 <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
 <ZMKXQpreSr47MFj6@xhacker>
 <290101d386866f639a7c482527d7a78c5108d49b.camel@linuxfromscratch.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <290101d386866f639a7c482527d7a78c5108d49b.camel@linuxfromscratch.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 12:29:44AM +0800, Xi Ruoyao wrote:
> On Fri, 2023-07-28 at 00:11 +0800, Jisheng Zhang wrote:
> > On Thu, Jul 27, 2023 at 08:54:59AM +0800, Xi Ruoyao wrote:
> > > On Thu, 2023-07-27 at 08:14 +0800, Xi Ruoyao wrote:
> > > > On Wed, 2023-07-26 at 23:00 +0800, Jisheng Zhang wrote:
> > > > > which dts r u using? see below.
> > > > > 
> > > > > > 
> > > > > > Or maybe my toolchain (GCC 13.1.0, Binutils-2.40, with no
> > > > > > patches) can
> > > > > > miscompile the kernel?
> > > > 
> > > > /* snip */
> > > > 
> > > > > > Boot HART ID              : 0
> > > > > > Boot HART Domain          : root
> > > > > > Boot HART Priv Version    : v1.11
> > > > > > Boot HART Base ISA        : rv64imafdcvx
> > > > > 
> > > > > what? I don't think the mainline dts provide v and x. 
> > > > 
> > > > I copied the compiled arch/riscv/boot/dts/thead/th1520-lichee-pi-
> > > > 4a.dtb
> > > > into /boot and loaded it with u-boot "load" command onto
> > > > 0x46000000, and
> > > > passed this address to the booti command.
> > > > 
> > > > But maybe I've copied the wrong file or made some other mistake...
> > > > I'll
> > > > recheck.
> > > 
> > > Hmm, and if I read OpenSBI code correctly, this line reflects the
> > > content of the misa CSR, not the DT riscv,isa value.
> > > 
> > 
> > Aha indeed the "vx" isa extensions are not from the DT riscv,isa
> > property. I will try your opensbi/linux/uboot combinations on my
> > lpi4a board tomorrow.
> 
> My kernel config attached.  Maybe you can find some stupid mistake in
> it, I'm not familiar with RISC-V, nor DT-based systems :(.

It seems like your kernel config is the problem. I used it and I saw
the same result of a panic in riscv_intc_irq:
https://gist.github.com/pdp7/1a26ebe20017a3b90c4e9c005f8178e1

This is the config I have been using successfully:
https://gist.github.com/pdp7/ecb34ba1e93fc6cfc4dce66d71e14f82

Could you try that config?

Linux 6.5-rc3 boots okay when built with it:
https://gist.github.com/pdp7/580b072f9a5bf9be87cf88b5f81e50e3

Thanks,
Drew
