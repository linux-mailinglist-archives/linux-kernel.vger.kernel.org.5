Return-Path: <linux-kernel+bounces-161983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3668B542F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB2BBB2140B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A6224EA;
	Mon, 29 Apr 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvaStaba"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6451E17C79
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382720; cv=none; b=pr7cLJDHuolGndT1r6q4N24l/+FQSAEaUJ7f60Lhoqo7M5fDYPiN1nNfpICLCOC+vGr7NkJVMUO3ZvkWCLSLIOny7MRCS+AyeyZbsfqe4FR4Za4f/P1Chm5y+F07XK0d/ICuEVesmrpQlbdK2cMW3A9gAVEstXulkKYpHeiyOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382720; c=relaxed/simple;
	bh=K8qRHDrtqHgZqOAB3DxYwHDgSoSpq4jFqaSKLYGlW48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1Fb5hUeo9ix2fldKnCfZQxsR22Asw5XveeytHDvTecm2DZLc7CW3JlIOXc90ClxEeI1sCtTFcv9DyeyshvBahsy5gU+kfa+WwbGOkNpFBEBIP5uxMymsoUXCqGliqC3ZS7n4x815VKts1IqGcYgcLsDRJYcnWOUlY/XanE9j1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IvaStaba; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a4b457769eso3476283a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714382718; x=1714987518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CP7urYo+70JxTDdjocGamt4MhJNpCFDJ7gBO0gt6mpU=;
        b=IvaStabafOk9r/3/+1SK0zcO+Os8fmMR0GTm6VshCuT18Ekfzb5TA/XePxgqKrDJiX
         0GlljWcPI1ql1/I+sUZ1jJG+ixBl8zZ8dmTRYy8oFE50hmbABywTi7ChPFlPYF7wupcb
         rrL8XSPsSDgmAlzKcZE77EdxHASiX5RQJ6YhOQdciJAi3DpmG+F9nJAv12OT/129t/IM
         KvXt6P5tFRI7GGZnyA0zeh2IuH5Fhy9abA7atHs8S7HmGnKudn+twq5u+5G8vOQX9p/F
         bsbOHj3GCZnGwL+GzQncW9vII6EAVinkA9FvrxQvir5fcIjsJDVYTJq+MmThC/2UDx+h
         dbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714382718; x=1714987518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CP7urYo+70JxTDdjocGamt4MhJNpCFDJ7gBO0gt6mpU=;
        b=cU9mjsLEP/4ioMifViibyhTRcIq1dvOqUy+ox6fMzQDnJbD/ZTMv2/bBxK3sbt+ZGJ
         9VxIgH/QTp/aD9b7NWutzfKG79tI3ZXkgL72THnbNJN2G+lWsoiI7BgHJa44JwI9PCO/
         hhKy/NxZEG6ios/4VmIf6NJK8hgzkqJyTX94V+pGCDXEUcdsSEoR6ozJKJyKyfhoaU87
         s6YX6jmss+qU04+wvhsPAOMi3y5fRiYwBpFPrkiFIwbr06S+omm4nz4t5aa265QCVbvW
         93V6tEOpAeTk9cGA0z8+1NBzuxP2kBZrC+l4c8VQAfoSfwaar4R263JaCiDsv9duq/W/
         BIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWBV5Xaj7EXk/399kvz9itzIx6Nvc18hgZmw++16DHbAf40mpeUkK9IuQbvHtji1A3JRcz0Viv2QW7ss+5dl2U2c5R3/RXnSwRXulH
X-Gm-Message-State: AOJu0YwZvOjFSe9kiVlOycwxR1eTk0iPoDB6UiqJiXLVq/jC7qlpRb3Y
	53LpydezN9Hb6PIgd6ItWFKPZJkNVLU/iKnbQPhgtrpRzzqveshHh98w6TLiCrBiF47HBeO5YV1
	m
X-Google-Smtp-Source: AGHT+IFITCOMk0yA7pLp8TcRe78mmJzy+qa5QjSau8VCgla5VWdIzElzIG0vSpMAMhKUMzDvhbSVrA==
X-Received: by 2002:a17:90b:3d4:b0:2a6:1625:368c with SMTP id go20-20020a17090b03d400b002a61625368cmr8711509pjb.6.1714382718462;
        Mon, 29 Apr 2024 02:25:18 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id gb23-20020a17090b061700b002b15a672805sm2339899pjb.23.2024.04.29.02.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 02:25:17 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:55:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	catalin.marinas@arm.com, vincent.guittot@linaro.org,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com
Subject: Re: [PATCH v4 4/4] cpufreq: Use arch specific feedback for
 cpuinfo_cur_freq
Message-ID: <20240429092515.2ehk4ifcul6mbaxh@vireshk-i7>
References: <20240405133319.859813-1-beata.michalska@arm.com>
 <20240405133319.859813-5-beata.michalska@arm.com>
 <76zutrz47zs6i2cquvjo2qn7myxpq7e3c6alhper7n3wrkhf5h@22l5t5pio2cd>
 <Zh6dSrUnckoa-thV@arm.com>
 <s2bel7fzwpkyfyfkhod4xaihuklsaum75ycbcgmcanqaezxdu7@uxvqdqt3yo7l>
 <ZiuF0zgqkMlmkEZz@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiuF0zgqkMlmkEZz@arm.com>

On 26-04-24, 12:45, Beata Michalska wrote:
> It seems that we might need to revisit the discussion we've had around
> scaling_cur_freq and cpuinfo_cur_freq and the use of arch_freq_get_on_cpu.
> As Vanshi has raised, having both utilizing arch specific feedback for
> getting current frequency is bit problematic and might be confusing at best.
> As arch_freq_get_on_cpu is already used by show_scaling_cur_freq there are not
> many options we are left with, if we want to kee all archs aligned:
> we can either try to rework show_scaling_cur_freq and it's use of
> arch_freq_get_on_cpu, and move it to cpuinfo_cur_freq, which would align with
> relevant docs, though that will not work for x86, or we keep it only there and
> skip updating cpuinfo_cur_freq, going against the guidelines. Other options,
> purely theoretical, would involve making arch_freq_get_on_cpu aware of type of
> the info requested (hw vs sw) or adding yet another arch-specific implementation,
> and those are not really appealing alternatives to say at least.
> What's your opinion on this one ?

Hi Beata / Vanshidhar,

Lets forget for once what X86 and ARM may have done and think about it
once again. I also had a chat with Vincent today about this.

The documentation says it clearly, cpuinfo_cur_freq is the one
received from hardware and scaling_cur_freq is the one requested from
software.

Now, I know that X86 has made both of them quite similar and I
suggested to make them all aligned (and never received a reply on my
previous message).

There are few reasons why it may be worth keeping the definition (and
behavior) of the sysfs files as is, at least for ARM:
- First is that the documentation says so.
- There is no point providing the same information via both the
  interfaces, there are two interfaces here for a reason.
- There maybe tools around which depend on the documented behavior.
- From userspace, currently there is only one way to know the exact
  frequency that the cpufreq governors have requested from a platform,
  i.e. the value from scaling_cur_freq. If we make it similar to
  cpuinfo_cur_freq, then userspace will never know about the requested
  frequency and the eventual one and if they are same or different.

Lets keep the behavior as is and update only cpuinfo_cur_freq with
arch_freq_get_on_cpu().

Makes sense ?

-- 
viresh

