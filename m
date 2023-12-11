Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C3D80C7C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjLKLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjLKLPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:15:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4989FC4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:15:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3666EC433C7;
        Mon, 11 Dec 2023 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702293324;
        bh=RN0s8CBgjbCxLqFraUoPfhHMhj3UEaksMF1EdYVCcb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGdnDlBbyPhSvst+CiF1w38ZpOeK558Jw8N+UpmPNyViJLmQQ+g0HV0Z19pvIR7iU
         5i8v8GTroF8wUTuURm2+avQW/SivHcUDrcbJ5pX9rqkwFSq1r92e3trEvXc3k0y/Ef
         bafTI4P0CNtcBv0DOiDxVbOr98ALpffBXRxatfOrE8ozkTlOAV6c0dzhlhXwm4lYgL
         g24oJxyMkHWt+6V4YAPTPeqYKmsou6X+PQwn0RkLaAGyB3ILQOWSVHDLb7U1scskbT
         zrpP58ng92AGbhwFCwLdW9KQ/XG4MUl8R2Sisjg3pQANfwedpuDhL8zkJSB0Y8Qpkk
         1DtLTxjcqL2Qw==
Date:   Mon, 11 Dec 2023 11:15:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
        lokeshgidra@google.com, peterx@redhat.com, david@redhat.com,
        ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Message-ID: <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
References: <20231206103702.3873743-1-surenb@google.com>
 <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SYlO/FU6WXTPk3xW"
Content-Disposition: inline
In-Reply-To: <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
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


--SYlO/FU6WXTPk3xW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 07:04:19PM -0800, Suren Baghdasaryan wrote:
> On Sun, Dec 10, 2023 at 5:01=E2=80=AFPM Suren Baghdasaryan <surenb@google=
=2Ecom> wrote:

> > Thanks for reporting! I'll try that later today.
> > Just to clarify, are you using mm-unstable and if so, has it been
> > rebased since Friday? There was an update to this patchset in
> > mm-unstable which Andrew merged on Friday and the failure does look
> > like something that would happen with the previous version.

> I tried reproducing the issue but so far unsuccessfully. Could you
> please confirm that on the latest mm-unstable branch it's still
> reproducible and if so, please provide detailed instructions on how
> you reproduce it.

This is linux-next.  I pasted the commands used to build and sent links
to a full build log in the original report.

--SYlO/FU6WXTPk3xW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV27z8ACgkQJNaLcl1U
h9AxCwf/ejCSQ8c+qUs0HXMuJ4xPDKv1c+X9cLcAO/onhQH8kPEGi19DToONrIQ5
FGCMwydxN8bgz6H9JNORPkzBCD8/Kuw+orP4Ch6rEGhlXTjnDX6m2RE/9H9yx+WT
DlHZPMtV/N4G3ge5PAhP1t5VNdfDl59cEPsGaJJRt2GmveY32R6uW/zkLsgZwSvV
e5/Dr8+kp1tyZjXvyeMJPNJIdwdz99xBa5Y889K7NiWnBJs1Ex76vPVpS/seTWEt
R/8qjSd0Lo57V6AvhLNFjckVpJfnIiNy/nHMi88zYs7QqCFxVGWUuWjt1XSiw55F
THCwieKs2vPRegtsifZR831PsToQfQ==
=vyq7
-----END PGP SIGNATURE-----

--SYlO/FU6WXTPk3xW--
