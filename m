Return-Path: <linux-kernel+bounces-12825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A581FA85
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7BE284AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F3101C8;
	Thu, 28 Dec 2023 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="hjh09u07"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE586F9E5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5d8a6730so17005345e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 10:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703788870; x=1704393670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iirN11FE11z2AdkUVp2pGSwKkOSOx/YMQULcIMI6Uxw=;
        b=hjh09u07DIuV2CKWvwWZbjVHsFyhjOCBdj14B07S8IT8i2Cye8vEc3TWoqrNwc1lfS
         seoaKEEMTXJbGdjgqsFY4h6vse/bdO7cbuMnpzwUrW9so/NdxEWuS1/gtbi+OIbmeX7X
         D3b3sRq7H35lpzC3bEccmZrZHduQRhaPIxu0CJzi7EnbAX0pSqRzTLZxZmCTvlEjmG2f
         MPreL2I24hF2ToNpJgNBUPqQAJwrvgzlWAt3ZuPiB4zKva+h6OoEeuQZIGvLns3vkNWC
         Pk65Pg7qVuQolvadAtJnp5GUK7+z7/n6jcybbSt+PLwdLmzwlCt+43ncCjb6tunLKWRc
         7KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703788870; x=1704393670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iirN11FE11z2AdkUVp2pGSwKkOSOx/YMQULcIMI6Uxw=;
        b=L8Q4DRkAS0flOAF24wNBnouUHCETQZbo08eCUGgVtBMx3RmhQczBoe912fPnr+0Fln
         1FQc8t7Zg213XeHAKk9bTzVhxeBDuwH+ZSgW+EqBPJZCsb1Ht8dKuL/dnVjjHym2DavB
         ymbf9ZrycmZI6UQUFSsURPxSqSppub+OxVNrlZx55q2Cp5mxliIHpBB4TFp6G/KvAtsr
         w4N/FvREfORQbIp66NFsNOH1YYTxBVe6jgsoHIZ1kjv+Jg8KRAgcio1xA6aa4Fvxae1C
         gi6zV0PqApDfrmEvuzRcrhJDPPSehTcKINTJWY0wgdjXvMAwUK2OpKVTgXdCszDvq8mW
         tQbA==
X-Gm-Message-State: AOJu0YxuCnE0uYTux0VIWARIBffXJXlEz/SonwS1Zw3mdVEuB0OOpPFS
	QO5d/UfyyQ+yKf5YgEv0yI9Eh5dExz3lTw==
X-Google-Smtp-Source: AGHT+IHWj78iSvO6jk95Dkf+/uo1cOMc9yitSOcHmHmGWYFDksWTIcftoBEFIZ53Zh1lXLYIDCFqLw==
X-Received: by 2002:a05:600c:5492:b0:40d:6025:3650 with SMTP id iv18-20020a05600c549200b0040d60253650mr1261241wmb.30.1703788869859;
        Thu, 28 Dec 2023 10:41:09 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id f8-20020adffcc8000000b003366b500047sm17552067wrs.50.2023.12.28.10.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 10:41:09 -0800 (PST)
Date: Thu, 28 Dec 2023 18:41:07 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 00/23] Introduce runtime modifiable Energy Model
Message-ID: <20231228184107.mfxgfwaclwaeqswg@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231217182255.mgrpgpu6ojjg62jp@airbuntu>
 <4f780b5e-7e37-40e3-bdf1-d7fe5d8dd1fc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f780b5e-7e37-40e3-bdf1-d7fe5d8dd1fc@arm.com>

On 12/19/23 10:22, Lukasz Luba wrote:

> > One thing I'm not sure about is that in practice temperature of the SoC can
> > vary a lot in a short period of time. What is the expectation here? I can see
> > this useful in practice only if we average it over a window of time. Following
> > it will be really hard. Big variations can happen in few ms scales.
> 
> It's mostly for long running heavy workloads, which involve other device
> than CPUs, e.g. GPU or ISP (Image Signal Processor). Those devices can
> heat up the SoC. In our game DrArm running on pixel6 the GPU uses 75-77%
> of total power budget (starting from ~2.5W for GPU + 1.3W for all CPUs).
> That 2.5W from the GPU is heating up the CPUs and mostly impact the Big
> cores, which are made from High-Performance cells (thus leaking more).
> OverUtilization in the first 4-5min of gaming is ~4-9%, so EAS can work
> and save some power, if it has a good model. Later we have thermal
> throttling and OU goes to ~50% but EAS still can work. If the model is
> more precised - thus adjusted for the raising leakage due to temperature
> increase (generated due to GPU power), than we still can use better that
> power budget and not waist on the leakage at higher OPPs.

I can understand the need. But looking at one specific case vs generalized form
is different.

So IIUC the expectation is to track temperature variations over minutes by
external sources to CPU.

> > I didn't get how the new performance field is supposed to be controlled and
> > modified by users. A driver interface doesn't seem suitable as there's no
> > subsystem that knows the characteristic of the workload except userspace. In
> > Android we do have contextual info about what the current top-app to enable
> > modifying the capacities to match its characteristics.
> 
> Well in latest public documentation (May2023) for Cortex-X4 there are
> described new features of Arm cores: PDP, MPMM, which can change the
> 'performance' of the core in FW. Our SCMI kernel subsystem will get an
> interrupt, so the drivers can know about it. It could be used for
> recalculating the efficiency of the CPUs in the EM. When there is no
> hotplug and the long running app is still running, that FW policy would
> be reflected in EM. It's just not done all-in-one-step. Those patches
> will be later.

I think these features are some form of thermal throttling IIUC.

I was asking for handling the EM accuracy issue using the runtime model. I was
expecting some sysfs knobs. Do you see this also require a vendor specific
driver to try to account for the EM inaccuracy issues we're seeing?

> Second, I have used that 'performance' field to finally get rid of
> this runtime division in em_cpu_energy() hot path - which was annoying
> me for very long time. It wasn't possible to optimize that last
> operation there, because the not all CPUs boot and final CPU capacity
> is not known when we register EMs. With this feature finally I can
> remove that heavy operation. You can see more in that patch 15/23.

Yep, it's good addition :)

> > > 5. All CPUs (Little+Mid+Big) power values in mW
> > > +------------+--------+---------------------+-------+-----------+
> > > |  channel   | metric |       kernel        | value | perc_diff |
> > > +------------+--------+---------------------+-------+-----------+
> > > |    CPU     | gmean  | EM_default          | 142.1 |   0.0%    |
> > > |    CPU     | gmean  | EM_modified_runtime | 131.8 |  -7.27%   |
> > > +------------+--------+---------------------+-------+-----------+
> > 
> > How did you modify the EM here? Did you change both performance and power
> > fields? How did you calculate the new ones?
> 
> It was just the power values modified on my pixel6:
> for Littles 1.6x, Mid 0.8x, Big 1.3x of their boot power.
> TBH I don't know the chip binning of that SoC, but I suspect it
> could be due to this fact. More about possible error range in chip
> binning power values you can find in my comment to the patch 22/23

Strange just modifying the power had this impact. It could be related to
similar impact I've seen with migration margin for the little increasing. By
making the cost higher there, then it'd move the residency to other cores and
potentially reduce running at higher freq on the littles.

> > Did you try to simulate any heating effect during the run if you're taking
> > temperature into account to modify the power? What was the variation like and
> 
> Yes, I did that experiment and presented on OSPM 2023 slide 13. There is
> big CPU power plot change in time, due to GPU heat. All detailed data is
> there. The big CPU power is ~18-20% higher when 1-1.5W GPU is heating up
> the whole SoC.

I meant during your experiment above.

> > at what rate was the EM being updated in this case? I think Jankbench in
> 
> In this experiment EM was only set once w/ the values mentioned above.
> It could be due to the chip lottery. I cannot say on 100% this phone.
> 
> > general wouldn't stress the SoC enough.
> 
> True, this test is not power heavy as it can be seen. It's more
> to show that the default EM after boot might not be the optimal one.

I wouldn't reach that conclusion for this particular case. But the underlying
issues exists for sure.

> > It'd be insightful to look at frequency residencies between the two runs and
> > power breakdown for each cluster if you have access to them. No worries if not!
> 
> I'm afraid you're asking for too much ;)

It should be easy to get them. It's hard to know where the benefit is coming
from otherwise. But as I said, no worries if not. If you have perfetto traces
I can take help to take a look.

> > My brain started to fail me somewhere around patch 15. I'll have another look
> > some time later in the week but generally looks good to me. If I have any
> > worries it is about how it can be used with the provided interfaces. Especially
> > expectations about managing fast thermal changes at the level you're targeting.
> 
> No worries, thanks for the review! The fast thermal changes, which are
> linked to the CPU's workload are not an issue here and I'm not worried
> about those. The side effect of the heat from other device is the issue.
> Thus, that thermal driver which modifies the EM should be aware of the
> 'whole SoC' situation (like mainline IPA does, when it manages all
> devices in a single thermal zone).

I think in practice there will be challenges to generalize the thermal impact.
But overall from EM accuracy point of view (for all the various reasons
mentioned), we need this ability to help handle them in practice. Booting with
a single hardcoded EM doesn't work.


Cheers

--
Qais Yousef

