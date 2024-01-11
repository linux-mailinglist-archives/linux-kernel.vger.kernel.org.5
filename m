Return-Path: <linux-kernel+bounces-23325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC4682AB11
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28525B28295
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DDB15AD9;
	Thu, 11 Jan 2024 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loRrzx5M"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265D15AD7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e5f3b390fso3619095e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704965622; x=1705570422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YZVP+CQcVdj5PNGHVAEFPym8Eeh6QaRGrvosV6Ad1s=;
        b=loRrzx5M3AI/e7TgWhd9OZB8lIbwGSk6jnzFRpVzgOVbiqHOTLpLWoIhHAUb56fTKs
         u/X6pF2zJabfxD34hekhkMRHy3MqsRp5QnLE7+N7fbGFQN6rP6/YsbMaDEh3dp6MPECh
         x3y6d9cXbqosieNQMGfzBbn628nq3kK6GkkzmOIV4fG5w25R4DY9a87PsRjd3kOm3Cmz
         zq71M9HnARrzAV+g6amkE1wniQo7NK80nPvFbw0mcqS57ZxtpVL7qRdw967KyiaYd7QB
         y78E40zX11P+BGJ5U+7qTCmiCga+mq7MdTAtCtthcHvCjFDz+7Aep0TvJMbGWU+Nf+A4
         9Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704965622; x=1705570422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YZVP+CQcVdj5PNGHVAEFPym8Eeh6QaRGrvosV6Ad1s=;
        b=VoadG2VwWDX8fUFLW4Qlf35TMSGJ5kVCx5Dms87j5semMKix/gwoJNorfrO0ZVCmtX
         qdehIlMByo0pcZcTFMeCsGmH793ILXS/Nmo34zXaD+/agXSVkQhMXfzBAICi1kCrFWlI
         P1etxE9kA/GyGto3AX9eBSPwzZpfQz/ngzBTce17qyVJ2N3Gx/rlxugVCStndK3H2H3z
         VZBt2LFSK+8jJg2ILd4ImnChw6I+tc3pJgd6tj7MLL7pY178oN2H9Hw5EGIEEAqgBIxF
         vuP3SDeOK3yZTwI09wXmwL9bFVS+2P/SxfAoS1ZkcQshk3T5phlRoQ4QA6hpK8i6SKJ0
         sdxw==
X-Gm-Message-State: AOJu0Yz8DJdHXrIXKIlxLZHKQoE/ztEHoYBhh419+IIAbVUCvIzfHEcw
	SvpcWPyoVxpl4zsboNwcdM4=
X-Google-Smtp-Source: AGHT+IFtk/QqleOM9nDbjIjbcyXJZg0NuHmJ+AYjnTJJlB/neiOfnPyx8uVJkauE14LRebXthUNF8Q==
X-Received: by 2002:a05:600c:1d86:b0:40e:4920:8c5b with SMTP id p6-20020a05600c1d8600b0040e49208c5bmr234560wms.122.1704965622369;
        Thu, 11 Jan 2024 01:33:42 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0040d839e7bb3sm5136576wmb.19.2024.01.11.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:33:41 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 11 Jan 2024 10:33:39 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <ZZ+185pB84Ihovve@gmail.com>
References: <ZTz9RpZxfxysYCmt@gmail.com>
 <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 8 Jan 2024 at 06:07, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Please pull the latest sched/core git tree from:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-01-08
> 
> Just a note that I'm currently bisecting into this merge for a
> horrendous performance regression.
> 
> It makes my empty kernel build go from 22 seconds to 44 seconds, and
> makes a full kernel build enormously slower too.

Ouch, that's horrible ...

> I haven't finished the bisection, but it's now inside *just* this
> pull, so I can already tell that I'm going to revert something in
> here, because this has been making my merge window miserable.

Just as a quick test, does switching to the 'performance' governor work 
around the regression:

  for ((cpu=0; cpu < $(nproc); cpu++)); do echo performance > /sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor; done

Thanks,

	Ingo

