Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E071C77E081
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244661AbjHPLe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244695AbjHPLek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:34:40 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B468E7C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=HBbF
        lemzEOhPa00H0VmfelS/CW8R7e58HfrA6PqinYI=; b=d8BWs07FAiT3EPZSfUar
        afa/AO5AcnMNr4BYb0rC+1+2uKo9Ww2BcHpGyDsXKGbLiElioTTlUvXdWvD/BTux
        JUgK2a9c5dFPZKY+Hd02QdpPg0hRd5fOMAeuvuOGODjPZfMNY8LhHX7UqmaqAL14
        jRVvZTyT5zzT6r5YDcDkXwdmqInS5Hcg1lypBiRDVGRqY4kTrvorwwn+DoNV8ZGX
        GopkLqibHhqHActGB4XuSdbHezISpaEGAYcH13WrVuTbzKU6qg/Rq8djA167gZrh
        iTv4yG2ZTDjaJdZQllhw5s0Xdg/F4X9Q/7IPhTv19n2NmtJCegCbuGQNSVzirsez
        9w==
Received: (qmail 116343 invoked from network); 16 Aug 2023 13:27:39 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Aug 2023 13:27:39 +0200
X-UD-Smtp-Session: l3s3148p1@Cm0/lQgDILcgAwDPXy5qAJ1huuy56R1W
Date:   Wed, 16 Aug 2023 13:27:38 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 56/62] mmc: renesas_sdhi: Convert to platform remove
 callback returning void
Message-ID: <ZNyyqlMFFZ2xPLUf@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yangtao Li <frank.li@vivo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727070051.17778-1-frank.li@vivo.com>
 <20230727070051.17778-56-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WXxTWG8lhc/cEAqB"
Content-Disposition: inline
In-Reply-To: <20230727070051.17778-56-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WXxTWG8lhc/cEAqB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 03:00:45PM +0800, Yangtao Li wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Builds fine, boots fine, rebind works:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--WXxTWG8lhc/cEAqB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmTcsqYACgkQFA3kzBSg
KbapCg//RlbUTbKwqc3S3+NyRLwP+SdcP6IJivgpDLTNh6kSTvFj0SKSlEE0ghwr
KaL3DKWsIICa2YgYTuDNIznUForrQOleFaE8JKS1NBT0DD6sR/wg0H0m06YIhonf
V+6brxQqEqg55wjYPR2sxFDgJJn6DS8Z2nZlOsns23kt+Ur84CLGZiIewkQuHTZG
RMv+1ke+ICsGOQTZBwg6fOdGEmjsx+IcRYk15uIEsl41MinpT/aiJuaxlZ7Xr9Ak
drUvYC7SHhZ0hZXmDaHNiMlJEDWFghOx5gPuTNzTSJP59oIWevLv/eI/QAdrDGAf
Ogu6jeiuhh3PaT7EJmu3jsYExA8AUoNkwGYxwbjAJDo3aMrdKpX/+on/9TU3L9Co
wiVTIVO5TCPmPlrctS6NUE8NAjX5C7UYtp76o9LgT39ZGoYe5Sa5ETioj2o2ZAYW
5DFIckgsYvAyATlnRKHNeBzpgKF9zYDkDZ/r5lAr7utG+DQr0Xq8BqONqIAc6YGf
i9xXGmmDTzZOwkAzU9jW7au6hG39pQxkNeKJ0VBV3VPURGrFeBIwto260Ku7HXsR
zGYyJTl8SHKS0AZAWvkhxC+RPUAgwWdCg+xOE23pyORNLmysDkk9SODrDv7RQn3+
H6LPHxyETABTC8rB3Wxqe+ChNgDbYgluws+64QKn/UCr9SFLXhY=
=KtVJ
-----END PGP SIGNATURE-----

--WXxTWG8lhc/cEAqB--
