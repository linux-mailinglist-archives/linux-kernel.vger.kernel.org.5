Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8C7C594F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjJKQiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjJKQiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:38:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D7191;
        Wed, 11 Oct 2023 09:38:11 -0700 (PDT)
Received: from mercury (dyndsl-091-248-188-112.ewe-ip-backbone.de [91.248.188.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C288F66072FC;
        Wed, 11 Oct 2023 17:38:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697042289;
        bh=6d+YP9X/mScC8F/S9P2hzPpSwGEPT+aRLtDeURjMSr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RtHw85TNMbkmXfqXyWSfB7GQizo2HD+Wjg0BBmntlPqVS091gimpCtA2YAabAQ5fG
         KxwBmXlJwP8HxDxMwAw9lqOPF1qmNeCUdv4XDGvL2JPBQnj9VkYp0HvpEroQZlAnil
         0+JyUGmPoXi7KdtoJ58Z7382buA30UUwDex064FQOQICJR1zOgNbNmKo7ENahu9Yi8
         FsEnz20EC2TwSCqb9OcdPWZK2CAeg+PDESP3mzm0ZmNs+c5mxFrI61OzwX60DoV5SB
         m+R1rtK0ZY/RRqFLvvB9ocs34y5fHAmZVfWsii/5na6cFl+kbF4P6h1pQwWZAmRz9N
         cLzjkJpDwUqIQ==
Received: by mercury (Postfix, from userid 1000)
        id 9447510609A6; Wed, 11 Oct 2023 18:38:07 +0200 (CEST)
Date:   Wed, 11 Oct 2023 18:38:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Add support for poweroff via RK806 PMIC
Message-ID: <20231011163807.tmouszvx7oahvzld@mercury.elektranox.org>
References: <20231010174138.1888396-1-megi@xff.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7tyk6joawtz5bvah"
Content-Disposition: inline
In-Reply-To: <20231010174138.1888396-1-megi@xff.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7tyk6joawtz5bvah
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 10, 2023 at 07:41:15PM +0200, Ond=C5=99ej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
>=20
> The PMIC supports powering off by twiddling some bits in a register. Add =
support
> for it via pre-existing rockchip,system-power-controller DT property.
>=20
> The series was tested against Linux 6.6-rc4.
>=20
> Please take a look.
>=20
> Thank you,
> 	Ond=C5=99ej Jirman
>=20
> v3:
> - use system-power-controller
> - deprecate rockchip,system-power-controller
> v2:
> - add a missing driver patch
>=20
> Ondrej Jirman (4):
>   dt-bindings: mfd: rk8xx: Deprecate rockchip,system-power-controller
>   dt-bindings: mfd: rk806: Allow system-power-controller property
>   mfd: rk8xx: Add support for standard system-power-controller property
>   mfd: rk8xx: Add support for RK806 power off
>=20
>  Documentation/devicetree/bindings/mfd/rockchip,rk805.yaml | 3 +++
>  Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml | 2 ++
>  Documentation/devicetree/bindings/mfd/rockchip,rk808.yaml | 3 +++
>  Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml | 3 +++
>  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 3 +++
>  Documentation/devicetree/bindings/mfd/rockchip,rk818.yaml | 3 +++
>  drivers/mfd/rk8xx-core.c                                  | 7 ++++++-
>  7 files changed, 23 insertions(+), 1 deletion(-)

The series is

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks,

-- Sebastian

--7tyk6joawtz5bvah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUmz2cACgkQ2O7X88g7
+poFMRAAiPJHXDicrEuNY5pm9aZCmEOfySeJUpAc0zVkbifdO+xNi/QQX/lURhxw
vRLnIIDVpy07GyfgfqEVNG9lt/0ImdtUIGzkmzlmZ46zRTqXad0oeM1LLoDyO2g5
JFJmm3paUauIqNC9uN+PuapzQIYRuxSswiwcoynwwOa2ZVmOIpUkHXiic3d5IBMt
PG8q2OIG80wtwDq6HFqDpvN89uhKG8Cd0vNS+YEYGmqAnsPmcbS1Y6BltBQ36RIU
o2Y27CxhwZ0VDoCjngo3b1wt8lq3FYgd/vVfhDovqGmBm3IVZIFeF6uEd0BY20sl
x3xAdNzRNvLxhOZcCro4Co08frGxjHktpflunVPVdHTpF78wxZ+WDc7zsZAc2jHE
sxJBhgHtRXO7Z7cTvh9tYxkem9pPHebcGo1ZoLKowqcwJm4EUV84r4DkZ2blcQhZ
S7aIgO6+KqgDw01DaTjX7K6gC6mnlK3sgWrbN6Ajl+IGLaU7GudtHL7YMdiPMQxN
lG/n9jMEQLSCQcl03jZk3V0wg+Zp8KXda4JUHR0xl9xJPbuhiifEEukPfz+4m8se
D1cDO5Jwz+3wdgi9g3JqZTZrm+gHecdah5x9QPCnBbguqbi2z/0pVweQFxhHQDkJ
47RnEsD44dgrF3g/xmpfjlwShXEkGekmEhCjKOj5QYYLyoXV0t4=
=D+Qq
-----END PGP SIGNATURE-----

--7tyk6joawtz5bvah--
