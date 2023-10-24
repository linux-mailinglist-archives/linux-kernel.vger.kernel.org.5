Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C277D4F77
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjJXMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjJXMIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:08:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783E120
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:08:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso3610530b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698149320; x=1698754120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMK1b0C/L5gsGLFeXRamJpztKKQzm+CIlOPG1sOdW0o=;
        b=gaZ0qE5eA/5N9XyHas6AG+0zpwNE94cgLrm79DCrEQD9YyMLHBuhqpT64VMXQbg3ad
         Cc8eiD+ABe2qworMHpL7pAVsjPXR5dfXuK9m5y7z9vZCDjqiXIbdq/fM2w9d0SmIhIKh
         znv2Y5DxEFnXemz/uQq9oTCx9puATNc5RmgtOo+p2dj+lEt9JxsOrXrhc8CcxNZf0qpB
         faHa6NZ+NrxcvlS/FtVvxJ1qzUiB9Lz2Pimpgy0MSsQeENPw1/uisiKMcW2L7IfAeL+Q
         oCInm5k+YJkXhbTtKWpamnis0Vg7WgWCYQV/RXXYWF4nxgofn/NBensjzSBlvv3SF41c
         Wwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149320; x=1698754120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMK1b0C/L5gsGLFeXRamJpztKKQzm+CIlOPG1sOdW0o=;
        b=l5oW3lMhKY13jyKg2cjCmppLioK+XJX63eS7EJXuovJFV30L7feiS92EcHInQNijFs
         yUIGv7CFhhLSBeQNwxncpjMISoGNpsFidvQc/NQTM9aUVcwPCfOw/b4G1ve7yJbpkx06
         K2hwlCPcMzRDYSAl0BsYOMIFUnNmkx3nbzVemnM9h7xOta5uRihkn6iU0BLG385BCwMI
         L8oVvM7vKAu1yEiymkgWxp0cTNDUsLZV+lCsdH2WZVS8BJHMJdugQ6cdgeq+VEQpMB7t
         FPE1tj1PPLAuWJufay0ZfECWA4f+U9kiD0eH+EZlmAXldyRZ1UAPoHqunbwVgyJhapAd
         TRHw==
X-Gm-Message-State: AOJu0YwkOn4yE+WpPYm4+BR8PmH7UwJ0m5KioOLpJWY8eVDY4u4Z73cw
        g4F79z/1Wx5aQuIwQexcZ6ZpBSS5g+OVWLwE8+N/ng==
X-Google-Smtp-Source: AGHT+IFf5XQ1QrXyWpn6fYdMoI3iDWgIsJGguKE6SezMge8SlFoUeS1mh1uQTHY/nYilct4uGjuRE5tSWIeQFzBQE0E=
X-Received: by 2002:a05:6a00:194a:b0:690:bdda:7c35 with SMTP id
 s10-20020a056a00194a00b00690bdda7c35mr10133732pfk.1.1698149319657; Tue, 24
 Oct 2023 05:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231023172800.315343-1-apatel@ventanamicro.com>
 <20231023172800.315343-8-apatel@ventanamicro.com> <20231024-arbitrate-glitter-2053d17d7260@spud>
In-Reply-To: <20231024-arbitrate-glitter-2053d17d7260@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 24 Oct 2023 17:38:28 +0530
Message-ID: <CAK9=C2UxD1uKCvg26xzevtm4MAeGix-qS9PM296uCg3NqSyTaA@mail.gmail.com>
Subject: Re: [PATCH v11 07/14] irqchip: Add RISC-V incoming MSI controller
 early driver
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 2:55=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Oct 23, 2023 at 10:57:53PM +0530, Anup Patel wrote:
>
> > +#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
> > +void imsic_vector_debug_show(struct seq_file *m,
> > +                          struct imsic_vector *vec, int ind)
> > +{
> > +     unsigned int mcpu =3D 0, mlocal_id =3D 0;
> > +     struct imsic_local_priv *lpriv;
> > +     bool move_in_progress =3D false;
> > +     struct imsic_vector *mvec;
> > +     bool is_enabled =3D false;
> > +     unsigned long flags;
> > +
> > +     lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
> > +     if (WARN_ON(&lpriv->vectors[vec->local_id] !=3D vec))
> > +             return;
> > +
> > +     raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
> > +     if (test_bit(vec->local_id, lpriv->ids_enabled_bitmap))
> > +             is_enabled =3D true;
> > +     mvec =3D lpriv->ids_move[vec->local_id];
> > +     if (mvec) {
> > +             move_in_progress =3D true;
> > +             mcpu =3D mvec->cpu;
> > +             mlocal_id =3D mvec->local_id;
> > +     }
> > +     raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
> > +
> > +     seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
> > +     seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_i=
d);
> > +     seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
> > +                (vec->local_id <=3D IMSIC_IPI_ID) ? 1 : 0);
>
> > +     seq_printf(m, "%*sis_enabled      : %5u\n", ind, "",
> > +                (move_in_progress) ? 1 : 0);
>
> gcc & clang report:
> drivers/irqchip/irq-riscv-imsic-state.c:288:14: warning: variable 'is_ena=
bled' set but not used [-Wunused-but-set-variable]
>
> This looks to be a copy-pasta issue, and the move_in_progress here
> should be is_enabled?

Thanks for catching. Strangely,  I did not see this warning with
the toolchain which I use.

I will fix it in the next patch revision.

Regards,
Anup

>
> > +     seq_printf(m, "%*sis_move_pending : %5u\n", ind, "",
> > +                (move_in_progress) ? 1 : 0);
> > +     if (move_in_progress) {
> > +             seq_printf(m, "%*smove_cpu        : %5u\n", ind, "", mcpu=
);
> > +             seq_printf(m, "%*smove_local_id   : %5u\n", ind, "", mloc=
al_id);
> > +     }
> > +}
