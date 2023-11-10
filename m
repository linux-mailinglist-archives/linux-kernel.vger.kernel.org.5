Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DDC7E8332
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346513AbjKJTxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346197AbjKJTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:53:35 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167E04788
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:37:32 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7b9dc928868so773926241.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699645051; x=1700249851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eSVdBnjUb+pSPmWrdmco4IiQtG0PIRfKrJ8USCOf2s=;
        b=MohLN2/J7VS0HGAdH1+vvUFCudq9Awy5c+SXpjSvltQ2RwdTSsS4rf88CtNcSzHwYP
         GPKXH9JJ6sTitmnuaH92tpTvpKsfl4s5MOP8Jr++lp+X5yFFg6LC9ZvWbJtdD8lej7UV
         lW+5NIwU8coiDBE3WIETrYuRkjgR0/Q4xQQEjzH2PPC7D2fBy0+6PzIHCmFjuCka6jNw
         wSVkUOxCsiZveUJnO9b0JuU0gABsimzL8n4q2InSvbsMDc8udqozkQL3dsSbedKbY+oJ
         uvpOfus5BgbaXoSvg/y1Oi+4VEZ1RQvW6WtvR/FpBkz7Ec95HR0+YpndE6uF7nw3VGnh
         2qfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699645051; x=1700249851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eSVdBnjUb+pSPmWrdmco4IiQtG0PIRfKrJ8USCOf2s=;
        b=mdXSNLRKSXxSS7NA6kixU/ac1UxQFj268ongkLdO4P0reM4yF+ccYvex0S7wmpoW/1
         nyHqLzjfffjtBdJjhMRdXXLk+a5kit8jJea+YxluxzqqsepDdmC9Oagib8954EIW0I+P
         gOL8dOJMu2b0lOLuis1SU+Zldueit52mB4nK9zGczAd1oX6gCgJBdpJNjoHAKJ279U7L
         ZgQQUCq3P8DfHgGQanJhYev2t0f7gfarW4RwutpIkQR4PMEE4rNJBYBbs1sZh7tcLqg6
         r82qoDfUQQTQ5MwDiQEEsGlGSTQlVLEdy9PWwzeVE+xyiROzmR9VDMTdoRnA097e2sZZ
         Tq6w==
X-Gm-Message-State: AOJu0Yw0AmQbi5+cCtH9ukF1xEoCnxnjCqPX6sEVMdzj5XmDI5tP04r2
        kQMymfQFxIEF044O7Bs8geRuX9AxGxGHNWVquS4=
X-Google-Smtp-Source: AGHT+IGzwKjvYl27zUuiz8pOY1Le6DRxMktZnC7h4EOLzYGECKufCnPz/W1dwjrTHKR8aM5olTkcdW3mmhu2+HRZ+ug=
X-Received: by 2002:a67:c392:0:b0:45f:1bed:cec9 with SMTP id
 s18-20020a67c392000000b0045f1bedcec9mr304486vsj.34.1699645051200; Fri, 10 Nov
 2023 11:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-10-lb@semihalf.com>
 <CAJfuBxyvX41CCb27LWMDxZrQ5wwhuw36F_VmXyB3F9q7r1Kt2A@mail.gmail.com> <CAK8ByeKCcmd7-8Lsv5jQB-Po5UYeFRD-jB0e08BNBNUJ01UhNA@mail.gmail.com>
In-Reply-To: <CAK8ByeKCcmd7-8Lsv5jQB-Po5UYeFRD-jB0e08BNBNUJ01UhNA@mail.gmail.com>
From:   jim.cromie@gmail.com
Date:   Fri, 10 Nov 2023 12:37:04 -0700
Message-ID: <CAJfuBxxAnonb-+UrkVs=MiJ-g-5JDzzEn=GKs2gQvdqH8dGDVw@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] dyndbg: add trace destination field to _ddebug
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

On Fri, Nov 10, 2023 at 7:52=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.c=
om> wrote:
>
> sob., 4 lis 2023 o 02:39 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihal=
f.com> wrote:
> > >
> > > Add trace destination field (trace_dst) to the _ddebug structure.
> > > The trace destination field is used to determine output of debug
> > > logs when +T is set. Setting trace_dst value to 0 (default) enables
> > > output to prdbg and devdbg trace events. Setting trace_dst value to
> > > a value in range of [1..255] enables output to trace instance.
> >
> >
> > should we do some expectation setting here ?
> > 255 is something of a promise to more than tom,dick,harry.
> > 16-64 is more suggestive of a limited resource,
> > might encourage more judicious use.
> >
>
> How about making it configurable in kernel Kconfig with default value
> set to 16 or 32 ?
>

given the general dislike of extra knobs, it's not the battle I would choos=
e.
ISTM we could start small, add bits later (if needed)
maybe 16 is too parsimonious; esp if DRM wants multiple instances per
driver (device?)



> > will look further later
