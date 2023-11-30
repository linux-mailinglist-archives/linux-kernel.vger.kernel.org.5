Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8477FEF03
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345460AbjK3MY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345470AbjK3MYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:24:53 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FFB171F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:24:59 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-46449c963deso314068137.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1701347098; x=1701951898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPS3xxiuZWf1VxJtT0YO9mlspTNHuYgCnulWUTvdTUA=;
        b=ECLhJ4NKqF2rj1/PeD6iSReZ0dFLqck+yBSx47CopTjwkcv5JLnp/yhXp0huWedkpj
         QdpjT87bayDcGpHhuDCIwSstPERFF2LjATKBUt3sxvCkh3tYIJdjb33ZIvRrxwRKwZvp
         xguxDjOFJf2l0XaYLox+FAG2HVUTQOy9L1ZNQqHos0lDY9ohp2FfBrfn49T+zO7/kFcq
         OFKvcgko4TLMCBicbSmk8XFTgtVB+r1nLINfKtoi6hlEAFaBfq5Qc52+LXBfGf1jrxly
         yAaSKDhfy7tGdUskuh1efPAuf2RclOIEgbO4XIvwwEmmAZQPYD3JWCne6Qd9AO6NPOA9
         hBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701347098; x=1701951898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPS3xxiuZWf1VxJtT0YO9mlspTNHuYgCnulWUTvdTUA=;
        b=W9WlP1gKBIDRIHKKcuYaQTfl/ZNk8xUylE859QnRqg2U7C/TtnKo1Suc+3J6ubwcwC
         ZCLuyPR4hmQfrgXPuxB6k8TgD991C2JehfAo4sgJvJcsLy9MQLT250Kkii1gGb6ILOIE
         8S/Jlahq5xVI+9iDTXpwWvs8p/FDrc3U3J0x5LRgQvSZz8fuOaLswrvIcbAqNH3X6Ocn
         y0rZBIvqmJrMDdxLY62fWaoBPtal5IxAR2EmTBUM/9N3Mi/3FbpkGFHqHZGGi9F/exO/
         5ccLITrPMeShkb6+7mO8Qkaw2Y+h/DV3IDhTPw3dkd/g88D0YKN9kjFAIEJf9BD7RA3k
         mxfQ==
X-Gm-Message-State: AOJu0YyARLULF/Od7Zo6lNBrqOhhqjTUDC6hxEkDUYZ0pTTyJ3vKNPmW
        A5V+LQsFwerW6ofEB2dmO+R0sG9dYxhTXZh0igonVA==
X-Google-Smtp-Source: AGHT+IF3j3HcT1aCoqg1svzx44lwtkXhHBGyT4I2UYvHSkERVae33zMG4SIUDxax/bcsvwuJzqZtRwm3Sbusnpboi2w=
X-Received: by 2002:a05:6102:317:b0:464:38fa:5ba6 with SMTP id
 23-20020a056102031700b0046438fa5ba6mr8074289vsa.7.1701347097820; Thu, 30 Nov
 2023 04:24:57 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR20MB4953C82499C5D81D2C6A020BBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953F9D77FFC76A9D236922DBBB6A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAK9=C2WAv5jJBt56xBea268DeyUA+YvbU7i+ahVjueafCi-r6A@mail.gmail.com>
 <20231130-decibel-passenger-6e932b1ce554@spud> <CAK9=C2Vsx8ddpYiqUhvqnJpdb-FKeNhLz3PsVpSeEz4TeQHiEg@mail.gmail.com>
 <20231130-shower-award-3cd5f1bba5db@spud> <CAK9=C2WgN=3BjxS+nF2ibFQoquNwXfxr_UQv8Kbf1+e4Teyfcw@mail.gmail.com>
 <20231130-laborious-dwarf-6913457466ad@spud>
In-Reply-To: <20231130-laborious-dwarf-6913457466ad@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 30 Nov 2023 17:54:43 +0530
Message-ID: <CAK9=C2UWwHVCvgXG0kNLt86JTk7P6p-EdPLS3F8Z5qnSpCPLkg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: thead,c900-aclint-mtimer:
 separate mtime and mtimecmp regs
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen Wang <unicorn_wang@outlook.com>,
        Anup Patel <anup@brainfault.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:40=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Thu, Nov 30, 2023 at 05:18:15PM +0530, Anup Patel wrote:
> > On Thu, Nov 30, 2023 at 5:15=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
>
> > > > and add separate "riscv" prefixed DT binding for RISC-V mtimer.
> > >
> > > Do you know of any users for a "riscv,mtimer" binding that are not
> > > covered by existing bindings for the clint?
> >
> > Ventana Veyron-v1 implements a mtimer per-cluster (or chiplet)
> > which is compatible to "riscv,mtimer" (i.e. we have both mtime
> > and mtimecmp MMIO registers).
>
> Okay, thanks. I guess iff veyron-v1 DT support shows up (or other
> similar devices) we can go ahead with a "riscv,mtimer" binding then.
> I had thought that you guys were going to be using ACPI though, so
> I guess the "other similar devices" applies.

We use ACPI from EDK2 onwards in our boot-flow. The booting
stages prior to EDK2 (such as OpenSBI) use DT. In fact, EDK2
also uses information in DT to populate static parts of the ACPI
table.

Regards,
Anup
