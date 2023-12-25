Return-Path: <linux-kernel+bounces-11078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC3E81E10F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99A8EB216F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA7524D1;
	Mon, 25 Dec 2023 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="IurqDHOf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20776524B5;
	Mon, 25 Dec 2023 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 055ED28B50B;
	Mon, 25 Dec 2023 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703512726;
	bh=n+bNKbNXfb2/4bdVR7HNYVml4Ep7meCB7jriTPNkfqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IurqDHOfIfSdXBt+kMMWz+tt0arerRhzSNoRDCrwcdfVFdIwiNhSES/Svbx3bcTNP
	 w6JA9qJGLhQCOaxt48zR9szieiq5Zvx3JIFmyJv4Qac0QPS7hsj/cl+r6SHCJH0pOw
	 Ao5FWNxlR9hs/aGHqN/rGnX+Qic0+2EAtDzpyOu0=
Date: Mon, 25 Dec 2023 15:58:44 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 02/10] dt-bindings: iio: pressure:
 honeywell,mprls0025pa.yaml add pressure-triplet
Message-ID: <ZYmKlJRrhonht4Zx@sunspire>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-3-petre.rodan@subdimension.ro>
 <49525adf-1540-4801-8cdf-be1c0fe640f6@linaro.org>
 <ZYmCOVvgcElnxRuH@sunspire>
 <503bc876-59d1-4fcb-b0b5-2dd88c62987c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8eqye/wz0y0EfH/9"
Content-Disposition: inline
In-Reply-To: <503bc876-59d1-4fcb-b0b5-2dd88c62987c@linaro.org>


--8eqye/wz0y0EfH/9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello,

On Mon, Dec 25, 2023 at 02:34:04PM +0100, Krzysztof Kozlowski wrote:
> On 25/12/2023 14:23, Petre Rodan wrote:
> > honeywell,transfer-function:
> > [..]
> > honeywell,pressure-triplet:
> > [..]
> > honeywell,pmin-pascal:
> > [..]
> > honeywell,pmax-pascal:
> > [..]
> >=20
> > since the last 3 are tied together as we will see below.
> > is there any reason you want this order to change?
>=20
> I just don't get why moving the code instead of adding new property next
> to them.

as I also said in the comments and in my last reply I want the user to not =
feel
in any way obliged to fill in pmin-pascal, pmax-pascal.
and since a user reads this file from top to bottom, the order in which the=
se
properties are shown to him is important, and it is the one above.

> The order is often alphabetical.

can we please make an exception?

> >>> +  honeywell,pmin-pascal:
> >>> +    description:
> >>> +      Minimum pressure value the sensor can measure in pascal.
> >>> +      To be specified only if honeywell,pressure-triplet is not set.
> >>
> >> The last sentence is redundant - schema should enforce that.
> >=20
> > when someone generates the dtbo files via
> >=20
> > cpp -nostdinc -I include -I ${LINUX_SRC}/include/ -I arch -undef -x ass=
embler-with-cpp ${file}.dts "${BUILD_DIR}/${file}.dts.preprocessed"
> > dtc -@ -I dts -O dtb -o "${BUILD_DIR}/${file}.dtbo" "${BUILD_DIR}/${fil=
e}.dts.preprocessed"
>=20
> And how this command matters? DT overlays are checked, so error is printe=
d.
>=20
> >=20
> > the schema is not checked in any way.
>=20
> When I run `make` the schema is also not checked, so is it an argument
> to add anything to the binding? No. Drop redundant text.
>=20
> > so unless people can be bothered to understand the yaml intricacies in =
the
> > bindings file, I feel they need to see that redundant information there=
, see below.
>=20
>=20
>=20
> >=20
> >>> +oneOf:
> >>> +  - required:
> >>> +      - honeywell,pmin-pascal
> >>> +      - honeywell,pmax-pascal
> >>> +  - required:
> >>> +      - honeywell,pressure-triplet
> >>> +
> >>> +allOf:
> >>> +  - if:
> >>> +      required:
> >>> +        - honeywell,pressure-triplet
> >>> +    then:
> >>> +      properties:
> >>> +        honeywell,pmin-pascal: false
> >>> +        honeywell,pmax-pascal: false
> >>
> >> This allOf is not needed.
> >=20
> > speaking for intricacies, if the allOf is removed, then a binding conta=
ining
> >=20
> > honeywell,pmax-pascal =3D <840000>;
> > honeywell,pressure-triplet =3D "0015PA";
> >=20
> > would be considered to be correct by the schema, but that would be the =
incorrect
> > result. so afaict allOf needs to stay, and so does the redundant text.
>=20
> Really? Did you test it?

for more hours than I would have liked. the allOf was provided with kindnes=
s by
Conor in my first revision.

testing it:
 1. invalid yaml with both honeywell,pmax-pascal and honeywell,pressure-tri=
plet
 defined passes the schema check if the allOf is removed:

 # make DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/iio/pressure/ho=
neywell,mprls0025pa.yaml  DT_CHECKER_FLAGS=3D-m dt_binding_check
 # echo $?
0

 2. the same invalid yaml but with the allOf not removed issues this output:

 [..]/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.=
example.dtb: pressure@18: honeywell,pmax-pascal: False schema does not allo=
w [[84000]]
         from schema $id: http://devicetree.org/schemas/iio/pressure/honeyw=
ell,mprls0025pa.yaml#

which is the expected behaviour. so AFAICT the allOf block is required, as =
well
as the redundant text for the humans that read the human-readable parts of =
the
bindings file.

invalid yaml example used above:

    #include <dt-bindings/gpio/gpio.h>
    #include <dt-bindings/interrupt-controller/irq.h>
    i2c {
        #address-cells =3D <1>;
        #size-cells =3D <0>;

        pressure@18 {
            compatible =3D "honeywell,mprls0025pa";
            reg =3D <0x18>;
            reset-gpios =3D <&gpio3 19 GPIO_ACTIVE_HIGH>;
            interrupt-parent =3D <&gpio3>;
            interrupts =3D <21 IRQ_TYPE_EDGE_RISING>;

            honeywell,pmax-pascal =3D <84000>;
            honeywell,pressure-triplet =3D "0025PA";
            honeywell,transfer-function =3D <1>;
            vdd-supply =3D <&vcc_3v3>;
        };
    };

best regards,
peter

--8eqye/wz0y0EfH/9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWJipQACgkQzyaZmYRO
fzB7xQ/+P2RrKV2a9LIob6nXbDg842zpZXDQI2ctFUjpI+yy1HKlwoDaxo0Siccq
zeikZ5CIlAC2tLTWUrHuH2iWvur2Aqp1HLDpAbXX/LI+itBSOGJ32GXf8yV2DlJ3
YQlUQGBXKnEvu6kncDrQzjdVJlKgm/JxPx0tMqv/NXiuypyxh6by+DvTBih3/pyF
LegHEdJbD8rk3cwrFY3TbU4I0xoIi/xnukh53RM8fcscsRoWxHxRwKvscI3XcLfU
1LLiMbxjeYxmtltlD22CL3h6kjAp3FB102XpvZcsCuNQ3YZ9Gxl/c8J2Uso4i79z
OSV73Q3PdXVidE+eX6e+3Sql5h8yjxn9efhGEAzO/2NE6d1WaXgzS04O7TelalKs
WF6g4FXlkcFjEWbj61kHQ5eHA4z1hg5kRZCGC91uLIDJs06kHJpxy9Eb9H4aZJC+
RuhsYdx4TqqUM7qQM+JrSm9edCR/6oGM3j/OxEZ7DaI+CjBUO85FAVtQZ6WSX62+
mNXdGvuVUumH5Xskg7XlJ1usFBb8XYBul8TzrilIWaxVOGo9ohVlNCyFD4rlY2+T
7bB/ZoBR8V0lvMEoqqnYK4wnQKnjEexXGMa/P5JFzb3NArJYGLF2XAUTuzLK2cyf
+yim3kYeIrjQi+kgUYAHzbFPgD2i2bpZoOM3mZdKYRS38U7MlVU=
=pZxl
-----END PGP SIGNATURE-----

--8eqye/wz0y0EfH/9--

