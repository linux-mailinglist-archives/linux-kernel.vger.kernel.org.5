Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C8C7E91A7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjKLQ34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjKLQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:29:55 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5632737
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:29:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso5462945a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699806588; x=1700411388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm62BhUFg7/jJw+CbLyqySO8C8fljS493Q+iH7bdCTU=;
        b=DpLChgyjmnkIGapK5bD1WOcdkYNf1hx01OOpnX/uG+pjKWEWGHGoIUnFo0JNIEbhV2
         ToBBNX/FLgccLtDuRIhT9c3U5MsV/XmJS+60nrzWoiVsWjq8d5rAe5iL6t5Ypcpbh6Ee
         23obIs0KXXcnkU7xsnAVQ1INWomI4n4WkcE1ip1UjQ10NLIetslr9N/b8uderKQQdJae
         lfAEb7XVHRMZexNFc/S9i6Fg74/IbPK4CmOz4b+7yvcjHK8ZVvIaJHOFfruejydH0tDU
         wYwwAQeA0BoN+18h5Y6pRfISVr5K8nryS4a5wpJesvFDaS+63NIqY3EtihN0NNT1wrwA
         pyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699806588; x=1700411388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gm62BhUFg7/jJw+CbLyqySO8C8fljS493Q+iH7bdCTU=;
        b=BDMZaWDDpRdkDqxebEuTDRqSZ/gi9eIk8vvEX/tefTlNkBPtzwxaRcASU3av0ZRftg
         DgNxs4cMFJo1hPMoRunS2UPyh4oyxVeunC1Strpspjvbnt3nJtQdjhlgTGMZyLTSbaht
         fS7Db/lMlaYxpmnaQM/CnM0TpByLa0nNW2A8n7bVUkB2IGxxkbZTQe9yo4awIVw2aqtn
         xxZtLNtVQ8qLWj4EKyv21S4863XZoY2oCPRCG4xeGvrm9/rnmZZM989gic09AipjysuX
         yDgV8rB+/4R/BCX2zqilFvsYLHIxm1v1JkLvEjlyo345Zh14Q5oDjqRUv/nRVHTswRtI
         O5xQ==
X-Gm-Message-State: AOJu0Yypjt1ELnuQQ1kpcL9zmGO4WRf841iDt8r7UCSZaEQ6vhmiirur
        Eiy1WjOjBcKpE+VbYXlRmrVNyATgIBzfXQfnSXi+
X-Google-Smtp-Source: AGHT+IHJHFjdIChBCm03i4ru6pvx//kJm+fSJpBCtv1zofkuecKvh7zzSbn4i2iOlFvsVIim7F97wu9NZR5iArC+eTY=
X-Received: by 2002:a50:ff0a:0:b0:53f:b9d2:d019 with SMTP id
 a10-20020a50ff0a000000b0053fb9d2d019mr3312401edu.11.1699806587918; Sun, 12
 Nov 2023 08:29:47 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-11-lb@semihalf.com>
 <CAJfuBxxVGaqG4wVu-kM3ynA8ARTD6DFPBuz0a1GqunMqdvRBgQ@mail.gmail.com>
 <CAK8ByeL9UJzNr=kAdyHZcdt6-B8c57OxUW+ccm4GmLrW26CxDg@mail.gmail.com> <CAJfuBxxTuiEun9YFtWY_99nvCwnJQ_LByJioOTxsCkMS6URQnw@mail.gmail.com>
In-Reply-To: <CAJfuBxxTuiEun9YFtWY_99nvCwnJQ_LByJioOTxsCkMS6URQnw@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Sun, 12 Nov 2023 17:29:36 +0100
Message-ID: <CAK8Bye+jVZwAta7mfd=zY2qk84MR3dRrX-6iZYhijTcO-o_uFg@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] dyndbg: add processing of T(race) flag argument
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

pt., 10 lis 2023 o 20:51 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Nov 10, 2023 at 7:52=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > sob., 4 lis 2023 o 04:06 <jim.cromie@gmail.com> napisa=C5=82(a):
> > >
> > > On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semih=
alf.com> wrote:
> > > >
> > > > Add processing of argument provided to T(race) flag.
> > > > The argument value determines destination of debug logs:
> > > >
> > > > 0 - debug logs will be written to prdbg and devdbg trace events
> > > > [1..255] - debug logs will be written to trace instance
> > > >
> > > > A user can provide trace destination by folowing T flag with
> > > > ":" and trace destination value in range [0..255], for example:
> > > >
> > > > echo "module thunderbolt =3DpT:7" > /sys/kernel/debug/dynamic_debug=
/control
> > > > echo "module thunderbolt =3DlT:7,p" > /sys/kernel/debug/dynamic_deb=
ug/control
> > > >
> > > > When T flag with argument is followed by other flags then the next =
flag has
> > > > to be preceded with ",".
> > > >
> > >
> > > the trailing , seems punctuation heavy.
> > > Could we just stipulate that any :string  (leading : trailing anythin=
g)
> > > be the last flag in the spec ?
> > > bare T flags are not constrained otherwise.
> > > seems fine as API-spec-by-error-codes.
> > >
> >
> > I followed Jason's suggestion to use "," when T flag is not the last
> > flag and destination is explicitly provided for the T flag, like in
> > the example above
> > "echo "module thunderbolt =3DlT:7,p" > /sys/kernel/debug/dynamic_debug/=
control".
> >
> > With "," we can have the following cases:
> > - when T is the last flag then it doesn't need to be followed by ","
> > even if destination is explicitly provided, for example "lpT:7",
> > - when T is not the last flag and destination is explicitly provided
> > then "," has to be used before next flag, for example "lT:7,p",
> > - when T is not the last flag and destination is not explicitly
> > provided then "," is not required, for example "lTp",
> >
> > Jim, Jason, would you please come to terms if we want to use "," or
> > just assume that T has to be the last flag in the spec ?
> >
>
> Im fine either way -   eliminating punctuation has a cost too,
> it adds some order dependency which isnt there now.
> If that complicates the code, no-good.
>

Ok, I will keep the option to use "," to separate T with explicitly
provided destination from a next flag.

>
> > >
> > >
> > >
> > > > When no value is provided trace destination defaults to 0, for exam=
ple:
>
> That seems wrong now - it should default to whatever it was previously se=
t to,
>

It was in my original proposal before you suggested to create
open/close commands.


> this allows setting a non-default dest while disabling the site:
>    echo class DRM_UT_CORE -T:core-log  > /proc/dynamic_debug/control
>
> then just enabling it later, to use the preset dest
>    echo class DRM_UT_CORE +T  > /proc/dynamic_debug/control
> or more likely:
>    echo 0x01 > /sys/module/drm/parameters/debug_trace
>
> this way, debug_trace is just like debug, but still can write to the
> separate trace-instances
>

Ack, I also clarified my suggestion related to this topic in patch 11.



> > > >
> > > > echo "module thunderbolt =3DT" > /sys/kernel/debug/dynamic_debug/co=
ntrol
> > > > echo "module thunderbolt =3DlTp" > /sys/kernel/debug/dynamic_debug/=
control
> > >
> > > no colon after T means p is a flag, not a destination name
> >
> > Yes, in this case p is a flag because when T is not followed
> > explicitly by destination then next character would be treated as
> > another flag.
