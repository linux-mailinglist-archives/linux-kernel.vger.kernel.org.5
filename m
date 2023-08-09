Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE38776421
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjHIPj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjHIPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EEE211C;
        Wed,  9 Aug 2023 08:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BEBA63EE4;
        Wed,  9 Aug 2023 15:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C72C433C7;
        Wed,  9 Aug 2023 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691595570;
        bh=ZN+Ph02j0blvyY6VRiCcTlHg1lDxH5//uAa9haCbAn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0MzQOFzaKje3rSd1sMFSE1kApBZCzLB8I2z0MbQK+v/GUrlpsqiQjqi+xSnExklK
         hQM+06ieQ+JBEv/MhCR02KZbqQPtc0jNLt+qnangDl1IihkMA4ymCsnS8lE1sia4eX
         OFBqlgq/O2RGSgpaa8bGA0+pVDpm8wQQzStXZhSu63ZdO4N7OxTYIUajdURgwKXQv2
         AMXeLFGwS192JLeKX1paG5pWcwrdKCTY50kF9iu9t/WZuc49OOE/eyex/soOi6Hs4D
         RhtqbijCKALv6khgCE3zzk1D8roP8Mxms7RHmtWAbVu9JMdz69IjKL15wGn99BEDyw
         84nb+hYMMvFxQ==
Date:   Wed, 9 Aug 2023 16:39:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Message-ID: <20230809-circus-photo-6911d2e18f96@spud>
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
 <20230808-amount-urban-9a6eb09852ca@spud>
 <536a9062-65b2-5518-5c50-1a61e23870ee@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VXgqk7woHVK+3S1c"
Content-Disposition: inline
In-Reply-To: <536a9062-65b2-5518-5c50-1a61e23870ee@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VXgqk7woHVK+3S1c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 03:47:55PM +0800, Yinbo Zhu wrote:
> =E5=9C=A8 2023/8/8 =E4=B8=8B=E5=8D=888:05, Conor Dooley =E5=86=99=E9=81=
=93:
> > On Mon, Aug 07, 2023 at 03:40:42PM +0800, Yinbo Zhu wrote:

> > > +  loongson,gpio-ctrl-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      This option indicate this GPIO control mode, where '0' represe=
nts
> > > +      bit control mode and '1' represents byte control mode.
> >=20
> > How is one supposed to know which of these modes to use?
>=20
>=20
> Byte mode is to access by byte, such as gpio3, the base address of the
> gpio controller is offset by 3 bytes as the access address of gpio3.
>=20
> The bit mode is the normal mode that like other platform gpio and it is
> to access by bit.
>=20
> If both modes are supported, it is recommended to prioritize using byte
> mode that according to spec.

So, sounds like this property should instead be a boolean that notes
whether the hardware supports the mode or not, rather than the current
enum used to determine software policy.

However, from Krzysztof's comments & my own feeling, it really does seem
like you should drop the do-everything compatible and introduce things
that are soc-specific.

--VXgqk7woHVK+3S1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNOzLQAKCRB4tDGHoIJi
0gKZAPwMObBwfQu8x9fheCqfaLGcTVE9kP/GlXm+nZ+WkYpRAAEA/fvnRYxDaHud
NkKpJyX9yzzr+jgHCWeKNA/w/9hz6QQ=
=8LUU
-----END PGP SIGNATURE-----

--VXgqk7woHVK+3S1c--
