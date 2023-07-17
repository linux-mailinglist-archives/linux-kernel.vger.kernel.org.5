Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803E4755AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGQFE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQFEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:04:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7750E52
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:04:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-262e3c597b9so2890629a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689570292; x=1692162292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNYeV3LGJNDSjU9rdyxRY+kYnsL8oTpzciBaAdsXjdw=;
        b=pFVcZKLHHSwYguk1P8Z8buW6liFYqiBFAfnxThWwQEwsHbaT8LgTuKCtNtZZahMwtZ
         v2pGwXXr279uep/RwINe1yy0PZs6T802JwxpDAxffwb8lTJo1yMKrL9PBZ5J03FY95CR
         EO15JvfPlnoz0pmtYRqvGvdMi7j/9ZOPof8ew+B6b7KOAkTPvMR0IkzZV4jLfEVgiRXy
         EUvGml3Nsscs8Nk+cb7/G7BijJuMi+JW9Pny8vPSnFwqPta6oyyFpHCbYNZxr0P90IgD
         AnRorZ0BFonzaR9x867Ych8Hw8OHCRxCoVTVd4rVQIMA/Ks6SlJkcG0Gtr+0p7aFyk6Y
         9/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689570292; x=1692162292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNYeV3LGJNDSjU9rdyxRY+kYnsL8oTpzciBaAdsXjdw=;
        b=DmoWXTVweW29p09WbIBlLqQzw5J/UJlrSk8he0aURwyRpAsofCqAhYyNgyTMUxMDud
         frWrb8a1q9t/UmiMwdwT1sh1/bXrYE9NE5ERIQ0RylOfygFHfJroZ/TqWnflkmypi1B+
         fyvqb9Zc/fJndL3EOKbDtodmIQ/sl3te8ZW0tWxeoBEhViWc2YYmRy71JDQTQJIq9wmp
         wl09qotqmItBOj6RCLyK44CQGPGn3+BcVJtflXVTHhqSTo7RndwIi9BTO3WYE8dZPPQQ
         SEaNFZsjbudFdFWiaohCQ4WStasxOVH3FOE7n6CiiVDP2h1uxMe51deuDV2f2Yeak9s0
         5/xg==
X-Gm-Message-State: ABy/qLZ+oPryZ4kkvQGruHKz5wxJhzgDwLOayyvp/CPnedM5pB+ZcLWg
        d1EhXzEkj0k02a3XoG+mnGlpq8bpVm7DQ1eweesYwA==
X-Google-Smtp-Source: APBJJlHblKksdgvAv0N83Z/xC4BvMT4Q7gyebPtrATeDzpArpZorrhwxdo3OYkO5C+L0q4QbzcrVAwRIUVdEpj7E+Vk=
X-Received: by 2002:a17:90a:4f81:b0:262:ece1:5fd9 with SMTP id
 q1-20020a17090a4f8100b00262ece15fd9mr10283082pjh.10.1689570291971; Sun, 16
 Jul 2023 22:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230710094321.1378351-1-apatel@ventanamicro.com>
 <20230710094321.1378351-2-apatel@ventanamicro.com> <20230711-3151a76400deb88b218e9f9b@orel>
In-Reply-To: <20230711-3151a76400deb88b218e9f9b@orel>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 17 Jul 2023 10:34:40 +0530
Message-ID: <CAK9=C2XABXWauDNJwK21eJQsknbb2CNUHkuTsgVmgSVgChnVTg@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] RISC-V: Add riscv_fw_parent_hartid() function
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 6:56=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Mon, Jul 10, 2023 at 03:13:13PM +0530, Anup Patel wrote:
> > We add common riscv_fw_parent_hartid() which help device drivers
> > to get parent hartid of the INTC (i.e. local interrupt controller)
> > fwnode. This should work for both DT and ACPI.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/processor.h |  3 +++
> >  arch/riscv/kernel/cpu.c            | 16 ++++++++++++++++
> >  2 files changed, 19 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/as=
m/processor.h
> > index c950a8d9edef..39dc23a18f88 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -81,6 +81,9 @@ int riscv_of_processor_hartid(struct device_node *nod=
e, unsigned long *hartid);
> >  int riscv_early_of_processor_hartid(struct device_node *node, unsigned=
 long *hartid);
> >  int riscv_of_parent_hartid(struct device_node *node, unsigned long *ha=
rtid);
> >
> > +struct fwnode_handle;
> > +int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *=
hartid);
> > +
> >  extern void riscv_fill_hwcap(void);
> >  extern int arch_dup_task_struct(struct task_struct *dst, struct task_s=
truct *src);
> >
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index a2fc952318e9..9be9b3b1f333 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -96,6 +96,22 @@ int riscv_of_parent_hartid(struct device_node *node,=
 unsigned long *hartid)
> >       return -1;
> >  }
> >
> > +/* Find hart ID of the CPU fwnode under which given fwnode falls. */
>
> This comment matches the comment for riscv_of_parent_hartid(), but I don'=
t
> think it will be correct for the !is_of_node(node) case since
> fwnode_property_read_u64_array() isn't obliged to walk up its tree.
> Looking ahead it appears riscv_fw_parent_hartid() is only called with the
> parent node, so we could just drop this function and use
> fwnode_property_read_u64_array() directly at the two call sites.

I think the function name riscv_fw_parent_hartid() is misleading. It should
be riscv_get_intc_hartid() because it is retrieving hartid based on INTC
fwnode.

Currently, this function is used in APLIC and IMSIC drivers but soon it
will be also used in PLIC driver with the upcoming PLIC ACPI support.

In fact, this patch should also replace riscv_of_parent_hartid() with
riscv_get_intc_hartid() in INTC and PLIC.

Regards,
Anup

>
> Thanks,
> drew
>
> > +int riscv_fw_parent_hartid(struct fwnode_handle *node, unsigned long *=
hartid)
> > +{
> > +     int rc;
> > +     u64 temp;
> > +
> > +     if (!is_of_node(node)) {
> > +             rc =3D fwnode_property_read_u64_array(node, "hartid", &te=
mp, 1);
> > +             if (!rc)
> > +                     *hartid =3D temp;
> > +     } else
> > +             rc =3D riscv_of_parent_hartid(to_of_node(node), hartid);
> > +
> > +     return rc;
> > +}
> > +
> >  DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> >
> >  unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
> > --
> > 2.34.1
> >
