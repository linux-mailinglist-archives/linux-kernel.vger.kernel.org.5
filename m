Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE37C02BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjJJRaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjJJRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:30:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C497
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:30:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1235C433C9;
        Tue, 10 Oct 2023 17:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696959015;
        bh=6W9QQtPNPmLddeXV3pB18UP1lHdG4DDs+Yp7vsexmEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdKYj3VUFBdCWhQdCItN3D0eNbQbQf28rQeCtNuO2OfTlNBQ/sK9SjZB/SGJeoWS3
         ggiZh2IXLNwHnNhHiO2b6uB4QsAyLx3wQ0YZyxUg9Kzhp/L9Zy1UMddzYbwcPQpOmC
         z4tAtGlXzyidWiuPUvwbogqHMcRV0h3Bt7PlInUIVSD4XHKpsB+9NEByIvjW35NS8f
         OhVzJxaEcRd/Rnbqzq7WPRlerbFB1SGPNTHXDq0eIy2tyrILxZlrEphl/gamBRMrFo
         w5TsLjmj0SbJvCBslHGKhf00hIK3pf/Z/QSii240aGMdB9CNVIoKVllW5rTqChe+KJ
         rAsQvo/RJ8kug==
Date:   Tue, 10 Oct 2023 18:30:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: regulator: regulator-output:
 Multiple supplies
Message-ID: <33d88df2-f41d-44f6-83d1-78e73136b860@sirena.org.uk>
References: <20231004121010.1192344-1-naresh.solanki@9elements.com>
 <20231006163054.GA4037413-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KePFqLOX9f/5rEnH"
Content-Disposition: inline
In-Reply-To: <20231006163054.GA4037413-robh@kernel.org>
X-Cookie: I feel partially hydrogenated!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KePFqLOX9f/5rEnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 06, 2023 at 11:30:54AM -0500, Rob Herring wrote:
> On Wed, Oct 04, 2023 at 02:10:07PM +0200, Naresh Solanki wrote:

> > Add support for multiple supplies.

> Again, why?

FWIW I do tend to share the same question that Rob and other people have
asked a few times here - is this really one userspace consumer with
multiple supplies, if so what does that userspace consumer represent?
I'd be expecting that this was representing a single supply to an
external device which for the most part would have a single input
supply.

--KePFqLOX9f/5rEnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUliiEACgkQJNaLcl1U
h9BthAf+KJgLXEo/DVufgNmxnPG13x3guPNUBDncLumLw7OoFIlL9K25sYw93xMU
brIbIy/NtDAAR9kPR1IJj131bRowiQPMr1ibXCkQ/7olLL5H1ugDrmqJL8KRQ4W8
jh3Gd5LpD9DVUU6WYG/7EPZ8WRy7oe5O7Yoc/gBom406yBovrkTUlXOeR+psMOJi
H5w0NinNdvzONNTSTvcUXB8Hv+Rpv2N+2DZOXV8YT7DQXkuwgKvbM9XK66gbxxQO
e57hm4u7ibC7Q0s4bYVP6et1CHXGLgILfAfX9XOkQWH17UeSfSQPkFx9ihDVNTPi
eMziezu/fAhY4cH65Q57pkBIbMgm8Q==
=5d6T
-----END PGP SIGNATURE-----

--KePFqLOX9f/5rEnH--
