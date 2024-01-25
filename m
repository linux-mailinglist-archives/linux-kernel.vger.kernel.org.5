Return-Path: <linux-kernel+bounces-38111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3D83BB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2192E1F26671
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C217753;
	Thu, 25 Jan 2024 07:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="WK3Apdcn"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5EC17727
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169302; cv=none; b=hEiAVgce7muCSqrS+XPLY8cZmzc3LX1qqtyZkcZjTUwWoyNMLOCLm2Wft7odyX9i9d8Cf7URIE/YJJal9nRqsdOPxIPh5ZR2IzmaCFx5l4H5Nu8Yp2QdzyDy7lUYV8CYaC/srcSGDWtDXkZN5i0eJae97WErgXFciJdNXfOMNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169302; c=relaxed/simple;
	bh=gTC2c9jN7tUYX1r6K+w1+v29WYz2GaNbGcR4mUy+84s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvyYHFuskLP1MJ9jMeuZNATKkeJvNEIsp94aafues3ln+2LTBOheu2hUcpyWSBK+7DCKm+K/QdxO755UODHgNFvqpr4NYVi9DbSOxEqd4qBdtRa1yooPAgf55dnL9oB75Cx9ImcOm0y/bRVF3QSkzJL/HFjKlIaLTM5VCfN17fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=WK3Apdcn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ddc5faeb7fso630427b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1706169300; x=1706774100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OROYfvMkNNHoS7DwRqESXxsnw6XTxOyVsoUr8hVxqY=;
        b=WK3ApdcndW0lj0k/QzwPGa252QUBzBy5KpEGg2w4cFuvi2aTu1jSoBgSC62rEgfOSf
         pttJtmcuS6WZHhCDO1k/qltbihv+5bFMJC46szepc0ucPNHtU/TmOYfbTtqdi4g1i9Hi
         9lCAVIS41VCM1xNA8T7N5TunGhOU3z7i5stn/rSXKfjtsFLgHNZzC4jEcwoLferRDb6L
         Y04Q/Y//nW4R4GKY3Z7D7GavC5H981mrNY+QjcIln0GLdTmQfEyWIFAqWcJjOJw5n+FI
         KCc3mht6+f8mxQzSeMFphCCoopl2J0EQMnIqS0tmvHllD5+W9y6YbEAVaHZw9IP5NO5S
         Haeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169300; x=1706774100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5OROYfvMkNNHoS7DwRqESXxsnw6XTxOyVsoUr8hVxqY=;
        b=d+l8fVPIqaAHq2tEPATVUkhKNBHOlliFKb8q8HxaGffn5bOUCMThZiqi5WOYTUr5dl
         cUO7XFgoU4JCAjPhK2EkK5zxxKym3uvMNUOI27h22ztYbx9qb6gEeBH6PCOfbL/SeSIy
         uvQX8j4pQof2oXixKF4RpZkJbZc7YUGR0rLCKAM5iRE7t78iKJhQecYRrT9GLTcFnD1u
         gFwVZ2NgxMJ5mDVrN3tJDnuV0nUUORhe3uFiJGs6dAwxGfbax0x4FrnkAL47SEL1QFZI
         oma1voW2x0WueiSBxi33UNGxFm5CEmumfAu+HMzJpbQUf/PrkasQtHeErHSH+LIlQxbh
         XPBg==
X-Gm-Message-State: AOJu0Yz40vfuD8H070lezKDIoZhs4Q9UozLWkCSaq3bpqJehERqNYo6q
	tI9Y9Ku56SnU2BtDZu6vZCn+0NZx4/AVHPksl3D1q3PgrW5iPcmla2RBCCaOzu4=
X-Google-Smtp-Source: AGHT+IHPj34+BjxeQU5RJ5hi0SAajOGsqZbqfp1sq3sB3OlcUAa1sEKHnRxffsrFMyH2FoKX03G36w==
X-Received: by 2002:a05:6a20:7350:b0:199:3b3f:25d8 with SMTP id v16-20020a056a20735000b001993b3f25d8mr772619pzc.61.1706169300307;
        Wed, 24 Jan 2024 23:55:00 -0800 (PST)
Received: from [10.54.24.52] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id u6-20020a056a00124600b006dbc5569599sm11436690pfi.10.2024.01.24.23.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 23:54:59 -0800 (PST)
Message-ID: <fcbf3eec-e67b-4377-a888-a59b2583ab5f@shopee.com>
Date: Thu, 25 Jan 2024 15:54:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] x86/resctrl: Display cache occupancy of busy RMIDs
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, babu.moger@amd.com, peternewman@google.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 James Morse <james.morse@arm.com>
References: <20240123092024.1271882-3-haifeng.xu@shopee.com>
 <8abb0237-90e3-484e-a549-d74f540d4045@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <8abb0237-90e3-484e-a549-d74f540d4045@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/1/25 06:25, Reinette Chatre wrote:
> (+James)
> 
> Hi Haifeng,
> 
> On 1/23/2024 1:20 AM, Haifeng Xu wrote:
>> If llc_occupany is enabled, the RMID may not be freed immediately unless
>> its llc_occupany is less than the resctrl_rmid_realloc_threshold.
>>
>> In our production environment, those unused RMIDs get stuck in the limbo
>> list forever because their llc_occupancy are larger than the threshold.
>> After turning it up , we can successfully free unused RMIDs and create
>> new monitor groups. In order to accquire the llc_occupancy of RMIDs in
>> each rdt domain, we use perf tool to track and filter the log manually.
>>
>> It's not efficient enough. Therefore, we can add a RFTYPE_TOP_INFO file
>> 'busy_rmids_info' that tells users the llc_occupancy of busy RMIDs. It
>> can also help to guide users how much the resctrl_rmid_realloc_threshold
>> should be.
> 
> I am addressing both patch 2/3 and patch 3/3 here.
> 
> First, please note that resctrl is obtaining support for Arm's Memory 
> System Resource Partitioning and Monitoring (MPAM) and MPAM's monitoring
> is done with a monitoring group that is dependent on the control group,
> not independent as Intel and AMD. Please see [1] for more details.
> 
> resctrl is the generic interface that will be used to interact with RDT
> on Intel, PQoS on AMD, and also MPAM on Arm. We thus need to ensure that
> the interface is appropriate for all. Specifically, for Arm there is
> no global "free RMID list", on Arm the free RMIDs (PMG in Arm language,
> but rmid is the term that made it into resctrl) are per control group.
> 
> Second, this addition seems to be purely a debugging aid. I thus don't see
> this as something that users may want/need all the time, yet when users do
> want/need it, accurate data is preferred. To that end, the limbo
> code already walks the busy list once per second. What if there is a
> new tracepoint within the limbo code that shares the exact data used during
> limbo list management?

OK, I'll try this way.

 From what I can tell, this data, combined with the
> per-monitor-group "mon_hw_id", should give user space sufficient data to
> debug the scenarios mentioned in these patches.
> 
> I did add James to this discussion to make him aware of your requirements.
> Please do include him in future submissions.
> 
> Reinette
> 
> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_20231215174343.13872-2D1-2Djames.morse-40arm.com_&d=DwICaQ&c=R1GFtfTqKXCFH-lgEPXWwic6stQkW4U7uVq33mt-crw&r=3uoFsejk1jN2oga47MZfph01lLGODc93n4Zqe7b0NRk&m=-XE6uI2GOyk-qzRRAWvuDzQ9NgM2-QK-KLArnJEYmu02heN9gOh6VMbPeF1iZUZe&s=FySup-TxYl6c-jaA7Q8OFIVwbMdsMxZ3ChQ6Sj0HaLA&e= 

Thanks.

