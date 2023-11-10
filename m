Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A477E80DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345770AbjKJSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbjKJSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:15:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28E39CF0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:51:29 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso3497933a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699627888; x=1700232688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSMR8dxyjzyEm0qfqsXvPIA/2B69sE2CBTnv1SPmJOY=;
        b=O5LYlaWQNptiwrEMWAJMYqiOZ5YcD2l75FGzLcaJQqNZnQJcqGl8Gy6GsZ1/+crFCA
         j6L99KOgCx85qegsy/LzdB9UsXHBt7AAjgcbJYp6HKKjxuqL4uaDCYFIt6vxAQtkS1FN
         Ilh0HMwUf+HJJcXrSHrt74lL/swTr4SWFQZCJ/xTamZ8AzecPkS1+aAzv3CcQDJwiIav
         KCbn12BmiInLfYQaBGcKgYt7yilkHEJq9W62DkIAuIuWZ2SHXLMyOLBC7vM6zb15iW3x
         okwo06lG6CNvUT5WUXMzRdYGNvwiKeVxzLUtaPMExXGnf+gZ41wEx0BKgrOawbV9gEvx
         fqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627888; x=1700232688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSMR8dxyjzyEm0qfqsXvPIA/2B69sE2CBTnv1SPmJOY=;
        b=mnEXVuuGlOxq3FwcJI4QPwcdCftOemXlz5QQmZtQUiYyBiwjZOs0BAg/00gHjN5RUW
         Q2xT84mBco3ue4vpnVtArKVv56XRnNpY5Hexogm9GOauw/ow7x2VDF1RSUVPT+M3hzH7
         uQ6B5FnfXlKmOA4U6Vo5L3X6tw7Iqub8mlYCGsYY+/IQtUmZ7djwoItftHPhdqcJs5Nu
         rd7Kak5Boq+HxA6rE40+ebkgtlhpcNL3ra3/L8jCJTsMbHZATIxPI82R+8oJ1hET7/5t
         DCvRYOfbrqFvwaLBXqxAzD/cleJ1sCgSU5a8jrXb6oleX05hQPN3NWvHvv2mc+ZBcC3N
         NMBQ==
X-Gm-Message-State: AOJu0Yzw9683q/n/4Zb3GtQ1LO4A7wV4MmwXTl/8hQ7E8x6m8UaKLGbZ
        IHp/h/sWejqTC6A+K4PyWNqUa26LiHG/OGmM3hY2
X-Google-Smtp-Source: AGHT+IEBJy7pW09ZpWJE+X5ayh6GPav+IfFA4hHpT9tyAqBCmyass9F8ujOQ0E+xfVqLvEP2dNCIfJkRZcEalLlgt+E=
X-Received: by 2002:a50:d741:0:b0:540:2ece:79 with SMTP id i1-20020a50d741000000b005402ece0079mr7759670edj.10.1699627888118;
 Fri, 10 Nov 2023 06:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-7-lb@semihalf.com>
 <20231106194500.123a517e@gandalf.local.home>
In-Reply-To: <20231106194500.123a517e@gandalf.local.home>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 10 Nov 2023 15:51:17 +0100
Message-ID: <CAK8ByeKz1uxFqTPHxkj0+1fiU-gFN4q+_rGHWmE2U-rSY=sRdg@mail.gmail.com>
Subject: Re: [PATCH v1 06/12] trace: use TP_printk_no_nl in dyndbg:prdbg,devdbg
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 7 lis 2023 o 01:45 Steven Rostedt <rostedt@goodmis.org> napisa=C5=82(a=
):
>
> On Fri,  3 Nov 2023 14:10:05 +0100
> =C5=81ukasz Bartosik <lb@semihalf.com> wrote:
>
> > index ccc5bcb070f9..91dcdbe059c0 100644
> > --- a/include/trace/events/dyndbg.h
> > +++ b/include/trace/events/dyndbg.h
> > @@ -20,20 +20,10 @@ TRACE_EVENT(prdbg,
> >
> >           TP_fast_assign(
> >                       __entry->desc =3D desc;
> > -                     /*
> > -                      * Each trace entry is printed in a new line.
> > -                      * If the msg finishes with '\n', cut it off
> > -                      * to avoid blank lines in the trace.
> > -                      */
> > -                     if (len > 0 && (text[len - 1] =3D=3D '\n'))
> > -                             len -=3D 1;
> > -
> >                       memcpy(__get_str(msg), text, len);
> > -                     __get_str(msg)[len] =3D 0;
> >                   ),
> >
> > -         TP_printk("%s.%s %s", __entry->desc->modname,
> > -                   __entry->desc->function, __get_str(msg))
> > +         TP_printk_no_nl("%s", __get_str(msg))
> >  );
> >
>
> Instead of adding the TP_printk_no_nl() (Which I still do not like), we
> could add a:
>
>         __get_str_strip_nl(msg)
>
> That will do the above loop. Which will move the processing to read side
> (slow path).
>
> And then we could update libtraceevent to handle that too.
>

Thanks Steve.

Jim, if you don't mind I will make the suggested changes ?

> -- Steve
