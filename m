Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3E87BD747
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbjJIJjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345950AbjJIJjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:39:21 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 02:39:19 PDT
Received: from gimli.rothwell.id.au (unknown [IPv6:2404:9400:2:0:216:3eff:fee1:997a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C898ABA;
        Mon,  9 Oct 2023 02:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
        s=201702; t=1696844030;
        bh=7Tii3g9U6G/x9SePXuUyMBs1rZtti85D/mR5NtmK/qE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q7iW/nXMZFqka2P7UXx4t3Vn70Dq7yAJQKdkKBIhSR7IF3bfSV5cM7lOdpad9vYLC
         cey0b8iaoz8y+ENHu1XHBD5/fJbpBuoSvFEoQdqZSWcAiX3lSdgqXLCxtkQXksFDh/
         X7nw0JgLHNVFXoTgFDl7zzBC63Ljgul0p9jmsZ2BsEjwqCo7hDzA5DLdyL4l2SXQ2x
         hpL2SB0SM6RXfa5Qx0waQ/VIAPygqxKl4dXR8YeIDXQiNteTDflmPJgD5LlK8K075z
         oB8vplm8gl4J3AvlP1wv9YxHCY3vqpBqvWRQdC41eVCFJO8Y7m2+5IhWr/Rog0PVtS
         47+uuWb2b5paA==
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.rothwell.id.au (Postfix) with ESMTPSA id 4S3v3s2vcZzyP5;
        Mon,  9 Oct 2023 20:33:45 +1100 (AEDT)
Date:   Mon, 9 Oct 2023 20:33:24 +1100
From:   Stephen Rothwell <sfr@rothwell.id.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <20231009203324.4199996a@li-c0a070c6-1ab2-11ed-80f2-9c2dcd447373>
In-Reply-To: <20231009084812.GB14330@noisy.programming.kicks-ass.net>
References: <20231009123118.4487a0e1@canb.auug.org.au>
        <20231009084812.GB14330@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4/QzaOFuP7i.EOVOmikz9T+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4/QzaOFuP7i.EOVOmikz9T+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Mon, 9 Oct 2023 10:48:12 +0200 Peter Zijlstra <peterz@infradead.org> wro=
te:
>
> >   #define __NR_fchmodat2 452
> >   __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
> > + #define __NR_futex_wake 454
> > + __SYSCALL(__NR_futex_wake, sys_futex_wake)
> > + #define __NR_futex_wait 455
> > + __SYSCALL(__NR_futex_wait, sys_futex_wait)
> > + #define __NR_futex_requeue 456
> > + __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
> >  =20
> >  +#define __NR_map_shadow_stack 453
> >  +__SYSCALL(__NR_map_shadow_stack, sys_map_shadow_stack)
> >  +
> >   #undef __NR_syscalls
> > - #define __NR_syscalls 454
> > + #define __NR_syscalls 457
> >  =20
> >   /*
> >    * 32 bit systems traditionally used different =20
>=20
> This seems to have the hunks in the wrong order, 453 should come before
> 454 no?

Oops, fixed thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/4/QzaOFuP7i.EOVOmikz9T+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUjyOQACgkQAVBC80lX
0GxJkgf/V9M3tXfSUDDtjMGFt3l0mBHvvrZV/qOYoRDWmqSpZViaAuuKgeUA89OO
+tTkNN1fnSBAkHAPb/WAfDFl9pj9a/3rV9R3vhLhIyU8zgEUhGQDV7e9kT0fYtF3
ttitXpVLxEmB0vtAB8fQf7JIh205Xuoj7uqkcdSBHKCwmamq+Yck42uk+ujrV5c2
lkgtzdF3PNDnwBAfXt2WXeZx85ZEqZgmJyUJ9oyz9v76FFbL7OlC8UVUZxFfL+FG
Tdefdc+sn2nKBzM1wItAU0OPsKYcbahG5yVVkVjzC3dxscGmydWD1XWhk7tyjPy5
Y239TROjJ1wHeDRfdVot9VNqsHOnZw==
=SS1c
-----END PGP SIGNATURE-----

--Sig_/4/QzaOFuP7i.EOVOmikz9T+--
