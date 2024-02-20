Return-Path: <linux-kernel+bounces-72838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D75485B935
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96D3B225F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F372D626C6;
	Tue, 20 Feb 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqfaYjjG"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4514A3F8DA;
	Tue, 20 Feb 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425489; cv=none; b=Y+4b8WMTdoEetIgcNaYspm8CXZs4PZ/RluC8P+0sWoH/AqYtHZEv1AXCltH23Mm8dGXq6BkCIdut63EXcHf3o/vseGmernIxU0QKeqlWilbzlC32VMmOPP7vxV1avFLyLw4b37pVkNSsDmnRH5/DUZE6PMcSQEveu6nbSbp26PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425489; c=relaxed/simple;
	bh=gqWnEVrj6X8koguCh/1V12vPu9u8+ATIHeDKJrUt/s8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKh5ouAjLT46gsKLBXpxIHU1zBM5cbZ8ejUUmtB6k1kMgPi8f8i/6Tg7QY5Is1DZRypQhtWWPqjtDBTwIA2IQt5ryiN71uuIk6mBPmgsZoMOPjfRk7lok0/qPa5V/RxAvviVTnQc01nXutwhQkTqEMMSciTyp5X2tZGFDgz+CSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqfaYjjG; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d23114b19dso27472051fa.3;
        Tue, 20 Feb 2024 02:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708425485; x=1709030285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBZStbmfbW8oAFFBuO7N8jZ1T2yrIqknOAfWmwW0P2U=;
        b=cqfaYjjGSYKkZYkz5agZV4LaeRPnMUPaeOncphuxkK4KJ2HkYirb8gNYn8c85N0tdh
         hDgYvfN7xvx50u+zaX7P7N49v22T3RXEpbYwanyrMW/4HNd1Y5f2mkJIIrrrK4c9eCpL
         UE0WBKagN2gOp81FFfTeslbMdDCoCY5qCbCrv5eA+ueKIcUJ+5Vdk2r3cbPtSQGXdFO0
         kermyF0Kd/sMQ5DDT2Rc04Tfngc/14s87UhIaKJEjwh0z3V9yvclJ1yTTu8P5gaKZ8+k
         DcoVKiNJSo8Shsk3SV9PjE9KvFrWL0DMmHAIgDHdumXuJagbS3dz7AO77QPvcPGLaBth
         8Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708425485; x=1709030285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBZStbmfbW8oAFFBuO7N8jZ1T2yrIqknOAfWmwW0P2U=;
        b=d3T7sF2m2Y3U0RlCslcPCc2uY7A7aY1hLPdmqWVpLYIb3K2dJRbqNiHKVLPfEUmdiO
         qcpbeFPlWHZ61DNfk8Y/+tYCP/asLwGtlxMqbHRzqRRlXpGGwWKtztpq3ISOsMBcR2+q
         9NeYIAA26wioRus44cQrt/9Q98SMAVNUHECNSxTm22F37b3HxZ6rwr9dwYk57XWrpCPf
         HhGtwMvzNcG6f7mEXCQhaWM1+EU659DqZlZD/npkvKI3oDjyrxP7YZIUQ4yw8JpnM/mf
         +DJCDw4kHXcbBUiRGfPQW0G6Qr++mdz7khP+FFg9qE0FWLRT5x9cjgW3+pZq1P6L8UiU
         W7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0gXV3DR3pLbtRIAQRMmMECX51ApS3VkEEaj7Ab1DmXhtGVhM8jQchgIbfkSFCVnRm0InDNyKEkh2xUBQHPpgNwAS10CALCCF1pCs3aF7lV/MjPCjfA/70kj4flNhwAMSI96jvjuUrkOk=
X-Gm-Message-State: AOJu0YylGwFcAiOcr5Jo0FC8TqUL8/GzDCDKgvwpRbq9z8ltS0Uj1kzY
	qyBjKp10m9bTShMgUsZU7hFNxA6aiktXwCEJHsMQuuzj9A2XuFI4xWEBFJjp+8VWqy3/I7M4Alb
	1DRTEpF8SWBWp3NLGEnUMglWiNzU=
X-Google-Smtp-Source: AGHT+IEuVsXgUq+eQ53PbbS56/RjDp4lMGD4iplxPf5avdZr6hPkxYbE8rlfJcVz8tbT6kdv99wIV5tg1mZkZlplz4Q=
X-Received: by 2002:a2e:9d84:0:b0:2d2:4800:5fe with SMTP id
 c4-20020a2e9d84000000b002d2480005femr1302916ljj.35.1708425484831; Tue, 20 Feb
 2024 02:38:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220061542.489922-1-zhaoyang.huang@unisoc.com>
 <20240220061542.489922-2-zhaoyang.huang@unisoc.com> <ZdR0DtDCWWFkSiUn@infradead.org>
In-Reply-To: <ZdR0DtDCWWFkSiUn@infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 20 Feb 2024 18:37:53 +0800
Message-ID: <CAGWkznFAFk6Z_1_omCSm_SupN6PA+ORjsjyFwqu6W=nxnDY8Qg@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: adjust CFS request expire time
To: Christoph Hellwig <hch@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:42=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Feb 20, 2024 at 02:15:42PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > According to current policy, CFS's may suffer involuntary IO-latency by
> > being preempted by RT/DL tasks or IRQ since they possess the privilege =
for
> > both of CPU and IO scheduler.
>
> What is 'current policy', what is CFS, what is RT/DL?  What privilege
> is possessed?
CFS and RT/DL are types of sched class in which CFS has the least
privilege to get CPU.
IMO, =E2=80=98current policy=E2=80=99 refers to two perspectives:
1. the RT task in the same core with the CFS task gets privileges in
both CPU and IO scheduler(deadline on duty) than CFS. Could we make
the CFS requests' expire_time be earlier than it used to be now.
2. In terms of the timing of inserting the request, preempted CFS
tasks lose the fairness involuntary when compared with none-preempted
CFS tasks. Could we decrease this impact in some way.
>
> > 1. All types of sched class's load(util) are tracked and calculated in =
the
> > same way(using a geometric series which known as PELT)
> > 2. Keep the legacy policy by NOT adjusting rq's position in fifo_list
> > but only make changes over expire_time.
> > 3. The fixed expire time(hundreds of ms) is in the same range of cpu
> > avg_load's account series(the utilization will be decayed to 0.5 in 32m=
s)
>
> What problem does this fix, i.e. what performance number are improved
> or what other effects does it have?
I have verified this commit via some benchmark tools like fio and
Androbench. Neither regression nor improvement is found. By analysing
the log below[2], where I find that CFS occupies most of the CPU for
the most part. If it makes more sense in the way of [1] where CFS is
over-preempted than a threshold.

[1]
-               rq->fifo_time =3D jiffies + dd->fifo_expire[data_dir];

                /*adjust expire time when cfs is over-preempted than 50%*/
+              fifo_expire =3D cfs_prop_by_util(current,100) < 50 ?
dd->fifo_expire[data_dir] :
+                       cfs_prop_by_util(current, dd->fifo_expire[data_dir]=
);
+               rq->fifo_time =3D jiffies + fifo_expire;

[2]
//prop is the proportion of CFS's util which is mostly above 90(90%)
during common benchmark test
   kworker/u16:3-73      [000] ...1.   321.140143: dd_insert_request:
dir 1,cfs 513, prop 91, orig_expire 1250, expire 1149
   kworker/u16:3-73      [000] ...1.   321.140414: dd_insert_request:
dir 1,cfs 513, prop 91, orig_expire 1250, expire 1149
   kworker/u16:3-73      [000] ...1.   321.140505: dd_insert_request:
dir 1,cfs 513, prop 91, orig_expire 1250, expire 1149
   kworker/u16:3-73      [000] ...1.   321.140574: dd_insert_request:
dir 1,cfs 513, prop 91, orig_expire 1250, expire 1149
   kworker/u16:3-73      [000] ...1.   321.140630: dd_insert_request:
dir 1,cfs 513, prop 91, orig_expire 1250, expire 1149
   kworker/u16:3-73      [000] ...1.   321.140682: dd_insert_request:
dir 1,cfs 513, prop 91, orig_expire 1250, expire 1149
   kworker/u16:3-73      [000] ...1.   321.140736: dd_insert_request:
dir 1,cfs 513, prop 91, orig_expire 1250, expire 1149
              dd-7296    [006] ...1.   321.143139: dd_insert_request:
dir 0,cfs 610, prop 92, orig_expire 125, expire 115
              dd-7296    [006] ...1.   321.143287: dd_insert_request:
dir 0,cfs 610, prop 92, orig_expire 125, expire 115
              dd-7296    [004] ...1.   321.156074: dd_insert_request:
dir 0,cfs 691, prop 97, orig_expire 125, expire 122
              dd-7296    [004] ...1.   321.156202: dd_insert_request:
dir 0,cfs 691, prop 97, orig_expire 125, expire 122

>
> > +              * The expire time is adjusted via calculating the propor=
tion of
> > +              * CFS's activation among whole cpu time during last seve=
ral
> > +              * dazen's ms.Whearas, this would NOT affect the rq's pos=
ition in
> > +              * fifo_list but only take effect when this rq is checked=
 for its
> > +              * expire time when at head.
> >                */
>
> Please speel check the comment and fix the formatting to have white
> spaces after sentences and never exceed 80 characters in block comments.
ok.
>

