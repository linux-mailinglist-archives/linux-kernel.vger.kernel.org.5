Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1497F3A31
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjKUXTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKUXTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:19:39 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7CD191;
        Tue, 21 Nov 2023 15:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700608768;
        bh=b5S8PhyDNaqpjhQ3AdC8IVlzThxl2BTRySzUXsB/ed4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d1VT5tu38x4XeY7kl53qnvK+czw16sjHHEn8YkPec470srLc7wSuxkAOquR15O52v
         PCfIEuV2B8/o+IV7Sb3x3pcd2fHeYhTjLm3oiL7tQ/G1xkx/nginZtAzxd5JRV33ws
         bg3lxfb+VIm74Tj62rabVP07EM3gE6iT6JPZ3Pzxjq8T1wyYqlT4AkSOC4kYTvJnkg
         mRTyVupD+Oy/XQHfSLXoexnPKMmcR3/Gk5zsqOUWNsU9kkRy74eeKnW6+14L0iCq/W
         wgyhoOQDJfGi1UjxT1AWx4u2tdioyAadnVjuPqRRHIxv3T51+/UgpJ4+6DWK9j/4cO
         KscXwoJI4VFJQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZgLm5npSz4wcX;
        Wed, 22 Nov 2023 10:19:28 +1100 (AEDT)
Date:   Wed, 22 Nov 2023 10:19:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the kspp-gustavo tree
Message-ID: <20231122101928.55737aac@canb.auug.org.au>
In-Reply-To: <9d3b74ec-4a92-4304-b8ee-5f70711666bc@embeddedor.com>
References: <20231122094739.38465ed3@canb.auug.org.au>
        <9d3b74ec-4a92-4304-b8ee-5f70711666bc@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qt+66Hc7FyNiKezeMwZQxEY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qt+66Hc7FyNiKezeMwZQxEY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, 21 Nov 2023 17:07:32 -0600 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>
> The fix for that shows up in linux-next already:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commi=
t/?id=3Dca76817f4c4bbf8f98268772f4eeea8382a34bcd

OK, so if maintainers are putting fixes exposed by this change into
their own trees, I need to merge your tree last then ...

--=20
Cheers,
Stephen Rothwell

--Sig_/qt+66Hc7FyNiKezeMwZQxEY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVdOwAACgkQAVBC80lX
0GxJTQf/XcGCb/6R8HtVM47FtFqz/4WyRtiBDdlAf3hVxDLxMdIO16J+lKHFL2IS
XoBzUJv5jELiNQrci7U//bsVUEkIeh6PFFjp66+3CNEWgqVuNuUMgPtTZCDr3glR
2KePX6WPQlJPJYByP/0iJpNY7ItbNX+pC579UzRuxfkdNvizrz/OEWOJO0/78Ub6
99rBh9M4+T6VAo+t/ykTfqjKDjbinFITVMR7izO62MNTb3Emj0klMfzChhsbZt/t
+kr67z3Sb66+CI13yEupTLm4z2Vw5LG/4ruhnX2dbkv0qeubm4Hh6ZZG643I2YJn
6DeMZqFSQtExDy0AHwuS0z2ya8CK2A==
=kSGT
-----END PGP SIGNATURE-----

--Sig_/qt+66Hc7FyNiKezeMwZQxEY--
