Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A527F2513
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjKUFJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjKUFI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:08:58 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D8DFA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:08:54 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso2396740fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700543333; x=1701148133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qLSUmFxKYTTBBAoYkylVM+B9mW+ZB3Zjl8Q8XAnhUc=;
        b=gWSQjuZKMt8glacIc5TJKBo3SDZpmp5CxWgTYXI5QEwn7JzoSw078/XJm1RJd0Lj4Q
         +LOaI0T3MzX9bCn8G0fwHw2ZDm4NLA21D7my9Fm/IUOwh9gjWLZx4aXqJyxWAPwy8wAj
         N0S4K6EDTAtqwfpoVlZZwtxmdnHcyYVbU+8BFVQm3MthxHwT5AEr0+8YufWMkkJNcc2Z
         ywFJXtExE7Ex48TG0g7Q8xnYvpYr67uEXu8zadxlJnheuTeP/Hg4CyF1+RPi7xdQGLVh
         M5s76b3ZmBm8ZcPmCpEd0ZhbL9QyQo6k50nLzz4w7r3k1trduMnEKU2gJLiKzy2UMLpv
         Ps+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700543333; x=1701148133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qLSUmFxKYTTBBAoYkylVM+B9mW+ZB3Zjl8Q8XAnhUc=;
        b=kI5ykB06CFXAfmGAigLsjq97cp44YrxH/wLM3AY3qlmp3WrrYFA7n6bY4aRNtkZFHc
         txEONTZo+YZViieHZtRY7RV2r2B5a9PXE6erDVdn0O3R5NBEk3V+urQIbFvKqQfDtsP+
         CN9JIUbOf376acaGI18gzlP92a3JxhOLDIqs7ExHvrlxnj9lVN2XVfoMWASCV6Pmm0jA
         7shIdde/2CN86unGYLL4TtWOqAwAud9H2LQJmXTeO8simlx8Q29hvARBG3ejccFfy2H9
         6RKoCtQv0QZytpW3ig/Oy1OLZyJ8tZKpYvP3KmpUOHdY0jPDsm5JubF7s3hrQch0qrP9
         8nEQ==
X-Gm-Message-State: AOJu0YybIW1SxZg2AtViRZBo+Iiwi/RXhu9jjrKN2RD+qVSYRa3JYbaD
        TayLagrlSaWuHpBG/TJIslShawn7IU0qbsguGzM=
X-Google-Smtp-Source: AGHT+IEhusFNJwp+JRVVrtPDfFkMGj6VkoCMw5BuesUHTNCoKKWuSelnAF94c/McFcKs5kVt53I+ludjrM8Ewj2Nxug=
X-Received: by 2002:a05:6871:5211:b0:1f9:6962:b06c with SMTP id
 ht17-20020a056871521100b001f96962b06cmr1127983oac.53.1700543333479; Mon, 20
 Nov 2023 21:08:53 -0800 (PST)
MIME-Version: 1.0
References: <20231120073821.1304-1-xuewen.yan@unisoc.com> <7c223b0c-d39a-4d53-8f00-7fbec6b49b6e@bytedance.com>
In-Reply-To: <7c223b0c-d39a-4d53-8f00-7fbec6b49b6e@bytedance.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Tue, 21 Nov 2023 13:08:42 +0800
Message-ID: <CAB8ipk_vO_WaCP6DgsfWdB+fa+hRyRVNwxY81KL=V3o2RD_svg@mail.gmail.com>
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

On Mon, Nov 20, 2023 at 4:49=E2=80=AFPM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Hi Xuewen, the pick part has been re-worked, would you please re-test
> with the newest branch?

Okay, Thanks!

>
> Thanks,
>         Abel
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=3Dsched%2F=
core
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
