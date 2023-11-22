Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E157F4C09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjKVQMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjKVPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:55:45 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9E318E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:55:41 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5caf387f2aaso31154747b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700668541; x=1701273341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HArRuhEJbPWUB0W1o682njJUc9wD7yRdaDevvOmIv4A=;
        b=iQd77CTuYh9bDrTj04rT1kZKWpdPENP2kLzACJ6e9YAvQ5lJxOsIwWebscrCkoEVJm
         QQbfSDZdCQ3UDxhVzPT15ULy552ms8Ert26n76q06rtTi10yyrq4gTSaOtNpS/H8i5pA
         cvH8Q3oQGW+E2CtaBJtmXmlx/y5n1kSR+RJTLKU7zsRwULjVhk1c05xDbNnREAGlv2gt
         CZeS0EcG9muwjUTE4Ty+mNKib8GFpbO1+lM3+0y4QJCkDZj2QMvkJwzw585gIWtag1A0
         7vmKE1jQMbwlodIp7iqL5J8lFz73r8q/Jskq9Pyuh7zoeGHpOVPhU4LX6xjpokAiPFF3
         RFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668541; x=1701273341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HArRuhEJbPWUB0W1o682njJUc9wD7yRdaDevvOmIv4A=;
        b=jfj5voT/PscaLr4YhuZ/q6q2ZaLSXN/jcIOeQUfxcTd/1tjLRnkgvWZWuh0NctVz+G
         Bzb7bfLYZVDBxIc6TSq23BPuoB2zfpfGPut3CeShlYcJ+ndkQSQlSfByjCGx6HrnT+EM
         BhdLo/ll3D/qxonQN+ayq1df9ug36IbiEMIU2PzKJ3j2K7mQXnJo9c0gmwWwvnDcv1QY
         M/ZydXVWeUK8hNAmBIV7Ey+d9/76/MhA/68FwfxlzSRNz8HKk1g6A4eiwWg5OX8gdgyD
         TuipYJIOebmx5pZFHxHug4reLKS6TpWoLY4jl7sTIk3nUcmGRGAVg6UtlSkxCvkMAhEi
         NjGA==
X-Gm-Message-State: AOJu0YwpXgsf/fuJB/MdyBOukW093tLLCmPMAadbEdewN0tBA+W2wfho
        1dNvt173hzrURZsxOlzeoHegl+O6otGHPhkShPEB+KJ5OxEu9oeG
X-Google-Smtp-Source: AGHT+IEatp29tETsY/z/USG4bCMF0FNTFq9EcKk6EQSgLqW7OdflPc+5AsvOvVB9eY2hZF924Cg6DLUnnnLMemc93og=
X-Received: by 2002:a81:658a:0:b0:5a7:aece:7e59 with SMTP id
 z132-20020a81658a000000b005a7aece7e59mr2546769ywb.50.1700668540835; Wed, 22
 Nov 2023 07:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20231121175640.9981-1-mkoutny@suse.com> <CAM0EoM=id7xo1=F5SY2f+hy8a8pkXQ5a0xNJ+JKd9e6o=--RQg@mail.gmail.com>
 <yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite2ah2a6i@l6arp7nzyj75> <CAM0EoMk_OgpjV7Huh-NHF_WxkJtQYGAMY+kutsL=qD9oYthh_w@mail.gmail.com>
In-Reply-To: <CAM0EoMk_OgpjV7Huh-NHF_WxkJtQYGAMY+kutsL=qD9oYthh_w@mail.gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 22 Nov 2023 10:55:29 -0500
Message-ID: <CAM0EoM=Pq02p-sbkMSQBg8=dwTC5z+AeLjeXdzeHTA1AFSLuRg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cls: Load net classifier modules via alias
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>,
        Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:33=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Nov 22, 2023 at 5:41=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.=
com> wrote:
> >
> > On Tue, Nov 21, 2023 at 05:37:37PM -0500, Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > What's speacial about the "tcf- '' that makes it work
> > > better for filtering than existing "cls_" prefix?
> >
> > tcf-foo is an alias.
> > cls_foo is the canonical name of the kernel module.
> >
> > request_module() + blacklist (as described in modprobe.d(5)) works only
> > when calling with the alias. The actual string is not important, being
> > an alias is the crux.
> >
>
> Thanks for the explanation.
>

Out of curiosity - how did you end up looking at this? Was there
someone who complained or is it just standard procedure to add aliases
to all modules and it was on a todo list somewhere?

cheers,
jamal

> > > What about actions (prefix "act_") etc?
> >
> > I focused only on "cls_" for the first iteration. Do you want me to loo=
k
> > at other analogous loads?
>
> Yes, look at act_ and sch_
>
> cheers,
> jamal
> > Thanks,
> > Michal
