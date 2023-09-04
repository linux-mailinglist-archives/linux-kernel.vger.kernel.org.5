Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DFA791B98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 18:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbjIDQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 12:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbjIDQ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 12:28:57 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22C310E4;
        Mon,  4 Sep 2023 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1693844925;
        bh=m9pWXbBe49tlMWmx7ceZ+WgmcQHqI9sadLx79JoqoHs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lndarXhJsj5eTZZzytgttIVLAHZ00If/azANijJL7+vxFoZtQgXOk5iiPxdEm1j7A
         PhkwRFDWlZTeefh9otlfhGIhuEFu7CjKomKHcxrfVG82Vu5/PUEKK3uzYvT5MkG5H/
         ewglGZ6p1p6+PcgMVYRKXpoEXrnjpdzVswZIIO0s=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 26728659C0;
        Mon,  4 Sep 2023 12:28:43 -0400 (EDT)
Message-ID: <292198d3915bafbe1c82372da2f2755a1842512f.camel@xry111.site>
Subject: Re: [PATCH] riscv: dts: thead: set dma-noncoherent to soc bus
From:   Xi Ruoyao <xry111@xry111.site>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        inux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Sep 2023 00:28:41 +0800
In-Reply-To: <ZPXtl1iWlsYwmixc@xhacker>
References: <20230820115353.1962-1-jszhang@kernel.org> <ZPUXhe7ogxvaB6Eg@x1>
         <ZPXtl1iWlsYwmixc@xhacker>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-04 at 22:45 +0800, Jisheng Zhang wrote:
> On Sun, Sep 03, 2023 at 04:32:21PM -0700, Drew Fustini wrote:
> > On Sun, Aug 20, 2023 at 07:53:53PM +0800, Jisheng Zhang wrote:
> > > riscv select ARCH_DMA_DEFAULT_COHERENT by default, and th1520 isn't
> > > dma coherent, so set dma-noncoherent to reflect this fact.
> > >=20
> > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > > ---
> > > =C2=A0arch/riscv/boot/dts/thead/th1520.dtsi | 1 +
> > > =C2=A01 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/=
dts/thead/th1520.dtsi
> > > index 56a73134b49e..58108f0eb3fd 100644
> > > --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> > > +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> > > @@ -139,6 +139,7 @@ soc {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0interrupt-parent =3D <&plic>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0#address-cells =3D <2>;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0#size-cells =3D <2>;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dma-noncoherent;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ranges;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0plic: interrupt-controller@ffd8000000 {
> > > --=20
> > > 2.40.1
> > >=20
> >=20
> > Tested-by: Drew Fustini <dfustini@baylibre.com>
> >=20
> > I tried this on the BeagleV Ahead. They system booted as expected and I
> > did not notice any problems in the boot log.
> >=20
> > Are there other patches such as the dwmac series that I should test thi=
s
> > with?
>=20
> Hmm, this patch is necessary to test dwmac, emmc ;)

Drew: does this fix the "broken DMA" issue you've mentioned in the EMMC
support patch?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
