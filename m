Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1E760B30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjGYHIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjGYHIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:08:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B83FBF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:08:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-316feb137a7so4703563f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690268893; x=1690873693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nemwt6odA/W6LAzXazKdN7X8FI/tGQtoSYxpSs1lg8c=;
        b=zWJ7gNOev2UK2JbtjZgRfPfqW0WArnCMDMvfXl8Yonl2R6MPL5/7DFkC3BGCcw82W2
         mGd/ShG6plEokjzXzt0/QOJoQIFzFH1z0dKLOgoWmY7IhSZTFc17xbJlvxGT0JbgFFTW
         r3wE232x+WJwcKlBZQ0GCrV1aj18OwIdCqeqOAnmEScGNlaU6viHri7P+FFW/cF0JE8Y
         l0N8flrR7Ko4pQzV1VwUlD4Ba2S5wBckSGhOTyrZ69xiBIUcMQPnBt3A2ATtNV+IMoa0
         SBveIjNOrybY5vtXxx9R3+VLB0d8GC4UdmjVuQfL0/4mO+KnApIPbMDDgBozjHcBX5uE
         wrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690268893; x=1690873693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nemwt6odA/W6LAzXazKdN7X8FI/tGQtoSYxpSs1lg8c=;
        b=jXb2wEXjfXeCipFULPkXjAeP1r0QSGMKwxb4x4bi0MmtEiu7wFEhiinNoYp1eCGE4g
         H5CkyX+S5p2zjbMid02HWJbTkFP6035SkLDrq4cotoRB/E6Bq+ft6yt8g2NVePvDlgwa
         Xo5xB98mBDc+Dz0WWXDhAYzKXOARxzYaFn9Ly50tB9Kv/9Mkh9PrCd5q40q/ot9LXpiw
         NUKRDIchUCajvX5/br9ijV8c5Y3HAo2AtBRvqOXTjNfBLqbuA4uwV+TzsmdDOM4AfNZz
         2OtppvT7DkAhQoSDu06jVKWbPGjsIB59131w2SYFESPw7J0h6ORDNxlK5VxvbLm/19ju
         5mbQ==
X-Gm-Message-State: ABy/qLYz0KFEWf1LGWT9BBn9g4rmX7EwwMx51D42ynkanD+xSnhrOTFp
        hanG4wFn+FEHmNSuBlU8iXTsrLqn3e5k+HDre6yW/w==
X-Google-Smtp-Source: APBJJlHOWVgAfvIWE3SwJNOHRN5kzve0ponjdSKN9AOGetzWhgHdBcNHiCtvHHaLdos5NlKV+C9CkHsTD+IMBIjKLQ8=
X-Received: by 2002:adf:ce8a:0:b0:317:5c18:f31d with SMTP id
 r10-20020adfce8a000000b003175c18f31dmr5125722wrn.35.1690268893182; Tue, 25
 Jul 2023 00:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230722123850.634544-1-alexghiti@rivosinc.com> <20230724-sanded-dental-c9125c76ad74@wendy>
In-Reply-To: <20230724-sanded-dental-c9125c76ad74@wendy>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 25 Jul 2023 09:08:01 +0200
Message-ID: <CAHVXubhiYT07L2ve2iEB5AZZdOgA0Sux8vDP4tMfdR6UTWuMgg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] riscv: Introduce KASLR
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 4:32=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> Hey Alex,
>
> On Sat, Jul 22, 2023 at 02:38:45PM +0200, Alexandre Ghiti wrote:
> > The following KASLR implementation allows to randomize the kernel mappi=
ng:
> >
> > - virtually: we expect the bootloader to provide a seed in the device-t=
ree
> > - physically: only implemented in the EFI stub, it relies on the firmwa=
re to
> >   provide a seed using EFI_RNG_PROTOCOL. arm64 has a similar implementa=
tion
> >   hence the patch 3 factorizes KASLR related functions for riscv to tak=
e
> >   advantage.
> >
> > The new virtual kernel location is limited by the early page table that=
 only
> > has one PUD and with the PMD alignment constraint, the kernel can only =
take
> > < 512 positions.
>
> I gave this all a go today, it seems to do what it it says on the tin,
> and crashing my kernel does dump out an offset etc.
>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>

Great, thanks for testing!

>
> I'll hopefully get some time later in the week to go through the code.

I will be on holiday in 3 weeks, you have some time, no worries :)

Thanks again,

Alex

>
> Cheers,
> Conor.
>
