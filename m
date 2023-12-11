Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450EC80C9B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbjLKMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjLKMYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:24:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2516AFD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:24:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80982C433C8;
        Mon, 11 Dec 2023 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702297494;
        bh=84WZ4ewsgmNR6/ZEW1MIf+TUOxBr41z/0ezXIVDNlCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ilAFsEluKCHN7JQF683UHoaAPdr3aQNU9wUM/86e2jGy5Lw+g1sufCi36ER71lb28
         IV3JUmJPzp0iLxUNt5NKysTnwDcg9lG5IZe0Shq4T5c81NCk3xy5AKv6Bojhof3wI4
         4xGSRRz2MLvaaHkhmd/YCurLS2ZKAyEZErJPT/FaBklhFmMI+Z+US4fVghYw5acFTe
         sSEmYrgg3VsPUDUk7SxhNlgpt2upZ1diZusBAjUJ4V9ihREC/RY1Dm5jw2Mb/HhhiN
         duZ2vyRwAY0SgqkMNwqsISFiGcgEx2VxFG69IxIHYRzoh4kwKP3PHwLGwTuMYuyygR
         reKVHlBPLxb5A==
Date:   Mon, 11 Dec 2023 12:24:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7/hbqtGcYo57an8M"
Content-Disposition: inline
In-Reply-To: <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
X-Cookie: Better dead than mellow.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7/hbqtGcYo57an8M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 01:03:27PM +0100, David Hildenbrand wrote:
> On 11.12.23 12:15, Mark Brown wrote:

> > This is linux-next.  I pasted the commands used to build and sent links
> > to a full build log in the original report.

> Probably also related to "make headers-install":

> https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com

> The general problem is that some mm selftests are currently not written in
> way that allows them to compile with old linux headers. That's why the build
> fails if "make headers-install" was not executed, but it does not fail if
> "make headers-install" was once upon a time executed, but the headers are
> outdated.

Oh, it's obviously the new headers not being installed.  The builds
where I'm seeing the problem (my own and KernelCI's) are all fresh
containers so there shouldn't be any stale headers lying around.

--7/hbqtGcYo57an8M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV2/40ACgkQJNaLcl1U
h9AYhgf+IwDyqx/YzY9a574RrlQwU81b5BOxu2o1hAwwT6vCfeujk8u7w16UtJiZ
z3PAPhFvqNlDM0hyEQ44r4HFLlplsauO1zJH0lygThC0wnc0MEd3PGe+8Qu2hJsj
+LCnpWR3+f5rJtTP9OImUOnWUCiVLjcphPpgICFoomrKmL/IAMKvao8Nq4mlMOey
DmnS71xdBnZLHEizsj9BRJmHQpsddXUsKKiTXgYDln7sCo423sPSNnDzS/HOg4aj
8NJekG0uFkF6e8NcJGq9PA+D8RWBNMFHiv9TActmsSFMGR7HAcYz8fOaT6yFZmZY
/zZ6acLUvhqjyGPCdx8npVgRedNb9Q==
=WaDf
-----END PGP SIGNATURE-----

--7/hbqtGcYo57an8M--
