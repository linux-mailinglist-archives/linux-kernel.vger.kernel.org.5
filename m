Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477A57CF821
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345579AbjJSME7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjJSMEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:04:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D81BCE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:03:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537CBC433C7;
        Thu, 19 Oct 2023 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697717028;
        bh=7RwRDPja+BFl9I42gPB9G48QdL9q0Wc22SuWBEjhfrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSqk6R0t7Y2nETGpH7m/j95dxlR5uEG7sj/AkGv0RjujwZtpE5racGJ6z03J+Ivyp
         FRyYqp9SN62PNV427KXcQ9l64TMw1qFrMGnVqCW+j1R2Oztqtc3FOB1Dnd9TIGvkn1
         iyMzYLXDKIjaxWLsER1xm3fznuDSSxfrglKoxoo7pc16hpyJFJWrlvOHn6e0Y4Mr4x
         WoE7d6F0VMne7e9R2NGZV7OTGAvYm5H7uK5PuPsSeDaQNMoAgvVWdh/1gqHUVLPEWv
         xuY8kShvwVrXUmjPj1a38GUjK40tBgfCDHEY5f3sA6sqWrUD9Ur51LKxrEQilI70S+
         HcpQM1c2Sp65Q==
Date:   Thu, 19 Oct 2023 13:03:41 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Message-ID: <20231019-repacking-scrunch-f2435c2fd7e8@spud>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KPoA9a73TBHTsk2t"
Content-Disposition: inline
In-Reply-To: <169762516670.391804.7528295251386913602.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KPoA9a73TBHTsk2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 05:32:48AM -0500, Rob Herring wrote:
>=20
> On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:
> > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > a DSA switch node need to have a ports or ethernet-ports
> > subnode, and that is actually required, so add requirements
> > using oneOf.
> >=20
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] wron=
g indentation: expected 8 but found 6 (indentation)
> ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] wron=
g indentation: expected 8 but found 6 (indentation)
>=20
> dtschema/dtc warnings/errors:
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-doc-validate", line 64, in <module>
>     ret |=3D check_doc(f)
>            ^^^^^^^^^^^^
>   File "/usr/local/bin/dt-doc-validate", line 32, in check_doc
>     for error in sorted(dtsch.iter_errors(), key=3Dlambda e: e.linecol):
>                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   File "/usr/local/lib/python3.11/dist-packages/dtschema/schema.py", line=
 125, in iter_errors
>     self.annotate_error(scherr, meta_schema, scherr.schema_path)
>   File "/usr/local/lib/python3.11/dist-packages/dtschema/schema.py", line=
 104, in annotate_error
>     schema =3D schema[p]
>              ~~~~~~^^^
> KeyError: 'type'

Locally, on an older version of dt-schema, I see
/stuff/linux-dt/Documentation/devicetree/bindings/net/dsa/dsa.yaml: $defs: =
'oneOf' should not be valid under {'$ref': '#/definitions/json-schema-prop-=
names'}
	hint: A json-schema keyword was found in $defs key.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/stuff/linux-dt/Documentation/devicetree/bindings/net/dsa/dsa.yaml: $defs:o=
neOf: [{'required': ['ports']}, {'required': ['ethernet-ports']}] is not of=
 type 'object'
	hint: $defs entries must contain schemas
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json

On the latest version I see the error from the bot.

Doing=20
diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documenta=
tion/devicetree/bindings/net/dsa/dsa.yaml
index bd6948e4fd9e..25e5950d51ae 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -55,10 +55,10 @@ $defs:
             $ref: dsa-port.yaml#
             unevaluatedProperties: false
=20
-  oneOf:
-    - required:
-      - ports
-    - required:
-      - ethernet-ports
+oneOf:
+  - required:
+    - ports
+  - required:
+    - ethernet-ports
=20
 ...

resolves both issues, but the older version of dt-schema definitely had
better error reporting in this case!


--KPoA9a73TBHTsk2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTEbHQAKCRB4tDGHoIJi
0pEpAQCU4hd9BQ874qBY0UwVcMAKHvyY/RN4cl/j41XZ9MKAEgD+MkLFIYAED1qk
QbcQNLASFWw6gdEZTkwIvwbJAoBlsA4=
=DneM
-----END PGP SIGNATURE-----

--KPoA9a73TBHTsk2t--
