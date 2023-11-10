Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D494E7E845E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbjKJUmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbjKJUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:41:44 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0348371E7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:51:50 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507f1c29f25so2823708e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699627909; x=1700232709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Mvi7lav8JrZRYFQ+CoUkEYfxxgB5+JW9swJ4hiybl8=;
        b=GXiXYlfZ+pJhnm/PjXeJmABrjGuK6bTE3ngz8Ypc8hRW5DFxsQnZGPtC8hbdI8xdu4
         JiWPjEOX67QKGe5FBJobtjSr3hOYno3AvDzFnwyHwUzYdbesKN8A4KB2vAHWSwM/boJx
         fwDo+MKBmu5IYCavFGNfApIxgajy+92+XpSm0rs93QxStbN89FkAN1sbP/WueYz6xJFl
         HAkBuYgGZGjZ5Rm40MjJydsi6GV1RKUFULG4vBFRqS1XZGQYBvROqJm+wQLz4PUoYLTy
         TxZZEKOvczi421nTZiRI8NjK8ieLydQ2LvsWbVg038QNxxY50jvaQW9v3X/cXeuGcbs6
         hkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627909; x=1700232709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Mvi7lav8JrZRYFQ+CoUkEYfxxgB5+JW9swJ4hiybl8=;
        b=aBVcAxBH8eCNfe5WjoCqh06NDCanMAeaR6sJ7+0VkMY8OTnMiySlvTHndBmnFdzrQK
         NYlqyzHfoTV5EtNd2Q54edsHStXFqQzReThAYsG107PzXxKP8TmYWaqh9C9MYxD9nvlk
         db27ctPnD1sM4F4mh6P85cINf3b8eEDjTwmAoCGVlyZK597CWeiBQ6sSzM4vT0eJpa4E
         91qp6EMsH97iSdvTOI67b0SLGFB+UZ7heK/68Y9jcJN29FIXz2TtTftIGmU89cyfeSll
         bu0eT4lQ0zy051hpdWUdtUx8sh3oZ6V79XjUSVYJBXxwOlDcF3YfPsdWC/jpk0Pi3stG
         ozxQ==
X-Gm-Message-State: AOJu0YxpyEuZOX1JMlSjgk2GaRSZWvvsJ1BIzEiPo3C2oEjAdezZR2HL
        zqFwcJr6VD1aHtodwGuo8dJtKVAALcS6UI+bpxo3
X-Google-Smtp-Source: AGHT+IHDGtAWuHGdBX3OpRSPta7vwVkXkLgCdzLshmpa67UAo2J4X9u84Iqw0CinBX7CCPHtuReKq+0mwKx0DtLyOgo=
X-Received: by 2002:a19:4f01:0:b0:503:385c:4319 with SMTP id
 d1-20020a194f01000000b00503385c4319mr3532227lfb.19.1699627908829; Fri, 10 Nov
 2023 06:51:48 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-8-lb@semihalf.com>
 <CAJfuBxzWSyw-Xp3k5WzOexbRZFydCUp_nX4A_BZs8Gq0OE2U7Q@mail.gmail.com>
In-Reply-To: <CAJfuBxzWSyw-Xp3k5WzOexbRZFydCUp_nX4A_BZs8Gq0OE2U7Q@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 10 Nov 2023 15:51:37 +0100
Message-ID: <CAK8ByeL=A6xC=q8Ah4im4JQGUcN_NZNg10pSezBPCeKW9J_DeQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/12] dyndbg: repack struct _ddebug
To:     jim.cromie@gmail.com
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 4 lis 2023 o 02:49 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.=
com> wrote:
> >
> > From: Jim Cromie <jim.cromie@gmail.com>
> >
> > Move the JUMP_LABEL to the top of the struct, since theyre both
> > align(8) and this closes a pahole (unfortunately trading for padding,
> > but still).
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> let me add, I havent really tested this, nevermind thorough.
> specifically, I didnt look for any offset dependence on the static-key
> inside their container.
> Conversely, maybe theres a free default or something in there.
>

Any idea how to properly test the relocation of the key ?



> > ---
> >  include/linux/dynamic_debug.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 497130816e9c..b9237e4ecd1b 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -14,6 +14,12 @@
> >   * the special section is treated as an array of these.
> >   */
> >  struct _ddebug {
> > +#ifdef CONFIG_JUMP_LABEL
> > +       union {
> > +               struct static_key_true dd_key_true;
> > +               struct static_key_false dd_key_false;
> > +       } key;
> > +#endif
> >         /*
> >          * These fields are used to drive the user interface
> >          * for selecting and displaying debug callsites.
> > @@ -53,12 +59,6 @@ struct _ddebug {
> >  #define _DPRINTK_FLAGS_DEFAULT 0
> >  #endif
> >         unsigned int flags:8;
> > -#ifdef CONFIG_JUMP_LABEL
> > -       union {
> > -               struct static_key_true dd_key_true;
> > -               struct static_key_false dd_key_false;
> > -       } key;
> > -#endif
> >  } __attribute__((aligned(8)));
> >
> >  enum class_map_type {
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
