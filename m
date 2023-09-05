Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FFE793230
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbjIEW4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjIEW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:56:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A0A109;
        Tue,  5 Sep 2023 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693954557;
        bh=3XId0jONKqadAc4zqqlX4pcPTQERznsFccoeD/kMRek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LwH9Sss2bP0ZWbt+6rcbqyrbqao3NbGWGddiKdLcd82JrWInLPQTYpG7d5G7lmEsc
         ELY+lIeKm97A+RJePAKolaQ/9vOzLKAhuGHDRz8ktKAiSTSAnqJYRD07/1NgOQRbU1
         diy9e1ncHD/anxnKblQ7QKbwrh6jjEOs+NAuLdhxH8OKJML1Xi6dkm//2Uj/eOB/DA
         D8RddInvzNl7iDIDtEQrmD7F38ZLowyZLK19tWS5OtxzFeOQRBpHZ3qKJcnT/9B/wV
         lfIUo+8cFImKo2KuaK+6GvMMkoWnecEwlM+Q1fuBB/ciK8bXTSsIrE3axrsm6Bt8At
         JZ/kAM/HYnkew==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RgLT90mB3z4wZJ;
        Wed,  6 Sep 2023 08:55:56 +1000 (AEST)
Date:   Wed, 6 Sep 2023 08:55:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the net-next tree
Message-ID: <20230906085543.1c19079a@canb.auug.org.au>
In-Reply-To: <20230626162908.2f149f98@canb.auug.org.au>
References: <20230626162908.2f149f98@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C=JbFxGsBsPUPIzAGxJl0I/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C=JbFxGsBsPUPIzAGxJl0I/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Jun 2023 16:29:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the net-next tree, today's linux-next build (htmldocs)
> produced these warnings:
>=20
> Documentation/networking/kapi:144: include/linux/phylink.h:110: ERROR: Un=
expected indentation.
> Documentation/networking/kapi:144: include/linux/phylink.h:111: WARNING: =
Block quote ends without a blank line; unexpected unindent.

The above 2 have been fixed.

> Documentation/networking/kapi:144: include/linux/phylink.h:614: WARNING: =
Inline literal start-string without end-string.
> Documentation/networking/kapi:144: include/linux/phylink.h:644: WARNING: =
Inline literal start-string without end-string.

These have not :-(

> Introduced by commit
>=20
>   f99d471afa03 ("net: phylink: add PCS negotiation mode")

--=20
Cheers,
Stephen Rothwell

--Sig_/C=JbFxGsBsPUPIzAGxJl0I/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT3se8ACgkQAVBC80lX
0GwbWQf9FzzktAAjAwW7RkETxqWfalD0JJhygSWHrcxb1a/kHPQdXxKVoC1eQO85
9dUKfZBnBqRK0nAgn3o/JHud4QM+dhVCy/1duFjw9MBdY3vT+AWzFv4YzQKvNaC6
rT2Z2ctssaUZ8I9yYbXGxWBJyvSywqJGdPM41Cm87rkNk7XRjJ/FlqbIn6Fjnm3c
isII8+dJvOZHtoC0oImi1Ki0zwU/MRkChkz6zl5WBw8dhkt8sft/5Suivc8tx1qz
7gjHD9xkV/CiXo7uCcD9lzdPaEfQJHxF8njiN/STgJVpFgtQ2x2H4e41lDf8ELbt
yl4tzaNDXykeMdAzQGNs4TgDK+6YFQ==
=RkUu
-----END PGP SIGNATURE-----

--Sig_/C=JbFxGsBsPUPIzAGxJl0I/--
