Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C547B7D93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 12:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjJDKzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjJDKzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 06:55:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81D9A6
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 03:55:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso3531292a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 03:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1696416913; x=1697021713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2VXnYJg94PLYA3o5E07f9bhB1wUV4CKoPvKaIfev68=;
        b=GY7oC6tpbUFJOdfavcXig+E8uZZHjKwd0MQGbzfMTsN4nNtkqKSWx/XP3DWgrOHSAl
         TMmHxDrCfXk1Z4eX5Gd8AkERRzoLDO0in/1ISByP7em8qFPsyeuad4FXzPn5nYBuE3Y5
         ZB/C8EZevpIM3lL7ZZKhHGKdPYAryaA+W/kUV6fsGFzVpm/jIpsQ57WqUoGr4UbXPsmb
         LIgvv0QSuPe7hwC5mfbz9snbC+19TjoxHPXVAcXniTMUChA7NJTVqPbe9C3LEVvi+OXu
         1bKyel/0qyb/WcDzXbVcYM+YDIv7ifClcJLcOU0N3peEhERN3q7W0TdBluPAqJXD7vAZ
         ZVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696416913; x=1697021713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2VXnYJg94PLYA3o5E07f9bhB1wUV4CKoPvKaIfev68=;
        b=aGoIBImpE14AjV/9+CYTfVr9OuzEkLyoJAUnW27vno82RdxjfftCpdsOWhAB6wCyE7
         t/SqpcyY2RT775/0ejK/ftaF5oMJEvQ97tyQShCkX4Hjvry8reHEduMTS97b5ebIYg5K
         C7LteY07MWdsT1dGbbSaJs8gabvsGQQf5QnawRQ6KSF2ooXEnPpI/vxsdV5CLeB0UCSS
         TWiQXgUxyxYc5ib+sSZIkTy4H8CaabbEGOPFYQFN+VVWj8HtO1gdHzCc/izKcAu21PDX
         cMoG9Vm9fbXQUCvGsIP600eTG8x80G2hNgCNC/xZ44r6bLrrt5M96Hk1Pbw0TRBQ+KU4
         Hk9Q==
X-Gm-Message-State: AOJu0YwnGkanzdOGk2GlUtxpT1CAlJOKn2T25AxGrxEKK/HkikjzMbyA
        Z0NHUUbqHUJ7Rr8raeXpzvo+bNy08PbTdPoA4JOM
X-Google-Smtp-Source: AGHT+IGNcJxvBSYK1LygnepuAKeRGJ/0cm0JFbFY/8bUlp026J70lx7B8yJdfksuozxGMuEFX6TVOyulBh6RqPkte+o=
X-Received: by 2002:aa7:c74c:0:b0:522:1d1d:1de8 with SMTP id
 c12-20020aa7c74c000000b005221d1d1de8mr1516760eds.2.1696416913180; Wed, 04 Oct
 2023 03:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
 <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home> <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
In-Reply-To: <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Wed, 4 Oct 2023 12:55:01 +0200
Message-ID: <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     jim.cromie@gmail.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 3 pa=C5=BA 2023 o 22:54 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Tue, Oct 3, 2023 at 1:57=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Mon, 2 Oct 2023 14:49:20 -0600
> > jim.cromie@gmail.com wrote:
> >
> > > hi Lukasz,
> > >
> > > sorry my kernel-time has been in my own trees.
> > >
> > > What I dont understand is why +T is insufficient.
> > >

We would like to be able to separate debug logs from different
subsystem (e.g. thunderbolt and usbcore).
With +T it is not possible because all debug logs will land in the same buc=
ket.

> > > IIUC, tracefs is intended for production use.
> > > thats why each event can be enabled / disabled
> > > - to select and minimize whats traced, and not impact the system
> > >
> > > and +T  can forward all pr_debugs to trace,
> > > (by 1-few trace events defined similarly to others)
> > > or very few, giving yet another selection mechanism
> > > to choose or eliminate specific pr-debugs and reduce traffic to
> > > interesting stuff.
> > >
> > > Once your debug is in the trace-buf,
> > > shouldnt user-space be deciding what to do with it ?
> > > a smart daemon could leverage tracefs to good effect.
> > >

Yes, a daemon could separate the debug logs but IMHO it is much
easier to separate logs by sending them directly from a given subsystem
to a separate trace instance. My proposal allows to configure different
trace instance as destination for each callsite.

> > > IMO the main value of +T is that it allows feeding existing pr_debugs
> > > into the place where other trace-data is already integrated and manag=
ed.
> > >
> > > At this point, I dont see any extra destination handling as prudent.
> > >
> >
> >
> > I'm fine with either approach. I kind of like the creation of the insta=
nce,
> > as that allows the user to keep this debug separate from other tracing
> > going on. We are starting to have multiple applications using the traci=
ng
> > buffer (although most are using instances, which is why I'm trying to m=
ake
> > them lighter weight with the eventfs code).
> >
> > -- Steve
> >

Steve, thanks for commenting from the trace perspective.

>
>
> Ok Im starting to grasp that multiple instances are good
> (and wondering how I didnt notice)
>
> What doesnt thrill me is the new _ddebug field, it enlarges the footprint=
.
>

Yes it increases _ddebug structure by a pointer size.

> can you make it go away ?

I implemented my proposal with flexibility in mind so that if someone
would like to add
another destination in the future it should be easy to do. I
understand that adding a pointer
to the _ddebug structure increases footprint size that's why I also
added CONFIG_DYNAMIC_DEBUG_DST
kernel configuration option in order to enable/disable this functionality.

> I have some thoughts ..

Please share your thoughts. I'm sure we can come to an agreement how
to incorporate both +T and my proposal.

Thanks,
Lukasz
