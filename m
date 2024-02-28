Return-Path: <linux-kernel+bounces-85351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9386B49F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604CD1F266B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22456EF02;
	Wed, 28 Feb 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DlYTXnuH"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D316EEEB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137234; cv=none; b=bk2UZpAK6YK0RhfHC4OnVvkV2uuQ4oGETlFUdEl1H9VoGuWfX/1lZJ3Tu+m9Be2z8kGT6XufSAmcKiwkzsq3iiwyyEhwRFzhAyV2/oF2yRTiVWrtFTKl48kDDBMMKT4odnqNXsZLLFCJQc2/i6Q8GoMUn42Whala5QN5V0N7Buw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137234; c=relaxed/simple;
	bh=gRqsnYVFkKn1kb+7kaBNUKqNIDOswnpt1ed9HwOe4gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ml+cUgD+ywvvm8RUrAe6KF+uJhkAJyi9dPIhyElreYU9dl58yswAvrPRZY/7A5FAP6rGOdiMbqbVStGV7I1T4q2XfbVjQ6ypUWdCJjcDR9bmpUerCSqy2NIbdoTYvhn7LtRNK6jQLiT0kIB7DG8FOx0UwlJ5NawQgxpV/2cmriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DlYTXnuH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412a14299a4so32170685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709137230; x=1709742030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/S/VGPvsfGjP7Vnsp0e+l7Ngw50qa9AEjKUyDL1iwOA=;
        b=DlYTXnuHNWE4DUxvb0FBTkYg9FbBkcl74nOgHppTQL7znArhzfFLEHwtMkQ81MyFYd
         oI+iuWFTT48NW71a+pE0vgvOdYFkYxsAVImGRsCVFojLcwR6QpRi7x8KU/Hpp644OZ2m
         RtgDjo/LL/3HeJ9jEv5xuS3LG+UOn6szwtljEpclawivirq+AslHYQY04evzmWvQd/DZ
         8pigHfFCMkOxpv4/LEh09KqFOwIfwB9p/0pDRylSAXJhc2xhjcd2qgxFtWmYLs7sTGG5
         wqfZ6/xQeAngXaCq2uJC54szidwXOm8M121svI1K8L24W1OgUrz+JYgHXfn5VqdbcsU6
         U2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137230; x=1709742030;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/S/VGPvsfGjP7Vnsp0e+l7Ngw50qa9AEjKUyDL1iwOA=;
        b=if9ctu3xa1szPBYGaZAeW60uqCa+mM3sLfnS4RsgEwP9Ye5E2OWFinZBY4KbzqGN9z
         OUN4djMYmfFXmNW5UwnIjyc6rLZrQW7gUSF0bNQrMIPd59ynUZdcXWx3lZIUFtHvgKqL
         83Ah3O87g6MbzPwF9iv16Ue7YHV2tTjcQMyBfNh/aj/CSwz+GDdQQVGT3/jsTcos6jiQ
         daqMuPNyOhMmoDnMhTk/q3uccETsin9qVh1x2wVdTHmO2UWQp7cIQqX7UBFkyio2eOtF
         YcO6+OipVswKi57+BPBb2JSJG0Y4hNBbLIedYJFVYRWnH+w3bcWRl47MqJBDqyabH8iM
         UNmg==
X-Forwarded-Encrypted: i=1; AJvYcCVFJo6/yig14t2gP7Q1+zkTVP7sfyeP00VK3jAjWJswZBIlIN2UzsGftxqO9l6/GUMxX0SrSH4VBS2KmqIdcF8piE/YnlS4CWERmvfv
X-Gm-Message-State: AOJu0YxEbhEDgrC506/LzxCDPMgw7sVc+ZLuJz3+extnDppuxvXjUExQ
	AsVBLBjNV3sMNxQTPARfkL6QTOP7ntfxks54q9dSLndZ/V4lN+Dk4cJo70g4LTU=
X-Google-Smtp-Source: AGHT+IHSTNPAeZQPfEjpv06cfjsWAjJN+aqIsA9v6MqW+59lP/s7aWpb1u0n+SUdmUzB+7s7HFvZxw==
X-Received: by 2002:a05:600c:46d3:b0:410:ed31:9e96 with SMTP id q19-20020a05600c46d300b00410ed319e96mr11058936wmo.11.1709137230312;
        Wed, 28 Feb 2024 08:20:30 -0800 (PST)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c1d2400b00412aff7874esm2546958wms.48.2024.02.28.08.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 08:20:30 -0800 (PST)
Message-ID: <12b30393-0b4b-400e-828b-231901d8933b@suse.com>
Date: Wed, 28 Feb 2024 17:20:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oneukum@suse.com>
Cc: syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>,
 bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com,
 tasos@tasossah.com, usb-storage@lists.one-eyed-alien.net
References: <0000000000003eb868061245ba7f@google.com>
 <99b0fb1b-37b3-4da4-8129-e502ed8e479a@suse.com>
 <9bbc5b63-33e3-44de-8bce-4c59dcce5e92@rowland.harvard.edu>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <9bbc5b63-33e3-44de-8bce-4c59dcce5e92@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.02.24 19:13, Alan Stern wrote:

>> It oopses here:
>>
>> 		} else {
>> 			if (!id[ATA_ID_SECTORS] || !id[ATA_ID_HEADS])
>> 				goto too_early;
> 
> Those two lines are debugging code you added, right?

Yes, sorry about that.

> 
>> 			sectnum = (u8)((lba % id[ATA_ID_SECTORS]) + 1);
>> 			cylinder = (u16)(lba / (id[ATA_ID_SECTORS] *
>> 					id[ATA_ID_HEADS]));
>>
>> in isd200_scsi_to_ata() because it must not be called before isd200_get_inquiry_data()
>> has completed.
> 
> It can't be; isd200_get_inquiry_data is called by isd200_Initialization
> during probe before any SCSI commands are transmitted.

So, you are concluding that the bisection is spurious because
without that patch the SCSI layer would see a capacity of zero
and not even try to read anything?

	Regards
		Oliver


