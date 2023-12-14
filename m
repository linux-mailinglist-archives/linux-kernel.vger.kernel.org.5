Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359A8812FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572959AbjLNMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572923AbjLNMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:15:54 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7177BD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:16:00 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-59082c4aadaso4334234eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1702556160; x=1703160960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBseVdrDFlP3wbP7vJYL9hvjzRVN+OTQXpZ+CsBu3pI=;
        b=bvWcy6PMY8YZaM7uhVJFLoE+xWHyZuH6BMb8w0KH2KFANUclkQc9Jfb/OqyfUMYO8T
         +134XcxFO4Z21nthq+eBU9Tx68rsCP+HmTSUj07Lbo3dHIWsDKCU0lZYDETFhuucqjMc
         dfzMob+PUTiLXZZVBKiNqDkOS6ai7FPfBKk9vCYw06xx1tTt32UtI0XvwdRy5CYTSI/W
         oTGNHcdMaBXCQb5onvv++5xkdyE2jQWMVSJFTgLp/nBHtRuR8G5OvUNd7sHFzXDngWwn
         4dT4sFpuo9kIz0TGa3Agauthu1uXA5XEwGktd1Kbgo7n1cfNyhwcy3r1zjPog/5Emwzq
         kDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702556160; x=1703160960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBseVdrDFlP3wbP7vJYL9hvjzRVN+OTQXpZ+CsBu3pI=;
        b=pmKMpnuQ/KYJuWEV7ZJ75zzqv1O3C/Ufb8oBfNC5kRvEFpxrPBKOgzFs775szY4hz6
         Y9ZjtTd5yy1oaWTkZnbiLVuna/oGoxmp2LGuJXMKuJncJPlKNZkqZc6r0YtdRD3jpCS3
         S4geJyEMyWJq5BIdsaUnFUeeU8u72tZ0orzB6ULefJ57HKbmbuHDX/z+NNSm0kQ7iMcV
         YhypJIx7OaC33bGABUfIxeZ25OkkfkaSZDli3LuuAxxMVkBprhTwm3Mtlv6tD2nzgqmv
         p7Ezqx2kxqIIfDKu8ZqMnUGWmVGfS98jfr4wR1HquzkgkbQwsAd5o6RlDNa4/TrgC+Sv
         Z8ew==
X-Gm-Message-State: AOJu0YyNAs+7KjK72g4d5eEyNGEbjnCjfRsUqsStOWZOpVRJMPICI/NQ
        wNGUywgjD4wbngz2iGEzKTbn9/AuCE8qR1gXq2sq4A==
X-Google-Smtp-Source: AGHT+IEj9LpcHY6hPKfn4REgUhGo85Mz6E/WR3+z/9PsY0zYZ3nuIGu4wDt6mM+Ma9Kl8FbXjzNz7S4MPf/SQnJvxkk=
X-Received: by 2002:a05:6358:6f07:b0:170:17eb:14b6 with SMTP id
 r7-20020a0563586f0700b0017017eb14b6mr8323474rwn.38.1702556159958; Thu, 14 Dec
 2023 04:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20231205024310.1593100-1-atishp@rivosinc.com> <20231205024310.1593100-3-atishp@rivosinc.com>
 <20231207-professed-component-84128c06befa@wendy>
In-Reply-To: <20231207-professed-component-84128c06befa@wendy>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Dec 2023 17:45:48 +0530
Message-ID: <CAAhSdy1vqGHeEMStu8Ft2Cz-_c=9e8ciwo9nBh=CDnEejEvp9w@mail.gmail.com>
Subject: Re: [RFC 2/9] drivers/perf: riscv: Add a flag to indicate SBI v2.0 support
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

On Thu, Dec 7, 2023 at 5:39=E2=80=AFPM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> On Mon, Dec 04, 2023 at 06:43:03PM -0800, Atish Patra wrote:
> > SBI v2.0 added few functions to improve SBI PMU extension. In order
> > to be backward compatible, the driver must use these functions only
> > if SBI v2.0 is available.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
>
> IMO this does not make sense in a patch of its own and should probably
> be squashed with the first user for it.

I agree. This patch should be squashed into patch4 where the
flag is first used.

Regards,
Anup

>
> > ---
> >  drivers/perf/riscv_pmu_sbi.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.=
c
> > index 16acd4dcdb96..40a335350d08 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -35,6 +35,8 @@
> >  PMU_FORMAT_ATTR(event, "config:0-47");
> >  PMU_FORMAT_ATTR(firmware, "config:63");
> >
> > +static bool sbi_v2_available;
> > +
> >  static struct attribute *riscv_arch_formats_attr[] =3D {
> >       &format_attr_event.attr,
> >       &format_attr_firmware.attr,
> > @@ -1108,6 +1110,9 @@ static int __init pmu_sbi_devinit(void)
> >               return 0;
> >       }
> >
> > +     if (sbi_spec_version >=3D sbi_mk_version(2, 0))
> > +             sbi_v2_available =3D true;
> > +
> >       ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
> >                                     "perf/riscv/pmu:starting",
> >                                     pmu_sbi_starting_cpu, pmu_sbi_dying=
_cpu);
> > --
> > 2.34.1
> >
