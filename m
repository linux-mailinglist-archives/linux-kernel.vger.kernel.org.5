Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6728A806B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377360AbjLFKAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377306AbjLFKAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:00:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D071112
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:00:50 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c08af319cso40714285e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701856849; x=1702461649; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KGQoaoJoZxLt1J6/kFo/TAtvqWVdczlg7GhNIGrfcqE=;
        b=Bq+dYj/86k57IR8CYNBf0ZpbxcEEoWwoAAAne//dgh5/Qf5T98l27xrNY9++IhNJvp
         AHl3EGFddTzadFZVaiHdF32P2be0ooeDTLe01gWh9dqAxPTDC4mrlJxh55agZrGy82l6
         eje5yVstDMFSVf/x52IpJMDcP81QgqFSD0SCAnIEieMNB0QpU74kE7tJ8obSgdrc3PtZ
         0l5+wBdzkPwog0RaS4XeHIpi3Ci8DGhtV6zfVqKRXRX1VoGdo/G1zz9Urr0dtuLEQ9lQ
         M10SpEbXqcdxAdJIcavG3uO5LJj1luwChEU7s2bhgFIp7Sdl9Wxn1QGZmu6pVv+zWglr
         kMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701856849; x=1702461649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGQoaoJoZxLt1J6/kFo/TAtvqWVdczlg7GhNIGrfcqE=;
        b=th/QqmJ82dbiif2uC43lEyrmEmCDjVTYfpr26kKGjmvrdkGPmEYstqQf3IgWfZz8A0
         DGrZbgZ6hr9y3Jae5zSywGw1BVlxqyNlEk3mG6mZz2m45KFdjMou90n3IjFzqoXji21G
         00uMjKPNzskZurokC0rvtL7kE6jMhG0VqTrL/7UXcvTW21hQGfF4r5OsUU6/a0TWOU8I
         U1WNrFFL35JDCuiQCgwWYes1BHv9U5n8r1qKzrmyFjAS6zkrPQUeI7K+9EdK5cNGPTAq
         ibGNpaC9IwGhDLCZNxcXD7LwmQ8cUSYIQ8oIQUs6TTHW958T7mtKJSq9s1hA29KtKeo3
         MjPQ==
X-Gm-Message-State: AOJu0YxOgYob2vLRc2ua7CAb92TuLH0p982fhH9vsNkDwd1qHzpd60O8
        rMxcmrTT9yn+Ke6USF8kRTuFCw==
X-Google-Smtp-Source: AGHT+IHUjiVLZvCAPEuPR+lbzrMXb79EVmegSafWM2YBr7+iOPvqMUPeya4MQ34whvxgbMZ042ebnQ==
X-Received: by 2002:a05:600c:444b:b0:40b:5e21:ec1e with SMTP id v11-20020a05600c444b00b0040b5e21ec1emr420301wmn.80.1701856849263;
        Wed, 06 Dec 2023 02:00:49 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id p23-20020a05600c1d9700b0040b47c69d08sm1287240wms.18.2023.12.06.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:00:48 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Wed, 6 Dec 2023 11:00:47 +0100
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jorge Ramirez-Ortiz <jorge@foundries.io>,
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
Message-ID: <ZXBGTxS7sUSILtLs@trax>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/23 07:02:43, Avri Altman wrote:
> >
> > On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
> > > Requesting a retune before switching to the RPMB partition has been
> > > observed to cause CRC errors on the RPMB reads (-EILSEQ).
> >
> > There are still 2 concerns:
> > 1) We don't really know the root cause.  Have you determined if here are
> > CRC errors in the main partition also?

right, and I don't disagree with that.

As a test I created a 4GB file from /dev/random which I then copied
several times (dd if= ....)

root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0# cat err_stats
# Command Timeout Occurred:      0
# Command CRC Errors Occurred:   0
# Data Timeout Occurred:         0
# Data CRC Errors Occurred:      0
# Auto-Cmd Error Occurred:       0
# ADMA Error Occurred:   0
# Tuning Error Occurred:         0
# CMDQ RED Errors:       0
# CMDQ GCE Errors:       0
# CMDQ ICCE Errors:      0
# Request Timedout:      0
# CMDQ Request Timedout:         0
# ICE Config Errors:     0
# Controller Timedout errors:    0
# Unexpected IRQ errors:         0

However as soon as I access RPMB and fails (it takes just a few tries) I see:

I/TC: RPMB: Using generated key
[   86.902118] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
E/TC:? 0
E/TC:? 0 TA panicked with code 0xffff0000
E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
E/LD:   arch: aarch64
E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
E/LD:  region  6: va 0xc0019000 pa 0x818ea9ba8 size 0x002000 flags rw-- (param)
E/LD:  region  7: va 0xc001b000 pa 0x818e97ba8 size 0x001000 flags rw-- (param)
E/LD:  region  8: va 0xc004f000 pa 0x00001000 size 0x014000 flags r-xs [0]
E/LD:  region  9: va 0xc0063000 pa 0x00015000 size 0x008000 flags rw-s [0]
E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc004f000
E/LD:  Call stack:
E/LD:   0xc0051a14
E/LD:   0xc004f31c
E/LD:   0xc0052d40
E/LD:   0xc004f624

root@uz3cg-dwg-sec:/var/rootdirs/home/fio# cat /sys/kernel/debug/mmc0/err_stats
# Command Timeout Occurred:      0
# Command CRC Errors Occurred:   0
# Data Timeout Occurred:         0
# Data CRC Errors Occurred:      1
# Auto-Cmd Error Occurred:       0
# ADMA Error Occurred:   0
# Tuning Error Occurred:         0
# CMDQ RED Errors:       0
# CMDQ GCE Errors:       0
# CMDQ ICCE Errors:      0
# Request Timedout:      0
# CMDQ Request Timedout:         0
# ICE Config Errors:     0
# Controller Timedout errors:    0
# Unexpected IRQ errors:         0

> > 2) Forcing this on everyone
> >
> > The original idea was that because re-tuning cannot be done in RPMB, the
> > need to re-rune in RPMB could be avoided by always re-tuning before
> > switching to RPMB and then switching straight back. IIRC re-tuning should
> > guarantee at least 4MB more I/O without issue.
> Performance is hardly an issue in the context of RPMB access -
> For most cases it’s a single frame.

Yes, the security use case typically stores hashes, variables
(bootcount, upgrade_available, versions, that sort of thing) and
certificates in RPMB.

Since you mentioned, I am seeing that tuning before switching to RPMB
has an impact on performance. As a practical test, just reading a 6 byte
variable incurs in 50ms penalty in kernel space due to the need to
retune 5 times. Not great since the request is coming from a Trusted
Application via OP-TEE through the supplicant meaning this TEE thread
(they are statically allocated CFG_NUM_THREADS) will be reserved for
quite a bit of time.

Roughly:
TA --> OP-TEE (core) --> TEE-supplicant --> Kernel (>50ms) --> OP-TEE --> TA

Adrian, I couldn't find the original performance justification for
enabling this feature globally. At which point do you think it becomes
beneficial to retune before accessing RPMB?

>
> Thanks,
> Avri
>
> >
> > The alternative to dropping re-tuning in this case could be to add a retry loop
> > for MMC_DRV_OP_IOCTL_RPMB if the error is -EILSEQ

For the security use case I mentioned above - even if it didn't end up in
the occasional CRC errors - I honestly see little value: dropping the
feature - or controlling it via CFG_ - seems more logical to me. Would you
agree?

> >
> >
> > >
> > > Since RPMB reads can not be retried, the clients would be directly
> > > affected by the errors.
> > >
> > > This commit disables the request prior to RPMB switching while
> > > allowing the pause interface to still request a retune before the
> > > pause for other use cases.
> > >
> > > This was verified with the sdhci-of-arasan driver (ZynqMP) configured
> > > for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
> > > cases, the error was easy to reproduce triggering every few tenths of
> > > reads.
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
> > > @@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct
> > mmc_card *card,
> > >                       if (ret)
> > >                               return ret;
> > >               }
> > > -             mmc_retune_pause(card->host);
> > > +             mmc_retune_pause(card->host, false);
> > >       }
> > >
> > >       return ret;
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c index
> > > 096093f7be00..a9b95aaa2235 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host
> > *host)
> > >
> > >  /*
> > >   * Pause re-tuning for a small set of operations.  The pause begins
> > > after the
> > > - * next command and after first doing re-tuning.
> > > + * next command and, if retune is set, after first doing re-tuning.
> > >   */
> > > -void mmc_retune_pause(struct mmc_host *host)
> > > +void mmc_retune_pause(struct mmc_host *host, bool retune)
> > >  {
> > >       if (!host->retune_paused) {
> > >               host->retune_paused = 1;
> > > -             mmc_retune_needed(host);
> > > +             if (retune)
> > > +                     mmc_retune_needed(host);
> >
> > Better to just drop mmc_retune_needed(host);
> >
> > >               mmc_retune_hold(host);
> >
> > There is still a small chance that re-tuning is needed anyway in which case it
> > will still be done.
> >
> > >       }
> > >  }
> > > diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h index
> > > 48c4952512a5..321776b52270 100644
> > > --- a/drivers/mmc/core/host.h
> > > +++ b/drivers/mmc/core/host.h
> > > @@ -18,7 +18,7 @@ void mmc_retune_disable(struct mmc_host *host);
> > > void mmc_retune_hold(struct mmc_host *host);  void
> > > mmc_retune_release(struct mmc_host *host);  int mmc_retune(struct
> > > mmc_host *host); -void mmc_retune_pause(struct mmc_host *host);
> > > +void mmc_retune_pause(struct mmc_host *host, bool retune);
> > >  void mmc_retune_unpause(struct mmc_host *host);
> > >
> > >  static inline void mmc_retune_clear(struct mmc_host *host)
>
