Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C175A82C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGTHuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjGTHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:50:12 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F52705
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:50:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76ad842d12fso9285285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689839406; x=1692431406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1eV0hd+WFxkT4H3WXsUaVe2R7jt2ve6HPlQS9R41YH8=;
        b=GMs/HCIP1qIQD+C0/O/gB/J1mV3W27NJeZnaZ5ct7CMkxtJ42hJ5sc5CQwU2KmqAaP
         xYtfz0h3E7kVwEZMgLEdfJmn1rlL6lsDFWVb1Nt4d+eZ23ZbaqsloiJtLcGlsTdFyS2+
         dLISSt6UapZ/jspR1KRWMQF8IQGVYiIb/GcgZNlASOAQZqsoiamhHVhdBD/p8/rZ9wjJ
         6iZWn4kZfa41Zq4lk+pbEl9EjyqBzh9t+4YYrEyX0hvZdRLVfOGgCNX43Z/A+4SdB6gN
         fptWiw87/J6OzxDHnT0bNAr2GVT6mAhyyPZviejPL5rrVk7qi7blvbnZ5zUX90SICQpt
         Ft9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689839406; x=1692431406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eV0hd+WFxkT4H3WXsUaVe2R7jt2ve6HPlQS9R41YH8=;
        b=B6pV9mJv4BhswqAAUID/xIYKGD/RRP7dlxH2kNXYy0N7uFbiVl/YNg48ZKzwlsfTOm
         nsRWTQult1ujYFOxv8J9sYnUAlmkchzVqRGClqvOiL5NPfr2uJ+TqQhe+Lzb/p7fcDPn
         mISb9kCi9sPoknVkTDPUkk3pD6VyWo8ub1pgk/UlQ34AM6KDtamy4nUhBNHTe4XCsli4
         xtHn6zJ1lUNxkQSIEsgjVL+RJlC2UVfRzSsb63hLvX+HGcR0kaQPuyuA/JIAJAMPYtq+
         N7fQeRuDjjvxW1BVOk7arAQLVbn6OUk1KWzYinA0BYXY72xTNnoqmtoI3vLPXNTWE8aS
         0Rkw==
X-Gm-Message-State: ABy/qLbIan8tuKiKizTdlK7pem3t6q6RF/SPdHb6gyCcyO5kwiA09JJP
        VHEpGbVj8/TLX3EYy3d1nXan+D+ROZkAKkl3Qum9rQ==
X-Google-Smtp-Source: APBJJlHZ7+nL7ZExwQUqkq/QE+5lrH731HZ8YomUjxHw0d37eIOj1GlXZFiHFn2tchtU0Slk2bOO8iCclO8GhcgNYhk=
X-Received: by 2002:a05:620a:8287:b0:768:14ee:2467 with SMTP id
 ox7-20020a05620a828700b0076814ee2467mr4610905qkn.66.1689839406157; Thu, 20
 Jul 2023 00:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230719184155.59375-1-Naresh.Solanki@9elements.com>
 <20230719184155.59375-3-Naresh.Solanki@9elements.com> <3a11291ea550744fb50f0e6359d4d8780e1c583a.camel@intel.com>
In-Reply-To: <3a11291ea550744fb50f0e6359d4d8780e1c583a.camel@intel.com>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 20 Jul 2023 13:19:55 +0530
Message-ID: <CABqG17g0mABdYz+2k_PWUaUrJ8_tJki8Z5CHZsymk4bc2At3Sw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] hwmon: (peci/dimmtemp) Add Sapphire Rapids support
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "Rudolph, Patrick" <patrick.rudolph@9elements.com>
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

Hi Iwona,

On Thu, 20 Jul 2023 at 01:35, Winiarska, Iwona
<iwona.winiarska@intel.com> wrote:
>
> On Wed, 2023-07-19 at 20:41 +0200, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > This patch extends the functionality of the hwmon (peci/dimmtemp) to
> > include support for Sapphire Rapids platform.
> >
> > Sapphire Rapids can accommodate up to 8 CPUs, each with 16 DIMMs. To
> > accommodate this configuration, the maximum supported DIMM count is
> > increased, and the corresponding Sapphire Rapids ID and threshold code
> > are added.
> >
> > The patch has been tested on a 4S system with 64 DIMMs installed.
> > Default thresholds are utilized for Sapphire Rapids, as accessing the
> > threshold requires accessing the UBOX device on Uncore bus 0, which can
> > only be achieved using MSR access. The non-PCI-compliant MMIO BARs are
> > not available for this purpose.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Changes in V3:
> > - Update Acked-by in commit message.
> > Changes in V2:
> > - Update subject.
> > ---
> >  drivers/hwmon/peci/dimmtemp.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
> > index ed968401f93c..edafbfd66fef 100644
> > --- a/drivers/hwmon/peci/dimmtemp.c
> > +++ b/drivers/hwmon/peci/dimmtemp.c
> > @@ -30,8 +30,10 @@
> >  #define DIMM_IDX_MAX_ON_ICX    2
> >  #define CHAN_RANK_MAX_ON_ICXD  4
> >  #define DIMM_IDX_MAX_ON_ICXD   2
> > +#define CHAN_RANK_MAX_ON_SPR   128
>
> Where was this number taken from?
> Single CPU has 8 channels (not 128), and dimmtemp hwmon binds to a single CPU.
>
> > +#define DIMM_IDX_MAX_ON_SPR    2
> >
> > -#define CHAN_RANK_MAX          CHAN_RANK_MAX_ON_HSX
> > +#define CHAN_RANK_MAX          CHAN_RANK_MAX_ON_SPR
>
> Then - there's no need for changing the MAX value.
>
> >  #define DIMM_IDX_MAX           DIMM_IDX_MAX_ON_HSX
> >  #define DIMM_NUMS_MAX          (CHAN_RANK_MAX * DIMM_IDX_MAX)
> >
> > @@ -530,6 +532,15 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int
> > dimm_order, int chan_rank, u
> >         return 0;
> >  }
> >
> > +static int
> > +read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int
> > chan_rank, u32 *data)
> > +{
> > +       /* Use defaults */
> > +       *data = (95 << 16) | (90 << 8);
> > +
> > +       return 0;
> > +}
> > +
>
> Rather than hardcoding the defaults, it should be possible to compute it in a
> similar way to ICX (and with that - commit message should be updated).
> We're starting from 1e:00.2 instead of 13:00.2, and offsets within IMC start
> from 0x219a8 with 0x8000 shift.
> It would look like this (note - not tested on actual SPR):
Thanks for the input. Will test & keep you posted.

Regards,
Naresh
>
> static int
> read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u32 *data)
> {
>         u32 reg_val;
>         u64 offset;
>         int ret;
>         u8 dev;
>
>         ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd4, &reg_val);
>         if (ret || !(reg_val & BIT(31)))
>                 return -ENODATA; /* Use default or previous value */
>
>         ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd0, &reg_val);
>         if (ret)
>                 return -ENODATA; /* Use default or previous value */
>
>         /*
>          * Device 26, Offset 219a8: IMC 0 channel 0 -> rank 0
>          * Device 26, Offset 299a8: IMC 0 channel 1 -> rank 1
>          * Device 27, Offset 219a8: IMC 1 channel 0 -> rank 2
>          * Device 27, Offset 299a8: IMC 1 channel 1 -> rank 3
>          * Device 28, Offset 219a8: IMC 2 channel 0 -> rank 4
>          * Device 28, Offset 299a8: IMC 2 channel 1 -> rank 5
>          * Device 29, Offset 219a8: IMC 3 channel 0 -> rank 6
>          * Device 29, Offset 299a8: IMC 3 channel 1 -> rank 7
>          */
>         dev = 26 + chan_rank / 2;
>         offset = 0x219a8 + dimm_order * 4 + (chan_rank % 2) * 0x8000;
>
>         ret = peci_mmio_read(priv->peci_dev, 0, GET_CPU_SEG(reg_val), GET_CPU_BUS(reg_val),
>                              dev, 0, offset, data);
>         if (ret)
>                 return ret;
>
>         return 0;
> }
>
> Thanks
> -Iwona
>
> >  static const struct dimm_info dimm_hsx = {
> >         .chan_rank_max  = CHAN_RANK_MAX_ON_HSX,
> >         .dimm_idx_max   = DIMM_IDX_MAX_ON_HSX,
> > @@ -572,6 +583,13 @@ static const struct dimm_info dimm_icxd = {
> >         .read_thresholds = &read_thresholds_icx,
> >  };
> >
> > +static const struct dimm_info dimm_spr = {
> > +       .chan_rank_max  = CHAN_RANK_MAX_ON_SPR,
> > +       .dimm_idx_max   = DIMM_IDX_MAX_ON_SPR,
> > +       .min_peci_revision = 0x40,
> > +       .read_thresholds = &read_thresholds_spr,
> > +};
> > +
> >  static const struct auxiliary_device_id peci_dimmtemp_ids[] = {
> >         {
> >                 .name = "peci_cpu.dimmtemp.hsx",
> > @@ -597,6 +615,10 @@ static const struct auxiliary_device_id
> > peci_dimmtemp_ids[] = {
> >                 .name = "peci_cpu.dimmtemp.icxd",
> >                 .driver_data = (kernel_ulong_t)&dimm_icxd,
> >         },
> > +       {
> > +               .name = "peci_cpu.dimmtemp.spr",
> > +               .driver_data = (kernel_ulong_t)&dimm_spr,
> > +       },
> >         { }
> >  };
> >  MODULE_DEVICE_TABLE(auxiliary, peci_dimmtemp_ids);
>
