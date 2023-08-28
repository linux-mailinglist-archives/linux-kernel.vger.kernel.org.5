Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6D578B3FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjH1PGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjH1PGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:06:42 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9C12A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:06:38 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 61A751C0004; Mon, 28 Aug 2023 17:06:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1693235196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yylICwaQdM/26lHIrVTa5TKyfRjIX2nH4uItYnG9dAY=;
        b=ajed7GrFSS+9MqlzOZkIPs88QvcXTfIDIxp2rmQJliUcX89JPxLm1mV9jdnaR4yrZlT2h2
        K4LbbfyoWNx/n83dDbBRpzpAvEMq51U6hryYVWPL/bmx7W7Ep8HPNiHUfREY+iGVqca11s
        o91fW1BKTxeaiIcH7rWO7B2ClzTJyBY=
Date:   Mon, 28 Aug 2023 17:06:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joshua Hudson <joshudson@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: System Call trashing registers
Message-ID: <ZOy3+8qKfQxyrWez@duo.ucw.cz>
References: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="D5ueYtbMZb/DnLu6"
Content-Disposition: inline
In-Reply-To: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D5ueYtbMZb/DnLu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> 1) A lot of my old 32-bit programs don't work on x64 linux anymore
> because int 80h now trashes ecx and edx. This hasn't been a serious
> problem for me.
>=20
> 2) syscall is documented to trash rcx and r11.
>=20
> What I don't understand is why this hasn't ever led to a security
> issue due to leaking values from kernel space (in the trashed
> registers) back to userspace.

I guess you should cc x86 maintainers?

I guess this is a regression? When did it start?

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--D5ueYtbMZb/DnLu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOy3+wAKCRAw5/Bqldv6
8vDsAKCrucLlvY0dt79g3t5++aDqyoK7gACfWQxnrH1RD5WgvF/Ced2bvFJzZf8=
=BSgY
-----END PGP SIGNATURE-----

--D5ueYtbMZb/DnLu6--
