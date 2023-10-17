Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1849C7CB7DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjJQBMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234433AbjJQBMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:12:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCA7AB;
        Mon, 16 Oct 2023 18:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697505154;
        bh=NMhSJLLZBb5jLZS62sR9J7ik/6UGL8vr11JDWG+rlKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DyZvcHzKj/P9BxPlXQNz4yvWSgXi9kJmHiicCTuJpMC4F9gJqG4zYyf1XhCFC7ud1
         DodIjx0xes41KY6QnCSXZmRQKO897vAHemWZXWKMSaIbtXp/dQ/e+WByQgOhCh2BHz
         /0CyWbY5HRmh8BXkmQM9pIiQln4bgZHC4VPJcblNx5BroLmRfkkoFUAYDG1T3LcRM4
         DoH2Mrfo2feKPBPuHQ5wftWh5vXpnYhO5648Q6CaSzqWQqB4b6jwre9y2C/7Bawctf
         /JREq63fxu1qZIDC3lwq6HguG1zAVw4zoayO9Y9c5CSZBe+9WAOJjO42ux5r0li9B9
         +QmrHghV1vikw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8bYr07llz4x1s;
        Tue, 17 Oct 2023 12:12:31 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 12:12:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <20231017121231.6f24c973@canb.auug.org.au>
In-Reply-To: <ZS0kKWsCaYHhKeHa@gmail.com>
References: <20231009123118.4487a0e1@canb.auug.org.au>
        <20231009084812.GB14330@noisy.programming.kicks-ass.net>
        <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
        <20231009141351.GD14330@noisy.programming.kicks-ass.net>
        <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
        <66e09ad5-2dcf-4159-9c98-f37ac739a445@kernel.dk>
        <20231011175407.GG6307@noisy.programming.kicks-ass.net>
        <ZScUhud9eqKIQJjC@gmail.com>
        <bf5ecd2d-06a7-4c51-a762-6fe3753044b6@kernel.dk>
        <ZScbKPQur2qao5Gf@gmail.com>
        <ZS0kKWsCaYHhKeHa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b3.gvt8g0i657AmabkNv=YK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b3.gvt8g0i657AmabkNv=YK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Mon, 16 Oct 2023 13:53:13 +0200 Ingo Molnar <mingo@kernel.org> wrote:
>
> Heads-up: the futex syscall numbers are now fixed on Alpha in the locking=
=20
> tree via:
>=20
>   dcc134510eef ("alpha: Fix up new futex syscall numbers")

Thanks.

> This would, I presume, trigger a new conflict in -next, which should be=20
> resolved in an identical fashion.

Indeed, done.

--=20
Cheers,
Stephen Rothwell

--Sig_/b3.gvt8g0i657AmabkNv=YK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUt338ACgkQAVBC80lX
0Gy70Qf/R6g0nDCE9/3ItjjYeFiSaIkYUigDYYZhAo5AYmEW4/TVE0E+rpoiLvHD
fXfzm2bN8pjXKTLDqWAZBi1t5qRPhxLg9zv2snD2rvFgQNhR1M750EiAAe6LSqFx
gnAVAaU7CeaFE0qxZ+TKI6ZjAVNHSMBS0geYLS4AqoDPsnwVTjuFEp47Nr62LT7U
uSyVvCgP2rhwgTl3cu0LFkRxUX50XvhuY/Pq2RnyNdXOhO2bCHH7w8nzdSBzxyPu
WkFdkeolHygwq2X546XRu60jmERrMFFxnbdULNKMv8gwNn4UlD1UNrFSbIal2uI8
y6JQkyAhETHxNmIADYv3XxLnPMg5Tg==
=LZj6
-----END PGP SIGNATURE-----

--Sig_/b3.gvt8g0i657AmabkNv=YK--
