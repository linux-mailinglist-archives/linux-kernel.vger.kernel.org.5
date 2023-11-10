Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9297E834E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345381AbjKJUDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjKJUD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:03:28 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963F6A9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:03:25 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2df2fb611so1534561b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699646605; x=1700251405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiR+2pf8KgWC6QuYOupk0/cL7vSmOx4tUyyIj9j62Wg=;
        b=GFfzoaeGz3DQ9OOkUy56DP4rec/IQ/26hbb/jzCPVq+PwHGEC7f9fLqjhKJXCN++q0
         D3BN54KpFHxXWe5cYr3WhUIbZlbQFMEpOwbcIx4BYWiBvgrfKhcQFiVktsCLkuRU7zep
         F30qr8rGTgn1wQVaLvrd+tZ0uXAbBulDxrkK5ttClt4cqJN/IqYK6z3BiHfAU87wSU4a
         NAaf7G4HTt4Iqm4aMVF7yXSI9pfajYsbQZd9HTvLJQ76XsOFMVoOTx95l3vxxrh4Vq1Y
         MLWflG+xlMoY0HVtFAICFJ5MIhKSKW/BTnVYHzghptytGlOhJ68JP2ZyJ1jKbqeMoS8A
         5FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699646605; x=1700251405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uiR+2pf8KgWC6QuYOupk0/cL7vSmOx4tUyyIj9j62Wg=;
        b=N0pLfvs61d2QItvakXmFKw7ovFvqzuneF+yJuO5/C7E60VASY4rPTdtMyTbNwCwWxb
         Z/4YSZy2aX+RpjG+fw8thlKQwt55ttiM5opV9W/HCwTPkBEEXZimAHgGYEza/0KHEt0Y
         v2gTdeXUlZYhhOe5tPKWPupFo+pDyENVNcGfiPYTswL3bKx1qjVOtfk7ObQ+LrhTsFfR
         GIRAnStcdMM4Jnt0+8qlQXgQlEUkwNLfqIA28kiCZ/lxHI6og3FCeVGHJ/0U5lQ34fju
         KveRZWLMnJiH95ybvxrnzBhiydk5hHm1czpogmcnYcL2sgZn3QDXHhEBZwfsZ98SnOEN
         Qw4g==
X-Gm-Message-State: AOJu0YxfzmEQLXsFEhi65lirTCFfwCJheN8Dqp/5baNNU/ZZSkkK5Hmr
        Buzj+zuXM0vgXVmNa6VghAFnPuoFxnWADkpkRgI=
X-Google-Smtp-Source: AGHT+IHYWgi4f4kuFsPegsAIEOsxXntmACu1bHl8Hzxikj7n/qk+O58u6TQSaTdp0RZ4Q9DadRg1z4sF8NS1LmbbxK4=
X-Received: by 2002:a05:6359:278e:b0:16b:c3ef:6045 with SMTP id
 ly14-20020a056359278e00b0016bc3ef6045mr114170rwb.0.1699646604569; Fri, 10 Nov
 2023 12:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-12-lb@semihalf.com>
 <CAJfuBxzhz7pBYkfqfPomH4PUzqLPX1nxsev4yrQ2P6m5hyMT+Q@mail.gmail.com> <CAK8ByeJ1fYSVaVQz3tERzj_5QNAN4Ggx850pKcAG3vhsoWnS+w@mail.gmail.com>
In-Reply-To: <CAK8ByeJ1fYSVaVQz3tERzj_5QNAN4Ggx850pKcAG3vhsoWnS+w@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Nov 2023 13:02:58 -0700
Message-ID: <CAJfuBxyu3VqakFNr4mW0h4QiPVSf-7HSPXobGO2_qC-H8yLgcw@mail.gmail.com>
Subject: Re: [PATCH v1 11/12] dyndbg: write debug logs to trace instance
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

On Fri, Nov 10, 2023 at 7:53=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> sob., 4 lis 2023 o 22:49 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihal=
f.com> wrote:
> > >
> > > When trace is enabled (T flag is set) and trace_dst field is set
> > > to value greater than 0 (0 is reserved for trace events) then
> > > debug logs will be written to trace instance pointed by trace_dst
> > > value, for example when trace_dst value is 2 then debug logs will
> > > be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.
> > > Given trace instance will not be initialized until debug logs are
> > > requested to be written to it and afer init will persist until
> > > reboot.
> > >
> >
> > restating 00 comments -
> >
> > you can get rid of integer destination ids by adding a new command: ope=
n/close
> >
> > $> echo  \
> >  open kms-instance \;\
> >  class DRM_UT_KMS -T:kms-instance  # preset-dests-disable-sites \;\
> > > /proc/dynamic_debug/control
> >
>
> Instead of using above command to preset destination we could preset
> destination with open command. I mean last successful
> open would preset destination ? What do you think ?
>

I dont think it works - if open maps to a dest-number, (or implicit as
TOP-of-stack)
then you just have +T<dest-number>  (or +T <implicit tos>)
rather than +T:dest-name
and you still have to keep track of what dest-numbers were already used.
(or every new dest needs an explicit OPEN before it)

and how do you then get back to default instance ?
open 0 ?
close <previous-handle> ?


by using names, all opens can be at the top,
(and thus document in 1 block all the named-instances)
and any named dest that hasnt been opened is an error
(not just reusing previous OPEN)


> >
> > and +T  w/o dest means use existing setting, not just 0 (unless thats
> > the existing setting)
> >
>
> Sounds good.
>

:-)
