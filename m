Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF32576A9E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjHAHXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjHAHXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F84F1;
        Tue,  1 Aug 2023 00:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 280FC614A5;
        Tue,  1 Aug 2023 07:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE78C433C7;
        Tue,  1 Aug 2023 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690874608;
        bh=my0GemI44LTxXtgO6hNse1vYl0rMa6dnpGwJk5pWK3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAKmBefzRiBaU9azLIvQfXwVYN3M4+4VWZ8D0e06hyy+vkOB1daCRKnFIiOZgD32J
         xM1WG8lXR/Xq40OF9Yg0fN9/hYo5aGBvZAyLiHmJDnfDxLeVnrMHhiDoF5waDZMEx/
         U9Lg19eUALIQD7FF2esG5p7A42ROnBFYartmhnZuw9BIhxO9wvnpClSrBDZU+5AjIz
         YMaVinulR/WQc+fldcJl0guPA/VUsv6uXl75VHRZD745dysKPK+aFkHQEzDg45/4/A
         kY8hyjxb3vj5ebgY+lTlm9O6r/wFP62jAxLB5kR1i3yIbctJTmY9s+sWr9MmJpj8kC
         qnMzaaRFY4WqQ==
Date:   Tue, 1 Aug 2023 08:23:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Message-ID: <20230801-whenever-imitation-b2759b212f6b@spud>
References: <20230731091059.17323-1-zhuyinbo@loongson.cn>
 <20230731091059.17323-2-zhuyinbo@loongson.cn>
 <20230731-setback-such-61815ee3ef51@spud>
 <041bf8a6-8d91-c2ce-6752-aa7255f946c7@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iYDJfgIGL+4ugo0v"
Content-Disposition: inline
In-Reply-To: <041bf8a6-8d91-c2ce-6752-aa7255f946c7@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iYDJfgIGL+4ugo0v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 02:39:49PM +0800, Yinbo Zhu wrote:
>=20
>=20
> =E5=9C=A8 2023/7/31 =E4=B8=8B=E5=8D=8811:55, Conor Dooley =E5=86=99=E9=81=
=93:
> > On Mon, Jul 31, 2023 at 05:10:58PM +0800, Yinbo Zhu wrote:
> > > Add parsing GPIO configure, input, output, interrupt register offset
> > > address and GPIO control mode support.
> >=20
> > This reeks of insufficient use of SoC specific compatibles. Do GPIO
> > controllers on the same SoC have different register offsets?
>=20
>=20
> Yes,
>=20
> > Where are the users for this?
>=20
>=20
> For example, ls2k500 contains multiple GPIO chips with different
> (configure, input, output, interrupt) offset addresses, but all others
> are the same.

Right. That's admittedly not what I expected to hear! Can you firstly
explain this in the commit message, and secondly add a soc-specific
compatible for the ls2k500 and only allow these properties on that SoC?

Thanks,
Conor.

--iYDJfgIGL+4ugo0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMiy6wAKCRB4tDGHoIJi
0vYgAQDuI7jEA+b9JDDSxFjsDMHi6wYg8nQNezU0dgANbuO6hgEAz0hN9trOiPv5
d00AEqnFcc0GjrDjpqmiiZOz8i27tgk=
=Zar6
-----END PGP SIGNATURE-----

--iYDJfgIGL+4ugo0v--
