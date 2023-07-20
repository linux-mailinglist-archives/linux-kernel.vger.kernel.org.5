Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7B75AB88
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGTJ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGTJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:56:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C213E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:56:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A75822B47;
        Thu, 20 Jul 2023 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689846985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b/WAt2ko11CilJolgusZ/OdpYjV+EX3EkCvfXpZrr+s=;
        b=rYM95cPglHk9jDNfuHASRTtJqM/HIqnacVgIXmHuxF4ODF6cin0kf8fTvWqt6glaITqfuy
        7+RzwU9B0mJDUrMkqT64sKEfgPT1Dod0laGPnAG/mMbq2gCiy9Ke+G7gEGBRbVuz5RaeCw
        yAuwOjCRnfVMyzo1MI8oU4a5/yqlvJ4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4A08138EC;
        Thu, 20 Jul 2023 09:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YmAUM8gEuWQIVQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 20 Jul 2023 09:56:24 +0000
Date:   Thu, 20 Jul 2023 11:56:23 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        security@kernel.org
Subject: Re: [PATCH] fs/jfs: Add a mutex named txEnd_lmLogClose_mutex to
 prevent a race  condition between txEnd and lmLogClose functions
Message-ID: <kyzmstq5dodvgpmd7rge3gtdikbbpauw6fide7vccgii4xtb6n@bwrwjsx4ylmx>
References: <20230515095956.17898-1-zyytlz.wz@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jkju3j6sdz2snaei"
Content-Disposition: inline
In-Reply-To: <20230515095956.17898-1-zyytlz.wz@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jkju3j6sdz2snaei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Zheng.

On Mon, May 15, 2023 at 05:59:56PM +0800, Zheng Wang <zyytlz.wz@163.com> wr=
ote:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in instrument_atomic_write include/linux/=
instrumented.h:87 [inline]
> BUG: KASAN: slab-use-after-free in clear_bit include/asm-generic/bitops/i=
nstrumented-atomic.h:41 [inline]
> BUG: KASAN: slab-use-after-free in txEnd+0x2a3/0x5a0 fs/jfs/jfs_txnmgr.c:=
535
> Write of size 8 at addr ffff888021bee840 by task jfsCommit/130
>=20
> CPU: 3 PID: 130 Comm: jfsCommit Not tainted 6.3.0-rc7-pasta #1

Is this still pertinent with the current mainline? (There were some
changes to jfs.)

> Through analysis, it was found that a race condition occurred between two
> functions lmLogClose and txEnd, which were executed in different threads.
> The possible sequence is as follows:
>=20
> -------------------------------------------------------------------------
> cpu1(free thread)        |        cpu2(use thread)
> -------------------------------------------------------------------------
> lmLogClose               |        txEnd
>                          |        log =3D JFS_SBI(tblk->sb)->log;
> sbi->log =3D NULL;         |
> kfree(log); [1] free log |
>                          |        clear_bit(log_FLUSH, &log->flag); [2] U=
AF

That looks sane to a by-passer.

> Fix it by add a mutex lock between lmLogClose and txEnd:

It doesn't feel right wrt "lock data, not code" heuristics.
And when I apply that, it turns out there's already jfs_log_mutex.
I'd suggest you explain more why a new lock is needed (if that's the
preferred solutino).

Thanks,
Michal

--jkju3j6sdz2snaei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZLkExgAKCRAGvrMr/1gc
jgMiAQDiHc2GPqN8BEsMex2H34eKF9kt0wtLtDPBjnRrVmd8ygEA43Tu18sFH+MU
p0UqiCSAchUq85Mzs0XfmVLFFOAmXAU=
=Toyw
-----END PGP SIGNATURE-----

--jkju3j6sdz2snaei--
