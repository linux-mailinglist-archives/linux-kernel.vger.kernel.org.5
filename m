Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A45B75483A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjGOKkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjGOKka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:40:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49753A88;
        Sat, 15 Jul 2023 03:40:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D1560303;
        Sat, 15 Jul 2023 10:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3F1C433C8;
        Sat, 15 Jul 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689417628;
        bh=wTBz1S2hSZwl9POKXMBD1OXuh1TzdFtjpS1qwGx+jkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzOsA2qFOz4tvHXjRervo3hsjJMpV6Wh6vmXrC9HBvJufqG5Rxd2QWn4Ytf9WmKT3
         ujHHRaZ6EHvH9eJq5Bo2tUdsmlaScYysaiAgNR5GV/wUns4qUKnTOnwwuRUszRu1mj
         4qvEGI7Q96XZXeehYXzyZx/h+k8lBAetCYLTvmZoAJuV5oqUtFL/b5h5rDuBdToy79
         LlOPbpvXntlRlSlMzqmc1z6eguAX/wxLQFmPbaLavZ+57NQu0BY6V2btUGLmjFKQek
         vDqhRkXReWmtyZWxzFjTYSctCOWNIJE4N1xbj3OiHtccADkleRhF4jBxF2aF3HsgF3
         RgCDKpsDhMdRA==
Date:   Sat, 15 Jul 2023 11:40:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, frank.binns@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        faith.ekstrand@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, afd@ti.com, hns@goldelico.com,
        matthew.brost@intel.com, christian.koenig@amd.com,
        luben.tuikov@amd.com, dakr@redhat.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 02/17] dt-bindings: gpu: Add Imagination Technologies
 PowerVR GPU
Message-ID: <20230715-paramount-straining-6a486f8af20d@spud>
References: <20230714142526.111569-1-sarah.walker@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PGVJVVq7kVn9L8A9"
Content-Disposition: inline
In-Reply-To: <20230714142526.111569-1-sarah.walker@imgtec.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PGVJVVq7kVn9L8A9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sarah,

Your series does not appear to be threaded. `git send-email` can be
passed, for example, a directory containing a whole series & will set
the correct in-reply-to headers so that the series is in a single
thread.

On Fri, Jul 14, 2023 at 03:25:26PM +0100, Sarah Walker wrote:
> Add the device tree binding documentation for the Series AXE GPU used in
> TI AM62 SoCs.

> Changes since v3:
> - Remove oneOf in compatible property
> - Remove power-supply (not used on AM62)
>=20
> Changes since v2:
> - Add commit message description
> - Remove mt8173-gpu support (not currently supported)
> - Drop quotes from $id and $schema
> - Remove reg: minItems
> - Drop _clk suffixes from clock-names
> - Remove operating-points-v2 property and cooling-cells (not currently
>   used)
> - Add additionalProperties: false
> - Remove stray blank line at the end of file

The changelog should go below the --- line.

> Signed-off-by: Sarah Walker <sarah.walker@imgtec.com>
> ---
>  .../devicetree/bindings/gpu/img,powervr.yaml  | 68 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpu/img,powervr.yaml

> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr.yaml b/Doc=
umentation/devicetree/bindings/gpu/img,powervr.yaml
> new file mode 100644
> index 000000000000..3292a0440465
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2022 Imagination Technologies Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpu/img,powervr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Imagination Technologies PowerVR GPU
> +
> +maintainers:
> +  - Sarah Walker <sarah.walker@imgtec.com>

> +  interrupts:
> +    items:
> +      - description: GPU interrupt

The description here doesn't add any value, since there is only one
interrupt, so you can drop it and do maxItems: 1 as you have done
elsewhere.

> +  interrupt-names:
> +    items:
> +      - const: gpu

And this
items:
  - const: gpu
can just be
const: gpu

Although, if there is only one interrupt this is probably not
particularly helpful. Are there other implementations of this IP that
have more interrupts?

Otherwise, this looks good to me.

Thanks,
Conor.

--PGVJVVq7kVn9L8A9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLJ3lgAKCRB4tDGHoIJi
0j3aAQDVMC24k6fauiEV0VhEg6EVlCN4u/NEO2bgeg06XEa29wD/RMfmf/un5KW6
LVpJKv8SHRhzcCHfOR387DPgS+VIDgE=
=XdJ6
-----END PGP SIGNATURE-----

--PGVJVVq7kVn9L8A9--
