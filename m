Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04EB7E7FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjKJR5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjKJRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:55:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41639CDC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:49:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso3427918a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 06:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699627784; x=1700232584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuC1ebddOcbyFtgoooZ0RpCVM2XC/YrD0lA+By0aFZM=;
        b=ovJw+g3Ow4qsloxW1nhSr4b1vLnsY1NgsUMixZ5Rym+8Z32oNiExKSqyDWTPmF3yHT
         cGqh4Tl7nNY6l2aUea3tg3bGS61375hxmPnxE0s52NS9wK3P7VB1IyohadHCqD8lOs7d
         afTxhImcAjIJ07EIjebyIY1+cEzWr4yCg/ToQlA1SNM0ERyQGYPeLzXkr+2+xMqQPd5K
         cVJvieJQr/dNczMaW5veuxinoZeuKBauJwGtI7eG18VWvy1wdk0W8d8xA+RZVJEEMQgH
         0hDAoAJ/HR7by98Ym3x1gTP+Y35thbDq2IKW9oLZoG8OzQZzoJbwDBZujZwejugjwEpD
         eUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627784; x=1700232584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuC1ebddOcbyFtgoooZ0RpCVM2XC/YrD0lA+By0aFZM=;
        b=XCjdo/q7WpqJ3E4p6x8DVQmA2UmrQB50VjOs7accx7zH4YbHjnYMhjnx9+wY/XLgg/
         RkQTndM4i6Z1fc7Aj1xinTHy/sbtPg81gyXiFafzycjnz6s+8RGG8AoHB/hBJhLLZOrl
         McmdSZwzsa/nFNQ6Y14nnZnERyiLvKRyzrwQuvw7PJLoP9087dMdAKees7SVpvHLLcfh
         XsUnUTSrLeSHuZ105TLwLSQbadVpGAOLCLxZftcHKj/e3cYUpYBTjgIEgCZ4a5GTZXCz
         wy8c1hlE5c7DCPKvuu6anfjZe0ue04rCjec7rTiq7iXmRmdDse/uwBRPoNTe2eFeP96+
         cFug==
X-Gm-Message-State: AOJu0YzSCfrisgAEkXqGqG0XDmIw4nIsswj2GnIUVnYVZwzkNp8XeJ3i
        H7yfPL4QMPZtEMt3LvmWpO/jMjx7DxICPVLLYgNg
X-Google-Smtp-Source: AGHT+IFC34HniD3bfQ+SadGlhNQcbQcSgMw/Yjqcsu/lvb/M+C3lRv38bIXk8en4VNCRu7HUCjV+ToeGwiy1E0iW+AM=
X-Received: by 2002:a50:d481:0:b0:53f:b964:ddb1 with SMTP id
 s1-20020a50d481000000b0053fb964ddb1mr6210389edi.37.1699627784060; Fri, 10 Nov
 2023 06:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <CAJfuBxz8mORgH9WaGVPsu7Z1cpgqWuJLxZNgFt1ocKa1sze5sw@mail.gmail.com>
In-Reply-To: <CAJfuBxz8mORgH9WaGVPsu7Z1cpgqWuJLxZNgFt1ocKa1sze5sw@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Date:   Fri, 10 Nov 2023 15:49:32 +0100
Message-ID: <CAK8Bye+MdinpzXAd+CMBp80rsmhqbrmMTJZ6LQrUYjVDVjVZYg@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] dyndbg: add support for writing debug logs to trace
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 4 lis 2023 o 02:25 <jim.cromie@gmail.com> napisa=C5=82(a):
>
> Hi =C5=81ukasz,
>
> can I haz a git remote url ?
> no webmail antics that way.
>

Here you are https://chromium.googlesource.com/chromiumos/third_party/kerne=
l/+log/refs/sandbox/ukaszb/dyndbg_trace_v1

> On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.=
com> wrote:
> >
> > Add support for writing debug logs to trace events and trace instances.
> > The rationale behing this feature is to be able to redirect debug logs
> > (per each callsite indivdually) to trace to aid in debugging. The debug
> > logs output to trace can be enabled with T flag. Additionally trace
> > destination can be provided to the T flag after ":". The trace destinat=
ion
> > field is used to determine where debug logs will be written. Setting tr=
ace
> > destination value to 0 (default) enables output to prdbg and devdbg tra=
ce
>
> isnt +p independent of dest var ?  its just "on" to syslog.
>

Yes +p would be independent from +T so that a given callsite debug log
could be written both to syslog and trace.

> > events. Setting trace destination value to a value in range of [1..255]
> > enables output to trace instance identified by trace destination value.
> > For example when trace destination value is 2 then debug logs will
> > be written to <debugfs>/tracing/instances/dyndbg_inst_2 instance.
> >
> > Usage examples:
> >
> > localhost ~ # echo "module thunderbolt =3DpT:7" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > This will enable output of debug logs to trace instance
> > <debugfs>/tracing/instances/dyndbg_inst_7 and debug logs will
> > be written to the syslog also because p flag is set.
> >
> > localhost ~ # echo "module thunderbolt =3DpT:7,l" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > When trace destination is followed by another flag then trace
> > destination has to be followed by ",".
> >
> > localhost ~ # echo "module thunderbolt =3DpTl" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > When trace destination is not provided explicitly then its value
> > defaults to 0. In this case debug logs will be written to the prdbg
> > and devdbg trace events.
> >
> > localhost ~ # echo "module thunderbolt =3DT:25" >
> >                                 <debugfs>/dynamic_debug/control
> >
> > This will enable output of debug logs to trace instance
> > <debugfs>/tracing/instances/dyndbg_inst_25 with debug logs output
> > to syslog disabled.
> >
> > Given trace instance will not be initialized until debug logs are
> > requested to be written to it and afer init it will persist until
> > reboot.
> >
>
> that (delayed init) might be a problem,
> user side will have to look for the appearance of traces ?
>

With open/close commands you proposed this will become obsolete.

> Also, I have some reservations about exposing numeric destinations -
> the user(space) must then decide/coordinate what dest-number
> is used for which instance/purpose.
>
> It would be fine for 1 customer, but might be a little tedious for many,
> who now have to coordinate.  A bit like a shared/party line in the early
> days of rural telephone.
>

Nice comparison :). But it was pretty "socializing" as everyone could
hear a conversation which took place on such a line.

> As I recall, an early early version of classmaps used numeric classes,
> (taken straight from drm_debug_category).
> As Jason noted (more diplomatically than I assimilated)
> it was kind of arbitrary and obscure/obtuse/unhelpful numbering.
>
> It is why I added classnames, with the bonus that
> the name->num mapping was also a validation step
> against known CLASSMAP_DEFINE-itions
> (if you knew DRM drivers knew "DRM_KMS_CORE",
>  you knew what you were asking for)
>
> Your earlier version had a dest keyword which maybe fits better with this=
 point.
> that said, it was in a selector position, so it doesnt work grammatically=
.
>
> So, what do you think about a new command:
>
> echo <<EoCMDBlk
> open kms-stream
> class DRM_UT_CORE +T  # global
> class DRM_UT_KMS +T:kms-stream
> EoCMDBlk \
> > /proc/dynamic/debug
>
> this allows tracking names, assigning ids, erroring when all used,
> and validating names > control
> without exposing the numbers.
>
> the open/close changes are (would be) persistent
>
> the thing it doesnt allow is pre-selecting the destination,
> then arming it later with a +T
>
> so it doesnt (wouldnt) play super-nice with
> echo 0x1F > /sys/module/drm/parameters/debug_trace
>
> that said, we can preset the dst:
>
> echo <<EoCMDBlk
> open drm-kms-stream
> open drm-core-stream
> class DRM_UT_CORE -T:drm-core-stream
> class DRM_UT_KMS -T:drm-kms-stream
> EoCMDBlk \
> > /proc/dynamic/debug
>
> then enable whatever is preset selectively:
>
> echo $I_forgot_the_bit > /sys/module/drm/parameters/debug_trace
> OR
> echo class DRM_UT_KMS +T > /proc/dynamic/debug
>

I agree that numbers are not very meaningful, I asked question related to y=
our
proposal in revisited comment.


>
>
>
>
>
>
> > Please note that output of debug logs to syslog (p flag) and trace
> > (T flag) can be independently enabled/disabled for each callsite.
> >
>
> so its the specific wording I previously grumbled about, I think.
>
> >
> >
> > Jim I took the liberty and based my work on your patches you pointed me
> > to https://github.com/jimc/linux/tree/dd-kitchen-sink. I picked up
> > the commits relevant to trace from the dd-kitchen-sink branch.
> > The only changes I introduced in your commits were related to checkpatc=
h
> > complains. There are two errors still left:
>
> Bah - macros !
> I'll look at your diffs in git :-)
>
> >
> > 1)
> > ERROR: need consistent spacing around '*' (ctx:WxV)
> > 140: FILE: lib/dynamic_debug.c:1070:
> > +                                 va_list *args)
> >
> > Which seems to be a false positive to me.
> >
> > 2)
> > ERROR: Macros with complex values should be enclosed in parentheses
> > 62: FILE: include/trace/stages/stage3_trace_output.h:12:
> > +#define TP_printk_no_nl(fmt, args...) fmt, args
> >
> > I have not figured out how to fix it.
>
> those 2  no_nl   patches were pretty exploratory,
> IIRC, Steve was inclined to add the \n  when not already in the format.
> It would be variation-proof
>
>
> >
> > Changes:
> > V1) Major rework after receiving feedback in
> > https://lore.kernel.org/all/20230915154856.1896062-1-lb@semihalf.com/
> >
> > Jim Cromie (7):
> >   dyndbg: add _DPRINTK_FLAGS_ENABLED
> >   dyndbg: add _DPRINTK_FLAGS_TRACE
> >   dyndbg: add write-events-to-tracefs code
> >   dyndbg: add 2 trace-events: pr_debug, dev_dbg
> >   tracefs: add TP_printk_no_nl - RFC
> >   trace: use TP_printk_no_nl in dyndbg:prdbg,devdbg
> >   dyndbg: repack struct _ddebug
> >
> > =C5=81ukasz Bartosik (5):
> >   dyndbg: move flags field to a new structure
> >   dyndbg: add trace destination field to _ddebug
> >   dyndbg: add processing of T(race) flag argument
> >   dyndbg: write debug logs to trace instance
> >   dyndbg: add trace support for hexdump
> >
> >  .../admin-guide/dynamic-debug-howto.rst       |   5 +-
> >  MAINTAINERS                                   |   1 +
> >  include/linux/dynamic_debug.h                 |  57 ++-
> >  include/trace/events/dyndbg.h                 |  54 +++
> >  include/trace/stages/stage3_trace_output.h    |   3 +
> >  include/trace/stages/stage7_class_define.h    |   3 +
> >  lib/Kconfig.debug                             |   1 +
> >  lib/dynamic_debug.c                           | 414 +++++++++++++++---
> >  8 files changed, 465 insertions(+), 73 deletions(-)
> >  create mode 100644 include/trace/events/dyndbg.h
> >
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
