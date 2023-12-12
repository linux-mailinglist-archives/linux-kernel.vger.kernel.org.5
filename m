Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3B180E273
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbjLLCvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjLLCvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:51:11 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1243EB0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:51:18 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d9f7b3de20so2381154a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702349477; x=1702954277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0aqDUuu9aenJJR4Np5l50Pkm6dm94+30/fi4cOM9ww=;
        b=S8ZNLwmmAeZGyiuxfCljoX3qsgkSFf6OYkLFEMTfdiV3aaWAYtm99ThIdl61obAnuN
         xAL4taOQmrMmUCG3UCmvgzaIOnB8JKjQ3lRr3m4b6JoSVOLTLAMswbiwnaI5w6KEzQOJ
         DZ6lbZV9eGz571YexPJtkMNWo+N9eDzfVouEuekOqx2IeNBhn9sapKuDjQVufojFO0d3
         nltl55ZuEu3+AYr0CqBySUVp01qNA58D/m25PzYWuqRjnxmoatzvedq7+vXb9vRfR9XI
         mnkutmEnqFuIwiCcfJ2K/FYQbFk3XXs3FFvmtSAWZxxPIebXZZ7URJi91kwd4qnD+wGE
         6Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702349477; x=1702954277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0aqDUuu9aenJJR4Np5l50Pkm6dm94+30/fi4cOM9ww=;
        b=ogvWYOMbuwCQsvjan5DQIZ06gSHVN2950GBx9x74UP7pgbsgAnewODdADL5XrBkP/o
         2Wi+3FIlpGBRysP85JV4LUZVvrVlH9wWBic8VEvOVsS4g87LjR6HlK49ZC2ba+gYpuT1
         va7CpUH4tmgfYNF2HLrot9Pfs+EVYqlrNALPRqvTX/sBtfu9VxwhzsrlefQz7J/rxB2f
         nLEi/ZLP+80lFDQIR7ijNIVwg4EB1LIzbvzqH6iy+mDAM2+2DflPFEA1wAs6mOQbW+vb
         V/lG9L5vKWMwU0b/TIC4HcVdJ6FGqQVS+CmgYcd2ILkm4e5B3TUnOcFYYtAgSCRFR/Vi
         PBZg==
X-Gm-Message-State: AOJu0Yxjln0kzdVBBPAy8/qglt8RK/bX+m7eIpPPno+vCmV9cPUDeNvI
        TEF7fevbuArUdEk4RdFIhwSWUYOukAq2w0DvWDw=
X-Google-Smtp-Source: AGHT+IFgpzLthij4rpf+ngrmQ6+YXdGpHyiX/IJmFbP8yOEti1iOwk1gCRKUsHkaRJXcrC8irvl9qFQpXXSrMy6fDUc=
X-Received: by 2002:a05:6870:799:b0:1fb:75b:99c7 with SMTP id
 en25-20020a056870079900b001fb075b99c7mr7298636oab.118.1702349477378; Mon, 11
 Dec 2023 18:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20231120073821.1304-1-xuewen.yan@unisoc.com> <7c223b0c-d39a-4d53-8f00-7fbec6b49b6e@bytedance.com>
In-Reply-To: <7c223b0c-d39a-4d53-8f00-7fbec6b49b6e@bytedance.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 12 Dec 2023 10:51:05 +0800
Message-ID: <CAB8ipk9WBNE8Yk9T9SXovnpyUtGu=ps8_i=3hbb4PS9PXovR+w@mail.gmail.com>
Subject: Re: [PATCH] sched/eevdf: Avoid NULL in pick_eevdf
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel

On Mon, Nov 20, 2023 at 4:49=E2=80=AFPM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Hi Xuewen, the pick part has been re-worked, would you please re-test
> with the newest branch?
>
> Thanks,
>         Abel
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=3Dsched%2F=
core

These patches would be merged into 6.6? If not, the pr_err also has a deadl=
ock.
And should be changed to printk_deferred.


954 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
  955 {
  956         struct sched_entity *se =3D __pick_eevdf(cfs_rq);
  957
  958         if (!se) {
  959                 struct sched_entity *left =3D __pick_first_entity(cfs=
_rq);
  960                 if (left) {
  961                         pr_err("EEVDF scheduling fail, picking
leftmost\n"); <<<<
  962                         return left;
  963                 }
  964         }
  965
  966         return se;
  967 }


>
> On 11/20/23 3:38 PM, Xuewen Yan Wrote:
> > Now in pick_eevdf function, add the pick_first_entity to prevent
> > picking null when using eevdf, however, the leftmost may be null.
> > As a result, it would cause oops because the se is NULL.
> >
> > Fix this by compare the curr and left, if the left is null, set
> > the se be curr.
> >
> > Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling po=
licy")
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >   kernel/sched/fair.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d7a3c63a2171..10916f6778ac 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -951,12 +951,28 @@ static struct sched_entity *__pick_eevdf(struct c=
fs_rq *cfs_rq)
> >       return NULL;
> >   }
> >
> > +/* Just simply choose the se with the smallest vruntime */
> > +static struct sched_entity *__pick_cfs(struct cfs_rq *cfs_rq)
> > +{
> > +     struct sched_entity *curr =3D cfs_rq->curr;
> > +     struct sched_entity *left =3D __pick_first_entity(cfs_rq);
> > +
> > +     /*
> > +      * If curr is set we have to see if its left of the leftmost enti=
ty
> > +      * still in the tree, provided there was anything in the tree at =
all.
> > +      */
> > +     if (!left || (curr && entity_before(curr, left)))
> > +             left =3D curr;
> > +
> > +     return left;
> > +}
> > +
> >   static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> >   {
> >       struct sched_entity *se =3D __pick_eevdf(cfs_rq);
> >
> >       if (!se) {
> > -             struct sched_entity *left =3D __pick_first_entity(cfs_rq)=
;
> > +             struct sched_entity *left =3D __pick_cfs(cfs_rq);
> >               if (left) {
> >                       pr_err("EEVDF scheduling fail, picking leftmost\n=
");
> >                       return left;
