Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716E2799A3D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 19:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbjIIRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbjIIRVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 13:21:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF26712F;
        Sat,  9 Sep 2023 10:21:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886F8C433C7;
        Sat,  9 Sep 2023 17:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694280090;
        bh=Fy3dsH6BRUVHCxBCS1Ol5LVfvfdC3A7vOM9N2EJH1Xc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o4Egzq1ZmUFCj0zkyojf3+qUcHBKsqrs0rUgUf08TG6qm9uppaKld6KlQBnAXbtxk
         JDwbXxuQHrM2bJXG88ttjoHDoWUC/9xyYcwv+bqxjxvqlrDAVgu3O9gW84Iprjt5H/
         JPJOxge1hxdONHBzoY7vRFIbzgYzJYpKhN7hucv0QWO4iYt7e3XD/JlT6KsbGqO8V2
         GXCD+9Pg1rYFfpHWON6wuq6HGUkyy/bJ9gpPbzsrvspbxxMuNcI16d6hEsZ/NewCYb
         6FNRkowQBT0dt2N2Dw2OCTUjUnZM0O8ovCJf6+JIN0XQirQEdO5iSzI/Srh0UqVn7G
         kLPkuWf+8Do8g==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5731fe1d2bfso1754239eaf.3;
        Sat, 09 Sep 2023 10:21:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YxifHa7neqVW91oS7bFt+/WN9YUN1P19TBGYZPjML/3oL16HGfi
        ViEO12+07kTeYpS06jwP1mYIZ7FcWlyD+LrfZ+E=
X-Google-Smtp-Source: AGHT+IGNd1Fj9owK04/CdOgMNqi1FHImSwQpv/o/xxTpqnwv84VBIBEmeafB6ZjfN4eb1c/sUrJ9E3HZXojXBVWFfuM=
X-Received: by 2002:a05:6870:e15:b0:1d5:8f05:39da with SMTP id
 mp21-20020a0568700e1500b001d58f0539damr1874926oab.25.1694280089951; Sat, 09
 Sep 2023 10:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230905190828.790400-1-masahiroy@kernel.org> <c8a92dc8-de78-7484-bcc8-d4a91bec77de@bell.net>
 <c6568683-86b4-c48d-ed37-f1f87677eb44@bell.net> <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
In-Reply-To: <97859bf1-c8c3-7294-8322-b0c9c408ba5e@bell.net>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 Sep 2023 02:20:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
Message-ID: <CAK7LNAR_4rVgAQToSoYmbgYnWoSpowcrKi2ciiH9HyhJUGdmWg@mail.gmail.com>
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

On Fri, Sep 8, 2023 at 7:02=E2=80=AFAM John David Anglin <dave.anglin@bell.=
net> wrote:
>
> On 2023-09-05 7:59 p.m., John David Anglin wrote:
> > On 2023-09-05 5:57 p.m., John David Anglin wrote:
> >> I'll check ddb5cdbafaaa.
> > Similar fault with ddb5cdbafaaa:
> The alignment of the __kstrtab_ symbols in vmlinux seems wrong.

__kstrtab_ symbols do not need alignment.

They were not aligned at all
before ddb5cdbafaaa^.



>  I'm fairly certain that function
> references prefixed with P% on hppa64 need 8 byte alignment.

Yeah.
In the following dump, all of __ksymtab_* are correctly 8-byte aligned.


>
> 81662: 0000000040ea4358     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_syste=
m[...]
>   81663: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_s=
yst[...]
>   81664: 0000000040e8e830     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab_sys=
tem[...]
>   81665: 0000000040ea4365     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_sta=
tic[...]
>   81666: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_s=
tat[...]
>   81667: 0000000040ea1640     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_sta=
tic[...]
>   81668: 0000000040ea437c     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_res=
et_[...]
>   81669: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_r=
ese[...]
>   81670: 0000000040e8bbc0     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab_res=
et_[...]
>   81671: 0000000040ea438a     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_loo=
ps_[...]
>   81672: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_l=
oop[...]
>   81673: 0000000040e86610     0 NOTYPE  LOCAL  DEFAULT   14 __ksymtab_loo=
ps_[...]
>   81674: 0000000040ea439a     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_ini=
t_uts_ns
>   81675: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_i=
nit[...]
>   81676: 0000000040e99180     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_ini=
t_uts_ns
>   81677: 0000000040ea43a6     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_nam=
e_t[...]
>   81678: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_n=
ame[...]
>   81679: 0000000040e9b340     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_nam=
e_t[...]
>   81680: 0000000040ea43b4     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_wai=
t_f[...]
>   81681: 0000000040ea4748     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtabns_w=
ait[...]
>   81682: 0000000040ea3638     0 NOTYPE  LOCAL  DEFAULT   15 __ksymtab_wai=
t_f[...]
>   81683: 0000000040ea43c7     0 NOTYPE  LOCAL  DEFAULT   16 __kstrtab_ini=
t_task
> [...]
>
> I'm not sure how we get symbols that aren't 8 byte aligned.  The ".balign=
 4" directive
> in __KSYMTAB doesn't seem correct but it's not the whole problem.
>
> Dave
>
> --
> John David Anglin  dave.anglin@bell.net
>


--=20
Best Regards
Masahiro Yamada
