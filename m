Return-Path: <linux-kernel+bounces-29129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D922830945
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B39A282816
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04121378;
	Wed, 17 Jan 2024 15:12:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0828F21347;
	Wed, 17 Jan 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504324; cv=none; b=t3uFqycTzxRkPE+/jbRkOqBKbXCQMPmYllpMPBRAE8hu4IccxtV4EpBqyZbW7SzYhVqOgyu3W1Wjfi2991gyr44xMp9HD0uE5UIklnkpgpxMqMOTHtTQYRNAZUgqabwDXwuzApI1j6OTeiAyi89J52VVCR+2xgoRQgpbEE9oIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504324; c=relaxed/simple;
	bh=acCBulbuXyCgYg9lJzUatUvbDs5kj9YLkW2CYVibaBY=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 Content-Language:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Ydxt7LAjVJV9pm2srOosvpJFbypikQ5/aBPGSdPoP/WkgldH6p1CFEwfrW1hTMyhayhN/vRufqb0c/iSfQIP5xT+j8dwGA2zwaobcpfb94GYSE2AqS7uDQdONx8QCroT1i9987GsoWm2hZVrEbN3ZLatX4NDG103mBCxmepgcP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 749B311FB;
	Wed, 17 Jan 2024 07:12:47 -0800 (PST)
Received: from [10.1.26.46] (e133047.arm.com [10.1.26.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF9593F5A1;
	Wed, 17 Jan 2024 07:11:59 -0800 (PST)
Message-ID: <e3e0147a-4fdb-4422-807d-24760c4ac30e@arm.com>
Date: Wed, 17 Jan 2024 15:11:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: block: ioprio: Update schedulers
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "bvanassche@acm.org"
 <bvanassche@acm.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>
References: <cde50a18-7c09-4d00-b3b8-32da2992c952@arm.com>
 <8085ea13-29d2-46bd-8ca9-407d22266d0c@wdc.com>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <8085ea13-29d2-46bd-8ca9-407d22266d0c@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/01/2024 12:49, Johannes Thumshirn wrote:
> On 17.01.24 13:20, Christian Loehle wrote:
>> This doc hasn't been touched in a while, in the meantime some
>> new io schedulers were added (e.g. all of mq), some with ioprio
>> support.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>   Documentation/block/ioprio.rst | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/block/ioprio.rst b/Documentation/block/ioprio.rst
>> index a25c6d5df87b..5410308888d2 100644
>> --- a/Documentation/block/ioprio.rst
>> +++ b/Documentation/block/ioprio.rst
>> @@ -9,14 +9,14 @@ Intro
>>   With the introduction of cfq v3 (aka cfq-ts or time sliced cfq), basic io
>>   priorities are supported for reads on files.  This enables users to io nice
>>   processes or process groups, similar to what has been possible with cpu
>> -scheduling for ages.  This document mainly details the current possibilities
>> -with cfq; other io schedulers do not support io priorities thus far.
>> +scheduling for ages. Support for io priorities is io scheduler dependent and
>> +currently supported by bfq, mq-deadline and cfq.
> 
> CFQ went away with blk-mq and got replaced by BFQ IIRC.

Right, I'll remove the mentioning of CFQ here and in the introductory sentence.
The introductory sentence also mentions "basic io priorities are supported for
reads on files", a limitation which hasn't been there in a long time.
Thanks, will send out v2 tomorrow.

> 
> 
>>   
>>   Scheduling classes
>>   ------------------
>>   
>> -CFQ implements three generic scheduling classes that determine how io is
>> -served for a process.
>> +Three generic scheduling classes are implemented for io priorities that
>> +determine how io is served for a process.
>>   
>>   IOPRIO_CLASS_RT: This is the realtime io class. This scheduling class is given
>>   higher priority than any other in the system, processes from this class are
> 


