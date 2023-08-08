Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2D774109
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjHHRNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjHHRND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:13:03 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529D81BAE2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:05:31 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76ca4f88215so354917285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510726; x=1692115526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsX16JaE/dN4gOylJbVE7fA44TuS5QnBc2EtJo4lrms=;
        b=b2GlzASdy7DBOrglpdUoZtOJwsrDI9Gd+EyHGESN0d9EVByLOvXFsC8evpanH1A/K2
         W+6LX4yiesx88ny0/egZen0LCIxTIl1XB0uP0d67gUn6pZvoUQ4jfmCA2cUSdBCcjYFI
         sXhZpw1LqigAgY0qBaUHdMX6+YIPKTKSVoWnOeRdhx/l9HxkR0j90H5lqbowbU1ddtjX
         jJF9CXlo/+Sm8gGES3RfOt5/uQkPNVxeg2ZI9ebs6AAEguA4GDM35Ehg5OJBXjrHlNQ2
         oAIFkBXKq41ilGBJLhs9KzdxlvovHIqzwdece8hP4TGMQNKTk5dB/sucHwcPWuSp5Xsf
         ZK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510726; x=1692115526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsX16JaE/dN4gOylJbVE7fA44TuS5QnBc2EtJo4lrms=;
        b=bir2v1ufzpTPc3ppfJSqHpMUmVXlD8RnPJWMYGe1Yp+PwWZDI8FTsb43S3dXp/cBJ2
         92AJoJYr6BTyXeEWZEUXrdo9mC+7tf1bs3emygRIn3dH6bJ8g5anzyBQjFuokun5rWzO
         LeceFCDvBGUZCX8aJRYuICKu5ZTWT06N/olEU8c08/sOecUOx/HYQgs5ye5hEqkBd2tC
         wRqMrs/cCQtdEkd3tjAgCIwbs+EYHwpIcsCTKE4atN5soU8McFkF/CLmYRik3ytWwaw/
         RPKRRdLXzSx/HTWfhlJggkUjj0EMNRxC0Dr0y7+tkBkTUyy2C9t2SGNeys0C3SDKOU9f
         vZaw==
X-Gm-Message-State: AOJu0YxGYwNS0aT/xzECPkXJW2YF3pJk8JKsma0GLA1Of5wApmJQi5UB
        VA14vRY7nqNbBCPTMdsotwBoJbkqTPZAh+iKqnYauga6CrXLLu53+0U=
X-Google-Smtp-Source: AGHT+IFcHuCdhWhFwV2CScacW37TrXchQ6LgEx/9avD7k7yowHOyPtOByTZWzFezP6769EyQm7oX+P3bxdH+dA6DuRY=
X-Received: by 2002:a25:cc8a:0:b0:d09:544a:db1b with SMTP id
 l132-20020a25cc8a000000b00d09544adb1bmr14692730ybf.34.1691492228235; Tue, 08
 Aug 2023 03:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230803054544.22007-1-wenchao.chen@unisoc.com>
 <CAPDyKFrb_nH7w8Wjz3oxJ6Vj30W4-U=k2ST8O7aib_kSHBjsFw@mail.gmail.com> <CA+Da2qzyKxvkkJYcbeYUzF5+VuFMka1tGjkvv09uD8Y1tKZcfg@mail.gmail.com>
In-Reply-To: <CA+Da2qzyKxvkkJYcbeYUzF5+VuFMka1tGjkvv09uD8Y1tKZcfg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:56:32 +0200
Message-ID: <CAPDyKFp2Yp=7FjWreaxHb6nbF8MVaTNtiKR7wfUk=nsE5vVihg@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: replace immediate with hsq->depth
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 12:41, Wenchao Chen <wenchao.chen666@gmail.com> wrote=
:
>
> On Tue, Aug 8, 2023 at 5:28=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Thu, 3 Aug 2023 at 07:46, Wenchao Chen <wenchao.chen@unisoc.com> wro=
te:
> > >
> > > Hsq is similar to cqe, using hsq->depth to represent
> > > the maximum processing capacity of hsq. We can adjust
> > > hsq->depth according to the actual situation.
> >
> > Sorry, but I don't quite follow here.
> >
> > Are you planning to update the host->hsq_depth dynamically from somewhe=
re?
> >
> > Kind regards
> > Uffe
> >
> Hi Uffe,
> Depending on the mmc device, some devices allow host to send more reqs
> to the device.

In that case, please add a patch for that too, to show how this is
going to be useful.

> Also, we use hsq->hsq_depth instead of immediate number "2" to make
> the code easier to understand.

Right, but we don't need a new member in struct mmc_host for that. We
could just be checking HSQ_MAX_DEPTH instead.

Kind regards
Uffe

>
> Thanks
> Wenchao.Chen
> > >
> > > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > > ---
> > >  drivers/mmc/core/queue.c   | 6 +-----
> > >  drivers/mmc/host/mmc_hsq.c | 1 +
> > >  drivers/mmc/host/mmc_hsq.h | 7 +++++++
> > >  include/linux/mmc/host.h   | 1 +
> > >  4 files changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > > index b396e3900717..a0a2412f62a7 100644
> > > --- a/drivers/mmc/core/queue.c
> > > +++ b/drivers/mmc/core/queue.c
> > > @@ -260,11 +260,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_m=
q_hw_ctx *hctx,
> > >                 }
> > >                 break;
> > >         case MMC_ISSUE_ASYNC:
> > > -               /*
> > > -                * For MMC host software queue, we only allow 2 reque=
sts in
> > > -                * flight to avoid a long latency.
> > > -                */
> > > -               if (host->hsq_enabled && mq->in_flight[issue_type] > =
2) {
> > > +               if (host->hsq_enabled && mq->in_flight[issue_type] > =
host->hsq_depth) {
> > >                         spin_unlock_irq(&mq->lock);
> > >                         return BLK_STS_RESOURCE;
> > >                 }
> > > diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> > > index 424dc7b07858..7b3952721c17 100644
> > > --- a/drivers/mmc/host/mmc_hsq.c
> > > +++ b/drivers/mmc/host/mmc_hsq.c
> > > @@ -337,6 +337,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_=
host *mmc)
> > >         hsq->mmc =3D mmc;
> > >         hsq->mmc->cqe_private =3D hsq;
> > >         mmc->cqe_ops =3D &mmc_hsq_ops;
> > > +       mmc->hsq_depth =3D HSQ_MAX_DEPTH;
> > >
> > >         for (i =3D 0; i < HSQ_NUM_SLOTS; i++)
> > >                 hsq->tag_slot[i] =3D HSQ_INVALID_TAG;
> > > diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> > > index 1808024fc6c5..795f6b9421d7 100644
> > > --- a/drivers/mmc/host/mmc_hsq.h
> > > +++ b/drivers/mmc/host/mmc_hsq.h
> > > @@ -5,6 +5,13 @@
> > >  #define HSQ_NUM_SLOTS  64
> > >  #define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
> > >
> > > +/*
> > > + * For MMC host software queue, we usually allow 2 requests in
> > > + * flight to avoid a long latency. But we can adjust hsq->depth
> > > + * according to the actual situation.
> > > + */
> > > +#define HSQ_MAX_DEPTH  2
> > > +
> > >  struct hsq_slot {
> > >         struct mmc_request *mrq;
> > >  };
> > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > index 461d1543893b..1fd8b1dd8698 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -520,6 +520,7 @@ struct mmc_host {
> > >
> > >         /* Host Software Queue support */
> > >         bool                    hsq_enabled;
> > > +       int                     hsq_depth;
> > >
> > >         u32                     err_stats[MMC_ERR_MAX];
> > >         unsigned long           private[] ____cacheline_aligned;
> > > --
> > > 2.17.1
> > >
