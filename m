Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589287F3D34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjKVFQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjKVFPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:15:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113711A2;
        Tue, 21 Nov 2023 21:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700630146;
        bh=sBU/bZ+FI04HRQr8KUpAG3G+oEHUx7aT2DD1neRzC4E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=by0I28/0Ia9PtGFkxTsnowDFQdz4092pbJbC6nc0mmm4Bh05SiaJVZUccmJ6yVO0o
         NB60sd4srA1VmCnHV2JSIuLPw+y1/gJfXAL8p4ZjIPz1Bvv0kW3TGpJ2ac/GB3QjBP
         ZFWsJLgtEzq64gkiyktUZxwnR0tITg9K7nN0e0DUEWMyHP9ZYl9vPgWzDn6B3uUcUh
         Iuf3bU6ET+q4GmDujMy1OgZ9xPmazcupmT50xpsMTRArSBg3ltLrJXVNR/VUaTJhWm
         HDrnzJ9woNlmLO7wGPXIDqqbw2W16pM1YJIfjWRvpjgCHSN6z1Sxn9olVnN2rONnb7
         vY9kGqI4hvYrw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZqFt2ljKz4xQZ;
        Wed, 22 Nov 2023 16:15:46 +1100 (AEDT)
Date:   Wed, 22 Nov 2023 16:15:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the kspp-gustavo tree
Message-ID: <20231122161544.7a7b8c13@canb.auug.org.au>
In-Reply-To: <7e58f7a0-440f-4067-87e2-381f05bfce2b@embeddedor.com>
References: <20231122144814.649823ac@canb.auug.org.au>
        <7e58f7a0-440f-4067-87e2-381f05bfce2b@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P_4PvN/owei9VOaqELGmQvX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P_4PvN/owei9VOaqELGmQvX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On Tue, 21 Nov 2023 22:04:17 -0600 "Gustavo A. R. Silva" <gustavo@embeddedo=
r.com> wrote:
>
> This doesn't show up with more recent compilers because it was an issue i=
n GCC.

Sure, but we do still support gcc back to v5.1 .. are there other
earlier versions where you may want to suppress these warnings?

--=20
Cheers,
Stephen Rothwell

--Sig_/P_4PvN/owei9VOaqELGmQvX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVdjoAACgkQAVBC80lX
0GwiXgf/W7PUQRjy7g6IroLCqEuyh0YPInNsu9hQTKahLIcRGBASypxJbI0YslHd
4h9uWWQ8/J1zeQx7PcQ7WwYWOZIzTDX5xxtN8IX+MUGb7/uPKiQ4zCn5QobnkayC
5b6Xn89YXFliIMHaD8kmR4vUskVRQJ9STjnBob7FLNxSuJlJH2giXWXboduiwu0h
zFa2mnKHiCO/LKdST6TTClgfl94oi9kDz4eyf/oA9PAN/mCioyj9v7B7dZZVg0fg
6l5Wm/x7LR7dIiLQq5uTWgk2OmOQ5p2BSwQ8CGu/dZiMcouqzPN01U7HpkQLheSl
LJIwL50xmhE4OuRopDmpZbwUvQosRQ==
=BX0M
-----END PGP SIGNATURE-----

--Sig_/P_4PvN/owei9VOaqELGmQvX--
