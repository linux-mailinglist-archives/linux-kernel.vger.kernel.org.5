Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8F7A422F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240148AbjIRHVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbjIRHU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:20:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517BAAA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:20:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so5164951a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1695021651; x=1695626451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYOkhYBxWVZ+LY5smS6U7evu3bZ7CccBMIczeYjBfLA=;
        b=EjH0N1PgDc1FiETrj44BmUN61ivYqXUiDnhqDbpEAMVe8o8gdRVuLw2TkqOcKPFexF
         rXraWdcRGc1Kulpxb5DDhSEWt0nV3fYmPk/bhP0aakzvTDpPr5EPCdk8M1m3JAGhw6F6
         ZEEX3aAR8GJ5xsPBOMuuhvgjjTMlyfH1WP0HnejsPXE8NHBhLpM1OtQ/MbWpciLQxIL4
         eK5Ahq0URI5oNmibmXlBKCYPItOWafJEhznDQWmGwb4w3f+CQGBeLa+Ms8CdPkqjm7m/
         gdSMVXKSGW9yMDHgNrayRCZtzGKUwSyGwwsEw2aRAdxHNX+93dfcooWNBRLUtGZcfejt
         T70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695021651; x=1695626451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYOkhYBxWVZ+LY5smS6U7evu3bZ7CccBMIczeYjBfLA=;
        b=GAD4P6+no4YDoEIs8O9L1jWpJsAGCnC/d5480O231cLcaFLah5uA79lHZENdf0Ev+u
         0yUtoQyWRmdLqu2+h2PtQlbQorbqWbh5E7EMVrSneJaU/S1HLwTTL8nlPZyC7V4s7ywq
         KOpsxB8NIp+uvzUXAM51KGZ/UaoPjHO4geouHjFBGypmSUz6ajkL7hKdDJtSOiK5uHWq
         ZD0LFoe5di6LhoNOFK93UdWl8Sj8voHL1pMUr37jwwZTylXOPy3QYutNQ0g6h1exPMCP
         DJ2ZFESjMWnsatsq+OrbnovqxaqCNLxm9vnqasRt4xC1h7xwiUakPxk5pbNOgbTf6ZT3
         HIyw==
X-Gm-Message-State: AOJu0YwY89c2x/memAs5Gb4ySK+wLM7GRYzHFp0mKyNM/nmCs79lazzy
        2Ks3NNiLGF1YHY4tRDDek6QBp5DBqe6Wcz7Apt88
X-Google-Smtp-Source: AGHT+IE2qZX9hrcJguj5TWLTk0ux10KdiBAX0b0v9aOSD/rDoawdpadpLuo9iBF2UegzyBC5qHD/mkgoMQdubQQUaso=
X-Received: by 2002:aa7:ccc8:0:b0:525:7091:124c with SMTP id
 y8-20020aa7ccc8000000b005257091124cmr7000653edt.19.1695021650705; Mon, 18 Sep
 2023 00:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
In-Reply-To: <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Mon, 18 Sep 2023 09:20:39 +0200
Message-ID: <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
Subject: Re: [PATCH v1] dynamic_debug: add support for logs destination
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 15 wrz 2023 o 20:02 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> On Fri, Sep 15, 2023 at 9:49=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf=
.com> wrote:
> >
> > Add support for selection of dynamic debug logs destination.
> > When enabled it allows to configure destination of each callsite
> > individually. The option adds a framework (described by struct
> > ddebug_dst_ops) which provides flexible means to add a new destination
> > for debug logs. On top of the framework support for trace instance as
> > destination is added. By default destination of debug logs is syslog.
> > Syslog can be set explicitly by using dst keyword or is selected by
> > default when dst keyword is omitted, for example:
>
> A while back,
> Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> proposed these patches:
>       https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitchu=
rch@axis.com/
>
> his approach adds a single flag, +x or (my pref) +T
> which sends the pr_debug to tracefs, independent of +p.
> Steve Rostedt offered feedback on one of the versions,
> and one could read that as provisional acceptance.
>
> Ive worked his patchset since, it is here:
> https://github.com/jimc/linux/tree/dd-trc-11
> (it has some unrelated bits too)
>
> but it sits atop another patchset:
> https://lore.kernel.org/lkml/20230911230838.14461-1-jim.cromie@gmail.com/
> or for git remote add
> https://github.com/jimc/linux/tree/dd-fix-5i
>

I looked through the patches you pointed me to. The solution with
+T/+x is elegant and tailored to specific needs.
Our rationale to write pr_debug/dev_dbg logs to tracefs is similar to
Vincent's to aid us in debugging.
Unfortunately the solution with +T/+x does not cover our use case.

Our use case is different. We experience issues reported by Chromebook
users which are difficult to reproduce
that's why we would like to enable debug logs to be written to tracefs
on productions systems.
When users experiences an issues and sends us a feedback report the
debug logs written to tracefs would be
attached to the feedback report. We would like to write debug logs to
a separate trace instances based on
the subsystem/driver. Our initial areas of interest/issues are usbcore
and thunderbolt drivers/subsystems.
More may come in the future.

With my proposal this could be achieved for the thunderbolt subsystem
with the following steps:
* enable kernel configuration option CONFIG_DYNAMIC_DEBUG_CORE,
* enable kernel configuration option DYNAMIC_DEBUG_DST and set its
  operation mode to Static.
* add the option to the thunderbolt's drivers/thunderbolt/Makefile
in order to compile in debug logs:
        CFLAGS_nhi.o :=3D -DDYNAMIC_DEBUG_MODULE
* compile the kernel and update it on a target device,
* finally append the entry to the kernel boot command line:
        thunderbolt.dyndbg=3D"dst trace:thunderbolt =3Dp"

Both the solutions (I mean +x/+T and mine proposal) have pros and cons.
Maybe both could coexist together, +x/+T by default and this patch as
configurable option
which adds more flexibility ?

>
> syslog and/or tracefs seems sufficient, do you have a 3rd destination ?
>

I don't have a use case for the third destination, but for example
adding socket destination to my proposal would be relatively fast and
easy (that would be for limited use only after a network is up and
running).

Thanks,
Lukasz

> thanks
