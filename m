Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A52D7FC3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376291AbjK1S4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbjK1S4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:56:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3207C131
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:56:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB898C433CC;
        Tue, 28 Nov 2023 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701197798;
        bh=IVX15cwRVhanxenCb9qdxGCtzR9TfKC+zZb0qEVecvw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PQClzvYRbwUbzuEmzP8doNA+u3BoK4HmAt9XafH+ibozCpW070MaClDo9grF65Bgw
         KlkbN72Giv36kbxxXKgsmHNgYc2VlMNv68sXObMePFGQRK7+ZLao3tpageZN78ygmC
         XIHxGypD/VSO1owLGFxWDi8R/X7/pzCQSX4X0wqr3bPb4Chth117VUB1qMEeEjo5wz
         u1+otPyScbfxDVcKYejLa0S4EE3nYuFUWZSP1oD+mfhRaLQeCawwCCOp+Ge+MlSJTN
         ty9lIBKEIEHhdL3TDTtGPq91eY6H6lPNox70o12rC8TGBan7CXNFG+YXSt/mDScpNg
         imuemKPbfxjxw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58a0154b4baso34902eaf.1;
        Tue, 28 Nov 2023 10:56:38 -0800 (PST)
X-Gm-Message-State: AOJu0YwAVEHgwJCg3mVeKIzBRB0I+yp81Am1ZACeA6ZyF3ib4birSo5w
        9/LBHa9NkSeIdgMVVb7dlUz7TfKNmijjQTp7qjg=
X-Google-Smtp-Source: AGHT+IFEqo5yd5/4rEOBcj46wHxE7sE0LtTiAv7hNthH3WbtiImwfv6yEqVPUbkvhP95iffaVMBJ4+FWY+6K1egXzic=
X-Received: by 2002:a05:6871:410b:b0:1fa:1d12:d1df with SMTP id
 la11-20020a056871410b00b001fa1d12d1dfmr6391876oab.19.1701197798041; Tue, 28
 Nov 2023 10:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20231128153858.84932-1-masahiroy@kernel.org> <7a2684e680ffe279ed1e586e8ddb24b94c2cf010.camel@decadent.org.uk>
In-Reply-To: <7a2684e680ffe279ed1e586e8ddb24b94c2cf010.camel@decadent.org.uk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 29 Nov 2023 03:56:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASWqQBcf+z+cxWphf5pi8VkB10ABYvPKSxrLKbePYwC0g@mail.gmail.com>
Message-ID: <CAK7LNASWqQBcf+z+cxWphf5pi8VkB10ABYvPKSxrLKbePYwC0g@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: deb-pkg: remove the fakeroot builds support
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kbuild@vger.kernel.org, Guillem Jover <guillem@debian.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 1:31=E2=80=AFAM Ben Hutchings <ben@decadent.org.uk>=
 wrote:
>
> On Wed, 2023-11-29 at 00:38 +0900, Masahiro Yamada wrote:
> > In 2017, the dpkg suite introduced the rootless builds support with the
> > following commits:
> >
> >   - 2436807c87b0 ("dpkg-deb: Add support for rootless builds")
> >   - fca1bfe84068 ("dpkg-buildpackage: Add support for rootless builds")
> >
> > This feature is available in the default dpkg on Debian 10 and Ubuntu
> > 20.04.
> >
> > Remove the old method.
>
> This seems reasonable.
>
>
> > Additionally, export DEB_RULES_REQUIRES_ROOT=3Dno in case debian/rules =
is
> > invoked without dpkg-buildpackage. This change aligns with the Debian
> > kernel commit 65206e29f378 ("Allow to run d/rules.real without root").
>
> The Debian linux package has multiple makefiles used recursively
> (rather than included).  The referenced commit is kind of a hack to
> make rootless builds of a subset of binary packages work when invoking
> one of the lower-level makefiles directly.


The upstream kernel does not support individual package build
since it is implemented in scripts/package/builddeb shell script.


Is the direct execution of debian/rules still worth supporting
in the upstream kernel?


If the answer is no, "export DEB_RULES_REQUIRES_ROOT=3Dno"
is meaningless.


> It works because the package runs dh_builddeb, which checks
> DEB_RULES_REQUIRES_ROOT.  But setting DEB_RULES_REQUIRES_ROOT has
> absolutely zero effect on dpkg-deb or other low-level tools.

Please let me clarify your statement.

Do you mean this?  ("is needed" ?)

"It is needed because the package runs dh_builddeb, which checks
 DEB_RULES_REQUIRES_ROOT."





> > While the upstream kernel currently does not run dh_testroot, it may
> > be useful in the future.
>
> We can do one of:
>
> 1. Ignore DEB_RULES_REQUIRES_ROOT, assume that dpkg-deb supports
>    --root-owner-group and use it unconditionally (your v1).
> 2. Check DEB_RULES_REQUIRES_ROOT, do either fakeroot and chown or
>    dpkg-deb --root-owner-group (current behaviour), and maybe also do
>    the equivalent of dh_testroot.
> 3. Delegate this to dh_builddeb.  Since we use dh_listpackages now,
>    debhelper is already required and this would make things a lot
>    simpler.
>
> But the combination of changes in v2 does not make sense to me.



I like 1 or 3.



If I go with 3.,
does splitting it into two patches make sense?


1/2:  remove fakeroot  (just like v1)
2/2:  dh_* conversion + "export DEB_RULES_REQUIRES_ROOT=3Dno"


--
Best Regards
Masahiro Yamada
