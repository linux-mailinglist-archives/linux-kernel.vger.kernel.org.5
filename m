Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6F0780B50
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376513AbjHRLnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376462AbjHRLmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:42:46 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6DB10DF;
        Fri, 18 Aug 2023 04:42:45 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-4103393a459so5651711cf.0;
        Fri, 18 Aug 2023 04:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692358964; x=1692963764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gUGa5pjlqkk1OcHTAGK9JwqvaQXnW1KsBKKB1vNUc4=;
        b=OQzyOVtPUuIHuLUWDWM//tAq2FIK5olQBgFlN3vLo5agf7nKCCnwEP6/rHlulXYCHO
         VxarFLi3dmi9woN8jgdpqomjEh9GOq4BYfTMhcI958/BTzsDLTSgg1klbSNPEx3VlLto
         0biOSMV8TNbVxLfdPFy/oqWC4rjfqzNAdgrhKXfur/M11PjbOY+23TVhUwUeCXr1mng1
         1pK88JsOz/eTSJVnJKkzE4HEslf2fa5HVmlq2RbfOZEs9i+CVpyWG+AUf5Nn4hyEd4ad
         ByS5aKuJuFSNX0y3iAoVTYWjkPsq7PdkPxBbLt6PvRcwg+9LhRxfkEAbkYd6ByD65MWi
         LZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692358964; x=1692963764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gUGa5pjlqkk1OcHTAGK9JwqvaQXnW1KsBKKB1vNUc4=;
        b=P8kvYb0d7ASKXELO9CVypsPcgLMKeXRbvsxYUC2nXn/PgcNKPHLhLxJJxAPS37mJmI
         1mkTyYvL0Tfx45vTp2TcjWBH6/pheI185AL9C6OpsBPQeRxID+VnSNr9VZjsdCPJ1+B2
         +4p3QP7JDszrM9IndvKpE7FX7u6LJA7CyKy03Ulp4iOWOXb8hUMt1piiyaNr3BeGcrdr
         Q0jMfhDku0/QQ02BKCpXeXlo8hgmZfsF5pAo1sUyFceP0PC5q4cBulpFEMgWT7xdWfeg
         wkikzqeGbUqZrcwxl4PZRiTPSd+wI3AVKsSwvlOuwo1wuriG+mqpL8RpI5UQQTF6666/
         9ehg==
X-Gm-Message-State: AOJu0YzlJfNC/kKoJx8vhYe0rNY3qcl6BYjwzUxX894gHCS5k7h/sOD9
        qN7Oc2LAS1ZuE6TZdwv7t7AHow7US8outdXRIV22MtKv
X-Google-Smtp-Source: AGHT+IFvg/PyS67P4uuGHe1pT8wHZnx17qw5h8CUsLymGEzFOoemE3zX716JAiDAc8Ql1jjXCY1HMVY1B239nY2mroM=
X-Received: by 2002:a05:622a:341:b0:40f:d27a:4367 with SMTP id
 r1-20020a05622a034100b0040fd27a4367mr2813003qtw.58.1692358964398; Fri, 18 Aug
 2023 04:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230811081239.246365-1-nashuiliang@gmail.com>
 <20230811154523.61e67cc3@gandalf.local.home> <20230812142019.06cb38b56287b0f068e8164f@kernel.org>
 <20230816160850.48fa95b6@gandalf.local.home> <20230818200258.7f318bab352508c54ed53e83@kernel.org>
In-Reply-To: <20230818200258.7f318bab352508c54ed53e83@kernel.org>
From:   chuang <nashuiliang@gmail.com>
Date:   Fri, 18 Aug 2023 19:42:33 +0800
Message-ID: <CACueBy7U9+b46YJ6Lbd-c=Nm9KhQyMoXbVOMT4esLYqq7nMt5Q@mail.gmail.com>
Subject: Re: [PATCH v2] tracing/eprobe: Iterate trace_eprobe directly
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I will submit a new patch using "for_each_trace_eprobe_tp".

On Fri, Aug 18, 2023 at 7:03=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Wed, 16 Aug 2023 16:08:50 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Sat, 12 Aug 2023 14:20:19 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >
> > > > At a minimum, let's call it:
> > > >
> > > >   for_each_trace_point_eprobe()
> > >
> > > OK, what about "for_each_trace_eprobe_on()"? I would like to clarify
> > >
> > > - what type is returned
> > > - not all trace_eprobes, but only on the trace_probe.
> > >
> > > Thank you,
> >
> >  for_each_trace_eprobe_tp() or for_each_trace_tp_eprobe() ?
>
> for_each_trace_eprobe_tp() is OK for me.
>
> Thanks!
>
> >
> > As it only works for a trace_probe.
> >
> > -- Steve
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
