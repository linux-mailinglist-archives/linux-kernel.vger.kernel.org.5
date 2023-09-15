Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3352F7A21E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjIOPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjIOPHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:07:41 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684652726
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:06:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41513d2cca7so353601cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694790381; x=1695395181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PZMXRUic8jLDKg5Qn/0jsFYvtSW5SyhezA9EAWtnpI=;
        b=ZvRTjhnHpR/jBbprd6N9AnrsZ83tbGR5ScCBYxZDA7fxVI3kmd8BR1yZ4y6PpPbQqU
         5qlQf8Il/Koafw0ROIG5O88sCo9YwwroIe49FeOvsxsiv2WzsggzP+TaT6wOlDPM6eCH
         dhKZ+457BJch+bjRGXdmxC4NCgP48rRst6kH1eY9WXqEVnXPg7hSZQ7NxGvop25dTaNY
         taGExLpBCel3k81o7mvRurkER8woBVhQuMxQvC6mRlwKeRfBSgb+0BRXtPzexrsBDUpD
         g4AR1pOlqVussRnUbVdskWhdHJtc2BWf/FAknuoYG2jNjyx9aDUwZA7RsVV8PcL/xxSD
         xPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790381; x=1695395181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PZMXRUic8jLDKg5Qn/0jsFYvtSW5SyhezA9EAWtnpI=;
        b=ZKraqbbMdQkf+CBXgaG2bYiclFfSO9f74LPlK/+YjJPdDjGnhI3zPzOUqHTGgR1RSh
         FbjHjsGbZLEjsNNXzwt8YjKwBcQWCuyLnlSRjViUt7fMDck6tkCVukkvsir18b7vyUTZ
         XR+ZA1BVTl8GqyDOPmj34emJFGoPtdE7acOLTmkKMTMVlA9slRjx6g5Hydb5OUIr41Zh
         7Y1EkU8ntRExRQuMjEkgck79NxLQKtiejKqLWtbhldA6HfV7uRoINyMhjVldLTgQkc2e
         /FVSSZnnfJDGaWTrYPYVqSr1Kd2tc2qMxUDXS4KphEw8Bvm4NS3DEVpM1MwpVl+/TbwI
         3T5g==
X-Gm-Message-State: AOJu0Yy50c1hE9G3o0lbhHgQbZs5QNdSUzn0++l5+PdOcpLKNom9k1Fz
        8fVgIsyQTXU7glAV4zZeXpQ4EKQMOtd9o68CwLDXxw==
X-Google-Smtp-Source: AGHT+IF/qfW1nt3T0UFrmUbSo4vb+e1sURQZHaIker3s5qm0jRWjN4KBqSDmjuLTbiFygljtMDlxozq2UI6JbGY6UY0=
X-Received: by 2002:a05:622a:50a:b0:40f:c60d:1c79 with SMTP id
 l10-20020a05622a050a00b0040fc60d1c79mr284661qtx.28.1694790381039; Fri, 15 Sep
 2023 08:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230915104156.3406380-1-make_ruc2021@163.com>
 <CANn89iJyktWcztc76Pw16MP-k-DfSjstW+WFgRxwUat7p25CGw@mail.gmail.com> <16461255-c2c0-2ffd-f031-5b7a1f67bf7e@mojatatu.com>
In-Reply-To: <16461255-c2c0-2ffd-f031-5b7a1f67bf7e@mojatatu.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 15 Sep 2023 17:06:09 +0200
Message-ID: <CANn89i++j0-QJ1WE=RO4_ucN9k-DgqK52jLSTcz_s_DmFiAnFw@mail.gmail.com>
Subject: Re: [PATCH] net: sched: drr: dont intepret cls results when asked to drop
To:     Pedro Tammela <pctammela@mojatatu.com>
Cc:     Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 5:03=E2=80=AFPM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> On 15/09/2023 09:55, Eric Dumazet wrote:
> > On Fri, Sep 15, 2023 at 12:42=E2=80=AFPM Ma Ke <make_ruc2021@163.com> w=
rote:
> >>
> >> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> >> assume res.class contains a valid pointer.
> >>
> >> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> >> ---
> >>   net/sched/sch_drr.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> >> index 19901e77cd3b..2b854cb6edf9 100644
> >> --- a/net/sched/sch_drr.c
> >> +++ b/net/sched/sch_drr.c
> >> @@ -309,6 +309,8 @@ static struct drr_class *drr_classify(struct sk_bu=
ff *skb, struct Qdisc *sch,
> >>          *qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
> >>          fl =3D rcu_dereference_bh(q->filter_list);
> >>          result =3D tcf_classify(skb, NULL, fl, &res, false);
> >> +       if (result =3D=3D TC_ACT_SHOT)
> >> +               return NULL;
> >>          if (result >=3D 0) {
> >>   #ifdef CONFIG_NET_CLS_ACT
> >>                  switch (result) {
> >> --
> >> 2.37.2
> >>
> >
> >   I do not see a bug, TC_ACT_SHOT is handled in the switch (result) jus=
t fine
> > at line 320 ?
>
> Following the code path (with CONFIG_NET_CLS_ACT=3Dn in mind), it looks
> like there are a couple of places which return TC_ACT_SHOT before
> calling any classifiers, which then would cause some qdiscs to look into
> a uninitialized 'struct tcf_result res'.
> I could be misreading it... But if it's the problem the author is trying
> to fix, the obvious way to do it would be:
>         struct tcf_result res =3D {};

CONFIG_NET_CLS_ACT=3Dn, how come TC_ACT_SHOT could be used ?

Can we get rid of CONFIG_NET_CLS_ACT, this seems obfuscation to me at
this point.
