Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91C8805B60
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjLEQlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLEQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:41:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D5D197
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:41:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2540C433C8;
        Tue,  5 Dec 2023 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701794502;
        bh=7gPvTvewOLYQNm6H9vhHB2NPFfXXl0A8Iq7cfPwQivU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8r8CH2wNSFGCbhl+A9QSDbuA2BjoZh332npyGfbLI/Xm9ItOrW8syvIgeDTlZ1q5
         wLf7hB/9KqXbzM5nA7Ed4L3Eaxd58OUSMd9V6Owkh/I0PD5JGgcvFnXxdd45TWB45N
         dZHNx1v8l2qarIZEqlOvnS6zv92XbrLUBhRP8cnBQ6C8e/tll68GcLBnYDvJHZCBHH
         /tITBhqqE/+NntvMtsIVPyI1cRyp88XUnMpeq77USqcR2rq3+I+QZlAtDFZio8240f
         MED/YK/ypi+zoWyRR8CJxZSfYIGVO+dV0CfVh28+NT+GbGpdOt5KHr+teW873ceATp
         r6/4OwfhZMJvw==
Date:   Tue, 5 Dec 2023 16:41:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-fsd@tesla.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: samsung: continued - add specific
 compatibles for Tesla FSD Hi,
Message-ID: <20231205-outnumber-yelp-dafb6ace186e@spud>
References: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C3JOgYS3s1TAhdme"
Content-Disposition: inline
In-Reply-To: <20231205092229.19135-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C3JOgYS3s1TAhdme
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 10:22:23AM +0100, Krzysztof Kozlowski wrote:
> Merging
> =3D=3D=3D=3D=3D=3D=3D
> I propose to take entire patchset through my tree (Samsung SoC), because:
> 1. I already took similar work this cycle:
>    https://lore.kernel.org/all/169997520487.6747.17671551558724027958.b4-=
ty@linaro.org/
> 2. Two new SoCs are coming (Google GS101 and ExynosAutov920) and they mig=
ht
>    touch the same lines.  It is reasonable for me to take the bindings fo=
r the new
>    SoCs, to have clean `make dtbs_check` on the new DTS.
> 3. Having it together helps me to have clean `make dtbs_check` within my =
tree
>    on the existing DTS.
> 4. No drivers are affected by this change.
>=20
> If folks agree, please kindly Ack the patches.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--C3JOgYS3s1TAhdme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW9SvwAKCRB4tDGHoIJi
0rShAP9wrpk6xlyay96Xfkv7prBahXUjkK/0KUi1p6lsWcoq7gEA09NZdE4qyxo8
SFwP9y3wxxh6dsTeHbeIUJ6yL4EpOgs=
=wgER
-----END PGP SIGNATURE-----

--C3JOgYS3s1TAhdme--
