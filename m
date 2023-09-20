Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE157A8293
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjITNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236416AbjITNDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:03:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4F128;
        Wed, 20 Sep 2023 06:03:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6BCC433C8;
        Wed, 20 Sep 2023 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695214987;
        bh=mOsDBDIOwfXwaQhf3USDdb3F9JCa//1vBpkpJd55YHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuVcOtjf5E0QnKm5GwYp4/s+Fv8bh/OeBioyoSy25ZJcD2Ci1Uit4uS3skQKjNxk6
         WUNAeGuJVZc4XdcP0jIyMgQk7Z67VkS2Qn86YqPEOSossNMj7qF39W7SX0zE1itOAB
         2j099vpEKgsXcqJU8IrUGEIETl2yuPdYJ6yWFePy95Y0Wa1Yf9LZciCjhUha5Y+p2q
         3AfCPjtwbK5EjsClfF0zhPYKMCsbefBphdptSwAVDEEvyG6u1UqZvTOq+tdo6AlKiW
         EsZa3GnYXFKxjzTGZsPr/DaPQp8W3JKhvWCbwJZzPLfAv7PTPC0Jrvg4+EoGYAm951
         tzAdBmQsLF6iw==
Date:   Wed, 20 Sep 2023 14:03:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Message-ID: <20230920-53a04651c08acb0796dc63b4@fedora>
References: <20230920-untimely-untagged-12b75e247afb@wendy>
 <IA1PR20MB495313B7E9B2FC529BE0BB2ABBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fHzTHLymqgiKnOlw"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495313B7E9B2FC529BE0BB2ABBF9A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fHzTHLymqgiKnOlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 07:24:21PM +0800, Inochi Amaoto wrote:
> >
> >Yo,
> >
> >On Wed, Sep 20, 2023 at 05:08:41PM +0800, Inochi Amaoto wrote:
> >>> On Wed, Sep 20, 2023 at 02:39:39PM +0800, Chen Wang wrote:
> >>>> From: Inochi Amaoto <inochiama@outlook.com>
> >>>>
> >>>> Add two new compatible string formatted like `C9xx-clint-xxx` to ide=
ntify
> >>>> the timer and ipi device separately, and do not allow c900-clint as =
the
> >>>> fallback to avoid conflict.
> >>>>
> >>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >>>> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> >>>
> >>> Have you ignored Krzysztof's comments on this? I don't see a response=
 or
> >>> a reaction to his comments about the compatibles on the last version.
> >>> Additionally, where is the user for these? I don't see any drivers th=
at
> >>> actually make use of these.
> >>>
> >>
> >> Sorry for late reply and wrong message-id.
> >>
> >> The clint is parsed by sbi.
> >
> >That needs to go in the commit message.
>=20
> Yes, it will.

Thanks.

> >> As use the same compatible, the opensbi will
> >> parse the device twice. This will cause a fault.
> >
> >Then only have one compatible with 2 register ranges? Then your SBI
> >implementation can use those two register ranges to find out the base
> >address for the mtimer bits and for the mswi bits.
> >I don't understand why this cannot be done, could you please explain.
>=20
> That is a good idea, but now SBI use the second register ranges as
> mtimecmp address for aclint. And there is a aclint-mswi in the SBI.
> Maybe a change is needed?

Yeah, I don't think the model for this in OpenSBI at the moment (and
since I checked, in QEMU too) is correct. I think we should re-do things
correctly and it'd be great if things didn't get merged to those
projects that end up being objected to by dt-binding people.
I've started keeping a closer eye on QEMU recently in that regard, but I
am not super attentive. I'll try to be better at that going forward!

>=20
> >I also don't see anything in the opensbi repo right now that is using
> >these (nor could I easily see any patches for opensbi adding this).
> >Is there another SBI implementation that you are using that I can take
> >a look at to try and understand this better?
> >
>=20
> This will be sumbit in a short time.
> Now we only use it is sophgo vendor SBI, which url is [1].
>=20
> [1] https://github.com/sophgo/opensbi

Thanks.

> >>> Why do you need to have 2 compatibles (and therefore 2 devices) for t=
he
> >>> clint? I thought the clint was a single device, of which the mtimer a=
nd
> >>> mswi bits were just "features"? Having split register ranges isn't a
> >>> reason to have two compatibles, so I must be missing something here...
> >
> >> Sorry for late reply, The clint consists of mtimer and ipi devices, wh=
ich
> >> is defined in [1].
> >
> >Yes, I have looked at the spec. I went to check it again before replying
> >here in case there was something immediately obvious that I was missing.
> >
>=20
> I think nothing missed.
>=20
> >> This standard shows clint(or the aclint) has two device,
> >
> >The wording used here doesn't really matter. It's one interrupt
> >controller that does mtimer and mswi.
> >
> >> but not one. In another word, there is no need to defined mtimer and i=
pi
> >> device on the same base address.
> >
> >There's also no need to have two compatibles for the same interrupt
> >controller, so I do not get this reasoning. What actually _requires_
> >them to be split?
> >
>=20
> Yes, it is one, but can be mapped into different address. So I think we
> need two.

Not two compatibles though, just two memory addresses that you need to
locate (or maybe even 3, for SSWI?)

>=20
> >> So we need two compatibles to allow sbi to identify them correctly.
> >
> >Why is it not sufficient to identify the individual memory regions?
> >
>=20
> FYI, Anup. As I have no idea for aclint implementation.
>=20
> >Thanks,
> >Conor.
> >

--fHzTHLymqgiKnOlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQrtgQAKCRB4tDGHoIJi
0sH4AP9aPXJ2MxGFLtqJMN8gdZXDTRRPiXRkMYqGcMxe9DXbQwD/YgQh6XCaTtVs
o6MGOLBVFZ6PY7rSGjPa2yPRN3KiPAc=
=c3Dp
-----END PGP SIGNATURE-----

--fHzTHLymqgiKnOlw--
