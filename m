Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBE576C705
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjHBHgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjHBHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:36:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183E30D1;
        Wed,  2 Aug 2023 00:36:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so4497417e87.2;
        Wed, 02 Aug 2023 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690961772; x=1691566572;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1ZhT/lHz8oBBSrpqok+uROkQ5qtTNN4HBw8QF0pmww=;
        b=Y2moqdbfXuUNkormsrVnJvvkrKNbq0M27AkpjnXDF7a0MNdHYFYP1ewxzZ1ATBhQer
         TONlv6D4eCl5smoinRHY8UR/RNzvnU7yq66tgSxDx0eIe11Mo+8opQQhq2U6LXeroaEs
         KfavP03BNuRfPK+dXRJt2A7Gt0sw51fzApqBIzBiivJTeMwwiq3v65P0x4ncmi6CF248
         NbKasNQ/jD27XA5wwUFGjyrma/XWOp0A6g87DSnhy8mNJ4hzfMweBWTcraC4MxuOvXbF
         P3jYB4ziks5dP7gCsQnzuBpKAVOpBnq1jCY7iS63kkRAhkjnIwT49DEJbu4HYPinYiJ+
         yd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690961772; x=1691566572;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1ZhT/lHz8oBBSrpqok+uROkQ5qtTNN4HBw8QF0pmww=;
        b=d/JWz+KvmLHMR8lkhXVYk4E2SxAjlBTchg9Bpvbz+x34S1pjSU8HjXVndCmt9ry3hb
         j9o8xk0Vc9FRHWVhOXwXIWBw36xTyPzcIZ8dqKH1+cLcxL0g8hw9+d0W/AM+0FvsE41t
         JKReEPH66mVaAfK5eBgwU30koBd29YfnjwbJ/Ts2G3ssj0JpffIbzcs6T/xKkqsYlGYh
         o8lCjO2HvDmfy52cavFdbLE9LuThzIKHuK8mqUDyZQnTLgTwJv0icQN6d5bC+YWjuYlu
         FSDrVQ6gIS0It+B18dfa5hXSqDnRFdH8BSWPSJQ7ZPUbo28LvhFX7WN2ANM9M/Wgf7hI
         sq8A==
X-Gm-Message-State: ABy/qLb260Xe9rjSX8p6INSXncCs0XXaNdrSzJyinYLdnPECpnX4CF0q
        UWV9UGWTMD0kPGKbwJyyQhTWwizJ0x8=
X-Google-Smtp-Source: APBJJlEPli/uvxt6waH+HmaHgCHrH5VSsORRq/CzNW+jEMgkY46K93/aj4rLHpHlODwm94AuRNlksA==
X-Received: by 2002:ac2:5e34:0:b0:4f8:6d54:72fb with SMTP id o20-20020ac25e34000000b004f86d5472fbmr3508354lfg.62.1690961771582;
        Wed, 02 Aug 2023 00:36:11 -0700 (PDT)
Received: from dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id y4-20020ac24e64000000b004fdda72ec16sm2845547lfs.274.2023.08.02.00.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:36:10 -0700 (PDT)
Date:   Wed, 2 Aug 2023 10:35:55 +0300
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Support ROHM BU27010 RGBC sensor
Message-ID: <cover.1690958450.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+/KVnvRY7fHV2aYK"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+/KVnvRY7fHV2aYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BU27010 RGBC + flickering sensor.

Following description copied from commit log:

> The ROHM BU27010 is an RGBC sensor with a flickering detection FIFO. The
> RGBC+IR sensor functionality is largely similar to what the BU27008 has.
> There are some notable things though:
>  - gain setting is once again new and exotic. Now, there is 6bit gain
>    setting where 4 of the bits are common to all channels and 2 bits
>    can be configured separately for each channel. The BU27010 has
>    similar "1X on other channels vs 2X on IR when selector is 0x0"
>    gain design as BU27008 had. So, we use same gain setting policy for
>    BU27010 as we did for BU27008 - driver sets same gain selector for
>    all channels but shows the gains separately for all channels so users
>    can (at least in theory) detect this 1X vs 2X madness...
>  - BU27010 has suffled all the control register bitfields to new
>    addresses and bit positions while still keeping the register naming
>    same.
>  - Some more power/reset control is added.
>  - FIFO for "flickering detection" is added.
>
> The control register suffling made this slightly nasty. Still, it is
> easier for maintenance perspective to add the BU27010 support in BU27008
> driver because - even though the bit positions/addresses were changed -
> most of the driver structure can be re-used. Writing own driver for
> BU27010 would mean plenty of duplicate code albeit a tad more clarity.

Revision history:

v2 =3D> v3:
 - minor styling and added comment
 - rebased on iio-fixes-for-6.5a which contains prerequisite patches
v1 =3D> v2:
 - make vdd-supply required binding.
 - Some re-ordering for struct member init.
 - Some re-ordering for code to get rid of function declarations.
 - Tidy up the mess from patch 2/3.
   - Refactor parts from 3/3 to 2/3.
   - Clean-up commented out code and tidy things in general.


---

Matti Vaittinen (3):
  dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor
  iio: light: bu27008: add chip info
  iio: light: bd27008: Support BD27010 RGB

 .../bindings/iio/light/rohm,bu27010.yaml      |  49 ++
 drivers/iio/light/rohm-bu27008.c              | 630 ++++++++++++++----
 2 files changed, 565 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu2701=
0.yaml


base-commit: 8a4629055ef55177b5b63dab1ecce676bd8cccdd
--=20
2.40.1


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--+/KVnvRY7fHV2aYK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmTKB1AACgkQeFA3/03a
ocUI6gf/azRTRKqE26hQJxhDFkA0U/jxOcqTLrap+NFOYrNPWtBSXRYVV7By5qh4
d07jNJkqRt7+qpxTKZMpNlPbOJyudsmmOC8dNTLEKZGi70N2n+qno0GGHkcP9Xjn
VkE2Xj1qZxbBUtDri3cdvbk8EATjl84ohPgBa/gZcFpM19I6BHT5DpEHoDw4/JKm
g9+NwmPSyFICYpn4OcTUzjSQpGT3kbwbikmwiYlck7UA3HN8UQN5KDj69txdAtw8
KBdvdp+6JJTqr0McA9cEaFcBrkFKsrNzoYlSrLKS05Uo7TzcsQiRCqJUAeM6n+1o
IOonQv9m45so5KthcugfPIlkEc4LtA==
=CDhN
-----END PGP SIGNATURE-----

--+/KVnvRY7fHV2aYK--
