Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91695755F94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGQJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjGQJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:41:44 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BAC272E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:41:18 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-345f1e0abf9so17526945ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689586878; x=1692178878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IF5Aah0U1g916DJ+l1iWpmHzkGqlpNkBGwnHTBEuZww=;
        b=UIbeX87LwwFrQygQJhQ/Yu7TKbvISrBQDni4EvC+VURRpuYaZsNJIrNEbDLe+f04cu
         RXPx149WzU+HSQQrAoWRvhWzdHrsxD8sZX8DZxxn28lhPgsZj0evHeKsjNOuqJWI/qHO
         Awf3dnyStoMtJphco1KPn/7RuMkdgdAEldpxcZSB0MWbnUCUWVLdRaWFzXy2Dvri/CYF
         3F39/QZPIFcNHkcbZ7vS4iD0vIzvcL/YaOxzm7GJcRr1evUUzXnulpTqnKoXUXzvEKbb
         QHStYl8DxeKyqWTG9i1iidsIUafHtQjv8F22bhIwTUX6pJtRTQuH7XTW4mHoarrheAuT
         dL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586878; x=1692178878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IF5Aah0U1g916DJ+l1iWpmHzkGqlpNkBGwnHTBEuZww=;
        b=eKxQ6s2ryxcnOlEL6jVchvoOjKMfwcIJUTKHv/alLglFTXndaan1/xeclK9wSzcI2F
         eWZqEZNI7AEv36kjQtNzBr/jMVDxL71T+J2sAkuvKdpL2gfJAQ6vQGAnTKYx8+obaLdv
         Ob8GSroBdaBNSCaAdAF0zxg+HSmjMQqxBnHpzZaIjm0ai+Whq6O1TncvINzIUp7tEL88
         p7k5AAC3q/kNHOIQsmRMuc8p8AIXUQirtBikl/L8lOLnIIHb6V8yY9e9RFjqysU99iuf
         cZVxoM+Kdw677ka1vH4PnANwgKVWpRlhmLveF7eMtOhUcF3aHH15jnRTRoGCU+rZ1FOr
         nvdQ==
X-Gm-Message-State: ABy/qLaNM11Sqtm2sU0QOL3zTfFn8YgLv3mXsL2lRhqCNsnqDz08B0aS
        Dhl5yCdIIcplsea696/ZBS2a7Szpjw2dV34lcDM+1w==
X-Google-Smtp-Source: APBJJlGMzds1bJSLGCx1YHVmPa1DVVqmv75EbBcaxAnMJHZF2HJgyznpMOdSM9rT820s+QonFtlBW6HQkgThxHnuPEw=
X-Received: by 2002:a92:c9c3:0:b0:346:3be0:86e6 with SMTP id
 k3-20020a92c9c3000000b003463be086e6mr8977317ilq.30.1689586877989; Mon, 17 Jul
 2023 02:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230711152144.755177-1-Naresh.Solanki@9elements.com> <16080951-743c-4f3c-bec2-153ff38d922f@roeck-us.net>
In-Reply-To: <16080951-743c-4f3c-bec2-153ff38d922f@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Mon, 17 Jul 2023 15:11:07 +0530
Message-ID: <CABqG17ikQ4p0cVxhgfAxXgfTT7Zm5JDrjebrEyfwc-9Eyx3puA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (dimmtemp) Support more than 32 DIMMs
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter

On Sat, 15 Jul 2023 at 22:28, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Jul 11, 2023 at 05:21:43PM +0200, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > This patch introduces support for handling more than 32 DIMMs by
> > utilizing bitmap operations. The changes ensure that the driver can
> > handle a higher number of DIMMs efficiently.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> Applied to hwmon-next.
>
> Note: I got multiple versions of this patch. In the future
> please version your patches and provide change logs.
Sure thing. Thanks
~Naresh
>
> Thanks,
> Guenter
>
> > ---
> >  drivers/hwmon/peci/dimmtemp.c | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> >
> >
> > base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
> >
> > diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
> > index ed968401f93c..ce89da3937a0 100644
> > --- a/drivers/hwmon/peci/dimmtemp.c
> > +++ b/drivers/hwmon/peci/dimmtemp.c
> > @@ -219,19 +219,21 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
> >  {
> >       int chan_rank_max = priv->gen_info->chan_rank_max;
> >       int dimm_idx_max = priv->gen_info->dimm_idx_max;
> > -     u32 chan_rank_empty = 0;
> > -     u32 dimm_mask = 0;
> > -     int chan_rank, dimm_idx, ret;
> > +     DECLARE_BITMAP(dimm_mask, DIMM_NUMS_MAX);
> > +     DECLARE_BITMAP(chan_rank_empty, CHAN_RANK_MAX);
> > +
> > +     int chan_rank, dimm_idx, ret, i;
> >       u32 pcs;
> >
> > -     BUILD_BUG_ON(BITS_PER_TYPE(chan_rank_empty) < CHAN_RANK_MAX);
> > -     BUILD_BUG_ON(BITS_PER_TYPE(dimm_mask) < DIMM_NUMS_MAX);
> >       if (chan_rank_max * dimm_idx_max > DIMM_NUMS_MAX) {
> >               WARN_ONCE(1, "Unsupported number of DIMMs - chan_rank_max: %d, dimm_idx_max: %d",
> >                         chan_rank_max, dimm_idx_max);
> >               return -EINVAL;
> >       }
> >
> > +     bitmap_zero(dimm_mask, DIMM_NUMS_MAX);
> > +     bitmap_zero(chan_rank_empty, CHAN_RANK_MAX);
> > +
> >       for (chan_rank = 0; chan_rank < chan_rank_max; chan_rank++) {
> >               ret = peci_pcs_read(priv->peci_dev, PECI_PCS_DDR_DIMM_TEMP, chan_rank, &pcs);
> >               if (ret) {
> > @@ -242,7 +244,7 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
> >                        * detection to be performed at a later point in time.
> >                        */
> >                       if (ret == -EINVAL) {
> > -                             chan_rank_empty |= BIT(chan_rank);
> > +                             bitmap_set(chan_rank_empty, chan_rank, 1);
> >                               continue;
> >                       }
> >
> > @@ -251,7 +253,7 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
> >
> >               for (dimm_idx = 0; dimm_idx < dimm_idx_max; dimm_idx++)
> >                       if (__dimm_temp(pcs, dimm_idx))
> > -                             dimm_mask |= BIT(chan_rank * dimm_idx_max + dimm_idx);
> > +                             bitmap_set(dimm_mask, chan_rank * dimm_idx_max + dimm_idx, 1);
> >       }
> >
> >       /*
> > @@ -260,7 +262,7 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
> >        * host platform boot. Retrying a couple of times lets us make sure
> >        * that the state is persistent.
> >        */
> > -     if (chan_rank_empty == GENMASK(chan_rank_max - 1, 0)) {
> > +     if (bitmap_full(chan_rank_empty, chan_rank_max)) {
> >               if (priv->no_dimm_retry_count < NO_DIMM_RETRY_COUNT_MAX) {
> >                       priv->no_dimm_retry_count++;
> >
> > @@ -274,14 +276,16 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
> >        * It's possible that memory training is not done yet. In this case we
> >        * defer the detection to be performed at a later point in time.
> >        */
> > -     if (!dimm_mask) {
> > +     if (bitmap_empty(dimm_mask, DIMM_NUMS_MAX)) {
> >               priv->no_dimm_retry_count = 0;
> >               return -EAGAIN;
> >       }
> >
> > -     dev_dbg(priv->dev, "Scanned populated DIMMs: %#x\n", dimm_mask);
> > +     for_each_set_bit(i, dimm_mask, DIMM_NUMS_MAX) {
> > +             dev_dbg(priv->dev, "Found DIMM%#x\n", i);
> > +     }
> >
> > -     bitmap_from_arr32(priv->dimm_mask, &dimm_mask, DIMM_NUMS_MAX);
> > +     bitmap_copy(priv->dimm_mask, dimm_mask, DIMM_NUMS_MAX);
> >
> >       return 0;
> >  }
