Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1008876F86A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjHDDkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHDDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:40:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98694498;
        Thu,  3 Aug 2023 20:40:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2683add3662so1068543a91.1;
        Thu, 03 Aug 2023 20:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691120436; x=1691725236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3taenBgw1XpvXsvPtzmLtzkM+Q2pKiv5XZ8YIpRNrrg=;
        b=qlgyobrOEL3H72qiLP+hYDrc0vsjW40wRONEemdb4nW84mlBxnomq4bHhKv+f83hHx
         Ongt1zOiovXIC03+RCbWmi/14McGQfRTj0FG7QpXs/381AApW+d4tcOUfE06StA+QjQo
         t7ue7bs4HC1pwZF2qOBlyXrTeCDQNgezY4c6kHWlcgVIBv4Os2Ibx1KRlgpOEyCo5A2l
         uq0yk+kHag1zr4CcJFTGe/toHqtNfmItREVtYhpcbuYd3EwT+oWuG+f3xNNU+LuZottY
         NmYcIPeEGntFff7ZtIe3JzhOkZ2xd6QUl9oN8SwlCz+OfzUPIHBlxVc56aiAT9pfh8/I
         h+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691120436; x=1691725236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3taenBgw1XpvXsvPtzmLtzkM+Q2pKiv5XZ8YIpRNrrg=;
        b=FsIYQ16yBTQyGgSYuHyJxfrPC8zPObGl1WCdBovqktVt2JflZoGV46tPkXRbdGfZrd
         dbeW0j2DgF2X7Sd669lP2vJk2n6qsaRZ/WL5g+9nPEhG8mUKn3axTz+QrU1KOqOMw006
         VmxqP5pwAWbp8OPy9cyZmF/Y3zb8rF796+vbiN6fdBcuYZFe4E6YaVsjSpA0HDsC2ADp
         j4pvczBiHV6dcoqigccYB7c1hPscNH5Mvhnb6ow4kU6Jc3xDmNJBJDalXv08YcsmACGK
         Rh3ALGSULcIvX6PBONpZC9aSd/CjfGKZHa9RT4kP1YG/j/PC9GW9hn4nkWXMeQPV2Ibn
         dbQQ==
X-Gm-Message-State: AOJu0Yy7Loc/kfdFWLTQ8Gfc0fX9+UQ4adgJM08/P1BR3bNM+S1gOz0k
        44nt/De9KYOKtXpyT+Fv8JvWq75xvv9tPrKO/gJQOYZc
X-Google-Smtp-Source: AGHT+IGpd2ITomzbqCjpKREKT01gjwGfonDQ2skxYtxOzvcNyLAqBZ2NdL+7iEqgRP8wiUjFmtITRYCHB15vQJV0TL0=
X-Received: by 2002:a17:90a:e605:b0:269:18f5:683e with SMTP id
 j5-20020a17090ae60500b0026918f5683emr611134pjy.3.1691120435982; Thu, 03 Aug
 2023 20:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <9d2898a0-239a-1bc7-4929-aa042f727ff4@kernel.org> <b1f2b859-d223-eb90-994b-8741ab7af087@kernel.org>
In-Reply-To: <b1f2b859-d223-eb90-994b-8741ab7af087@kernel.org>
From:   Luna Jernberg <droidbittin@gmail.com>
Date:   Fri, 4 Aug 2023 05:40:22 +0200
Message-ID: <CADo9pHjqNx9_DspLB2sx3pDRJv-vqO8s7PJYNk5LoQLXhvwTxQ@mail.gmail.com>
Subject: Re: man-pages-6.05.01 released
To:     Alejandro Colomar <alx@kernel.org>,
        andyrtr <andyrtr@archlinux.org>,
        Luna Jernberg <droidbittin@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Sam James <sam@gentoo.org>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Marcos Fouces <marcos@debian.org>
Content-Type: multipart/mixed; boundary="000000000000dc11d3060210a8be"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000dc11d3060210a8be
Content-Type: text/plain; charset="UTF-8"

Hello!

Here comes and updated PKGBUILD for Arch Linux, sorry it took a while,
was watching Fedora Flock 2023 yesterday

Den tors 3 aug. 2023 kl 00:32 skrev Alejandro Colomar <alx@kernel.org>:
>
> Gidday!
>
> On 2023-08-01 15:19, Alejandro Colomar wrote:
> > Gidday!
> >
> > I'm proud to announce:
> >
> >       man-pages-6.05 - manual pages for GNU/Linux
> >
> > The release tarball is already available at <kernel.org>
> >
> > Tarball download:
> >       <https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/>
> > Git repository:
> >       <https://git.kernel.org/cgit/docs/man-pages/man-pages.git/>
>
> There was a small problem while packaging for Debian.  quilt(1)
> produces a .pc/ dir in the root of the repository, and the patches
> stored in there confuse the build system to try to lint those patches
> as if they were manual pages.  If you successfully packaged 6.05
> without noticing this issue, you can safely ignore this bugfix
> release.  If you noticed the issue, or haven't yet started, I suggest
> you package 6.05.01.
>
> Changes since man-pages-6.05:
>
> man-pages-6.05.01:
>
> -  Build system:
>    -  Ignore dot-dirs within $MANDIR
>
>
> Cheers,
> Alex
>
> --
> <http://www.alejandro-colomar.es/>
> GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5
>

--000000000000dc11d3060210a8be
Content-Type: application/octet-stream; name=PKGBUILD
Content-Disposition: attachment; filename=PKGBUILD
Content-Transfer-Encoding: base64
Content-ID: <f_lkw1fn5s0>
X-Attachment-Id: f_lkw1fn5s0

IyBNYWludGFpbmVyOiBBbmRyZWFzIFJhZGtlIDxhbmR5cnRyQGFyY2hsaW51eC5vcmc+Cgpwa2du
YW1lPW1hbi1wYWdlcwpwa2d2ZXI9Ni4wNS4wMQpfcG9zaXh2ZXI9MjAxNy1hCnBrZ3JlbD0xCnBr
Z2Rlc2M9IkxpbnV4IG1hbiBwYWdlcyIKYXJjaD0oJ2FueScpCmxpY2Vuc2U9KCdHUEwnICdjdXN0
b20nKQp1cmw9Imh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL21hbi1wYWdlcy8iCm1ha2VkZXBl
bmRzPSgnbWFuMmh0bWwnICdnaXQnKQojIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9k
b2NzL21hbi1wYWdlcy9tYW4tcGFnZXMuZ2l0Lwpzb3VyY2U9KGh0dHBzOi8vd3d3Lmtlcm5lbC5v
cmcvcHViL2xpbnV4L2RvY3MvbWFuLXBhZ2VzLyRwa2duYW1lLSRwa2d2ZXIudGFyLnt4eixzaWdu
fQogICAgICAgIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvcHViL2xpbnV4L2RvY3MvbWFuLXBhZ2Vz
L21hbi1wYWdlcy1wb3NpeC8kcGtnbmFtZS1wb3NpeC0ke19wb3NpeHZlcn0udGFyLnt4eixzaWdu
fSkKIyBodHRwczovL3d3dy5rZXJuZWwub3JnL3B1Yi9saW51eC9kb2NzL21hbi1wYWdlcy9zaGEy
NTZzdW1zLmFzYwpzaGEyNTZzdW1zPSgnYjk2YWI2YjQ0YTY4OGM5MWQxYjU3MmU1MmZlY2U1MTll
MWNmZDJiYjRjMzNmZTcwMTRmYzNmZDFlZjNmOWNhZScKICAgICAgICAgICAgJ1NLSVAnCiAgICAg
ICAgICAgICdjZTY3YmIyNWI1MDQ4YjIwZGFkNzcyZTQwNWE4M2Y0YmM3MGZhZjA1MWFmYTI4OTM2
MWM4MWY5NjYwMzE4YmMzJwogICAgICAgICAgICAnU0tJUCcpCnZhbGlkcGdwa2V5cz0oJ0U1MjI1
OTVCNTJFREE0RTZCRkNDQ0I1RTg1NjE5OTExM0EzNUNFNUUnKSAjIE1pY2hhZWwgS2VycmlzayAo
TGludXggbWFuLXBhZ2VzIG1haW50YWluZXIpIDxtdGsubWFucGFnZXNAZ21haWwuY29tPgojICsg
Zm9yIHBvc2l4IHRhcmJhbGwKdmFsaWRwZ3BrZXlzKz0oJ0E5MzQ4NTk0Q0UzMTI4M0E4MjZGQkRE
OEQ1NzYzM0Q0NDFFMjVCQjUnKSAjIEFsZWphbmRybyBDb2xvbWFyIEFuZHJlcyA8YWx4Lm1hbnBh
Z2VzQGdtYWlsLmNvbT4KCnByZXBhcmUoKSB7CiAgY2QgIiR7c3JjZGlyfSIvJHBrZ25hbWUtJHBr
Z3ZlcgoKICAjIGluY2x1ZGVkIGluIHNoYWRvdwogIHJtIG1hbjUvcGFzc3dkLjUKICBybSBtYW4z
L2dldHNwbmFtLjMKICAjIGluY2x1ZGVkIGluIHR6ZGF0YQogIHJtIG1hbjUvdHpmaWxlLjUgbWFu
OC97dHpzZWxlY3QsemR1bXAsemljfS44CiAgIyBpbmNsdWRlZCBpbiBsaWJ4Y3J5cHQKICBybSBt
YW4zL2NyeXB0Ki4zCn0KCnBhY2thZ2UoKSB7CiAgY2QgIiR7c3JjZGlyfSIvJHBrZ25hbWUtJHBr
Z3ZlcgoKICAjIGluc3RhbGwgbWFuLXBhZ2VzCiAgbWFrZSBERVNURElSPSIke3BrZ2Rpcn0iIHBy
ZWZpeD0vdXNyIGluc3RhbGwgCgogICMgaW5zdGFsbCBwb3NpeCBwYWdlcwogIHB1c2hkICIke3Ny
Y2Rpcn0iLyRwa2duYW1lLXBvc2l4LSR7X3Bvc2l4dmVyJS0qfQogIG1ha2UgREVTVERJUj0iJHtw
a2dkaXJ9IiBpbnN0YWxsIAogIHBvcGQKICAKICAjIHBvc2l4IHBhZ2VzIGhhdmUgYSBjdXN0b20g
bGljZW5zZQogIGluc3RhbGwgLW03NTUgLWQgIiR7cGtnZGlyfS91c3Ivc2hhcmUvbGljZW5zZXMv
JHtwa2duYW1lfSIKICBpbnN0YWxsIC1tNjQ0ICIke3NyY2Rpcn0iLyRwa2duYW1lLXBvc2l4LSR7
X3Bvc2l4dmVyJS0qfS9QT1NJWC1DT1BZUklHSFQgIiR7cGtnZGlyfS91c3Ivc2hhcmUvbGljZW5z
ZXMvJHtwa2duYW1lfS9QT1NJWC1DT1BZUklHSFQiCn0K
--000000000000dc11d3060210a8be--
