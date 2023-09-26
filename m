Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172537AEA81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjIZKg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIZKgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:36:54 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98543E5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:36:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690bfd4f3ebso6346187b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 03:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695724604; x=1696329404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rx4sePY/rSBccbkTwzXRYI99umtH2PVsvZS0TGK67Q=;
        b=Lk9+uCBA/hkurNJdqm3YWh4t9+7VSFyP1Hhp5gT2qDcPROAUkecHwXTQ5qCDGvOL5w
         I3uAeQPyCZKnVkkm0nKMgu0qSCXDimI77V4kGrXF8KS6e8lFdhy61aq6F+GWxWwTcjyw
         6KFLIPz49hm+TwnS68zNJfJJX8UZKrZ3haxJ3x+CQS7RPb1jRSxEra6AaF/QA9ZP+YsO
         KUeQBhoHWfRgfOOibrYDKb7zb/uchjIf6JQYkeIfpsYfRVezoDIrlwx2VrjZjmvs7Dqn
         NmqaLZwNDAuU3YzT6oExXaobze70Io9i84ZSdH7B3EoQ7feoEFsJlymNQEtebetcGPFo
         18+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724604; x=1696329404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rx4sePY/rSBccbkTwzXRYI99umtH2PVsvZS0TGK67Q=;
        b=sy+JINr6D/sFjO1Cuy043tkowsPq1XtAze3RyQQ5E4x69hxgjN7IjCXrlpzb/WIsOa
         qthljrsiWMRgTqq2VeKDuoqyroD4JooaWcgk7BQamqDSo/H8l8nnX7HHzpeRghr3npVH
         NsFZBhDkkqsq7STHEXPHVjzZZsstFf6XN/x4QQE1oH4pKF+f7UAzL0upy6MYhx2GS/L2
         D6MnHn6vOalcMykE+2arYMX1Np1CDDX+v8nc2MNX38j0MkXBlsYMqQRo3IW0DPVu3RXi
         fgMU90tSfeztLHj4e6uCVZeZEMq1ZdPv2v0m1HVtcFvQSXlb4Z6pLmX0/vQddylWMx1p
         RX4A==
X-Gm-Message-State: AOJu0YzRuR7yMLdDeyVkveIYiCv7haM1bvwOS1+T5HPLCqva9drJ9jyM
        fpyqtoUA5U1690ZudqewyCS0gZMo90Q4isgnYowfHQ==
X-Google-Smtp-Source: AGHT+IHIRi9ZVDlNT1ohN+8nCSAnjQwp3jtFP6KIrnSHcB3eCSMzD8i9SanrNqP/YOG1gVgtwBdM2u2LAbTydBhfjQk=
X-Received: by 2002:a05:6a20:12cd:b0:137:2f8c:fab0 with SMTP id
 v13-20020a056a2012cd00b001372f8cfab0mr8383450pzg.49.1695724603930; Tue, 26
 Sep 2023 03:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230926102801.1591126-1-dunaev@tecon.ru>
In-Reply-To: <20230926102801.1591126-1-dunaev@tecon.ru>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 26 Sep 2023 16:06:31 +0530
Message-ID: <CAK9=C2UiBNQtv0Q2yJMKqc5pMX_jam+ZmfRz3Rme0ZYuqN68HA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/riscv-intc: Mark INTC nodes for secondary CPUs as initialized.
To:     Dmitry Dunaev <dunaev@tecon.ru>
Cc:     dunaich@mail.ru, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 3:59=E2=80=AFPM Dmitry Dunaev <dunaev@tecon.ru> wro=
te:
>
> The current Linux driver irq-riscv-intc initialize IRQ domain only once,
> when init function called on primary hart. In other cases no IRQ domain i=
s
> created and no operation on interrupt-controller node is performed.
> This is cause of that no common Linux driver can use per-cpu interrupts
> mapped to several CPUs because fwnode of secondary cores INTC is not
> marked as initialized. This device is always will be marked as deferred.
> For example the system with devicetree
>
>     cpu0: cpu@0 {
>         cpu0_intc: interrupt-controller {
>             interrupt-controller;
>             compatible =3D riscv,cpu-intc;
>         };
>     };
>
>     cpu1: cpu@1 {
>         cpu1_intc: interrupt-controller {
>             interrupt-controller;
>             compatible =3D riscv,cpu-intc;
>         };
>     };
>
>     buserr {
>         compatible =3D riscv,buserr;
>         interrupts-extended =3D <&cpu0_intc 16 &cpu1_intc 16>;
>     };
>
> will always report 'buserr' node as deferred without calling any
> bus probe function.
>
> This patch will mark all secondary nodes passed to irq-riscv-intc
> driver init function as initialized to be able to act as correct
> IRQ phandle node.
>
> Signed-off-by: Dmitry Dunaev <dunaev@tecon.ru>
> ---
>  drivers/irqchip/irq-riscv-intc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 4adeee1bc391..c01a4e8d4983 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -155,8 +155,10 @@ static int __init riscv_intc_init(struct device_node=
 *node,
>          * for each INTC DT node. We only need to do INTC initialization
>          * for the INTC DT node belonging to boot CPU (or boot HART).
>          */
> -       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id())
> +       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id()) {
> +               fwnode_dev_initialized(of_node_to_fwnode(node), true);

There is already a patch on LKML to address this.
https://www.spinics.net/lists/kernel/msg4929886.html

>                 return 0;
> +       }
>
>         return riscv_intc_init_common(of_node_to_fwnode(node));
>  }
> @@ -179,8 +181,10 @@ static int __init riscv_intc_acpi_init(union acpi_su=
btable_headers *header,
>          * for each INTC. We only do INTC initialization
>          * for the INTC belonging to the boot CPU (or boot HART).
>          */
> -       if (riscv_hartid_to_cpuid(rintc->hart_id) !=3D smp_processor_id()=
)
> +       if (riscv_hartid_to_cpuid(rintc->hart_id) !=3D smp_processor_id()=
) {
> +               fwnode_dev_initialized(of_node_to_fwnode(node), true);
>                 return 0;
> +       }

We don't need this change for ACPI because we don't have devlink
dependency between devices and INTC.

Regards,
Anup

>
>         fn =3D irq_domain_alloc_named_fwnode("RISCV-INTC");
>         if (!fn) {
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
