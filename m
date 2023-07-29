Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46DC767CB8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjG2HLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG2HLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:11:45 -0400
Received: from rivendell.linuxfromscratch.org (rivendell.linuxfromscratch.org [208.118.68.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C83C44BE;
        Sat, 29 Jul 2023 00:11:43 -0700 (PDT)
Received: from [192.168.124.11] (unknown [113.140.29.5])
        by rivendell.linuxfromscratch.org (Postfix) with ESMTPSA id D31131C1D3F;
        Sat, 29 Jul 2023 07:11:34 +0000 (GMT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.0 at rivendell.linuxfromscratch.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfromscratch.org;
        s=cert4; t=1690614701;
        bh=GtWup6G69OxGe9NTbfxKk/AU+VDZ7uQHTSJ8d2QGmfQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Bj1leRvNyevEtj8TzesgVIBZYbWbdWg23CPM/Xn5iwZyDxfdaMspe2ttJVf9hZnGl
         q67wOPsfDIm7OX52dFItVqoytUuczsto/umSo/psLgv7r4ZD9lOLOEsSYQ9EhUaHPw
         7PmcJ8PNVoml/FFf7xUuP+KZNzIlHDAvT5vKAvh7QZjceBnG4ipFEPv2ggBz9z4A8n
         J+S47IMhVlhXBjpDiAO/QGKyTlf9osQwNKpIu3e2Pz8xxtIRCoqNA7hGgJCu8ZIywN
         naYpGypcuG/4c4oKhZeryhCqS+HN6xw3CxyrsTIHlOJUvF7ju5vPx2rVhQ4X8MPbA2
         mD0mxJ8IlVLpw==
Message-ID: <a4e5c82728d053b6888fdb6870ec69bd83cb6405.camel@linuxfromscratch.org>
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
From:   Xi Ruoyao <xry111@linuxfromscratch.org>
To:     Drew Fustini <dfustini@baylibre.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
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
Date:   Sat, 29 Jul 2023 15:11:27 +0800
In-Reply-To: <ZMQAqUfb0y/igQs2@x1>
References: <3e0994dab495920ac590dc28d6b9d9765abe0c7e.camel@linuxfromscratch.org>
         <ZME1J4mpVf5yth32@xhacker>
         <866eab3e30a18c50742a75d62aee223fdc7e3cee.camel@linuxfromscratch.org>
         <4986b92f1a5aa303a529c6004aaedd2184c3ccf7.camel@linuxfromscratch.org>
         <ZMKXQpreSr47MFj6@xhacker>
         <290101d386866f639a7c482527d7a78c5108d49b.camel@linuxfromscratch.org>
         <ZMNojqwLxcG8FcHN@x1>
         <af41edfe515373530d3d1ffc43c581131e6f6038.camel@linuxfromscratch.org>
         <0f528aa0d4e6f2491835c9a78bb38dd162b75810.camel@linuxfromscratch.org>
         <CAJM55Z9SeT_-5vDWVUAOKeNGZ0TmBPQMjdaZuyVcnbNJuxNCBQ@mail.gmail.com>
         <ZMQAqUfb0y/igQs2@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-28 at 10:53 -0700, Drew Fustini wrote:
> On Fri, Jul 28, 2023 at 12:23:12PM +0200, Emil Renner Berthing wrote:
> > On Fri, 28 Jul 2023 at 12:07, Xi Ruoyao <xry111@linuxfromscratch.org> w=
rote:
> > >=20
> > > On Fri, 2023-07-28 at 15:40 +0800, Xi Ruoyao wrote:
> > > > On Fri, 2023-07-28 at 00:04 -0700, Drew Fustini wrote:
> > > > > It seems like your kernel config is the problem. I used it and I =
saw
> > > > > the same result of a panic in riscv_intc_irq:
> > > > > https://gist.github.com/pdp7/1a26ebe20017a3b90c4e9c005f8178e1
> > > > >=20
> > > > > This is the config I have been using successfully:
> > > > > https://gist.github.com/pdp7/ecb34ba1e93fc6cfc4dce66d71e14f82
> > > > >=20
> > > > > Could you try that config?
> > > > >=20
> > > > > Linux 6.5-rc3 boots okay when built with it:
> > > > > https://gist.github.com/pdp7/580b072f9a5bf9be87cf88b5f81e50e3
> > > >=20
> > > > Yes, your configuration works.
> > > >=20
> > > > I'll try to figure out which specific configuration item is problem=
atic
> > > > in my origin one...
> > >=20
> > > Ah, I found it... If I deselect CONFIG_FRAME_POINTER it will crash.
> > >=20
> > > And I see RISC-V selects ARCH_WANT_FRAME_POINTERS, so it seems frame
> > > pointer is mandated.=C2=A0 But then why I'm able to deselect
> > > CONFIG_FRAME_POINTER?
> >=20
> > You've probably run into this issue:
> > https://lore.kernel.org/linux-riscv/20230716001506.3506041-1-guoren@ker=
nel.org/
> >=20
> > Try applying those two patches.
> >=20
> > /Emil
>=20
> Thanks, I think that fixes the issue with CONFIG_FRAME_POINTER=3Dn. I had
> the same kernel crash [1] when trying the config from Xi [2].
>=20
> I just did 'b4 shazam 20230716001506.3506041-1-guoren@kernel.org' and
> the riscv_intc_irq panic no longer occurs [3]. I don't have the mmc
> patches applied on this branch so the boot just hangs at mounting rootfs
> but I think it is otherwise okay.

Again thanks for your help!  I'm looking forward to your MMC driver :).

> [1] https://gist.github.com/pdp7/1a26ebe20017a3b90c4e9c005f8178e1
> [2] https://gist.github.com/pdp7/c6e358be892d506826be304dcc346a7a
> [3] https://gist.github.com/pdp7/871ada434febeca4ff93f2381352c038

