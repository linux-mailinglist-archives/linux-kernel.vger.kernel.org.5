Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5C7558A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 00:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjGPW4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 18:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPW4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 18:56:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE301BC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 15:56:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C20351FD80;
        Sun, 16 Jul 2023 22:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689548201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ys6h1vzSSIaVlocCSqGhavDDv/6uvxE6L3vdhd2vrHU=;
        b=PWntyDKakwSLMFInmJ+7M0/XbQdZfYmju+55r0dP1mW0uLHtGVPTK+PrdNDEYQJEB7uXUP
        CUhJC/5KngSu3bg2WkciXAsOjrekWDBEa5v38iEoPt5+NBSKF8UpamYmzSXQIwu3VDeJhk
        Ob6qLEWZ9TiorznFmaNAIIREnrg1kxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689548201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ys6h1vzSSIaVlocCSqGhavDDv/6uvxE6L3vdhd2vrHU=;
        b=tVHZ8DnJNgYMPlWL9jq6IDcqJQXb7D85Av55qDaaOCq4k1fVOIT0v382BqaDqget93lIoV
        DHRRktctJYkWukBA==
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A38EA2C142;
        Sun, 16 Jul 2023 22:56:41 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 68C9B604DF; Mon, 17 Jul 2023 00:56:41 +0200 (CEST)
Date:   Mon, 17 Jul 2023 00:56:41 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230716225641.un3p3wvtpqldgy6f@lion.mk-sys.cz>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
 <fb93d107-c834-1849-2b14-1dd33c4f9955@leemhuis.info>
 <20230709140929.5sdcvyqquotkn752@carpenter>
 <20230710171628.vo4azoabe26kepij@treble>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="75t4gryvpwcuroiv"
Content-Disposition: inline
In-Reply-To: <20230710171628.vo4azoabe26kepij@treble>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--75t4gryvpwcuroiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 10:16:28AM -0700, Josh Poimboeuf wrote:
> On Sun, Jul 09, 2023 at 05:09:29PM +0300, Michal Kubecek wrote:
> > On Sat, Jul 08, 2023 at 03:40:50PM +0200, Linux regression tracking (Th=
orsten Leemhuis) wrote:
> > > On 28.06.23 13:58, Michal Kubecek wrote:
> > > >=20
> > > > this morning, mainline kernel builds started to fail on my desktop =
like
> > > > this:
> > > >=20
> > > >   mike@lion:~/work/git/kernel-upstream> mkdir /srv/ram/kobj
> > > >   mike@lion:~/work/git/kernel-upstream> make -j24 CC=3Dgcc-13 O=3D/=
srv/ram/kobj defconfig >/dev/null
> > > >   mike@lion:~/work/git/kernel-upstream> make -j24 CC=3Dgcc-13 O=3D/=
srv/ram/kobj all >/dev/null
> > > >   net/ipv4/netfilter/iptable_nat.o: warning: objtool: mmap fail rel=
oc
> > > >   net/netfilter/xt_mark.o: warning: objtool: mmap fail reloc
> > > >   net/netfilter/xt_nat.o: warning: objtool: mmap fail reloc
> > > >   net/netfilter/xt_LOG.o: warning: objtool: mmap fail reloc
> > > >   net/netfilter/xt_MASQUERADE.o: warning: objtool: mmap fail reloc
> > > >   net/netfilter/nf_log_syslog.o: warning: objtool: mmap fail reloc
> > > >   net/netfilter/xt_addrtype.o: warning: objtool: mmap fail reloc
> > > >   fs/efivarfs/efivarfs.o: warning: objtool: mmap fail reloc
> > > >   drivers/thermal/intel/x86_pkg_temp_thermal.o: warning: objtool: m=
map fail reloc
> > > >   vmlinux.o: warning: objtool: mmap fail reloc
> > > >   incomplete ORC unwind tables in file: vmlinux
> > > >   Failed to sort kernel tables
> > > >   make[2]: *** [/home/mike/work/git/kernel-upstream/scripts/Makefil=
e.vmlinux:35: vmlinux] Error 1
> > > >   make[2]: *** Deleting file 'vmlinux'
> > > >   make[1]: *** [/home/mike/work/git/kernel-upstream/Makefile:1256: =
vmlinux] Error 2
> > > >   make: *** [Makefile:226: __sub-make] Error 2
> > > >=20
> > > > I bisected the failure to commit
> > > >=20
> > > >   eb0481bbc4ce ("objtool: Fix reloc_hash size")
> > > >=20
> > > > I also tried gcc11 and building on a normal filesystem (rather than
> > > > tmpfs) but the result is still the same. Different configurations (=
e.g.
> > > > allmodconfig) only show more modules with "mmap fail reloc". The ma=
chine
> > > > has 64 GB of RAM and both ulimit -m and ulimit -v show "unlimited".
> > > > Anything idea what else I should try?
> > >=20
> > > Michal, thx for the report. Please correct me if I'm wrong: this as of
> > > now is unfixed, as your patch to fix is afaics wasn't merged yet (at
> > > least I can't see it even in next, but I might be missing something).
> >=20
> > Yes, the fix has not been merged yet and current master (commit
> > 1c7873e33645) still shows the issue.
>=20
> Should be fixed in the tip tree with the following patch:
>=20
> https://lkml.kernel.org/lkml/168897683429.404.6801969953192508868.tip-bot=
2@tip-bot2

The fix reached mainline now as

  9f71fbcde282 ("objtool: initialize all of struct elf")

and is present in 6.5-rc2 so that it no longer exhibits the issue.

Michal

--75t4gryvpwcuroiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmS0daUACgkQ538sG/LR
dpVH1QgAu3oi5xk/rao2uXTc8HkpITK4aYMlv5bZSQxgS6fJn2pAtlItDmY/Pijf
lths1Gf2+xgFSEWCilYiGRsSxR9y5AN1yoRNKnxKghOuRpIHHjZWGy86CNlMcJOn
vmgzW+HlelHrZQ22STQPDFDsRrUM4/nCehfDWSPnu/vAUHczZstHovpXPqTF4cpF
fwFCRhUeW9zQUNSGuOtqpEFJHsKgDswekXVhHrHNGrqBKb00TdcvftYnREX8Eus6
TwxM+HZcpqB3q9DROMoVfRv2Dm8LinXfCLRbp8EUx1RiBNLfy0YuoKojBH/TJOYM
TPigoGMbNaqBl+Y63I+1OWe8KtgGfg==
=ZHsS
-----END PGP SIGNATURE-----

--75t4gryvpwcuroiv--
