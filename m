Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A904E7E8C4E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjKKTXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKTXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:23:31 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AE4C4;
        Sat, 11 Nov 2023 11:23:28 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 271F21C0071; Sat, 11 Nov 2023 20:23:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1699730607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K6odKY3sY9Zkf6tdtdGxd7vIMwPRzaLEncX/QIk0rXA=;
        b=XLClci90peawuVYrVztZgHTKdYXdm0itTVjUfT1o+gb03zwYRO8sKeZM7Ysqz3xv20JsKu
        gC10dXiq9RGnUBBC4l5p/D3yMyQ+N+l3lmhT6w1JHTEAimIyXCVpEiyRC6bxc4D4nADsnJ
        1B/ta8uCxeE34YaCjjZuP2frK0rBieI=
Date:   Sat, 11 Nov 2023 20:23:13 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: media: i2c: add galaxycore,gc2145
 dt-bindings
Message-ID: <ZU/QyrbaeyoV5+ON@duo.ucw.cz>
References: <20231107081345.3172392-1-alain.volmat@foss.st.com>
 <20231107081345.3172392-3-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HEYXTtUT371s7KFw"
Content-Disposition: inline
In-Reply-To: <20231107081345.3172392-3-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HEYXTtUT371s7KFw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Introduction of the Galaxy Core GC2145 XVGA CMOS camera sensor.

> diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc214=
5.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> new file mode 100644
> index 000000000000..94d194cf5452
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc2145.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Galaxy Core 1/5'' UXGA CMOS Image Sensor
> +
> +maintainers:
> +  - Alain Volmat <alain.volmat@foss.st.com>
> +
> +description:
> +  The Galaxy Core GC2145 is a high quality 2 Mega CMOS image sensor, for=
 mobile

I'd drop "high quality" and add "pixel".

> +  phone camera applications and digital camera products. GC2145 incorpor=
ates a
> +  1616V x 1232H active pixel array, on-chip 10-bit ADC, and image signal
> +  processor. It is programmable through an I2C interface. Image data is =
sent
> +  either through a parallel interface or through MIPI CSI-2.

Short note what the on-board ISP can do might be welcome here.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--HEYXTtUT371s7KFw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZU/UoQAKCRAw5/Bqldv6
8orDAJwM20frY6IY1jpKX8OIEbZK9e6RLQCZATDMB7pVsZ9YHVBMUlxXBbnOi50=
=I4xG
-----END PGP SIGNATURE-----

--HEYXTtUT371s7KFw--
