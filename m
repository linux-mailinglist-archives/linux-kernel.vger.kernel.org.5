Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856187B06AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjI0OZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjI0OZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:25:04 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D8F3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:25:02 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7a893053770so7143468241.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695824701; x=1696429501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zBtvWgKmM9zJhcy404AwOZ/qden8YZEKEMkYgmkSGM=;
        b=GK05OGmBn9NauqSyZ/dBElRXNYu+qYfbBeP+LcSD3l0URYLmzbf+t4duZRs8f2ijwW
         N6ZPesGjhfIBzI67k1ypnpEzGOWAPDI3l9NHDF8hpigyH0HgAp5YgTFx67bVd66X1Vqq
         9uCevoPL2nkGEYuNSRL+IUE71vdocQ2zaEhGKjPLaIzHszKZFmUk07Yi2GJI4NMuZI1j
         h8S/2Xa7ZYNCBVpQPojhdLJ1mzizCeqWjmFA0FDbkiNbvh/9sfmTlHAJYi/oR72m1bhO
         yBTK0503QD6kzMMC0KuNqW4Bu3HvojHpDe37uwtcTfEi+5Ep4Ox/2UW9hCGEDZCPoV7M
         yCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695824701; x=1696429501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zBtvWgKmM9zJhcy404AwOZ/qden8YZEKEMkYgmkSGM=;
        b=QaZbfjVVaNZXHQpVuddKm4XCyFT2ERlZV6kh9J3IzQ+f/24YAy27X4YtYqgBKrg0py
         6dlYPYtHeThGE8aU1KKmXSoiKB4WWYoEzigAafxP2dClBTd3tnbOoXEFvfVaE5JNNJW9
         qWZHeo2GmHcC+TUbhGAreZwiU4Om9kX4wb7LlZlbR1iAUekvRytEvCmIKq4Yjtk3rNu2
         F3JbzupV7/FjteEfyBfBVwsPai30RKXTdWqGH5SYk8tl1e69bO/eS0MRNkUY0juNTqps
         8mqusJJQUclh3z9BCv9U4wIH01jdfHv6LVYg7VxcZorsL9LEm1pDLJXToeiJNnNXMPKh
         dTlA==
X-Gm-Message-State: AOJu0YyuALlKy9Hb/dzyEIuAuF/9UtCCR/zYxJdjrJMNEqD+BAbzfTjH
        OsZWZijMpGYI24U1ZrYvxM/CJeVzL7R+v7f9nuOTzA==
X-Google-Smtp-Source: AGHT+IEupaxxfC2vLKvvjDNkNI5Xiaf744yeHqsHZNxC5INiulcJS9XScdmDGlNcxeJW5zjArMSL/morCgR2JHbUOjc=
X-Received: by 2002:a05:6102:3f05:b0:452:79da:94a with SMTP id
 k5-20020a0561023f0500b0045279da094amr3772881vsv.4.1695824701267; Wed, 27 Sep
 2023 07:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
 <20230925-gorged-boxer-3804735e2d18@spud> <20230925-reappear-unkind-7f31acdd82de@spud>
In-Reply-To: <20230925-reappear-unkind-7f31acdd82de@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 27 Sep 2023 19:54:49 +0530
Message-ID: <CAK9=C2UBgNWFTdQKt29+bNnWDgHZGd5fU+oP1bqsarkqc5+jgg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] KVM RISC-V Conditional Operations
To:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 9:07=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Sep 25, 2023 at 04:33:15PM +0100, Conor Dooley wrote:
> > On Mon, Sep 25, 2023 at 07:08:50PM +0530, Anup Patel wrote:
> > > This series extends KVM RISC-V to allow Guest/VM discover and use
> > > conditional operations related ISA extensions (namely XVentanaCondOps
> > > and Zicond).
> > >
> > > To try these patches, use KVMTOOL from riscv_zbx_zicntr_smstateen_con=
dops_v1
> > > branch at: https://github.com/avpatel/kvmtool.git
> > >
> > > These patches are based upon the latest riscv_kvm_queue and can also =
be
> > > found in the riscv_kvm_condops_v2 branch at:
> > > https://github.com/avpatel/linux.git
> > >
> > > Changes since v1:
> > >  - Rebased the series on riscv_kvm_queue
> > >  - Split PATCH1 and PATCH2 of v1 series into two patches
> > >  - Added separate test configs for XVentanaCondOps and Zicond in PATC=
H7
> > >    of v1 series.
> > >
> > > Anup Patel (9):
> > >   dt-bindings: riscv: Add XVentanaCondOps extension entry
> > >   RISC-V: Detect XVentanaCondOps from ISA string
> > >   dt-bindings: riscv: Add Zicond extension entry
> > >   RISC-V: Detect Zicond from ISA string
> >
> > For these 4:
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Actually, now that I think of it, I'm going to temporarily un-review this=
.
> From patch-acceptance.rst:
> | Additionally, the RISC-V specification allows implementers to create
> | their own custom extensions.  These custom extensions aren't required
> | to go through any review or ratification process by the RISC-V
> | Foundation.  To avoid the maintenance complexity and potential
> | performance impact of adding kernel code for implementor-specific
> | RISC-V extensions, we'll only consider patches for extensions that eith=
er:
> |
> | - Have been officially frozen or ratified by the RISC-V Foundation, or
> | - Have been implemented in hardware that is widely available, per stand=
ard
> |   Linux practice.
>
> The xventanacondops bits don't qualify under the first entry, and I
> don't think they qualify under the second yet. Am I wrong?

The Ventana Veyron V1 was announced in Dec 2022 at RISC-V summit
followed by press releases:
https://www.ventanamicro.com/ventana-introduces-veyron-worlds-first-data-ce=
nter-class-risc-v-cpu-product-family/
https://www.embedded.com/ventana-reveals-risc-v-cpu-compute-chiplet-for-dat=
a-center/
https://www.prnewswire.com/news-releases/ventana-introduces-veyron-worlds-f=
irst-data-center-class-risc-v-cpu-product-family-301700985.html

@Palmer if the above looks good to you then please ack PATCH1-to-4

Thanks,
Anup
