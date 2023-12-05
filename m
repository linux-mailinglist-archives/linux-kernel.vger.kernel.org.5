Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1752805B74
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345099AbjLEQKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjLEQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:10:01 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD0C122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:10:06 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3334a701cbbso2051492f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701792604; x=1702397404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cdrpO8C0nU4ljU4ooPjskl+QNi6RFyVvcGgF3Sty5jA=;
        b=Ba5MuIdF4U+NnpyoFjfElzDxb9c5FXXRQ1M49oAh1CfjMDF079zjnJRRwxaxjWoRWv
         RArBWuMaQ5oJYiYq+hhCK+bwo23gsLV5NfMglE3fqQvEkEh0XQ6pORaU6lS459FMH2D0
         KlHvd6aOTR2OJJe6v28AA0vzxRB598Ck8Nyi9edLQdSRW8DvRPSQHwPvVbxVEbCvX6Z/
         G9DouKbQChX5KYmvjXRIlw9dvfOT12xDw5nxrc7FdGpV6UHi5Ebv9zO/AwXuYdw6GAGH
         qwMJsZ+WN3hJjXR4AMwQ/tnB42DVnvDjMhWQst3nmaGTqnPze5TLk5qJ/2tIVmR3tGYx
         Afsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701792604; x=1702397404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdrpO8C0nU4ljU4ooPjskl+QNi6RFyVvcGgF3Sty5jA=;
        b=c9UUHpOac/JOZ5vBAyb0PBFBaqslAaaTbqm+/8GkEA1zzetIYJcM6PFGzcHzVAlEZk
         tDjEg2SwmdGUz+KLfgB3yR8gMOGv3pc8XwqzYGy8BAS4YVmdSRjK+3tuEUYBySI7QiLK
         HhfSXXJO92PaWD/PJd0tqY05BIgGw1TrPvBnScQr5rsXN2WoFNlURFOdiogU1uRmAMdm
         7t7SGsOJhLHyyOBgxbPixJmQq5YyF5K1aGblsVDsKby/wOzcKoewHuNBJK5l7igEyzGk
         5GMKtPE3n80zDyvVYIMwEU0IpmOIWPv//kn8MvXZBjZJFeXxa2KXkuaoIpzUM0JF5ctP
         OwIg==
X-Gm-Message-State: AOJu0YyB5WWFiTKSL692VayQ/3G5GS8bPB9XXwwV0/Hgnm5Kkc+MUBEa
        u9jXH9GIvbV5fwXo9+70bkajsg==
X-Google-Smtp-Source: AGHT+IGzKI/9qgICgI6hzaCZ6WXjGUwnD39wKIQydbCs838fDoa9j5N4kkchpcnNi9FNxJDE48HHUw==
X-Received: by 2002:a5d:5691:0:b0:332:ffdb:e9ad with SMTP id f17-20020a5d5691000000b00332ffdbe9admr3124222wrv.46.1701792604504;
        Tue, 05 Dec 2023 08:10:04 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600002a700b00332eb16d215sm14913576wry.23.2023.12.05.08.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:10:04 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Tue, 5 Dec 2023 17:10:02 +0100
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "christian.loehle@arm.com" <christian.loehle@arm.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
        "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
        "asuk4.q@gmail.com" <asuk4.q@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Message-ID: <ZW9LWrlYa2+lUcVc@trax>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <DM6PR04MB657532850510D64BA7D62297FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZW4W6aZq+0DCmVTi@trax>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW4W6aZq+0DCmVTi@trax>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/23 19:14:01, Jorge Ramirez-Ortiz, Foundries wrote:
> On 04/12/23 17:58:45, Avri Altman wrote:
> > >
> > > Requesting a retune before switching to the RPMB partition has been
> > > observed to cause CRC errors on the RPMB reads (-EILSEQ).
> > >
> > > Since RPMB reads can not be retried, the clients would be directly affected by
> > > the errors.
> > >
> > > This commit disables the request prior to RPMB switching while allowing the
> > > pause interface to still request a retune before the pause for other use cases.
> > >
> > > This was verified with the sdhci-of-arasan driver (ZynqMP) configured for
> > > HS200 using two separate eMMC cards (DG4064 and 064GB2). In both cases,
> > > the error was easy to reproduce triggering every few tenths of reads.
> > >
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > ---
> > >  drivers/mmc/core/block.c | 2 +-
> > >  drivers/mmc/core/host.c  | 7 ++++---
> > >  drivers/mmc/core/host.h  | 2 +-
> > >  3 files changed, 6 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > > f9a5cffa64b1..1d69078ad9b2 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card
> > > *card,
> > >                         if (ret)
> > >                                 return ret;
> > >                 }
> > > -               mmc_retune_pause(card->host);
> > > +               mmc_retune_pause(card->host, false);
> > >         }
> > >
> > >         return ret;
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> > > 096093f7be00..a9b95aaa2235 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host *host)
> > >
> > >  /*
> > >   * Pause re-tuning for a small set of operations.  The pause begins after the
> > > - * next command and after first doing re-tuning.
> > > + * next command and, if retune is set, after first doing re-tuning.
> > >   */
> > > -void mmc_retune_pause(struct mmc_host *host)
> > > +void mmc_retune_pause(struct mmc_host *host, bool retune)
> > >  {
> > Since mmc_blk_part_switch_pre is the only caller of mmc_retune_pause,
> > How about just move those lines into it?
>
> +1 from me
>
> I wasnt sure if there was some other plan for mmc_retune_pause in the
> future hence why I didnt remove it and extended it instead.
>
> Should I wait for Adrian's confirmation or just go ahead?.

just making sure this is not falling through the cracks.
