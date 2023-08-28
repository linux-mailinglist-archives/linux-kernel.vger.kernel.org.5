Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4478A868
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjH1I7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjH1I7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:59:50 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D29103;
        Mon, 28 Aug 2023 01:59:47 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76da8e70ed3so177940485a.3;
        Mon, 28 Aug 2023 01:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693213187; x=1693817987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6/obRJ5ioyT4HGrPxjoMWXiWDYdXVyzHpHN+4tAdfM=;
        b=LZwzEb5BQgbi7VGf5ZmGZmOIyzdEHmzuHd6TEPDu/fVJ3uvGT5KpXxnrC4wbDzHU2y
         F5CNZQ8ClIWDeQiIarBLbsL/lGwMgn6UvCyEu/L1eSr4jE2wPJN+lQhUGwLe/t5Wgy7f
         sdhvG7PoBA4Xf5WsSBd/bax03neNJcoiwjyKa1nrJ3RUWnGRdCHqPlBlr2AAmb8GfOia
         uHSF5ID7XAeRul0dOMhTp8dA99k/1uKllM9M/aOaF4nkDf5nx0GXIVCX1UgnlQdR3idu
         HblpvC+qxCrJZD969XuYZcl5gR6YiE1sIWasNnjWhkbYtlopbVHPksM+6Q0cmVx/fWQh
         /vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693213187; x=1693817987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6/obRJ5ioyT4HGrPxjoMWXiWDYdXVyzHpHN+4tAdfM=;
        b=cKfiZ2LtPdV3K9XPyAkbFI++VghkFNwOj0DGp4U7HH3Zs9EZczmDpw6C9lRjIF1zN4
         vY0qYs5Aa4FfwMmIOVc6zHt7vRdtQ/XINehtMoo2FWVkp+fpYRul6xnspOpEclpAB8Xo
         1b4IB3KbRTdylr4Y07bLgEbcMY3VM1omC+1enq2smPcjS0eqUEI1JwGwOTlEFl79tLrN
         vziDjc2m0LZUGRABcDg4LknhPs/pm8mxuj5Gxp5sHygLTnurjplVo8N9us9mgVHZ/anF
         PKclhwQ+HK/H6cl5Tjp+yGMGbonA1A5wUi+4tM7uGDKirh3z69Fj8kpY8Qp6vK96IuOo
         4XXg==
X-Gm-Message-State: AOJu0YxXgEFZrCLmUBGuTBzEL8Sz7KeUkdU/tFmvJ7saa9dZvPggG8l4
        CEUo/jYyCvPNTNiJeqj71BfJiyPJoj1FYBH4EIV6xagIz9Y=
X-Google-Smtp-Source: AGHT+IH1zyaLI3bOrANccKAtefGchSmSDUk3GJooSvfC2L+NnKMoE4zItrP3AArM78MhyWE/WgW4LlDQkapZNYMqYFU=
X-Received: by 2002:a0c:c547:0:b0:64f:3882:512a with SMTP id
 y7-20020a0cc547000000b0064f3882512amr23079371qvi.13.1693213186970; Mon, 28
 Aug 2023 01:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230823061734.27479-1-wenchao.chen@unisoc.com>
 <20230823061734.27479-3-wenchao.chen@unisoc.com> <CAPDyKFriZ_uu-WACjqXK5um1bYJSDaHsghOMGwwPJXM8pYCoGw@mail.gmail.com>
In-Reply-To: <CAPDyKFriZ_uu-WACjqXK5um1bYJSDaHsghOMGwwPJXM8pYCoGw@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Mon, 28 Aug 2023 16:59:35 +0800
Message-ID: <CA+Da2qzsDv9MVvmXwG=DsF6B70geR1PCy+KG63n8dqJecHzXUg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: hsq: dynamic adjustment of hsq->depth
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 6:37=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 23 Aug 2023 at 08:18, Wenchao Chen <wenchao.chen@unisoc.com> wrot=
e:
> >
> > Increasing hsq_depth improves random write performance.
> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >  drivers/mmc/host/mmc_hsq.c | 26 ++++++++++++++++++++++++++
> >  drivers/mmc/host/mmc_hsq.h |  2 ++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> > index 8556cacb21a1..8682a3d16a76 100644
> > --- a/drivers/mmc/host/mmc_hsq.c
> > +++ b/drivers/mmc/host/mmc_hsq.c
> > @@ -21,6 +21,30 @@ static void mmc_hsq_retry_handler(struct work_struct=
 *work)
> >         mmc->ops->request(mmc, hsq->mrq);
> >  }
> >
> > +static void mmc_hsq_modify_threshold(struct mmc_hsq *hsq)
> > +{
> > +       struct mmc_host *mmc =3D hsq->mmc;
> > +       struct mmc_request *mrq;
> > +       struct hsq_slot *slot;
> > +       int need_change =3D 0;
> > +       int tag;
> > +
> > +       for (tag =3D 0; tag < HSQ_NUM_SLOTS; tag++) {
> > +               slot =3D &hsq->slot[tag];
> > +               mrq =3D slot->mrq;
> > +               if (mrq && mrq->data && (mrq->data->blocks =3D=3D HSQ_D=
ATA_IS_4K)
>
> This assumes mrq->data->blksz is 512 (which at least for now is always
> the case), but perhaps better to compute the request size instead?
> Hence:
>
> "mrq->data->blksz * mrq->data->blocks =3D=3D 4096"
>

I will update it in the next version. Thanks.

> > +                               && (mrq->data->flags & MMC_DATA_WRITE))
> > +                       need_change++;
> > +               else
> > +                       break;
> > +       }
> > +
> > +       if (need_change > 1)
> > +               mmc->hsq_depth =3D HSQ_PERFORMANCE_DEPTH;
> > +       else
> > +               mmc->hsq_depth =3D HSQ_NORMAL_DEPTH;
> > +}
> > +
> >  static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
> >  {
> >         struct mmc_host *mmc =3D hsq->mmc;
> > @@ -42,6 +66,8 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq=
)
> >                 return;
> >         }
> >
> > +       mmc_hsq_modify_threshold(hsq);
> > +
> >         slot =3D &hsq->slot[hsq->next_tag];
> >         hsq->mrq =3D slot->mrq;
> >         hsq->qcnt--;
> > diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> > index aa5c4543b55f..fc031e38f1e0 100644
> > --- a/drivers/mmc/host/mmc_hsq.h
> > +++ b/drivers/mmc/host/mmc_hsq.h
> > @@ -10,6 +10,8 @@
> >   * flight to avoid a long latency.
> >   */
> >  #define HSQ_NORMAL_DEPTH       2
> > +#define HSQ_PERFORMANCE_DEPTH  5
> > +#define HSQ_DATA_IS_4K 8
>
> Perhaps re-phrase the comment a few lines above to explain why/when
> '5' can be good too.
>

Ok, I'll add that in the next version. Thanks.

For 4k random writes, we allow hsq_depth to increase to 5 for better
performance.

> >
> >  struct hsq_slot {
> >         struct mmc_request *mrq;
>
> Kind regards
> Uffe
