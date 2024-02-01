Return-Path: <linux-kernel+bounces-47801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1FD845309
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02153283631
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028ED15AAA3;
	Thu,  1 Feb 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh0e906Z"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA1F17554
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777129; cv=none; b=JJGjGo83gJcK1+JpqMkZDxi4Zcmf4qD0eQmwkwhH/UF9YIBwD5ZZUejMsLtkhtEIIgaYxJ7uB8uVBiLclTT24Ggw/aazQipvAgFnisN76x97ROlUdn6DSjjMVazFdRzPjbZQbMaj29Rpi4T0rox6k8+z7g2E3FM2c1eR20R0GVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777129; c=relaxed/simple;
	bh=ZeCVEC88aFDQifLmxDuyqjAZRUqbopvrbP7CIOyEiiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjltluoT1narlMHrGPHaVH3QSxiJTuyd14MPCuzgoDigfW9AohbI9arOFgXirCurpqQoOgHO2BYpyRT0XpKj5991bsOpQXDiLxrHkIiLmXjh5W/bztidjVQRq+Tpvi9Bjx2OmOqssPYjksmbG7LNBM5UE4OJJ33zQ8xw9JcK9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh0e906Z; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddfb0dac4dso508523b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706777127; x=1707381927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqQ2rjhscVH44HJbE2x6Sjo+r+IoQjs+UyP6+yIu/FM=;
        b=eh0e906Z4ijTjeVKnVuiGc3S6z4N1TztMt5YUaORz+JSpIdVI+JY8jUydErbw5LUxt
         2ko/b0RjrgCpBMsY4r//NuKDEORJIcxZXA9EN9I19XmGQSrjOX4Fg/fLIZ6vm9ma/Tae
         mh3/kg1DgizvNucydJ2TbxyJnhSSPN4BfyK1h937o42XQfDFWq9Ff8yewL7y6tonUvnI
         PySTqRXm9AF9K2vyb6Xn7aw2NQcT5hPr7vyk6dtvS1SVI8XIHOQeWHkYSV8GDVFqZggy
         V34We2rzhN4msoyX0AuxFGO/CNjxpMqOcmJjmjGp21VZ11ZpNZA3elbBtzjUCwMiZi1c
         EoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777127; x=1707381927;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqQ2rjhscVH44HJbE2x6Sjo+r+IoQjs+UyP6+yIu/FM=;
        b=uq0MjvgCOZKvzOFLIUgCLpwYqtUBoIKv4kMBhGpJtln4VL5P9eGPWSvxsBDgghBibf
         kedYW7F9TYK+4AvpBnXV3HtEKYh15q4F3b4LUMYSAtkV3CxUndZM6p8seOjyZJW3ICH8
         OsP7jWbJzu9E9jIoOtAdBTNSVU+WLSquDhrUfCqz+pEdIejab0c6J2a/cmUxVzb5AsTw
         dAk4tf8tbT5efrAVREE2i93/5TMtcYWazCMxGQWgTDm/6S0ewMenuLXHHWhdhsDAEi39
         uhYNGCwwveD+q6QSqU2A/hESDpg1tbsHmSL+cbbsRrTQdrHSywDkm25VnbXQf8Qs3Hy8
         G5NQ==
X-Gm-Message-State: AOJu0YwAhgMAewoiW7ijFH5C4LQ2KfJC8RfggeOFGFgpwa2tOGIh2UBK
	83P6KCwRq0sZcV/R6BETYVINAbTDIRH5hnofptL66SJpQuNyCFnI
X-Google-Smtp-Source: AGHT+IHDGn8/vI4PW2M7BkxpvFZHgFO0UTnphCl2zLMy3v55th50FskRxdWo+deQb2EYHmXMxAcPHA==
X-Received: by 2002:a05:6a21:398d:b0:19e:378a:124c with SMTP id ad13-20020a056a21398d00b0019e378a124cmr4279963pzc.12.1706777127160;
        Thu, 01 Feb 2024 00:45:27 -0800 (PST)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id cq13-20020a17090af98d00b0028e023be116sm2937953pjb.49.2024.02.01.00.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:45:26 -0800 (PST)
Message-ID: <5e60b86f-a854-4958-a936-820597d43b6b@gmail.com>
Date: Thu, 1 Feb 2024 16:45:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] sched/fair: pack SD_ASYM_PACKING into
 sched_use_asym_prio
Content-Language: en-US
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 sshegde@linux.ibm.com
References: <20240130131708.429425-1-alexs@kernel.org>
 <20240130131708.429425-5-alexs@kernel.org>
 <20240201005547.GC18560@ranerica-svr.sc.intel.com>
From: kuiliang Shi <seakeel@gmail.com>
In-Reply-To: <20240201005547.GC18560@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/1/24 8:55 AM, Ricardo Neri wrote:
> On Tue, Jan 30, 2024 at 09:17:07PM +0800, alexs@kernel.org wrote:
>> From: Alex Shi <alexs@kernel.org>
> pack SD_ASYM_PACKING into sched_use_asym_prio
> 
> Instead of saying `pack` you could say "Check the SD_ASYM_PACKING flag
> in sched_use_asym_prio()"
> 
>>
>> Then the flags check passed into sched_asym and sched_group_asym.
>> It's a code cleanup, no func changes.
> 
> I'd the changelog as follows:
> 
> "sched_use_asym_prio() checks whether CPU priorities should be used. It
> makes sense to check for the SD_ASYM_PACKING() inside the function.
> Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
> remove the now superfluous checks for the flag in various places"

Thanks a lot for all comments for this series patches, will take your versions in all commits' logs.

Thanks!
Alex

