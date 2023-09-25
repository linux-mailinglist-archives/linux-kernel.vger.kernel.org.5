Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984907ACDE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjIYCJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjIYCJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:09:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5757FBD;
        Sun, 24 Sep 2023 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695607750;
        bh=+SCBDn0q8B6DTEvvnRcSanfG3DjyzjZiz9jofyzapQA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MolaEwdkMhDlTfq/lY2uFKfabcxoC7tOWNqG4dzf8ZVZtlB0ZUoyiMN0MJGiNkBz9
         st7yy6SI21x4mMV1YFQR83LTxao7LWs07kqd5ml0tuqmG5obZsmiR+E/CJNzJJKZYY
         6jAy4C03CHgHdx6DQ4/qii1OCt/nvnHDjK6kIufIzD6gexUJC8AhvwA7pt48Cc28Zq
         EF/RxFcwbRWhXLzsp97cH7pUXsm7cFAIp79OSwZYe52b5hOQPIX2dRjrIeYbNC1hC7
         JuhMxyHR/uwAIDNLmdpX8PO1kLM7jG2ti5o4cCZvyvc/+Nob/gKC2yPZzXPwCc69v7
         gwdQxSGPr2wng==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rv5sK03fRz4xNq;
        Mon, 25 Sep 2023 12:09:08 +1000 (AEST)
Date:   Mon, 25 Sep 2023 12:09:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <20230925120908.4b15c44d@canb.auug.org.au>
In-Reply-To: <20230925120544.7b1baece@canb.auug.org.au>
References: <20230925120544.7b1baece@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4iDlT0te4T54MwelldPzrRR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4iDlT0te4T54MwelldPzrRR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Sep 2023 12:05:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the block tree got a conflict in:
>=20
>   arch/ia64/kernel/syscalls/syscall.tbl
>=20
> between commit:
>=20
>   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
>=20
> from the asm-generic tree and commits:
>=20
>   9f6c532f59b2 ("futex: Add sys_futex_wake()")
>   cb8c4312afca ("futex: Add sys_futex_wait()")
>   0f4b5f972216 ("futex: Add sys_futex_requeue()")
>=20
> from the block tree.

These three commits are also in the tip tree.

> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/4iDlT0te4T54MwelldPzrRR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUQ68QACgkQAVBC80lX
0Gyp6Qf/SOObiUMbuIWhKFwtS+J/xHobxRAjLrucovzWZl/mNLjzy1gR451WVNFH
wl9ZNbhEprauHPuofzEIfXnFnl7Saz7Igkd4jtKa5l+Dt8dzVAdHrbKhhcheKuz2
EcH7RmLkHEUVFEkWPL7UBGNhI9lbel+ZhA+Iuz0Qapp7ouxVb0oYT/g3pSFWjoyr
Fgi+ubk07H0OipoodFLB+EwJkACFySplZiVm4HaNS8VHpu6zMdpRgan2g14KqCGX
unrLRoKmRJlFO67J5QcLwHd5Go+Xlu9sro+8faD5B9SCp7+uYWlnFLL1rGdP5U71
Is9zk5mln7BixxQ8+BiZ6I+xnWcCkQ==
=THaW
-----END PGP SIGNATURE-----

--Sig_/4iDlT0te4T54MwelldPzrRR--
