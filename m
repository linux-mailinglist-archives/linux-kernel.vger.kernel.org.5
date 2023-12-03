Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA183802569
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjLCQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLCQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:26:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04FDB0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 08:26:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-332fd81fc8dso2853746f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 08:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1701620815; x=1702225615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JKUYtoOf0LqZvx5jLyKDik00mRuUG08DYUD1N82aPUc=;
        b=YTLDIjm8AhWJ0oMzc+iXGwmWZuFxXfG2VpinSXjKBMtN2jrm09e8xFTJsYD8DYmWus
         SZHW+xJw9RXu3u80Wr0OJSSixw7u+CJHBXSIdLYECN2M48hH2PBG/cg9Smv6Xk8JwpXJ
         gwnNEb4g4DmWklh25wUg6RqApZDP3kcdK5GDJX7JYZRxCGFINTnXGisLjNF3vKS/s1B2
         vwPUjHbFMHPXcxuHTvZ0SR2nbyE+2dirwFuhgKnOqjDg7ATlQJqJBsbUXJPXDqbYzgVF
         SqABgrsiLiWoII91Ls20oidOpAikfwmMDsi9NXvMK9VDsSmJzk0QBPkhcjHI53hwUhaD
         iatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701620815; x=1702225615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKUYtoOf0LqZvx5jLyKDik00mRuUG08DYUD1N82aPUc=;
        b=TY4yw2cLRZJRGO6Igacxov6CqfKc7EAh6QVdWhh4cRPUMBMUELNMWcAqgOT1iU12GY
         YXTV236twIvLvwHh+5ggZzmBkhLFLGparU5t6BPFHNG59Ksspux0fQrbIvTwFeUkh++M
         EeD8yeHL0rlCubSKo92UdrifkmPTrlmwM76Le1v0b4PAcLzlDiv5LK8WzJLQNtpHdpzE
         r4G681fZ+OD0DNyFnbu4bZ4fXWdJ3SnXzQ8D00Ccdo2AEE6CZSj3xTXUQrg9D6TmeeMu
         pDdEGARyv3d0Vkvima2WW2YGxjnyAzd3/l2sqx1k5fE4PICn1DLSJOv+yscSx8KI9TLH
         +4bA==
X-Gm-Message-State: AOJu0YzxeRknpD8rJNEIwad8zv/4YPP0qu+TjGT53dM5FuhaOfPB5QVN
        AaZJ9IMTPiZ4u6inHa4ttMLFuw==
X-Google-Smtp-Source: AGHT+IGr2WEVErhhlk/iLQwRu3uPaTWWPJOPCyS0S8/7XyF+hmJ3xXZGJvuUd+vGX2KfNnQZiUIENA==
X-Received: by 2002:a05:600c:43c3:b0:40b:5e59:da78 with SMTP id f3-20020a05600c43c300b0040b5e59da78mr1888128wmn.139.1701620815032;
        Sun, 03 Dec 2023 08:26:55 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm15585604wms.3.2023.12.03.08.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 08:26:54 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Sun, 3 Dec 2023 17:26:52 +0100
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "CLoehle@hyperstone.com" <CLoehle@hyperstone.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "hare@suse.de" <hare@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "asuk4.q@gmail.com" <asuk4.q@gmail.com>,
        "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
        "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
        "marex@denx.de" <marex@denx.de>,
        "rafael.beims@toradex.com" <rafael.beims@toradex.com>,
        "robimarko@gmail.com" <robimarko@gmail.com>,
        "ricardo@foundries.io" <ricardo@foundries.io>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
Message-ID: <ZWysTPapFyGJdu5d@trax>
References: <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
 <ZWiNDgUFF8ug7gZf@trax>
 <fbc82848-d402-4075-8176-de9ed0345d78@intel.com>
 <ZWkGZ7av1S4Clwdv@trax>
 <ZWkKgU+J9atnJdqT@trax>
 <ZWmN+k+wUWcXT5ID@trax>
 <fecd033b-b2ea-4906-a320-22a5c2ede46c@intel.com>
 <ZWoBqs/5m6tCuBGo@trax>
 <ZWoTOm+8Y75TLz6q@trax>
 <DM6PR04MB6575FF9532A9FC0EE91B5B37FC80A@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6575FF9532A9FC0EE91B5B37FC80A@DM6PR04MB6575.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/23 16:47:23, Avri Altman wrote:
> Hi,
> Sorry for joining so late - This thread was routed to my junk mail somehow.
> We were observing this issue recently with one of our clients using a Broadcom platform.
> Similarly like in this case, the tuning process didn't use cmd21, so sending only cmd6 is perfectly ok.
> We couldn't find any issue with the device at the time.
> During our investigation, it turned out that the client had a kernel hack of its own,
> and once it was removed the issue wasn't reproducing anymore.

um, do you know what driver or setting could have be caused the issue?

This product is using the Xilinx kernel. 5.15.64
https://github.com/Xilinx/linux-xlnx

>
> > > > >>> hi Adrian
> > > > >>>
> > > > >>> Sure, this is the output of the trace:
> > > > >>>
> > > > >>> [  422.018756] mmc0: sdhci: IRQ status 0x00000020 [  422.018789]
> > > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.018817] mmc0: sdhci:
> > > > >>> IRQ status 0x00000020 [  422.018848] mmc0: sdhci: IRQ status
> > > > >>> 0x00000020 [  422.018875] mmc0: sdhci: IRQ status 0x00000020 [
> > > > >>> 422.018902] mmc0: sdhci: IRQ status 0x00000020 [  422.018932]
> > > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.020013] mmc0: sdhci:
> > > > >>> IRQ status 0x00000001 [  422.020027] mmc0: sdhci: IRQ status
> > > > >>> 0x00000002 [  422.020034] mmc0: req done (CMD6): 0: 00000800
> > > > >>> 00000000 00000000 00000000 [  422.020054] mmc0: starting CMD13
> > > > >>> arg 00010000 flags 00000195 [  422.020068] mmc0: sdhci: IRQ
> > > > >>> status 0x00000001 [  422.020076] mmc0: req done (CMD13): 0:
> > > > >>> 00000900 00000000 00000000 00000000 [  422.020092] <mmc0:
> > > > >>> starting CMD23 arg 00000001 flags 00000015> [  422.020101] mmc0:
> > > > >>> starting CMD25 arg 00000000 flags 00000035
> > > > >>> [  422.020108] mmc0:     blksz 512 blocks 1 flags 00000100 tsac 400 ms
> > nsac 0
> > > > >>> [  422.020124] mmc0: sdhci: IRQ status 0x00000001 [  422.021671]
> > > > >>> mmc0: sdhci: IRQ status 0x00000002 [  422.021691] mmc0: req done
> > > > >>> <CMD23>: 0: 00000000 00000000 00000000 00000000 [  422.021700]
> > > > >>> mmc0: req done (CMD25): 0: 00000900 00000000 00000000
> > 00000000
> > > > >>> [  422.021708] mmc0:     512 bytes transferred: 0
> > > > >>> [  422.021728] mmc0: starting CMD13 arg 00010000 flags 00000195
> > > > >>> [  422.021743] mmc0: sdhci: IRQ status 0x00000001 [  422.021752]
> > > > >>> mmc0: req done (CMD13): 0: 00000900 00000000 00000000
> > 00000000 [
> > > > >>> 422.021771] <mmc0: starting CMD23 arg 00000001 flags 00000015> [
> > > > >>> 422.021779] mmc0: starting CMD18 arg 00000000 flags 00000035
> > > > >>> [  422.021785] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms
> > nsac 0
> > > > >>> [  422.021804] mmc0: sdhci: IRQ status 0x00000001 [  422.022566]
> > > > >>> mmc0: sdhci: IRQ status 0x00208000
> > > > >>> <---------------------------------- this doesnt seem right [
> Why not?
> Its cmd25-cmd25-cmd18 which implies rpmb write?

sorry I am referring to the IRQ status  0x00208000 (CRC errors) - not
the sequence.

>
> > > > >>> 422.022629] mmc0: req done <CMD23>: 0: 00000000 00000000
> > 00000000 00000000 [  422.022639] mmc0: req done (CMD18): 0: 00000900
> > 00000000 00000000 00000000
> > > > >>> [  422.022647] mmc0:     0 bytes transferred: -84 < -------------------------
> > -------- it should have transfered 4096 bytes
> > > > >>> [  422.022669] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd:
> > > > >>> data error -84 [  422.029619] mmc0: starting CMD6 arg 03b30001
> > > > >>> flags 0000049d [  422.029636] mmc0: sdhci: IRQ status 0x00000001
> > > > >>> [  422.029652] mmc0: sdhci: IRQ status 0x00000002 [  422.029660]
> > > > >>> mmc0: req done (CMD6): 0: 00000800 00000000 00000000 00000000
> > [
> > > > >>> 422.029680] mmc0: starting CMD13 arg 00010000 flags 00000195 [
> > > > >>> 422.029693] mmc0: sdhci: IRQ status 0x00000001 [  422.029702]
> > > > >>> mmc0: req done (CMD13): 0: 00000900 00000000 00000000
> > 00000000 [
> > > > >>> 422.196996] <mmc0: starting CMD23 arg 00000400 flags 00000015> [
> > > > >>> 422.197051] mmc0: starting CMD25 arg 058160e0 flags 000000b5
> > > > >>> [  422.197079] mmc0:     blksz 512 blocks 1024 flags 00000100 tsac 400
> > ms nsac 0
> > > > >>> [  422.197110] mmc0:     CMD12 arg 00000000 flags 0000049d
> > > > >>> [  422.199455] mmc0: sdhci: IRQ status 0x00000020 [  422.199526]
> > > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.199585] mmc0: sdhci:
> > > > >>> IRQ status 0x00000020 [  422.199641] mmc0: sdhci: IRQ status
> > > > >>> 0x00000020 [  422.199695] mmc0: sdhci: IRQ status 0x00000020 [
> > > > >>> 422.199753] mmc0: sdhci: IRQ status 0x00000020 [  422.199811]
> > > > >>> mmc0: sdhci: IRQ status 0x00000020 [  422.199865] mmc0: sdhci:
> > > > >>> IRQ status 0x00000020 [  422.199919] mmc0: sdhci: IRQ status
> > > > >>> 0x00000020 [  422.199972] mmc0: sdhci: IRQ status 0x00000020 [
> > > > >>> 422.200026] mmc0: sdhci: IRQ status 0x00000020
> > > > >>>
> > > > >>>
> > > > >>> does this help?
> > > > >
> > > > > Just asking because it doesn't mean much to me other than the
> > > > > obvious CRC problem.
> > > > >
> > > > > Being this issue so easy to trigger - and to fix - indicates a
> > > > > problem on the card more than on the algorithm (otherwise faults
> > > > > would be all over the place). But I am not an expert on this area.
> > > > >
> > > > > any additional suggestions welcome.
> > > >
> > > > My guess is that sometimes tuning produces a "bad" result. Perhaps
> > > > the margins are very tight and the difference is only 1 tap.  When a
> > > > "bad" result happens in non-RPMB, a CRC error results in re-tuning
> > > > and retry, so no errors are seen.  When it happens in RPMB, that is
> > > > not possible, so the error is obvious.  Not re-tuning before RPMB
> > > > switch helps because the CRC-error->re-tuning to a "good" result has
> > > > probably already happened.
> > > >
> > > > However,  based on that theory, it is not necessary the eMMC that is
> > > > at fault.
> > > >
> > > > It may be worth considering a stronger eMMC driver strength setting.
> > >
> > > sure I can tune the value (just building now). however I am not sure
> > > about the implications - is there any negative consequence of
> > > increasing this value that I could monitor (if tests pass)?
> >
> > ZynqMP does not set the property "fixed-emmc-driver-type" and since the
> > sdhci-of-arasan driver does not implement select_drive_strength() the
> > drive_strength setting is zero.
> >
> > So AFAICS things are working accordingly - it is hard for me to say if things
> > should have been coded any differently.
> >
> > > >
> > > > sdhci supports err_stats in debugfs - that may show how many CRC
> > > > errors there are when not accessing RPMB.
> > >
> > > ok
> > >
> > > >
> > > > I don't object to skipping re-tuning before RPMB switch, but I am
> > > > not sure about tying it to a specific eMMC.
> > >
> > > thanks. will follow up after further testing.
> >
> > should I just repost the patch now skiping the retune for all cards before
> > switching to the RPMB partition? instead of using a quirk?
> >
> > On this particular card it has now run for a couple of days so I am confident
> > that it addresses at the very least the symptom of the issue.
> As aforesaid, we observed a similar issue on a different platform as well.
> If it's not realistic to further pursue Adrian's theory, *And* this doesn't reproduce on other cards,
> we have no objection setting the quirk for Sandisk.
> (if you're having trouble testing other cards ping me privately I can help you with that).

I have some extra eMMC cards which I used to validate RPMB on the OP-TEE
port I did for AMD/Xilinx Versal ACAP some time ago and which I maintain upstream:
https://optee.readthedocs.io/en/latest/building/devices/versal.html?highlight=versal

However I cant use them on this hardware - there is not a uSD slot, just
USB. And from what I can see, RPMB doesnt get mapped when the device is
mounted as a mass storage device (unless there is a way that I dont
know?). Other than that I am not sure what to propose. Suggestions
welcome.

Versal uses the same sdhci-of-arasan driver but with some diffences:
https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/18842090/SD+controller?responseToken=4bd005c7902a3dbd9ecb032f02e52ccb
This particular issue can not be reproduced on that platform.

It also didn't ever trigger in any of the other platforms I have
worked with and supported during the last four years (STM32MP1, NXP
(iMX8, iMX7, iMX6), etc). And we have heard of no customers complaining
about upgrade issues.

Being RPMB critical for our security story - device firmware
verification and upgrade - we would have noticed. So this one is the
first time we have had troubles accessing RPMB - incidentally blocking a
product launch and causing a bit of pain.
https://docs.foundries.io/latest/reference-manual/security/secure-machines.html?highlight=rpmb#accessing-secure-storage

We could carry the patch internally (it seems harmless after all the
testing done) but I'd much rather land it upstream if possible.

>
> Thanks a lot for fixing this,
> Avri

thanks everyone for the support.

>
> (btw - yes - our manufacturer id is 0x45 - it is set differently in the mmc driver for historic reasons -
> Thank you for adding this.)
>
> >
> >
> > >
> > > >
> >
>
