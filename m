Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18F07D2AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjJWHJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjJWHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:09:08 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238D1188
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=KkAe
        LLgWLM5KXP64Cj4yIbcMQ879DhR2OB2+2eT7GHs=; b=iwTHuVMoLR+JNVDpnLdR
        SGxclKGti7ROvXSXV+25Q1fEsqy8KmZ90GsZxQSaHztFwsLA/CxYeycTw5gmLtwm
        PjcN3JRWCqz8nkmHVwBlTnAg6LD6HD+oQJQ2az8n66FX1vg5+jMkxeTJuu6jRBKk
        yBi5Y9I+h3qHVRitgbPOgUS8Gt887EVR5Zkzk/aQzAi9MOmiT8pnPm0rJX8i1T/Y
        FTI3duXNtxll8E97bX9JP3oTQD1+bwIKApxL8O7Ks2Ovs6Zy0MQX4FypExr7DooN
        rCjWuXDhOO9/pwOBbQbiHTf6/sH+x5Thc3yJCQdFg005KoKK87MHrMOlo3OZPBJE
        Dw==
Received: (qmail 1849151 invoked from network); 23 Oct 2023 09:09:04 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Oct 2023 09:09:04 +0200
X-UD-Smtp-Session: l3s3148p1@YvOz5VwInJwgAQnoAHZpAPyQUfJFEq1N
Date:   Mon, 23 Oct 2023 09:09:03 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] gnss: ubx: add support for the reset gpio
Message-ID: <ZTYcD8l+lUlLog91@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Johan Hovold <johan@kernel.org>, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
References: <20230921133202.5828-1-wsa+renesas@sang-engineering.com>
 <20230921133202.5828-4-wsa+renesas@sang-engineering.com>
 <ZS1AxSRL4F5WBvnC@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n2o7eTgxzL/5uehf"
Content-Disposition: inline
In-Reply-To: <ZS1AxSRL4F5WBvnC@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n2o7eTgxzL/5uehf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So this means that the reset line will be asserted indefinitely in case
> the GNSS receiver is not used. Are you sure that's a good idea?

Yup. Saves power. We do this for our ethernet PHYs as well. Any reasons
not to do this?

> I don't know yet which module this is for, or how this signal is
> supposed to be used, but the above makes this look more like an
> active-high (regulator) enable signal. Perhaps that's what it is or
> should be modelled as (i.e. as a fixed regulator).

Nope, it is a RESET_N pin.


--n2o7eTgxzL/5uehf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmU2HA8ACgkQFA3kzBSg
Kbap/w//ZItgDWveXoAOgOKiowOQFeRrASG5UyQWpKRGZNDBGCQbSeEW86HtPR7/
bO/eklIS4g3vjng5LGVygMMgydO//202Ylc3YbBYBkXw4Z/NioGVADJTUzUY+Ym8
Foi1xShFQ6aMx5U/bww3hzMF+sSLDUA7iuQNxX2qI8oYL20j1cbFd5p/WZOSEcQF
Yg1eUWMmdYtIdZINnzPsKZK1Kdpr7jAidY1ivH+0vTMlfLB3eynkB5P2mz/ZMDdp
Vw0HRVWuFR/USuN5KYeZQACmSVBiKMwInoevUgsaCPUhZ4aeuAkgxGTD55cOy/Oo
HpjUUxZNb6aVmCBejfYKjTMykcovhFZaRsEkMtjhvar3mMJSzElhU7jgQjWHFDP4
8XJ3J3Q4caGrsOwisRB0ZiI77sX32gDKl1qa23YecquKzkpk+/UfNXx1XCzP0Fbz
Bu3qrktgJvcowTXgL9Vs/04bZh5u6hE4vFeTBlUqtc6+mS15zaCppDaky3QeoDzF
ONz0DeQXcU7BufZ9RFYq09qXG1UkekQ3MlESrURnX5RcOBTi6ztQ/cTJyzaa9V4C
XyO5KBCvp4QwzlOdrH4QBHRa6+oQEqwCwaIKbGdMM/x+SpLWtP2I4luQPiXx+I5q
I2Mr68f0Hms0JnPHV84cmYMrzH5BnH82E6JCZ4AbWGIFO2ya0G8=
=Egmt
-----END PGP SIGNATURE-----

--n2o7eTgxzL/5uehf--
