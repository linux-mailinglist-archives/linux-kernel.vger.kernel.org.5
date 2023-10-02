Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9587B4FE4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbjJBKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjJBKH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:07:57 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A441A7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:07:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-536071e79deso6452704a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1696241272; x=1696846072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rBE/X1fNgWjaIN6Sj4tH8MKiYOoxqBKfQq2X0KIQro=;
        b=q5JoH4qUw8mGRm/pSG7Y9PunD/u9IhQKtaCdK1eNAiyx6WZM1x/ZuDETKhJ+ax2i3j
         5BLrfFCZjEl39g+fq8Ezyw7527I4Hk/WrUZTiN20FFnJ7rynHli7MUu6/Uy0MqGUWiUQ
         ylsNnemkGzijC468OiyvKbMGUfwMd/EtZQs0gcoHXprFMdMmSaYu1ItM2HS0NlbklgpB
         /ybBp4yje1iXHgkcwTtyDt+pf7s3mXO3M3Vpx6jNQpb00xORmfba9k4fnN8smHUEJfzc
         +QrjQ6B7GBGORMc7hb2KPt+CK3mMTEP/KCx2RLjLUGwoqP7F4pgr/eFXbGHpSvBcE4qv
         fuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696241272; x=1696846072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rBE/X1fNgWjaIN6Sj4tH8MKiYOoxqBKfQq2X0KIQro=;
        b=w58oy+GFST+LLi/qeB70QbuUeIdfOVVblKofZKky+b1dnTzHkdObm2gLHQlpsMXtD7
         Z+QKBIqWzzdOmq7VFrMnVSoO03L2Pr1z+d/FbD7+5KzaKE6Tr/zRzU7hY9P+3oPu0D2a
         6aQScKbGkU0Mhe0nyZQTSKTVC9fRLdoEqQlIzzr7/+xSZ41UoWX4R4ikEftUEmGecQMK
         fNMb7RusxgWCtDnZaavAfjPAqqQ/TFnWE+kHyA/qNsOYn9JLQYzidZTnhqvI7YdNigCe
         8mBA8WFEl+qjo6xq+4nVy7uAyjiPGvqKwWsYbFxu3LYv/Ow+zp8kbua7xQ04yN0p3B2I
         0R3Q==
X-Gm-Message-State: AOJu0YxnVby8gIDxGc0GUFQRvOwabprqAry9w185+n8RDJefVbg12LwW
        9d3N92UW/lGmiAQloTfluZat6Zy/iZff6hjbzHvg
X-Google-Smtp-Source: AGHT+IEKemgDMX9Ug3m7ub/wYKKnKKvvTVmykNgKS3dAJCty/BCOeniwA5+4pQDc8Ae8oYaWWG091ytWdIuWem/eZWg=
X-Received: by 2002:aa7:c301:0:b0:533:dd4d:2941 with SMTP id
 l1-20020aa7c301000000b00533dd4d2941mr11154175edq.16.1696241272626; Mon, 02
 Oct 2023 03:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230915154856.1896062-1-lb@semihalf.com> <CAJfuBxyFYyGCtr5i=P7N=1oX3J=jmdp1VLGLt+z1fAnuvGK2aA@mail.gmail.com>
 <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
In-Reply-To: <CAK8ByeJBrPEQSgUc91LQO9Krzjh2pauhMTjEC82M8ozayE76Yg@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Mon, 2 Oct 2023 12:07:41 +0200
Message-ID: <CAK8Bye+fco5o3U1Sj+4WtpC5qy1gqUQUsTS1+BcjZe2ppFPCLg@mail.gmail.com>
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

pon., 18 wrz 2023 o 09:20 =C5=81ukasz Bartosik <lb@semihalf.com> napisa=C5=
=82(a):
>
> pt., 15 wrz 2023 o 20:02 <jim.cromie@gmail.com> napisa=C5=82(a):
> >
> > On Fri, Sep 15, 2023 at 9:49=E2=80=AFAM =C5=81ukasz Bartosik <lb@semiha=
lf.com> wrote:
> > >
> > > Add support for selection of dynamic debug logs destination.
> > > When enabled it allows to configure destination of each callsite
> > > individually. The option adds a framework (described by struct
> > > ddebug_dst_ops) which provides flexible means to add a new destinatio=
n
> > > for debug logs. On top of the framework support for trace instance as
> > > destination is added. By default destination of debug logs is syslog.
> > > Syslog can be set explicitly by using dst keyword or is selected by
> > > default when dst keyword is omitted, for example:
> >
> > A while back,
> > Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>
> > proposed these patches:
> >       https://lore.kernel.org/lkml/20200825153338.17061-1-vincent.whitc=
hurch@axis.com/
> >
> > his approach adds a single flag, +x or (my pref) +T
> > which sends the pr_debug to tracefs, independent of +p.
> > Steve Rostedt offered feedback on one of the versions,
> > and one could read that as provisional acceptance.
> >
> > Ive worked his patchset since, it is here:
> > https://github.com/jimc/linux/tree/dd-trc-11
> > (it has some unrelated bits too)
> >
> > but it sits atop another patchset:
> > https://lore.kernel.org/lkml/20230911230838.14461-1-jim.cromie@gmail.co=
m/
> > or for git remote add
> > https://github.com/jimc/linux/tree/dd-fix-5i
> >
>
> I looked through the patches you pointed me to. The solution with
> +T/+x is elegant and tailored to specific needs.
> Our rationale to write pr_debug/dev_dbg logs to tracefs is similar to
> Vincent's to aid us in debugging.
> Unfortunately the solution with +T/+x does not cover our use case.
>
> Our use case is different. We experience issues reported by Chromebook
> users which are difficult to reproduce
> that's why we would like to enable debug logs to be written to tracefs
> on productions systems.
> When users experiences an issues and sends us a feedback report the
> debug logs written to tracefs would be
> attached to the feedback report. We would like to write debug logs to
> a separate trace instances based on
> the subsystem/driver. Our initial areas of interest/issues are usbcore
> and thunderbolt drivers/subsystems.
> More may come in the future.
>
> With my proposal this could be achieved for the thunderbolt subsystem
> with the following steps:
> * enable kernel configuration option CONFIG_DYNAMIC_DEBUG_CORE,
> * enable kernel configuration option DYNAMIC_DEBUG_DST and set its
>   operation mode to Static.
> * add the option to the thunderbolt's drivers/thunderbolt/Makefile
> in order to compile in debug logs:
>         CFLAGS_nhi.o :=3D -DDYNAMIC_DEBUG_MODULE
> * compile the kernel and update it on a target device,
> * finally append the entry to the kernel boot command line:
>         thunderbolt.dyndbg=3D"dst trace:thunderbolt =3Dp"
>
> Both the solutions (I mean +x/+T and mine proposal) have pros and cons.
> Maybe both could coexist together, +x/+T by default and this patch as
> configurable option
> which adds more flexibility ?
>

Jim,

Do you have thoughts/comments about/to my proposal ?

Thanks,
Lukasz


> >
> > syslog and/or tracefs seems sufficient, do you have a 3rd destination ?
> >
>
> I don't have a use case for the third destination, but for example
> adding socket destination to my proposal would be relatively fast and
> easy (that would be for limited use only after a network is up and
> running).
>
> Thanks,
> Lukasz
>
> > thanks
