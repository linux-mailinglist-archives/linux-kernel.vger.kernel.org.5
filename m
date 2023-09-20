Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD47A878F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjITOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjITOwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:52:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7939FAD;
        Wed, 20 Sep 2023 07:52:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0126C433C8;
        Wed, 20 Sep 2023 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695221522;
        bh=+2j3nces5C2Y6G0w4dr7sRGrgDbYjuDpUw6pC0lKXLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NygEtZrk84lRg6zKqBNWyp3ecx3eq9+OEYuaKVfg2N7CTM0PFuCY+ay2Nts8XzVf9
         q4P86pfVq6bOsFt9RzKQMFNwbNhIRkmKK/+yQxcmlNfb/bwcOf0le3K5HVsWDaus7x
         8rG61cADEugt8Xq3G2sh+KU2IF3kD/RDzsV3kbHi3tlwbwEUhyOAI3/FNNgC8WphQG
         IQTQtfOjcvDjO5g1asyVSoMh/huLKRvq68pCPMiIyIssh7pZgVN2npFfCq6+p2q2i6
         29gO3GTdmMadV259kKNdlXHvnW/wCxAYFhp+wR/X5lodXFNBFyRhiuY1kExAraLatu
         HWAE1QULyRqTA==
Date:   Wed, 20 Sep 2023 15:51:55 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>,
        Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Message-ID: <20230920-992a56b66366f3c0591a6a94@fedora>
References: <66b988f0-39fc-2ed3-8f38-151d6a3c9e52@linaro.org>
 <IA1PR20MB49536BFE1254ADEE0E795A26BBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20230920-8503c6365655d3ef3dadfd53@fedora>
 <CAK9=C2WWzc_M49-S+Gi509a6-gk3-89sAZn-ZCRhsQc4JwUpoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lO3IQKh1/e514qwn"
Content-Disposition: inline
In-Reply-To: <CAK9=C2WWzc_M49-S+Gi509a6-gk3-89sAZn-ZCRhsQc4JwUpoQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lO3IQKh1/e514qwn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 08:08:49PM +0530, Anup Patel wrote:
> On Wed, Sep 20, 2023 at 6:28=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Sep 20, 2023 at 08:40:07PM +0800, Inochi Amaoto wrote:
> > > >On 20/09/2023 14:15, Inochi Amaoto wrote:
> > > >>> On 20/09/2023 08:39, Chen Wang wrote:
> > > >>>> From: Inochi Amaoto <inochiama@outlook.com>
> > > >>>>
> > > >>>> Add two new compatible string formatted like `C9xx-clint-xxx` to=
 identify
> > > >>>> the timer and ipi device separately, and do not allow c900-clint=
 as the
> > > >>>
> > > >>> Why?
> > > >>>
> > > >>
> > > >> If use the same compatible, SBI will process this twice in both ip=
i and
> > > >> timer, use different compatible will allow SBI to treat these as d=
ifferent.
> > > >> AFAIK, the aclint in SBI use the same concepts, which make hard to=
 use the
> > > >> second register range. I have explained in another response.
> > > >
> > > >What is a SBI? Linux driver? If so, why some intermediate Linux driv=
er
> > > >choice should affect bindings?
> > > >Best regards,
> > > >Krzysztof
> > > >
> > >
> > > SBI (Supervisor Binary Interface) is defined by riscv, which is an in=
terface
> > > between the Supervisor Execution Environment (SEE) and the supervisor=
=2E The
> > > detailed documentation can be found in [1].
> > >
> > > The implement of SBI needs fdt info of the platform, which is provide=
d by
> > > kernel. So we need a dt-bindings for these devices, and these will be
> > > processed by SBI.
> > >
> > > [1] https://github.com/riscv-non-isa/riscv-sbi-doc
> >
> > Yeah, this is the unfortunate problem of half-baked bindings (IMO)
> > ending up in OpenSBI (which likely means they also ended up in QEMU).
> > This T-Head stuff is coming across our (metaphorical) desks, so we are
> > obviously going to try to do things correctly. I may end up speaking to
> > Anup later today, if I do I will point him at this thread (if he hasn't
> > seen it already).
>=20
> RISC-V ACLINT is one of those unfortunate non-ISA specs (like
> SiFive PLIC) which is implemented by various organizations but
> not officially ratified by RVI.

Yeah, I brought this stuff up at the weekly pw sync call, and Paul
pointed that out.

> The SiFive CLINT has flexibility related limitations which makes it
> not useful for multi-socket and mult-die systems. The SiFive CLINT
> is also not useful for systems with AIA because with AIA M-mode has
> a new way of doing M-mode IPIs. Due to this reasons, the RISC-V
> ACLINT spec breaks down traditional SiFive CLINT into two separate
> devices namely mtimer and mswi. This allows platforms to implement
> only the required set of devices. The mtimer as defined by the ACLINT
> specifications also allows platforms to place mtime and mtimecmp
> registers at different locations.
>=20
> Refer, https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc
>=20
> We need a separate DT bindings document for ACLINT MTIMER
> and ACLINT MSWI because these are separate devices. The
> Sophgo sg2042 SoC should add their implementation specific
> compatible strings in this document.

If the spec isn't frozen, I'm not accepting a binding for the "generic"
version of it. Bindings for this specific implemtnation are okay.
For sure though, squeezing this into the sifive,plic binding isn't
appropriate.

What was pointed out, I think by Samuel, that the reason that this may
need to be split is the fact that there are many possible MTIMER
register ranges & possibly sswi stuff too that would need to be
differentiated.

>=20
> Regards,
> Anup

--lO3IQKh1/e514qwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQsHCAAKCRB4tDGHoIJi
0oIxAP4l9Y+OWxR43uIh16s9q+QkJcVDOsWIXdpnb0KYX5AOogD/eVTeoiQKQkzL
Sdw+Zw7PIgPrS0SkTX280B840uhfswE=
=7xPz
-----END PGP SIGNATURE-----

--lO3IQKh1/e514qwn--
