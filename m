Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84347CEB78
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJRWtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjJRWty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:49:54 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C9115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:49:52 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9c687f83a2so2213972276.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697669392; x=1698274192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Itd3K+35Q5LCuuiQpkQ+hlfAcgIRYzc4goGel/0mjhk=;
        b=N0Vji/T8DW8QFf0c+EbGY/jy6gfJe+WrUi8hV8KG9ZMkVr6f6qUG7svg43G3GNmGtT
         0xsT1Gyu35vu89ecergNJ8k3KGzahpdpemBOwzYFWtkCMt/IVHPd+xen+muXNBeIwyft
         ASAyV9/WY4BVxzmYmyFHE/WNYlJYOQmkD1ngzQSDqJgAVqmt6Ok+0CkcN/W41OOLH0wr
         Qb4M3kye26wCzeFXez/2ln7mKqXTkOAyr2TxgWdcfo5ZPYQVTVhfxSd2/hntwRppMxNJ
         ZEDe2k02Hhb5hXNm8b7meQR8M5y/Ci5Irz7Re1hLRhEb2qifG/cy5NipKE/nzFKZH05Q
         OXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697669392; x=1698274192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Itd3K+35Q5LCuuiQpkQ+hlfAcgIRYzc4goGel/0mjhk=;
        b=Lc3SnRRnQtrG3HJkqBUKuTbvWgd4X0/L4J5ekb9bk6q7ubAWX9hQJYoMxo7Fot6oeE
         29OCUyx0EvW9sY2bPQZUOuSYFbn2/3zgrgsfRbL0LTiWyaUrzhEZU8/OmpoKI6IFvAeE
         Eiv9sob2Ivj2goIS5u8PtTQ6HKMMl+9HMg8nVZ7aYwqc0+WwrbsCs10ssnUDfxKgtsxT
         XQ/2AqqeG45wKjFnZWbj6WJwIsTdhH5s/xeeDrrn2uvFFExrN3Np1HkUPDGzfA9rIWtp
         TKzuUIhTtzvg/gfd1Rt3TiEbaB/lyojvldak8ajtHBuDFzAQzpdfNitUADfq5IPwCLE+
         6pKw==
X-Gm-Message-State: AOJu0YzG12NFHkMMWeAw2jRck4/TxJu2kUf8R+GG8Av5GfGLJHdO9RnL
        ZpnYPd/Yg9uYfnNZGVlWeZ2NYbbRAljpGvIngDg21E1+QHRZoxc8
X-Google-Smtp-Source: AGHT+IFMQne48Ci6124ZJ4/1HYU4EA0QRWtfa4ezFepMeZBntWk0+Ilj6fnvEHae0teXkx2uHfaLR4luXVeMdbtLFcE=
X-Received: by 2002:a5b:3ce:0:b0:d80:68d1:b826 with SMTP id
 t14-20020a5b03ce000000b00d8068d1b826mr732120ybp.6.1697669391762; Wed, 18 Oct
 2023 15:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231001194943.658299-1-beanhuo@iokpp.de> <CAPDyKFpgPEhVuTbxe5YhYQ0W6907SwJRxSQLB1F2FbVW3zKHxg@mail.gmail.com>
 <254df9b8ca7475ad9dbd3a303c60e1f99eca9c56.camel@iokpp.de> <CAPDyKFofJR0xtpmjCQXM7=VzUeN5jQLD2AZYEWocuyCnYNObYw@mail.gmail.com>
 <fbb29b88-7a16-4d3d-a96a-0256f6bcfc05@beims.me>
In-Reply-To: <fbb29b88-7a16-4d3d-a96a-0256f6bcfc05@beims.me>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 00:49:15 +0200
Message-ID: <CAPDyKFo2BGp+Wacz7cTAPZ7_Tkpy0St0AujWfiW=13P7fmrwhA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for Micron
 eMMC Q2J54A
To:     Rafael Beims <rafael@beims.me>
Cc:     Bean Huo <beanhuo@iokpp.de>, adrian.hunter@intel.com,
        beanhuo@micron.com, jakub.kwapisz@toradex.com,
        rafael.beims@toradex.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 at 18:05, Rafael Beims <rafael@beims.me> wrote:
>
> On 10/10/2023 18:04, Ulf Hansson wrote:
> > On Tue, 10 Oct 2023 at 17:33, Bean Huo <beanhuo@iokpp.de> wrote:
> >> Hi Ulf,
> >>
> >> thanks for your comments, I didn't quite get your points:
> >>
> >> On Tue, 2023-10-10 at 16:20 +0200, Ulf Hansson wrote:
> >>>> @@ -2381,8 +2381,11 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct
> >>>> mmc_queue *mq, struct request *req)
> >>>>                           }
> >>>>                           ret = mmc_blk_cqe_issue_flush(mq, req);
> >>>>                           break;
> >>>> -               case REQ_OP_READ:
> >>>>                   case REQ_OP_WRITE:
> >>>> +                       if (mmc_card_broken_cache_flush(card) &&
> >>>> !card->written_flag)
> >>> It looks superfluous to me to check mmc_card_broken_cache_flush() and
> >>> !card->written_flag. Just set the card->written_flag unconditionally.
> >> what did you mean "Just set the card->written_flag unconditionally."?
> >> This means I just need to check card->written_flag and set card-
> >>> written_flag to true and false in the case
> >> MMC_QUIRK_BROKEN_CACHE_FLUSH? or don't need to call
> >> mmc_card_broken_cache_flush()?
> > I mean skip the checks above and just do the assignment below.
> >
> >>>> +                               card->written_flag = true;
> >>>> +                       fallthrough;
> >>>> +               case REQ_OP_READ:
> >>>>                           if (host->cqe_enabled)
> >>>>                                   ret = mmc_blk_cqe_issue_rw_rq(mq,
> >>>> req);
> >>>>                           else
> >>>> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> >>>> index 4edf9057fa79..b7754a1b8d97 100644
> >>>> --- a/drivers/mmc/core/card.h
> >>>> +++ b/drivers/mmc/core/card.h
> >>>> @@ -280,4 +280,8 @@ static inline int
> >>>> mmc_card_broken_sd_cache(const struct mmc_card *c)
> >>>>           return c->quirks & MMC_QUIRK_BROKEN_SD_CACHE;
> >>>>    }
> >>>>
> >>>> +static inline int mmc_card_broken_cache_flush(const struct
> >>>> mmc_card *c)
> >>>> +{
> >>>> +       return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
> >>>> +}
> >>>>    #endif
> >>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >>>> index 89cd48fcec79..47896c32086e 100644
> >>>> --- a/drivers/mmc/core/mmc.c
> >>>> +++ b/drivers/mmc/core/mmc.c
> >>>> @@ -1929,6 +1929,8 @@ static int mmc_init_card(struct mmc_host
> >>>> *host, u32 ocr,
> >>>>           if (!oldcard)
> >>>>                   host->card = card;
> >>>>
> >>>> +       card->written_flag = false;
> >>>> +
> >>> How about doing this after a successful flush operation instead? In
> >>> other words in _mmc_flush_cache().
> >> Here initializes flag and the patch is intenting to eliminate the cache
> >> flush command before writing. what do you mean adding in
> >> mmc_flush_cache()?
> > mmc_init_card() is called while initializing and re-initializing the
> > card. So, it certainly works to reset the flag from here.
> >
> > However, _mmc_flush_cache() is called before powering off the card,
> > which then would work similarly to the above, but also gets called for
> > REQ_OP_FLUSH. Wouldn't that mean that we may be able to skip some
> > unnecessary/troublesome cache flush requests if we would reset the
> > flag from  mmc_flush_cache(), rather than from mmc_init_card()?
> >
> > Kind regards
> > Uffe
> Forgive me if I'm misunderstanding something, but wouldn't resetting the
> flag on _mmc_flush_cache()
> essentially disable cache when the MMC_QUIRK_BROKEN_CACHE_FLUSH is active?

It would, until after there has been a new I/O write. Is that a problem?

>
>  From what I see, the card->written flag is supposed to stay true until
> we need to reinitialize the
> eMMC again, otherwise we would be skipping cache flushes we don't want
> to skip. It's only before
> writing for the first time that we want to skip the flush.

If that's really what we want, that's perfectly okay to me. The commit
message isn't really clear about this, so I think that Bean could
improve that too.

I guess we need some kind of confirmation from Bean about this. Don't
get me wrong, I am happy to go with whatever approach as long as it's
clear *why* the selected approach is taken.

Kind regards
Uffe
