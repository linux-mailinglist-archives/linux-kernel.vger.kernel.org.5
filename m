Return-Path: <linux-kernel+bounces-21753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAFE8293CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC3A1C256BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF29364C3;
	Wed, 10 Jan 2024 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkckBDl9"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3B29433
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6da9c834646so3223168b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 22:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704869007; x=1705473807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufriYbCxMamJExkyO+DSziDprmr/nvohHV8KvnEcisE=;
        b=GkckBDl9tyDeaKoq1OlLbr6jEBwdbjzMGB0I45CAU6xI+pgxYAVVcgVcq2AKQpBjM7
         3wnDntahFoAcep5K8VnjbMQzSJIofcavO4I7WeCodBVsVW8sbbAy3vuCAA23d10llbWQ
         O0Sa1BdzkP2xMT49yTz2ONeRQ0t3IdlTQum1qPOpfmaOziYsSz+6XZRSr9zXz8ZyI7IT
         OorO6nPNXk+DvFyUSi31O7tQPj6+WQAiDZdAp8KoiEEuE89AijmVyZCZabZe5dKcdwdV
         PbKiXXhbg5q2qGY1BdIQLX4bb8S1WkyNIE0CjOlaKMneYqwUl0Y8joqktrM0wx4EbVEw
         JFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869007; x=1705473807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufriYbCxMamJExkyO+DSziDprmr/nvohHV8KvnEcisE=;
        b=RQcNGpqJNOjKV5+9SgkvzXR47KDn+BITdI1vUrId/jYv0Tld722ZedHvnkIONDeRSz
         82FToaVaxz8hThpDhGURGZOc5SwZjQdsnYRUhHBJ2I1noPnWPliHC/JrWIFgzoYB62ed
         VZcQTIDqxDEtAOXEi1dh3q9I81368Dmzyucq3LLnJeMa1eBlHhHtH0xsRiJJ0p6F3mhh
         gjqO2yt5+sYB4SMzbX44RaPXZK4c68JasKpOSYZ1jseZ4Xez/mutWrjI/IwI/W6W3C6T
         JsZtc10AREJ/j0dBi2e7oy0ug7dJROhbSNbbDOVoc5ow6unaSWmy9sd+hy+aihVKwrpb
         cyVg==
X-Gm-Message-State: AOJu0YzH4v0ADTH560JEeFFqdH0HANcZuXM2bKTfRdhOnlb8C7AQhq+A
	/PLymEgsZc2PkCSy5FG8jVcMBvcO5iwOyg==
X-Google-Smtp-Source: AGHT+IHVmZ9O2UiKApFYg6a+2bvUEeNRE+QH24QgnpIssMtERJd0DP+8Dglnh788IGmlXjBYlPjMPA==
X-Received: by 2002:a05:6a20:1682:b0:198:7feb:97ae with SMTP id q2-20020a056a20168200b001987feb97aemr365175pzc.123.1704869007250;
        Tue, 09 Jan 2024 22:43:27 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id n5-20020a634005000000b005cd64ff9a42sm2618582pga.64.2024.01.09.22.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:43:26 -0800 (PST)
Date: Wed, 10 Jan 2024 12:13:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	sudeep.holla@arm.com, rafael@kernel.org, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	lukasz.luba@arm.com, rui.zhang@intel.com, mhiramat@kernel.org,
	daniel.lezcano@linaro.org, amit.kachhap@gmail.com, corbet@lwn.net,
	gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, qyousef@layalina.io
Subject: Re: [PATCH v4 1/5] cpufreq: Add a cpufreq pressure feedback for the
 scheduler
Message-ID: <20240110064324.bex3ssej5ghie6cu@vireshk-i7>
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
 <20240109164655.626085-2-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109164655.626085-2-vincent.guittot@linaro.org>

On 09-01-24, 17:46, Vincent Guittot wrote:
> Provide to the scheduler a feedback about the temporary max available
> capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
> filtered as the pressure will happen for dozens ms or more.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   | 10 ++++++++++
>  2 files changed, 46 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

