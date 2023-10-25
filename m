Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE85E7D6C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343677AbjJYMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjJYMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:43:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92907AC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:43:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D1DC433C8;
        Wed, 25 Oct 2023 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698237788;
        bh=xFN7wfcpI5IKeJaVpcVe4CyiVilhPV4Rqp3uHIiLo40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCENl4dczCBp4463jmUp4115uJ/TaeaDg2enyYz9SP3D+kSoFk4ohOp+HNuO3odJu
         AiW3xsR5D9K5L9ZR1+ccfTtZsyUNcG+R23Bc+dycYfj0eVs1j02NCw6nGgV1iBZdZm
         lDRIwMWdSWoVKX+oT6q03g1cayMwx7cvzO3CFw3zduowe5JT6Ukxy5M2MCqoT9q21e
         NO7nb+7Pyu7kijifIqjkxFJgO3MObhg1UXlRc8YcPUeHmpEB0YRvnq3WsVMuHRJvlV
         h6DDeYGPUucYI5On4LWwIPworoFY/oXozu2Aa5nRUolVyoSltf8Iq2aHtUHNORdse/
         HiTNqcWCnjXUg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvdEO-0006O3-0u;
        Wed, 25 Oct 2023 14:43:28 +0200
Date:   Wed, 25 Oct 2023 14:43:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct
 sequence
Message-ID: <ZTkNcHAzgnL5xpAO@hovoldconsulting.com>
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
 <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
 <ff3eb88a-6941-4303-a4ba-17cad3842b88@sirena.org.uk>
 <2a0aabf5-41a3-cc07-3203-9b0bca6b71aa@linaro.org>
 <ZTjKWHAAfSYfc5px@hovoldconsulting.com>
 <6df45f92-5fe6-4b44-af04-c528d540ac06@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1DRDQSr7JlFP+Vi9"
Content-Disposition: inline
In-Reply-To: <6df45f92-5fe6-4b44-af04-c528d540ac06@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1DRDQSr7JlFP+Vi9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 01:36:14PM +0100, Mark Brown wrote:
> On Wed, Oct 25, 2023 at 09:57:12AM +0200, Johan Hovold wrote:
>=20
> > I understand Srini has looked at this but has not yet been able to come
> > up with a generic implementation. Would it be possible to merge the two
> > codec fixes as an interim workaround for 6.7?
>=20
> You're talking about two fixes here but this is a 4 patch series...

Yes, sorry, I should have been more clear. I was talking about the codec
fixes so that's patch 3 and 4.

I believe the first two have already been applied.

Johan

--1DRDQSr7JlFP+Vi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZTkNbAAKCRALxc3C7H1l
CPhcAP0bXzqQntT2WVRRpH1rW3mq9js4VcOAQR1+C/pyg2UODAEAlKQgWaSybBLL
8FnIhhB3yIND3bJxgUD9PTa1yhgKoQk=
=Lhzr
-----END PGP SIGNATURE-----

--1DRDQSr7JlFP+Vi9--
