Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C447A4931
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbjIRMG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241955AbjIRMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:06:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1C7CE7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:05:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8733DC433C8;
        Mon, 18 Sep 2023 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695038727;
        bh=9FwDnCwNpeTZ03dQEveEuwWOjsUBCbikkvn0MmHn5ys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCJ2KG7m9cVApmjU/Ixo9zQNagIbZNXFDny80PtM5a7YzaU537+6dkZsawcCQ1lWr
         Olu9itipnmYfyeN+UITBKbcpdWpIxkJuVlSeiclak3lSbXEBX3ZdF1bFsogHkpJJC3
         xTZFT0QQeElkulbnSSpTcpBv4++lQ54RiZrexsTc0L3jSfj6J8Y+67Cg9Jtg0IhBDy
         UKpNqH03Udy67cxxZRn9ME2wNlH+1IH4v42TGNgwQCuv7k6mcplFvSx8YMClf9NRtJ
         OrTDYzUk9rpKeJTQXlKfNjo3cQHyl/2Kc6drT+biCf6c0LzVmE21PFBESEb//l1cfj
         yiO3tgDDfctgw==
Date:   Mon, 18 Sep 2023 13:05:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>,
        Zeng Heng <zengheng4@huawei.com>
Subject: Re: [PATCH 2/2] Revert "regulator: core: fix kobject release warning
 and memory leak in regulator_register()"
Message-ID: <e11bcb8f-be81-4a71-a7eb-30a2da981602@sirena.org.uk>
References: <cover.1694985959.git.mirq-linux@rere.qmqm.pl>
 <d7361cf5c6bfc78f519149554eadad1d5ef5e76f.1694985959.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+VujQYPYsSrhp0uL"
Content-Disposition: inline
In-Reply-To: <d7361cf5c6bfc78f519149554eadad1d5ef5e76f.1694985959.git.mirq-linux@rere.qmqm.pl>
X-Cookie: Never kick a man, unless he's down.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+VujQYPYsSrhp0uL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 11:35:14PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> This reverts commit 5f4b204b6b8153923d5be8002c5f7082985d153f.
>=20
> Since rdev->dev now has a release() callback, the proper way of freeing
> the initialized device can be restored.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--+VujQYPYsSrhp0uL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUIPQIACgkQJNaLcl1U
h9DJ4gf9GS5Nbq8I3+ySfKxcU7yshxu3bDPrQ0wy3CKLrMITNqR3s35oE8a1WnIS
GvxcEnhas40WE4UWJdRNeZzrjmpoPUN29sAGWH0DLtWvs4XYqFPF6ZqHWDw7H0cw
W2VspifhkZIg4UzlR/hFzcw3JsxktYRcrhWNg/LBQyhs9gRsWmirGGQLtr8qRXhj
dWGrboaajFOR/NEgJ78hTG6s4bN5aOVZEIORqOnetzMcEyMCl9sD9d7K7T+xvn+g
X4tlxgAPuqWGCXyW8pnDKGiwIJiHqV+9IY5+Bq5O0Nn5DUWOY0sXJkU1BRySEpWq
l7GBObueQw8WPRD5pwp6gF91qONJKg==
=0Rtr
-----END PGP SIGNATURE-----

--+VujQYPYsSrhp0uL--
