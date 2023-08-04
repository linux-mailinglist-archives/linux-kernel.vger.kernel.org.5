Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D198A770ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHDVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjHDVXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6FE46;
        Fri,  4 Aug 2023 14:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D122A62080;
        Fri,  4 Aug 2023 21:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ECCC433C8;
        Fri,  4 Aug 2023 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691184194;
        bh=wSJaIZhISXirDF3jgfh6c4FcH0NgVKh0TCqvHAGh65w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URoiX2yLiohhGg12ok9xl78D8VS2pzkNBU1EEqlq/Ic3ryb6t1MWOIUqba3NCnhYt
         OH5PKq3KKKnRVIBxJXiJ/2omxYEFOdOignvj1G7ET1h0h6no15MoOpjzXTvsBRva9x
         G3VouXbTLLUnB7vNVx2mjOccE17wWjtLcJWd7sweMEarnaVI0PEfkk8io74l/mm40N
         n/YraTBugIhzYzmdh7U2z0oxY3Pj5MXSwD4ZoIUShMAlCArM4AiNmyHXRenXazNBMG
         2Mnfwnb7LSXxXdssCh4CoFwBtgNqdSM/9SyjCglOgMbtfbtkcU+85WbggsPCJVGqLR
         79g23ErXr1rfQ==
Date:   Fri, 4 Aug 2023 22:23:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Ivan Mikhaylov <fr0st61te@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Po-Yu Chuang <ratbert@faraday-tech.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: net: ftgmac100: convert to yaml version
 from txt
Message-ID: <20230804-doorman-overdress-b1ea7393740e@spud>
References: <20230731074426.4653-1-fr0st61te@gmail.com>
 <20230804132034.4561f9d7@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0xRaSzT8JWffNfAv"
Content-Disposition: inline
In-Reply-To: <20230804132034.4561f9d7@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0xRaSzT8JWffNfAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 01:20:34PM -0700, Jakub Kicinski wrote:
> CC: Conor=20
>=20
> in case the missing CC is the reason for higher than usual=20
> review latency :)

You even CCed the +dt address so the mail ended up in the right place!
I doubt not having me on CC is the reason for the delay, seems to be a
pattern that the conversion patches end up being Rob's to look at. I at
least find them more difficult to review than new bindings.

It looks like Rob's comments on v(N-1) were resolved, but something here
looks odd to me.

> > +  clocks:
> > +    minItems: 1
> > +    items:
> > +      - description: MAC IP clock
> > +      - description: RMII RCLK gate for AST2500/2600
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    contains:
> > +      enum:
> > +        - MACCLK
> > +        - RCLK

I don't really understand the pattern being used here.

> > -- clocks: In accordance with the generic clock bindings. Must describe=
 the MAC
> > -  IP clock, and optionally an RMII RCLK gate for the AST2500/AST2600. =
The
> > -  required MAC clock must be the first cell.

The order in the original binding was strict & the MAC clock had to come
first. What's in the new yaml one is more permissive & I think it should
be

  clock-names:
    minItems: 1
    items:
      - const: MACCLK
      - const: RCLK

unless of course I am missing something that is...

> > -- clock-names:
> > -
> > -      - "MACCLK": The MAC IP clock
> > -      - "RCLK": Clock gate for the RMII RCLK

--0xRaSzT8JWffNfAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZM1sPAAKCRB4tDGHoIJi
0rENAQD1vKcQgnhP6Ln+CWJv1wWzBmj3uPwvjHn2kG1gX4N5ngD+NbxpzHQUm8o2
ckkj4vJWvILJx7q/JO4+08b2JRrsUQo=
=DyLQ
-----END PGP SIGNATURE-----

--0xRaSzT8JWffNfAv--
