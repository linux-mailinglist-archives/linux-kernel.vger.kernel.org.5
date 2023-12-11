Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE6380D51A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345095AbjLKSQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjLKSQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:16:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6FB95
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:16:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5E8C433C8;
        Mon, 11 Dec 2023 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702318568;
        bh=b4SzHYBlBfVYzMKlFytXfg+W32rsjAYh1uFD+VjgDRU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yqc8n9Exs1us3nbS3F0tNgNMwas7NPcdrqVA4j/66qtrnMWkbUmWFnpdxutMugJw5
         Q9JMnvciuMeCJC2VDChDCpIw6zaCTJkEwupG2120YfC2x5gpArp47pUbfx1ZCKjkEX
         ei9iUKqVqMawnxxZCAc/Xs3U0l5e0WJLkmZieQ+m1wzSv1bjjse0JWbgGqSE9uPgnm
         NK2rj/B00S9RKyVMAnabx9X5SXji3slesIuRW8SXCJjhwVBv6v2mQRk9Nw6UFCyRs7
         zxEyG9aYgaFm2zeNVh6g72UTARawd1yJWvo0E0U+X3P3KebBZMTPX3rxgqdbSRWflX
         5u4sQrTJumoSw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1feeea75fbfso3075125fac.3;
        Mon, 11 Dec 2023 10:16:08 -0800 (PST)
X-Gm-Message-State: AOJu0Yxrpt7uS4TfkRZH35Gm9v7LyQR255HkcPaalRhd0ybNhFtEtVEZ
        ibetQCRLvTpsAoM4V3R6DVOPTPEKaQAhv+sfqF8=
X-Google-Smtp-Source: AGHT+IGrB4LVwOfjwDcEsmCTjO6kZJRWvY77iRWupbzMoVZJH5NslGRTomF3l/+HCr9pN4GLQSUNVrY7qtnVzxOB62o=
X-Received: by 2002:a05:6870:1699:b0:1fb:75a:c426 with SMTP id
 j25-20020a056870169900b001fb075ac426mr4249250oae.79.1702318567772; Mon, 11
 Dec 2023 10:16:07 -0800 (PST)
MIME-Version: 1.0
References: <CAFSh4UwYYAOb0YpC=WAL6SD+8jTLuSkhgrgjh8JmogUb10V=zw@mail.gmail.com>
 <CAK7LNASE6H2GoXzJ1PXWEqsemQ3ny1K34vOxN0uVn1fh7Mmt5A@mail.gmail.com> <CAFSh4UwkXyTnECgJBQA4uBqD0QOFiUBvj=aOy7qzXZqAZKYkcQ@mail.gmail.com>
In-Reply-To: <CAFSh4UwkXyTnECgJBQA4uBqD0QOFiUBvj=aOy7qzXZqAZKYkcQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 Dec 2023 03:15:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQE0vuAEqq+S_9bQ6h12TmyUDut238Q0LmeodfZZxWR+Q@mail.gmail.com>
Message-ID: <CAK7LNAQE0vuAEqq+S_9bQ6h12TmyUDut238Q0LmeodfZZxWR+Q@mail.gmail.com>
Subject: Re: Building signed debs
To:     Tom Cook <tom.k.cook@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 7:19=E2=80=AFPM Tom Cook <tom.k.cook@gmail.com> wro=
te:
>
> On Sat, Dec 9, 2023 at 6:18=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> > On Fri, Dec 8, 2023 at 8:14=E2=80=AFPM Tom Cook <tom.k.cook@gmail.com> =
wrote:
> > >
> > > I'm trying to build a signed .deb kernel package of
> > > https://github.com/torvalds/linux/tree/v6.6.  I've copied
> > > certs/default_x509.genkey to certs/x509.genkey.  The .config is the
> > > one from Ubuntu 23.10's default kernel with all new options accepted
> > > at their default and CONFIG_SYSTEM_TRUSTED_KEYS=3D"" and
> > > CONFIG_SYSTEM_REVOCATION_KEYS=3D"".
> > >
> > > This builds the kernel and modules, signs the modules, compresses the
> > > modules and then attempts to sign the modules again.  That fails,
> > > because the .ko module files are now .ko.zst files and the file it's
> > > trying to sign isn't there.  Full failure is pasted below.
> >
> >
> >
> > Modules are signed before the compression.
>
> Reading back through my earlier email, I wasn't clear that when I said "T=
his
> builds the kernel..." I meant "`make deb-pkg` builds the kernel".  I'm no=
t
> doing anything outlandish here, I think, just expecting the build system =
to
> work.
>
> Regards,
> Tom


OK, I understood.



The error is caused by the following lines
in scripts/package/builddeb:


# re-sign stripped modules
if is_enabled CONFIG_MODULE_SIG_ALL; then
        ${MAKE} -f ${srctree}/Makefile
INSTALL_MOD_PATH=3D"${image_pdir}" modules_sign
fi



The error happens when all of the following three
are enabled.

 - CONFIG_DEBUG_INFO
 - CONFIG_MODULE_SIG_ALL
 - CONFIG_MODULE_COMPRESS_*


If you disable one of them, you can do deb-pkg.







--=20
Best Regards
Masahiro Yamada
