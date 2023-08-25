Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47939788C1E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbjHYPGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbjHYPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598AD212C;
        Fri, 25 Aug 2023 08:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4A1563615;
        Fri, 25 Aug 2023 15:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68185C433C7;
        Fri, 25 Aug 2023 15:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692975980;
        bh=Ih/unC5mMCx0JKXD/w7LDAy5yURqSrSqENwjWGzF/uU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3D3xXWdL3aN3ZNRmG8w4Fh9U/tF6GOzUrF54Ie0lYeuD8w5lgdEY0yLNCTRA875O
         P91s0EIswGDNhohzkXL/rolyPFEX3Zdb5QyFfBaTOheMmZcUqhiuk/nT5Cl4Und65Z
         gSZz1H/6rC87Zxghj6HLSgkp7u8rhOvOlAps7uGkGM0GlCVzlFwxqWhSLzH6AQdMxr
         X1T+LjJsNkvs//VIzsgiadWmIzW6IfBNPx4SpmUFTPGGlqrOacWwz3gu4QWjMp672X
         OWbgaAw/HTUtx7d9CLxnF4FB4Dl8XuB1ABjJlN5pi86Js7tQWBGMcZZ02OqRf5YuoY
         ZEaK4WJ/fX0hw==
Date:   Fri, 25 Aug 2023 16:06:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [RFC v4 0/4] StarFive's Pulse Width Modulation driver support
Message-ID: <20230825-exclusion-doing-93532be4fa97@spud>
References: <20230825081328.204442-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9eiGjMF7i2kmpUJ"
Content-Disposition: inline
In-Reply-To: <20230825081328.204442-1-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9eiGjMF7i2kmpUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 04:13:24PM +0800, William Qiu wrote:
> Hi,
>=20
> This patchset adds initial rudimentary support for the StarFive
> Pulse Width Modulation controller driver. And this driver will
> be used in StarFive's VisionFive 2 board.The first patch add
> Documentations for the device and Patch 2 adds device probe for
> the module.
>=20
> Changes v3->v4:
> - Rebased to v6.5rc7.
> - Sorted the header files in alphabetic order.
> - Changed iowrite32() to writel().
> - Added a way to turn off.
> - Moified polarity inversion implementation.
> - Added 7100 support.
> - Added dts patches.
> - Used the various helpers in linux/math.h.
> - Corrected formatting problems.
> - Renamed dtbinding  to 'starfive,jh7100-pwm.yaml'.
> - Dropped the redundant code.
>=20
> Changes v2->v3:
> - Fixed some formatting issues.
>=20
> Changes v1->v2:
> - Renamed the dt-binding 'pwm-starfive.yaml' to 'starfive,jh7110-pwm.yaml=
'.
> - Dropped the compatible's Items.
> - Dropped the unuse defines.
> - Modified the code to follow the Linux coding style.
> - Changed return value to dev_err_probe.
> - Dropped the unnecessary local variable.
>=20
> The patch series is based on v6.5rc7.

Out of curiosity, why is this series still an RFC?

--M9eiGjMF7i2kmpUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOjDZAAKCRB4tDGHoIJi
0hpMAQCVxJxrRd/qnUytncJTEZTkZhBNWpfnTFJiTWosLONwagEA1gWFXmEkUG4p
P717RLD26fgyVmB/czA/nZe4Y6jfIwk=
=QcUj
-----END PGP SIGNATURE-----

--M9eiGjMF7i2kmpUJ--
