Return-Path: <linux-kernel+bounces-59443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B7384F733
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477D41F225D5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939AE69D2F;
	Fri,  9 Feb 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="F27PHmnY"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2569D06;
	Fri,  9 Feb 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488502; cv=none; b=OkXoojVHUIVsbXF+Eceybx8ESp97b84urdUDSXd6KKSwbzNOVfgpp2rWebGw0wyRbFoFaymP4QOmsGAkIu83K9feIkldaLt4BYNPFZI4lXt24ttr9BPJdEUTa3nfo9yHSBLR3kpZHey+tnuPTEh1l6htQdw79cqKPO5fJa7iZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488502; c=relaxed/simple;
	bh=ftA9Fo7g2wtjDSzW77/KjG5A162BrIDTYmApgh1fI6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Je585fxkZN1yWb7DaIQfawW8QAiY8uLR81ucPZy1+tt+89U41QxzRpv0jt/qCEFAbVdlHvY7iCeqGSsmL8RHqAHdEQjwXKx/yqeSPLgt2hfOCEmxNPxhQAtsWE02ZPjYgKIVwm0Qabn33dWKsp0lN7You0wsKCIJMk2UjrGogac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=F27PHmnY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7913B41A2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707488498; bh=taW+tkvDfbt2qy8v9nxzh69sp/ior4+xEzMGXz77F5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F27PHmnY6ZYKp4xw6+JHAJxKY60h8nYposF4baL+8MM68OwZLKH9BDs20Dt4fnxvx
	 47IIBUlzutPoBwf2JIdKYVUHcKTY0xu9yYQgkT/pWNhdXa4wjaET5UGgFZIyr7SwAC
	 L6kHybSckxdbNcIcR3kMbUh2sQu5LgtRqCTFMvW4mUGZTwPxRvnbkowOxf+mD/S5nQ
	 aa5k/L1HkT1A/732504ozxXGfy9hh4qE0Acj9wAVqvDOJpu1dO8EzfcPpx62/rH6On
	 tu4NxFpXU3nxPY+DiAld8mByNQa44Zjd9hUnXpQ6H8BK2bnXVevbAW7/aiKBpNggA+
	 UNwepEWTikRFg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7913B41A2A;
	Fri,  9 Feb 2024 14:21:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Christian Brauner <brauner@kernel.org>, Vincenzo Mezzela
 <vincenzo.mezzela@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH] docs: filesystems: fix typo in docs
In-Reply-To: <20240209-apathisch-lustig-c2f17bdd74ed@brauner>
References: <20240208162032.109184-1-vincenzo.mezzela@gmail.com>
 <20240209-apathisch-lustig-c2f17bdd74ed@brauner>
Date: Fri, 09 Feb 2024 07:21:37 -0700
Message-ID: <87jznden0u.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

> On Thu, Feb 08, 2024 at 05:20:32PM +0100, Vincenzo Mezzela wrote:
>> This patch resolves a spelling error in the filesystem documentation.
>> 
>> It is submitted as part of my application to the "Linux Kernel Bug
>> Fixing Spring Unpaid 2024" mentorship program of the Linux Kernel
>> Foundation.
>> 
>> Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
>> ---
>>  Documentation/filesystems/files.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/filesystems/files.rst b/Documentation/filesystems/files.rst
>> index 9e38e4c221ca..eb770f891b27 100644
>> --- a/Documentation/filesystems/files.rst
>> +++ b/Documentation/filesystems/files.rst
>> @@ -116,7 +116,7 @@ before and after the reference count increment. This pattern can be seen
>>  in get_file_rcu() and __files_get_rcu().
>>  
>>  In addition, it isn't possible to access or check fields in struct file
>> -without first aqcuiring a reference on it under rcu lookup. Not doing
>> +without first acquiring a reference on it under rcu lookup. Not doing
>
> I stared at this for way too long to figure out that there's actually a
> spelling mistake in there. Thanks! I've snagged it. Jon, let me know if
> you prefer to take it.

I'd applied it too - sorry, he sent two and I replied once to the other
one, which you didn't get.  I can drop my copy.

Thanks,

jon

