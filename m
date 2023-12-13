Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D509811952
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjLMQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLMQ1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:27:53 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD93DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:27:59 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-db538b07865so7368655276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702484878; x=1703089678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwN+wNPTyEXCpp42soj4i392Xk+t7dyiyZpAtyDWMEo=;
        b=nenhJP5dVQrEO2jkA5KSwztV01ushi3T66KvzjZen/j2fpGRCcUIktCEnUG6zzEUp6
         ED6ybavjofqLt99cJXCw8tNCzbORqPV+EDhPi71OZyYp+ZVU7v+L00ZJcLmSHoaAmD0U
         GmdZEySL10eo2FirliaBSRyEj3deEA6Nr56Tt1lq+0Tx3i+IxOn2JD2CaCat+yUHxh3h
         t/t7gHppma6yQtrPyVNt0jqq6AoKduw5ZHgviSynLEuSbpUFZsyhqmfJwnRZHCYUsYWO
         rp2uEqo/+EwoKwdZLfOpjMr/DEMtV0GFuvVybrvsICDHAu4I5IQ7YHUp/FF96Dx7LTc7
         CR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484878; x=1703089678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwN+wNPTyEXCpp42soj4i392Xk+t7dyiyZpAtyDWMEo=;
        b=i2m1wdQXUxLdFT9j8YTr/9OBCGxB3v/0WtLzxvzeR1XlWWSBF5BObrpHIw6feCHatw
         YdT7PS1oWNirtCD+RWHRjkxZoEtOVGgJIwWe36JsmJnlKiqs89qGh4nlrfR5zei8esyM
         bXqeEkZnL6GofnHfMVyxV5X60oP7HkGST8tXdh7tSLMMW5NNJiWdbkkpI6oSxpOUiZsu
         UmOC3gaBHi0ZecBBTsJjUr/mnYvPeiHnT1OCTmx1wEB0BUtci0FDXA37nmcasDBq0VK9
         yWLcLix1FjneGNfUE/j8pYO11fBnuMqCdjCT2o7TuNuK5ugnB9bZaQnhNBNSYVQT3IGC
         5hdQ==
X-Gm-Message-State: AOJu0YxaCY78Vzudg81Cye5zt3bPtWAYvN36E+u/okKVjrCcyKxtYSwd
        dVmxODF3t5zbdx5K/Zxb+2HSy3t5zZapyqsvR6dKhg==
X-Google-Smtp-Source: AGHT+IGIMAXe9iUoZENamxfBq2v5A/ljH9uhwB9zsViZ6KKm+zFKaXMYXuDHPuUeofItu8Wh+2WIN54ripiKFmO34BU=
X-Received: by 2002:a25:8051:0:b0:db5:4731:eeb8 with SMTP id
 a17-20020a258051000000b00db54731eeb8mr5500365ybn.18.1702484878223; Wed, 13
 Dec 2023 08:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20231212235003.2036221-1-debug@rivosinc.com> <mhng-ae72b5fd-358d-48e2-87cf-f571b67afe9e@palmer-ri-x1c9a>
 <ZXkCs9ypok5X/Wx2@debug.ba.rivosinc.com> <20231213-707b4e8b5a91ceedd557eb12@orel>
In-Reply-To: <20231213-707b4e8b5a91ceedd557eb12@orel>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Wed, 13 Dec 2023 08:27:46 -0800
Message-ID: <CAKC1njQ16drCZzWCS8PuX1U7x1UfC3bwpEmeizs1L5z4KHFaPw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] riscv: envcfg save and restore on trap entry/exit
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com, guoren@kernel.org,
        mchitale@ventanamicro.com, waylingii@gmail.com,
        greentime.hu@sifive.com, samitolvanen@google.com,
        Bjorn Topel <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        jeeheng.sia@starfivetech.com, Heiko Stuebner <heiko@sntech.de>,
        Evan Green <evan@rivosinc.com>, jszhang@kernel.org,
        cleger@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 4:24=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Tue, Dec 12, 2023 at 05:02:43PM -0800, Deepak Gupta wrote:
> > On Tue, Dec 12, 2023 at 04:53:48PM -0800, Palmer Dabbelt wrote:
> > > On Tue, 12 Dec 2023 15:49:25 PST (-0800), debug@rivosinc.com wrote:
> > > > envcfg CSR defines enabling bits for cache management instructions =
and soon
> > > > will control enabling for control flow integrity and pointer maskin=
g features.
> > > >
> > > > Control flow integrity and pointer masking features need to be enab=
led on per
> > > > thread basis. Additionally, I believe cache management instructions=
 need to be
> > > > enabled on per thread basis. As an example a seccomped task on risc=
v may be
> > > > restricted to not use cache management instructions
> > >
> > > Do we have anything in the kernel that actually does that?  Generally=
 we
> > > need some use, I couldn't find any user-mode writable envcfg bits in =
any
> > > extesions I looked at (admittidly just CFI and pointer masking), and
> > > unless I'm missing something there's no per-thread state in the kerne=
l.
> > >
> >
> > Cache management operations?
> > As of now kernel blindly enables that for all the user mode. It will be=
 good if
> > that is enabled on per-thread basis. Sure, all threads can have it enab=
led by
> > default. But if strict seccomp is enabled, I would argue that cache man=
agement
> > operations for that thread to be disabled as is done on other arches. A=
s an
> > example x86 disable rdtsc on strict seccomp. RISCV allows this CMO exte=
nsion
> > and I expect CMO to leverage this (currently it
> > doesn't).
> >
> > I was being opportunistic here so that I can reduce number of patches o=
n CFI
> > enabling patchset.
> >
> > Will it be okay if I revise this patch to include with a usecase to res=
trict CMO
> > (say for case of strict seccomp on risc-v)?
>
> I opted to only expose cache block zero since giving userspace the
> ability to invalidate cache blocks seems risky from a side-channel attack
> perspective.

I didn't pay attention. You're right, it's only cbo.zero that's exposed.
I will roll up my patch with cfi set then.

>
> I'm no security expert, so feedback welcome, but I don't see a risk with
> userspace being granted cbo.zero, even for strict seccomp processes.

Yeah I don't see a risk with cbo.zero to strict seccomp thread either.

>
> Thanks,
> drew
