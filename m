Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BB977426D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjHHRo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjHHRog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:44:36 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C957DAA146
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:20:03 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4478ea3ac05so2153605137.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691511563; x=1692116363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9zS30PvoHblPo8YN82wx1JKihZIxwLEMzYHF89G6sU=;
        b=fFcWy6vQXRriasQBzQp5wZCsoL179Q0MZdKjiLmWmUp9b8tWWg3qCghtd7rTB3NFPF
         0Fsj69tM1ZnXDVTxO+U+wyybonRFjtZv7t81HF890KjO7bA94wZjxjd/r5ZAKAOeOOYk
         WZ7fL12aJEb5DeABXUTMlPFBrgBuXbxcv0HW/JL9VMLiFGas8oQSZAvEf4gcX8HwGK5P
         ylkx9Nc8DqVoz7Mxgpqgvo1JxZFSUbwzR0fEPOahrX2DS2yJNKIbpATPWp+8h/VkS7rg
         s44kgSkL1BZM74aJ8aeBFDkq6bL9+tQ3vPBUieOFmoDX0we9yFUu8fHotZTPfc0rJSTD
         lhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511563; x=1692116363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9zS30PvoHblPo8YN82wx1JKihZIxwLEMzYHF89G6sU=;
        b=fQgI0Ysre/d6hjQR6r9u6ZPvE1XU+mg9YcMwVJjFBWLIOCw1hj+8qDYQH4Nwx1FTUo
         Mdzmb0QZo8BLoD2hxpxhNxGXxAEcuxGGkqxwqWcmMWYXVFJkTUqllhNcpTsk2jQ8rc8C
         /18ZZ6dMdr0pX7SF/MRC/06vsz2ziwkeaZa4rnDqqZ7Uc0plgaUTw4Wr3j+x9ynumb+B
         Xa/d9nf5wtTB8pYtR3wbhyseQyzTavyl28sSzRHgdNp1wt6wlmTWwbbg91DPelIqxXGR
         //5pbgqm9M+SG5YaSYa81gNilereKqMUtTJVD4zyOn4agBdwQ3t1PH7uqUk4UL3+3P8K
         KSAQ==
X-Gm-Message-State: AOJu0Yw3FGcrrYpiLYv6BM9VzWUMYIgdV4ebez8ygicIE/NJClR99fer
        pjXFal7XHy6Kz0mFT5wBLmaWRJlHYaYlSxagKhQdFMAFnn18Vor7RKc=
X-Google-Smtp-Source: AGHT+IHwj3koprvncE8FX41F8VhQ9ofHcuhvfeQaw4c/xsViq681+NAYgINd4xXSKcG2d8KRUWa6MORkInxl0+tlgIk=
X-Received: by 2002:a17:90a:c583:b0:263:5c6a:1956 with SMTP id
 l3-20020a17090ac58300b002635c6a1956mr9160440pjt.25.1691492249057; Tue, 08 Aug
 2023 03:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
 <20230803175916.3174453-21-sunilvl@ventanamicro.com> <20230808-chalice-easing-1369c7386082@spud>
In-Reply-To: <20230808-chalice-easing-1369c7386082@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 8 Aug 2023 16:27:16 +0530
Message-ID: <CAK9=C2XZ7_tfSK6HNN1Em5fAHrknWBqGaD9gPL8yGs8AzE3vQg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 20/21] RISC-V: ACPI: Create PLIC platform device
To:     Conor Dooley <conor@kernel.org>
Cc:     Sunil V L <sunilvl@ventanamicro.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Will Deacon <will@kernel.org>, Haibo Xu <haibo1.xu@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Scally <djrscally@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Anup Patel <anup@brainfault.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 2:12=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Thu, Aug 03, 2023 at 11:29:15PM +0530, Sunil V L wrote:
> > Since PLIC needs to be a platform device
>
> For the unwashed, why does the PLCI need to be a platform device?
> (And while you're at that, please try to make use of the extra ~20
> characters per line that you can use here.)

As suggested by Marc Z, only timers and IPIs need to be probed early.
Everything else needs to be a platform device. The devlink feature of
Linux DD framework ensures that platform devices are probed in the
right order based on the interdependency.

The PATCH5 of the v7 AIA series converts the PLIC driver into a
platform driver. This works perfectly fine.

>
> > probe the
> > MADT and create platform devices for each PLIC in the
> > system. Use software node framework for the fwnode
> > which allows to create properties and hence the
> > actual irqchip driver doesn't need to do anything
> > different for ACPI vs DT.
> >
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
> > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
>
> > +static struct fwnode_handle *acpi_plic_create_fwnode(struct acpi_madt_=
plic *plic)
> > +{
> > +     struct fwnode_handle *fwnode, *parent_fwnode;
> > +     struct riscv_irqchip_list *plic_element;
> > +     struct software_node_ref_args *refs;
> > +     struct property_entry props[8] =3D {};
> > +     int nr_contexts;
> > +
> > +     props[0] =3D PROPERTY_ENTRY_U32("riscv,gsi-base", plic->gsi_base)=
;
> > +     props[1] =3D PROPERTY_ENTRY_U32("riscv,ndev", plic->num_irqs);
> > +     props[2] =3D PROPERTY_ENTRY_U32("riscv,max_prio", plic->max_prio)=
;
>
> My OCD wants to know why this gets an _ but the others have a -.
>
> > +     props[3] =3D PROPERTY_ENTRY_U8("riscv,plic-id", plic->id);
> > +     props[4] =3D PROPERTY_ENTRY_U64("riscv,plic-base", plic->base_add=
r);
> > +     props[5] =3D PROPERTY_ENTRY_U32("riscv,plic-size", plic->size);
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup
