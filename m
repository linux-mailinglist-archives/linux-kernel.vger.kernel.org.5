Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F12D80D1E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbjLKQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344657AbjLKQeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:34:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1134D9E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:34:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B704C433C7;
        Mon, 11 Dec 2023 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702312463;
        bh=QbRrkITDgkJCeqMLW1qe7fhOw6lXgNPsb71J+dKjZmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jvCSSld6cPnM0hPRvec27Uh4IabHwsQOX/uckEDpbEWgTGwQazayJJ4XiuOn+Qb/G
         pq3jhFh9QpiE2ALVq6eMdLaqmNVlg2GQmuhYKMgecgNKIhoxDuTI76Z6/3aIWhaq+7
         VJ5nvlSP54hGmFneWqBusqIYEN6/V4gcPdl3hhhHEpfikqwhglHfbVZKry8UuZ4R03
         VSDYaWJIKJFB3D24kBFZaqrZWuKYgp8KXOYtczdFemKB8xe+i89Q/gP+hutiN+lHKn
         JP7zcC2tVGndaAXyQS5qGibfr1DfULsbXVBMQeTXX6+kQBzVWvfbg4R1E6NsKTlHDU
         5yw9Mt/hxq9oA==
Date:   Mon, 11 Dec 2023 16:34:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
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
Message-ID: <915d2f82-0bcd-4992-9261-81687ca16e9f@sirena.org.uk>
References: <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <9d06d7c1-24ae-4495-803d-5aec28058e68@sirena.org.uk>
 <CAJuCfpGEbGQh=VZbXtuOnvB6yyVJFjJ9bhwc7BaoL4wr1XLAfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UmzPtGFsmRTmz9FI"
Content-Disposition: inline
In-Reply-To: <CAJuCfpGEbGQh=VZbXtuOnvB6yyVJFjJ9bhwc7BaoL4wr1XLAfQ@mail.gmail.com>
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


--UmzPtGFsmRTmz9FI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2023 at 08:29:06AM -0800, Suren Baghdasaryan wrote:

> Just to rule out this possibility, linux-next was broken on Friday
> (see https://lore.kernel.org/all/CAJuCfpFiEqRO4qkFZbUCmGZy-n_ucqgR5NeyvnwXqYh+RU4C6w@mail.gmail.com/).
> I just checked and it's fixed now. Could you confirm that with the
> latest linux-next you still see the issue?

Yes, it looks like it's fixed today - thanks!  (The fix was getting
masked by the ongoing KVM breakage.)

--UmzPtGFsmRTmz9FI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV3OgYACgkQJNaLcl1U
h9B9pwf9EjjPpa2QYF7F1JyuE+gyyQEssW9afBJMvjjhu6DYQp+9i0USYwSk2/OX
t5c2+FWTXahvCkVtvHE9nmaCF44rS2gbhHkwABa/qA2+Pi/DPJ7LD6EgKzEZtY4u
hslaiTtYvx1R0ba0X8AHASRfzOvVis63I5eetswE9JeeEdM1i+IdwuO0V0tg6rTl
gFuxAkkW4uwgA5zLAYQIS3BxENIN1Uz9bxDMnmq/O7RWaihd3ArPhGYwWu1BKfoy
nqFpiREyp0b6s29XYAkveW1/xId23STrmpiRIJ3e3k97dotoW7VE1t5S9uT+g/iA
SCd8qIVMSFeFSdfOgyKyXJ+VaV+GYg==
=aBaU
-----END PGP SIGNATURE-----

--UmzPtGFsmRTmz9FI--
