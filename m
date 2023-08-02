Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6776C40A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjHBEUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHBEUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:20:12 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545A6134;
        Tue,  1 Aug 2023 21:20:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so10047318e87.2;
        Tue, 01 Aug 2023 21:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690950008; x=1691554808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gyc6Vj/5+QgRlaB1KaWGH5SSUdxooJ2BJvSWFUv67IM=;
        b=NCr2oAXvcBJArDD/sAVTq7EuIgtysWri+HxABg8ibiRjXF9KyKaA3k651KJ1V8OmiQ
         AOx5f6gNpBYAjfAcZX+SwzPxnxIdBFYbgUOENPlm7upqNIr9jhKNPh1y8X1Wc5w3bCuy
         1nQ5JEKOddXXWSJu+FNuRdUIoFV5p90CbrhszLmEnz+tTWHY8q/FdvnhWbye/vhOIXRo
         flcSZclTABprwxpPnFMIViu9SeqH+XQzDOqYCs+/usqwA6gRua+PsHwL44tqTLJGBbUG
         Wq3NH4Z9bhkTl1kngqtAxftP+QKMYM/cQqkpx6ZzihfwGkIYqCuOwDczB+1zNl1UWgb4
         VaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690950008; x=1691554808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gyc6Vj/5+QgRlaB1KaWGH5SSUdxooJ2BJvSWFUv67IM=;
        b=eWZkLqpacRmWStzTp1JF/GmyrdRBmGieJ8VSxtOCzlOlqdoyxMgx75OgTJNINNa6z9
         34Q8ejrdBm4NXS+hy91U7xhHYmEKU5xlVyEzdp5Y9fGQBvwTz0u0MYQVh3ZM+CompB92
         hW9cK320pcjC2ejQJ0/cx8Ie9lB8Gmc0Wk1fHEM8kj3f4NxpF8+r6jw0so8PQyQWOHP9
         6EJMXt3AUhPX4r9T1FNMDBzpHKbrpkI8ic79e6Hfsz1FtreTyfVOpp4+sjiKew7Ro53M
         NcDxqSgCV1MWoaDFcPXNVeIvwe7t2eVvAIhr0JUXlz7pQFPfJSKP4Bcc4Oc+uoIp/OCH
         hUAw==
X-Gm-Message-State: ABy/qLZR1yThhMW/nOzYqzGuvYoQo5vX73WFun/aynBa13jXSszhaiqQ
        dmEhQSEG9OlHyjxfeCRRviZvXPK92Fv1rkJLDwU=
X-Google-Smtp-Source: APBJJlG6qMD7MEpNdpzp7BKJlp1VHLlflRVDL1JCdrgiOU6nL8WaNWoOE1zFUH5G0/Dwx+78tUgN8V/cFuAvuicqGlg=
X-Received: by 2002:a05:6512:158e:b0:4fb:9469:d659 with SMTP id
 bp14-20020a056512158e00b004fb9469d659mr4581746lfb.23.1690950008267; Tue, 01
 Aug 2023 21:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <9d2898a0-239a-1bc7-4929-aa042f727ff4@kernel.org>
In-Reply-To: <9d2898a0-239a-1bc7-4929-aa042f727ff4@kernel.org>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Wed, 2 Aug 2023 06:19:54 +0200
Message-ID: <CADo9pHgFjtFSPv3vLUuO7u2A5rVYw2P_1ZP6yBGU43q_DNUgig@mail.gmail.com>
Subject: Re: man-pages-6.05 released
To:     Alejandro Colomar <alx@kernel.org>,
        andyrtr <andyrtr@archlinux.org>,
        Luna Jernberg <droidbittin@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Sam James <sam@gentoo.org>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Marcos Fouces <marcos@debian.org>
Content-Type: multipart/mixed; boundary="0000000000009379340601e8fa12"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009379340601e8fa12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Updated PKGBUILD for Arch Linux

Den tis 1 aug. 2023 kl 15:30 skrev Alejandro Colomar <alx@kernel.org>:
>
> Gidday!
>
> I'm proud to announce:
>
>         man-pages-6.05 - manual pages for GNU/Linux
>
> The release tarball is already available at <kernel.org>
>
> Tarball download:
>         <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
> Git repository:
>         <https://git.kernel.org/cgit/docs/man-pages/man-pages.git/>
>
> A change from man-pages-6.04 merits a mention in this release, as it
> wasn't properly documented in the previous release notes:
>
>    -  Add make(1) 'check' target.  This has been split from 'lint'.
>       'lint' will check the source code, and 'check' will check the
>       rendered pages (as a user will read them).  There are currently
>       several pages that fail this `make check`, and distributors that
>       depend on this can workaround it by touching a few files:
>
>       $ make check -k -j >/dev/null 2>/dev/null;
>       $ make check -k 2>/dev/null;
>       GREP      .tmp/man/man1/memusage.1.check-catman.touch
>       TROFF     .tmp/man/man2/fanotify_init.2.cat.set
>       TROFF     .tmp/man/man2/gettimeofday.2.cat.set
>       TROFF     .tmp/man/man2/s390_sthyi.2.cat.set
>       GREP      .tmp/man/man3/mallopt.3.check-catman.touch
>       TROFF     .tmp/man/man3/unlocked_stdio.3.cat.set
>       TROFF     .tmp/man/man4/console_codes.4.cat.set
>       TROFF     .tmp/man/man4/lirc.4.cat.set
>       GREP      .tmp/man/man4/smartpqi.4.check-catman.touch
>       GREP      .tmp/man/man4/veth.4.check-catman.touch
>       TROFF     .tmp/man/man5/proc.5.cat.set
>       GREP      .tmp/man/man5/slabinfo.5.check-catman.touch
>       TROFF     .tmp/man/man5/tzfile.5.cat.set
>       TROFF     .tmp/man/man7/address_families.7.cat.set
>       TROFF     .tmp/man/man7/ascii.7.cat.set
>       TROFF     .tmp/man/man7/bpf-helpers.7.cat.set
>       GREP      .tmp/man/man7/keyrings.7.check-catman.touch
>       GREP      .tmp/man/man7/uri.7.check-catman.touch
>       TROFF     .tmp/man/man8/tzselect.8.cat.set
>       TROFF     .tmp/man/man8/zdump.8.cat.set
>       TROFF     .tmp/man/man8/zic.8.cat.set
>
>       After touching the previous files, `make check` will succeed:
>
>       $ make check -k 2>/dev/null | awk '{print $2}' | xargs touch;
>       $ make check -j >/dev/null;
>       $ echo $?
>       0
>
> The most notable changes in this release (man-pages-6.05) are:
>
> New and rewritten pages
> -----------------------
>
> man2/
>         ioctl_pipe.2
>
> man3/
>         regex.3
>
> man5/
>         erofs.5
>
> Newly documented interfaces in existing pages
> ---------------------------------------------
>
> bpf.2
>         EAGAIN
>
> ioctl_userfaultfd.2
>         UFFD_FEATURE_EXACT_ADDRESS
>
> prctl.2
>         PR_GET_AUXV
>
> recv.2
>         MSG_CMSG_CLOEXEC
>
> statx.2
>         STAT_ATTR_MOUNT_ROOT
>
> syscall.2
>         ENOSYS
>
> resolv.conf.5
>         no-aaaa
>         RES_NOAAAA
>
> tmpfs.5
>         CONFIG_TRANSPARENT_HUGEPAGE
>
> ip.7
>         IP_LOCAL_PORT_RANGE
>
> rtnetlink.7
>         IFLA_PERM_ADDRESS
>
> New and changed links
> ---------------------
>
> man3type/
>         regex_t.3type                           (regex(3))
>         regmatch_t.3type                        (regex(3))
>         regoff_t.3type                          (regex(3))
>
> Global changes
> --------------
>
> -  Types:
>    -  Document functions using off64_t as if they used off_t (except
>       for lseek64()).
>
> -  Build system:
>    -  Keep file modes in the release tarball.
>    -  Fix symlink installation (`make install LINK_PAGES=3Dsymlink`).
>    -  Add support for using bzip2(1), lzip(1), and xz(1) when installing
>       pages and creating release tarballs.
>    -  Create reproducible release tarballs.
>    -  Move makefiles from lib/ to share/mk/.
>    -  Support mdoc(7) pages.
>    -  Relicense Makefiles as GPL-3.0-or-later.
>    -  Build PostScript and PDF manual pages.
>    -  Add support for running our build system on arbitrary source
>       trees; this makes it possible to easily run our linters on another
>       project's manual pages as easily as `make lint MANDIR=3D~/src/groff=
`
>
> -  Licenses:
>    -  Relicense ddp.7 from VERBATIM_ONE_PARA to Linux-man-pages-copyleft.
>    -  Relicense dir_colors.5 from LDPv1 to GPL-2.0-or-later.
>    -  Use new SPDX license identifiers:
>       -  Linux-man-pages-1-para                 (was VERBATIM_ONE_PARA)
>       -  Linux-man-pages-copyleft-2-para        (was VERBATIM_TWO_PARA)
>       -  Linux-man-pages-copyleft-var           (was VERBATIM_PROF)
>
> -  ffix:
>    -  use `\%`
>    -  un-bracket tbl(1) tables
>
>
> Contributors
> ------------
>
> The following people contributed patches/fixes, reports, notes,
> ideas, and discussions that have been incorporated in changes in
> this release:
>
> "David S. Miller" <davem@davemloft.net>
> "G. Branden Robinson" <g.branden.robinson@gmail.com>
> A. Wilcox <AWilcox@wilcox-tech.com>
> Adam Dobes <adobes@redhat.com>
> Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
> Alan Cox <alan@llwyncelyn.cymru>
> Alejandro Colomar <alx@kernel.org>
> Alexei Starovoitov <ast@kernel.org>
> Andreas Schwab <schwab@suse.de>
> Andrew Clayton <andrew@digital-domain.net>
> Andrew Morton <akpm@linux-foundation.org>
> Avinesh Kumar <akumar@suse.de>
> Bastien Roucari=C3=A8s <rouca@debian.org>
> Bjarni Ingi Gislason <bjarniig@simnet.is>
> Brian Inglis <Brian.Inglis@Shaw.ca>
> Bruno Haible <bruno@clisp.org>
> Carsten Grohmann <carstengrohmann@gmx.de>
> Colin Watson <cjwatson@debian.org>
> Cyril Hrubis <chrubis@suse.cz>
> DJ Delorie <dj@redhat.com>
> Daniel Verkamp <daniel@drv.nu>
> David Howells <dhowells@redhat.com>
> Dirk Gouders <dirk@gouders.net>
> Dmitry Goncharov <dgoncharov@users.sf.net>
> Eli Zaretskii <eliz@gnu.org>
> Elliott Hughes <enh@google.com>
> Eric Biggers <ebiggers@google.com>
> Eric Blake <eblake@redhat.com>
> Eric Wong <e@80x24.org>
> Fangrui Song <maskray@google.com>
> Florian Weimer <fweimer@redhat.com>
> Gavin Smith <gavinsmith0123@gmail.com>
> Guillem Jover <guillem@hadrons.org>
> G=C3=BCnther Noack <gnoack@google.com>
> Helge Kreutzmann <debian@helgefjell.de>
> Igor Sysoev <igor@sysoev.ru>
> Ingo Schwarze <schwarze@openbsd.org>
> Jakub Jelinek <jakub@redhat.com>
> Jakub Sitnicki <jakub@cloudflare.com>
> Jakub Wilk <jwilk@jwilk.net>
> Johannes Weiner <hannes@cmpxchg.org>
> John Gilmore <gnu@toad.com>
> John Hubbard <jhubbard@nvidia.com>
> John Scott <jscott@posteo.net>
> Jonathan Corbet <corbet@lwn.net>
> Jonathan Wakely <jwakely@redhat.com>
> Joseph Myers <joseph@codesourcery.com>
> Josh Triplett <josh@joshtriplett.org>
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Larry McVoy <lm@mcvoy.com>
> Lennart Jablonka <humm@ljabl.com>
> Linus Heckemann <git@sphalerite.org>
> Lukas Javorsky <ljavorsk@redhat.com>
> Marcos Fouces <marcos@debian.org>
> Mario Blaettermann <mario.blaettermann@gmail.com>
> Martin (Joey) Schulze <joey@infodrom.org>
> Masami Hiramatsu <mhiramat@kernel.org>
> Masatake YAMATO <yamato@redhat.com>
> Matthew House <mattlloydhouse@gmail.com>
> Matthew Wilcox (Oracle) <willy@infradead.org>
> Michael Kerrisk <mtk.manpages@gmail.com>
> Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer.de>
> Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Mike Frysinger <vapier@gentoo.org>
> Mike Kravetz <mike.kravetz@oracle.com>
> Mingye Wang <arthur200126@gmail.com>
> Nadav Amit <namit@vmware.com>
> Nick Desaulniers <ndesaulniers@google.com>
> Oskari Pirhonen <xxc3ncoredxx@gmail.com>
> Paul E. McKenney <paulmck@kernel.org>
> Paul Eggert <eggert@cs.ucla.edu>
> Paul Floyd <pjfloyd@wanadoo.fr>
> Paul Smith <psmith@gnu.org>
> Philip Guenther <guenther@gmail.com>
> Ralph Corderoy <ralph@inputplus.co.uk>
> Reuben Thomas <rrt@sc3d.org>
> Rich Felker <dalias@libc.org>
> Richard Biener <richard.guenther@gmail.com>
> Sam James <sam@gentoo.org>
> Serge Hallyn <serge@hallyn.com>
> Seth David Schoen <schoen@loyalty.org>
> Siddhesh Poyarekar <siddhesh@gotplt.org>
> Simon Horman <simon.horman@corigine.com>
> Stefan Puiu <stefan.puiu@gmail.com>
> Steffen Nurpmeso <steffen@sdaoden.eu>
> Szabolcs Nagy <nsz@port70.net>
> Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
> Tom Schwindl <schwindl@posteo.de>
> Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> Torbjorn SVENSSON <torbjorn.svensson@foss.st.com>
> Ulrich Drepper <drepper@redhat.com>
> Vahid Noormofidi <vnoormof@nvidia.com>
> Vlastimil Babka <vbabka@suse.cz>
> Wilco Dijkstra <Wilco.Dijkstra@arm.com>
> Xi Ruoyao <xry111@xry111.site>
> Yang Xu <xuyang2018.jy@fujitsu.com>
> Yedidyah Bar David <didi@redhat.com>
> Zack Weinberg <zack@owlfolio.org>
> Zijun Zhao <zijunzhao@google.com>
>
> Apologies if I missed anyone!
>
>
> Thanks you all for contributing!
>
> Cheers,
> Alex
>
> --
> <http://www.alejandro-colomar.es/>
> GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--0000000000009379340601e8fa12
Content-Type: application/octet-stream; name=PKGBUILD
Content-Disposition: attachment; filename=PKGBUILD
Content-Transfer-Encoding: base64
Content-ID: <f_lkt7ysm90>
X-Attachment-Id: f_lkt7ysm90

IyBNYWludGFpbmVyOiBBbmRyZWFzIFJhZGtlIDxhbmR5cnRyQGFyY2hsaW51eC5vcmc+Cgpwa2du
YW1lPW1hbi1wYWdlcwpwa2d2ZXI9Ni4wNQpfcG9zaXh2ZXI9MjAxNy1hCnBrZ3JlbD0xCnBrZ2Rl
c2M9IkxpbnV4IG1hbiBwYWdlcyIKYXJjaD0oJ2FueScpCmxpY2Vuc2U9KCdHUEwnICdjdXN0b20n
KQp1cmw9Imh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL21hbi1wYWdlcy8iCm1ha2VkZXBlbmRz
PSgnbWFuMmh0bWwnICdnaXQnKQojIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9kb2Nz
L21hbi1wYWdlcy9tYW4tcGFnZXMuZ2l0Lwpzb3VyY2U9KGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcv
cHViL2xpbnV4L2RvY3MvbWFuLXBhZ2VzLyRwa2duYW1lLSRwa2d2ZXIudGFyLnt4eixzaWdufQog
ICAgICAgIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvcHViL2xpbnV4L2RvY3MvbWFuLXBhZ2VzL21h
bi1wYWdlcy1wb3NpeC8kcGtnbmFtZS1wb3NpeC0ke19wb3NpeHZlcn0udGFyLnt4eixzaWdufSkK
IyBodHRwczovL3d3dy5rZXJuZWwub3JnL3B1Yi9saW51eC9kb2NzL21hbi1wYWdlcy9zaGEyNTZz
dW1zLmFzYwpzaGEyNTZzdW1zPSgnODliMTQ0NWNmZTJlM2RlOGJkMTM5NzU4Yzc4ZjA4YjM3ODEz
Y2ZmMjE3YjlmYjFjOGRmNTVmZDk0MDc4NzVhNicKICAgICAgICAgICAgJ1NLSVAnCiAgICAgICAg
ICAgICdjZTY3YmIyNWI1MDQ4YjIwZGFkNzcyZTQwNWE4M2Y0YmM3MGZhZjA1MWFmYTI4OTM2MWM4
MWY5NjYwMzE4YmMzJwogICAgICAgICAgICAnU0tJUCcpCnZhbGlkcGdwa2V5cz0oJ0U1MjI1OTVC
NTJFREE0RTZCRkNDQ0I1RTg1NjE5OTExM0EzNUNFNUUnKSAjIE1pY2hhZWwgS2VycmlzayAoTGlu
dXggbWFuLXBhZ2VzIG1haW50YWluZXIpIDxtdGsubWFucGFnZXNAZ21haWwuY29tPgojICsgZm9y
IHBvc2l4IHRhcmJhbGwKdmFsaWRwZ3BrZXlzKz0oJ0E5MzQ4NTk0Q0UzMTI4M0E4MjZGQkREOEQ1
NzYzM0Q0NDFFMjVCQjUnKSAjIEFsZWphbmRybyBDb2xvbWFyIEFuZHJlcyA8YWx4Lm1hbnBhZ2Vz
QGdtYWlsLmNvbT4KCnByZXBhcmUoKSB7CiAgY2QgIiR7c3JjZGlyfSIvJHBrZ25hbWUtJHBrZ3Zl
cgoKICAjIGluY2x1ZGVkIGluIHNoYWRvdwogIHJtIG1hbjUvcGFzc3dkLjUKICBybSBtYW4zL2dl
dHNwbmFtLjMKICAjIGluY2x1ZGVkIGluIHR6ZGF0YQogIHJtIG1hbjUvdHpmaWxlLjUgbWFuOC97
dHpzZWxlY3QsemR1bXAsemljfS44CiAgIyBpbmNsdWRlZCBpbiBsaWJ4Y3J5cHQKICBybSBtYW4z
L2NyeXB0Ki4zCn0KCnBhY2thZ2UoKSB7CiAgY2QgIiR7c3JjZGlyfSIvJHBrZ25hbWUtJHBrZ3Zl
cgoKICAjIGluc3RhbGwgbWFuLXBhZ2VzCiAgbWFrZSBERVNURElSPSIke3BrZ2Rpcn0iIHByZWZp
eD0vdXNyIGluc3RhbGwgCgogICMgaW5zdGFsbCBwb3NpeCBwYWdlcwogIHB1c2hkICIke3NyY2Rp
cn0iLyRwa2duYW1lLXBvc2l4LSR7X3Bvc2l4dmVyJS0qfQogIG1ha2UgREVTVERJUj0iJHtwa2dk
aXJ9IiBpbnN0YWxsIAogIHBvcGQKICAKICAjIHBvc2l4IHBhZ2VzIGhhdmUgYSBjdXN0b20gbGlj
ZW5zZQogIGluc3RhbGwgLW03NTUgLWQgIiR7cGtnZGlyfS91c3Ivc2hhcmUvbGljZW5zZXMvJHtw
a2duYW1lfSIKICBpbnN0YWxsIC1tNjQ0ICIke3NyY2Rpcn0iLyRwa2duYW1lLXBvc2l4LSR7X3Bv
c2l4dmVyJS0qfS9QT1NJWC1DT1BZUklHSFQgIiR7cGtnZGlyfS91c3Ivc2hhcmUvbGljZW5zZXMv
JHtwa2duYW1lfS9QT1NJWC1DT1BZUklHSFQiCn0K
--0000000000009379340601e8fa12--
