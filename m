Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8102D77DB45
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbjHPHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242470AbjHPHjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE9110FF;
        Wed, 16 Aug 2023 00:39:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B83D62DBA;
        Wed, 16 Aug 2023 07:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F71EC433C8;
        Wed, 16 Aug 2023 07:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692171556;
        bh=/riLcTIr82d0TsMzt8Qndom9rYRqAJfK7qtF6pzxk9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XL5N5MReFrUVSXJi3ai0bu/+Qiuo7A8gZIuvSahgwnBPHvOTR8p76eDbfy6fesN96
         6Ltf/NFV4XfJ2le4WsgbEsXciordf+x7AnMD3SIdlcHHNfd6/UwSqHrHSZgjmRZjPx
         85RO82tQ8BWL86lI090A9W43lG49vzqL93v3sVTFYlhPK0MYBYEK8rLw9MfPUNwIK1
         Qq0Mw6QVpBQ0KcOCh7JJXItFDgJvdG4azZg16ed0rEzL36VqLOA5gc5SFOopMOX2fs
         5FUjHAePtPPgTWO7LSFIGjme5hj8copwUwaoZEpW4gtqib6HI93WKm5MaecNSUvstf
         A5PZdV7EGUXsA==
Date:   Wed, 16 Aug 2023 09:39:14 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <wc5qj6vs6ij3lzucweifimxjhxfuagm7neixm3qian6hqufqqy@kfa67cvi2g3n>
References: <20230815172454.138a386b@canb.auug.org.au>
 <2023081546-unpaved-important-3d18@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksno2ipmtsqylt7v"
Content-Disposition: inline
In-Reply-To: <2023081546-unpaved-important-3d18@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ksno2ipmtsqylt7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Aug 15, 2023 at 05:21:35PM +0200, Greg KH wrote:
> On Tue, Aug 15, 2023 at 05:24:54PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > After merging the driver-core tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > ERROR: modpost: missing MODULE_LICENSE() in drivers/base/test/root-devi=
ce-test.o
> > ERROR: modpost: missing MODULE_LICENSE() in drivers/base/test/platform-=
device-test.o
> >=20
> > Caused by commits
> >=20
> >   06188bc80ccb ("drivers: base: Add basic devm tests for root devices")
> >   b4cc44301b9d ("drivers: base: Add basic devm tests for platform devic=
es")
> >=20
> > I have used the driver-core tree from next-20230809 for today.
>=20
> Ick, obviously no one tested these somehow :(

kunit compiles those tests builtin by default

> Maxime, can you send me a fix, or I can just revert the changes for now
> and wait for a new series?

I just sent fixes

Maxime

--ksno2ipmtsqylt7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZNx9IQAKCRDj7w1vZxhR
xUw/AQDs2AuheVnJgCuujrb4UWbehNy6N+kl3QiNF+OE/qKE4QD/QW+lXIbQJFSI
JoirQKtLaMBhNwXmLrCXXkZ9peu5OAU=
=q2Kz
-----END PGP SIGNATURE-----

--ksno2ipmtsqylt7v--
