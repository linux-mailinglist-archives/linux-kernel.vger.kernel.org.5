Return-Path: <linux-kernel+bounces-20986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD251828824
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1068F1C23641
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D96526AFD;
	Tue,  9 Jan 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNCafcL3"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652031391
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2278710a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704810663; x=1705415463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d3HXRcKDVxJPTXyXJSN6jduIbifNRx9OK443HIjFR3c=;
        b=uNCafcL3BbzriyQNRDfLPsysHiWA0xiGo1soCwY9H5k4/YXABvsNn+ch3oLKdxHBgK
         0xBcwdCI6eDD283MK41rFiTEHJXGzx5f+8jTrBWF8PkvC1Y+SL9a6W9+ZNQ1qOqXtdrW
         zNdDa80CyA5jrt/2AGxZuKQKaX5RemiAcBm94SpDGmhRCws7DsPislkMFGy5FHBAGs8P
         EUa/k6CDUM8trkRKY5Yl7aqeGH9R4185NUbQeBNDOWFCGKl5ixOdukYr1d4IpITzZI/c
         +4hqgqluZEoRKpWh21xf8eW7r9gz+ECGdIpG9hDOoIhbM/YElNbORxQKTC9mH4Wh7rAo
         8Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704810663; x=1705415463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3HXRcKDVxJPTXyXJSN6jduIbifNRx9OK443HIjFR3c=;
        b=Ir/su4enrQ8+4/XgoI4gWU489MwpHCYmYgT93NdglSY7CLyVKo5vMo5lZUZXFOdmbg
         HNSgVJasdAr+9TA1w3LPBTClHahrbcZA02wVc1h00nmcKFLjNIb0/NsJz7BciIMp8385
         sItU2BeDnAAviyjDDDb+Mxg4j87rAQ36p5J4r/BWsqT8Uj4FCSEoQbtqWPTWVH2BZMKI
         E8w8j959/svQlEvFykzDzs6FoyCQrIaSjT74MYl8xc4QAn+UgJ/u9qImUN+oCkQgoUXD
         zCJ7epghTvm9nve1S3cNvHXwrxj8WHPCIvPngVKXXQi7v9e8N67Hxfdu9i6Zyqcsehqt
         /EVQ==
X-Gm-Message-State: AOJu0Yz2M/nnFtiPkyXRFzpml4iVBfb97pdTHsCmcssLG+6F3UXxu+LN
	AVZtOB+74sxdprZrmT6zkyir0Dr8BXrzGgwPoAyZMerbumPnRg==
X-Google-Smtp-Source: AGHT+IGCrRv2Xox8IoTKAK1tK0lI+F5UQ2lc3D09T7sRQDvvxo2IzFqkGcHCcK2S942TMjaLqrnQP9OX3vcm21L/yJk=
X-Received: by 2002:a17:90a:ea83:b0:28c:8ec9:6330 with SMTP id
 h3-20020a17090aea8300b0028c8ec96330mr3145262pjz.15.1704810662738; Tue, 09 Jan
 2024 06:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
 <20240108134843.429769-3-vincent.guittot@linaro.org> <fb25afab-9586-455a-b8c1-47949035c95a@arm.com>
In-Reply-To: <fb25afab-9586-455a-b8c1-47949035c95a@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 9 Jan 2024 15:30:51 +0100
Message-ID: <CAKfTPtDEKzup63H0iwHkTQCZOdQLUurACCYfEB-MpW+v7JEfag@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] sched: Take cpufreq feedback into account
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, rafael@kernel.org, viresh.kumar@linaro.org, 
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com, 
	mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com, 
	corbet@lwn.net, gregkh@linuxfoundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	qyousef@layalina.io
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 12:22, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 08/01/2024 14:48, Vincent Guittot wrote:
> > Aggregate the different pressures applied on the capacity of CPUs and
> > create a new function that returns the actual capacity of the CPU:
> >   get_actual_cpu_capacity()
>
>    function name                scaling
>
> (1) arch_scale_cpu_capacity() - uarch
>
> (2) get_actual_cpu_capacity() - hw + cpufreq/thermal of (1)
>
> (3) capacity_of()             - rt (rt/dl/irq) of (2) (used by fair)
>
> Although (1) - (3) are very close to each other from the functional

I don't get your point as name of (1) and (3) have not been changed by the patch

> standpoint, their names are not very coherent.
>
> I assume this makes it hard to understand all of this when reading the
> code w/o knowing these patches before.
>
> Why is (2) tagged with 'actual'?

This is the actual max compute capacity of the cpu at now  i.e.
possibly reduced because of temporary frequency capping

So (2) equals (1) minus temporary performance capping and (3)
additionally subtracts the time used by other class to (2)


>
> This is especially visible in feec() where local variable cpu_cap
> relates to (3) whereas cpu_actual_cap related to (2).
>
> [...]
>

