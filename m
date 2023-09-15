Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6117A1D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbjIOLiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjIOLiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:38:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CDB1FE5;
        Fri, 15 Sep 2023 04:38:16 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-773a0f36b4bso103957285a.0;
        Fri, 15 Sep 2023 04:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694777895; x=1695382695; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cxNDW2pc+qfPc4Lym4jAA6BiSnYn/+cC5qiOO1I7v58=;
        b=EYsmCAt4Ae1rhTl1lpZruHr2QmE5Tx0KCM+KMMNppJEqcAlBcPYul6CHq47Hn99RuO
         wv3vMspgxjrQv9RU5gRvdKi6SLqMCQQvR+XVhRcWhpV5H/VCRaPeBH2nILn7tySw7NfH
         FtvmO7KraB1e5P2bUqK5GLhDYU8YyWjA+lSO+SM4wOM+u0gUC5cr82tH4rDPDkGxRDSA
         EV1CkBIWCGevGkCEsQ278dJ9F6GNaMNeJRBvzomCVf53LBUM6+uFC3Xyr2u7sxdZMxHs
         FDOfe4rWQJeUZ4j5Bj6rlRo9XyzAAZBDM2XPsv32uAobPeB75QbEMzq+ZWrvZGcuzLaj
         tjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694777895; x=1695382695;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxNDW2pc+qfPc4Lym4jAA6BiSnYn/+cC5qiOO1I7v58=;
        b=r0WOB15X8qW3dy4aoOmhfTrxBKIrxiJ+X/7VxUhMrXtzWxHlvR7mY0uueWT0E7myqw
         U0mh132WhfA7aA+fkEDdWBwLNk6mHCNHePcVk7zs6MfnE0XQcjbSIEeHqKqABKaRtJx/
         VzN34AZcJgbIpTOBwLCPKtRCxGQ37v763Wf0UtBzTvGxzLk210ya/O9J2jala82JtSXe
         yazGrq/Ss9uFUYtNZ09cFW3ymu8ec5d9qf4/YQkNqt1HfQof+4uwQ5r9xuNf/Di63VoG
         D119ds0gCzUiAmabwPSpox2TymF2WqzVr/6yMRXl3yDovTgzow8ZsHhgd3MBHAbrd9ut
         qrig==
X-Gm-Message-State: AOJu0Ywqm/7CzdaMsfLb32wiR5H5lTkv3cyseYuC86z6Bd8rQtEy1w6z
        em3E4wVak8F+fTf9xYp7PGxpkffxLN5wn1lQe4OkoWqZkwg=
X-Google-Smtp-Source: AGHT+IHTWigqVTjsdMVBHh6tO8GXL+EP2oxt0yRo3g/Mb08HXd1floT5TyY+aHKV7+aAkaPtkD6TpNoKsilhpSBWiVY=
X-Received: by 2002:a0c:f14b:0:b0:647:35b7:4955 with SMTP id
 y11-20020a0cf14b000000b0064735b74955mr1440923qvl.52.1694777895308; Fri, 15
 Sep 2023 04:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230829020451.9828-1-wenchao.chen@unisoc.com>
 <20230829020451.9828-3-wenchao.chen@unisoc.com> <CAPDyKFo67SOWS3eYgEDKGOtmZJY5UtPw7+V0BEdkF_Y8yY2i5A@mail.gmail.com>
In-Reply-To: <CAPDyKFo67SOWS3eYgEDKGOtmZJY5UtPw7+V0BEdkF_Y8yY2i5A@mail.gmail.com>
From:   Wenchao Chen <wenchao.chen666@gmail.com>
Date:   Fri, 15 Sep 2023 19:38:04 +0800
Message-ID: <CA+Da2qx8XEGencXCj4EHquM2zB=dCp2c_DEa38EiWS5UAXP34w@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] mmc: hsq: dynamic adjustment of hsq->depth
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sept 2023 at 20:57, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 29 Aug 2023 at 04:05, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
> >
> > Increasing hsq_depth improves random write performance.
> >
> > Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> > ---
> >  drivers/mmc/host/mmc_hsq.c | 27 +++++++++++++++++++++++++++
> >  drivers/mmc/host/mmc_hsq.h |  5 +++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> > index 8556cacb21a1..0984c39108ba 100644
> > --- a/drivers/mmc/host/mmc_hsq.c
> > +++ b/drivers/mmc/host/mmc_hsq.c
> > @@ -21,6 +21,31 @@ static void mmc_hsq_retry_handler(struct work_struct *work)
> >         mmc->ops->request(mmc, hsq->mrq);
> >  }
> >
> > +static void mmc_hsq_modify_threshold(struct mmc_hsq *hsq)
> > +{
> > +       struct mmc_host *mmc = hsq->mmc;
> > +       struct mmc_request *mrq;
> > +       struct hsq_slot *slot;
> > +       int need_change = 0;
>
> Rather than using a variable to keep track of this, why not just do
> the below here?
>
> mmc->hsq_depth = HSQ_NORMAL_DEPTH;
>
> > +       int tag;
> > +
> > +       for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
> > +               slot = &hsq->slot[tag];
> > +               mrq = slot->mrq;
> > +               if (mrq && mrq->data &&
> > +                       (mrq->data->blksz * mrq->data->blocks == 4096) &&
> > +                       (mrq->data->flags & MMC_DATA_WRITE))
> > +                       need_change++;
>
> And following above, then we can do the below here:
> mmc->hsq_depth = HSQ_PERFORMANCE_DEPTH;
> break;
>
> That should simplify and make this more efficient too, right?
>

Yes, you are right. But need_change = 2, it means more reqs are allowed.
Alternatively, modify it like this:
mmc->hsq_depth = (need_change > 1)  ? HSQ_PERFORMANCE_DEPTH : HSQ_NORMAL_DEPTH;

> > +               else
> > +                       break;
> > +       }
> > +
> > +       if (need_change > 1)
> > +               mmc->hsq_depth = HSQ_PERFORMANCE_DEPTH;
> > +       else
> > +               mmc->hsq_depth = HSQ_NORMAL_DEPTH;
> > +}
> > +
>
> [...]
>
> Kind regards
> Uffe
