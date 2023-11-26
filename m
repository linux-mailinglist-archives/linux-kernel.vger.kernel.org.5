Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAA57F9180
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 07:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjKZGAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 01:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZGAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 01:00:32 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC4710B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 22:00:38 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-462e70f1c20so320010137.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 22:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700978437; x=1701583237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVBJvNUR0/pOzjVeXc6+sRDyqqnU2dxLFNeCeuHxDVU=;
        b=deDQazEYemCGEm/n51V6uhPd/o/3oeo6qvjjfX7JBWvu7jILrJKsS9hXbF4CHFcAgD
         qv7T8nfbCiyapAuGSi+HYmPuKpVzYbv9drTh8n6UULD4oQ5ncF7FwITnuXgLxqOXrT7f
         KkPF5GyvTRRYR0MnOWfFFvJPCWlVKLr9rZ7TcQRv1gmDxwCZkHZiLSt+01ouk9qHOJet
         BanDpdt5lzGAvKQIA7ScpvdW0d+gaTGXi0WUw2sqgfmGW5/Hy9m75V9U5zmxopN8F1hU
         qclU6gO89E3oXHuZiARBNnCcYeksg5zU8tFtGj6s29Dw99ZF6bGB+gpjb4HwOC3dFDFu
         MU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700978437; x=1701583237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVBJvNUR0/pOzjVeXc6+sRDyqqnU2dxLFNeCeuHxDVU=;
        b=GlTiI+x/B2uD13S6SCtF13Wx82X4A6VsdX1b1zDgy8jCSN6qtmNO/REtFeyWNcLLPO
         ViPTML/TBoweAvHY544tbqH/wZntDEcSa1zWT9WifdRREfZUCZKFo5iVL7UQTtznmjkL
         QfsdDb0cSv7UJ30iLnygtv63Oxr7lUeVE7I3QSNGoapkNCKkL6hfvhlDTWxYAxS+zDBA
         pbow4xaSiZxmBzZdS0ke9Cntg90Npoapz4yBRse4GU1Q/Yl0GR5E/t627anxhpCXFzoM
         x3DtiGUriqyNNFN+vZKXjDvdUPN2qfXCCPa2zdxZA4I2ro1WE8lm8u2PRxIQtkuj+5T3
         rzmg==
X-Gm-Message-State: AOJu0YzljBPwKB1PTaEtMiTMX6OwIMTTgP47I5fBFNCil8FN9bmLPuOC
        8mLWfMnnGRQUdGBwYulz3fYaaGautHvNZ3jAwbc=
X-Google-Smtp-Source: AGHT+IE1p9k3rniddSbTwUCo9TJnI3mLES4fsMgMILjp1kCAu6k/EUx08S5m5sdskuf2vM49QMH02u0tBRGtnvPaiHg=
X-Received: by 2002:a67:e444:0:b0:462:9ad2:9f75 with SMTP id
 n4-20020a67e444000000b004629ad29f75mr2395567vsm.14.1700978437150; Sat, 25 Nov
 2023 22:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-8-lb@semihalf.com>
 <CAJfuBxzWSyw-Xp3k5WzOexbRZFydCUp_nX4A_BZs8Gq0OE2U7Q@mail.gmail.com>
 <CAK8ByeL=A6xC=q8Ah4im4JQGUcN_NZNg10pSezBPCeKW9J_DeQ@mail.gmail.com>
 <CAJfuBxzH=G++Qs86OGUFTC2WuBZh8JZ4y7a7KcVi+7R8L3N7Fw@mail.gmail.com>
 <CAK8Bye+uX38zDyGdd4GbsYWfPACNiaiBW92vZuRjuM1VDQqe0A@mail.gmail.com> <CAK8ByeK8mVQbmYsbCdZGf4F=RHPbGguDcKfhtbWF3-MpVDNkbg@mail.gmail.com>
In-Reply-To: <CAK8ByeK8mVQbmYsbCdZGf4F=RHPbGguDcKfhtbWF3-MpVDNkbg@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Sat, 25 Nov 2023 23:00:11 -0700
Message-ID: <CAJfuBxyVDy6e-M+g7-aydfHov_KGuF5Ze7Gx_bEGuU5mzzjbcg@mail.gmail.com>
Subject: Re: [PATCH v1 07/12] dyndbg: repack struct _ddebug
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 7:39=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> niedz., 12 lis 2023 o 17:28 =C5=81ukasz Bartosik <lb@semihalf.com> napisa=
=C5=82(a):
> >
> > pt., 10 lis 2023 o 22:01 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > On Fri, Nov 10, 2023 at 7:51=E2=80=AFAM =C5=81ukasz Bartosik <lb@semi=
half.com> wrote:
> > > >
> > > > sob., 4 lis 2023 o 02:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> > > > >
> > > > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@s=
emihalf.com> wrote:
> > > > > >
> > > > > > From: Jim Cromie <jim.cromie@gmail.com>
> > > > > >
> > > > > > Move the JUMP_LABEL to the top of the struct, since theyre both
> > > > > > align(8) and this closes a pahole (unfortunately trading for pa=
dding,
> > > > > > but still).
> > > > > >
> > > > > > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > > > >
> > > > > let me add, I havent really tested this, nevermind thorough.
> > > > > specifically, I didnt look for any offset dependence on the stati=
c-key
> > > > > inside their container.
> > > > > Conversely, maybe theres a free default or something in there.
> > > > >
> > > >
> > > > Any idea how to properly test the relocation of the key ?
> > >
> > > I was hoping Jason knew it from memory.
> > >
> > > I have booted dd-kitchen-sink, which includes it, and it didnt melt t=
he box.
> > >
> > > I just checked `pahole vmlinux` output for the existence of 0-offset =
keys.
> > > Its not conclusive, cuz im only looking at x86.
> > >
> > > it does occur, but only for "sub-types".
> > >
> > > struct static_key_true {
> > >         struct static_key          key;                  /*     0    =
16 */
> > >
> > >         /* size: 16, cachelines: 1, members: 1 */
> > >         /* last cacheline: 16 bytes */
> > > };
> > > struct static_key_false {
> > >         struct static_key          key;                  /*     0    =
16 */
> > >
> > >         /* size: 16, cachelines: 1, members: 1 */
> > >         /* last cacheline: 16 bytes */
> > > };
> > > struct static_key_false_deferred {
> > >         struct static_key_false    key;                  /*     0    =
16 */
> > > ...};
> > > struct static_key_mod {
> > >         struct static_key_mod *    next;                 /*     0    =
 8 */
> > > ...};
> > > struct static_key_deferred {
> > >         struct static_key          key;                  /*     0    =
16 */
> >
> > I will test it on arm64.
>
> Hi Jim,
>
> I verified that relocation of JUMP_LABEL to the top of the _ddebug
> struct does not brak dynamic debug functionality on arm64.
> I double checked I had CONFIG_JUMP_LABEL enabled in the kernel config for=
 arm64.
> I was able to enable/disable callsites and see debug logs being written.
>
> But if you're concerned there might be issue related to that
> relocation on other architectures then let's drop this patch
> and I will use pahole instead of padding for location of flags and
> trace destination fields.
> What do you think ?
>


On balance, I think it should go in.
0 - my bias was towards abundance of paranoia
1 - youve done real work to evaluate the actual risk
2 - Jason is on thread, hasnt said WHOA
3 - actual patches have seen some testing (lkp-robot included)
4 - static-keys/jump-labels have been around a long time

One new topic:

Do you have any thoughts or plans wrt self-testing ?

the addition of private instances,
that can be opened & closed, and written to by +T:private_1

would benefit greatly from a test harness to validate it.
so far all Ive done is demo scripts

:-) thanks

> Thanks,
> Lukasz
