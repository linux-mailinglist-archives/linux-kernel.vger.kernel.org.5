Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25D2783753
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjHVBWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHVBW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:22:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEC184;
        Mon, 21 Aug 2023 18:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692667341;
        bh=QsNDGFvVo1SvxEvhU10jBdQRvP3U/A2CgPljhigcvQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lc1ahpj1fWUVwYlCjg/HPm13YYYVnVyCLWQC8lbkw04saXWFi2yu8wC1Jv8iBaoWw
         o+C/wq2UFi/FzQqou+SQa5Rgqzy47ZMQTscW3nkmJo4aLpfnSkenVcZN9ByuWL98w9
         wKf5Xn+W8OEgiHEkV6eEn1rA+Cnssd9HGrcRklIdC3btw3XnFhWAjq3HAy/iMpiK+V
         xx3wQdDESzeMEbIALJ4wDINggUCpHuOdWGaz8wSXNXV0cH0cR8JJIBKGlCtpKz/ETv
         X1yUmWp655AzuJ/CpImlcFgjGS2oZVWKMlIQSTvb85iPVW6JwPhCsHpTdGCof59Fiq
         99711Z8IDpy/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVBR13HQ0z4wxx;
        Tue, 22 Aug 2023 11:22:21 +1000 (AEST)
Date:   Tue, 22 Aug 2023 11:22:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230822112217.185c3357@canb.auug.org.au>
In-Reply-To: <ZOQLUMBB7amLUJLY@casper.infradead.org>
References: <20230822095537.500047f7@canb.auug.org.au>
        <ZOQLUMBB7amLUJLY@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CYCJ/0.1wJKizPBWXmOeEhD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CYCJ/0.1wJKizPBWXmOeEhD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Tue, 22 Aug 2023 02:11:44 +0100 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Tue, Aug 22, 2023 at 09:55:37AM +1000, Stephen Rothwell wrote:
> > In file included from include/trace/trace_events.h:27,
> >                  from include/trace/define_trace.h:102,
> >                  from fs/xfs/xfs_trace.h:4428,
> >                  from fs/xfs/xfs_trace.c:45:
> > include/linux/pgtable.h:8:25: error: initializer element is not constant
> >     8 | #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT) =20
>=20
> Ummm.  PowerPC doesn't have a compile-time constant PMD size?

Yeah, you are not the first (or probably the last) to be caught by that.

--=20
Cheers,
Stephen Rothwell

--Sig_/CYCJ/0.1wJKizPBWXmOeEhD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTkDckACgkQAVBC80lX
0Gw/wAf/SCxysM9kgwBGXjE8mdNaMmTV0RuXSW5fILUfaH2K1bwzirH/1UYXENFe
h78SXWxhzCtvQsEpLMYiaNRdaAsbFwXebMAreYkEVSA7y+QWZ+PyIlLE7/cjjSpO
RPe10UzO/fdzXdjzz8Ll3MvCLgMiPxUWoonouaBz7roLcv8EAjEjXl/TS5fcQoqp
XFZLn4PzY4HH7tNI2pVBhH8bhELoX8mU8FC+h3a2ygQSANdASi9u/2BXAroJVbCY
7AwW30IKzdD0JJnmlsL+59JyaMEE9Pd1m+o3JzXkoi0MJicvpKiL3oIss2z74vfH
7bupmKGqIkxtkbHGVd+UWhsMJWK/Iw==
=u0m7
-----END PGP SIGNATURE-----

--Sig_/CYCJ/0.1wJKizPBWXmOeEhD--
