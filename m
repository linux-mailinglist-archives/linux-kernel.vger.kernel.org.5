Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0EB7FF009
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbjK3NY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345484AbjK3NY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:24:28 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F73199
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:24:34 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so12184221fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701350672; x=1701955472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rl1Zr3xVKLAcSLgsM15CyRFnl8qKQTSqrb43H8OFNJM=;
        b=P+NL4o6Ue+2rjNluwEcw+aJ1lWZMZ2GXAVxS3T0fx3CLjgYxtNgnHjeebjJzxI4LIA
         TmUYxAlluSpKvgpaOUppvYC0zWs0ni+NsiEciE3Nq/R1eDFzWBBqiURo6ozk4L1N5v++
         xfC7Wlk1ExeWhlWZFAAjP3v/Hr1BHu2YwUgu2e1N5N4WSA5QFt9lAFZmz39q0uodwvlQ
         2OyNwdeV/joofY9qsOvtUrlziETpHYZfhdqgz1qcGoWqOxMEzS1X978I5lBNzX5Ahcg9
         WECCYRgm4VYdPIAjPt5ZPRG4PpPe+LGWaO15/mFbj9/ZV62UL5xekEYYjcGjTiaj7y/S
         EsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701350672; x=1701955472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl1Zr3xVKLAcSLgsM15CyRFnl8qKQTSqrb43H8OFNJM=;
        b=OFmaLz6JDHER83kWxDHnnYds9ibOJt2eWOghoTy088A8J2twWFHEHyzPd37GlAKMz7
         1bphnMkFfSB9hZMRB2IMYErap2CBC+vOdLx2T6Q2NbsD3Qgq6xN443V2WPPvk1teWRKs
         V/1Ll9EhrD/76jgAnUARaP3Ws08X8nApMpiuMUxoor9YC/ZXhCNz/8J+qx5o0+tJmXpX
         U3ouLBxhmaem9ZVGR/EtWZPSmtb/E2jhIeslVq9uo+JFemDKmrKG+zIWn7z1wr7d8ja9
         OZZu9QpSiTkABGTjNZdDfTGI/1CpdVrNiOoo6bJ7Vfk6txRzT5hrO/OpBIzgWXqHc84d
         UWrw==
X-Gm-Message-State: AOJu0YxYBt8bcc6dLO6Iy09qhTf9rAfbDSptdqt052b+tE1isJnuBjZG
        WX3JKKdbiKsAjhFO7GSYhJ/zfg==
X-Google-Smtp-Source: AGHT+IFUdS0yevdMvat7JYL0oTGRcPHCkJOYSRpJSzMd3CfvSVDHUrv2frYyBgVJcQioN/5JVeLlVQ==
X-Received: by 2002:a2e:88c2:0:b0:2c9:c1f8:fa29 with SMTP id a2-20020a2e88c2000000b002c9c1f8fa29mr3192590ljk.33.1701350672122;
        Thu, 30 Nov 2023 05:24:32 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b0040b3d8907fesm1990114wmo.29.2023.11.30.05.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:24:31 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Thu, 30 Nov 2023 14:24:30 +0100
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>, CLoehle@hyperstone.com,
        adrian.hunter@intel.com, jinpu.wang@ionos.com, hare@suse.de,
        beanhuo@micron.com, yangyingliang@huawei.com, asuk4.q@gmail.com,
        yibin.ding@unisoc.com, victor.shih@genesyslogic.com.tw,
        marex@denx.de, rafael.beims@toradex.com, robimarko@gmail.com,
        ricardo@foundries.io, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Message-ID: <ZWiNDgUFF8ug7gZf@trax>
References: <20231129160533.2827458-1-jorge@foundries.io>
 <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/23 11:34:18, Ulf Hansson wrote:
> On Wed, 29 Nov 2023 at 17:05, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> >
> > On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
> > re-tune before switching to the RPMB partition would randomly cause
> > subsequent RPMB requests to fail with EILSEQ:
> > * data error -84, tigggered in __mmc_blk_ioctl_cmd()
> >
> > This commit skips the retune when switching to RPMB.
> > Tested over several days with per minute RPMB reads.
>
> This sounds weird to me and needs more testing/debugging in my
> opinion, especially at the host driver level. Perhaps add some new
> tests in mmc_test, that does a partition switch to/from any partition
> and then run regular I/O again to see if the problem is easier to
> reproduce?

hi Uffe

ok I'll have a look - I have never used this driver before, so if you
have anything in the works I'll be glad to integrated and adapt.

>
> The point is, I wonder what is so special with RPMB here? Note that,
> it has been quite common that host drivers/controllers have had issues
> with their tuning support, so I would not be surprised if that is the
> case here too.

Right, it is just that the tuning function for of-arasan is the generic
__sdhci_execute_tuning() - only wrapped around arasan DLL reset
calls. Hence why I aimed for the card: __sdhci_execute_tuning and ZynqMP
are not recent functions or architectures.


> Certainly I would be surprised if the problem is at
> the eMMC card side, but I may be wrong.

How do maintainers test the tuning methods? is there anything else for
me to do other than forcing a retune with different partitions?

>
> Kind regards
> Uffe

For completeness this is the error message - notice that we have a
trusted application (fiovb) going through OP-TEE and back to the TEE
supplicant issuing an rpmb read of a variable (pretty normal these days,
we use it on many different platforms - ST, NXP, AMD/Xilinx, TI..).

The issue on this Zynqmp platform is scarily simple to reproduce; you
can ignore the OP-TEE trace, it is just the TEE way of reporting that
the RPMB read failed.

root@uz3cg-dwg-sec:/var/rootdirs/home/fio# fiovb_printenv m4hash
[  461.775084] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
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
E/LD:  region  6: va 0xc0019000 pa 0x816b31fc8 size 0x001000 flags rw-- (param)
E/LD:  region  7: va 0xc001a000 pa 0x816aa1fc8 size 0x002000 flags rw-- (param)
E/LD:  region  8: va 0xc006b000 pa 0x00001000 size 0x014000 flags r-xs [0]
E/LD:  region  9: va 0xc007f000 pa 0x00015000 size 0x008000 flags rw-s [0]
E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc006b000
E/LD:  Call stack:
E/LD:   0xc006de58
E/LD:   0xc006b388
E/LD:   0xc006ed40
E/LD:   0xc006b624
Read persistent value for m4hash failed: Exec format error

Also I instrumented sdhci-of-arasan.c to confirm that tuning wasn't failing.

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 681ac4cab8ab..54cde79d2719 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1123,7 +1123,10 @@ static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode)

        err = sdhci_execute_tuning(mmc, opcode);
        if (err)
-           return err;
+         WARN_ON(1);
+
+ if (host->tuning_err)
+         WARN_ON(1);

        arasan_zynqmp_dll_reset(host, device_id);


Incidentally - not sure if it is intentional or not - I noticed that the
function arasan_zynqmp_execute_tuning(..) can not fail which seems wrong
(IMO it should also check host->tuning_err and not only err which will
always be 0).

Do you think this needs fixing even though not related to this problem?

TIA
Jorge

>
> >
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  Fixes v1: kernel test robot identified typo causing build failure
> >            CIF_MANFID_SANDISK_SD --> CID_MANFID_SANDISK_SD
> >
> >  drivers/mmc/core/block.c  | 6 +++++-
> >  drivers/mmc/core/card.h   | 7 +++++++
> >  drivers/mmc/core/quirks.h | 7 +++++++
> >  include/linux/mmc/card.h  | 1 +
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 152dfe593c43..9b7ba6562a3b 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -860,6 +860,11 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
> >                                 return ret;
> >                 }
> >                 mmc_retune_pause(card->host);
> > +
> > +               /* Do not force retune before RPMB switch */
> > +               if (mmc_can_retune(card->host) &&
> > +                   mmc_card_broken_rpmb_retune(card))
> > +                       card->host->need_retune = 0;
> >         }
> >
> >         return ret;
> > @@ -3143,4 +3148,3 @@ module_exit(mmc_blk_exit);
> >
> >  MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("Multimedia Card (MMC) block device driver");
> > -
> > diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> > index b7754a1b8d97..1e1555a15de9 100644
> > --- a/drivers/mmc/core/card.h
> > +++ b/drivers/mmc/core/card.h
> > @@ -85,6 +85,7 @@ struct mmc_fixup {
> >  #define CID_MANFID_MICRON       0x13
> >  #define CID_MANFID_SAMSUNG      0x15
> >  #define CID_MANFID_APACER       0x27
> > +#define CID_MANFID_SANDISK2     0x45
> >  #define CID_MANFID_KINGSTON     0x70
> >  #define CID_MANFID_HYNIX       0x90
> >  #define CID_MANFID_KINGSTON_SD 0x9F
> > @@ -284,4 +285,10 @@ static inline int mmc_card_broken_cache_flush(const struct mmc_card *c)
> >  {
> >         return c->quirks & MMC_QUIRK_BROKEN_CACHE_FLUSH;
> >  }
> > +
> > +static inline int mmc_card_broken_rpmb_retune(const struct mmc_card *c)
> > +{
> > +       return c->quirks & MMC_QUIRK_BROKEN_RPMB_RETUNE;
> > +}
> > +
> >  #endif
> > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > index cca71867bc4a..56c79b6b3537 100644
> > --- a/drivers/mmc/core/quirks.h
> > +++ b/drivers/mmc/core/quirks.h
> > @@ -130,6 +130,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
> >         MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> >                   MMC_QUIRK_BROKEN_SD_DISCARD),
> >
> > +       /*
> > +        * SanDisk iNAND 7250 DG4064, this quirk shall disable the retune
> > +        * operation enforced by default when switching to RPMB.
> > +        */
> > +       MMC_FIXUP("DG4064", CID_MANFID_SANDISK2, 0x100, add_quirk_mmc,
> > +                 MMC_QUIRK_BROKEN_RPMB_RETUNE),
> > +
> >         END_FIXUP
> >  };
> >
> > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > index 7b12eebc5586..bd6986189e8b 100644
> > --- a/include/linux/mmc/card.h
> > +++ b/include/linux/mmc/card.h
> > @@ -296,6 +296,7 @@ struct mmc_card {
> >  #define MMC_QUIRK_BROKEN_SD_DISCARD    (1<<14) /* Disable broken SD discard support */
> >  #define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
> >  #define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
> > +#define MMC_QUIRK_BROKEN_RPMB_RETUNE   (1<<17) /* Don't force a retune before switching to RPMB */
> >
> >         bool                    written_flag;   /* Indicates eMMC has been written since power on */
> >         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> > --
> > 2.34.1
