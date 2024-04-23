Return-Path: <linux-kernel+bounces-155162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 088AF8AE60A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A641C209B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AFC84FD9;
	Tue, 23 Apr 2024 12:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="PqwNoUkq"
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83BF4594A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875400; cv=none; b=Q2wDi+ncSnsrn+Wxfb1sEyVD/Oc2a+fM86AwQXHeGtB2fcTa5Hmts8dsGKQhrXCQXFoxCWabNubRskCktcaFeKJXhVMfiF+WbklcG4hjRtoLH7c+mTrdcrDD4QZs9wfUEPeE5TqK0FmsKbuRITSoJY7MQs8fkDUrMM6h7CEnSYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875400; c=relaxed/simple;
	bh=Q99S/DEREDr4fChO9ym4b0hPsWbl1wtOVKah3zSOWJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NS9tSnwhpeMc1SCJW4Lao02fqxZ5CzCfUkT0dWVJeZ8br1sUHrO+OipSZEPIGIecWsUFWGKlFQIsaoMx/TGaCAS7IhJV73fCapyvJsTBtwPIh4QIVf+3NZ/vxxsPbh7Q8MfQG4/ZaeDG+g5UX6yT2+oBp5akaceZsSTzABzKwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=PqwNoUkq; arc=none smtp.client-ip=140.205.0.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713875394; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wTjKYtAEHOduKI0XEVExYwKYYYwxDyq717ZSUBWZezY=;
	b=PqwNoUkqeMTqXnYUWmFNBtI37i3jecOU1onLw5wEWSqEV//rRTt7FHWH3QD6EhWeqQN+PAmxxA9ah5hPj9O3+MfMa/gmz1itD+jYEhLdKwnoDexQD8ObQ+BsZwvDsAQ0WbP4ZpDXhIXXCEKqXRU9HzQPF+K3CRQIcVsAxcuc0eU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---.XJWNeVg_1713875393;
Received: from 30.230.91.3(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJWNeVg_1713875393)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 20:29:53 +0800
Message-ID: <3ce6a032-1bcd-47d2-86fb-0b33c541508d@antgroup.com>
Date: Tue, 23 Apr 2024 20:29:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] um: Add an internal header shared among the user code
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
 <20240423112457.2409319-6-tiwei.btw@antgroup.com>
 <e850e5016348805e7e2f427ed98cb1eb539fc434.camel@sipsolutions.net>
 <ee636701-3f92-4424-8b04-dd2cecd8313a@antgroup.com>
 <21cd05c895abc4f4e66190b26632543ff7990b32.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <21cd05c895abc4f4e66190b26632543ff7990b32.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/24 8:22 PM, Johannes Berg wrote:
> On Tue, 2024-04-23 at 20:09 +0800, Tiwei Bie wrote:
>> On 4/23/24 7:30 PM, Johannes Berg wrote:
>>> On Tue, 2024-04-23 at 19:24 +0800, Tiwei Bie wrote:
>>>>
>>>>  $(USER_OBJS:.o=.%): \
>>>> -	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h -include user.h $(CFLAGS_$(basetarget).o)
>>>> +	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) -include $(srctree)/include/linux/kern_levels.h \
>>>> +		-include user.h -include $(srctree)/arch/um/os-Linux/internal.h $(CFLAGS_$(basetarget).o)
>>>>
>>>
>>> Why not just include it explicitly?
>>
>> I think it might be more convenient if we include it implicitly,
>> especially since there are two levels of directories under os-Linux/.
>> But I don't have a strong opinion on this. I'm also willing to
>> include it explicitly.
> 
> Yeah, ok, dunno.
> 
>>> We do have the warnings?
>>
>> Yeah. Without this patch, I can get below warnings with `make ARCH=um defconfig && make ARCH=um`:
>>
> 
> Sure. I meant, we don't need to hide the include, if we need to add it
> to some other file, we'll have the warnings as a reminder. :)
> 
> I don't think anyone today would write the code as it is now ...

Makes sense. Will include it explicitly. Thanks!

Regards,
Tiwei

