Return-Path: <linux-kernel+bounces-108792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDDA881004
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADCE1C22EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972612D05C;
	Wed, 20 Mar 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsyCbhlA"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF44C33C8;
	Wed, 20 Mar 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931009; cv=none; b=tgmCm05sCU+yy4bRw0s2aj+liphaxHpvSWknuUgtufZtcBhVMmt0hqwuP5rRcaRHXv7jTeKh1egp1WxtHM8CjgHyPPbnOlgep2leWdSosvCTtrjzQf4wCD0Wy43aVOqU1oLugh2gjE1iuyqBQBnHitRUjy9VKVFiIDcAYbI2njE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931009; c=relaxed/simple;
	bh=uD7yeDDKAgDkCyfxnMi1h58cXBkBZldpDdLbmyXzmxk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rRjvwxuD9P6XHpaSg3w9n3uIlaocJCnoxY6X7nS3WgPPuiegvlQ4sbncpPXnsgKDuuwu4E1XaYGZVkuQLG+WXtwUoYr3KC1FdVfgxdSldBUHh9OtqQHAU53ITWecD95NJ3L9cZnl1GmvBEMxu+9iutNz0m9kjmm/vSzRwtGYjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsyCbhlA; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso223237566b.3;
        Wed, 20 Mar 2024 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710931006; x=1711535806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tE11unCgfqxEW9yCQd9IYqKoscAT7LusykWb18rUm+U=;
        b=XsyCbhlAnJbfsL147Beb6uwzec6uf4ou4Wza/t76mj8yNpnB4I1bB7QYvuA0isa88C
         NRMGW2GsN7D1lk15F/m0utf6N7K4eOrb65ljKB0e02rwi/OvnXLCc3yb6CEQx722T02a
         SrVCHZ1jIvXs5MtHozRW/Tfj0xvymdEP/RB33yRPmaG1t4TUsNhBIlBQRjMtsoFa/4i8
         5zTorseE5sBMaV1R5YWNxBZQjNA0n3GLTDXxB518l0R1U/J39RVUNjzAbQ6rswWnuPUN
         XgYcYm6NOo9IXw/6qQPyARztfTbvppJZ8BkAIsO8oa/4x685fZZuaP1sqJwRSgfI2F2q
         7E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710931006; x=1711535806;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tE11unCgfqxEW9yCQd9IYqKoscAT7LusykWb18rUm+U=;
        b=g904XjrmW0fDQczV4XccBN9xAzeITOIDgj58EbyAJFTVkTNYQBqaSoGJ3CA1xvtoPa
         NK333FWXYk/2fPamfAd7oNR53Rg1o15usxbCV8HbVC+bbnFMSh0EfIv6JZcoZLMK3H+w
         tNUFh7E6WTXF37eevEdIjNxakGPU0Q8o4d6JXv3EfEOER6PMYmGyvgP6QccvxFnw4PlZ
         W6hY0knjmUwDTeCSk4GG8hA/Qn0oGp/qYXhAOp1IOZiHXUhy6/eJ0L0Mh+F4WuCG559G
         3jCzpTMrw0j8VHz92o9RLlPRgF1xZu1MAOnvOlDZNusKADTPGeWQP/d7oSxxPcUu2NFh
         Ia5A==
X-Forwarded-Encrypted: i=1; AJvYcCUVHcAD+11iommkz2Al2HmQr4MLqSRJbup9K7f1iDFTb+4xyyWT8Woj64lAVRJy/VRAnJIfj+9C28rqMahdJc2BojDkBa6YjGhp+SbwsEUyqiZtCvatpR5/CFVMUSD/ZOII6NhCBsnm
X-Gm-Message-State: AOJu0YzWa6BdcaemjJVxHxWonwi9MpRM/k1+fHLI1L3+ORqXemOZHwSg
	DIYxf5DwMpSrGguMR0sWNXdIEtBlgzAQGu2UtVOf3BlC7gSM/BKJA/N6qSDOtBUZCLmgBvn+Wfk
	5PoRMjCx+u2cb2+mtziIFqTh531GOLwyXrYQM5A==
X-Google-Smtp-Source: AGHT+IHHeypJJTI7Id0KWEulquens6W0HmqkMTNJyTyzGNFXO5qcL5HKvVVfuNGStMdqem7ltSPKDF0T9Glng0wGKeY=
X-Received: by 2002:a17:906:b74a:b0:a46:6ba1:4c8c with SMTP id
 fx10-20020a170906b74a00b00a466ba14c8cmr11757016ejb.44.1710931005990; Wed, 20
 Mar 2024 03:36:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Wed, 20 Mar 2024 13:36:34 +0300
Message-ID: <CALHCpMiUfa0j46HcorZGPDPV5Zg5ZFdWukT+5jTediuKJuoB5w@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
To: serghox@gmail.com
Cc: adrian.hunter@intel.com, jyanchou@realtek.com, 
	open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, 
	quic_asutoshd@quicinc.com, ritesh.list@gmail.com, shawn.lin@rock-chips.com, 
	Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Subject: [PATCH v7 0/2] mmc: sdhci-of-dwcmshc: Add CQE support

Hi Sergey, Adrian!

First of all I want to thank Sergey for supporting the CQE feature
on the DWC MSHC controller.

I tested this series on the LicheePi 4A board (TH1520 SoC).
It has the DWC MSHC IP too and according to the T-Head datasheet
it also supports the CQE feature.

> Supports Command Queuing Engine (CQE) and compliant with eMMC CQ HCI.

So, to enable CQE on LicheePi 4A need to set a prop in DT
and add a IRQ handler to th1520_ops:
> .irq = dwcmshc_cqe_irq_handler,

And the CQE will work for th1520 SoC too.

But, when I enabled the CQE, I was faced with a strange effect.

The fio benchmark shows that emmc works ~2.5 slower with enabled CQE.
219MB/s w/o CQE vs 87.4MB/s w/ CQE. I'll put logs below.

I would be very appreciative if you could point me where to look for
the bottleneck.

Without CQE:

# cat /sys/kernel/debug/mmc0/ios
clock:          198000000 Hz
actual clock:   198000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    10 (mmc HS400 enhanced strobe)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

# fio --filename=/dev/mmcblk0 --direct=1 --rw=randread --bs=1M
--ioengine=sync --iodepth=256 --size=4G --numjobs=1 --group_reporting
--name=iops-test-job --eta-newline=1 --readonly
iops-test-job: (g=0): rw=randread, bs=(R) 1024KiB-1024KiB, (W)
1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioengine=sync, iodepth=256
fio-3.34
Starting 1 process
note: both iodepth >= 1 and synchronous I/O engine are selected, queue
depth will be capped at 1
Jobs: 1 (f=1): [r(1)][15.0%][r=209MiB/s][r=209 IOPS][eta 00m:17s]
Jobs: 1 (f=1): [r(1)][25.0%][r=208MiB/s][r=208 IOPS][eta 00m:15s]
Jobs: 1 (f=1): [r(1)][35.0%][r=207MiB/s][r=207 IOPS][eta 00m:13s]
Jobs: 1 (f=1): [r(1)][47.4%][r=208MiB/s][r=208 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [r(1)][52.6%][r=209MiB/s][r=208 IOPS][eta 00m:09s]
Jobs: 1 (f=1): [r(1)][63.2%][r=208MiB/s][r=208 IOPS][eta 00m:07s]
Jobs: 1 (f=1): [r(1)][68.4%][r=208MiB/s][r=207 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [r(1)][78.9%][r=207MiB/s][r=207 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [r(1)][89.5%][r=209MiB/s][r=209 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [r(1)][100.0%][r=209MiB/s][r=209 IOPS][eta 00m:00s]
iops-test-job: (groupid=0, jobs=1): err= 0: pid=132: Thu Jan  1 00:03:44 1970
  read: IOPS=208, BW=208MiB/s (219MB/s)(4096MiB/19652msec)
    clat (usec): min=3882, max=11557, avg=4778.37, stdev=238.26
     lat (usec): min=3883, max=11559, avg=4779.93, stdev=238.26
    clat percentiles (usec):
     |  1.00th=[ 4359],  5.00th=[ 4555], 10.00th=[ 4555], 20.00th=[ 4621],
     | 30.00th=[ 4621], 40.00th=[ 4686], 50.00th=[ 4752], 60.00th=[ 4817],
     | 70.00th=[ 4883], 80.00th=[ 4948], 90.00th=[ 5014], 95.00th=[ 5145],
     | 99.00th=[ 5473], 99.50th=[ 5538], 99.90th=[ 5932], 99.95th=[ 6915],
     | 99.99th=[11600]
   bw (  KiB/s): min=208896, max=219136, per=100.00%, avg=213630.77,
stdev=1577.33, samples=39
   iops        : min=  204, max=  214, avg=208.56, stdev= 1.55, samples=39
  lat (msec)   : 4=0.39%, 10=99.58%, 20=0.02%
  cpu          : usr=0.38%, sys=13.04%, ctx=4132, majf=0, minf=275
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=4096,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=208MiB/s (219MB/s), 208MiB/s-208MiB/s (219MB/s-219MB/s),
io=4096MiB (4295MB), run=19652-19652msec

Disk stats (read/write):
  mmcblk0: ios=8181/0, merge=0/0, ticks=25682/0, in_queue=25682, util=99.66%


With CQE:

fio --filename=/dev/mmcblk1 --direct=1 --rw=randread --bs=1M --ioengine=sync -
-iodepth=256 --size=4G --numjobs=1 --group_reporting --name=iops-test-job --eta-
newline=1 --readonly
iops-test-job: (g=0): rw=randread, bs=(R) 1024KiB-1024KiB, (W)
1024KiB-1024KiB, (T) 1024KiB-1024KiB, ioeng
ine=sync, iodepth=256
fio-3.34
Starting 1 process
note: both iodepth >= 1 and synchronous I/O engine are selected, queue
depth will be capped at 1
Jobs: 1 (f=1): [r(1)][5.8%][r=83.1MiB/s][r=83 IOPS][eta 00m:49s]
Jobs: 1 (f=1): [r(1)][10.0%][r=84.0MiB/s][r=84 IOPS][eta 00m:45s]
Jobs: 1 (f=1): [r(1)][14.0%][r=83.1MiB/s][r=83 IOPS][eta 00m:43s]
Jobs: 1 (f=1): [r(1)][18.0%][r=83.1MiB/s][r=83 IOPS][eta 00m:41s]
Jobs: 1 (f=1): [r(1)][22.4%][r=84.1MiB/s][r=84 IOPS][eta 00m:38s]
Jobs: 1 (f=1): [r(1)][26.5%][r=83.1MiB/s][r=83 IOPS][eta 00m:36s]
Jobs: 1 (f=1): [r(1)][30.6%][r=83.1MiB/s][r=83 IOPS][eta 00m:34s]
Jobs: 1 (f=1): [r(1)][34.7%][r=84.1MiB/s][r=84 IOPS][eta 00m:32s]
Jobs: 1 (f=1): [r(1)][38.8%][r=83.1MiB/s][r=83 IOPS][eta 00m:30s]
Jobs: 1 (f=1): [r(1)][42.9%][r=83.1MiB/s][r=83 IOPS][eta 00m:28s]
Jobs: 1 (f=1): [r(1)][46.9%][r=84.1MiB/s][r=84 IOPS][eta 00m:26s]
Jobs: 1 (f=1): [r(1)][51.0%][r=83.0MiB/s][r=83 IOPS][eta 00m:24s]
Jobs: 1 (f=1): [r(1)][55.1%][r=83.0MiB/s][r=83 IOPS][eta 00m:22s]
Jobs: 1 (f=1): [r(1)][59.2%][r=84.1MiB/s][r=84 IOPS][eta 00m:20s]
Jobs: 1 (f=1): [r(1)][63.3%][r=83.0MiB/s][r=83 IOPS][eta 00m:18s]
Jobs: 1 (f=1): [r(1)][67.3%][r=83.1MiB/s][r=83 IOPS][eta 00m:16s]
Jobs: 1 (f=1): [r(1)][71.4%][r=84.1MiB/s][r=84 IOPS][eta 00m:14s]
Jobs: 1 (f=1): [r(1)][75.5%][r=83.0MiB/s][r=83 IOPS][eta 00m:12s]
Jobs: 1 (f=1): [r(1)][79.6%][r=83.0MiB/s][r=83 IOPS][eta 00m:10s]
Jobs: 1 (f=1): [r(1)][83.7%][r=84.0MiB/s][r=84 IOPS][eta 00m:08s]
Jobs: 1 (f=1): [r(1)][87.8%][r=83.1MiB/s][r=83 IOPS][eta 00m:06s]
Jobs: 1 (f=1): [r(1)][91.8%][r=83.0MiB/s][r=83 IOPS][eta 00m:04s]
Jobs: 1 (f=1): [r(1)][95.9%][r=84.0MiB/s][r=84 IOPS][eta 00m:02s]
Jobs: 1 (f=1): [r(1)][100.0%][r=83.0MiB/s][r=83 IOPS][eta 00m:00s]
iops-test-job: (groupid=0, jobs=1): err= 0: pid=134: Thu Jan  1 00:02:19 1970
  read: IOPS=83, BW=83.3MiB/s (87.4MB/s)(4096MiB/49154msec)
    clat (usec): min=11885, max=14840, avg=11981.37, stdev=61.89
     lat (usec): min=11887, max=14843, avg=11983.00, stdev=61.92
    clat percentiles (usec):
     |  1.00th=[11863],  5.00th=[11994], 10.00th=[11994], 20.00th=[11994],
     | 30.00th=[11994], 40.00th=[11994], 50.00th=[11994], 60.00th=[11994],
     | 70.00th=[11994], 80.00th=[11994], 90.00th=[11994], 95.00th=[11994],
     | 99.00th=[12125], 99.50th=[12256], 99.90th=[12387], 99.95th=[12387],
     | 99.99th=[14877]
   bw (  KiB/s): min=83800, max=86016, per=100.00%, avg=85430.61,
stdev=894.16, samples=98
   iops        : min=   81, max=   84, avg=83.22, stdev= 0.89, samples=98
  lat (msec)   : 20=100.00%
  cpu          : usr=0.00%, sys=5.44%, ctx=4097, majf=0, minf=274
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=4096,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=256

Run status group 0 (all jobs):
   READ: bw=83.3MiB/s (87.4MB/s), 83.3MiB/s-83.3MiB/s
(87.4MB/s-87.4MB/s), io=4096MiB (4295MB), run=49154-
49154msec

Disk stats (read/write):
  mmcblk1: ios=8181/0, merge=0/0, ticks=69682/0, in_queue=69682, util=99.96%


Best regards,
Maksim

