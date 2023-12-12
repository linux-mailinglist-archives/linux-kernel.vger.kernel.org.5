Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F3480EFC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376472AbjLLPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjLLPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:12:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B20E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:12:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F85CC433C7;
        Tue, 12 Dec 2023 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702393942;
        bh=QHxKdB968+9G1qW19Q0elFcukvl/07+msQ/9qSNOuWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ToAop2WxsqPeCAWeT5j5Ot4c+vqe+c0c9/eBSPO/6+2vfYGiDTMmazBilH5Rk60X/
         Se2AP63NyFeTgkt+MUH7URECE7Z9R8CUVY7Xx2IW9Q9G/PBW5jRMaDsHJXxguHUJIP
         69ltjhDjxgv0yBVL2PA0dUkCPuHHUQLf0e6kByMBVlhfJl2flLgtLUycWU24mk+Qoj
         KDpK1wMmhtJQ1T5pI4dzAyDKaNWYmRKiR/MlLi59aVemG9iK3Lon1jJl/jwuAueCHn
         02K0wkVlI6LP5L4J36Mph5tR8WDWKK3bmwaS+hiwlz4rI3OFcVU9pVmwFjC7YxXpNR
         ZI3rSbZvpBruQ==
Date:   Tue, 12 Dec 2023 15:12:13 +0000
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
Message-ID: <0f97db9c-5b86-4f56-8463-2520fe79f709@sirena.org.uk>
References: <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
 <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
 <e3048458-726e-4b98-b2bf-908ea9066959@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rjhnOum+JKh0/0au"
Content-Disposition: inline
In-Reply-To: <e3048458-726e-4b98-b2bf-908ea9066959@nvidia.com>
X-Cookie: If rash develops, discontinue use.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rjhnOum+JKh0/0au
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 12:29:58PM -0800, John Hubbard wrote:
> On 12/11/23 12:21, Mark Brown wrote:

> > additional variables that depend on the user's build environment, we
> > already have enough build issues.  It ought to be mostly tedious rather
> > than hard but it's still a pain, especially given the issues we have
> > getting kselftest fixes merged promptly.

> What about David's option (3):

> (3) Regularly archive the required headers in the selftest directory
>     like external projects like QEMU do.

> , combined with something in the build system to connect it up for
> building the selftests?

> Or maybe there is an innovative way to do all of this, that we have
> yet to think of.

We do copy files into tools/include at random times which makes sense
for things that aren't uapi, and we are putting bits of uapi there
already so we could just expand the set of files copied there.  AFAICT
the only reason we're copying the uapi files at all is that they're
directly in the same include/ directories as everything else and are
always referenced with their uapi/ prefix.

--rjhnOum+JKh0/0au
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV4eEwACgkQJNaLcl1U
h9DNVwgAhjdvx5btBIs0XvROBoWhSCo0Vy3s4M5v2OhKz5hwpav0C1t6Y7u5+YQ1
jonZ0ZQbbEew6o/zPQtcooNt6/HgrVqW1zrVGxzarxUWawcwk1lN8+cPZKNO287H
fQzpXaQou3R5XHUmQzHAIcy9WKZJC8PfFZJ4aLx8BhSdd/hf8VJ+OB2A3JlCPBaJ
XZ9wq6/ump80e8eRdwEX/LS3SBYj/KpKyHQ5lXeTCGTuZPDdstDcS+LVDgiBLsEx
HWeHttr3zJfs5scL3HiDTwvwsO6JDN81C6tCp4WkoJG9YnSHEWHxdTW0ARNvB2Jz
PtTLr7uHfBsiPFnLMkG6MqNPsmk4zg==
=TB+2
-----END PGP SIGNATURE-----

--rjhnOum+JKh0/0au--
