Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71E27A55F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjIRW4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIRW4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:56:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36D8F;
        Mon, 18 Sep 2023 15:56:10 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a64619d8fbso664555766b.0;
        Mon, 18 Sep 2023 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695077769; x=1695682569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tftkfCRDvcs4v9yhjyjUTVMx7qSfJ5Yv3Qi6b8m0pFI=;
        b=O0WFZ+zzLWhT9X5G7eiq1e9CwaGn5oX1smu3hlkLv4qGf8br8pz8lhL8dJwEJilNTb
         1H2u7mZ6u1NDJBLrJrCrZeDBfgGT1Z3GUjykVPHbiprY4EHJUM7I0FTtqGhUHcH52T0T
         MWweEchCume+SBtp0H0A7s9e8dPFfnGOlbPYpaZB6oFlGYbooAw3iUcVvEvhwRl1slUv
         1c9s4sg3F2CadYB5Hz9wdflrhig1QpBxSnA/t4AzrjsL/szu4Y2YRiS55i1syvOTOFLJ
         geDcP/I4o/wHYTE9W2B3rSD3kRYWLCJ97X3b6+8mGAL0TDQ16b0XCRfmu/wChqzNNC2S
         X9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695077769; x=1695682569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tftkfCRDvcs4v9yhjyjUTVMx7qSfJ5Yv3Qi6b8m0pFI=;
        b=Mut4vwGgMtkzil67eIggTYY1J4R9P8eeMePaBYAlifVZdh/nJAlRDun8oX6EYHUJ/e
         pSBu8Ao4+eTn1xCk1KA2rE+dP20UirEq+lbmx6uwftL5IwLLa4dwvoO5IMQtjzeGg0ar
         F6v9LDbtUNbKyRtXXLDwF2PFJ/Y9ZUW8szpgzW1SosIr/H45a2yN6VuhXieWnUATtZ1Z
         mKxuSWpUTzi+Z7jsiPswfgsfAJorK9K9AiZpZabT37+0ZkHg9r6wZh+ReaFAmGHzJ8It
         RBez+uE590ud4i6P2EYn+i0xjKSEttP0KLgX15jquZT0reExG6tB4hy40fn1//QP92CX
         /qCQ==
X-Gm-Message-State: AOJu0YzEtIZZCz/n7G/56vUTSaVH3lAxJ/nYxBscEovqwPZ8R3aBaOqL
        1L0dcEn7ZYm7cHPT6JouK2kdlt9vWQPLkwsfL8w=
X-Google-Smtp-Source: AGHT+IFpC7h3oiR2e/FsAxZpvqmdBeNGyNbZC00OQ9F6uY4pZs5emDtplxQ/fvPIz/FLvbM4UJDM2JpjENynkjMDLyA=
X-Received: by 2002:a17:906:519b:b0:9ad:e298:a5d with SMTP id
 y27-20020a170906519b00b009ade2980a5dmr9218002ejk.19.1695077769209; Mon, 18
 Sep 2023 15:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
In-Reply-To: <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
From:   Brian Pardy <brian.pardy@gmail.com>
Date:   Mon, 18 Sep 2023 18:55:58 -0400
Message-ID: <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[RS removed from CC due to bounce message]

On Wed, Sep 6, 2023 at 5:03=E2=80=AFPM Brian Pardy <brian.pardy@gmail.com> =
wrote:
> On Tue, Sep 5, 2023 at 9:01=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
> > Thanks for the regression report. But if you want to get it fixed,
> > you have to do your part: perform bisection. See Documentation/admin-gu=
ide/bug-bisect.rst in the kernel sources for how to do that.
> >
> > Anyway, I'm adding it to regzbot:
> >
> > #regzbot ^introduced: v6.4..v6.5
> > #regzbot title: incorrect CPU utilization report (multiplied) when moun=
ting CIFS
>
> Thank you for directing me to the bug-bisect documentation. Results below=
:
>
> # git bisect bad
> d14de8067e3f9653cdef5a094176d00f3260ab20 is the first bad commit
> commit d14de8067e3f9653cdef5a094176d00f3260ab20
> Author: Ronnie Sahlberg <lsahlber@redhat.com>
> Date:   Thu Jul 6 12:32:24 2023 +1000
>
>     cifs: Add a laundromat thread for cached directories
>
>     and drop cached directories after 30 seconds
>
>     Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
>     Signed-off-by: Steve French <stfrench@microsoft.com>
>
>  fs/smb/client/cached_dir.c | 67 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/smb/client/cached_dir.h |  1 +
>  2 files changed, 68 insertions(+)

Is there any further information I can provide to aid in debugging
this issue? Should I just expect incorrect load average reporting when
a CIFS share is mounted on any kernel >6.5.0?

I'm not clear on the value or necessity of this "laundromat thread" -
everything worked as expected before it was added - shall I just patch
it out of my kernel builds going forward if there is no interest in
fixing it? Is a .config option to disable it possible?
