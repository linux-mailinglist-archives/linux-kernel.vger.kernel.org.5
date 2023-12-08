Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0BB80AD9B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjLHUQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:16:14 -0500
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A024123;
        Fri,  8 Dec 2023 12:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1702066573;
        bh=7zDeKbPJAl8AvhFTIblAERkOHIfqFDPfl1Vqvi+CM28=;
        h=Date:From:Cc:Subject:From;
        b=W+X9ycCPgPivkQ0xTjz3ETf8qpk/Cxu4J6Vg2JQhBpjRmP1lNSkZf4BPBtvnQbwDY
         Royly5AZaJXiyGhGbVwk3ETPaZrGvxf2j/Oo+qJ8G7fkNhnFATOatdA+lIlF4JN44H
         1/j7sAR4xw2ltYDjdQ29EeF0Q2NCaMWqSoOBqB3o5L+1MQXYtzDmoDvjueczP4rZv9
         0JSWbPGrGjvz5GY9/lkGLW/L/yMUjn1U6PxwPTToEFdroBY5RYp/rwnL8pnk4zDVGh
         3lFVWURv+VeRo323GYjXILeFN8K5VjVsCbAnXD70Xu379ozRzmOxZ1L0+DHay4S1CG
         u+SpOkmV10qQw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 0971C12FD2;
        Fri,  8 Dec 2023 21:16:13 +0100 (CET)
Date:   Fri, 8 Dec 2023 21:16:12 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: dns_resolver: the module is called dns_resolver, not
 dnsresolver
Message-ID: <gh4sxphjxbo56n2spgmc66vtazyxgiehpmv5f2gkvgicy6f4rs@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4764cojxptaryfum"
Content-Disposition: inline
User-Agent: NeoMutt/20231103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4764cojxptaryfum
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

$ modinfo dnsresolver dns_resolver | grep name
modinfo: ERROR: Module dnsresolver not found.
filename: /lib/modules/6.1.0-9-amd64/kernel/net/dns_resolver/dns_resolver.ko
name:     dns_resolver

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 net/dns_resolver/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dns_resolver/Kconfig b/net/dns_resolver/Kconfig
index 155b06163409..7c2dba273e35 100644
--- a/net/dns_resolver/Kconfig
+++ b/net/dns_resolver/Kconfig
@@ -23,6 +23,6 @@ config DNS_RESOLVER
 	  information.
=20
 	  To compile this as a module, choose M here: the module will be called
-	  dnsresolver.
+	  dns_resolver.
=20
 	  If unsure, say N.
--=20
2.39.2

--4764cojxptaryfum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmVzeYwACgkQvP0LAY0m
WPGq3Q//Yj2fnDiiF2TEh3GLe/6/OTPVutSLxCXYS3p2Ii+rrwqnxji/CxWMYvTi
DqSlbAncQ1TAMuPfPSvUxf/e04vWHF8rcyPSck3ZKvlILLmai2O62iENbUx2Cchq
UkjZ2vjCmWQoI6B7L7tI9p6vwQaL+XzuHHIKR186ip+vAFak+bs26kZe4J39l7XH
AjXpbzpNXvNRqZXRxi8utCkpG2mBPejFq+I2YllXp3SHYZ07bipq49tOvKJBqlY3
yl0M2DrIgmPTHN+KNgTid35SJ0gfo1TMmwCy2JXSY1jDKBrTFpo1S3KDREcm04MY
B6Dipsz6x8OGvHiY1s0Iis/Wxm+gl203IaelAVBrpe2A/eepYyWIzI/tCth7RxgY
ZzVakkOnvhAu9PlUXJaHcMTrazBs86stc11zoOyo/TlHICBPMb1vT8P6IPncszRQ
HDpDep9uufgtjkmgbEwy5wGOeSGsEvBlXRc70aQ3KWuOeOt5Y8uoPTR5TP/hFjBe
OQ9bzg7a6nK9+VC/hTdiZeFa2dtvKnU6U4eONefHvoKtHwy6YEONZ+AXi76ReQ+j
T5OEBT8TPMMPEmVws3KJctF+d3okdPKOJ3HvL2wuuBTG+6QN/mzfuqDY8E/VNMRy
FHGxrbeLozJQbnZLhRD9mKMHF/9BZ9EHPj/ee3md0CPPOFfkTCQ=
=KQCC
-----END PGP SIGNATURE-----

--4764cojxptaryfum--
