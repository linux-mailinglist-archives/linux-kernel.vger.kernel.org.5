Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFC7764FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjG0J24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjG0J2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:28:17 -0400
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDACE8690;
        Thu, 27 Jul 2023 02:19:16 -0700 (PDT)
Received: from [192.168.124.11] (unknown [113.140.29.10])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 872301C1E3F;
        Thu, 27 Jul 2023 09:19:08 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1690449554;
        bh=U3/iZtufbRk45Ts76eay7OLdIEe1IdvlvMnUnVReqh8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Z8mNShnFzFCDa+6T09xC9x+L74plUnIJhzVb1nZjZltH+qoaU6mGqmSzxrWpErjEt
         k6ofcrPoVjzWt+bV2neqteEUYWxIRtl/Ti4h4tWpD0mXNPlZEPuaywC/g0Y/GX4fKs
         ninbuE0bT73eHjVHFeH8zpFw2aDSSoypWL63nXR9behxJgfKWyEoNN/Hha8E9SKiQn
         6IP8Y4r5O9LWZrsDguAo2XpyMgSr7ZYAI4tAQ1g+nwNoZ1a2+mdnk7SONgJp/Wut8I
         gJ7ItS39IunM9F5YA20b712clPIe/5mqVq5JRUZfOoMdQidYarE7g8jB5tjV9qzU1y
         qNvD0LcqdTV/w==
Message-ID: <c5e44ec519f4d56a71d416cf43a375cdbf0b9358.camel@linuxfromscratch.org>
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
From:   Xi Ruoyao <xry111@linuxfromscratch.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Thu, 27 Jul 2023 17:18:51 +0800
In-Reply-To: <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
References: <20230617161529.2092-1-jszhang@kernel.org>
         <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
         <20230725-unheard-dingy-42f0fafe7216@wendy> <ZL/jMYL3akl78ZZN@xhacker>
         <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
         <ZME1J4mpVf5yth32@xhacker>
         <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
         <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-27 at 08:54 +0800, Xi Ruoyao wrote:
> On Thu, 2023-07-27 at 08:14 +0800, Xi Ruoyao wrote:
> > On Wed, 2023-07-26 at 23:00 +0800, Jisheng Zhang wrote:
> > > which dts r u using? see below.
> > >=20
> > > >=20
> > > > Or maybe my toolchain (GCC 13.1.0, Binutils-2.40, with no patches) =
can
> > > > miscompile the kernel?
> >=20
> > /* snip */
> >=20
> > > > Boot HART ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 : 0
> > > > Boot HART Domain=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 : root
> > > > Boot HART Priv Version=C2=A0=C2=A0=C2=A0 : v1.11
> > > > Boot HART Base ISA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : rv64=
imafdcvx
> > >=20
> > > what? I don't think the mainline dts provide v and x.=20
> >=20
> > I copied the compiled arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dtb
> > into /boot and loaded it with u-boot "load" command onto 0x46000000, an=
d
> > passed this address to the booti command.
> >=20
> > But maybe I've copied the wrong file or made some other mistake... I'll
> > recheck.
>=20
> Hmm, and if I read OpenSBI code correctly, this line reflects the
> content of the misa CSR, not the DT riscv,isa value.
>=20
> The log of successful boot provided by Drew also contains
> "rv64imafdcvx":
>=20
> https://gist.github.com/pdp7/23259595a7570f1f11086d286e16dfb6

I tried a __show_reg call before the panic:

[    0.012953] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.5.0-rc3 #7
[    0.012967] Hardware name: Sipeed Lichee Pi 4A (DT)
[    0.012976] epc : ffffffff80c84a60 ra : 0000000000000000 sp : ffffffff80=
04dfee
[    0.012988]  gp : 0000000200000120 tp : ffffffff80c03d20 t0 : ffffffff80=
002d6c
[    0.012997]  t1 : ffffffff8004dfee t2 : ffffffff8004dfe6 s0 : ffffffff80=
c03d20
[    0.013005]  s1 : ffffffff80c966f0 a0 : ffffffff80c98140 a1 : 2000000000=
000000
[    0.013012]  a2 : 0000000000000043 a3 : 203a656c6f736e6f a4 : ffffffff80=
c03def
[    0.013021]  a5 : ffffffff80dcb4a0 a6 : 0000000000000001 a7 : 0000000000=
000014
[    0.013030]  s2 : 000000000000000a s3 : 0000000000000000 s4 : 0000000000=
000000
[    0.013036]  s5 : ffffffd9fef69740 s6 : 0000000000000008 s7 : 0000000000=
000032
[    0.013046]  s8 : 0000000000000002 s9 : ffffffff80c03df0 s10: ffffffff80=
dcb4e8
[    0.013056]  s11: ffffffff80dc7c80 t3 : ffffffff80c03d48 t4 : ffffffff80=
dcb2f0
[    0.013064]  t5 : ffffffff80c84a60 t6 : ffffffff80c10b98
[    0.013071] status: 0000000000000000 badaddr: 0000000000000001 cause: ff=
ffffff80dcb4f7
[    0.013082] Kernel panic - not syncing: unexpected interrupt cause

I compared these with System.map and the result seems completely erratic
(for example, sp is out of init_stack, and gp is not __global_pointer$).

