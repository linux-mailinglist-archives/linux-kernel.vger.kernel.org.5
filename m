Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0207FFE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377092AbjK3WCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377065AbjK3WCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:02:38 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6019BF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:02:19 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bc39dcbcbso2047824e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 14:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701381737; x=1701986537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYMwO+rRmEQXl88wag+AKHza9dXHerPXsEEU1KzlOvY=;
        b=D5ckXEjuLlIsWhDPTjYDtTV2OkjL+pT/+gAyZDDjJBhowcmkk8KNedCZnPjIywCDDY
         ngYnea2X4jYgwr9kEVkjvI/afw/9FX5jhU83Q96NLx3YTYB6nPS0LW8UZRgAsFv1/Rrk
         kWuWupvEF69ndvXxvdaD4VFx7K+kUxlua4Dmd64gII08YU1UdN/O8Kw7pXf65q8csyrU
         IxaZx6If888saAJIAqBlL91bGOCatz/O82WU3qdc9hRCo9Jmh6cxL7t6zhyEy3S/66HC
         551dt4OecOIhwovbINOsKUVNewNLNPWM4ZEB8AN5U1tqIe0k74nOPTKf9wub8ZrGC1VM
         BhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701381737; x=1701986537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYMwO+rRmEQXl88wag+AKHza9dXHerPXsEEU1KzlOvY=;
        b=EQtP+LWFzL8tyqGrsmH8FNfFaAHBB/QTboTZKaKeBZndg13Qf3frOK7BxIuG+70QKp
         tO8Pm6W3J8xNDJXaCpX+JJ+zifFeiYr9VF2qXf9lblZ2c6VzGLnBAynJOOyJwNYcxUQG
         /80Odr7Dv3358Gf27HT+FaG3Myg05TXVNdCwzFRuW0qVsbhdCHFA9kpKxt4mZretsapf
         4/s4+ELhnAoC8zbhOk/aIT+sBr5qyRXSYCe42dv5htnMkfW3JSLyk+fqjQSn+6WSz3dC
         QCeh1wP6jOVkmrNpn2s+CdGKVUGmRGseSTLeeQjkGlp1MpH73W8obndiU7jNvM5TTwNG
         OZZw==
X-Gm-Message-State: AOJu0YydHJUMF68xGQVsiA/+W1LRiFImwvkMVfvoXFTEw/TuACUCHNw4
        kfqWHWf1COYSIZ2vImUjJrMgGg==
X-Google-Smtp-Source: AGHT+IEXm8+12jrUz+d4LJM/yXxie+fj9XzFN3dO0PefeI3HoXt4cW6N7hr7foM/lCYhDxxgnmy+5A==
X-Received: by 2002:a19:7006:0:b0:50a:a6d2:b59b with SMTP id h6-20020a197006000000b0050aa6d2b59bmr127452lfc.50.1701381737507;
        Thu, 30 Nov 2023 14:02:17 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id r5-20020a05600c35c500b0040b54335d57sm6513091wmq.17.2023.11.30.14.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:02:17 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Thu, 30 Nov 2023 23:02:15 +0100
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        CLoehle@hyperstone.com, jinpu.wang@ionos.com, hare@suse.de,
        Ulf Hansson <ulf.hansson@linaro.org>, beanhuo@micron.com,
        yangyingliang@huawei.com, asuk4.q@gmail.com, yibin.ding@unisoc.com,
        victor.shih@genesyslogic.com.tw, marex@denx.de,
        rafael.beims@toradex.com, robimarko@gmail.com,
        ricardo@foundries.io, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Message-ID: <ZWkGZ7av1S4Clwdv@trax>
References: <20231129160533.2827458-1-jorge@foundries.io>
 <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
 <ZWiNDgUFF8ug7gZf@trax>
 <fbc82848-d402-4075-8176-de9ed0345d78@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbc82848-d402-4075-8176-de9ed0345d78@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/23 21:12:28, Adrian Hunter wrote:
> On 30/11/23 15:24, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 30/11/23 11:34:18, Ulf Hansson wrote:
> >> On Wed, 29 Nov 2023 at 17:05, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> >>>
> >>> On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
> >>> re-tune before switching to the RPMB partition would randomly cause
> >>> subsequent RPMB requests to fail with EILSEQ:
> >>> * data error -84, tigggered in __mmc_blk_ioctl_cmd()
> >>>
> >>> This commit skips the retune when switching to RPMB.
> >>> Tested over several days with per minute RPMB reads.
> >>
> >> This sounds weird to me and needs more testing/debugging in my
> >> opinion, especially at the host driver level. Perhaps add some new
> >> tests in mmc_test, that does a partition switch to/from any partition
> >> and then run regular I/O again to see if the problem is easier to
> >> reproduce?
> >
> > hi Uffe
> >
> > ok I'll have a look - I have never used this driver before, so if you
> > have anything in the works I'll be glad to integrated and adapt.
> >
> >>
> >> The point is, I wonder what is so special with RPMB here? Note that,
> >> it has been quite common that host drivers/controllers have had issues
> >> with their tuning support, so I would not be surprised if that is the
> >> case here too.
> >
> > Right, it is just that the tuning function for of-arasan is the generic
> > __sdhci_execute_tuning() - only wrapped around arasan DLL reset
> > calls. Hence why I aimed for the card: __sdhci_execute_tuning and ZynqMP
> > are not recent functions or architectures.
> >
> >
> >> Certainly I would be surprised if the problem is at
> >> the eMMC card side, but I may be wrong.
> >
> > How do maintainers test the tuning methods? is there anything else for
> > me to do other than forcing a retune with different partitions?
> >
> >>
> >> Kind regards
> >> Uffe
> >
> > For completeness this is the error message - notice that we have a
> > trusted application (fiovb) going through OP-TEE and back to the TEE
> > supplicant issuing an rpmb read of a variable (pretty normal these days,
> > we use it on many different platforms - ST, NXP, AMD/Xilinx, TI..).
> >
> > The issue on this Zynqmp platform is scarily simple to reproduce; you
> > can ignore the OP-TEE trace, it is just the TEE way of reporting that
> > the RPMB read failed.
> >
> > root@uz3cg-dwg-sec:/var/rootdirs/home/fio# fiovb_printenv m4hash
> > [  461.775084] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> > E/TC:? 0
> > E/TC:? 0 TA panicked with code 0xffff0000
> > E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> > E/LD:   arch: aarch64
> > E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
> > E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
> > E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
> > E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
> > E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
> > E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
> > E/LD:  region  6: va 0xc0019000 pa 0x816b31fc8 size 0x001000 flags rw-- (param)
> > E/LD:  region  7: va 0xc001a000 pa 0x816aa1fc8 size 0x002000 flags rw-- (param)
> > E/LD:  region  8: va 0xc006b000 pa 0x00001000 size 0x014000 flags r-xs [0]
> > E/LD:  region  9: va 0xc007f000 pa 0x00015000 size 0x008000 flags rw-s [0]
> > E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc006b000
> > E/LD:  Call stack:
> > E/LD:   0xc006de58
> > E/LD:   0xc006b388
> > E/LD:   0xc006ed40
> > E/LD:   0xc006b624
> > Read persistent value for m4hash failed: Exec format error
>
> Have you tried dynamic debug for mmc
>
>     Kernel must be configured:
>
>         CONFIG_DYNAMIC_DEBUG=y
>
>     To enable mmc debug via sysfs:
>
>         echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
>         echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control
>
>

hi Adrian

Sure, this is the output of the trace:

[  422.018756] mmc0: sdhci: IRQ status 0x00000020
[  422.018789] mmc0: sdhci: IRQ status 0x00000020
[  422.018817] mmc0: sdhci: IRQ status 0x00000020
[  422.018848] mmc0: sdhci: IRQ status 0x00000020
[  422.018875] mmc0: sdhci: IRQ status 0x00000020
[  422.018902] mmc0: sdhci: IRQ status 0x00000020
[  422.018932] mmc0: sdhci: IRQ status 0x00000020
[  422.020013] mmc0: sdhci: IRQ status 0x00000001
[  422.020027] mmc0: sdhci: IRQ status 0x00000002
[  422.020034] mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[  422.020054] mmc0: starting CMD13 arg 00010000 flags 00000195
[  422.020068] mmc0: sdhci: IRQ status 0x00000001
[  422.020076] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  422.020092] <mmc0: starting CMD23 arg 00000001 flags 00000015>
[  422.020101] mmc0: starting CMD25 arg 00000000 flags 00000035
[  422.020108] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 400 ms nsac 0
[  422.020124] mmc0: sdhci: IRQ status 0x00000001
[  422.021671] mmc0: sdhci: IRQ status 0x00000002
[  422.021691] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
[  422.021700] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
[  422.021708] mmc0:     512 bytes transferred: 0
[  422.021728] mmc0: starting CMD13 arg 00010000 flags 00000195
[  422.021743] mmc0: sdhci: IRQ status 0x00000001
[  422.021752] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  422.021771] <mmc0: starting CMD23 arg 00000001 flags 00000015>
[  422.021779] mmc0: starting CMD18 arg 00000000 flags 00000035
[  422.021785] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
[  422.021804] mmc0: sdhci: IRQ status 0x00000001
[  422.022566] mmc0: sdhci: IRQ status 0x00208000
[  422.022629] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
[  422.022639] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[  422.022647] mmc0:     0 bytes transferred: -84
[  422.022669] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
[  422.029619] mmc0: starting CMD6 arg 03b30001 flags 0000049d
[  422.029636] mmc0: sdhci: IRQ status 0x00000001
[  422.029652] mmc0: sdhci: IRQ status 0x00000002
[  422.029660] mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
[  422.029680] mmc0: starting CMD13 arg 00010000 flags 00000195
[  422.029693] mmc0: sdhci: IRQ status 0x00000001
[  422.029702] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  422.196996] <mmc0: starting CMD23 arg 00000400 flags 00000015>
[  422.197051] mmc0: starting CMD25 arg 058160e0 flags 000000b5
[  422.197079] mmc0:     blksz 512 blocks 1024 flags 00000100 tsac 400 ms nsac 0
[  422.197110] mmc0:     CMD12 arg 00000000 flags 0000049d
[  422.199455] mmc0: sdhci: IRQ status 0x00000020
[  422.199526] mmc0: sdhci: IRQ status 0x00000020
[  422.199585] mmc0: sdhci: IRQ status 0x00000020
[  422.199641] mmc0: sdhci: IRQ status 0x00000020
[  422.199695] mmc0: sdhci: IRQ status 0x00000020
[  422.199753] mmc0: sdhci: IRQ status 0x00000020
[  422.199811] mmc0: sdhci: IRQ status 0x00000020
[  422.199865] mmc0: sdhci: IRQ status 0x00000020
[  422.199919] mmc0: sdhci: IRQ status 0x00000020
[  422.199972] mmc0: sdhci: IRQ status 0x00000020
[  422.200026] mmc0: sdhci: IRQ status 0x00000020


does this help?

thanks
Jorge
