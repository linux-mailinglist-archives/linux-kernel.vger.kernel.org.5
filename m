Return-Path: <linux-kernel+bounces-95086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44D5874919
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A12855B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B006312F;
	Thu,  7 Mar 2024 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O67iqBrZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2cjqQWy"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B06310B;
	Thu,  7 Mar 2024 07:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709797978; cv=none; b=nbL/wYOzqPspGAbhJyagmYxezPzrY7Orxc13fYaRguDzvaONrHvzdgRZFmxGVgTe9H3eesr+rcO12B6u8SMaQ16fEM6AWW97Fk8F3EWU8enRfzkNdiNaZEnA5AuTLkVXLnaN6frT16Ynlov+16Tyr9VGZRuGS7ia/zBfMiXAMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709797978; c=relaxed/simple;
	bh=2fjs0v2lhXf14YMF73sZlJKN1KHNF0BScIknj0t3qLY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=EsxNCSoj0W4zuRbqJUcf0BdZv5JZVw5EdduOqjZgw1Ur44/3+PcdrUqO5Had3HBb8TsDC7bGlxnwWLhjLSTXu0kuImiz73Zh4N/inI8M6V4KwSxvVYQSu91CT16MsUaQF0KEecDz3hkyluPGatdMwPEeikc8zAgOEhQnWK77mus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O67iqBrZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2cjqQWy; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 46B471C0005B;
	Thu,  7 Mar 2024 02:52:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 07 Mar 2024 02:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709797973; x=1709884373; bh=afyLY/l9R7
	0gs9c2KrRiUpws6jfz5mx+nYl8UbTp5B8=; b=O67iqBrZKpaHV9f/a0eC5OlCA0
	kvni3QdUEAKVVe49BScYaENsrH2cr0ILUtEbLWtwItOaWdbJblTaesgY9AHlQ/95
	y8oI0WINk+NBdahQDvNEGkPZU1+CGSeIIaXYLEGCtpdZKApnTdZ+/4kyfY4kt/k0
	5RAG2PbqLlJ65xtBsAUCpk84uBcQ9HpNaRukIRnurUTYiHs/Eu3EwftCOHQlP9DD
	jnuYLZZCqOM4wIoGMZviymtb5Xl4LPsbcKqtoX+aT9FVpfeRSFSVz1aVZc8NCZvc
	IvdkvpAoQWPYnJFwVf/U71/Xmrtu+Yg8Jla/5bIloQ5L1dCoiOpr5KJ3hgnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709797973; x=1709884373; bh=afyLY/l9R70gs9c2KrRiUpws6jfz
	5mx+nYl8UbTp5B8=; b=S2cjqQWyS0Z1vUaCffjTUB4Af2LcwLMQ7UgF1khKCljU
	pi/W0f58t5OKenZmRPdONVXFqjC+U6GrIbrEfxbg3LNA+wzcEmCHMLs8FvMV0I6Q
	I1PGAMVhL8QT6Mr7dy/UcPJ1p9NkX2UWLKssTrAa4Bvj8ZBD/VPQ9QxWgnJdJLkD
	6ZA8l0a0eoev7HliGWgpHGlKsO8C9Gg9rn6hhIam9wDVoSvt3JeUES8ogBHYGg5X
	F2Y8z6+/vsJ/Kb4fkOL1IPshidNsbQORjiBaf+mH9O0v4jRa4+cp3/NX/HrYWIK/
	xGRmNQEl/oZ89qsO7AyeqT7QT4j6ugA/UUQ5PhaHAQ==
X-ME-Sender: <xms:VHLpZd67YGruW1Bk9nU_QnbfKrNMW43go98P3uV1LrB_EEqChHtdeA>
    <xme:VHLpZa6NlzCjV-v276oagp-PJRYdhbZAAgLAK6C-6VDwedRSa4-7UUF7nF7MinW-8
    9vyPUQWMysqZrqPgXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VHLpZUf_mVG7eglPqsXPeRpiRs4l4Amse2apiXIb5OApW0gNP5VgHg>
    <xmx:VHLpZWLnQkaqTHWNduucbgPZr_IbCK13YEyIeetiALQOCdJChSLD-w>
    <xmx:VHLpZRJV-ozFC3xj3XF-Q5SW0cRy1YKofRek_6VA71mWTzRPsXnEHg>
    <xmx:VXLpZa6uxoGRkGneynLHOLw9bClFEiDKqksPaqouNdWlCTu2vCJhC34ogSI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 91795B6008D; Thu,  7 Mar 2024 02:52:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8896bcc5-09b1-4886-9081-c8ce0afc1c40@app.fastmail.com>
In-Reply-To: <20240306232052.21317-1-semen.protsenko@linaro.org>
References: <20240306232052.21317-1-semen.protsenko@linaro.org>
Date: Thu, 07 Mar 2024 08:52:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sam Protsenko" <semen.protsenko@linaro.org>,
 "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>, "Christoph Hellwig" <hch@lst.de>
Cc: "Chris Ball" <cjb@laptop.org>, "Will Newton" <will.newton@gmail.com>,
 "Matt Fleming" <matt@console-pimps.org>,
 "Christian Brauner" <brauner@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Sumit Semwal" <sumit.semwal@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K
Content-Type: text/plain

On Thu, Mar 7, 2024, at 00:20, Sam Protsenko wrote:
> Commit 616f87661792 ("mmc: pass queue_limits to blk_mq_alloc_disk") [1]
> revealed the long living issue in dw_mmc.c driver, existing since the
> time when it was first introduced in commit f95f3850f7a9 ("mmc: dw_mmc:
> Add Synopsys DesignWare mmc host driver."), also making kernel boot
> broken on platforms using dw_mmc driver with 16K or 64K pages enabled,
> with this message in dmesg:
>
>     mmcblk: probe of mmc0:0001 failed with error -22
>
> That's happening because mmc_blk_probe() fails when it calls
> blk_validate_limits() consequently, which returns the error due to
> failed max_segment_size check in this code:
>
>     /*
>      * The maximum segment size has an odd historic 64k default that
>      * drivers probably should override.  Just like the I/O size we
>      * require drivers to at least handle a full page per segment.
>      */
>     ...
>     if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
>         return -EINVAL;
>
> In case when IDMAC (Internal DMA Controller) is used, dw_mmc.c always
> sets .max_seg_size to 4 KiB:
>
>     mmc->max_seg_size = 0x1000;
>
> The comment in the code above explains why it's incorrect. Arnd
> suggested setting .max_seg_size to .max_req_size to fix it, which is
> also what some other drivers are doing:
>
>    $ grep -rl 'max_seg_size.*=.*max_req_size' drivers/mmc/host/ | \
>      wc -l
>    18

Nice summary!

> This change is not only fixing the boot with 16K/64K pages, but also
> leads to a better MMC performance. The linear write performance was
> tested on E850-96 board (eMMC only), before commit [1] (where it's
> possible to boot with 16K/64K pages without this fix, to be able to do
> a comparison). It was tested with this command:
>
>     # dd if=/dev/zero of=somefile bs=1M count=500 oflag=sync
>
> Test results are as follows:
>
>   - 4K pages,  .max_seg_size = 4 KiB:                   94.2 MB/s
>   - 4K pages,  .max_seg_size = .max_req_size = 512 KiB: 96.9 MB/s
>   - 16K pages, .max_seg_size = 4 KiB:                   126 MB/s
>   - 16K pages, .max_seg_size = .max_req_size = 2 MiB:   128 MB/s
>   - 64K pages, .max_seg_size = 4 KiB:                   138 MB/s
>   - 64K pages, .max_seg_size = .max_req_size = 8 MiB:   138 MB/s

Thanks for sharing these results. From what I can see here, the
performance changes significantly with the page size, but barely
with the max_seg_size, so this does not have the effect I was
hoping for. On a more positive note this likely means that we
don't have to urgently backport your fix.

This could mean that either there is not much coalescing across
pages after all, or that the bottleneck is somewhere else.

> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8e2d676b9239..cccd5633ff40 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2951,8 +2951,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>  	if (host->use_dma == TRANS_MODE_IDMAC) {
>  		mmc->max_segs = host->ring_size;
>  		mmc->max_blk_size = 65535;
> -		mmc->max_seg_size = 0x1000;
> -		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> +		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> +		mmc->max_seg_size = mmc->max_req_size;

The change looks good to me.

I see that the host->ring_size depends on PAGE_SIZE as well:

#define DESC_RING_BUF_SZ        PAGE_SIZE
host->ring_size = DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr);
host->sg_cpu = dmam_alloc_coherent(host->dev,
               DESC_RING_BUF_SZ, &host->sg_dma, GFP_KERNEL);

I don't see any reason for the ring buffer size to be tied to
PAGE_SIZE at all, it was probably picked as a reasonable
default in the initial driver but isn't necessarily ideal.

From what I can see, the number of 4KB elements in the
ring can be as small as 128 (4KB pages, 64-bit addresses)
or as big as 4096 (64KB pages, 32-bit addresses), which is
quite a difference. If you are still motivated to drill
down into this, could you try changing DESC_RING_BUF_SZ
to a fixed size of either 4KB or 64KB and test again
with the opposite page size, to see if that changes the
throughput?

If a larger ring buffer gives us significantly better
throughput, we may want to always use a higher number
independent of page size. On the other hand, if the
64KB number (the 138MB/s) does not change with a smaller
ring, we may as well reduce that in order to limit the
maximum latency that is caused by a single I/O operation.

     Arnd

