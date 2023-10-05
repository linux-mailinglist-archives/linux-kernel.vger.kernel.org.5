Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDCD7BA878
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjJERwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjJERwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:52:46 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB195585
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:14:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so2050255a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 10:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1696526076; x=1697130876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3jOJ9y4m0qNvfGlNMEwsIKM+Ht48cxLl39lUm8RL8s=;
        b=QaNSoEp2rACavVX9r/B2SzhumdWsNADP8WTOrOg5CZk7OYw2RrLagzPqBcRD4eHwNu
         PxPO/R0I3AGFcsq7IIhMTEzmcL0K8/GMtc/gtr0g5XGa8djxCD8e75LSQTdUorg7p4Y2
         yjpb9x496FdWlByeguJZP3mLbnAZFcQv3o+1D8G42/vMipfEfMi4WFyaeyd5dSKPMgDN
         /6NSqOZZO5pp3fVwFidwbHpGYuc6eVUjv7e0aUaOhaUsJUBfiDTihD1PSXBWEoRkx8+b
         bXUJRl1Ro092Cq5dWm7PBhIpwZBTWtzaR+P84n+h+EuiIkKIhCYkgP+LltdtAtwmLFnR
         Qv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526076; x=1697130876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3jOJ9y4m0qNvfGlNMEwsIKM+Ht48cxLl39lUm8RL8s=;
        b=VcPXu/U20cZ1Lse66kc870+ivQxGJrc8PXS6T+aY01QMvIgnO+fOrRF8QuZpHkqUtp
         W0Q1fapLEorknKT3DRdc0JBczkYPVkYKIaEaVEOH/CwFa9m1FDJ8eUR1cF/1cwb9yD7P
         pMM4X9bCTEX9d+9AmWMz8uUpoa9e/YZnvFTomlxBjf4SkGy9QM+F77okqCWMEQrzVIwv
         SpFEzhCUXQEjuuSnb3CjLyjB9PIlXcrAJfq4e+UOvehZQx364/Eg8JL3BIrLMriPzqof
         FUdvr2ORIAl7L4b/iuDZKqwjVVoUl9IsklT1kkLoCWtUY+7swaz5WpI9ylUv9Vd0L60H
         2gdg==
X-Gm-Message-State: AOJu0Yxm3LjIwWX4k+7tHluR954A5cs6WGijKdc6CtB1aS9Vez0rQRTg
        xQqya1eFWltGmv5wb5BE/UxbNrVs64L24vMszV6/
X-Google-Smtp-Source: AGHT+IEBE+8FnUNXghQ8T604xAr48cXK+thAS03ZFKqTukQoCtv5xOF22IcYWMBbXkvPTSZam56COONlQgZuEoOqcv0=
X-Received: by 2002:aa7:dc0f:0:b0:52c:b469:bafd with SMTP id
 b15-20020aa7dc0f000000b0052cb469bafdmr5143303edu.41.1696526076018; Thu, 05
 Oct 2023 10:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
 <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
 <CAJfuBxxmL-GtBgt=033F9UNeLCreFbJh3HrQQN2nYKwR_0uTbg@mail.gmail.com>
 <20231003155810.6df9de16@gandalf.local.home> <CAJfuBxyJyFbFEhRxrtxJ_RazaTODV6Gg64b1aiNEzt6_iE4=Og@mail.gmail.com>
 <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
In-Reply-To: <CAK8ByeLNc9UbTNG4x=40AxYqjjRCsvBNtNFai0PMveM2X4XCow@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Thu, 5 Oct 2023 19:14:24 +0200
Message-ID: <CAK8ByeKKYFP6yZsy3-7iU2O5sC5gEPkNeYn-=XN3sBDZEBNPmA@mail.gmail.com>
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

Jim,

Just one more thought. If you review my patch then we could move into
discussing the details.

Thanks,
Lukasz

=C5=9Br., 4 pa=C5=BA 2023 o 12:55 =C5=81ukasz Bartosik <lb@semihalf.com> na=
pisa=C5=82(a):
>
> wt., 3 pa=C5=BA 2023 o 22:54 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Tue, Oct 3, 2023 at 1:57=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Mon, 2 Oct 2023 14:49:20 -0600
> > > jim.cromie@gmail.com wrote:
> > >
> > > > hi Lukasz,
> > > >
> > > > sorry my kernel-time has been in my own trees.
> > > >
> > > > What I dont understand is why +T is insufficient.
> > > >
>
> We would like to be able to separate debug logs from different
> subsystem (e.g. thunderbolt and usbcore).
> With +T it is not possible because all debug logs will land in the same b=
ucket.
>
> > > > IIUC, tracefs is intended for production use.
> > > > thats why each event can be enabled / disabled
> > > > - to select and minimize whats traced, and not impact the system
> > > >
> > > > and +T  can forward all pr_debugs to trace,
> > > > (by 1-few trace events defined similarly to others)
> > > > or very few, giving yet another selection mechanism
> > > > to choose or eliminate specific pr-debugs and reduce traffic to
> > > > interesting stuff.
> > > >
> > > > Once your debug is in the trace-buf,
> > > > shouldnt user-space be deciding what to do with it ?
> > > > a smart daemon could leverage tracefs to good effect.
> > > >
>
> Yes, a daemon could separate the debug logs but IMHO it is much
> easier to separate logs by sending them directly from a given subsystem
> to a separate trace instance. My proposal allows to configure different
> trace instance as destination for each callsite.
>
> > > > IMO the main value of +T is that it allows feeding existing pr_debu=
gs
> > > > into the place where other trace-data is already integrated and man=
aged.
> > > >
> > > > At this point, I dont see any extra destination handling as prudent=
.
> > > >
> > >
> > >
> > > I'm fine with either approach. I kind of like the creation of the ins=
tance,
> > > as that allows the user to keep this debug separate from other tracin=
g
> > > going on. We are starting to have multiple applications using the tra=
cing
> > > buffer (although most are using instances, which is why I'm trying to=
 make
> > > them lighter weight with the eventfs code).
> > >
> > > -- Steve
> > >
>
> Steve, thanks for commenting from the trace perspective.
>
> >
> >
> > Ok Im starting to grasp that multiple instances are good
> > (and wondering how I didnt notice)
> >
> > What doesnt thrill me is the new _ddebug field, it enlarges the footpri=
nt.
> >
>
> Yes it increases _ddebug structure by a pointer size.
>
> > can you make it go away ?
>
> I implemented my proposal with flexibility in mind so that if someone
> would like to add
> another destination in the future it should be easy to do. I
> understand that adding a pointer
> to the _ddebug structure increases footprint size that's why I also
> added CONFIG_DYNAMIC_DEBUG_DST
> kernel configuration option in order to enable/disable this functionality=
.
>
> > I have some thoughts ..
>
> Please share your thoughts. I'm sure we can come to an agreement how
> to incorporate both +T and my proposal.
>
> Thanks,
> Lukasz
