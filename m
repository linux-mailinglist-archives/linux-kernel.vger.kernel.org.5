Return-Path: <linux-kernel+bounces-78684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8292F86172E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8941C21BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CFC84A2C;
	Fri, 23 Feb 2024 16:12:07 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6093405C7;
	Fri, 23 Feb 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704727; cv=none; b=d4n8TCdBl5+StkLpiCzBwTGwZB8R86+ksItWKkw/RQFqPeu8Uq90RrpthvmZScYnfXMToobS8Obxy55xhHm2KKgKAeYO1dqu3lxfan2JluV21QZ3h66pL9OPkmGP4y/ApSdR+8f8KizL1qZdT0jzLHGaiw2azCyBjqSwBU3L0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704727; c=relaxed/simple;
	bh=IYZqpnDB3Z2+5OZRzz3nhcxs9MGkwIv0jltubSu1ZvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QW7JDYsl+HDLXdAeeX7rzyk0jzfx90KF8ov716x/wxGWCo/XLeOTLYnk1cdgcDR0MuL+K3TblI/ZqCUDXMDIXu89baK7Dlrh+lSbCL2JfHz6r+G51CfdxHtseevXYZoZv14oqqaUdrduRa0P2yztlGKLIWRUIhEsnhizBBWgVrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e47c503fb5so703238b3a.2;
        Fri, 23 Feb 2024 08:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704725; x=1709309525;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYZqpnDB3Z2+5OZRzz3nhcxs9MGkwIv0jltubSu1ZvA=;
        b=roLdd85Bv8xTcnyoKQZE5NWzYzLElKQMAjtIFUgn5Yjx32FSAD0QIuZW+ttcz5CS3B
         86JDfG5qrU5XuenY7Hi9xZyZrcJM3mhDgBaVELwn7Rve+xKDepSBvsk5yKDh2vjpZtph
         uKNnubWZqUGvzpcwKIJ1h/av7e0otmOi9LYxaoW1otG2rBPeZvMOVYkrEPe7100O+jEG
         yb8qlahu4Bhdi/QHfqoOQvaKgUtCPCEpOX15kiPmBjlE2t1t3hCRPjxF/L+NEC0IRR5Y
         zNcMk/aRbfW3kKKTcK/ddsUIRN1/qrl2NWw5X52HcTEptkM8G7EyN4LQv+CLJEq9OYwY
         KwhA==
X-Forwarded-Encrypted: i=1; AJvYcCVLNDVOR9gr1buL6CMNVPbZydbWY4isv16mR+lyZvbKEhXqSWInm7QBJzvJrfeOmZkA8RXcIgs1sP98jV015r4Aj9wTi2el/KyOTU0=
X-Gm-Message-State: AOJu0YwGgkCS/qF1UvdAO6oYGctC1Sg73yHzPOV21prmIIbflfRlZgr2
	mmtixusGr67NI9QNYA5iwuWISicIrh+j9CHPtQ32TAZepP7ciozt
X-Google-Smtp-Source: AGHT+IHzpuQcMVcAUWd8AjHuQZlT1DFNC2jSXD7wC37QFNhWnipL/1e5mN9eWMwtB7J/g5vvfb7brw==
X-Received: by 2002:a05:6a00:929f:b0:6e4:d868:ac35 with SMTP id jw31-20020a056a00929f00b006e4d868ac35mr298726pfb.19.1708704724846;
        Fri, 23 Feb 2024 08:12:04 -0800 (PST)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b006e053e98e1csm12993655pfn.136.2024.02.23.08.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:12:04 -0800 (PST)
Message-ID: <e079f55d-9e4c-49e5-8389-ac2c2c4ad7c5@acm.org>
Date: Fri, 23 Feb 2024 08:12:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched: Add a new function to compare if two cpus
 have the same capacity
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>, Jens Axboe <axboe@kernel.dk>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, Wei Wang <wvw@google.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <20240223155749.2958009-1-qyousef@layalina.io>
 <20240223155749.2958009-2-qyousef@layalina.io>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240223155749.2958009-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 07:57, Qais Yousef wrote:
> The new helper function is needed to help blk-mq check if it needs to
> dispatch the softirq on another CPU to match the performance level the
> IO requester is running at. This is important on HMP systems where not
> all CPUs have the same compute capacity.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

