Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6A80EFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376499AbjLLPO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376501AbjLLPOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:14:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6684F2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:15:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4426FC433C8;
        Tue, 12 Dec 2023 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702394100;
        bh=oGVr7zPlcrVYpok1WC00xYCvHeubPWaAIUYuFIBTxIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFFIZs3IJ110sA2RLnvBq3HY3f0/ITUybpr+HZukAawXy4XKQAje2eeWlkvoomCjf
         QpcR4y4y7g865okSTznFDLpP4z+O2SlOCsz3Rlh7OX/tejONnJhO+EN5Vf9mdtk49o
         FpE89ON4XJ67L7OSxzlvAnhCjEX2i4HJ5685DumOlFIyXfig9XMNQZ4SVNSApOuarQ
         45Azymp2KkihHU4fK3I7Pty4YFNrED6EyFGnXJ7iKvp/3SmxR4pGIYXmhugNqW6UBB
         EUllqfWG6ODM07vN/7W4Ex7NACDzEQjNaMOlWD/06pSThKdEO7nkSpQkK40rlo6waL
         wv3rOW1oTz58g==
Date:   Tue, 12 Dec 2023 15:14:54 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <anup@brainfault.org>, Baoquan He <bhe@redhat.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Chen Jiahao <chenjiahao16@huawei.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
        Frederik Haxel <haxel@fzi.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nam Cao <namcaov@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/3] Fix XIP boot and make XIP testable in QEMU
Message-ID: <20231212-crabmeat-flatness-3c0d02966551@spud>
References: <20231212130116.848530-1-haxel@fzi.de>
 <20231212-customary-hardcover-e19462bf8e75@wendy>
 <CAM4kBBKBC=ZSQPzAq5MFQvd1g9=Up_oRAK5CV74oJHt=SbcPqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+0u/nDWT3CkbhlUL"
Content-Disposition: inline
In-Reply-To: <CAM4kBBKBC=ZSQPzAq5MFQvd1g9=Up_oRAK5CV74oJHt=SbcPqg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+0u/nDWT3CkbhlUL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Firstly, no html mails, they're rejected by the lists and break people's
mail flows.

On Tue, Dec 12, 2023 at 03:16:13PM +0100, Vitaly Wool wrote:
> tis 12 dec. 2023 kl. 14:23 skrev Conor Dooley <conor.dooley@microchip.com=
<mailto:conor.dooley@microchip.com>>:
> > On Tue, Dec 12, 2023 at 02:01:11PM +0100, Frederik Haxel wrote:
> > > XIP boot seems to be broken for some time now. A likely reason why no=
 one
> > > seems to have noticed this is that XIP is more difficult to test, as =
it is
> > > currently not easily testable with QEMU.
> > >
> > > These patches fix the XIP boot and allow an XIP build without BUILTIN=
_DTB,
> > > which in turn makes it easier to test an image with the QEMU virt mac=
hine.
> >=20
> >=20
> > Are you actually using XIP in something other than QEMU? The fact that
> > some of the blamed fixes are over 18 months old suggests that you are
> > not actively using XIP builds of the mainline kernel.
> > There is a desire to remove XIP support (among other things), so if you
> > do actually have a use case for it, speak up.
>=20
> Yes, we surely do, on K210 for instance. It=E2=80=99s using an older kern=
el and

The k210 and nommu are on the block for removal too :)
Is your use case for either the k210 or XIP something other than
"ooh this works"?=20

> I haven=E2=80=99t checked the mainline status for a while

I figured that when the request I sent asking if you could test XIP was
ignored. We've been 50-50 on whether it has been broken since Alex put
the dtb in the fixmap ~9 months ago.

> but it is likely that I will come up with some XIP updates
> before Christmas.

May I ask what you intend updating?

Cheers,
Conor.

--+0u/nDWT3CkbhlUL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXh47QAKCRB4tDGHoIJi
0iegAP9vWnOsipXucsygK4bN5Fqo+iSWJF0osyBy+ir9UgSb2wD+Nd9s1gKWU8L2
pYyXJfR4gVj/PQI7ZKedSn3V3zOz5gM=
=xLOI
-----END PGP SIGNATURE-----

--+0u/nDWT3CkbhlUL--
