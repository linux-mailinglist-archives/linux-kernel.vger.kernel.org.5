Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1046C799A8F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbjIITUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjIITUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 15:20:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA91AA;
        Sat,  9 Sep 2023 12:20:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212E2C433C7;
        Sat,  9 Sep 2023 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694287238;
        bh=1GOmyuyrRXA+/1LFQMq9gOFatm+qrDGTMl3dI2bG7J4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=II4vrGeqpBWADmHJncm40gfqqv7xOwWgFYkjdLwNXyqcRtd4pDYZiQqJ1umSrvMt4
         KV2xilN9EoBnErEWA8DQtHDQULpwjuJGLjlMF7NxIAt1gb4ao161s4AX6TsB/dWmOm
         xn+rha554h8bCwwbTUo6Zi7RzRlQqLiFILfsp51WeB1y+2F4brw6v4062Pmk2qiEWs
         bm6cFOfe54q8vqZtaEsT0UF22thKbqlKYW+JI/FzewbpZj+8Hmd78knlNOdI8UKM/U
         SIcvdFdqrEngLp7chyruqjd0hHGHE/hjCZfOagMqf2pds+EbAaoRdZtKqoIzx0b8Aq
         qssPwDJmY2FWw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-57359e85e9bso1783068eaf.2;
        Sat, 09 Sep 2023 12:20:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YywoOYMxcgh1xKkr02KkKP8CySnwKmvuJCecuikObluNyiG4guq
        lN+ajf7mcx0xvvVno5Xii1pg9Db0n2FPC6Q2JXo=
X-Google-Smtp-Source: AGHT+IEU8bbX/YiyxkZie71dNCWQAjPJAcOZfCpFYCXLTiHCnOlIeKRpcLSFOAFOsHJR/qZBEJYsq8+fQADfRXAX948=
X-Received: by 2002:a05:6870:e305:b0:1bf:dc26:4947 with SMTP id
 z5-20020a056870e30500b001bfdc264947mr6643673oad.46.1694287237522; Sat, 09 Sep
 2023 12:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230905190828.790400-1-masahiroy@kernel.org> <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net> <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
 <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
In-Reply-To: <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 Sep 2023 04:20:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
Message-ID: <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
Subject: Re: [PATCH] linux/export: fix reference to exported functions for parisc64
To:     John David Anglin <dave.anglin@bell.net>
Cc:     linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a little more investigation,
I found arch/parisc/kernel/parisc_ksyms.c
is causing the issue.

That file is a collection of EXPORT_SYMBOL
of assembly code.

I will take a closer look tomorrow.











On Sun, Sep 10, 2023 at 2:20=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Sep 8, 2023 at 7:02=E2=80=AFAM John David Anglin <dave.anglin@bel=
l.net> wrote:
> >
> > On 2023-09-05 7:59 p.m., John David Anglin wrote:
> > > On 2023-09-05 5:57 p.m., John David Anglin wrote:
> > >> I'll check ddb5cdbafaaa.
> > > Similar fault with ddb5cdbafaaa:
> > The alignment of the __kstrtab_ symbols in vmlinux seems wrong.
>
> __kstrtab_ symbols do not need alignment.
>
> They were not aligned at all
> before ddb5cdbafaaa^.
>
>
>
> >  I'm fairly certain that function
> > references prefixed with P% on hppa64 need 8 byte alignment.
>
> Yeah.
> In the following dump, all of __ksymtab_* are correctly 8-byte aligned.
>
>
> >
> > 81662: 0000000040ea4358     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_sys=
tem[...]
> >   81663: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns=
_syst[...]
> >   81664: 0000000040e8e830     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab_s=
ystem[...]
> >   81665: 0000000040ea4365     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_s=
tatic[...]
> >   81666: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns=
_stat[...]
> >   81667: 0000000040ea1640     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_s=
tatic[...]
> >   81668: 0000000040ea437c     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_r=
eset_[...]
> >   81669: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns=
_rese[...]
> >   81670: 0000000040e8bbc0     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab_r=
eset_[...]
> >   81671: 0000000040ea438a     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_l=
oops_[...]
> >   81672: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns=
_loop[...]
> >   81673: 0000000040e86610     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab_l=
oops_[...]
> >   81674: 0000000040ea439a     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_i=
nit_uts_ns
> >   81675: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns=
_init[...]
> >   81676: 0000000040e99180     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_i=
nit_uts_ns
> >   81677: 0000000040ea43a6     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_n=
ame_t[...]
> >   81678: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns=
_name[...]
> >   81679: 0000000040e9b340     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_n=
ame_t[...]
> >   81680: 0000000040ea43b4     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_w=
ait_f[...]
> >   81681: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns=
_wait[...]
> >   81682: 0000000040ea3638     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_w=
ait_f[...]
> >   81683: 0000000040ea43c7     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_i=
nit_task
> > [...]
> >
> > I'm not sure how we get symbols that aren't 8 byte aligned.  The ".bali=
gn 4" directive
> > in __KSYMTAB doesn't seem correct but it's not the whole problem.
> >
> > Dave
> >
> > --
> > John David Anglin  dave.anglin@bell.net
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Best Regards
Masahiro Yamada
