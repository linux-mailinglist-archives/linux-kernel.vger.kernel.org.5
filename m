Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCA979762C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjIGQDv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 12:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjIGQBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:01:47 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2759D3;
        Thu,  7 Sep 2023 08:51:52 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5733d431209so669651eaf.0;
        Thu, 07 Sep 2023 08:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101834; x=1694706634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHLh0XIuAU9BJlqzEfpp7VQfwKfBKemsHfjkdXxbouo=;
        b=DyRfiSyskXeAJOXKkxh6qnbQDisXzXAUx/qoe5COmt9mNcElPwII+7W+cxHEWjQJi+
         SXj4pXdEhSb1ax68fQjgVr+kYYmzHNqUPfNrR4XfOyHnN+hoi+oKoXq/S47mFbx4nf9D
         mdmj6t+yT2fewIdEF33ZCvWzcmYe2Ybv0yISpo1djzn4QlTHtm2eeBGq1u4Qqd0sA4JG
         PIYlJr36Uw182vxgIhY9M3ks4lFCLtiCBPLTyU/Jl3AVQgzwYy/n2rtbbiRAqLEtBjjA
         92KzeeUhr4iuoIKSskYtuua8Uf19U+7uVoT1uryvIv/vGGZ8fDmcweRgn0V9qNzFaqRC
         zUuw==
X-Gm-Message-State: AOJu0YykxDMe0pj97R3XcIGWz0OzLrUyhNm1e9ZGWaHPUkjv3fpCiqaH
        DTz4R2zgEMMKU/Zj+65FKZKCnjkuw2bA+g==
X-Google-Smtp-Source: AGHT+IEXPMdb/zfhFva+7by/Jggj6S9TQW7vBVCkn39rAVGXwXMBswrTkjnA+9ZJN99+IaZNvUVLKw==
X-Received: by 2002:a05:6808:1894:b0:3a7:62ad:af39 with SMTP id bi20-20020a056808189400b003a762adaf39mr25372164oib.13.1694097386145;
        Thu, 07 Sep 2023 07:36:26 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id w125-20020a817b83000000b0058427045833sm4361218ywc.133.2023.09.07.07.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 07:36:25 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d7b8d2631fdso967294276.3;
        Thu, 07 Sep 2023 07:36:25 -0700 (PDT)
X-Received: by 2002:a25:ad91:0:b0:d2c:32cb:c631 with SMTP id
 z17-20020a25ad91000000b00d2c32cbc631mr20648715ybi.27.1694097385344; Thu, 07
 Sep 2023 07:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694095086.git.geert@linux-m68k.org> <5c80dc63-e7d0-5d82-de83-7e35c54b8351@csgroup.eu>
In-Reply-To: <5c80dc63-e7d0-5d82-de83-7e35c54b8351@csgroup.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Sep 2023 16:36:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzOsAa1qtnqBP0Wr_AaTGWUnxVHnWryoCDPX0d-v1EBg@mail.gmail.com>
Message-ID: <CAMuHMdWzOsAa1qtnqBP0Wr_AaTGWUnxVHnWryoCDPX0d-v1EBg@mail.gmail.com>
Subject: Re: [PATCH 0/2] m68k/powerpc: Kill references to non-existent README.legal
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Thu, Sep 7, 2023 at 4:25 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 07/09/2023 à 16:21, Geert Uytterhoeven a écrit :
> > Several source files contain license boilerplate that refers to the file
> > "README.legal", which never existed in upstream Linux.  This is a relic
> > from the early port of Linux to the m68k processor family, before it was
> > merged in v1.3.94.  Later, copies of this boilerplate ended up in the
> > PowerPC port.
> >
> > The "README.legal" file (from e.g. [1]) read:
> >
> > ---8<-----------------------------------------------------------------
> > Legal information about the Linux/68k software package
> >
> > All files contained in this archive are copyrighted by one or more
> > person.  They are not in the public domain.
> >
> > Most of the files are copyrighted by Linus Torvalds, the original
> > writer of Linux for IBM PC clone systems.  Some parts are copyrighted
> > by other IBM PC linux developers.  Other parts are copyrighted by
> > Linux/68k developers.
> >
> > This package is subject to the terms and conditions of the GNU General
> > Public License.  A copy of this license may be found in the file named
> > "COPYING" which should be in the same directory as this file.  If the
> > file has been omitted, you may obtain it by writing to the Free
> > Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> > ----------------------------------------------------------------->8---
> >
> > Note that the "COPYING" file at that time corresponded to the version
> > from upstream Linux v0.99.11 until v2.1.104, and thus predated the
> > addition of the "only valid GPL version is v2" clause in v2.4.0-test8.
> >
> > This patch series gets rid of the references to README.legal by
> > replacing the boilerplate with SPDX license identifiers.
> >
> > Thanks for your comments!
>
> As far as I know this kind of patch has to be copied to
> linux-spdx@vger.kernel.org

Thanks, added to CC.

> > [1] https://www.ibiblio.org/pub/historic-linux/ftp-archives/tsx-11.mit.edu/Oct-07-1996/680x0/v0.9/linux-0.9.tar.gz
> >
> > Geert Uytterhoeven (2):
> >    m68k: Replace GPL 2.0+ README.legal boilerplate by SPDX
> >    powerpc: Replace GPL 2.0+ README.legal boilerplate by SPDX
> >
> >   arch/m68k/68000/entry.S             | 7 ++-----
> >   arch/m68k/bvme6000/config.c         | 5 +----
> >   arch/m68k/coldfire/entry.S          | 7 ++-----
> >   arch/m68k/ifpsp060/Makefile         | 6 ++----
> >   arch/m68k/kernel/entry.S            | 7 ++-----
> >   arch/m68k/kernel/head.S             | 8 ++------
> >   arch/m68k/mvme147/config.c          | 5 +----
> >   arch/m68k/mvme16x/config.c          | 5 +----
> >   arch/m68k/q40/config.c              | 5 +----
> >   arch/powerpc/kernel/ptrace/ptrace.c | 5 +----
> >   arch/powerpc/kernel/signal.c        | 5 +----
> >   arch/powerpc/kernel/signal.h        | 7 ++-----
> >   12 files changed, 18 insertions(+), 54 deletions(-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
