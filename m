Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30077E91AB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjKLQcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjKLQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:32:12 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99227FA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:32:05 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so6106555a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699806724; x=1700411524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tfogd60Mf10SUzDNNbUyjU+larXxYctWj7sHRw5ljA8=;
        b=tcNv0GB4xI2cX5dG59g8QdpDzjufFKPVsibpodd1atBojJhTemUH/h/fjbstGzmyga
         dy+KfM9fIypJCsMu0RxZhl4ENaXsX0FFgJfFoMEIL+cPgEQ0Huuy6nreZeKZ2tE3aUxH
         vLOhRvf2QBK3ZpxUJigs9LsgVTkNPzRs10Kd9aT/1wXWazrXa4BIZuiir3I39AkBGbU2
         HZmI+iEtMmBy+ABriWe0Dd/7oBCrCBHlLfmYSxgKmWbCpGys8f6pfYZbSBkazJYy83oI
         SY4QmXARHzOeDS8NWd4UyG7hgmXuykmC3ErU14YMnoe/ad63TiUP0IBWzXOmkNm90knq
         t2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699806724; x=1700411524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tfogd60Mf10SUzDNNbUyjU+larXxYctWj7sHRw5ljA8=;
        b=DnTA6fEtAtiCgwFqIV5BnESfH51Y0wOdCzXsP4mpXX0nW7N7/HqeTel9AgD0hgpTWZ
         FyESCuxwc6tNlXqi8woXk5IojLfpxk83S6svxfpoVvLzOiLmyD4t5o5MQpwFVejCPPza
         iwN2Gr3OZu8C276FC52vIjPX0yeOxQGMI5z0fmfqX6qesut9AlG3FGwgy2ZifLYwThmM
         c3125AFFedpjEnOfktsQOB/zDGmqBQfW0js1Kov47twDh4bRF6rZMJ+QGusK1kjxQ688
         NuSVGC3UVDuijpYMx3NsxTYf9s/SBSO+yh+tYptxW1bS4PbesanxbX8zOcQVqbJXJfai
         MnDQ==
X-Gm-Message-State: AOJu0YwOIUow0uqWtLr0+NOMK6TRCHgBH16Zr8TTLjJhiM15KV9Ge/k7
        e8sCwOw5mNc9P5fd1nKnpTo2iNCqQ2gM48i+k9ye
X-Google-Smtp-Source: AGHT+IE9B+zbno9ebZVEV2FxbcHB/82M5t9YoPRGLccBXw6sd0pMpgtSFQ/1CwP8F7GoU7QiSb+R+Aq1JWzL9DcXoeQ=
X-Received: by 2002:aa7:c04a:0:b0:543:783:e8c5 with SMTP id
 k10-20020aa7c04a000000b005430783e8c5mr3229363edo.18.1699806723966; Sun, 12
 Nov 2023 08:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-12-lb@semihalf.com>
 <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com>
 <CAK8ByeJ1fYSVaVQz3tERzj_5QNAN4Ggx850pKcAG3vhsoWnS+w@mail.gmail.com> <CAJfuBxyu3VqakFNr4mW0h4QiPVSf-7HSPXobGO2_qC-H8yLgcw@mail.gmail.com>
In-Reply-To: <CAJfuBxyu3VqakFNr4mW0h4QiPVSf-7HSPXobGO2_qC-H8yLgcw@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Sun, 12 Nov 2023 17:31:52 +0100
Message-ID: <CAK8ByeL1WwdVKSMtGfbHZLfYm73ZwjiEbtNZJiWur-spMc74Zg@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] dyndbg: write debug logs to trace instance
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 lis 2023 o 21:03 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 10, 2023 at 7:53=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > sob., 4 lis 2023 o 22:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semih=
alf.com> wrote:
> > > >
> > > > When trace is enabled (T flag is set) and trace_dst field is set
> > > > to value greater than 0 (0 is reserved for trace events) then
> > > > debug logs will be written to trace instance pointed by trace_dst
> > > > value, for example when trace_dst value is 2 then debug logs will
> > > > be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.
> > > > Given trace instance will not be initialized until debug logs are
> > > > requested to be written to it and afer init will persist until
> > > > reboot.
> > > >
> > >
> > > restating 00 comments -
> > >
> > > you can get rid of integer destination ids by adding a new command: o=
pen/close
> > >
> > > $> echo  \
> > >  open kms-instance \;\
> > >  class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites \;\
> > > > /proc/dynamic_debug/control
> > >
> >
> > Instead of using above command to preset destination we could preset
> > destination with open command. I mean last successful
> > open would preset destination ? What do you think ?
> >
>
> I dont think it works - if open maps to a dest-number, (or implicit as
> TOP-of-stack)
> then you just have +T<dest-number>  (or +T <implicit tos>)
> rather than +T:dest-name
> and you still have to keep track of what dest-numbers were already used.
> (or every new dest needs an explicit OPEN before it)
>
> and how do you then get back to default instance ?
> open 0 ?
> close <previous-handle> ?
>
>
> by using names, all opens can be at the top,
> (and thus document in 1 block all the named-instances)
> and any named dest that hasnt been opened is an error
> (not just reusing previous OPEN)
>

Sorry, I should have been more specific with my proposal. Let me use
an example to clarify it:
open usb -> create trace instance "usb" and make it default
echo module usbcore +T > /proc/dynamic_debug/control --> write usbcore
debug logs to trace instance named usb
open tbt --> create trace instance "tbt" and make it default
echo module aaa +T:usb > /proc/dynamic_debug/control --> write aaa
debug logs to trace instance named usb, instance usb has to be used
explicitly

                         because now tbt is default trace instance
echo module bbb +T > /proc/dynamic_debug/control --> write bbb debug
logs to trace instance named tbt
close tbt --> close tbt trace instance, I omit this step but in order
for an instance to be successful closed it must not be used by any
callsite, after
                    closing tbt instance the usb becomes default instance

I agree that your method of setting default trace instance is more flexible=
:
class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites

Maybe we can combine both to set default trace destination ?

Also I think we need a reserved keyword for writing debug logs to
trace events - maybe "event" keyword ?


>
> > >
> > > and +T  w/o dest means use existing setting, not just 0 (unless thats
> > > the existing setting)
> > >
> >
> > Sounds good.
> >
>
> :-)
