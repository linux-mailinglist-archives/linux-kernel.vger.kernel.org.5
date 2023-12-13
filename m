Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B99480CF08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343986AbjLKPGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjLKPGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:06:00 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F5DC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:06:04 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35d77fb7d94so19297515ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1702307164; x=1702911964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lzf4DhCznlzcRBcUtHso1avw0yzP0AXiQHuu6/xM1CE=;
        b=MMuu3LERA3QqPSPIidLGOwvKG0IqeIkE1MQjwrmZbjv7dqX2T+oKaTSr8gJJ747c2O
         ofzGvbbe/kGK07VKTCl1zjVKirxM3H8bRUpkT+onicTZmpbK+vTyHkQOqbrCv14+IL/u
         WZQlTLGdftQFCLUTcH1w0xFeKFfRLE8FkZxOAb7hYLcKXgt+mENUgghTf4KB5DsGEodf
         m5dbivhNZIZeEDl+b8TFS9cmL55h7pZ3yKhgN0wHcdDmOT2mFh7QoE/tRkFjdsSn+pEV
         P79qAlOxay9Xk+JA/OAPFpNDmJTr8V+EzqE5Y4SrA06VOhEDe+qfpPpxeVBm1U+37azV
         kCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702307164; x=1702911964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lzf4DhCznlzcRBcUtHso1avw0yzP0AXiQHuu6/xM1CE=;
        b=E0ovHvnM0ro4rk2ySI4AyMkd3+9jBOst2pDSq6VfZASTtG6pxVxrp9FQvoLeZh1ta7
         mgDDlBRbX05s4w53UT//JBD3kMreGtxUmbBDW70kZjS2t4mny3KhjBUszHVPaIyLvNye
         TC4rExmfLcJ37F2uOYs9ir+EMnzm60P87vnggh8oMThRXIuZMpJkBPfiswjaEfjzPEtX
         PRFWojCTfq31dMsrhPRmJFOcrukYllAPGoN7iswxN7s+c+UZg8M4wumeU1tke+SwOE55
         dOA3FiOVfZfgU6tTtcee6Ts49KZJ9xxYpZzZvg4FqEFm9wq39TdGZY5jXcj7A8bUcm+H
         6vqg==
X-Gm-Message-State: AOJu0YwOSdyhJQdRYJQ4YkcVE98lU6a9OXhLunnczGYlp3Wbg09L0/gw
        IkkGlJ76yUBU4DtqEtWoP84EQg==
X-Google-Smtp-Source: AGHT+IE9/QvjSFV0EMlnfpHlhLeX8UBfSFDksie9UvyigW45srnVy/2SALxcVpApu1QlmKwdofAFWQ==
X-Received: by 2002:a05:6e02:b22:b0:35d:5995:1d66 with SMTP id e2-20020a056e020b2200b0035d59951d66mr8633833ilu.43.1702307163781;
        Mon, 11 Dec 2023 07:06:03 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id z10-20020a92bf0a000000b0035c72480f1esm2348914ilh.83.2023.12.11.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:06:03 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Mon, 11 Dec 2023 16:05:58 +0100
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        Avri Altman <Avri.Altman@wdc.com>,
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
Message-ID: <ZXclVpvpx0sV2Hcn@trax>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZXBGTxS7sUSILtLs@trax>
 <ZXbBhjZIn5sj6EYO@trax>
 <7443a730-411a-4dd3-b911-241356493516@intel.com>
 <ZXbtS9KKQY+vk7Mq@trax>
 <a0eb3547-9bdc-40e0-8861-1d8beec50a78@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0eb3547-9bdc-40e0-8861-1d8beec50a78@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/23 13:32:57, Adrian Hunter wrote:
> On 11/12/23 13:06, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 11/12/23 12:25:19, Adrian Hunter wrote:
> >> On 11/12/23 10:00, Jorge Ramirez-Ortiz, Foundries wrote:
> >>> On 06/12/23 11:00:47, Jorge Ramirez-Ortiz, Foundries wrote:
> >>>> On 06/12/23 07:02:43, Avri Altman wrote:
> >>>>>>
> >>>>>> On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
> >>>>>>> Requesting a retune before switching to the RPMB partition has been
> >>>>>>> observed to cause CRC errors on the RPMB reads (-EILSEQ).
> >>>>>>
> >>>>>> There are still 2 concerns:
> >>>>>> 1) We don't really know the root cause.  Have you determined if here are
> >>>>>> CRC errors in the main partition also?
> >>>>
> >>>> right, and I don't disagree with that.
> >>>>
> >>>> As a test I created a 4GB file from /dev/random which I then copied
> >>>> several times (dd if= ....)
> >>>>
> >>>> root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0# cat err_stats
> >>>> # Command Timeout Occurred:      0
> >>>> # Command CRC Errors Occurred:   0
> >>>> # Data Timeout Occurred:         0
> >>>> # Data CRC Errors Occurred:      0
> >>>> # Auto-Cmd Error Occurred:       0
> >>>> # ADMA Error Occurred:   0
> >>>> # Tuning Error Occurred:         0
> >>>> # CMDQ RED Errors:       0
> >>>> # CMDQ GCE Errors:       0
> >>>> # CMDQ ICCE Errors:      0
> >>>> # Request Timedout:      0
> >>>> # CMDQ Request Timedout:         0
> >>>> # ICE Config Errors:     0
> >>>> # Controller Timedout errors:    0
> >>>> # Unexpected IRQ errors:         0
> >>>>
> >>>> However as soon as I access RPMB and fails (it takes just a few tries) I see:
> >>>>
> >>>> I/TC: RPMB: Using generated key
> >>>> [   86.902118] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> >>>> E/TC:? 0
> >>>> E/TC:? 0 TA panicked with code 0xffff0000
> >>>> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> >>>> E/LD:   arch: aarch64
> >>>> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
> >>>> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
> >>>> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
> >>>> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
> >>>> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
> >>>> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
> >>>> E/LD:  region  6: va 0xc0019000 pa 0x818ea9ba8 size 0x002000 flags rw-- (param)
> >>>> E/LD:  region  7: va 0xc001b000 pa 0x818e97ba8 size 0x001000 flags rw-- (param)
> >>>> E/LD:  region  8: va 0xc004f000 pa 0x00001000 size 0x014000 flags r-xs [0]
> >>>> E/LD:  region  9: va 0xc0063000 pa 0x00015000 size 0x008000 flags rw-s [0]
> >>>> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc004f000
> >>>> E/LD:  Call stack:
> >>>> E/LD:   0xc0051a14
> >>>> E/LD:   0xc004f31c
> >>>> E/LD:   0xc0052d40
> >>>> E/LD:   0xc004f624
> >>>>
> >>>> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# cat /sys/kernel/debug/mmc0/err_stats
> >>>> # Command Timeout Occurred:      0
> >>>> # Command CRC Errors Occurred:   0
> >>>> # Data Timeout Occurred:         0
> >>>> # Data CRC Errors Occurred:      1
> >>>> # Auto-Cmd Error Occurred:       0
> >>>> # ADMA Error Occurred:   0
> >>>> # Tuning Error Occurred:         0
> >>>> # CMDQ RED Errors:       0
> >>>> # CMDQ GCE Errors:       0
> >>>> # CMDQ ICCE Errors:      0
> >>>> # Request Timedout:      0
> >>>> # CMDQ Request Timedout:         0
> >>>> # ICE Config Errors:     0
> >>>> # Controller Timedout errors:    0
> >>>> # Unexpected IRQ errors:         0
> >>>>
> >>>>>> 2) Forcing this on everyone
> >>>>>>
> >>>>>> The original idea was that because re-tuning cannot be done in RPMB, the
> >>>>>> need to re-rune in RPMB could be avoided by always re-tuning before
> >>>>>> switching to RPMB and then switching straight back. IIRC re-tuning should
> >>>>>> guarantee at least 4MB more I/O without issue.
> >>>>> Performance is hardly an issue in the context of RPMB access -
> >>>>> For most cases it’s a single frame.
> >>>>
> >>>> Yes, the security use case typically stores hashes, variables
> >>>> (bootcount, upgrade_available, versions, that sort of thing) and
> >>>> certificates in RPMB.
> >>>>
> >>>> Since you mentioned, I am seeing that tuning before switching to RPMB
> >>>> has an impact on performance. As a practical test, just reading a 6 byte
> >>>> variable incurs in 50ms penalty in kernel space due to the need to
> >>>> retune 5 times. Not great since the request is coming from a Trusted
> >>>> Application via OP-TEE through the supplicant meaning this TEE thread
> >>>> (they are statically allocated CFG_NUM_THREADS) will be reserved for
> >>>> quite a bit of time.
> >>>>
> >>>> Roughly:
> >>>> TA --> OP-TEE (core) --> TEE-supplicant --> Kernel (>50ms) --> OP-TEE --> TA
> >>>
> >>> To add more detail to the timing above, when using RPMB, OP-TEE stores
> >>> the secure filesystem on RPMB as well, so accessing one of the variables
> >>> stored in the filesystem consists on a number (~5) of individual RPMB
> >>> requests (each one forcing a retune, each retune taking around 10ms).
> >>>
> >>> BTW, I also tried delaying the timing between those consecutive retunes
> >>> (up to 1 second), but the issue still persisted.
> >>>
> >>>>
> >>>> Adrian, I couldn't find the original performance justification for
> >>>> enabling this feature globally. At which point do you think it becomes
> >>>> beneficial to retune before accessing RPMB?
> >>>
> >>> How should we proceed with this patch then? can it be merged as I
> >>> proposed? should I rewrite it differently? not sure what is next
> >>
> >> It would be good to try to determine if the error happens when the
> >> switch command comes immediately after tuning.  For example, add
> >> a delay after tuning and see if that makes any difference. e.g.
> >>
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index c79f73459915..6b168659282a 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -2867,8 +2867,10 @@ int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> >>
> >>  		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> >>  		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> >> -			if (ctrl & SDHCI_CTRL_TUNED_CLK)
> >> +			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
> >> +				msleep(10);
> >>  				return 0; /* Success! */
> >> +			}
> >>  			break;
> >>  		}
> >>
> >>
> >
> > Thanks Adrian.
> >
> > The issue sill triggers (in this case on the last but one access to
> > retrieve the 6 byte variable).
> >
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2781,6 +2781,7 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> >          * Issue opcode repeatedly till Execute Tuning is set to 0 or the number
> >          * of loops reaches tuning loop count.
> >          */
> > + printk(KERN_ERR "tune starts[loop %d]\n", host->tuning_loop_count);
> >         for (i = 0; i < host->tuning_loop_count; i++) {
> >                 u16 ctrl;
> >
> > @@ -2799,8 +2800,11 @@ static int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> >
> >                 ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> >                 if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
> > -                   if (ctrl & SDHCI_CTRL_TUNED_CLK)
> > -                           return 0; /* Success! */
> > +                 if (ctrl & SDHCI_CTRL_TUNED_CLK) {
> > +                         printk(KERN_ERR "tune success[%d]\n", i);
> > +                         msleep(10);
> > +                         return 0; /* Success! */
> > +                 }
> >                         break;
> >                 }
> >
> >
> > [  164.919090] tune starts[loop 40]
> > [  164.923152] tune success[39]
> > [  164.952106] tune starts[loop 40]
> > [  164.956611] tune success[39]
> > [  165.084402] tune starts[loop 40]
> > [  165.089350] tune success[39]
> > [  165.116491] tune starts[loop 40]
> > [  165.120806] tune success[39]
> > [  165.145016] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
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
> > E/LD:  region  6: va 0xc0019000 pa 0x818ac38e8 size 0x001000 flags rw-- (param)
> > E/LD:  region  7: va 0xc001a000 pa 0x818ac36e8 size 0x001000 flags rw-- (param)
> > E/LD:  region  8: va 0xc0022000 pa 0x00001000 size 0x014000 flags r-xs [0]
> > E/LD:  region  9: va 0xc0036000 pa 0x00015000 size 0x008000 flags rw-s [0]
> > E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc0022000
> > E/LD:  Call stack:
> > E/LD:   0xc0024e58
> > E/LD:   0xc0022388
> > E/LD:   0xc0025d40
> > E/LD:   0xc0022624
> > [  166.119598] tune starts[loop 40]
> > [  166.125700] tune success[39]
>
> It might make a difference if there is another command before the
> switch command, e.g. add a CMD13 (could keep the tune print to tell
> that the CMD13 comes after re-tuning)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 892e74e611a0..3265049f4132 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -875,6 +875,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>  				   unsigned int part_type)
>  {
>  	int ret = 0;
> +	u32 status;
>
>  	if (part_type == EXT_CSD_PART_CONFIG_ACC_RPMB) {
>  		if (card->ext_csd.cmdq_en) {
> @@ -883,6 +884,9 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>  				return ret;
>  		}
>  		mmc_retune_pause(card->host);
> +		ret = mmc_send_status(card, &status);
> +		pr_info("%s: %s: status %#x, ret %d\n", mmc_hostname(card->host), __func__, status, ret);
> +		ret = 0;
>  	}
>
>  	return ret;
>
>
>
> And another thing to try is SDHCI_QUIRK2_TUNING_WORK_AROUND
>

I run it in a loop with all the proposed changes and after 6 or 7 seconds the error triggered:

$ while true; do if ! read_rpmb variable ;then exit 0; fi; done
[....]


[  146.686482] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
[  146.699092] ldts: tune starts[loop 40]
[  146.704032] ldts: tune success[39]
[  146.726442] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
[  146.745891] ldts: tune starts[loop 40]
[  146.750858] ldts: tune success[39]
[  146.774506] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
[  146.787191] ldts: tune starts[loop 40]
[  146.792087] ldts: tune success[39]
[  146.814544] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
[  146.826383] ldts: tune starts[loop 40]
[  146.830942] ldts: tune success[39]
[  146.854500] ldts: mmc0: mmc_blk_part_switch_pre: status 0x900, ret 0
[  146.863421] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
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
E/LD:  region  6: va 0xc0019000 pa 0x818c17b48 size 0x001000 flags rw-- (param)
E/LD:  region  7: va 0xc001a000 pa 0x818c17d48 size 0x001000 flags rw-- (param)
E/LD:  region  8: va 0xc003c000 pa 0x00001000 size 0x014000 flags r-xs [0]
E/LD:  region  9: va 0xc0050000 pa 0x00015000 size 0x008000 flags rw-s [0]
E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc003c000
E/LD:  Call stack:
E/LD:   0xc003ea14
E/LD:   0xc003c31c
E/LD:   0xc003fd40
