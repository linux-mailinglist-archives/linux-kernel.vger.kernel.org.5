Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0777740D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjHHRLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjHHRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:10:44 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8CB1B531;
        Tue,  8 Aug 2023 09:04:24 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-585fd99ed8bso97769747b3.1;
        Tue, 08 Aug 2023 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510661; x=1692115461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge4UpGsqgeWYVTzHHgiNtZ1FFA8wffVk7bme0ep5yV8=;
        b=F815O/mLLDKqliVgjT/GxSLDKtwSKdQ/yDIInEaueB2N54jEGaRdqTajiSGARkkGsA
         u5X+yyOODshgYP8BotYsuP1TxJDHRlYoYooMkdiD7bEeHUp+oEtN7AvdagCkFXrORn5m
         DChd1+fUPE+ga+6P/m7EqcmtyfMr2GIVzvLWjoB7D3QN4l/P28cRc2bEP7iCeWi+1KXI
         lxEXKK+Ntt0vH+r9cJwGfFIP6Jx3B4p9y603lSHYs2E5oZ96nrxwMg4SAmVuIWXjaYM7
         RtcQa8TaE8deeN/1fT7f/+tapQlp+FoMEvit/qFLBCt9fQaaBmwwzwNO22IjfQHzxk2g
         vibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510661; x=1692115461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge4UpGsqgeWYVTzHHgiNtZ1FFA8wffVk7bme0ep5yV8=;
        b=HHkeLPiOWow8PXicXZrvAKmI0K/8K9G/8HHg+xteAyOrrE1nhw5W3EBoZSYCsdvO69
         IXSQSlPgay62ZLeGNvqFynuWfpIO+J3LcmqDz7ibCwn/jttVMw+WavY2ZHrvQQ9N/bsS
         KpKgv976lnTOy1fjf+Dml0ivbPibCkSUZDiYC08EP2bitsMEjce2Ntun/WCdXhBOW9EJ
         B+U5fYOBUVMxg5CdNeSC96jl21ma3ccXavS4bckSaMiVsP7hEIMydy1bh2nAIRFGxp5R
         9M6bHXXDCt+GQO4VkICIPfAyfMkZknS9A1dkjhUxmHtLKzIOYI9a3YuhwCzxPk3OwTCJ
         ilQg==
X-Gm-Message-State: AOJu0YzrV5jz3pSAInKX3qub71q+Ky2otloxu6uHhofjTRkrsvMzy/yi
        1rKUHcEiTek2Yzw3pk9NFhoJBBRFGtnPc2MAEYAz7ApnCL8=
X-Google-Smtp-Source: AGHT+IEjnyGdAyrJUFEAHV8lW6LrCsMS7v6CycxWtVxzjsBRdvzUp8pQlt4w9mAfh175Goj255eodkxuvJwA61+Jle4=
X-Received: by 2002:a0c:9a49:0:b0:63c:c72e:6762 with SMTP id
 q9-20020a0c9a49000000b0063cc72e6762mr10418001qvd.9.1691491300456; Tue, 08 Aug
 2023 03:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230803054544.22007-1-wenchao.chen@unisoc.com> <CAPDyKFrb_nH7w8Wjz3oxJ6Vj30W4-U=k2ST8O7aib_kSHBjsFw@mail.gmail.com>
In-Reply-To: <CAPDyKFrb_nH7w8Wjz3oxJ6Vj30W4-U=k2ST8O7aib_kSHBjsFw@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Tue, 8 Aug 2023 18:41:28 +0800
Message-ID: <CA+Da2qzyKxvkkJYcbeYUzF5+VuFMka1tGjkvv09uD8Y1tKZcfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: replace immediate with hsq->depth
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 5:28=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Thu, 3 Aug 2023 at 07:46, Wenchao Chen <wenchao.chen@unisoc.com> wrote=
:
> >
> > Hsq is similar to cqe, using hsq->depth to represent
> > the maximum processing capacity of hsq. We can adjust
> > hsq->depth according to the actual situation.
>
> Sorry, but I don't quite follow here.
>
> Are you planning to update the host->hsq_depth dynamically from somewhere=
?
>
> Kind regards
> Uffe
>
Hi Uffe,
Depending on the mmc device, some devices allow host to send more reqs
to the device.
Also, we use hsq->hsq_depth instead of immediate number "2" to make
the code easier to understand.

Thanks
Wenchao.Chen
> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >  drivers/mmc/core/queue.c   | 6 +-----
> >  drivers/mmc/host/mmc_hsq.c | 1 +
> >  drivers/mmc/host/mmc_hsq.h | 7 +++++++
> >  include/linux/mmc/host.h   | 1 +
> >  4 files changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > index b396e3900717..a0a2412f62a7 100644
> > --- a/drivers/mmc/core/queue.c
> > +++ b/drivers/mmc/core/queue.c
> > @@ -260,11 +260,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_=
hw_ctx *hctx,
> >                 }
> >                 break;
> >         case MMC_ISSUE_ASYNC:
> > -               /*
> > -                * For MMC host software queue, we only allow 2 request=
s in
> > -                * flight to avoid a long latency.
> > -                */
> > -               if (host->hsq_enabled && mq->in_flight[issue_type] > 2)=
 {
> > +               if (host->hsq_enabled && mq->in_flight[issue_type] > ho=
st->hsq_depth) {
> >                         spin_unlock_irq(&mq->lock);
> >                         return BLK_STS_RESOURCE;
> >                 }
> > diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> > index 424dc7b07858..7b3952721c17 100644
> > --- a/drivers/mmc/host/mmc_hsq.c
> > +++ b/drivers/mmc/host/mmc_hsq.c
> > @@ -337,6 +337,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_ho=
st *mmc)
> >         hsq->mmc =3D mmc;
> >         hsq->mmc->cqe_private =3D hsq;
> >         mmc->cqe_ops =3D &mmc_hsq_ops;
> > +       mmc->hsq_depth =3D HSQ_MAX_DEPTH;
> >
> >         for (i =3D 0; i < HSQ_NUM_SLOTS; i++)
> >                 hsq->tag_slot[i] =3D HSQ_INVALID_TAG;
> > diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> > index 1808024fc6c5..795f6b9421d7 100644
> > --- a/drivers/mmc/host/mmc_hsq.h
> > +++ b/drivers/mmc/host/mmc_hsq.h
> > @@ -5,6 +5,13 @@
> >  #define HSQ_NUM_SLOTS  64
> >  #define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
> >
> > +/*
> > + * For MMC host software queue, we usually allow 2 requests in
> > + * flight to avoid a long latency. But we can adjust hsq->depth
> > + * according to the actual situation.
> > + */
> > +#define HSQ_MAX_DEPTH  2
> > +
> >  struct hsq_slot {
> >         struct mmc_request *mrq;
> >  };
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 461d1543893b..1fd8b1dd8698 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -520,6 +520,7 @@ struct mmc_host {
> >
> >         /* Host Software Queue support */
> >         bool                    hsq_enabled;
> > +       int                     hsq_depth;
> >
> >         u32                     err_stats[MMC_ERR_MAX];
> >         unsigned long           private[] ____cacheline_aligned;
> > --
> > 2.17.1
> >
