Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331FF809229
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443883AbjLGUSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjLGUSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:18:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68221710
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:18:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16879C433C7;
        Thu,  7 Dec 2023 20:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701980334;
        bh=QNpdhsUDUeBMWgIe029az6yJ0bM5+Vcwn1beTYWInjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiREk0soMiRO9TNKHICL6XVvpK+xRhB8awImP5Tu/ALNn3KK0TLQEII5AS6pC8BMV
         hGBCZsGBE165bv3S3xh0lY+E0TYq1sbIHJ7u/xiU6kZW9c+mKAOQ0FwC3NTNiZSh0/
         Py2ShItz64LdfEow6Bfrl3/u5m+LvWLyjTJli7sLatQX9Y9NgEhQwaG20dRQNzsrqu
         xNyXu8FZEv5rXhi4eXpDOHoNHkK2DTrU1bWSN+BSvK/qUNCkhnA70RPevK6AZy18Vx
         vknatbPHPBBDRpO5JxgZTeFUivH7BQvrdHCTtvbobP0MxaDLu0R2lkuxUaVm+U3kWe
         0UqAlSihLkq9A==
Date:   Thu, 7 Dec 2023 20:18:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Shuah Khan <shuah@kernel.org>, kernelci@lists.linux.dev,
        kernel@collabora.com, Guenter Roeck <groeck@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/3] kselftest: Add new test for detecting unprobed
 Devicetree devices
Message-ID: <310391e8-fdf2-4c2f-a680-7744eb685177@sirena.org.uk>
References: <20230828211424.2964562-1-nfraprado@collabora.com>
 <20230828211424.2964562-4-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pkj5fhuMUnWEtPFQ"
Content-Disposition: inline
In-Reply-To: <20230828211424.2964562-4-nfraprado@collabora.com>
X-Cookie: Integrity has no need for rules.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pkj5fhuMUnWEtPFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 05:13:12PM -0400, N=EDcolas F. R. A. Prado wrote:
> Introduce a new kselftest to detect devices that were declared in the
> Devicetree, and are expected to be probed by a driver, but weren't.

I've been running this in my personal CI for a little while now and I'm
finding it's pretty marginal for the 45 second default timeout in
kselftest on some platforms, especially BeagleBone Black though it's not
just that.  BBB is both slow and has a comprehensive DT which won't help
matters, there's 253 devices.

I'm running it from nfsroot which is going to be part of the problem but
shouldn't be too bad since we're mainly dealing with proc and sysfs and
hopefully mostly running cached binaries, I'm also using a serial
console to get the output which is going to add overhead especially with
a large number odevices with length names.  I'm not sure what the best
solution is here - a quick glance at the code doesn't ring any alarm
bells for me, this may just be a reasonable runtime for the test.

--Pkj5fhuMUnWEtPFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVyKKgACgkQJNaLcl1U
h9Bc2Qf9Ff2kw/O+966mMrAYPT/ndJA6i8hD9VjeLevjVDZ2HGUY9YfIo4B+zkb2
bPVIFdfHfD3J3hu01MWBUyaUVTNU+TWTF3rX5imPd9NNFHnvneTOGtg4KOCRXcSl
KKuM+C4k+euPWJiFNJRJgwLFVOY4GPNrVkTi9XP7r6Wv8MU7Un4sjQ0+dBTmE5gp
FclMgg306GEgWgzGxw2rIhyLZbGJPpPuu0cmqVlitgmTWIzi63vQrH4wrCQ+R/l1
Npe6lzBjnqghV5cJOLs0sQe7NRMPzY/B9Z+cXERW1DYad86s9jeYedqdXDaRuqjM
CgbCssr96PhbPheZxkPPULQacKbrBA==
=uXwM
-----END PGP SIGNATURE-----

--Pkj5fhuMUnWEtPFQ--
