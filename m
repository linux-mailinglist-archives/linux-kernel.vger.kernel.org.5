Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A0276431E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjG0AzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjG0AzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:55:12 -0400
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65751128;
        Wed, 26 Jul 2023 17:55:10 -0700 (PDT)
Received: from localhost.localdomain (xry111.site [89.208.246.23])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 402161C1E1F;
        Thu, 27 Jul 2023 00:55:02 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1690419305;
        bh=EGiODkWN+sI4nD/FFSATqvkp1/ldo4EJzoi1AC4wIA4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Kh/eQ+OxKl2JWIeZfu0JsJd/LcrQINOI2JVHgm+QQGNOSnPJ7QTLDlNz5IqwOCPRb
         lQdXOMt32fYhpHUsKRiKv5mLIOu4zVyJS0bx+ZxmTB1iMBSTnYWocyg79ealOaxOOk
         FQn3XI2S2WtGvW8WGzvC3wEMnyNU+J7H7tJ4pQZCkSL6/vMjFtlc4SDGupIWJIyXyX
         6FziEQESVxgrtRYr+ZCGxu7Bg09tqPf7MTq2vJ8agLtr1HykWFcwVnr2hL5Y5LdVcB
         h2d+hAx2qSHs6PCHgX4Ycr74d7JAYT4jHcQ4g92fWiJ0fjclgdo9LaU3NGVikHZyvs
         VXaXme01rZI+w==
Message-ID: <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
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
Date:   Thu, 27 Jul 2023 08:54:59 +0800
In-Reply-To: <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
References: <20230617161529.2092-1-jszhang@kernel.org>
         <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
         <20230725-unheard-dingy-42f0fafe7216@wendy> <ZL/jMYL3akl78ZZN@xhacker>
         <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
         <ZME1J4mpVf5yth32@xhacker>
         <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
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

On Thu, 2023-07-27 at 08:14 +0800, Xi Ruoyao wrote:
> On Wed, 2023-07-26 at 23:00 +0800, Jisheng Zhang wrote:
> > which dts r u using? see below.
> >=20
> > >=20
> > > Or maybe my toolchain (GCC 13.1.0, Binutils-2.40, with no patches) ca=
n
> > > miscompile the kernel?
>=20
> /* snip */
>=20
> > > Boot HART ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 : 0
> > > Boot HART Domain=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 : root
> > > Boot HART Priv Version=C2=A0=C2=A0=C2=A0 : v1.11
> > > Boot HART Base ISA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : rv64im=
afdcvx
> >=20
> > what? I don't think the mainline dts provide v and x.=20
>=20
> I copied the compiled arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dtb
> into /boot and loaded it with u-boot "load" command onto 0x46000000, and
> passed this address to the booti command.
>=20
> But maybe I've copied the wrong file or made some other mistake... I'll
> recheck.

Hmm, and if I read OpenSBI code correctly, this line reflects the
content of the misa CSR, not the DT riscv,isa value.

The log of successful boot provided by Drew also contains
"rv64imafdcvx":

https://gist.github.com/pdp7/23259595a7570f1f11086d286e16dfb6

