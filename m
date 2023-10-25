Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C337D6F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbjJYObo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjJYObm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:31:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D680E195
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:31:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-27d4372322aso4063788a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698244299; x=1698849099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ5KMjXB468aEBKF9WSiVgBHVpR3dfOc9lss4H+jYhs=;
        b=a8jHXs/ncDqFO3Ug9Z+uiw8TCylysZZRBAyDhkAouP9H9sVsz6SlgE7cGOONSIdeza
         UyncUDczzJNaeSbXIYDPiTPFwwc+eZyNkabPIQlx4L1df+00tTn8diRoxnMEybe02RUx
         o2AtaQH7glr3jSKfvclC4QyiVUYiGELEg43rmPzVha/M+cCfw1CrsEA+EOaiFaFPoMbn
         s5O2UX9M/zoOPD+6V5Uzy9gvYMNMnGu1K3bRnWcMBR8fMz/IbZrpOK43A6nzeLjG8773
         wwc2SaKRumc0WNa8CsysrQj1IJVW6JBrlDtBirNzknMzmiE3rsTXWWFb7xP0XEf1v631
         jdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698244299; x=1698849099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQ5KMjXB468aEBKF9WSiVgBHVpR3dfOc9lss4H+jYhs=;
        b=PCwU0z+4MwnalYjk669OayrmiNyHB/tr+m1YfZJ9dnHH2nakDAmFpNMC2+NyrNUT09
         0PG3TdOOnoy29Ay/O6LnJJJNBnerGKWYzTqddwwp4DUbUOSmqxw6CRAUByYn4+jW2mZF
         DGqTPM9TGjlZII2MZBJ83XyVyjGnMA5mjJlHacDHRVG1YZpUCQqQYaeYAKGAYUbGEu1F
         sJzaVDTvSdYWyXnW+wXYxkBikr0HPrY3Rzw91ewwPy95dX3HFbZI8r1rxplor5f/kLB1
         rQMNLBXkIo1qMOkGKYcGwVhuhFutKBxqmMmAE6AV70UGN9/a2FMspMNL+70kNhryqTGX
         vdKQ==
X-Gm-Message-State: AOJu0Yxp2cTTg/weqk8HY4AP3t9Lx4OPGv1WG3XJJ1jFgqyM4m6H3wNa
        nw7Ue5lKy6bLIY0vIv63R3hvTKdSZb2noTPKVbjaBA==
X-Google-Smtp-Source: AGHT+IF7tK7NfgRXXBPos0ywzXuU86jChm+AWmtZlA6vYIo4J7cbqAiHmW1rfAYJAfDBMxaRs+5k+PsdcZyeZeyJr4k=
X-Received: by 2002:a17:90b:4d8e:b0:27d:515d:94f0 with SMTP id
 oj14-20020a17090b4d8e00b0027d515d94f0mr11823715pjb.24.1698244298909; Wed, 25
 Oct 2023 07:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231025142820.390238-1-apatel@ventanamicro.com>
In-Reply-To: <20231025142820.390238-1-apatel@ventanamicro.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 25 Oct 2023 20:01:27 +0530
Message-ID: <CAK9=C2UrDELsQpM2S5h9Qd9SJWrFmuGGCT-zYJgHL3E0S-DkUA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Linux RISC-V AIA Preparatory Series
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
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

Hi Palmer,

On Wed, Oct 25, 2023 at 7:58=E2=80=AFPM Anup Patel <apatel@ventanamicro.com=
> wrote:
>
> The first three patches of the v11 Linux RISC-V AIA series can be
> merged independently hence sending these patches as an independent
> perparatory series.
> (Refer, https://www.spinics.net/lists/devicetree/msg643764.html)
>
> These patches can also be found in the riscv_aia_prep_v1 branch at:
> https://github.com/avpatel/linux.git
>
> Anup Patel (3):
>   RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
>   of: property: Add fw_devlink support for msi-parent
>   irqchip/sifive-plic: Fix syscore registration for multi-socket systems

As mentioned on the patchwork call, these are the first three patches
of the v11 Linux AIA series.

Please consider this for the Linux-6.7 merge window.

>
>  arch/riscv/kernel/cpu.c           | 11 ++++++-----
>  drivers/irqchip/irq-sifive-plic.c |  7 ++++---
>  drivers/of/property.c             |  2 ++
>  3 files changed, 12 insertions(+), 8 deletions(-)
>
> --
> 2.34.1
>

Regards,
Anup
