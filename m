Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8D7B48BC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 19:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbjJARHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjJARHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:07:46 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B5EC9;
        Sun,  1 Oct 2023 10:07:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2CBD760006;
        Sun,  1 Oct 2023 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696180060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhbZnwWf71+UUTHRQ8xN/7PXzLXHc8GR+wwelJyyT+I=;
        b=oT2ZWjimx5qHzixIKM7c7VWYaAj1uOO65Ya3XyLsWoPaf2VxZNCgELNFEHIeV4aEAe2tmV
        pkJBP5ox4+dWXfG5X0GGTGvQxQt+YiJE9xoxqHlKHWuwMiY2uqiBEkFONTkwuc0cgedgsv
        Rx4KvBirWej1myOJeDy0qyPWl3lrfpwKmBsGkWcOfUEY9wKrVNMVBfUrpq3FH2w8XH+nOc
        91RqaVUj9CB0esMCwFnOW6G4goNVVhsEbe+cu+2g9Wcsp7GIr5O35n8ohCULxiovkCPtbL
        +4fvJLMv6kdJl+yyzndjwEDD9PgoSTzOuRvt7/PhEsB3lOmz27zKixa1mPmfZQ==
Date:   Sun, 1 Oct 2023 19:07:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mtd: fixed-partitions: Add binman
 compatible
Message-ID: <20231001190736.4f007796@xps-13>
In-Reply-To: <20230927202057.3676497-1-sjg@chromium.org>
References: <20230927202057.3676497-1-sjg@chromium.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

sjg@chromium.org wrote on Wed, 27 Sep 2023 14:20:51 -0600:

> Add a compatible string for binman, so we can extend fixed-partitions
> in various ways.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  .../bindings/mtd/partitions/binman.yaml       | 49 +++++++++++++++++++
>  .../mtd/partitions/fixed-partitions.yaml      |  6 +++
>  .../bindings/mtd/partitions/partitions.yaml   |  1 +
>  MAINTAINERS                                   |  5 ++
>  4 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binm=
an.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml=
 b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> new file mode 100644
> index 000000000000..34fd10c1a318
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Google LLC
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binman firmware layout
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +select: false
> +
> +description: |
> +  The binman node provides a layout for firmware, used when packaging fi=
rmware
> +  from multiple projects. It is based on fixed-partitions, with some
> +  extensions.

Could you mention the input file vs. output file and which one this
binding describes?

> +
> +  Documentation for Binman is available at:
> +
> +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
> +
> +  with the current image-description format at:
> +
> +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#im=
age-description-format
> +
> +allOf:
> +  - $ref: /schemas/mtd/partitions/fixed-partitions.yaml#
> +
> +properties:
> +  compatible:
> +    const: binman
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    partitions {
> +        compatible =3D "binman", "fixed-partitions";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +
> +        partition-u-boot@100000 {

Do you mind if we avoid playing with the node name? I would prefer:

	partition@100000 {
		label =3D "foo";

> +            label =3D "u-boot";
> +            reg =3D <0x100000 0xf00000>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-parti=
tions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partiti=
ons.yaml
> index 331e564f29dc..1c04bc2b95af 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> @@ -14,6 +14,9 @@ description: |
>    The partition table should be a node named "partitions". Partitions ar=
e then
>    defined as subnodes.
> =20
> +  The Binman tool provides some enhanced features, so provides a compati=
ble
> +  string to indicate that these are permitted.

I believe this is not necessary and is implied by the $ref in
partitions.yaml.

>  maintainers:
>    - Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> =20
> @@ -24,6 +27,9 @@ properties:
>        - items:
>            - const: sercomm,sc-partitions
>            - const: fixed-partitions
> +      - items:
> +          - const: binman
> +          - const: fixed-partitions
> =20
>    "#address-cells": true
> =20
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.=
yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> index 1dda2c80747b..849fd15d085c 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> @@ -15,6 +15,7 @@ maintainers:
> =20
>  oneOf:
>    - $ref: arm,arm-firmware-suite.yaml
> +  - $ref: binman.yaml
>    - $ref: brcm,bcm4908-partitions.yaml
>    - $ref: brcm,bcm947xx-cfe-partitions.yaml
>    - $ref: fixed-partitions.yaml
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5f18c6ba3c3c..367c843ec348 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3517,6 +3517,11 @@ F:	Documentation/filesystems/bfs.rst
>  F:	fs/bfs/
>  F:	include/uapi/linux/bfs_fs.h
> =20
> +BINMAN
> +M:	Simon Glass <sjg@chromium.org>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/mtd/partitions/binman*
> +
>  BITMAP API
>  M:	Yury Norov <yury.norov@gmail.com>
>  R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The rest of the series otherwise lgtm.

Thanks,
Miqu=C3=A8l
