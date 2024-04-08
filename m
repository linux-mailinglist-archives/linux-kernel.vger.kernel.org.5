Return-Path: <linux-kernel+bounces-134932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3089B8FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18781F21E95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA6947794;
	Mon,  8 Apr 2024 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="KTNsGiGU"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9064595C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562248; cv=none; b=IToFAdZGTM/2MsohL/wcKmDAs26e13Y8K3DLgu/wOT28yyBQJtW+yKloi4fhJeXz5ToYNJCvhpbY5NzC/i2TTNVKs2ZFx0tZEuNNDMPvLlwu6u4kCmH36U1dVObatU4KaCB1UcWUuObDPH58Mz3Wq/Bp3rAnTJq8p1AxrCq4uFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562248; c=relaxed/simple;
	bh=2OnP4cb1z8gIRAZhhFT2S0R4H+4Hqy7YIK4KutMQgdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bByvA+yJs5COEdZj2Pk6pHFPOXTY8uGKMnWIGAjpSse15rzCaYGPCgIPboojDYI3x7cRMMBK3SwOBvMtHnc7zK+MZp2Z7gO0YQgRYJMDGItKsoGgrLRnicsj0/jemeaaQC1jZFmuIw4z4oSYY1FJS61DnNfWrKY0HEULrHtmI4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=KTNsGiGU; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa17c29ba0so989170eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1712562246; x=1713167046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KehI8KPu4upz8qJpXfAhUFMX8O5R+67ExYXkKnpvrA=;
        b=KTNsGiGU1m4qJu4Lv7QFSK6ZKssMxhD7fAfCGyS9qPlfpOSoqI+2PfOqK0vqlxJqpR
         DUKYGfqkFkE6hjqV4L3U8Zi8SLCSp8t1naA5Bbdhz44Vndp636t9BqIFGoE92ftmgDEk
         fyO4/U7glT9OAg9cVGHswbrk1u0hfe02SCQeK9hUANeK7hB/3YrFR/RD7MJJ5JNU3Jwg
         TZtJieit9+yBnQGdrpL/MYhWtfpRaVo3zeONdZzk4w7CBPP1rwhkR1NoYysDeUqA5Rmv
         QqHmezXZ5WUHVprnv86Su28tu5qYtZ5BiZVCLtgeZIGa4S1upC6DY9DX9QqXkVbpKA1J
         smHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562246; x=1713167046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5KehI8KPu4upz8qJpXfAhUFMX8O5R+67ExYXkKnpvrA=;
        b=p8hclRsBnlAl14Ac37bZmkzDkJtfF+TcDDs7RJCcGAuPUZW0a5+qJcVs7v6gmsAkq9
         wZf2b9DAVxMWsw3I8ozLCauz78cdaY3gqi4a9Z9Ue54pXZhWHXPb+U9K7pcUe16Z2PrC
         KcrVu3aafmSyfrg2NjTVMyT7rtnBywufN1Hg3VEiGERpRomCebYj75TxMhhnWyKrAvwc
         oC990TUErrORs5gCMVY3XocsxypBnuXaZC2TkHmdU6T2VnyL0M4yoZU1pp+tQt3B7tLK
         b4Q0y3/+xAUNJUR5YWXiGz6giH4RLJZ3R1qfjqyVdwFEb3Y6Yqw/C7w6mF59aFuU+/lC
         x1dw==
X-Forwarded-Encrypted: i=1; AJvYcCVOe4kaBdbHenZ6UuBnAsqHpzQ+c+5fmYoaedjrGHmt4CR68h8bTAGm2oWbJZBeGOBq+XqdSQxCJAOqp8y6f1S/43wiOiiib+D4rGwr
X-Gm-Message-State: AOJu0YxnmcX9YB2CgWgFoLE3bFRfHleZ/w/blonFD6IVHN9IFrBw7S7T
	wElx56TBrYFgNNh90fNj40LRoOhKZNI21KfD0mq1wAj0BrluRcWgYDP26M7RzNA=
X-Google-Smtp-Source: AGHT+IFsrY4ZpM3SAF0h5M/wjAh7CCTDQmcxT7QFjm1k9lYJqPJRb9dp4KkrAB1d1fuYX++MqHlz8g==
X-Received: by 2002:a05:6871:4cd:b0:229:8236:ae9 with SMTP id n13-20020a05687104cd00b0022982360ae9mr8836690oai.59.1712562245841;
        Mon, 08 Apr 2024 00:44:05 -0700 (PDT)
Received: from [10.54.24.115] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id u21-20020aa78495000000b006e580678dfbsm5812798pfn.193.2024.04.08.00.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:44:05 -0700 (PDT)
Message-ID: <ca45f32d-b526-4bcd-b177-08698babaf3d@shopee.com>
Date: Mon, 8 Apr 2024 15:44:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] x86/resctrl: Track llc_occupancy of RMIDs in limbo
 list
To: Reinette Chatre <reinette.chatre@intel.com>, james.morse@arm.com
Cc: fenghua.yu@intel.com, babu.moger@amd.com, bp@alien8.de,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 hpa@zytor.com, peternewman@google.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20240319083039.223088-1-haifeng.xu@shopee.com>
 <4244b729-2eec-4999-9427-00b5c9f3e6fc@intel.com>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <4244b729-2eec-4999-9427-00b5c9f3e6fc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/3/30 07:06, Reinette Chatre wrote:
> Hi Haifeng,
> 
> On 3/19/2024 1:30 AM, Haifeng Xu wrote:
>> After removing a monitor group, its RMID may not be freed immediately
>> unless its llc_occupancy is less than the re-allocation threshold. If
>> turning up the threshold, the RMID can be reused. In order to know how
>> much the threshold should be, it's necessary to acquire the llc_occupancy.
>>
>> The patch series provides a new tracepoint to track the llc_occupancy.
> 
> There seems to be a problem with the DKIM attestation. Here is what I see
> when I download this series:
> 
>     $ b4 am -Q 20240319083039.223088-1-haifeng.xu@shopee.com
>     Grabbing thread from lore.kernel.org/all/20240319083039.223088-1-haifeng.xu@shopee.com/t.mbox.gz
>     Analyzing 3 messages in the thread
>     Looking for additional code-review trailers on lore.kernel.org
>     Checking attestation on all messages, may take a moment...
>     ---
>       ✗ [PATCH v6 1/2] x86/resctrl: Rename pseudo_lock_event.h to trace.h
>       ✗ [PATCH v6 2/2] x86/resctrl: Add tracepoint for llc_occupancy tracking
>     ---
>       ✗ BADSIG: DKIM/shopee.com
>     ---
>     Total patches: 2
>     ---
> 

Hi, Reinette,

I can also reproduced it. After digging into it, I found that our DKIM signature header
has 't' and 'x' flags. They are recommended as a means to help identify spam.

t= is the DKIM signature timestamp.
x= is the DKIM signature expiration time.

The source code of DKIM Validation can be seen in dkim/__init__.py(line 351), I paste it
here.

 343     if b'x' in sig:
 344         if re.match(br"\d+$", sig[b'x']) is None:
 345             raise ValidationError(
 346               "x= value is not a decimal integer (%s)" % sig[b'x'])
 347         x_sign = int(sig[b'x'])
 348         now = int(time.time())
 349         slop = 36000 # 10H leeway for mailers with inaccurate clocks
 350         if x_sign < now - slop:
 351             raise ValidationError(
 352                 "x= value is past (%s)" % sig[b'x'])
 353             if x_sign < t_sign:
 354                 raise ValidationError(
 355                     "x= value is less than t= value (x=%s t=%s)" %
 356                     (sig[b'x'], sig[b't']))

The expiry time is less than the time point you download the patch, so the validation
fails. If I comment out these lines, this series can be successfully downloaded.

The signature is only valid for a week. So if you use b4 to download the patch series,
It's best to do it in a week after the patch is sent.

Thanks.


> The patches look good to me. Thank you very much for adding this.
> Please resubmit with the DKIM attestation fixed and then you can add:
> 
> | Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Reinette

Thanks for your review.

