Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4668980DB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbjLKUWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbjLKUWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:22:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD4D43
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:21:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB20AC433C7;
        Mon, 11 Dec 2023 20:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702326107;
        bh=rBpsBQzFgdCR4uHw0YOyenL0nzKHxfcOgHqKnrLFUgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsnscW4ZZ5eBgpkU295ZqeOTsNn9/RTDGLj7cdzfkE8r9Ykj9rjeLJWZOosb66RpM
         PcruomYoMTgkCOxzS7igzpPDXBSXxzbMKwDpyKmEn52XohKoXrPW+E4FaeTUTZn/vf
         TE3qxb83kDoO9+z3I2BE7RP6RRCqeG9Oazz/sB5uqVqZtClli7+l5e1u5pkoTigTEa
         V3YMc/Mulx67x28a+6szulTMl72N2/2hfHpb/71TBZBlG9ScNb/+3rwtjq8LhVoRYf
         6jiEm7qGsyygnUZxQkZrZl+HWG8LWyMUyl4ymFPGxjkqmV0MNZZL8RX+rQMmNkD3Hl
         7I/AKm1Q3PoWA==
Date:   Mon, 11 Dec 2023 20:21:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, ryan.roberts@arm.com,
        hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
        rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
        jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
References: <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2t6rLyxDF+xX0gNK"
Content-Disposition: inline
In-Reply-To: <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
X-Cookie: Better dead than mellow.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2t6rLyxDF+xX0gNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 10:46:23AM -0800, John Hubbard wrote:

> Or (4) Hack in little ifdef snippets, into the selftests, like we used
> to do. Peter Zijlstra seems to be asking for this, if I understand his
> (much) earlier comments about this.

I can't help but think that if we're having to manually copy bits of
the uapi headers (which are already separated out in the source) into
another part of the same source tree in order to use them then there's
room for improvement somewhere.  TBH it also doesn't seem great to add
additional variables that depend on the user's build environment, we
already have enough build issues.  It ought to be mostly tedious rather
than hard but it's still a pain, especially given the issues we have
getting kselftest fixes merged promptly.

--2t6rLyxDF+xX0gNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3b1IACgkQJNaLcl1U
h9D6XQf9FJcaZ/aSuBGP4yhVAKDtuYM+O0Qsar4MJCFGlNRbAu/ep77u/lb6SiNm
LU23BBBAiqPUIKnMW5exn+9u4d7eZg/jgUqktFGJQUooAZXP7tesJ2juToB11Von
QMaHZ51yQWx/4vduSYWRr1jeH6bKVsC4iUQD8NAxCP7NgC5DqzoKkZUshRIJ1UPa
m+TgJ2pDfv6sHcEeBnNvfGIUR7AtUlR+CyGsoRs+vv1EUYGuOmV46mf4w34U1FUc
cSDhODvruTSYW8nNp0yvLcfzC+vgcC6N24IvLy06fYwhVWLsPx3dL089H+FYubVt
1ik547NSpFhk2Unxhvfsaj1pgPYtCA==
=lcNl
-----END PGP SIGNATURE-----

--2t6rLyxDF+xX0gNK--
