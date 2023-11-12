Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A957E91A6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjKLQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjKLQ3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:29:22 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33A010F
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:29:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo5668000a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699806558; x=1700411358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HL6UrV6Yk16zCUvNvxw8pw9JIyP1jvvUIe/aBJPp93o=;
        b=JIPyp1FibM+LzoAnxa2gzet51oyPPEV4OKgGS7aOfLYEPmihWwYWb5wEi2cLLMhLX8
         dafqcaEmnsgSlx95FHgERxamk5uFqs65fZodDu0fXCX0taxPZUt6mq7n7q0/DRXwFpeT
         2qCIR5SMDuIe2JmFK/dODAw50vJxZsggokTWqzajDsK2J1bePOdDDF2pogePTKLF8A2F
         nRIooNrjDqEAKXcwhc46ybudcot5uSr6cdtdMeyqSPiwONQJKaE6yl/DCtceD69o2JIn
         FrI500hGDUa5YRr8xyIqGeJb0avj0hWEJJAd3vza69CjfOPwIfLnUgRyOYuQvbQncfYx
         h9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699806558; x=1700411358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL6UrV6Yk16zCUvNvxw8pw9JIyP1jvvUIe/aBJPp93o=;
        b=c07/tux7q2B8HxXzle7wM+s9mh1m/2aNIp+Lk1ErpzTTGlqsNmY7HLc7MNqQCyTfJG
         PhBPGXeRdZ6ZO94IcNagJuWvHcQOzImTwyq4uAFceEdziDIdJonCCuzW/52XmnxOSKX0
         7jrBZpnDfm54cfDBDupGbu49a9hKf3o/Dlsy7tmj2I/PRn9z4sjuu3nckYGRv2nUCZE6
         tlJ/HDu6FuPfafVwdUBg4fB8qWWi6fL+eRA6D879L4gQEEZ+B0GKi21XHjN570+ag7iy
         yaeFwm2dTvdbcZ0hfTD9AZkj7at92Z6zJImWkKunuF8M7We792gOXqlZMKRybsGTpywP
         ckLQ==
X-Gm-Message-State: AOJu0YzV0b1allEcSvA5HIKuzhWHhamXxc+1Xhm8D0mNXPVSm9THkpep
        hgp1BKyri64+CzgGagpTWy0nhQs/G30RNW24Fh+I
X-Google-Smtp-Source: AGHT+IEoHDAzvLXOLBcsG3P1RG6+GC5TBfYuF5fmrYhQ3HEP+OF5LHAy3xPZcxE6qwkK16p8xGpiH6gOKc+IUqPgYTQ=
X-Received: by 2002:a05:6402:78a:b0:540:ccde:5 with SMTP id
 d10-20020a056402078a00b00540ccde0005mr3303150edy.37.1699806558476; Sun, 12
 Nov 2023 08:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-10-lb@semihalf.com>
 <CAJfuBxyvX41CCb27LWMDxZrQ5wwhuw36F_VmXyB3F9q7r1Kt2A@mail.gmail.com>
 <CAK8ByeKCcmd7-8Lsv5jQB-Po5UYeFRD-jB0e08BNBNUJ01UhNA@mail.gmail.com> <CAJfuBxxAnonb-+UrkVs=MiJ-g-5JDzzEn=GKs2gQvdqH8dGDVw@mail.gmail.com>
In-Reply-To: <CAJfuBxxAnonb-+UrkVs=MiJ-g-5JDzzEn=GKs2gQvdqH8dGDVw@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Sun, 12 Nov 2023 17:29:07 +0100
Message-ID: <CAK8Bye+n=UBy60T56TJCat2n0LNfpfAeDG56QM41PWyUGzqRHg@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] dyndbg: add trace destination field to _ddebug
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 lis 2023 o 20:37 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 10, 2023 at 7:52=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > sob., 4 lis 2023 o 02:39 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semih=
alf.com> wrote:
> > > >
> > > > Add trace destination field (trace_dst) to the _ddebug structure.
> > > > The trace destination field is used to determine output of debug
> > > > logs when +T is set. Setting trace_dst value to 0 (default) enables
> > > > output to prdbg and devdbg trace events. Setting trace_dst value to
> > > > a value in range of [1..255] enables output to trace instance.
> > >
> > >
> > > should we do some expectation setting here ?
> > > 255 is something of a promise to more than tom,dick,harry.
> > > 16-64 is more suggestive of a limited resource,
> > > might encourage more judicious use.
> > >
> >
> > How about making it configurable in kernel Kconfig with default value
> > set to 16 or 32 ?
> >
>
> given the general dislike of extra knobs, it's not the battle I would cho=
ose.
> ISTM we could start small, add bits later (if needed)
> maybe 16 is too parsimonious; esp if DRM wants multiple instances per
> driver (device?)
>

If we don't want the extra config knob then I would opt for 64.

>
>
> > > will look further later
