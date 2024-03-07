Return-Path: <linux-kernel+bounces-95514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D9D874EAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C760B24A18
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6CF129A8B;
	Thu,  7 Mar 2024 12:14:10 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38D3233
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813649; cv=none; b=n/czwL6MDSSa0Z5Wrw7Hz/QgoDcWBfXZPp9P6JRBXRkZ0CjJKrmvl3RMfok/skDu2QjQtqBFsL9V+TO6hOjVQUP0gi86j3DcmiN74i1d7Vb8nM1ork+d8tYKLFIdoN2bSh5aWyxyQfpndklCG3CjtHO8JRIJX21JDyzXbCqBZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813649; c=relaxed/simple;
	bh=3PEmWEx6elLryl2CM6/FMnZkO8+VE19YwQUChS0L3oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emyaOko/mMpioKPtOXxbgOSUgI2vOqjW5ME5p4aTsyu6psYvHILlQ1yeqJYNsUScK7itDY36Ku+7gAwCBVIMWDxe5cVXy3uk4vA6UXCOohxtSXmh5Dj3VXdAkdFceAvCFBMMofAJNfcnWEwNyC7Tagwmomz54kJHGuIn++YI+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412bcca7c56so312685e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 04:14:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813646; x=1710418446;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbOAwhMnSdJGlPlWPiV1Em71QncrNK6+P5igUXX/YWs=;
        b=eELmFv9iNaC5YXwQBlRyY9mlrZFmDj809UqijXSQLZNHk6dWItJRzhw0DXqn5X5fIQ
         zic8NlLYyeJRCAeiscwPijBbwB3yLJsk3uq6Z/KrIfkueaFzGGB14tNeQZcpWOW4OgXI
         KUImHKbkqZocw8TkewkMGeFz+K7quRkAjkbWx0xNbp2k1y/pqHtiQLGW77QXSBexs6cg
         TJO6JooWBUSKrzGBq+qX2AHtF3y0VXFj6QrllVc0F6GV5zPhrghYR33BEhqnmyqwfzRA
         47+6T+qBl4X4EJM+3NfPPqI/BWR0tdOjC9QJXKJirxwbz1CCuXa+kUe+EE9Jbjb8M2Bs
         o3xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkWL8qaVaIPLfbyvtp7KfGQO4H25mRwyPXSS+y4UTxfRW576Rx+zpapYnf7e8MWGkfvdkCdO4o3cEByr5gVgqZLJx8Psx0RfRFvHLv
X-Gm-Message-State: AOJu0YzjbVnp+ifIier+SZGeJwb9U3TJcCZw9j0T1rN8enXddJCe8Y6v
	NV9TSW3lvYnZdY1EvpDkhdQsI+2V0BWDaCVV6IB7jnqq59YFWW4B
X-Google-Smtp-Source: AGHT+IG/23S4boJLNpBSrEFKOwJ9L/axhUWJLQuZX3EM3km9SAxXajGd7JKkgqOTFNaskOcCCdwV2w==
X-Received: by 2002:a05:600c:444c:b0:412:eee0:a5e4 with SMTP id v12-20020a05600c444c00b00412eee0a5e4mr1337178wmn.1.1709813646229;
        Thu, 07 Mar 2024 04:14:06 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bs19-20020a056000071300b0033daaef7afcsm20579395wrb.83.2024.03.07.04.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 04:14:05 -0800 (PST)
Message-ID: <b02588cb-6fbc-4116-86d6-173c115f50c5@grimberg.me>
Date: Thu, 7 Mar 2024 14:14:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240305080005.3638-1-dwagner@suse.de>
 <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
 <72c1d3a8-14ad-43e8-a68a-25be903698c4@suse.de>
 <432a39d5-6d08-4d38-a357-7c8d9123189a@grimberg.me>
 <08f3d804-f94b-4a2f-897b-7fee3411e6fc@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <08f3d804-f94b-4a2f-897b-7fee3411e6fc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/03/2024 13:45, Hannes Reinecke wrote:
> On 3/7/24 12:30, Sagi Grimberg wrote:
>>
>>
>> On 07/03/2024 12:37, Hannes Reinecke wrote:
>>> On 3/7/24 09:00, Sagi Grimberg wrote:
>>>>
>>>> On 05/03/2024 10:00, Daniel Wagner wrote:
>>>>> I've picked up Hannes' DNR patches. In short the make the 
>>>>> transports behave the same way when the DNR bit set on a 
>>>>> re-connect attempt. We
>>>>> had a discussion this
>>>>> topic in the past and if I got this right we all agreed is that 
>>>>> the host should honor the DNR bit on a connect attempt [1]
>>>> Umm, I don't recall this being conclusive though. The spec ought to 
>>>> be clearer here I think.
>>>
>>> I've asked the NVMexpress fmds group, and the response was pretty 
>>> unanimous that the DNR bit on connect should be evaluated.
>>
>> OK.
>>
>>>
>>>>>
>>>>> The nvme/045 test case (authentication tests) in blktests is a 
>>>>> good test case for this after extending it slightly. TCP and RDMA 
>>>>> try to
>>>>> reconnect with an
>>>>> invalid key over and over again, while loop and FC stop after the 
>>>>> first fail.
>>>>
>>>> Who says that invalid key is a permanent failure though?
>>>>
>>> See the response to the other patchset.
>>> 'Invalid key' in this context means that the _client_ evaluated the 
>>> key as invalid, ie the key is unusable for the client.
>>> As the key is passed in via the commandline there is no way the client
>>> can ever change the value here, and no amount of retry will change 
>>> things here. That's what we try to fix.
>>
>> Where is this retried today, I don't see where connect failure is 
>> retried, outside of a periodic reconnect.
>> Maybe I'm missing where what is the actual failure here.
>
> static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
> {
>         struct nvme_tcp_ctrl *tcp_ctrl =
>                         container_of(to_delayed_work(work),
>                         struct nvme_tcp_ctrl, connect_work);
>         struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>
>         ++ctrl->nr_reconnects;
>
>         if (nvme_tcp_setup_ctrl(ctrl, false))
>                 goto requeue;
>
>         dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
>                         ctrl->nr_reconnects);
>
>         ctrl->nr_reconnects = 0;
>
>         return;
>
> requeue:
>         dev_info(ctrl->device, "Failed reconnect attempt %d\n",
>
> and nvme_tcp_setup_ctrl() returns either a negative errno or an NVMe 
> status code (which might include the DNR bit).

I thought this is about the initialization. yes today we ignore the 
status in re-connection assuming that whatever
happened, may (or may not) resolve itself. The basis for this assumption 
is that if we managed to connect the first
time there is no reason to assume that connecting again should fail 
persistently.

If there is a consensus that we should not assume it, its a valid 
argument. I didn't see where this happens with respect
to authentication though.

