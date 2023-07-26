Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AAB7635B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjGZL4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjGZL4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:56:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A72C269A;
        Wed, 26 Jul 2023 04:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FECC61A85;
        Wed, 26 Jul 2023 11:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0E2C433C8;
        Wed, 26 Jul 2023 11:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690372553;
        bh=9Ase8OYeF6lxW9qO+vE8ldDwEpxuEB3jlpqk2z6oIIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKsjbuHI78C0TNQKvgNOABpA5Z5u4FWc1oS6X2aYf04UAICQTEDzrLL9I4mNcTlo7
         hCWe7nrWExWH6PkfM/O2EQY6cRuDU0jPL7VR/LGQxjpIcbulXKMCFSq5BK9tI9n6ci
         iqK2lg+JC5h9TpbHK6rFYlAm7YLlw79JcgVtOL80NPjg1Z1E4Iz8FLPONV7sHd+JH8
         JYb5SW/w8uPjtjCMy2r7uNoDu7ej44079tUbzUa7xCIreO/Vs9G/zVYvZ1nc9my9V1
         GHTO1qhtGYnBLj7lAAH6e6bATgAD68zlzPGezlgx76F3CA6+s14U6bIqTS+HkZA4NQ
         iL5mz0uKM6gMg==
Date:   Wed, 26 Jul 2023 12:55:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Jeong <eric.jeong.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] regulator: dt-bindings: dlg,slg51000: Convert to DT
 schema
Message-ID: <4859d289-f4e2-4676-9be4-182f7dbda8b6@sirena.org.uk>
References: <20230725063132.42132-1-krzysztof.kozlowski@linaro.org>
 <d33e5dbc-ca38-4702-903a-b36f9a824391@sirena.org.uk>
 <1c3684e3-b88a-0476-9376-19d07956e261@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WsoF2ODsLbGtFrNe"
Content-Disposition: inline
In-Reply-To: <1c3684e3-b88a-0476-9376-19d07956e261@linaro.org>
X-Cookie: Life is the urge to ecstasy.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WsoF2ODsLbGtFrNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2023 at 09:32:17AM +0200, Krzysztof Kozlowski wrote:
> On 25/07/2023 12:43, Mark Brown wrote:

> > This is just adding an OS specific note in the description, it's not
> > actually marking the properties as required.

> They cannot be required, because it depends whether the regulator is
> used or not. IOW, they are not required for unused regulators, which is
> not possible to encode in the schema.

Oh, you mean if the regulator is in use in the system rather than if
it's enabled!  I suspect that there's a requirement that either at least
one of the supplies be provided so that the chip I/O works, or there's
some other currently undocumented supply that is required for that
reason.

BTW there's also a formatting error:

+  vin3-supply:
+    description:
+      Input supply for ldo3, required if regulatoris enabled

missing space before is.

--WsoF2ODsLbGtFrNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTBCcMACgkQJNaLcl1U
h9C+3gf+Im+7dbQ8RsJCUUZn678BWKCbTHjfrQ1199JOgt3L4GDNmZN7iMmLHGAD
MijyKFpuFaq1FQ0rMTt1he53GSqWo6h1kX6x8w/Qtgo0WCAbg3n0bkmr0E0l/9Ex
9GMIK0p9/BqeUtMdfP9ytKxgcEPqiaZjk789zmO3C9pV7SOrUmTO/Iz/OH4+2cfe
eD/EFXXZVpS8oS3y31FwT8GnUsZFeo7TxeG65+dI69B04ASS2emiSreYk3yfk5n9
2mBOiSZY5orZEov8shoHqwTutPf6vR/4LKe4AodVHinPhAVV2aCd87+tc3dj2dFd
i+A8IEtgncioNBaEkS53bxVPGv8pcQ==
=yL84
-----END PGP SIGNATURE-----

--WsoF2ODsLbGtFrNe--
