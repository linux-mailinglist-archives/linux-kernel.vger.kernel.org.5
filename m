Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5E799CF5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 09:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346420AbjIJHr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 03:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJHr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 03:47:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE3CC;
        Sun, 10 Sep 2023 00:47:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F32AC433C9;
        Sun, 10 Sep 2023 07:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694332071;
        bh=Rz4jtOTYDBSKI98hgW7EZT01fGJ/owT3vhvbsiCA+kE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nzrmb3iNL5uvsZjNviemh3zvai8Vvu2aoysmwtcQPWQrr4AfytGBLwjucscbPIlXE
         Ea7kdOvMCmHAOtfER/rp+994nq2YvbirFOSJo8yy1Ktut/GVSap8OSVAZr8eTAKeEH
         3tdHkBuhFvFj9M8wa2uY5yyjI/JgwJ7Aixd7PP8qFIuN2rUCdlHRuwP2GN5lIRPi0D
         sXYwjrG/OytggdOunb6V8WqDPg8nyLx9pR5Du0+TVmY0PVqD13Lq7rJUwD0rLk94Qt
         PUBss3q+nA9IcHnWl/3k0mPBR+/qSRLaBFB+79Rqo/U6kYCdbfA5EvmVBgwoNpzpyR
         I0zvNAjD0fmQA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so2701894fac.0;
        Sun, 10 Sep 2023 00:47:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YydSilwfKGe24xRrFxRKEqdYwA1tenaU4soHhyDmbr1kHt+8IOS
        YdHYTtvDR5ot7f3OMycYbrmqsLvVmGtN1cie3gw=
X-Google-Smtp-Source: AGHT+IEBkubfViNfd840oNX7D3PabXrKxgpjQiFTDranOshb3BpXDNpHDlTi16kEfT16QEkbmOYas6ZB1t32EfsqeQ4=
X-Received: by 2002:a05:6871:298:b0:1d0:da52:4235 with SMTP id
 i24-20020a056871029800b001d0da524235mr8701245oae.26.1694332070744; Sun, 10
 Sep 2023 00:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230905190828.790400-1-masahiroy@kernel.org> <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net> <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
 <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com> <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
In-Reply-To: <CAK7LNAQQ1Vp4YtvU8Bq9aE+NWxnnOTX2dcZ5Gc9fC+vjRmCe4w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 Sep 2023 16:47:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNATktSBFe=7cE8kHEGx2R90iVV6AJsCfgg5ZD2+ssMmzow@mail.gmail.com>
Message-ID: <CAK7LNATktSBFe=7cE8kHEGx2R90iVV6AJsCfgg5ZD2+ssMmzow@mail.gmail.com>
Subject: Re: [PATCH] linux/export: fix reference to exported functions for parisc64
To:     John David Anglin <dave.anglin@bell.net>,
        Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: multipart/mixed; boundary="00000000000035762c0604fc6dc1"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000035762c0604fc6dc1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi John, Helge,

Could you test the attached patch please?


Again, I only tested compilation for this.
I do not have parisc64 hardware.
In my understanding, QEMU does not support hppa64.
I do not find a way to test parisc64.


Masahiro Yamada





On Sun, Sep 10, 2023 at 4:20=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> With a little more investigation,
> I found arch/parisc/kernel/parisc_ksyms.c
> is causing the issue.
>
> That file is a collection of EXPORT_SYMBOL
> of assembly code.
>
> I will take a closer look tomorrow.
>
>
>
>
>
>
>
>
>
>
>
> On Sun, Sep 10, 2023 at 2:20=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Fri, Sep 8, 2023 at 7:02=E2=80=AFAM John David Anglin <dave.anglin@b=
ell.net> wrote:
> > >
> > > On 2023-09-05 7:59 p.m., John David Anglin wrote:
> > > > On 2023-09-05 5:57 p.m., John David Anglin wrote:
> > > >> I'll check ddb5cdbafaaa.
> > > > Similar fault with ddb5cdbafaaa:
> > > The alignment of the __kstrtab_ symbols in vmlinux seems wrong.
> >
> > __kstrtab_ symbols do not need alignment.
> >
> > They were not aligned at all
> > before ddb5cdbafaaa^.
> >
> >
> >
> > >  I'm fairly certain that function
> > > references prefixed with P% on hppa64 need 8 byte alignment.
> >
> > Yeah.
> > In the following dump, all of __ksymtab_* are correctly 8-byte aligned.
> >
> >
> > >
> > > 81662: 0000000040ea4358     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_s=
ystem[...]
> > >   81663: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
ns_syst[...]
> > >   81664: 0000000040e8e830     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab=
_system[...]
> > >   81665: 0000000040ea4365     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
_static[...]
> > >   81666: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
ns_stat[...]
> > >   81667: 0000000040ea1640     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab=
_static[...]
> > >   81668: 0000000040ea437c     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
_reset_[...]
> > >   81669: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
ns_rese[...]
> > >   81670: 0000000040e8bbc0     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab=
_reset_[...]
> > >   81671: 0000000040ea438a     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
_loops_[...]
> > >   81672: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
ns_loop[...]
> > >   81673: 0000000040e86610     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab=
_loops_[...]
> > >   81674: 0000000040ea439a     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
_init_uts_ns
> > >   81675: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
ns_init[...]
> > >   81676: 0000000040e99180     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab=
_init_uts_ns
> > >   81677: 0000000040ea43a6     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
_name_t[...]
> > >   81678: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
ns_name[...]
> > >   81679: 0000000040e9b340     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab=
_name_t[...]
> > >   81680: 0000000040ea43b4     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
_wait_f[...]
> > >   81681: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
ns_wait[...]
> > >   81682: 0000000040ea3638     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab=
_wait_f[...]
> > >   81683: 0000000040ea43c7     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab=
_init_task
> > > [...]
> > >
> > > I'm not sure how we get symbols that aren't 8 byte aligned.  The ".ba=
lign 4" directive
> > > in __KSYMTAB doesn't seem correct but it's not the whole problem.
> > >
> > > Dave
> > >
> > > --
> > > John David Anglin  dave.anglin@bell.net
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Best Regards
Masahiro Yamada

--00000000000035762c0604fc6dc1
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-linux-export-fix-reference-to-exported-functions-for.patch"
Content-Disposition: attachment; 
	filename="0001-linux-export-fix-reference-to-exported-functions-for.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lmd5gco60>
X-Attachment-Id: f_lmd5gco60

RnJvbSBlNDczYzlmYTQ5ODAxYWVhN2MzN2Q0Y2YxOTcxMGQ4OWZmMzU4YWI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3Jn
PgpEYXRlOiBXZWQsIDYgU2VwIDIwMjMgMDM6NDY6NTcgKzA5MDAKU3ViamVjdDogW1BBVENIXSBs
aW51eC9leHBvcnQ6IGZpeCByZWZlcmVuY2UgdG8gZXhwb3J0ZWQgZnVuY3Rpb25zIGZvcgogcGFy
aXNjNjQKCkpvaG4gRGF2aWQgQW5nbGluIHJlcG9ydGVkIHBhcmlzYyBoYXMgYmVlbiBicm9rZW4g
c2luY2UgY29tbWl0CmRkYjVjZGJhZmFhYSAoImtidWlsZDogZ2VuZXJhdGUgS1NZTVRBQiBlbnRy
aWVzIGJ5IG1vZHBvc3QiKS4KCkxpa2UgaWE2NCwgcGFyaXNjNjQgdXNlcyBhIGZ1bmN0aW9uIGRl
c2NyaXB0b3IuIFRoZSBmdW5jdGlvbgpyZWZlcmVuY2VzIG11c3QgYmUgcHJlZml4ZWQgd2l0aCBQ
JS4KCkFsc28sIHN5bWJvbHMgcHJlZml4ZWQgJCQgZnJvbSB0aGUgbGlicmFyeSBoYXZlIHRoZSBz
eW1ib2wgdHlwZQpTVFRfTE9QUk9DIGluc3RlYWQgb2YgU1RUX0ZVTkMuIFRoZXkgc2hvdWxkIGJl
IGhhbmRsZWQgYXMgZnVuY3Rpb25zCnRvby4KCkZpeGVzOiBkZGI1Y2RiYWZhYWEgKCJrYnVpbGQ6
IGdlbmVyYXRlIEtTWU1UQUIgZW50cmllcyBieSBtb2Rwb3N0IikKUmVwb3J0ZWQtYnk6IEpvaG4g
RGF2aWQgQW5nbGluIDxkYXZlLmFuZ2xpbkBiZWxsLm5ldD4KQ2xvc2VzOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1wYXJpc2MvMTkwMTU5OGEtZTExZC1mN2RkLWE1ZDktOWE2OWQwNmU2
YjZlQGJlbGwubmV0L1QvI3UKU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGly
b3lAa2VybmVsLm9yZz4KLS0tCiBpbmNsdWRlL2xpbnV4L2V4cG9ydC1pbnRlcm5hbC5oIHwgMiAr
Kwogc2NyaXB0cy9tb2QvbW9kcG9zdC5jICAgICAgICAgICB8IDkgKysrKysrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2V4
cG9ydC1pbnRlcm5hbC5oIGIvaW5jbHVkZS9saW51eC9leHBvcnQtaW50ZXJuYWwuaAppbmRleCAx
Yzg0OWRiOTUzYTUuLjQ1ZmNhMDliMjMxOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9leHBv
cnQtaW50ZXJuYWwuaAorKysgYi9pbmNsdWRlL2xpbnV4L2V4cG9ydC1pbnRlcm5hbC5oCkBAIC01
Miw2ICs1Miw4IEBACiAKICNpZmRlZiBDT05GSUdfSUE2NAogI2RlZmluZSBLU1lNX0ZVTkMobmFt
ZSkJCUBmcHRyKG5hbWUpCisjZWxpZiBkZWZpbmVkKENPTkZJR19QQVJJU0MpICYmIGRlZmluZWQo
Q09ORklHXzY0QklUKQorI2RlZmluZSBLU1lNX0ZVTkMobmFtZSkJCVAlbmFtZQogI2Vsc2UKICNk
ZWZpbmUgS1NZTV9GVU5DKG5hbWUpCQluYW1lCiAjZW5kaWYKZGlmZiAtLWdpdCBhL3NjcmlwdHMv
bW9kL21vZHBvc3QuYyBiL3NjcmlwdHMvbW9kL21vZHBvc3QuYwppbmRleCAzNGE1Mzg2ZDQ0NGEu
LmRlNDk5ZGNlNTI2NSAxMDA2NDQKLS0tIGEvc2NyaXB0cy9tb2QvbW9kcG9zdC5jCisrKyBiL3Nj
cmlwdHMvbW9kL21vZHBvc3QuYwpAQCAtMTIyOCw2ICsxMjI4LDE1IEBAIHN0YXRpYyB2b2lkIGNo
ZWNrX2V4cG9ydF9zeW1ib2woc3RydWN0IG1vZHVsZSAqbW9kLCBzdHJ1Y3QgZWxmX2luZm8gKmVs
ZiwKIAkgKi8KIAlzLT5pc19mdW5jID0gKEVMRl9TVF9UWVBFKHN5bS0+c3RfaW5mbykgPT0gU1RU
X0ZVTkMpOwogCisJLyoKKwkgKiBGb3IgcGFyaXNjNjQsIHN5bWJvbHMgcHJlZml4ZWQgJCQgZnJv
bSB0aGUgbGlicmFyeSBoYXZlIHRoZSBzeW1ib2wgdHlwZQorCSAqIFNUVF9MT1BST0MuIFRoZXkg
c2hvdWxkIGJlIGhhbmRsZWQgYXMgZnVuY3Rpb25zIHRvby4KKwkgKi8KKwlpZiAoZWxmLT5oZHIt
PmVfaWRlbnRbRUlfQ0xBU1NdID09IEVMRkNMQVNTNjQgJiYKKwkgICAgZWxmLT5oZHItPmVfbWFj
aGluZSA9PSBFTV9QQVJJU0MgJiYKKwkgICAgRUxGX1NUX1RZUEUoc3ltLT5zdF9pbmZvKSA9PSBT
VFRfTE9QUk9DKQorCQlzLT5pc19mdW5jID0gdHJ1ZTsKKwogCWlmIChtYXRjaChzZWNuYW1lLCBQ
QVRURVJOUyhJTklUX1NFQ1RJT05TKSkpCiAJCXdhcm4oIiVzOiAlczogRVhQT1JUX1NZTUJPTCB1
c2VkIGZvciBpbml0IHN5bWJvbC4gUmVtb3ZlIF9faW5pdCBvciBFWFBPUlRfU1lNQk9MLlxuIiwK
IAkJICAgICBtb2QtPm5hbWUsIG5hbWUpOwotLSAKMi4zOS4yCgo=
--00000000000035762c0604fc6dc1--
