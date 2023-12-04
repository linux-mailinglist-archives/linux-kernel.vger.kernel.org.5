Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAE1803C88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjLDSOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjLDSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:13:59 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB299FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 10:14:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c07ed92fdso19124835e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701713643; x=1702318443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6Ysu3ckmP8RjbD8nV6PK1Q2tvFrfhEG4JhXPRcZ6h4=;
        b=dUUHa6RYmMlw45haIp7frEbwxgqhTedfSIhDquoIBX+H3DhIyhrFcbkcdYf1s5l4Fy
         lphSoPlWsx80O6rgtAA5sSz+JheuWJoPUOj2pLOJxuyVlFrdna4gN5WAGn7S5cB0KFxs
         LOiPA1MB2+HneZ7a9tSQ3iR/q5HGa57RRtp1c1dmLAHaibieJDN7oYgNkx+6B4cKE11p
         YOV5/zF2hVowpisJxOa8VAr3vw8X36KOCrup2YGwjJHTJNntZkeYgwQ/WJ6FZ01W7TmE
         QCGL6eq5VJcM2fX0Rg0HUErSmaSnPhpjLJYaUPfzHAjRJ/TjK/aAl5I93DxB0lXpInbB
         mp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713643; x=1702318443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6Ysu3ckmP8RjbD8nV6PK1Q2tvFrfhEG4JhXPRcZ6h4=;
        b=e5+4h/yMov0DSdIU0UXt/IOCQwx3+u5di/xG2YkIRnUgNsNhQxgRHdnRp5p7RKJdjc
         7CpY/u0m3JykbvZDKmfaUc3Suaya5eh69IrPmLZ9lvx7TCWvFSHeiP3aVqIWaTurOI43
         uafItzSIdjQHv0RmGn41mpuaUJ3+oAv2caq5bAEkVtR4pINB057askvpWjNSCCAXFxUd
         xsO0YJV8MN4hYkOyGjT/bY5GWl8vQmpy6e0ZvvnPUJOdh2BytWQCVPLojWA/W0Yoe7X6
         o1K9bKII0MH7qHrLtsOnSvCuQMAxnoDpoWZ7U4zFlavEFSRYuSy/abHqrk25weTz+ofH
         TyDg==
X-Gm-Message-State: AOJu0Yxh7V3P9mgQT7mXxT+XH9hYl7xY3WUzeEoX5voU8uDFt+u25C5b
        QqjQwfmOZVEEqaWK4+lIPAjZ7A==
X-Google-Smtp-Source: AGHT+IGrD0jC+jESi6/UMgWfWzJaBcMPfbF6HcomwTApBWi3OHeF9DSppgOU5mx7mEFv5Ca22KaP1Q==
X-Received: by 2002:a05:600c:4747:b0:40b:5e21:cc19 with SMTP id w7-20020a05600c474700b0040b5e21cc19mr2906475wmo.68.1701713643338;
        Mon, 04 Dec 2023 10:14:03 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600001c300b003333b8eb84fsm6916316wrx.113.2023.12.04.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:14:02 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Mon, 4 Dec 2023 19:14:01 +0100
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>,
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
Message-ID: <ZW4W6aZq+0DCmVTi@trax>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <DM6PR04MB657532850510D64BA7D62297FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB657532850510D64BA7D62297FC86A@DM6PR04MB6575.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/23 17:58:45, Avri Altman wrote:
> >
> > Requesting a retune before switching to the RPMB partition has been
> > observed to cause CRC errors on the RPMB reads (-EILSEQ).
> >
> > Since RPMB reads can not be retried, the clients would be directly affected by
> > the errors.
> >
> > This commit disables the request prior to RPMB switching while allowing the
> > pause interface to still request a retune before the pause for other use cases.
> >
> > This was verified with the sdhci-of-arasan driver (ZynqMP) configured for
> > HS200 using two separate eMMC cards (DG4064 and 064GB2). In both cases,
> > the error was easy to reproduce triggering every few tenths of reads.
> >
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  drivers/mmc/core/block.c | 2 +-
> >  drivers/mmc/core/host.c  | 7 ++++---
> >  drivers/mmc/core/host.h  | 2 +-
> >  3 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> > f9a5cffa64b1..1d69078ad9b2 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card
> > *card,
> >                         if (ret)
> >                                 return ret;
> >                 }
> > -               mmc_retune_pause(card->host);
> > +               mmc_retune_pause(card->host, false);
> >         }
> >
> >         return ret;
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> > 096093f7be00..a9b95aaa2235 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host *host)
> >
> >  /*
> >   * Pause re-tuning for a small set of operations.  The pause begins after the
> > - * next command and after first doing re-tuning.
> > + * next command and, if retune is set, after first doing re-tuning.
> >   */
> > -void mmc_retune_pause(struct mmc_host *host)
> > +void mmc_retune_pause(struct mmc_host *host, bool retune)
> >  {
> Since mmc_blk_part_switch_pre is the only caller of mmc_retune_pause,
> How about just move those lines into it?

+1 from me

I wasnt sure if there was some other plan for mmc_retune_pause in the
future hence why I didnt remove it and extended it instead.

Should I wait for Adrian's confirmation or just go ahead?.
