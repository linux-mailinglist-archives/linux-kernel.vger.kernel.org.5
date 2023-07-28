Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391B27660C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjG1A3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjG1A3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:29:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA23582;
        Thu, 27 Jul 2023 17:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690504177;
        bh=X8AmoRd7j6IOIhRCdXxSiOZ/cStGRBhbymInXzXdygQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VUmhHHPPqDvFFoYhKV7MGwCD15EfGQhAd+AIV8nLJGwAmHlNH/9DIML6XHiCP1gKU
         mqXukKq4mkoqca+QjVCv1iDF3c030xeHhpKkavrtI5VElK5cewJszDnUEdtc9rWWkT
         kCj3G0+uyz8lbqBEfSxWfac9SgMvWBVk2KV3BZfVSp9PceUBRdV8ASArO4Hob6UCcf
         c1GS5LICBqxbNwyxLaQoRPseaN9uBH3BKNeJu286TWa/PqhnWybycgpdbQ0j+X1ZoA
         f2Bhfa6UjOEZ4XXSHevPNa4/wKBvi10sJBAoOUlNiH1hS/KnorndUX/FMg5jYMl2Uf
         VwOBVw/DaTYWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBpRj1R6Pz4wqW;
        Fri, 28 Jul 2023 10:29:37 +1000 (AEST)
Date:   Fri, 28 Jul 2023 10:29:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230728102936.66ac5481@canb.auug.org.au>
In-Reply-To: <CAJuCfpHzz3f8Ru7C03b-TVi0g1gcMOEkd2v=ayNunEEs6cjZxg@mail.gmail.com>
References: <20230728091849.7f32259d@canb.auug.org.au>
        <ZMMCnvc3h7XT/NM2@casper.infradead.org>
        <20230728102022.7593856b@canb.auug.org.au>
        <CAJuCfpHzz3f8Ru7C03b-TVi0g1gcMOEkd2v=ayNunEEs6cjZxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ibcE64FQAK_yk=G3_xqGofC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ibcE64FQAK_yk=G3_xqGofC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Suren,

On Thu, 27 Jul 2023 17:23:45 -0700 Suren Baghdasaryan <surenb@google.com> w=
rote:
>
 Hmm. 657b5146955e ("mm: lock_vma_under_rcu() must check vma->anon_vma
> under vma lock") should be adding a "inval_end_read" label. At least I
> see it in https://lore.kernel.org/all/20230726214103.3261108-3-jannh@goog=
le.com/
> and will check Linus' tree in a min. I don't see that label in your
> patch...

It's there in the file, but did not conflict with anything.  What I
published is not a "patch" as such, but a diff showing the conflict
resolution.

--=20
Cheers,
Stephen Rothwell

--Sig_/ibcE64FQAK_yk=G3_xqGofC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTDC/AACgkQAVBC80lX
0GzTHQf+OXi69pT60/0oRH3j3DOf4ju7DTL6TG9umapsSJ3UzJdRhz8k35gSW8NR
7adT/rHmqegKfUqlLP3ybAXDGI1eGSKVLBQp5pTx0EeIe36o+zGBRwNECADwmo9h
YaFDvVceDEVC8VQcyqVLz+ny45cvIdS/Fn0jvny2S/xIM7BTJo0OPwFWoKEpX+Pz
86rKQKIUiJtJBIj4oDwBv23b5FzfQjO0OgFRNouJK3kLzHiBfmITzLtThY0ANQhv
I/TUdFyB9SGA+navuFvbJ0GWElvRF6F8tfjNY+OJOJ+1t18E+hX1G7qQ0lyfzwO+
utMDB6Ku0IOLkVszSM2xv9E8SsaLiA==
=onmo
-----END PGP SIGNATURE-----

--Sig_/ibcE64FQAK_yk=G3_xqGofC--
