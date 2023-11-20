Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B842E7F17CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjKTPua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjKTPu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:50:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B922A0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:50:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A91EC433C7;
        Mon, 20 Nov 2023 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700495425;
        bh=hwGdvTC30e2lqKVVWjBXy5T6ES/s37IXoRVGMd2+0pQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuakXYfH2B3OCYrq02ImXPaLKHHgv1XoOxq2euxeIQWC0Crhms/GQfyHAERvfK69s
         DF1RBMamEUYPuaOfpnaQp1j+CNzucEdp1EpNAPN+hWMv57j1T/49wvYAu20TggHUvr
         9h9mFblafUh5Qh+JN7xv4j9enLyvvjGgt/YK2XvQvOmhX4pbud5Uo9wJI5ysIkZrNw
         BPWdpOl8U5S3cdCW/wUONBUm0CW8H5dyUUZJsDljmdbgfcn5XTMVRFnoX/B5WCXJTP
         PyXPoKPqTJYSNuJDOUBMqvy72xpUWxgQ/NsRdT6CL/dMnTLhYok/ymvlzSQA5CyIvF
         LZZLM4LJ/KWzQ==
Date:   Mon, 20 Nov 2023 15:50:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Sahaj Sarup <sahaj.sarup@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] dt-bindings: display: ssd1307fb: Change
 "solomon,page-offset" default value
Message-ID: <20231120-granola-sturdy-83d054f1b6fa@spud>
References: <20231116180743.2763021-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4bFoAD9+noYJcHZh"
Content-Disposition: inline
In-Reply-To: <20231116180743.2763021-1-javierm@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4bFoAD9+noYJcHZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 07:07:37PM +0100, Javier Martinez Canillas wrote:
> This is used to specify the page start address offset of the display RAM.
>=20
> The value is used as offset when setting the page start address with the
> SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
> 1 if the property is not present in the Device Tree.
>=20
> But the datasheet mentions that the value on reset for the page start is a
> 0, so it makes more sense to also have 0 as the default value for the page
> offset if the property is not present.
>=20
> In fact, using a default value of 1 leads to the display not working when
> the fbdev is attached to the framebuffer console.
>=20
> Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>=20
>  .../devicetree/bindings/display/solomon,ssd1307fb.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.=
yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> index 3afbb52d1b7f..badd81459aaa 100644
> --- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
> @@ -35,7 +35,7 @@ properties:
> =20
>    solomon,page-offset:
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    default: 1
> +    default: 0

I think I saw it pointed out by Maxime elsewhere that this breaks the
ABI. It would be nice if DT defaults matched the hardware's, but I don't
really think it is worth breaking the ABI here. Expanding the property
description to explain the impact of the particular values might help
with incorrect usage.

Thanks,
Conor.

>      description:
>        Offset of pages (band of 8 pixels) that the screen is mapped to
> =20
> --=20
> 2.41.0
>=20

--4bFoAD9+noYJcHZh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVuAPAAKCRB4tDGHoIJi
0rwwAQDwlz5bsqGXaRqTo+gxHO6qWygSskpfqHWje4LOQ/STSAEAjptBSDLIi9s1
DjGRyqKsN280gvpMTdz7FUpAEO1gZwg=
=pjLO
-----END PGP SIGNATURE-----

--4bFoAD9+noYJcHZh--
