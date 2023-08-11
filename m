Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7276A778845
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbjHKHeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjHKHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:34:44 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3305812B;
        Fri, 11 Aug 2023 00:34:44 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63d48c3d242so10355326d6.2;
        Fri, 11 Aug 2023 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691739283; x=1692344083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7GcUPXQY9U36+/aaRDeoI7fgExGIaZH3ho2ralObws=;
        b=EAa8wpKxBuJIkvd/QqQ7qd4mtlizhCd6+wLT4qd6Jqg0cREuqjdYZDZ4rb2k05uMIF
         OTxGv6O80oK/Q5AfbJIg1M0VOJ4H9+6xVUPW68wcj+pU0Aq428ResIDex70ngo7qfisp
         1iUZODSoV4XnVr1+gsYZACvpa3wkOs0vQYJiBi56L6djc5u5Vkn9oCuaWhP/SDwLYrRz
         i2HgWPujlKj7xQQ6Ej3SvGCj2UgCOoybHpWSFux4hFLupK7Rzh/0QXGTgahX0ga68SA8
         t0xtndTZl1mnjj2QJoczNlOSu8bvpNZgVJq/rZLtfszoyxIJpuU24FByGlsMmk1RQBwT
         tQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739283; x=1692344083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u7GcUPXQY9U36+/aaRDeoI7fgExGIaZH3ho2ralObws=;
        b=k729AirkdamoDTWtDH2JZFyvG4K0NpUF9mkSRBl4M8dvaHK08aff9aZaYOtXmjyPEu
         glVULculhQhTMxntlBnPrrch3bgiDEegJbhuk/qi+sM5OMYC9PSKDzBPwejUud31gCdH
         ADdIuGy0UOcZAQZGhMimzJ3WUD+Ukg2N3xgvxM0DzctyOhQBTnPBFPv1aq+4nosHdJi4
         8cx+ezMzuGtf/ZUEbIm/+eO/72hl8s3R5AR3Z7Rv4V+T+NtX5TIhtkUOu4qIDRWhalSD
         sABVDK3dYxh8KQl5GyrW0VX/TANFDeosh8p4aZUbRh4z/AAnOfp1tUXCXcehXEXxXyBB
         Z/bA==
X-Gm-Message-State: AOJu0YwqUnJCRdruutnl5O+rjkdLwuwp/UAnXnxvb8wX6/zUA72X2Fxc
        emLcfvLQLDrXxvzsGUUY2XbcvyPh0AEz+Wj4Lzr6kUYsUMs=
X-Google-Smtp-Source: AGHT+IE24rh4VDB50qxGN5HNkPGlzPSXb9wToey+S0iK2s0b6wjc8VNvtHVilA6cio1vQeUsnGsCQS28nm6Uhqg5LJc=
X-Received: by 2002:a0c:ca84:0:b0:63f:be66:3c3b with SMTP id
 a4-20020a0cca84000000b0063fbe663c3bmr881709qvk.15.1691739283204; Fri, 11 Aug
 2023 00:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230803054544.22007-1-wenchao.chen@unisoc.com>
 <CAPDyKFrb_nH7w8Wjz3oxJ6Vj30W4-U=k2ST8O7aib_kSHBjsFw@mail.gmail.com>
 <CA+Da2qzyKxvkkJYcbeYUzF5+VuFMka1tGjkvv09uD8Y1tKZcfg@mail.gmail.com> <CAPDyKFp2Yp=7FjWreaxHb6nbF8MVaTNtiKR7wfUk=nsE5vVihg@mail.gmail.com>
In-Reply-To: <CAPDyKFp2Yp=7FjWreaxHb6nbF8MVaTNtiKR7wfUk=nsE5vVihg@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 11 Aug 2023 15:34:32 +0800
Message-ID: <CA+Da2qynMSjtKHEqD_U3nBfXPxO63kjy8b3hwcB3zOV3NZvfLA@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: replace immediate with hsq->depth
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 6:57=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Tue, 8 Aug 2023 at 12:41, Wenchao Chen <wenchao.chen666@gmail.com> wro=
te:
> >
> > On Tue, Aug 8, 2023 at 5:28=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> > >
> > > On Thu, 3 Aug 2023 at 07:46, Wenchao Chen <wenchao.chen@unisoc.com> w=
rote:
> > > >
> > > > Hsq is similar to cqe, using hsq->depth to represent
> > > > the maximum processing capacity of hsq. We can adjust
> > > > hsq->depth according to the actual situation.
> > >
> > > Sorry, but I don't quite follow here.
> > >
> > > Are you planning to update the host->hsq_depth dynamically from somew=
here?
> > >
> > > Kind regards
> > > Uffe
> > >
> > Hi Uffe,
> > Depending on the mmc device, some devices allow host to send more reqs
> > to the device.
>
> In that case, please add a patch for that too, to show how this is
> going to be useful.
>

OK, I'll update it in the next version.

> > Also, we use hsq->hsq_depth instead of immediate number "2" to make
> > the code easier to understand.
>
> Right, but we don't need a new member in struct mmc_host for that. We
> could just be checking HSQ_MAX_DEPTH instead.
>
> Kind regards
> Uffe
>

Using the definition of host in core makes it feel a little strange.

> >
> > Thanks
> > Wenchao.Chen
> > > >
> > > > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > > > ---
> > > >  drivers/mmc/core/queue.c   | 6 +-----
> > > >  drivers/mmc/host/mmc_hsq.c | 1 +
> > > >  drivers/mmc/host/mmc_hsq.h | 7 +++++++
> > > >  include/linux/mmc/host.h   | 1 +
> > > >  4 files changed, 10 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> > > > index b396e3900717..a0a2412f62a7 100644
> > > > --- a/drivers/mmc/core/queue.c
> > > > +++ b/drivers/mmc/core/queue.c
> > > > @@ -260,11 +260,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk=
_mq_hw_ctx *hctx,
> > > >                 }
> > > >                 break;
> > > >         case MMC_ISSUE_ASYNC:
> > > > -               /*
> > > > -                * For MMC host software queue, we only allow 2 req=
uests in
> > > > -                * flight to avoid a long latency.
> > > > -                */
> > > > -               if (host->hsq_enabled && mq->in_flight[issue_type] =
> 2) {
> > > > +               if (host->hsq_enabled && mq->in_flight[issue_type] =
> host->hsq_depth) {
> > > >                         spin_unlock_irq(&mq->lock);
> > > >                         return BLK_STS_RESOURCE;
> > > >                 }
> > > > diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.=
c
> > > > index 424dc7b07858..7b3952721c17 100644
> > > > --- a/drivers/mmc/host/mmc_hsq.c
> > > > +++ b/drivers/mmc/host/mmc_hsq.c
> > > > @@ -337,6 +337,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mm=
c_host *mmc)
> > > >         hsq->mmc =3D mmc;
> > > >         hsq->mmc->cqe_private =3D hsq;
> > > >         mmc->cqe_ops =3D &mmc_hsq_ops;
> > > > +       mmc->hsq_depth =3D HSQ_MAX_DEPTH;
> > > >
> > > >         for (i =3D 0; i < HSQ_NUM_SLOTS; i++)
> > > >                 hsq->tag_slot[i] =3D HSQ_INVALID_TAG;
> > > > diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.=
h
> > > > index 1808024fc6c5..795f6b9421d7 100644
> > > > --- a/drivers/mmc/host/mmc_hsq.h
> > > > +++ b/drivers/mmc/host/mmc_hsq.h
> > > > @@ -5,6 +5,13 @@
> > > >  #define HSQ_NUM_SLOTS  64
> > > >  #define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
> > > >
> > > > +/*
> > > > + * For MMC host software queue, we usually allow 2 requests in
> > > > + * flight to avoid a long latency. But we can adjust hsq->depth
> > > > + * according to the actual situation.
> > > > + */
> > > > +#define HSQ_MAX_DEPTH  2
> > > > +
> > > >  struct hsq_slot {
> > > >         struct mmc_request *mrq;
> > > >  };
> > > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > > index 461d1543893b..1fd8b1dd8698 100644
> > > > --- a/include/linux/mmc/host.h
> > > > +++ b/include/linux/mmc/host.h
> > > > @@ -520,6 +520,7 @@ struct mmc_host {
> > > >
> > > >         /* Host Software Queue support */
> > > >         bool                    hsq_enabled;
> > > > +       int                     hsq_depth;
> > > >
> > > >         u32                     err_stats[MMC_ERR_MAX];
> > > >         unsigned long           private[] ____cacheline_aligned;
> > > > --
> > > > 2.17.1
> > > >
