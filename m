Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60378924D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjHYXXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjHYXXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:23:23 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DEF2109
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:23:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5008d16cc36so2161815e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693005799; x=1693610599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y/MCOutpdQ9jrdBYlOHctxvB4AexelxGOeGhkirgy8=;
        b=U8NKwCCNSifsc2lSTaq4WiTeE1T6YuPABAyz74CRhWhIPiyirbpLKqOOyHPBIdfVD0
         Itd8MKaLEcUQ+vuDtqtCUcpbE2MedhssvMzV160oBFM/wKbNn9o4q7ThtKK6zbFpzaiE
         BMDad/zHG8StzWD3C1o3qgOLzhAp0vVKoTLs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693005799; x=1693610599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4y/MCOutpdQ9jrdBYlOHctxvB4AexelxGOeGhkirgy8=;
        b=X78YSbPqAhAn7BUBqEnd97oqdD0UnxMQhqF8px6v+Vesp5O63b7UD2w5R3BYENXSeg
         2fpRwvgZmElDG/rfKBjdC7gJvFIqa42FmopK8JxJSTN5QLFpCRFtJOnUj/ti1EwKy4jx
         IZ5JFrOBoJLfd4ix6c8CC2ZOwXOZVRzkPeLrKxvlHG9AduzAATH5dP/FsowHPxgzi4AK
         McyvqxGro8HsDLqcAdscfvtaFm4onTVFb8yKZ5o2hg0xrt8TGmcFCce5Ziz4nnHsYUJ+
         ekygdGeOkw1L2yIfbdq0pTIv8xgIKqrKUhsnriYowduoQzX5IxNZxCWTOV9PLlWmlb66
         h/Kw==
X-Gm-Message-State: AOJu0Yw7lN+boFBU5nXZioYvUdHorYwUoZ6Kv3XXhbkriHTtWnqz/+H8
        PpvpjTTrRl79/kdXTSO1I9Nb0tFQ75Vuf6V4UqrYvg==
X-Google-Smtp-Source: AGHT+IEHxDRNRzDhD7J/HEqvUIEgnQd72FT7NvreGyXrsE98RFOiKe9Js51h5J1CykBkagVO4tydb+PQ0x7QUhyImSE=
X-Received: by 2002:ac2:5f4b:0:b0:500:9ee2:15f with SMTP id
 11-20020ac25f4b000000b005009ee2015fmr3398223lfz.46.1693005799136; Fri, 25 Aug
 2023 16:23:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Aug 2023 18:23:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAD=FV=U24kF7WbZPKMbk=kJMU14+yFJXpGWWfj0fPbA9J6h0Eg@mail.gmail.com>
References: <20230824153233.1006420-1-dianders@chromium.org>
 <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
 <CAE-0n52iVDgZa8XT8KTMj12c_ESSJt7f7A0fuZ_oAMMqpGcSzA@mail.gmail.com> <CAD=FV=U24kF7WbZPKMbk=kJMU14+yFJXpGWWfj0fPbA9J6h0Eg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Aug 2023 18:23:18 -0500
Message-ID: <CAE-0n514xGWz1yaF84zL=QBCQcMwct+pu8nLBgRHPq6+DE3g5g@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using pseudo-NMI
To:     Doug Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2023-08-25 16:02:46)
> On Fri, Aug 25, 2023 at 3:27=E2=80=AFPM Stephen Boyd <swboyd@chromium.org=
> wrote:
> >
> > Quoting Douglas Anderson (2023-08-24 08:30:30)
> > > diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/ir=
q.h
> > >
> > >  static int ipi_irq_base __read_mostly;
> > >  static int nr_ipi __read_mostly =3D NR_IPI;
> > > -static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
> > > +static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
> >
> > Side note: it would be nice to mark ipi_desc as __ro_after_init. Same
> > for nr_ipi and ipi_irq_base.
>
> I'd rather not change it in this patch since it's a pre-existing and
> separate issue, but I can add a patch to the end of the series for
> that if I end up spinning it. Otherwise I can send a follow-up patch
> for it.

Of course. Don't change it in this patch.

>
>
> > >  static void ipi_setup(int cpu);
> > >
> > > @@ -845,6 +852,22 @@ static void __noreturn ipi_cpu_crash_stop(unsign=
ed int cpu, struct pt_regs *regs
> > >  #endif
> > >  }
> > >
> > > +static void arm64_backtrace_ipi(cpumask_t *mask)
> > > +{
> > > +       __ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
> > > +}
> > > +
> > > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclu=
de_cpu)
> >
> > Can this be 'bool exclude_self' instead of int? That matches all other
> > implementations from what I can tell.
>
> Nope. See the part of the commit message that says:
>
> This patch depends on commit 36759e343ff9 ("nmi_backtrace: allow
> excluding an arbitrary CPU") since that commit changed the prototype
> of arch_trigger_cpumask_backtrace(), which this patch implements.

Ah, ok. Sounds fine then.
