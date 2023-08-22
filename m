Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7E5783E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjHVKpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHVKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:45:44 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A9FB;
        Tue, 22 Aug 2023 03:45:42 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5E8881C000F; Tue, 22 Aug 2023 12:45:41 +0200 (CEST)
Date:   Tue, 22 Aug 2023 12:45:40 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        "David S . Miller" <davem@davemloft.net>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 4/9] vxlan: generalize vxlan_parse_gpe_hdr
 and remove unused args
Message-ID: <ZOSR1KDjz6Qq2eUa@duo.ucw.cz>
References: <20230813161427.1089101-1-sashal@kernel.org>
 <20230813161427.1089101-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oOsTmPMt7U6WTNng"
Content-Disposition: inline
In-Reply-To: <20230813161427.1089101-4-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oOsTmPMt7U6WTNng
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jiri Benc <jbenc@redhat.com>
>=20
> [ Upstream commit 17a0a64448b568442a101de09575f81ffdc45d15 ]
>=20
> The vxlan_parse_gpe_hdr function extracts the next protocol value from
> the GPE header and marks GPE bits as parsed.
>=20
> In order to be used in the next patch, split the function into protocol
> extraction and bit marking. The bit marking is meaningful only in
> vxlan_rcv; move it directly there.
>=20
> Rename the function to vxlan_parse_gpe_proto to reflect what it now
> does. Remove unused arguments skb and vxflags. Move the function earlier
> in the file to allow it to be called from more places in the next
> patch.

This seems to be a cleanup/preparation for a patch we don't have
queued for 4.14. Please drop.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oOsTmPMt7U6WTNng
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOSR1AAKCRAw5/Bqldv6
8mKhAJ9pUfT+HA5jxPpK61CW88dp4CxlSACaAnSnMayAjI5FG6c2pci1IjKcGy4=
=4ws1
-----END PGP SIGNATURE-----

--oOsTmPMt7U6WTNng--
