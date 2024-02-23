Return-Path: <linux-kernel+bounces-78424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235AD861349
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF2D283299
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C87F7CC;
	Fri, 23 Feb 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="vnxr39rM"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D837422EF5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696260; cv=none; b=NDpDfbkhTF/WUEvD5I3LxscN2YcIQiBGSFwukZpyIUfels8xdHDmevf7/OCGhANqS7n2+9dpxWQ2pOrzouYiVBeBBmZB8pi2PLnqh6saEixscZntPSHk87IgNN0sx4XcjBLiJUlMM3vqsmJ0fcpOfzX+IyAim8rHFkDsOGYOLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696260; c=relaxed/simple;
	bh=oBSX1Ry5YLy9imY4XGA0Q1INCU4gugOE22Ic4IOuKw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5FKZdgIuqFuLlkb0GS+D9ZRLlF/gL6/C/CPuHHJ119s1YmTDMuGHVbnTYKv0KTBD8qH5klv6S9MbDOPAXUkZ9E0nV2pV5WphgOClXkvTPRqlegLM2fm6F9w8PYFob+01uwlcscDmMLUM50NJSq80AN4fhb4pXBJBNrBCA1MlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=vnxr39rM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso587880f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708696257; x=1709301057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DNSkS12J+nqUD5hGYKyEpVXw3bH86AfCh19+P6X2amI=;
        b=vnxr39rMk2sJFSww+7iyvS8fgjis920tlOjUZ8EnDHGm7BBnogjw/zarcchUl1SXid
         2yO65NpK/lDqWICQgorqVcN0UViXz59QN/Pyrk5A1L+ovNIN5rgZHv9Fp00iVssJI6Eo
         WbZ4M4v7T4waRm4Ejs2SBhomdKm9leIf/Qv4U6hR2VSi+1/iE/JMc110DcASVFQ4bSeS
         35vD6gTspTahe4LFpggjCGC2nHAp6SzfygHaYPdkQ/BdW7fpjcNX836BBVWz/+SNZXPr
         AQKSKedvZl28xZOoE3hf5AW/F/VlLnxEuMWwKxCH2H9dpsW3IiecWFyPlzI/BNxqk/5t
         j2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708696257; x=1709301057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNSkS12J+nqUD5hGYKyEpVXw3bH86AfCh19+P6X2amI=;
        b=Ssx/u4weToWpP0BraleXvfgFVOuDsaGoSQT46BR4ooaHIyzA5Nc2FrjyqnIhbPDE4/
         /la46Q1fzwebqSJKTVStzOZA2cRzOlKnFKnsobI/9O1fRcPwkbkBT6FRgt4j5O0PC+1R
         dydqJKgQPNdVsYIy3FWO6rAxSvCF+6GzSLnhpT5jzyI7VIoIGxKZieFWHB2dlCNMa27L
         TzqBUeiTpEUsuLcACLxXArcliEhXC2I6Y/XvnJ9vHzZmUw84HY3P5NZYo+r5DFDUIHGJ
         0cKBWfuJfwNgcx5k7YzlZRCiSA1y2RgJX7FpmGXQy1dEHnVCs7l6H9atZ7svrsEqXdGk
         YxKw==
X-Forwarded-Encrypted: i=1; AJvYcCXSgjZF7V+nbEj5RVslIuhJWOSJxm9lNHtnR8lSiwBJbc5snSf+1bj2OQacqEXAiMzl3uCkXgrYJpsUxPKj5BwBbVIWdXakdpc1pH3X
X-Gm-Message-State: AOJu0Yzq4BFJI4WVHtOzSYgpQr4tAn1vfmWUUmiItcWtPTyz/UGTh2Mc
	EU+ERS1OELK+lB/u7QdMGovmhTK1jRSTLpP3VDCE35OoNEE/eRZc5NTe4VauqpyVjDtPZhIlAnC
	F
X-Google-Smtp-Source: AGHT+IGgJVtnSBZK1oGHTyssxABdImnl2UKeywZT005VbmYttsJARkj+qEyMs5r4JMG805MRSM4Xzw==
X-Received: by 2002:a5d:5383:0:b0:33d:63b6:defd with SMTP id d3-20020a5d5383000000b0033d63b6defdmr4993536wrv.31.1708696257173;
        Fri, 23 Feb 2024 05:50:57 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id c11-20020a056000104b00b0033b483d1abcsm2828392wrx.53.2024.02.23.05.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:50:56 -0800 (PST)
Date: Fri, 23 Feb 2024 13:50:55 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240223135055.bvglqof57x4bykow@airbuntu>
References: <20240220225622.2626569-1-qyousef@layalina.io>
 <20240220225622.2626569-3-qyousef@layalina.io>
 <Zdhlt9GZe502wpPy@vingu-book>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zdhlt9GZe502wpPy@vingu-book>

On 02/23/24 10:30, Vincent Guittot wrote:
> Le mardi 20 févr. 2024 à 22:56:20 (+0000), Qais Yousef a écrit :
> > If a misfit task is affined to a subset of the possible cpus, we need to
> > verify that one of these cpus can fit it. Otherwise the load balancer
> > code will continuously trigger needlessly leading the balance_interval
> > to increase in return and eventually end up with a situation where real
> > imbalances take a long time to address because of this impossible
> > imbalance situation.
> > 
> > This can happen in Android world where it's common for background tasks
> > to be restricted to little cores.
> > 
> > Similarly if we can't fit the biggest core, triggering misfit is
> > pointless as it is the best we can ever get on this system.
> > 
> > To be able to detect that; we use asym_cap_list to iterate through
> > capacities in the system to see if the task is able to run at a higher
> > capacity level based on its p->cpus_ptr. We do that when the affinity
> > change, a fair task is forked, or when a task switched to fair policy.
> > We store the max_allowed_capacity in task_struct to allow for cheap
> > comparison in the fast path.
> > 
> > Improve check_misfit_status() function by removing redundant checks.
> > misfit_task_load will be 0 if the task can't move to a bigger CPU. And
> > nohz_load_balance() already checks for cpu_check_capacity() before
> > calling check_misfit_status().
> > 
> > Test:
> > =====
> > 
> > Add
> > 
> > 	trace_printk("balance_interval = %lu\n", interval)
> > 
> > in get_sd_balance_interval().
> > 
> > run
> > 	if [ "$MASK" != "0" ]; then
> > 		adb shell "taskset -a $MASK cat /dev/zero > /dev/null"
> > 	fi
> > 	sleep 10
> > 	// parse ftrace buffer counting the occurrence of each valaue
> > 
> > Where MASK is either:
> > 
> > 	* 0: no busy task running
> > 	* 1: busy task is pinned to 1 cpu; handled today to not cause
> > 	  misfit
> > 	* f: busy task pinned to little cores, simulates busy background
> > 	  task, demonstrates the problem to be fixed
> > 
> > Results:
> > ========
> > 
> > Note how occurrence of balance_interval = 128 overshoots for MASK = f.
> > 
> > BEFORE
> > ------
> > 
> > 	MASK=0
> > 
> > 		   1 balance_interval = 175
> > 		 120 balance_interval = 128
> > 		 846 balance_interval = 64
> > 		  55 balance_interval = 63
> > 		 215 balance_interval = 32
> > 		   2 balance_interval = 31
> > 		   2 balance_interval = 16
> > 		   4 balance_interval = 8
> > 		1870 balance_interval = 4
> > 		  65 balance_interval = 2
> > 
> > 	MASK=1
> > 
> > 		  27 balance_interval = 175
> > 		  37 balance_interval = 127
> > 		 840 balance_interval = 64
> > 		 167 balance_interval = 63
> > 		 449 balance_interval = 32
> > 		  84 balance_interval = 31
> > 		 304 balance_interval = 16
> > 		1156 balance_interval = 8
> > 		2781 balance_interval = 4
> > 		 428 balance_interval = 2
> > 
> > 	MASK=f
> > 
> > 		   1 balance_interval = 175
> > 		1328 balance_interval = 128
> > 		  44 balance_interval = 64
> > 		 101 balance_interval = 63
> > 		  25 balance_interval = 32
> > 		   5 balance_interval = 31
> > 		  23 balance_interval = 16
> > 		  23 balance_interval = 8
> > 		4306 balance_interval = 4
> > 		 177 balance_interval = 2
> > 
> > AFTER
> > -----
> > 
> > Note how the high values almost disappear for all MASK values. The
> > system has background tasks that could trigger the problem without
> > simulate it even with MASK=0.
> > 
> > 	MASK=0
> > 
> > 		 103 balance_interval = 63
> > 		  19 balance_interval = 31
> > 		 194 balance_interval = 8
> > 		4827 balance_interval = 4
> > 		 179 balance_interval = 2
> > 
> > 	MASK=1
> > 
> > 		 131 balance_interval = 63
> > 		   1 balance_interval = 31
> > 		  87 balance_interval = 8
> > 		3600 balance_interval = 4
> > 		   7 balance_interval = 2
> > 
> > 	MASK=f
> > 
> > 		   8 balance_interval = 127
> > 		 182 balance_interval = 63
> > 		   3 balance_interval = 31
> > 		   9 balance_interval = 16
> > 		 415 balance_interval = 8
> > 		3415 balance_interval = 4
> > 		  21 balance_interval = 2
> > 
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> 
> I have a comment below but anyway
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks for all the reviews and the help!

I sent v7 in reply to this taking your comment into account with minor tweaks
to avoid the else leg and white space to keep rq->misfit_task_load = 0 easily
spottable below the now long if condition.


Thanks!

--
Qais Yousef

