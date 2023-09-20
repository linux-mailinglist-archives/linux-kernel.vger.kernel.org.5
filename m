Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993A77A70DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjITDQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITDQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:16:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1453B0;
        Tue, 19 Sep 2023 20:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695179803;
        bh=FcvIPU8fNd+lk476FhRdjCbsI18VwXUWxLBtQhlI8Do=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uTj7Qs2doGAyGTFb4DBqiicoqosO9njoSZlOXOSf6KbBAqzquHKySyjjUmvDUNf9e
         Q8IGYZKgdGpZnq1dOVKsKgchAdNjbxCygG82QSGzaNILXxcmVfzGUKoTVIyPyJPIK5
         GPlCJGA7y3ZMWIITx9r0ruy4ibIW0qUg7T4MrZvWwEGXmmhdvGgI9sfzepVH2cOpmT
         7hEpMNVIaISZQIUdW5EYIoX5ugUJJq8ev5c9aiE66HhcsBSY1mlMoCKWYTAYeHQ6+0
         qWsPRwAgl2S0WDbZYBRSZYmDozykFGkw0OxkO7nOcFPq2kuxfzS1SVMkWk72uK2tpf
         g0ujCUjUbxcfA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rr3bb3zZjz4xSb;
        Wed, 20 Sep 2023 13:16:43 +1000 (AEST)
Date:   Wed, 20 Sep 2023 13:16:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the btrfs tree
Message-ID: <20230920131642.62803bd8@canb.auug.org.au>
In-Reply-To: <20230912222006.5a7cab3d@canb.auug.org.au>
References: <20230912104646.3a9140f7@canb.auug.org.au>
        <20230912112011.GB20408@suse.cz>
        <20230912222006.5a7cab3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FAG_enEudv=Du=Dqq6jepBd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FAG_enEudv=Du=Dqq6jepBd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, 12 Sep 2023 22:20:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi David,
>=20
> On Tue, 12 Sep 2023 13:20:11 +0200 David Sterba <dsterba@suse.cz> wrote:
> >=20
> > I tried 12 and 13, no warnings on x86_64, however the report is on
> > powerpc. If this is on a big endian host it could be a valid warning, we
> > have an optmization where the on-disk format endianity matches CPU
> > (little endian) then the structures btrfs_disk_key and btrfs_key are
> > equivalent and no coversion is needed.
> >=20
> > There were some changes that might be related and newly added to
> > for-next so we don't have any other reference point, I'll take a look. =
=20
>=20
> This is indeed a big endian build (big endian cross build on a little
> endian host).  I also did *not* get these warnings on my x86_64 build.

But I do get them from my s390 defconfig build.  Any progress?

--=20
Cheers,
Stephen Rothwell

--Sig_/FAG_enEudv=Du=Dqq6jepBd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUKZBoACgkQAVBC80lX
0Gy70gf/YmluHlhMP7eWESvTvE/NAroQsV7JJwxxnANNjjFzVbgss+VXC73QpW4e
ZdxoxMPNvpb+I6dejb7+rmpjYYaW7VLgH2oT+Zqdq8GM6wRP3ULiBMQVoKK85DPC
mzh9eb0mrbvdCr125ix4ShAdofmIdQMTIALnfASi4ffCxq/lStlBZGEXeasbUdcS
pzQxGGWjDtmgvVkGlee8h6hI4LZw9M8ebiiW9mFlc1+efNHDODSU8V6IP441dQs2
mNNr+JsXiYO8i2AmSKOZ0BVSmPUVS7mwYe0dvYQJDLsJdQ0wZtgE9wpJYvjsr/n5
Xf9Ua6vidk8lxb0X1x9NpWKxisxMag==
=lDmk
-----END PGP SIGNATURE-----

--Sig_/FAG_enEudv=Du=Dqq6jepBd--
