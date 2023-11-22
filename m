Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3787F4A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344470AbjKVPeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjKVPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:33:45 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A5D10C7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:33:13 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cc3dd21b0cso10848097b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 07:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700667192; x=1701271992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4ei9NRU/G7jwU5acqapK3n4Kv1mApAAownSARqq2L0=;
        b=ZotGumm18UkjuzQlhCKJy3Pu0MPvp/26g9R0vuU7+vIzkLf/zZIC/dVBFj8r4LcvQ3
         4KcAlrI11IjyvgjUHVZYV2Q6BsxRkhpzG45d88mQqmk7WCUGLkXGGwAy8jo4UFDh9UCZ
         B9V2M4UcNPMpSYeZ3U79QjlYVG1mTdhrIMFyBpcnGwVkABFeCF6wiGtpG4iA+mUeLnw+
         PAe8Q7QaA7hl8meuB085PBVal2zn4uaoiRQZ7nY23xgN+SC352eIE01y7Qni55kabB+y
         TfxaCr66ufKsreFEYtxfffAOS0RYr07Huo8yR1eO5xVk3w1Go7zcwGIvArv1ugCWqm1s
         11Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667192; x=1701271992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4ei9NRU/G7jwU5acqapK3n4Kv1mApAAownSARqq2L0=;
        b=ssJH1EbvL8YGWHIIsNfz7xqLALFtKn6ycEr3RFGSsTx45P/BthwiggNjcjAjl969of
         g+3h84ojB0fqjDicjbDGWj/dGI6+sTSOQnwDLKCXuQRQ3ccIU5WrM+NGsaQ83Z+uV/1n
         Bosamz9ubQZd2ruvjhhKb0TqHv6nBUX7RXCzoL69Nhw2N1MWyg1mlHU0ZcEzFYUmnwPJ
         HWO6hOEPQY1POpRU/ye4lZCw/iT2EqfCGqxBFelOlgq7ss338C03UTlgGsesmLhI3iyg
         UkT5aqqSLdibHWZCnLkWH2LDwK1tJz/+yDza7lK42HdLRzFeSev4SFwdYk+B4jCMM5PJ
         dcDg==
X-Gm-Message-State: AOJu0Yzz3HleZm7cGE0DhGCY4u+VyizWUinQ1+T7+YAvaUeoxyO9mI/h
        YF5Z0vQc/9VqLBfdJ/usaEJpIS45ni+O9dpLFn/RKUWJ6k5iAKyb
X-Google-Smtp-Source: AGHT+IE4G4KLm9Drcj26SIBaIAfNRfhVxN87Ha1FgM1GhfP1jQnP9+8vTA0KhZEZWso2wFxW5NqLLp8rwsJG9A9wifg=
X-Received: by 2002:a0d:efc2:0:b0:5cb:e3a9:5e77 with SMTP id
 y185-20020a0defc2000000b005cbe3a95e77mr2755985ywe.6.1700667192512; Wed, 22
 Nov 2023 07:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20231121175640.9981-1-mkoutny@suse.com> <CAM0EoM=id7xo1=F5SY2f+hy8a8pkXQ5a0xNJ+JKd9e6o=--RQg@mail.gmail.com>
 <yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite2ah2a6i@l6arp7nzyj75>
In-Reply-To: <yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite2ah2a6i@l6arp7nzyj75>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Wed, 22 Nov 2023 10:33:01 -0500
Message-ID: <CAM0EoMk_OgpjV7Huh-NHF_WxkJtQYGAMY+kutsL=qD9oYthh_w@mail.gmail.com>
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

On Wed, Nov 22, 2023 at 5:41=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Tue, Nov 21, 2023 at 05:37:37PM -0500, Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > What's speacial about the "tcf- '' that makes it work
> > better for filtering than existing "cls_" prefix?
>
> tcf-foo is an alias.
> cls_foo is the canonical name of the kernel module.
>
> request_module() + blacklist (as described in modprobe.d(5)) works only
> when calling with the alias. The actual string is not important, being
> an alias is the crux.
>

Thanks for the explanation.

> > What about actions (prefix "act_") etc?
>
> I focused only on "cls_" for the first iteration. Do you want me to look
> at other analogous loads?

Yes, look at act_ and sch_

cheers,
jamal
> Thanks,
> Michal
