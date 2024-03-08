Return-Path: <linux-kernel+bounces-96824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FD28761E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A58B21679
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0B754BF6;
	Fri,  8 Mar 2024 10:21:46 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7F54BDE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893306; cv=none; b=h+RV4PpiKKPJE+7TlnGuQ9NKg7+jMcgJuIc5JJyAO5pb/ma6Ow4CrZbr1rXoUACplyPPJoAaJYnf8S2x5q+x2EVp1mXKJcjdQSqnjbHIxt1wdDxdDnl7+oD/gn+XR9mkzqeBuyumq1oc1hvG8gEBCkkyzO/FsrZLrjNi6V/auaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893306; c=relaxed/simple;
	bh=t+yeOVuLz5XArA05ID9cnrDzM7mi7gMMr5EtHRQf7sQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epEcwkV8xC1KxRjxcbmboSzy4RISXEUhYb9oGxvOO3k5ztNS0eF1LvOKWxRRU5r25lsIjtAyjRCxvFTMvJ1QoYoGIOElJjXlTnvz0SwOj+4JPQKWePPbb+/Sw8uB4YJTEr0HMHwznQbtRpHULnob/5CujABgtGDnkLCal/N3EOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513830f18d9so195596e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709893303; x=1710498103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOyJ0vXvYfxQRLj0ZrdvSqI4qJstkPbTgrDZPnLnrv4=;
        b=kFHWrsNbgl1sFkpN7qDnzDvxt/gOiLOAxyW8BBcvgRIZ7gbdN2f2awyMW/+tNxnwrz
         mSbhm2rt9KjlijSnTTOBNP1JNGARb2WAGD2YEs+O+snK/r/C39w9YgwQBuWeruIxoF1I
         MzQH208VNmn84ieH1TxJXVdRExXoYKLCl3nx/Cq8CqlOZbVIoCGb3EYFnMv/7Et0qWIL
         etNdsUK8frJPFKXt8VA0M8yiAf7hUtkys/CE+oS5aQ3d0fAtag2clIQgYc2pPb3YXeDC
         B3ciiKJZI6eDEI0EMv0bGkh8fCeGfAdmaIuwqYbYx8vBWJ6aaym57VwRd0aXS/ZTxO7T
         /GCA==
X-Forwarded-Encrypted: i=1; AJvYcCUn6zx1uIF3CwITrjvOEL6eLpLgVmvCFB2L4VPc7tTQ6tK1Re2qiFS2ZNjlaqjKhxKwmI/P7fVdsMJLoFXGe1DV7n/OkKCwFzXWkVHQ
X-Gm-Message-State: AOJu0Yz5OKoGHtXgCsP3ahPwiSwKKbGSgLaZ61Lt+bJpvi3pGvokOmOf
	ZFsJpxwVCqd/UOSDw5Q4ugxSEwdtw4i4CR2taM3vg+HpjodMmWwZ
X-Google-Smtp-Source: AGHT+IEg7otObSNvAQkRZFRGAB1RYZTFwqMGbwMIpvLuU2IT7sSktAUSbK5hI7G9hD5ARZBuyLu+aA==
X-Received: by 2002:ac2:48ae:0:b0:513:4467:523c with SMTP id u14-20020ac248ae000000b005134467523cmr891239lfg.3.1709893302423;
        Fri, 08 Mar 2024 02:21:42 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id jh3-20020a05600ca08300b0041304100fa9sm5430817wmb.45.2024.03.08.02.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 02:21:42 -0800 (PST)
Message-ID: <2cda7c9a-a460-4bb4-95f7-ab44f8f1007c@grimberg.me>
Date: Fri, 8 Mar 2024 12:21:40 +0200
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
 <b02588cb-6fbc-4116-86d6-173c115f50c5@grimberg.me>
 <b23a5c7c-a877-4cde-acd4-50c21c3ef1fc@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b23a5c7c-a877-4cde-acd4-50c21c3ef1fc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/03/2024 14:52, Hannes Reinecke wrote:
> On 3/7/24 13:14, Sagi Grimberg wrote:
>>
>>
>> On 07/03/2024 13:45, Hannes Reinecke wrote:
>>> On 3/7/24 12:30, Sagi Grimberg wrote:
>>>>
> [ .. ]
>>>>
>>>> Where is this retried today, I don't see where connect failure is 
>>>> retried, outside of a periodic reconnect.
>>>> Maybe I'm missing where what is the actual failure here.
>>>
>>> static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>>> {
>>>         struct nvme_tcp_ctrl *tcp_ctrl =
>>>                         container_of(to_delayed_work(work),
>>>                         struct nvme_tcp_ctrl, connect_work);
>>>         struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
>>>
>>>         ++ctrl->nr_reconnects;
>>>
>>>         if (nvme_tcp_setup_ctrl(ctrl, false))
>>>                 goto requeue;
>>>
>>>         dev_info(ctrl->device, "Successfully reconnected (%d 
>>> attempt)\n",
>>>                         ctrl->nr_reconnects);
>>>
>>>         ctrl->nr_reconnects = 0;
>>>
>>>         return;
>>>
>>> requeue:
>>>         dev_info(ctrl->device, "Failed reconnect attempt %d\n",
>>>
>>> and nvme_tcp_setup_ctrl() returns either a negative errno or an NVMe 
>>> status code (which might include the DNR bit).
>>
>> I thought this is about the initialization. yes today we ignore the 
>> status in re-connection assuming that whatever
>> happened, may (or may not) resolve itself. The basis for this 
>> assumption is that if we managed to connect the first
>> time there is no reason to assume that connecting again should fail 
>> persistently.
>>
> And that is another issue where I'm not really comfortable with.
> While it would make sense to have the connect functionality to be
> one-shot, and let userspace retry if needed, the problem is that we
> don't have a means of transporting that information to userspace.
> The only thing which we can transport is an error number, which
> could be anything and mean anything.

Not necessarily. error codes semantics exists for a reason.
I just really don't think that doing reconnects on a user-driven 
initialization is a good idea at all
unlike the case where the controller was connected and got disrupted, 
this is not user driven and
hence makes sense.

> If we had a defined way stating: 'This is a retryable, retry with the 
> same options.' vs 'This is retryable error, retry with modified 
> options.' vs 'This a non-retryable error, don't bother.' I'd be
> fine with delegating retries to userspace.
> But currently we don't.

Well, TBH I don't know if userspace even needs it. Most likely what a 
user would want is to define
a number of retries and give up if they expire. Adding the intelligence 
for what connect is retry-able or
not does not seem all that useful to me.

>
>> If there is a consensus that we should not assume it, its a valid 
>> argument. I didn't see where this happens with respect
>> to authentication though.
>
> nvmf_connect_admin_queue():
>
>             /* Authentication required */
>             ret = nvme_auth_negotiate(ctrl, 0);
>             if (ret) {
>                     dev_warn(ctrl->device,
>                              "qid 0: authentication setup failed\n");
>                     ret = NVME_SC_AUTH_REQUIRED;
>                     goto out_free_data;
>             }
>             ret = nvme_auth_wait(ctrl, 0);
>             if (ret)
>                     dev_warn(ctrl->device,
>                              "qid 0: authentication failed\n");
>             else
>                     dev_info(ctrl->device,
>                              "qid 0: authenticated\n");
>
> The first call to 'nvme_auth_negotiate()' is just for setting up
> the negotiation context and start the protocol. So if we get
> an error here it's pretty much non-retryable as it's completely
> controlled by the fabrics options.
> nvme_auth_wait(), OTOH, contains the actual result from the negotiation,
> so there we might or might not retry, depending on the value of 'ret'.
>
> Cheers,
>
> Hannes
>


