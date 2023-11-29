Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F347FDD78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjK2QmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjK2QmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:42:11 -0500
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BA6BC;
        Wed, 29 Nov 2023 08:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1701276134;
        bh=VzR4EoUUwocqvWHOsW2iuWo50a/tDaBPTdKdJ2I6t2g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nizf3tKADXY9gw8RTUwRGlwn3bF+kVHzcfAVVoQy23ftGQWm2aMZcuj6CBws7tvwq
         WMFFy81wFg7j3jQUfMh7fvPY1jOvXITNjXdb5dkmIXHJgd90hJjS7roCLSq93WMdzb
         tYBpVV0GAKvvq8IUWSqB2agdkt/YRZcNtRZaba+A=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 7382166AB8;
        Wed, 29 Nov 2023 11:42:11 -0500 (EST)
Message-ID: <5f437109d2be2b8843f549a661054a2e3ec0d66e.camel@xry111.site>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Document th1520 reset control
From:   Xi Ruoyao <xry111@xry111.site>
To:     Conor Dooley <conor@kernel.org>, Kwanghoon Son <k.son@samsung.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Thu, 30 Nov 2023 00:42:09 +0800
In-Reply-To: <20230919-42333064be342f6ab125dd75@fedora>
References: <20230918045125.4000083-1-k.son@samsung.com>
         <CGME20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50@epcas1p1.samsung.com>
         <20230918045125.4000083-2-k.son@samsung.com>
         <20230918-4ef7f52da269f3a7e4023bb3@fedora>
         <005301d9eab7$5688c920$039a5b60$@samsung.com>
         <20230919-42333064be342f6ab125dd75@fedora>
Autocrypt: addr=xry111@xry111.site; prefer-encrypt=mutual;
 keydata=mDMEYnkdPhYJKwYBBAHaRw8BAQdAsY+HvJs3EVKpwIu2gN89cQT/pnrbQtlvd6Yfq7egugi0HlhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPoiTBBMWCgA7FiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQrKrSDhnnEOPHFgD8D9vUToTd1MF5bng9uPJq5y3DfpcxDp+LD3joA3U2TmwA/jZtN9xLH7CGDHeClKZK/ZYELotWfJsqRcthOIGjsdAPuDgEYnkdPhIKKwYBBAGXVQEFAQEHQG+HnNiPZseiBkzYBHwq/nN638o0NPwgYwH70wlKMZhRAwEIB4h4BBgWCgAgFiEEkdD1djAfkk197dzorKrSDhnnEOMFAmJ5HT4CGwwACgkQrKrSDhnnEOPjXgD/euD64cxwqDIqckUaisT3VCst11RcnO5iRHm6meNIwj0BALLmWplyi7beKrOlqKfuZtCLbiAPywGfCNg8LOTt4iMD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-19 at 09:47 +0100, Conor Dooley wrote:
> Guo,
>=20
> On Tue, Sep 19, 2023 at 02:08:32PM +0900, Kwanghoon Son wrote:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: thead,th1520-reset
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: syscon
> > > >=20
> > > > iDumb question perhaps, but why is this a syscon?
> > >=20
> > > This is good point.
> > > In fact, I took it from the vendor kernel, and I tried to keep it as =
same as I could.
> > > Vendor also followed drivers/reset/reset-imx7.c
> > > As Rob said, if don't need it, I'll change it.
>=20
> > I have investigated vendor kernels, but it is still not sure reset info=
rmation.
> > I thought this is about sys_reg, but without datasheet, can't tell.
> > Therefore, should be stopped patch for a while until knows better comes=
 out.
>=20
> Is there documentation in English you can provide to these people that
> are trying to add support for your product?

It can be downloaded from
https://dl.sipeed.com/shareURL/LICHEE/licheepi4a/09_Doc now.  Click on
"TH1520 User Manual.zip" and enter a captcha.  The doc about resetting
is in chapter 5 of "TH1520 System User Manual.pdf".


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
