Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242E079B502
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377672AbjIKW15 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Sep 2023 18:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbjIKNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:42:04 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8321CDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:41:58 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-58cbdf3eecaso42485277b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439717; x=1695044517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Fjv8PmDJnyBJVhOZHOd88BdYtAyAHCd5lHO8BTBdh4=;
        b=Na2LQUWeVF7jDBylb60A4VUXIHNTs9MDsaL2O7T3INUcb9BLw7e8Ij48xlZRK0pqvr
         BQ2rqWa017hTdMY8hWaaqawguzWb9oSLQcvmUr8CrmDSvuZx6Lv9OpgNaEEBcYvjREJL
         o/XoStxuw0lWtmW1ABsws8B8nw6JiL5OZMun9aO5pE1H+iNXjKzrvZdGWXrVgNQETX0V
         jXzuXARdRMW+6C43R6USwpWfH+Wgd49AbhRi78w06+NoELTjhrO5k8OYHXzsuA3+DLA7
         Oo6WVebBQNl8Y6tcj3RNJS+qQVTsKiOkbe7GkwB6bUiJX3VBz8Ojd/zTDIX7v+HeFpFr
         vElw==
X-Gm-Message-State: AOJu0Yz0ByHFDVtvUmK3pRUkfJKtJgr1LKIDLG3XS468bdMw485+ci2W
        5XmUHvbUxznoRAgqw2tp2M5DY/OjSkooXw==
X-Google-Smtp-Source: AGHT+IGMUhJ9XHnA3epqXcUiALavASR49osga2uJM/GgtWeEFFT9EqN0wLZYC3T1aMLk3U2bbDr4qA==
X-Received: by 2002:a5b:690:0:b0:d78:f32:5849 with SMTP id j16-20020a5b0690000000b00d780f325849mr7993745ybq.24.1694439717695;
        Mon, 11 Sep 2023 06:41:57 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id y3-20020a259b03000000b00d8098adcb01sm655155ybn.37.2023.09.11.06.41.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:41:56 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-d7260fae148so4005299276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:41:56 -0700 (PDT)
X-Received: by 2002:a25:ef4d:0:b0:d7a:c4dc:e7b3 with SMTP id
 w13-20020a25ef4d000000b00d7ac4dce7b3mr8154432ybm.61.1694439716223; Mon, 11
 Sep 2023 06:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694093327.git.geert@linux-m68k.org> <64ea8cf65a4318fbf8c91cb3062d90a2555007c4.1694093327.git.geert@linux-m68k.org>
 <2545f40a-0c59-491d-895f-4a7975faaedc@app.fastmail.com> <CAMuHMdWs0QbRQZCXZ2Gycqb7jjsjUZMp7_h2mVWxR1zrjCL1Og@mail.gmail.com>
 <76998b95-827a-4e71-8782-0990b204fcfa@app.fastmail.com>
In-Reply-To: <76998b95-827a-4e71-8782-0990b204fcfa@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Sep 2023 15:41:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVmjFm89kW_=AiatXZ_M2gSJ7+csvv3N77OM_cbsF_tSA@mail.gmail.com>
Message-ID: <CAMuHMdVmjFm89kW_=AiatXZ_M2gSJ7+csvv3N77OM_cbsF_tSA@mail.gmail.com>
Subject: Re: [PATCH 15/52] m68k: emu: Mark version[] __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-m68k@lists.linux-m68k.org,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Sat, Sep 9, 2023 at 4:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Sep 9, 2023, at 14:12, Geert Uytterhoeven wrote:
> > On Sat, Sep 9, 2023 at 10:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Thu, Sep 7, 2023, at 15:41, Geert Uytterhoeven wrote:
> >> > When building with W=1:
> >> >
> >> >     m68k/arch/m68k/emu/nfeth.c:42:19: warning: ‘version’ defined but
> >> > not used [-Wunused-const-variable=]
> >> >        42 | static const char version[] =
> >> >         |                   ^~~~~~~
> >> >
> >> > Fix this while obeying the wishes of the original copyright holders by
> >> > marking version[] with __maybe_unused.
> >> >
> >> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >>
> >> That will just drop it from the object file, maybe it should
> >> instead be marked "__used" ?
> >
> > Given it's been like this since the beginning, I guess it never showed
> > up in the object file anyway...
>
> Older compilers used to keep unused variables, and all versions
> still do when building with -O0 instead of the usual -O2.
>
> I can see on godbolt.org that gcc-1.27 did not have that optimization
> yet, while gcc-4.1 had it, but I haven't found any versions between
> those. I vaguely remember us throwing out the version strings from
> most kernel files a long time ago, possibly that was triggered by
> gcc no longer putting them into the object any more, but I can't
> find a reference for that.
>
> What I can see is that a lot of old network drivers have version
> strings like this one, but they are actually printed from the
> probe function, and lost their __devinitdata annotation in the past.

The version string in arch/m68k/emu/nfeth.c used to be __devinitdata,
too, but it was never printed.  So I'm just gonna silence the warning,
as this patch does.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
