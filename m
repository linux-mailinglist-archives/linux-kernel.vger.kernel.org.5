Return-Path: <linux-kernel+bounces-110041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29788593D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D621F25073
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7C51C2A;
	Thu, 21 Mar 2024 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="MDPFzU9Y"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155C83CAA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024780; cv=none; b=VHco5XK11kFPT5GHAxvXeCMZpVJA/ROWemWD31dbtfMDkkZ6p2MIkZs69aVlUyXXnmmq+B76t0yL/1GUKim2Jz8XvaFzTevQRCUchNXGmbCAbV7Trmjv2jWQGCasD9hpg6wfusE4FCskFfdXfrRBZzTO5RrnjZZKiWBwfyblRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024780; c=relaxed/simple;
	bh=Kmu3zbPUyay6XlM8mJYmGLdGinxyCQPn1imK7hIxqtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbBa90RaIhpVsBapeDuHlDkmMpq3ExK+u7u3DUqWxlCDDZBOoB/rloM0zNoh9fbkcBmFuxL7ayVSq/+UR+JykIaaJrI4fvMHR9w8Kf3UVlRPRdnPg37b81Allm20G48CYm5mOE/tJEpvy+sZRAdmkj6JQDD5b9Rdi3DD9k1cLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=MDPFzU9Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-414701303f7so8865575e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711024777; x=1711629577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNZ7vhsdbmv3tsfRVkzmFnvT+rAuDkFFXFyABvgWN9Y=;
        b=MDPFzU9YaM+C6XhbqR3xXXjhLmOsVF9+I887J+A/xBplZIuDh6mFQqFEB3iD37Lt4p
         uYM0JyS5Bfsbl5TVOjvIcGhwwhE8F2FDcN+5fgSwjG81XD9jPhAtPfS7wWhXFf6aHo79
         7bSB0SfICDUTq9bEz5UVNl/XbdRWWoxc1Cv2WJtLjkCGaMRRTDCuyprUx7foY+3ApO3X
         7kL7J6csWopnhUouhNMHLhBoaIojUZwwaz9BUVZwcvgdF+8wCJ+ZC8JABLa7Iv6M7n9w
         dXsh5VVj1IrCpNC43Nw2VGRlZGC3wXFXU4XOn1H8sJ+EPEAIiA8pv1pN9vvf7uI6Uf+J
         ot5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711024777; x=1711629577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNZ7vhsdbmv3tsfRVkzmFnvT+rAuDkFFXFyABvgWN9Y=;
        b=gmL7PgCAdLYDhHxiKqh3qutexdWFANntsvD6YhjcgeMD4pYcKO8KOPy+sB7rrZxnl0
         aupSw9iiQS5FxIZQ6OJXKSVcRb4IFAtIdM72t8hBKCZVLAMdLjuc+umezF7PveRAI1wo
         hW27pVz2HnQQomwzG6dW890u03ICvK2w4Sor7ulWsvcRM0ix7qA8DQsi8DoZhsSLudmc
         V0FTGonTRndiXNjUayoACULFB3WPylemzU3owNICof7ulbSasxa/HNq0M9FVcAAGydlB
         E73Yz+qCYioWOc7NRzX2WiLzL4tl4eoEefV11085PhPfm2vI+Gpt9mgJwme0oKzgHer6
         rw4A==
X-Forwarded-Encrypted: i=1; AJvYcCUBOw5j8Y55UZpwSjXnqk0dkAX5sz/XAhMx1nxX5xUPEWglZiHpkJM7zRla/lYkvmLMZgYkkX/N2WyTyrC0WHFifIZsPTFR8xCMMhMn
X-Gm-Message-State: AOJu0YyDEYsxOqa/zSduJapgigB4ePPXwVUzDTKthfnWYi/yc1h7V8zc
	DUN++iLKlMFhl/AASaOWEHZIkjeBGjWuYbqg4oUCkqKymf3vR/zbKwhzR00eAPk=
X-Google-Smtp-Source: AGHT+IGt57g28ARi2T1iW4asSHhR0gQbNaXQuJ3XP+Q0+k/8e4PFX+HjmNPJHcwMpW1JipVFYQAjyA==
X-Received: by 2002:a05:600c:4254:b0:414:5e91:124f with SMTP id r20-20020a05600c425400b004145e91124fmr1979948wmm.23.1711024777073;
        Thu, 21 Mar 2024 05:39:37 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b004146d736fcdsm4938670wmo.36.2024.03.21.05.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:39:36 -0700 (PDT)
Date: Thu, 21 Mar 2024 12:39:35 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
	rafael@kernel.org, dietmar.eggemann@arm.com, vschneid@redhat.com,
	vincent.guittot@linaro.org, Johannes.Thumshirn@wdc.com,
	adrian.hunter@intel.com, ulf.hansson@linaro.org, andres@anarazel.de,
	asml.silence@gmail.com, linux-pm@vger.kernel.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Introduce per-task io utilization boost
Message-ID: <20240321123935.zqscwi2aom7lfhts@airbuntu>
References: <20240304201625.100619-1-christian.loehle@arm.com>
 <86f0af00-8765-4481-9245-1819fb2c6379@acm.org>
 <0dc6a839-2922-40ac-8854-2884196da9b9@arm.com>
 <c5b7fc1f-f233-4d25-952b-539607c2a0cc@acm.org>
 <2784c093-eea1-4b73-87da-1a45f14013c8@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2784c093-eea1-4b73-87da-1a45f14013c8@arm.com>

(Thanks for the CC Bart)

On 03/06/24 10:49, Christian Loehle wrote:
> Hi Bart,
> 
> On 05/03/2024 18:36, Bart Van Assche wrote:
> > On 3/5/24 01:13, Christian Loehle wrote:
> >> On 05/03/2024 00:20, Bart Van Assche wrote:
> >>> On 3/4/24 12:16, Christian Loehle wrote:
> >>>> - Higher cap is not always beneficial, we might place the task away
> >>>> from the CPU where the interrupt handler is running, making it run
> >>>> on an unboosted CPU which may have a bigger impact than the difference
> >>>> between the CPU's capacity the task moved to. (Of course the boost will
> >>>> then be reverted again, but a ping-pong every interval is possible).
> >>>
> >>> In the above I see "the interrupt handler". Does this mean that the NVMe
> >>> controller in the test setup only supports one completion interrupt for
> >>> all completion queues instead of one completion interrupt per completion
> >>> queue? There are already Android phones and developer boards available
> >>> that support the latter, namely the boards equipped with a UFSHCI 4.0 controller.
> >>
> >> No, both NVMe test setups have one completion interrupt per completion queue,
> >> so this caveat doesn't affect them, higher capacity CPU is strictly better.
> >> The UFS and both mmc setups (eMMC with CQE and sdcard) only have one completion
> >> interrupt (on CPU0 on my setup).
> > 
> > I think that measurements should be provided in the cover letter for the
> > two types of storage controllers: one series of measurements for a
> > storage controller with a single completion interrupt and a second
> > series of measurements for storage controllers with one completion
> > interrupt per CPU.
> 
> Of the same type of storage controller? Or what is missing for you in
> the cover letter exactly (ufs/emmc: single completion interrupt,
> nvme: one completion interrupt per CPU).
> 
> > 
> >> FWIW you do gain an additional ~20% (in my specific setup) if you move the ufshcd
> >> interrupt to a big CPU, too. Similarly for the mmc.
> >> Unfortunately the infrastructure is far from being there for the scheduler to move the
> >> interrupt to the same performance domain as the task, which is often optimal both in
> >> terms of throughput and in terms of power.
> >> I'll go looking for a stable testing platform with UFS as you mentioned, benefits of this
> >> patch will of course be greatly increased.
> > 
> > I'm not sure whether making the completion interrupt follow the workload
> > is a good solution. I'm concerned that this would increase energy
> > consumption by keeping the big cores active longer than necessary. I
> > like this solution better (improves storage performance on at least
> > devices with a UFSHCI 3.0 controller): "[PATCH v2 0/2] sched: blk:
> > Handle HMP systems when completing IO"
> > (https://lore.kernel.org/linux-block/20240223155749.2958009-1-qyousef@layalina.io/).
> 
> That patch is good, don't get me wrong, but you still lose out by running everything
> up to blk_mq_complete_request() on (potentially) a LITTlE (that might be run on a low OPP),
> while having a big CPU available at a high OPP anyway ("for free").
> It is only adjacent to the series but I've done some measurements (Pixel6 again, same device
> as cover letter, Base is Android 6.6 mainline kernel (so without my series, but I somewhat forced
> the effects by task pinning), Applied is with both of sched: blk: Handle HMP systems when completing IO):

So you want the hardirq to move to the big core? Unlike softirq, there will be
a single hardirq for the controller (to my limited knowledge), so if there are
multiple requests I'm not sure we can easily match which one relates to which
before it triggers. So we can end up waking up the wrong core.

Generally this should be a userspace policy. If there's a scenario where the
throughput is that important they can easily move the hardirq to the big core
unconditionally and move it back again once this high throughput scenario is no
longer important.

Or where you describing a different problem?

Glad to see your series by the way :-) I'll get a chance to review it over the
weekend hopefully.


Cheers

--
Qais Yousef

> 
> Pretty numbers (IOPS):
> Base irq@CPU0 median: 6969
> Base irq@CPU6 median: 8407 (+20.6%)
> Applied irq@CPU0 median: 7144 (+2.5%)
> Applied irq@CPU6 median: 8288 (18.9%)
> 
> This is with psyncx1 4K Random Read again, of course anything with queue depth
> takes advantage of batch completions to significantly reduce irq pressure.
> 
> Not so pretty numbers and full list commands used:
> 
> w/o patch:
> irq on CPU0 (default):
> psyncx1: 7000 6969 7025 6954 6964
> io_uring4x128: 28766 28280 28339 28310 28349
> irq on CPU6:
> psyncx1: 8342 8492 8355 8407 8532
> io_uring4x128: 28641 28356 25908 25787 25853
> 
> with patch:
> irq on CPU0:
> psyncx1: 7672 7144 7301 6976 6889
> io_uring4x128: 28266 26314 27648 24482 25301
> irq on CPU6:
> psyncx1: 8208 8401 8351 8221 8288
> io_uring4x128: 25603 25438 25453 25514 25402
> 
> 
> for i in $(seq 0 4); do taskset c0 /data/local/tmp/fio_aosp_build --name=test --rw=randread --bs=4k --runtime=30 --time_based --filename=/dev/block/sda --minimal | awk -F ";" '{print $8}'; sleep 30; done
> 
> for i in $(seq 0 4); do taskset c0 /data/local/tmp/fio_aosp_build --name=test --rw=randread --bs=4k --runtime=30 --time_based --filename=/dev/block/sda --ioengine=io_uring --iodepth=128 --numjobs=4 --group_reporting --minimal | awk -F ";" '{print $8}'; sleep 30; done
> 
> echo 6 > /proc/irq/296/smp_affinity_list
> 
> 
> Kind Regards,
> Christian

