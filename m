Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE96D7DC153
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjJ3UhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjJ3UhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:37:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A09EFE;
        Mon, 30 Oct 2023 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698698228;
        bh=kKVReQ2HLqh4fTYOxvEBglxLXvmXaMtUjWAkpNeYU7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d49XSugkWCJvAWMf3QFojxNIN7rVA5qDk8fwTw16oydR9kcSW7iOP+F/Mw2OiF9RE
         fYxoPhtBOyGgRmcJEFMOXtO7wzW6Ix7su/WvHbnlWOvNAJ3lS0tktdwxn37sbyromY
         +STHFoqWYJxRr0ZsbFXYXGt+u0BPjCj/gezDtSbXowaEp9N/LSMNUwSlMts5eOEC6O
         Dxi8nhQPZGqun7IUE/B5jQQDWZCdRkRzQfqfdbdUMatIYn67l2aeNfJ+g9jpc4tPXy
         MwvvGxGI/K7dOdpR66ubm/qOVxHOKCOL9QUVksQtevdErin6LyQvdRD5Uf+YDIhB+R
         kp0APj/eyOTIg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SK4nb1TvLz4wcX;
        Tue, 31 Oct 2023 07:37:07 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 07:37:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kvm-x86 tree
Message-ID: <20231031073705.512dab4b@canb.auug.org.au>
In-Reply-To: <3ed75fa4-6b49-4fd2-a907-8619ca19a8b8@redhat.com>
References: <20231030134806.24510492@canb.auug.org.au>
        <20231030-ignorant-liebschaft-6d603ab43494@brauner>
        <3ed75fa4-6b49-4fd2-a907-8619ca19a8b8@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//c_IGahhLhJSEaICQttXXNj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//c_IGahhLhJSEaICQttXXNj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On Mon, 30 Oct 2023 12:27:07 +0100 Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>
> On 10/30/23 11:05, Christian Brauner wrote:
> >=20
> > @Paolo and @Sean, does that make sense and is the series for v6.7 or
> > just already in -next for v6.8? =20
>=20
> It's for 6.8.

Then it should not be in linux-next yet. :-(
--=20
Cheers,
Stephen Rothwell

--Sig_//c_IGahhLhJSEaICQttXXNj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVAE/EACgkQAVBC80lX
0GzacQf+IU7hUvfEJf/a7GlUinmCdqlDvSaCdLIPGAwBQXMdX6/BKBSPlI7W5+Og
CUl0P/ll6XUzRNhJBbQSJJg4oik4d/HjX8OzVyOmKIqhrev+Q82qyV7kwMx2U0UE
jNCtFqClsfov7mhgu1a/W5kP23XesUD2i9rkSqtjVQz515J5Mu9uF04/267mnVpf
QQbrmY+SlmHc27RO3HKMqS+Z12EVsy7XTAXoO8RFO/vqGeiYIwJUH9poFlKwW3+g
FKpqncmXwlyqfz5aDZvcrK/2HlsuLifwCmDnDlJ7gwfSS+LzHuMvQmobBIxxu7Ju
CYT5tL6CCvvHgDjfk3Ky0B72TVtOYw==
=G2bY
-----END PGP SIGNATURE-----

--Sig_//c_IGahhLhJSEaICQttXXNj--
