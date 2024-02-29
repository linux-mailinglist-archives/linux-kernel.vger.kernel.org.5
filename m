Return-Path: <linux-kernel+bounces-86882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A942B86CC30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38BA21F263E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41A513DBA4;
	Thu, 29 Feb 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EWQRPLnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kgwswZqC"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FF137747;
	Thu, 29 Feb 2024 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218547; cv=none; b=aKJg6FUDmMfHKCAOPr8MeWjeLk9Xg8eFLPED/9g6tDmXUcGhA4wRSlnlpAGnD6nV4mP/T63oMggMNNhTA2wg6nffKPDXuPaQqLBXrOI9v2xUAPwRMljfKW3gHRutkEqxijvKQy6a8AiRjve5TGg5DJVkTXMquEVoxEK/xNlBLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218547; c=relaxed/simple;
	bh=SxpffWLnyNDN/1841uyE0oshS0QJzdCO3z1ODT/FKfo=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DuWEneNleS0hwbKKNTWjFZ/rlwVHNeV2QMPuj/xMKudF92ajXKuh8n2+JkJAQTHMoD9EwcnWzsNJk9DpertiF7qJZW+Sxb2jFi+aUOv9RoXaMwWwvE1xSlCbgFGNPQgiXn9VxBjUcUSl+dtfs+HvKEAv/MZ/cbjYDAEZt2rBnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EWQRPLnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kgwswZqC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 702F3138008A;
	Thu, 29 Feb 2024 09:55:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 29 Feb 2024 09:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709218544; x=1709304944; bh=ElrnHAwLCy
	WSxuQyqqrk5ArK2AElYsG6snJ116Z584E=; b=EWQRPLnfAbMJ1vDBCYnB5QTE3e
	PLshvLt0jsi6tRuTJJoZPcl4feTqh1YXFSSKYV/YmQvGkEMu7GVLyskmA/ABLWMG
	U7xzycyYSldlE8gHjaM9LSIqka1RHuuOqOSDRMTBAE8XVBHKjeUckTMzOIwikybO
	3Hr7Yw92Js2IS3DsozWuTicFAb/LVvXy5PJLcc/1timwMSsAvIKg8IX+1xQEfyVD
	yU64E18jscl0f3Dq9tFFR0xFck6QmyyU9XrC3QGD/8q1JVl2VPx+VGwiCdRLDZp6
	mjb38T7lXSUkFmj97lIqdT4lTRxp6kCzvRbX+Rv0bcEtl9vF2O1FB7/DwM9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709218544; x=1709304944; bh=ElrnHAwLCyWSxuQyqqrk5ArK2AEl
	YsG6snJ116Z584E=; b=kgwswZqCGD30lv4lfhqoahxAFWzB1FCW0aXfcoy3GJlZ
	SNKbg9kgzF5d53gGrBiXd/h/utj+SaFZwnQ/wqJ2KkiwHMlsPHvCkQu1RpMKlCx0
	7oJ2GPwSWN5GGCxHRc+1tx09K4aSBiKaEJXOsou3KvA0O2MHcZXmu1IHnEZ5hCmq
	ksEPw7zb8VJqwxpNbWVqQ80RSx3mCdTI0w5VnarZ55MS5OSUzIAEftvKiQ5eF5bO
	XcvMwMh8BW/32k28VNwTb+2H6kFa2a4h1JQX+Nq9KsFhjVx/kW5aB2PEbDgNAlm7
	eciwXGJbtEWMgH3x1PSSyOLrOh7RBblb1Tu3irtuoQ==
X-ME-Sender: <xms:75rgZSMKxAllCEagoly7NiuxF63DbKEpTqSiS1TCkDtHMCF6s3ELwg>
    <xme:75rgZQ_fzUNwiHNOui847k7ktzT6trggMvKmZy_GHw2tOYoNquEVnnt8-Xt9k6dTs
    mrydnhUq08WsKyQrxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeeihfejueefkeevteevheethedtfedtteeufeefteffkeetffeuvdevtdelhfeu
    veenucffohhmrghinhepthhugihsuhhithgvrdgtohhmpdhlihhnrghrohdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:75rgZZTLQ3Bg016M5OCdhxkkx8XK3VRMQYoG9tT1hI4RqtVQh7wSjQ>
    <xmx:75rgZSsSGP9j94QBUe-H6MtiEBXEuuRyh2u1I5faMevfQHlX5hU0yQ>
    <xmx:75rgZacieoMGqqaFHsBpsq1Sz4QDHvZlPELmnQv7hxGxVtbN4UxtMA>
    <xmx:8JrgZW0vILFsu5BdPZ5eg6exUya_gGwgXk6wdMz-RgYYQUD0cCc32Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4DEC0B6008D; Thu, 29 Feb 2024 09:55:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-182-gaab6630818-fm-20240222.002-gaab66308
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d5c07950-6f42-4ac9-b0d8-776d444252ae@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
References: 
 <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
Date: Thu, 29 Feb 2024 15:55:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 linux-block <linux-block@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "open list" <linux-kernel@vger.kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
 "Christian Brauner" <brauner@kernel.org>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Jaehoon Chung" <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Subject: Re: WinLink E850-96: WARNING: at block/blk-settings.c:204 blk_validate_limits
Content-Type: text/plain

On Thu, Feb 29, 2024, at 15:14, Naresh Kamboju wrote:
> The arm64 WinLink E850-96 Board boot failed with 16K and 64K page size builds
> Please find the below warning log on Linux next-20240229.
> First noticed on the next-20240220 tag.
>
> This issue arises only when one of these Kconfig options is enabled.
>   CONFIG_ARM64_16K_PAGES=y
>   CONFIG_ARM64_64K_PAGES=y
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Warning log:
> -------
> [    2.231008] mmc_host mmc0: Bus speed (slot 0) = 49968750Hz (slot
> req 52000000Hz, actual 49968750HZ div = 0)
> [    2.231714] mmc_host mmc0: Bus speed (slot 0) = 399750000Hz (slot
> req 200000000Hz, actual 199875000HZ div = 1)
> [    2.241961] mmc0: new HS400 Enhanced strobe MMC card at address 0001
> [    2.249182] ------------[ cut here ]------------
> [    2.252371] WARNING: CPU: 3 PID: 90 at block/blk-settings.c:204
> blk_validate_limits (block/blk-settings.c:204 (discriminator 1))


The warning was added with commit d690cb8ae14b ("block: add
an API to atomically update queue limits")

+               if (!lim->max_segment_size)
+                       lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
+               if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
+                       return -EINVAL;

Whereas mmc_alloc_disk sets the limit as

        /*
         * Setting a virt_boundary implicity sets a max_segment_size, so try
         * to set the hardware one here.
         */
        if (host->can_dma_map_merge) {
                lim.virt_boundary_mask = dma_get_merge_boundary(mmc_dev(host));
                lim.max_segments = MMC_DMA_MAP_MERGE_SEGMENTS;
        } else {
                lim.max_segment_size =
                        round_down(host->max_seg_size, lim.logical_block_size);
                lim.max_segments = host->max_segs;
        }

and max_seg_size gets initialized to either one less
than 64k, or to exactly 4k in the dwmmc driver here:

        /* Useful defaults if platform data is unset. */
        if (host->use_dma == TRANS_MODE_IDMAC) {
                mmc->max_segs = host->ring_size;
                mmc->max_blk_size = 65535;
                mmc->max_seg_size = 0x1000;
                mmc->max_req_size = mmc->max_seg_size * host->ring_size;
                mmc->max_blk_count = mmc->max_req_size / 512;
        } else if (host->use_dma == TRANS_MODE_EDMAC) {
                mmc->max_segs = 64;
                mmc->max_blk_size = 65535;
                mmc->max_blk_count = 65535;
                mmc->max_req_size =
                                mmc->max_blk_size * mmc->max_blk_count;
                mmc->max_seg_size = mmc->max_req_size;
        } else {
                /* TRANS_MODE_PIO */
                mmc->max_segs = 64;
                mmc->max_blk_size = 65535; /* BLKSIZ is 16 bits */
                mmc->max_blk_count = 512;
                mmc->max_req_size = mmc->max_blk_size *
                                    mmc->max_blk_count;
                mmc->max_seg_size = mmc->max_req_size;
        }

Adding the mmc and dw-mmc maintainers to cc for clarification.

     Arnd

> [    2.261056] Modules linked in:
> [    2.264082] CPU: 3 PID: 90 Comm: kworker/3:1 Not tainted
> 6.8.0-rc6-next-20240229 #1
> [    2.271724] Hardware name: WinLink E850-96 board (DT)
> [    2.276756] Workqueue: events_freezable mmc_rescan
> [    2.281534] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    2.288479] pc : blk_validate_limits (block/blk-settings.c:204
> (discriminator 1))
> [    2.293076] lr : blk_set_default_limits (block/blk-settings.c:241)
> <trim>
> [    2.337595] PM: genpd: Disabling unused power domains
> [    2.338361] xhci-hcd xhci-hcd.0.auto: remove, state 84
> [    2.338391] usb usb1: USB disconnect, device number 1
> [    2.343322]  x1 : 0000000000001000 x0 : ffff8000a504f888
> [    2.343335] Call trace:
> [    2.343339] blk_validate_limits (block/blk-settings.c:204 (discriminator 1))
> [    2.343350] blk_alloc_queue (block/blk-core.c:421)
> [    2.343362] blk_mq_alloc_queue (block/blk-mq.c:4083 (discriminator 4))
> [    2.350571] ALSA device list:
> [    2.352700] xhci-hcd xhci-hcd.0.auto: USB bus 1 deregistered
> [    2.355651] __blk_mq_alloc_disk (block/blk-mq.c:4130)
> [    2.355664] mmc_alloc_disk (drivers/mmc/core/queue.c:379)
> [    2.355678] mmc_init_queue (drivers/mmc/core/queue.c:463)
> [    2.359577]   No soundcards found.
> [    2.362942] mmc_blk_alloc_req (drivers/mmc/core/block.c:2500
> (discriminator 1))
> [    2.362951] mmc_blk_probe (drivers/mmc/core/block.c:2603
> drivers/mmc/core/block.c:3025)
> [    2.446877] mmc_bus_probe (drivers/mmc/core/bus.c:132)
> [    2.446892] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
> [    2.454016] __driver_probe_device (drivers/base/dd.c:800)
> [    2.458346] driver_probe_device (drivers/base/dd.c:830)
> [    2.462513] __device_attach_driver (drivers/base/dd.c:959)
> [    2.466939] bus_for_each_drv (drivers/base/bus.c:457)
> [    2.470761] __device_attach (drivers/base/dd.c:1032)
> [    2.474579] device_initial_probe (drivers/base/dd.c:1080)
> [    2.478746] bus_probe_device (drivers/base/bus.c:532)
> [    2.482563] device_add (drivers/base/core.c:3646)
> [    2.486037] mmc_add_card (drivers/mmc/core/bus.c:371)
> [    2.489683] mmc_attach_mmc (drivers/mmc/core/mmc.c:2353)
> [    2.493500] mmc_rescan (drivers/mmc/core/core.c:2097 (discriminator
> 1) drivers/mmc/core/core.c:2259 (discriminator 1))
> [    2.496974] process_one_work (kernel/workqueue.c:3253)
> [    2.500966] worker_thread (kernel/workqueue.c:3322 (discriminator
> 2) kernel/workqueue.c:3409 (discriminator 2))
> [    2.504700] kthread (kernel/kthread.c:388)
> [    2.507914] ret_from_fork (arch/arm64/kernel/entry.S:861)
> [    2.511473] ---[ end trace 0000000000000000 ]---
> [    2.516435] mmcblk: probe of mmc0:0001 failed with error -22
> [    2.522114] Waiting for root device /dev/mmcblk0p12...
>
> Kconfig:
>  - 
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2ccVUNsQjaWBcREYI0wFRjzG3oa/config
>
> Steps to reproduce:
>  - 
> https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2ccVWjLtBJ3IuDSKLkyaFholQ67/reproducer
>
> Links:
>  - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240229/testrun/22884460/suite/boot/test/gcc-13-lkftconfig-16k_page_size/log
>  - 
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240229/testrun/22884435/suite/boot/test/gcc-13-lkftconfig-64k_page_size/details/
>  - 
> https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2d2JxLaSCZ6cTNGMeKdCbAjk9Sh
>  - 
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2d2JuyeiEHCtWGJYV80n1tF77lh/
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org

