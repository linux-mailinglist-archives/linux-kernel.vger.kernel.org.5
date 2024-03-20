Return-Path: <linux-kernel+bounces-109399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624A8818A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D9F283CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592DE17578;
	Wed, 20 Mar 2024 20:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eJR6sbSR"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3673B1B7F5;
	Wed, 20 Mar 2024 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710966668; cv=none; b=ntTHjbstj7TqGtgJZBpKW4Gpa4iJgDUw0NILCb6BWSxva7cuYba3T96zf2JJGYPAOGa2quL59a4+jU6XDvHK5FvJ62H8WsceP6L9sVY7zSot96sxKYyYTpCc66YjYxmh8hKjDMAPGALXLAAdHQZjWb8N+DLQyvTFyBK3ChqOafA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710966668; c=relaxed/simple;
	bh=ftELp+AQpN+pT8FlMdTcA2etrhKsXPl9MtAA44puBeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijefk5s138sULWnYRdKFBJPfsky3ggqrF5mLjv+rdtxpIQqBEQ++OTUaBQUo0NNdZgYO9x45uMoPQqGzHN8+mwA+JUESfiUGBLWOOJCuirFPh7Igjpu12A6rpm6Twt7AEFA18sx0Jpx5BAwpVVck4A3MyT9/QYzwx/Lg5w5/ufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eJR6sbSR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.106.151] (unknown [167.220.2.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8A6A720B74C3;
	Wed, 20 Mar 2024 13:31:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A6A720B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710966666;
	bh=LjNajcTf5mT64oJtdPlWYXohXjlD7KHbVX6iVtTNaxM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eJR6sbSRnr7jKg1NOAoDHQjhMsLt2lbwNoUurE8453RHuwOP/lav2yod0rrGbe9p7
	 245ClYUHJ3mecsRXR37rNvTVNg31oEz2ju7BzIZHeIZvg4e6hxTcCVU/+vwVA50149
	 LDRtRn74I/Tmd9JYCYNcR6ERNpSTh8T0MVBo+5G8=
Message-ID: <a69805c7-7b8a-44ee-9b32-f9314b5a9763@linux.microsoft.com>
Date: Wed, 20 Mar 2024 13:31:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v15 12/21] security: add security_bdev_setintegrity()
 hook
Content-Language: en-CA
To: Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
 tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
 snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1710560151-28904-13-git-send-email-wufan@linux.microsoft.com>
 <f5cf9d285bd5f09bbc3f79b0800d37fc@paul-moore.com>
 <CZYFP5S04YTK.23AJMKWQWVCR8@kernel.org>
 <CZYFR8LEEQB1.8C0J9KCTF8CB@kernel.org>
From: Fan Wu <wufan@linux.microsoft.com>
In-Reply-To: <CZYFR8LEEQB1.8C0J9KCTF8CB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/20/2024 1:31 AM, Jarkko Sakkinen wrote:
> On Wed Mar 20, 2024 at 10:28 AM EET, Jarkko Sakkinen wrote:
>> On Wed Mar 20, 2024 at 1:00 AM EET, Paul Moore wrote:
>>> On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
>>>>
>>>> This patch introduces a new hook to save block device's integrity
>>>> data. For example, for dm-verity, LSMs can use this hook to save
>>>> the roothash signature of a dm-verity into the security blob,
>>>> and LSMs can make access decisions based on the data inside
>>>> the signature, like the signer certificate.
>>>>
>>>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>>>>
>>>> --
>>>> v1-v14:
>>>>    + Not present
>>>>
>>>> v15:
>>>>    + Introduced
>>>>
>>>> ---
>>>>   include/linux/lsm_hook_defs.h |  2 ++
>>>>   include/linux/security.h      | 14 ++++++++++++++
>>>>   security/security.c           | 28 ++++++++++++++++++++++++++++
>>>>   3 files changed, 44 insertions(+)
>>>
>>> I'm not sure why you made this a separate patch, help?  If there is
>>> no significant reason why this is separate, please squash it together
>>> with patch 11/21.
>>
>> Off-topic: it is weird to have *RFC* patch set at v15.
>>
>> RFC by de-facto is something that can be safely ignored if you don't
>> have bandwidth. 15 versions of anything that can be safely ignored
>> is by definition spamming :-) I mean just conceptually.
>>
>> So does the RFC still hold or what the heck is going on with this one?
>>
>> Haven't followed for some time now...
> 
> I mean if this RFC trend continues I'll just put auto-filter for this
> thread to put straight to the bin.  There's enough non-RFC patch sets
> to review.
> 
> BR, Jarkko

Sorry about the confusion with the RFC tag – I wasn't fully aware of its 
conventional meaning and how it's perceived in terms of importance and 
urgency. Point taken, and I'll make sure to remove the RFC tag for 
future submissions. Definitely not my intention to clog up the workflow 
or seem like I'm spamming.

-Fan

