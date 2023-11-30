Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237BC7FF85D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjK3RfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3RfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:35:08 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064E4197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:35:14 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d3eb2d465cso457b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701365693; x=1701970493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JdYGimUU6VCO987XoyzXKLf7pYPiXDG4sSKXnicjavY=;
        b=SXvXaPRM4EBRHX9Xs6HHqQKqM2s3LbXXI1+xZgzaW1yUG5aDd/rdB2UGvsllKLRieb
         uKIOgUprftw0xA7bm16GfPVHKMVeg8HMPfVbxQ/SepXiYF8uqxCOGEVozA8/JpH6RurH
         BGgXsKjsjM4e4fKy2FjCAujyEPdz3ohalg7Z54SK7wECGQSFRS6U8YMcGydvGfM17wOW
         M/La7EYkrUNmmTaFYgb2YDsFiW5xYJq4cueiY5dhnTY7ONWl6tAAg1L8NMGABnxRPfhB
         FYaE6yIirHOSS1F4wPuvxRo6zfbZIOO0BD1BgMRC9z8q0cYhgGaS/AkE3hC7DxoOVKfp
         DSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701365693; x=1701970493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdYGimUU6VCO987XoyzXKLf7pYPiXDG4sSKXnicjavY=;
        b=Wb8FyYJ3Rc40i5JPv2iWTN3GR77rLQ6v8t1bwafmfD1qkHY4C2K9342SuWcHIMD434
         VLunQRqUSDdpMW5VOEzmceF6dPS8L9b2wqKiixju3OT+1fPZC6DV8M+oFLd8HlHo/GR+
         m5xuXeRYSZLTXSJiel8G9SKSHDwbwqhjaKI+kLL4RlSn8qb9tJSJNMUuWHmHlmeXYbGO
         0J18Kq4c79zH+PlF/aVP21/vit+GgIwaC0XwfD4JsbYamgYWM6HeJ13P9RBYE0uMWi9M
         mLcaxS0MdrlAPSnscM12J5ecn05CCiY1pvngr3RNJO7HUeKpbGuWtWStYD/tklMUInnk
         dGXg==
X-Gm-Message-State: AOJu0Yxz7aw/3ZbKw9fzWpbGK+ecG4NGE4bbEjGtQweFSmFq8SL6CQoY
        aJRGfsdGHepaBU4zylNkEI4q0SOjDnn7Gt4fL9b8/A==
X-Google-Smtp-Source: AGHT+IEjVoWifL8WXALWoNygf0QQKGdngRfMCZCvHest+QyknhNF0y0KUJMi0Fl2KjGJ48467oMRYebHuj7y9k6pWDk=
X-Received: by 2002:a81:52cb:0:b0:5c9:12ec:5203 with SMTP id
 g194-20020a8152cb000000b005c912ec5203mr692214ywb.32.1701365693578; Thu, 30
 Nov 2023 09:34:53 -0800 (PST)
MIME-Version: 1.0
References: <20231129160533.2827458-1-jorge@foundries.io> <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
 <ZWiNDgUFF8ug7gZf@trax>
In-Reply-To: <ZWiNDgUFF8ug7gZf@trax>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 30 Nov 2023 18:34:17 +0100
Message-ID: <CAPDyKFqBAyF4bzjQR5JnKB3DOvmN58zUuNv0hKw6fXh17CEJnw@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     CLoehle@hyperstone.com, adrian.hunter@intel.com,
        jinpu.wang@ionos.com, hare@suse.de, beanhuo@micron.com,
        yangyingliang@huawei.com, asuk4.q@gmail.com, yibin.ding@unisoc.com,
        victor.shih@genesyslogic.com.tw, marex@denx.de,
        rafael.beims@toradex.com, robimarko@gmail.com,
        ricardo@foundries.io, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 at 14:24, Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 30/11/23 11:34:18, Ulf Hansson wrote:
> > On Wed, 29 Nov 2023 at 17:05, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> > >
> > > On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
> > > re-tune before switching to the RPMB partition would randomly cause
> > > subsequent RPMB requests to fail with EILSEQ:
> > > * data error -84, tigggered in __mmc_blk_ioctl_cmd()
> > >
> > > This commit skips the retune when switching to RPMB.
> > > Tested over several days with per minute RPMB reads.
> >
> > This sounds weird to me and needs more testing/debugging in my
> > opinion, especially at the host driver level. Perhaps add some new
> > tests in mmc_test, that does a partition switch to/from any partition
> > and then run regular I/O again to see if the problem is easier to
> > reproduce?
>
> hi Uffe
>
> ok I'll have a look - I have never used this driver before, so if you
> have anything in the works I'll be glad to integrated and adapt.
>
> >
> > The point is, I wonder what is so special with RPMB here? Note that,
> > it has been quite common that host drivers/controllers have had issues
> > with their tuning support, so I would not be surprised if that is the
> > case here too.
>
> Right, it is just that the tuning function for of-arasan is the generic
> __sdhci_execute_tuning() - only wrapped around arasan DLL reset
> calls. Hence why I aimed for the card: __sdhci_execute_tuning and ZynqMP
> are not recent functions or architectures.

Well, I suggest we try to get some help from the driver authors then.

>
>
> > Certainly I would be surprised if the problem is at
> > the eMMC card side, but I may be wrong.
>
> How do maintainers test the tuning methods? is there anything else for
> me to do other than forcing a retune with different partitions?

Good question. I think we should have an mmc_test for that, but I
don't think we have.

Unfortunately, I don't have the bandwidth to help with this currently,
so unless some other can step in and help you are on your own.

>
> >
> > Kind regards
> > Uffe
>
> For completeness this is the error message - notice that we have a
> trusted application (fiovb) going through OP-TEE and back to the TEE
> supplicant issuing an rpmb read of a variable (pretty normal these days,
> we use it on many different platforms - ST, NXP, AMD/Xilinx, TI..).
>
> The issue on this Zynqmp platform is scarily simple to reproduce; you
> can ignore the OP-TEE trace, it is just the TEE way of reporting that
> the RPMB read failed.
>
> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# fiovb_printenv m4hash
> [  461.775084] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> E/TC:? 0
> E/TC:? 0 TA panicked with code 0xffff0000
> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> E/LD:   arch: aarch64
> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
> E/LD:  region  6: va 0xc0019000 pa 0x816b31fc8 size 0x001000 flags rw-- (param)
> E/LD:  region  7: va 0xc001a000 pa 0x816aa1fc8 size 0x002000 flags rw-- (param)
> E/LD:  region  8: va 0xc006b000 pa 0x00001000 size 0x014000 flags r-xs [0]
> E/LD:  region  9: va 0xc007f000 pa 0x00015000 size 0x008000 flags rw-s [0]
> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc006b000
> E/LD:  Call stack:
> E/LD:   0xc006de58
> E/LD:   0xc006b388
> E/LD:   0xc006ed40
> E/LD:   0xc006b624
> Read persistent value for m4hash failed: Exec format error
>
> Also I instrumented sdhci-of-arasan.c to confirm that tuning wasn't failing.
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 681ac4cab8ab..54cde79d2719 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1123,7 +1123,10 @@ static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>         err = sdhci_execute_tuning(mmc, opcode);
>         if (err)
> -           return err;
> +         WARN_ON(1);
> +
> + if (host->tuning_err)
> +         WARN_ON(1);
>
>         arasan_zynqmp_dll_reset(host, device_id);
>
>
> Incidentally - not sure if it is intentional or not - I noticed that the
> function arasan_zynqmp_execute_tuning(..) can not fail which seems wrong
> (IMO it should also check host->tuning_err and not only err which will
> always be 0).
>
> Do you think this needs fixing even though not related to this problem?

I usually defer to driver authors and Adrian as the SDHCI maintainer
for questions like these, so again, sorry for not being able to help
more than this.

[...]

Kind regards
Uffe
