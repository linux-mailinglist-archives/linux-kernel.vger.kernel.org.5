Return-Path: <linux-kernel+bounces-3861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD881741A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E0C1F21833
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E93787B;
	Mon, 18 Dec 2023 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXcytq6h"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6017E200A4;
	Mon, 18 Dec 2023 14:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16B1C433C8;
	Mon, 18 Dec 2023 14:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702910872;
	bh=1Ejc3DTMkoqF39XaGz2sEGxnABT4TjgOb+bh3SkctYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXcytq6h9tCH/7HvVzZRCLC/z6pQGJLUIHrtngZCWYCOt54aLS9VexxGok7fLlRRd
	 qB5H3/QFz1eytjNp0CEIcvpXUXg1TkqGVsYtJAzzw7espS8tqc0flDyu0fjgrLsYU1
	 qwjVDnglnEoVW7co7iMsIUVg4DSsFX9S3WHSL26SMG0HrOnfvB1CaOW6XZgM7xPRra
	 ZXHqeoU6SZEAGYffZW6Yn1sHP24se3KJJq9Z2x84WSUhwvJjvmNCBVOH9/ID+AaFtO
	 UnmHDBJJfsTNhxsNcWtoSrC7u5STsDsogDuXxu5zSq73N55LK9bElkoRotmyhKuA3a
	 i4i38sM2MTf3A==
Date: Mon, 18 Dec 2023 14:47:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/2] dt-bindings: display: Add SSD133x OLED controllers
Message-ID: <20231218-example-envision-b41ca8efa251@spud>
References: <20231218132045.2066576-1-javierm@redhat.com>
 <20231218132045.2066576-2-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QqzxdS1EmQ01CbaQ"
Content-Disposition: inline
In-Reply-To: <20231218132045.2066576-2-javierm@redhat.com>


--QqzxdS1EmQ01CbaQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 02:20:35PM +0100, Javier Martinez Canillas wrote:
> Add a Device Tree binding schema for the OLED panels based on the
> Solomon SSD133x family of controllers.
>=20
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
> Changes in v2:
> - Unconditionally set the width and height constraints (Conor Dooley).
> - Fix indentation in the DTS examples (Krzysztof Kozlowski).
>=20
>  .../bindings/display/solomon,ssd133x.yaml     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd=
133x.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd133x.ya=
ml b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
> new file mode 100644
> index 000000000000..8feee9eef0fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/solomon,ssd133x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Solomon SSD133x OLED Display Controllers
> +
> +maintainers:
> +  - Javier Martinez Canillas <javierm@redhat.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - solomon,ssd1331
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: solomon,ssd-common.yaml#
> +
> +  - properties:
> +      width:
> +        default: 96
> +      height:
> +        default: 64

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml=
 b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
index 8feee9eef0fd..ffc939c782eb 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd133x.yaml
@@ -9,24 +9,24 @@ title: Solomon SSD133x OLED Display Controllers
 maintainers:
   - Javier Martinez Canillas <javierm@redhat.com>
=20
+allOf:
+  - $ref: solomon,ssd-common.yaml#
+
 properties:
   compatible:
     enum:
       - solomon,ssd1331
=20
+  width:
+    default: 96
+
+  height:
+    default: 64
+
 required:
   - compatible
   - reg
=20
-allOf:
-  - $ref: solomon,ssd-common.yaml#
-
-  - properties:
-      width:
-        default: 96
-      height:
-        default: 64
-
 unevaluatedProperties: false
=20
 examples:

The properties stuff doesn't need to be in the allOf. Although, I took
the opportunity to look at ssd-common.yaml. How do the height/width here
differ from the vendor prefixed versions in that file?

--QqzxdS1EmQ01CbaQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYBbgAAKCRB4tDGHoIJi
0nUWAP47tXmu50as8MLPe0wyFtLmpL2ScU7fl+agMnc8GU2sEwEAjVkZfObf4dO6
6QrCJ+/muSgOHjoVmG3AKNOOkz9xDAU=
=YGWG
-----END PGP SIGNATURE-----

--QqzxdS1EmQ01CbaQ--

