Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B97D7C41FE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjJJVE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjJJVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:04:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8E091
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:04:54 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9a4c0d89f7so1699457276.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696971894; x=1697576694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0JPdI81s1g1jD64Q6FcuAIQKwcDv5/ca0TQcTmOhurM=;
        b=Os+bFrzjhKtV+ps1T390Qm8hpHMVq3LwUOgCgOVfUlkN3Q8TL8cVK0ReTu0o6Sq4JB
         2/wAEYVjoN2plvvMndkzomzIMsYozdssEUPQx5b5NS0wz5W3noHvSJMeB3mvmwW4oFnu
         FXMA4aVMjstZ4AvEWAcR736DnW62WaGhYP7aezjJK+/mPOITmfXCHoiGCLgiJlMl1pPv
         4/VpSq3O+EYV7x7Hk2TI1Gcp0UGmYE/x2oMdl689WUHUHorp56k2jfmOnjliti+CfnJ1
         Ck1dHaOiYmtG8dCclg7t2TwRqapvu4cr5BpQu4DHsSVTrUDDSJ6dPs0TqMpaY4VsTTmc
         Dm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696971894; x=1697576694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JPdI81s1g1jD64Q6FcuAIQKwcDv5/ca0TQcTmOhurM=;
        b=sQpfWpwGZ/ZTiV/ZVJ93ktH6o59CVTbVJ6do19nVU2wmo7E0p2hal03pjsuFo+5K1G
         SXm7JP94xv4suzx9YKiNdfCzJMlDOnanzcebjuWRSbp9jAkGu7dJnBNMQqoAoNs2qY63
         fOXFUYkDQuPDUbFbgVnDRRDSD7QA081hq+Tg2d9uZf4C/7sdSd0YtFik4463jWYwVlxe
         dRvxPuR79FOEB6Nl4tQ5WmMEdCzW6xiLv/fQlXgwuKlHf9anFIYcWH1jp40Bh6mYIgVz
         wtxHy3frnZhMm4H4BeY4lr/b4JN5ldD5gjZf3u88tlw/GrL6m8+8WVxog51e3qrjcIWQ
         mi/w==
X-Gm-Message-State: AOJu0Yx8xRDjI7gaEqNhdkaQLyXfvxBTG3QgPqLaDBljFoERrXI0uSTs
        588FuYn88MHalrZ3RWHYoLQhLs0a40OpOT/pxp943vSxcMT0oETPcFw=
X-Google-Smtp-Source: AGHT+IHuv4B4I/7pSOoU5p4zYXXxB+UnuU5+plZrypxjr00y7A8QvxFJzcakHp6OBM059ut4sqv1nhHOkk4zB/QCxkI=
X-Received: by 2002:a05:6902:707:b0:d84:afae:96a8 with SMTP id
 k7-20020a056902070700b00d84afae96a8mr23439973ybt.7.1696971893895; Tue, 10 Oct
 2023 14:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231001194943.658299-1-beanhuo@iokpp.de> <CAPDyKFpgPEhVuTbxe5YhYQ0W6907SwJRxSQLB1F2FbVW3zKHxg@mail.gmail.com>
 <254df9b8ca7475ad9dbd3a303c60e1f99eca9c56.camel@iokpp.de>
In-Reply-To: <254df9b8ca7475ad9dbd3a303c60e1f99eca9c56.camel@iokpp.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Oct 2023 23:04:16 +0200
Message-ID: <CAPDyKFofJR0xtpmjCQXM7=VzUeN5jQLD2AZYEWocuyCnYNObYw@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 at 17:33, Bean Huo <beanhuo@iokpp.de> wrote:
>
> Hi Ulf,
>
> thanks for your comments, I didn't quite get your points:
>
> On Tue, 2023-10-10 at 16:20 +0200, Ulf Hansson wrote:
> > > @@ -2381,8 +2381,11 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct
> > > mmc_queue *mq, struct request *req)
> > >                          }
> > >                          ret = mmc_blk_cqe_issue_flush(mq, req);
> > >                          break;
> > > -               case REQ_OP_READ:
> > >                  case REQ_OP_WRITE:
> > > +                       if (mmc_card_broken_cache_flush(card) &&
> > > !card->written_flag)
> >
> > It looks superfluous to me to check mmc_card_broken_cache_flush() and
> > !card->written_flag. Just set the card->written_flag unconditionally.
>
> what did you mean "Just set the card->written_flag unconditionally."?
> This means I just need to check card->written_flag and set card-
> >written_flag to true and false in the case
> MMC_QUIRK_BROKEN_CACHE_FLUSH? or don't need to call
> mmc_card_broken_cache_flush()?

I mean skip the checks above and just do the assignment below.

>
> >
> > > +                               card->written_flag = true;
> > > +                       fallthrough;
> > > +               case REQ_OP_READ:
> > >                          if (host->cqe_enabled)
> > >                                  ret = mmc_blk_cqe_issue_rw_rq(mq,
> > > req);
> > >                          else
> > > diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> > > index 4edf9057fa79..b7754a1b8d97 100644
> > > --- a/drivers/mmc/core/card.h
> > > +++ b/drivers/mmc/core/card.h
> > > @@ -280,4 +280,8 @@ static inline int
> > > mmc_card_broken_sd_cache(const struct mmc_card *c)
> > >          return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
> > >   }
> > >
> > > +static inline int mmc_card_broken_cache_flush(const struct
> > > mmc_card *c)
> > > +{
> > > +       return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
> > > +}
> > >   #endif
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index 89cd48fcec79..47896c32086e 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host
> > > *host, u32 ocr,
> > >          if (!oldcard)
> > >                  host->card = card;
> > >
> > > +       card->written_flag = false;
> > > +
> >
> > How about doing this after a successful flush operation instead? In
> > other words in _mmc_flush_cache().
>
> Here initializes flag and the patch is intenting to eliminate the cache
> flush command before writing. what do you mean adding in
> mmc_flush_cache()?

mmc_init_card() is called while initializing and re-initializing the
card. So, it certainly works to reset the flag from here.

However, _mmc_flush_cache() is called before powering off the card,
which then would work similarly to the above, but also gets called for
REQ_OP_FLUSH. Wouldn't that mean that we may be able to skip some
unnecessary/troublesome cache flush requests if we would reset the
flag from  mmc_flush_cache(), rather than from mmc_init_card()?

Kind regards
Uffe
