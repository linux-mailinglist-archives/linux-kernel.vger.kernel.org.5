Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40227E8295
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346096AbjKJTZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346191AbjKJTZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:25:09 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF4A241
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:21:31 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b9ff2b6f9bso988050241.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699644090; x=1700248890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rj+mwX3atTYRm5E9cvZquh4fnIssUkhFIuKei33GjsY=;
        b=T8OAIFjQDnTXcNfzMLE8nwmu/AugmYHuapyq3rOcvYaa9gvEXmlujtQapY3Lw7BRy1
         eROegYDD6UgGD/xtibwtFC3NhMaalK4xqD40pzAU2dXJp9U2KQYDK/q6cT7Mj35dkx6u
         +FYMgrjiPLrQVvSeCmunZZVBFP0kg3NFiFzyWaztVjcrCHbrSmtCi7Cr2HYtV5cqXXKz
         ltQ89MmZ4dwpYEgIE+1kAI9HcPZfaW8JBPJNq3mA7j0Axudj80BJojU1EKjuG2GYCUM8
         D0LITZbsN9X8k5f7l0CO1WvV94ZtRCw34kUPGAU3O+Ao+WTl0S3DXyzTpHQIn8o1Soeb
         IBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699644090; x=1700248890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rj+mwX3atTYRm5E9cvZquh4fnIssUkhFIuKei33GjsY=;
        b=igXOwPvNzD5oZOdCvRZlDnvFLW5y5Fmd/PWVO5Gl+BJqkdViX/+uAXmqGmreTBNGZA
         qROUmd5ROrGYmIAWxH16MM/h4B53RCRxtuPe2CteUychngENoFq7dqM7Q9rC0TFOnSX4
         B/ufEXQzZKwQ8D+IdICLwDvf2QAKRzmzY1lzD60y60Grj4NYEfUT9SU/yHWRJfabVu8D
         8gAj1Ru+iPMigGer6GnUOeLpgfLYi8b/azAi/XD4KptVfaANMEje/eleBg5y36ylgdXr
         F561x9cpZVLs6ED67S0Qpd8h1DuaCPiuewVRGsBhw0N/iS0fVRNdfXr/Vqm/9+Q04Z7J
         DJWw==
X-Gm-Message-State: AOJu0YwCbYLaIsv3K9TxDtoOLmif3iSrjcgBrbEwfGoFQjtL/eeXa6sk
        5gXMhnUk4C4dSmF4vSBZ8KeDXhYdyV2s+vQfk90=
X-Google-Smtp-Source: AGHT+IEsbmRjnww/TO6ipd/nzDUqoHrhOdLtlToiOUsZX9lLXUC/rT8AWm6ZC4y6XzxC49yLFgfZ26AabJRAunG3tMk=
X-Received: by 2002:a05:6102:2d04:b0:460:5a82:fc55 with SMTP id
 ih4-20020a0561022d0400b004605a82fc55mr422683vsb.28.1699644090529; Fri, 10 Nov
 2023 11:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-7-lb@semihalf.com>
 <20231106194500.123a517e@gandalf.local.home> <CAK8ByeKz1uxFqTPHxkj0+1fiU-gFN4q+_rGHWmE2U-rSY=sRdg@mail.gmail.com>
In-Reply-To: <CAK8ByeKz1uxFqTPHxkj0+1fiU-gFN4q+_rGHWmE2U-rSY=sRdg@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Nov 2023 12:21:04 -0700
Message-ID: <CAJfuBxxXE3ro2_WHM=c7yExcJqc8qY7rFmnT=jUs9_V4rTPugg@mail.gmail.com>
Subject: Re: [PATCH v1 06/12] trace: use TP_printk_no_nl in dyndbg:prdbg,devdbg
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
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

On Fri, Nov 10, 2023 at 7:51=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> wt., 7 lis 2023 o 01:45 Steven Rostedt <rostedt@goodmis.org> napisa=C5=82=
(a):
> >
> > On Fri,  3 Nov 2023 14:10:05 +0100
> > =C5=81ukasz Bartosik <lb@semihalf.com> wrote:
> >
> > > index ccc5bcb070f9..91dcdbe059c0 100644
> > > --- a/include/trace/events/dyndbg.h
> > > +++ b/include/trace/events/dyndbg.h
> > > @@ -20,20 +20,10 @@ TRACE_EVENT(prdbg,
> > >
> > >           TP_fast_assign(
> > >                       __entry->desc =3D desc;
> > > -                     /*
> > > -                      * Each trace entry is printed in a new line.
> > > -                      * If the msg finishes with '\n', cut it off
> > > -                      * to avoid blank lines in the trace.
> > > -                      */
> > > -                     if (len > 0 && (text[len - 1] =3D=3D '\n'))
> > > -                             len -=3D 1;
> > > -
> > >                       memcpy(__get_str(msg), text, len);
> > > -                     __get_str(msg)[len] =3D 0;
> > >                   ),
> > >
> > > -         TP_printk("%s.%s %s", __entry->desc->modname,
> > > -                   __entry->desc->function, __get_str(msg))
> > > +         TP_printk_no_nl("%s", __get_str(msg))
> > >  );
> > >
> >
> > Instead of adding the TP_printk_no_nl() (Which I still do not like), we
> > could add a:
> >
> >         __get_str_strip_nl(msg)
> >
> > That will do the above loop. Which will move the processing to read sid=
e
> > (slow path).
> >
> > And then we could update libtraceevent to handle that too.
> >
>
> Thanks Steve.
>
> Jim, if you don't mind I will make the suggested changes ?
>

if Steve likes it, Im happy.

> > -- Steve
