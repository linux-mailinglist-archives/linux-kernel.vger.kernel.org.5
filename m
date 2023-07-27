Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141D67642DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 02:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjG0APP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 20:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG0APN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 20:15:13 -0400
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DFBE1AD;
        Wed, 26 Jul 2023 17:15:10 -0700 (PDT)
Received: from [192.168.3.30] (unknown [36.44.143.80])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id 1A1DB1C81CC;
        Thu, 27 Jul 2023 00:15:00 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1690416905;
        bh=DIeHF5kJlA2aI9G3e6fvnHlF5pPSTY4C8thMtYC5jiI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Wb87FT5DJHs6JK0kkjGyB2DV3Hrd2ZeMFoeSgfiyefBcReHXAqsMW83UaZyYIHnjF
         CSnJtJoqtkVT+0uGBJARFDnZ53zaawbH7XFMa+0wDSbUZqY5CP6KPhP8zF4vXcSKg/
         qTdrsOrNasLdASe9Jy1wYJ7K5XAQu23cl46f9US7WPY2QY8gI6z46QOHcLy2rbIzO9
         fgAbZT1719VtNr+zfnKJgJxpCYw6ZOTor4T584TiuGAPK689c+IiiIzWEd8/m8JUNF
         2XPPx7w4n+HRJPqDjV1ZyQmChzGVQd0n8h68ierXMAO/5l8HdjC0Xmj3riV81mMtAt
         8L+EvJDv5NizQ==
Message-ID: <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
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
Date:   Thu, 27 Jul 2023 08:14:57 +0800
In-Reply-To: <ZME1J4mpVf5yth32@xhacker>
References: <20230617161529.2092-1-jszhang@kernel.org>
         <c9a44f534071a6d67f1e21bafdb713793c559124.camel@linuxfromscratch.org>
         <20230725-unheard-dingy-42f0fafe7216@wendy> <ZL/jMYL3akl78ZZN@xhacker>
         <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
         <ZME1J4mpVf5yth32@xhacker>
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

On Wed, 2023-07-26 at 23:00 +0800, Jisheng Zhang wrote:
> which dts r u using? see below.
>=20
> >=20
> > Or maybe my toolchain (GCC 13.1.0, Binutils-2.40, with no patches) can
> > miscompile the kernel?

/* snip */

> > Boot HART ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 : 0
> > Boot HART Domain=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
: root
> > Boot HART Priv Version=C2=A0=C2=A0=C2=A0 : v1.11
> > Boot HART Base ISA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : rv64imaf=
dcvx
>=20
> what? I don't think the mainline dts provide v and x.=20

I copied the compiled arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dtb
into /boot and loaded it with u-boot "load" command onto 0x46000000, and
passed this address to the booti command.

But maybe I've copied the wrong file or made some other mistake... I'll
recheck.

