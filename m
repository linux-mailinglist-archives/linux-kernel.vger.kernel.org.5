Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10E380114D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378698AbjLARJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:09:12 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2A9106
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:09:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b4746ae51so22454115e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701450556; x=1702055356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPhfNDwTRads5r218R2Uh8KjrutNTJmZ0j4bM3wrzF8=;
        b=PEq+cjvqzkbtE4AxSAvfrpZ0hsEAg9eflvlPYZ2dFjH+4omO6MPtuM8aYC6VstLjZb
         5XHmxReqhe/+ne0bNA/ghzXzl0rrAnqk91Br7k9DnQ+KLjw+lMcnt1CS11153jG8aLXs
         S7QATm/BpXcnicCzIJdF+DjXYyffiT2wBf9SlPqI4A5+TmeEtlynPcxmH6BIOAjYNcT+
         WF6XMQjn5XXmUqRTsmV9lTuJbMdm4HF5onr+eWf4zVIxTt+Hay/fpYprdLKAKBFRMdtH
         9xdpQTHt3akY4G/prROhya8wq8vBM8iWcGINNHhb444xajmSUHaSuPqMkeUA89YwnUJJ
         9JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450556; x=1702055356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPhfNDwTRads5r218R2Uh8KjrutNTJmZ0j4bM3wrzF8=;
        b=YyQKAV6+zNAi7O6BbaigQ6K+cNUrA8FWxdBRB/K6rWzvCoEwAMb+BtXQu8k/1YGSMb
         7dRUDaBJD+xNcImiPENRbKgRnhcsHr3C64ANmcLKTuPKQft8VlK4K9rsk2NQWGi9HtaM
         fy0erGTcIJqWVDQqxIAmPjTXYqCI11cFLEZDCT9+lZgs1/J7Ah2iFRpVrrSauZ+oTsrd
         Amyk07dd8+PuIUOMoshrHkSLBR1fFy1orIs6vhI8HFsk0/sjJ1spYLSFBK+3dRG6zhVr
         LCGlfGEa2xDs8ykSi0gKOATFsRbe1nnaFcH3CfrC970bf+E/UXsYOzfoFzug/knFWK64
         45NA==
X-Gm-Message-State: AOJu0Yz3F2Zpc5kIdLlzx3z6wZbchrWGyAIHC64VunZ219vrSp6eB7pp
        SdN+JBe2KJQr75bfthYhZ/DFeQ==
X-Google-Smtp-Source: AGHT+IGVdgb0xWYcJ3Rp7W5064vBtZfPoNHYxUNgG14X4Lj+OIVzVmlTpLGA/KMDUuvmpYOVVzj7Tg==
X-Received: by 2002:a05:600c:518b:b0:40b:5e59:c582 with SMTP id fa11-20020a05600c518b00b0040b5e59c582mr498394wmb.172.1701450556458;
        Fri, 01 Dec 2023 09:09:16 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id t20-20020a05600c199400b0040b36ad5413sm5961421wmq.46.2023.12.01.09.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:09:15 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Fri, 1 Dec 2023 18:09:14 +0100
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, CLoehle@hyperstone.com,
        jinpu.wang@ionos.com, hare@suse.de,
        Ulf Hansson <ulf.hansson@linaro.org>, beanhuo@micron.com,
        yangyingliang@huawei.com, asuk4.q@gmail.com, yibin.ding@unisoc.com,
        victor.shih@genesyslogic.com.tw, marex@denx.de,
        rafael.beims@toradex.com, robimarko@gmail.com,
        ricardo@foundries.io, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Message-ID: <ZWoTOm+8Y75TLz6q@trax>
References: <20231129160533.2827458-1-jorge@foundries.io>
 <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
 <ZWiNDgUFF8ug7gZf@trax>
 <fbc82848-d402-4075-8176-de9ed0345d78@intel.com>
 <ZWkGZ7av1S4Clwdv@trax>
 <ZWkKgU+J9atnJdqT@trax>
 <ZWmN+k+wUWcXT5ID@trax>
 <fecd033b-b2ea-4906-a320-22a5c2ede46c@intel.com>
 <ZWoBqs/5m6tCuBGo@trax>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWoBqs/5m6tCuBGo@trax>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/23 16:54:18, Jorge Ramirez-Ortiz, Foundries wrote:
> On 01/12/23 13:46:25, Adrian Hunter wrote:
> > On 1/12/23 09:40, Jorge Ramirez-Ortiz, Foundries wrote:
> > > On 30/11/23 23:19:45, Jorge Ramirez-Ortiz, Foundries wrote:
> > >> On 30/11/23 23:02:15, Jorge Ramirez-Ortiz, Foundries wrote:
> > >>> On 30/11/23 21:12:28, Adrian Hunter wrote:
> > >>>> On 30/11/23 15:24, Jorge Ramirez-Ortiz, Foundries wrote:
> > >>>>> On 30/11/23 11:34:18, Ulf Hansson wrote:
> > >>>>>> On Wed, 29 Nov 2023 at 17:05, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> > >>>>>>>
> > >>>>>>> On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
> > >>>>>>> re-tune before switching to the RPMB partition would randomly cause
> > >>>>>>> subsequent RPMB requests to fail with EILSEQ:
> > >>>>>>> * data error -84, tigggered in __mmc_blk_ioctl_cmd()
> > >>>>>>>
> > >>>>>>> This commit skips the retune when switching to RPMB.
> > >>>>>>> Tested over several days with per minute RPMB reads.
> > >>>>>>
> > >>>>>> This sounds weird to me and needs more testing/debugging in my
> > >>>>>> opinion, especially at the host driver level. Perhaps add some new
> > >>>>>> tests in mmc_test, that does a partition switch to/from any partition
> > >>>>>> and then run regular I/O again to see if the problem is easier to
> > >>>>>> reproduce?
> > >>>>>
> > >>>>> hi Uffe
> > >>>>>
> > >>>>> ok I'll have a look - I have never used this driver before, so if you
> > >>>>> have anything in the works I'll be glad to integrated and adapt.
> > >>>>>
> > >>>>>>
> > >>>>>> The point is, I wonder what is so special with RPMB here? Note that,
> > >>>>>> it has been quite common that host drivers/controllers have had issues
> > >>>>>> with their tuning support, so I would not be surprised if that is the
> > >>>>>> case here too.
> > >>>>>
> > >>>>> Right, it is just that the tuning function for of-arasan is the generic
> > >>>>> __sdhci_execute_tuning() - only wrapped around arasan DLL reset
> > >>>>> calls. Hence why I aimed for the card: __sdhci_execute_tuning and ZynqMP
> > >>>>> are not recent functions or architectures.
> > >>>>>
> > >>>>>
> > >>>>>> Certainly I would be surprised if the problem is at
> > >>>>>> the eMMC card side, but I may be wrong.
> > >>>>>
> > >>>>> How do maintainers test the tuning methods? is there anything else for
> > >>>>> me to do other than forcing a retune with different partitions?
> > >>>>>
> > >>>>>>
> > >>>>>> Kind regards
> > >>>>>> Uffe
> > >>>>>
> > >>>>> For completeness this is the error message - notice that we have a
> > >>>>> trusted application (fiovb) going through OP-TEE and back to the TEE
> > >>>>> supplicant issuing an rpmb read of a variable (pretty normal these days,
> > >>>>> we use it on many different platforms - ST, NXP, AMD/Xilinx, TI..).
> > >>>>>
> > >>>>> The issue on this Zynqmp platform is scarily simple to reproduce; you
> > >>>>> can ignore the OP-TEE trace, it is just the TEE way of reporting that
> > >>>>> the RPMB read failed.
> > >>>>>
> > >>>>> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# fiovb_printenv m4hash
> > >>>>> [  461.775084] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> > >>>>> E/TC:? 0
> > >>>>> E/TC:? 0 TA panicked with code 0xffff0000
> > >>>>> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> > >>>>> E/LD:   arch: aarch64
> > >>>>> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
> > >>>>> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
> > >>>>> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
> > >>>>> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
> > >>>>> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
> > >>>>> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
> > >>>>> E/LD:  region  6: va 0xc0019000 pa 0x816b31fc8 size 0x001000 flags rw-- (param)
> > >>>>> E/LD:  region  7: va 0xc001a000 pa 0x816aa1fc8 size 0x002000 flags rw-- (param)
> > >>>>> E/LD:  region  8: va 0xc006b000 pa 0x00001000 size 0x014000 flags r-xs [0]
> > >>>>> E/LD:  region  9: va 0xc007f000 pa 0x00015000 size 0x008000 flags rw-s [0]
> > >>>>> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc006b000
> > >>>>> E/LD:  Call stack:
> > >>>>> E/LD:   0xc006de58
> > >>>>> E/LD:   0xc006b388
> > >>>>> E/LD:   0xc006ed40
> > >>>>> E/LD:   0xc006b624
> > >>>>> Read persistent value for m4hash failed: Exec format error
> > >>>>
> > >>>> Have you tried dynamic debug for mmc
> > >>>>
> > >>>>     Kernel must be configured:
> > >>>>
> > >>>>         CONFIG_DYNAMIC_DEBUG=y
> > >>>>
> > >>>>     To enable mmc debug via sysfs:
> > >>>>
> > >>>>         echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
> > >>>>         echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control
> > >>>>
> > >>>>
> > >>>
> > >>> hi Adrian
> > >>>
> > >>> Sure, this is the output of the trace:
> > >>>
> > >>> [  422.018756] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.018789] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.018817] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.018848] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.018875] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.018902] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.018932] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.020013] mmc0: sdhci: IRQ status 0x00000001
> > >>> [  422.020027] mmc0: sdhci: IRQ status 0x00000002
> > >>> [  422.020034] mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> > >>> [  422.020054] mmc0: starting CMD13 arg 00010000 flags 00000195
> > >>> [  422.020068] mmc0: sdhci: IRQ status 0x00000001
> > >>> [  422.020076] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> > >>> [  422.020092] <mmc0: starting CMD23 arg 00000001 flags 00000015>
> > >>> [  422.020101] mmc0: starting CMD25 arg 00000000 flags 00000035
> > >>> [  422.020108] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 400 ms nsac 0
> > >>> [  422.020124] mmc0: sdhci: IRQ status 0x00000001
> > >>> [  422.021671] mmc0: sdhci: IRQ status 0x00000002
> > >>> [  422.021691] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
> > >>> [  422.021700] mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> > >>> [  422.021708] mmc0:     512 bytes transferred: 0
> > >>> [  422.021728] mmc0: starting CMD13 arg 00010000 flags 00000195
> > >>> [  422.021743] mmc0: sdhci: IRQ status 0x00000001
> > >>> [  422.021752] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> > >>> [  422.021771] <mmc0: starting CMD23 arg 00000001 flags 00000015>
> > >>> [  422.021779] mmc0: starting CMD18 arg 00000000 flags 00000035
> > >>> [  422.021785] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
> > >>> [  422.021804] mmc0: sdhci: IRQ status 0x00000001
> > >>> [  422.022566] mmc0: sdhci: IRQ status 0x00208000 <---------------------------------- this doesnt seem right
> > >>> [  422.022629] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
> > >>> [  422.022639] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> > >>> [  422.022647] mmc0:     0 bytes transferred: -84 < --------------------------------- it should have transfered 4096 bytes
> > >>> [  422.022669] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> > >>> [  422.029619] mmc0: starting CMD6 arg 03b30001 flags 0000049d
> > >>> [  422.029636] mmc0: sdhci: IRQ status 0x00000001
> > >>> [  422.029652] mmc0: sdhci: IRQ status 0x00000002
> > >>> [  422.029660] mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> > >>> [  422.029680] mmc0: starting CMD13 arg 00010000 flags 00000195
> > >>> [  422.029693] mmc0: sdhci: IRQ status 0x00000001
> > >>> [  422.029702] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> > >>> [  422.196996] <mmc0: starting CMD23 arg 00000400 flags 00000015>
> > >>> [  422.197051] mmc0: starting CMD25 arg 058160e0 flags 000000b5
> > >>> [  422.197079] mmc0:     blksz 512 blocks 1024 flags 00000100 tsac 400 ms nsac 0
> > >>> [  422.197110] mmc0:     CMD12 arg 00000000 flags 0000049d
> > >>> [  422.199455] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.199526] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.199585] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.199641] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.199695] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.199753] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.199811] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.199865] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.199919] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.199972] mmc0: sdhci: IRQ status 0x00000020
> > >>> [  422.200026] mmc0: sdhci: IRQ status 0x00000020
> > >>>
> > >>>
> > >>> does this help?
> > >
> > > Just asking because it doesn't mean much to me other than the obvious CRC
> > > problem.
> > >
> > > Being this issue so easy to trigger - and to fix - indicates a problem
> > > on the card more than on the algorithm (otherwise faults would be all
> > > over the place). But I am not an expert on this area.
> > >
> > > any additional suggestions welcome.
> >
> > My guess is that sometimes tuning produces a "bad" result. Perhaps
> > the margins are very tight and the difference is only 1 tap.  When
> > a "bad" result happens in non-RPMB, a CRC error results in re-tuning
> > and retry, so no errors are seen.  When it happens in RPMB, that is
> > not possible, so the error is obvious.  Not re-tuning before RPMB
> > switch helps because the CRC-error->re-tuning to a "good" result has
> > probably already happened.
> >
> > However,  based on that theory, it is not necessary the eMMC that is
> > at fault.
> >
> > It may be worth considering a stronger eMMC driver strength setting.
>
> sure I can tune the value (just building now). however I am not sure
> about the implications - is there any negative consequence of increasing
> this value that I could monitor (if tests pass)?

ZynqMP does not set the property "fixed-emmc-driver-type" and since the
sdhci-of-arasan driver does not implement select_drive_strength() the
drive_strength setting is zero.

So AFAICS things are working accordingly - it is hard for me to say if
things should have been coded any differently.

> >
> > sdhci supports err_stats in debugfs - that may show how many CRC
> > errors there are when not accessing RPMB.
>
> ok
>
> >
> > I don't object to skipping re-tuning before RPMB switch, but I am
> > not sure about tying it to a specific eMMC.
>
> thanks. will follow up after further testing.

should I just repost the patch now skiping the retune for all cards
before switching to the RPMB partition? instead of using a quirk?

On this particular card it has now run for a couple of days so I am
confident that it addresses at the very least the symptom of the issue.


>
> >
