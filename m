Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCF813024
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573019AbjLNMaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573052AbjLNMaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:30:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2ADD5B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:30:17 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5cd51c0e8ebso111573a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702557016; x=1703161816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTYg98AeDb9Vd3saTDUzETIyYCa5DfFItfsf1F8SOZA=;
        b=DPoqSIOC//NfYPnbZPUT4SaBSv0O4yGqD0Qnh/3ctAf49bGjIX+7UcoCdHENl3Kcc3
         N9KiAv0xPkFuXwPJA/HI12LdlpT/3lHT4gyQHbGrfO9ZObyQmpbRpb6+0fPfxvszGHBc
         28kgwT7BAObTkNEX2/rETSSsZ/+9rGWBGsOiBdfkYxQrny/6cREaW6kHCrD+awSUe1Hz
         u2nlRPU0jp/XAAC2oH0Tw97ughA2rvU0FZiFLjjoM2yAxdvpcVc59Mz/xDr69JMhaKjR
         obgBpglK7VYoddL3c5AAWAKPvmw3OAif9PsNrMsRrDud3Iv0U4otVnLeCD1RRwDyyn+1
         XzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557016; x=1703161816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTYg98AeDb9Vd3saTDUzETIyYCa5DfFItfsf1F8SOZA=;
        b=fW3ziGa7T8PZ9g4gMhCVf4kkSnvDNbistJ9PkqtgM2c1D2KZX5AL9ITt7qOozo+Hbj
         WysSHghPJMzVaWx44Ksul0o1+wnGIbh6KBwG7gjhz4Q1yEqsBE7A7gqEr1DWNHWBqDyZ
         mWdARkx77uGL96oAVfs0oR/SyP1TfRJED3A+jMlE+K1SePFJH06S6wMCwk2ej3uYz1f3
         bVxwMZLUQuhBf5zhJRlcU9BMfCIjzlhrdbxG8QcOmTHNGtit0oyxYTyEWSscNOyfHu6w
         riMCZF3rk5CV9ZicQ6qptwS6FBgODVOe5GUy4qOzEclmgsNCzq90pCzScKemY9r7MIgk
         7t3w==
X-Gm-Message-State: AOJu0YxLzHGr8y2yfjv+TK9oNgmA8RyIfa53abqYYBpiI6WcPXMNzOHb
        cqu3abjxbLqIom3YfB1x6SJouupEYMlXIjKB/HGIPA==
X-Google-Smtp-Source: AGHT+IFh3PynjsOpH0Bb8g1t7TJwzACkLLtlQcWLE6SdhoVWBWTJX6SSIb1nQpDSBgiJeLn6u3PRCAqA+k4jZ3r/imQ=
X-Received: by 2002:a05:6a20:560c:b0:18f:97c:9278 with SMTP id
 ir12-20020a056a20560c00b0018f097c9278mr4531886pzc.93.1702557016440; Thu, 14
 Dec 2023 04:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20231205024310.1593100-1-atishp@rivosinc.com> <20231205024310.1593100-5-atishp@rivosinc.com>
 <20231207-fidgeting-plywood-8347d9d346be@wendy>
In-Reply-To: <20231207-fidgeting-plywood-8347d9d346be@wendy>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Dec 2023 18:00:04 +0530
Message-ID: <CAAhSdy3yK8CoQGZYT6j_xiKozt8viVXHogqVzUS7TxHs2Q_0Tw@mail.gmail.com>
Subject: Re: [RFC 4/9] drivers/perf: riscv: Read upper bits of a firmware counter
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 6:03=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> On Mon, Dec 04, 2023 at 06:43:05PM -0800, Atish Patra wrote:
> > SBI v2.0 introduced a explicit function to read the upper bits
> > for any firmwar counter width that is longer than XLEN. Currently,
> > this is only applicable for RV32 where firmware counter can be
> > 64 bit.
>
> The v2.0 spec explicitly says that this function returns the upper
> 32 bits of the counter for rv32 and will always return 0 for rv64
> or higher. The commit message here seems overly generic compared to
> the actual definition in the spec, and makes it seem like it could
> be used with a 128 bit counter on rv64 to get the upper 64 bits.
>
> I tried to think about what "generic" situation the commit message
> had been written for, but the things I came up with would all require
> changes to the spec to define behaviour for FID #5 and/or FID #1, so
> in the end I couldn't figure out the rationale behind the non-committal
> wording used here.
>
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 40a335350d08..1c9049e6b574 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -490,16 +490,23 @@ static u64 pmu_sbi_ctr_read(struct perf_event *ev=
ent)
> >       struct hw_perf_event *hwc =3D &event->hw;
> >       int idx =3D hwc->idx;
> >       struct sbiret ret;
> > -     union sbi_pmu_ctr_info info;
> >       u64 val =3D 0;
> > +     union sbi_pmu_ctr_info info =3D pmu_ctr_list[idx];
> >
> >       if (pmu_sbi_is_fw_event(event)) {
> >               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_FW_REA=
D,
> >                               hwc->idx, 0, 0, 0, 0, 0);
> >               if (!ret.error)
> >                       val =3D ret.value;
> > +#if defined(CONFIG_32BIT)
>
> Why is this not IS_ENABLED()? The code below uses one. You could then
> fold it into the if statement below.
>
> > +             if (sbi_v2_available && info.width >=3D 32) {
>
>  >=3D 32? I know it is from the spec, but why does the spec define it as
>  "One less than number of bits in CSR"? Saving bits in the structure I
>  guess?

Yes, it is for using fewer bits in counter_info.

The maximum width of a HW counter is 64 bits. The absolute value 64
requires 7 bits in counter_info whereas absolute value 63 requires 6 bits
in counter_info. Also, a HW counter if it exists will have at least 1 bit
implemented otherwise the HW counter does not exist.

Regards,
Anup

>
> > +                     ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTE=
R_FW_READ_HI,
> > +                                     hwc->idx, 0, 0, 0, 0, 0);
>
> > +                     if (!ret.error)
> > +                             val =3D val | ((u64)ret.value << 32);
>
> If the first ecall fails but the second one doesn't won't we corrupt
> val by only setting the upper bits? If returning val =3D=3D 0 is the thin=
g
> to do in the error case (which it is in the existing code) should the
> first `if (!ret.error)` become `if (ret.error)` -> `return 0`?
>
>
> > +                             val =3D val | ((u64)ret.value << 32);
>
> Also, |=3D ?
>
> Cheers,
> Conor.
>
> > +             }
> > +#endif
> >       } else {
> > -             info =3D pmu_ctr_list[idx];
> >               val =3D riscv_pmu_ctr_read_csr(info.csr);
> >               if (IS_ENABLED(CONFIG_32BIT))
> >                       val =3D ((u64)riscv_pmu_ctr_read_csr(info.csr + 0=
x80)) << 31 | val;
> > --
> > 2.34.1
> >
