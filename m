Return-Path: <linux-kernel+bounces-130420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44A8977D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A2C1F21B24
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46100153583;
	Wed,  3 Apr 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="U3Xj5F9W"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D746A152E11;
	Wed,  3 Apr 2024 18:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712167594; cv=none; b=oBcMQz/fTtwoXavhPujNh29Mu2RrIezW1Jd1Nyn6XGMiYx348tDKR26gBYNaL7fA9CD9xQH+KyVWvj+F2C1DyyRl3GwFhbUH4fiCh/4PnGCk2yMk5ym5MqYLmvMh7XE0VlSqO4/Yco8fru/DXetQptKYt4ITbOAsdtXsHgj+8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712167594; c=relaxed/simple;
	bh=5m6VOcgHOe4SYB/rSBcchnqgOUDENpQXobQNyZKgX0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqQ/Lq0nSzoQagDMmzj6Pp6W8MJdnbpKTPy9OiBnQRPQbp/yELiObFluRdJrk3vNF3NYZQcXRusezmKvdgaP7/mDdipaoefVmX6z7XRFc0b+nzqk8xkxrCTHOwkkDDeMBkNTYFT+nWAYi2u7bbWWQkvatEyePTX6QJA5+y4AJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=U3Xj5F9W; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 32C6E3F2F9;
	Wed,  3 Apr 2024 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712167589;
	bh=ddwEN/UnUOz25J/Hbmt3w3pE4mBozWKhgJVvL8PNpBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=U3Xj5F9WCYs+sEEOcYorfKeikV608XJApffKe6tDz41ykVkOSRrgKjZh+tZ0q7prH
	 DzUj352Ltg6r0LPtug6GzJEgtMgUlhw9jrBu8X12lUwp8M2Sds3nWL1f9ZIEFKc+f3
	 22lnaYwHjDbnSji/+Hi1ARrDF7O3Evwqw9v/lxUCNbqlC9qFYx/D82oGLQQ6sKsbFi
	 ebzMTJcfJ2ntsIckVV1MMlIBhyVUY2Lmcj4ORt2B6f6CTjsSWw2IDXpJn7moH2Rox0
	 osZVuE5Hto0hcdMw9ufa5n4M4TIp4GqWY+FEltZ3FS5K3/gR39hKUl1pP4Nb8IGf7t
	 dvHm6r1yIXRNg==
Message-ID: <a0819f54-7469-4c94-b567-71f634c84ac1@canonical.com>
Date: Wed, 3 Apr 2024 14:06:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5.15 Regression] block: rename GENHD_FL_NO_PART_SCAN to
 GENHD_FL_NO_PART
To: Greg KH <gregkh@linuxfoundation.org>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 axboe@kernel.dk, sashal@kernel.org, stable@vger.kernel.org,
 Francis Ginther <francis.ginther@canonical.com>
References: <924449dc-9b1f-4943-afe3-a68c03aedbb5@canonical.com>
 <2024040329-unstopped-spelling-64c8@gregkh>
Content-Language: en-US
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Autocrypt: addr=joseph.salisbury@canonical.com; keydata=
 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
 p24lPxLL08SuCEzuBw==
In-Reply-To: <2024040329-unstopped-spelling-64c8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/3/24 13:54, Greg KH wrote:
> On Wed, Apr 03, 2024 at 01:50:09PM -0400, Joseph Salisbury wrote:
>> Hi Christoph,
>>
>> A kernel bug report was opened against Ubuntu [0].  This bug is a regression
>> introduced in mainline version v5.17-rc1 and made it's way into v5.15 stable
>> updates.
>>
>> The following commit was identified as the cause of the regression in 5.15:
>>
>> c6ce1c5dd327 ("block: rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART")
> How is renaming a define a "regression"?
The "regression" is experienced after upgrading to the kernel to the 
version that introduced this commit.
The v5.15.131 kernel works as expected, upgrading the kernel to 
v5.15.132 breaks behavior that worked in a prior kernel version.
Reverting commit c6ce1c5dd327 in v5.15.132 allows the experience to be 
as before in v5.15.131.

>
>> I was hoping to get your feedback, since you are the patch author. Is the
>> best approach to revert this commit, since many third parties rely on the
>> name being GENHD_FL_NO_PART_SCAN in kernel headers?
> External kernel modules are never an issue.  Is this a userspace thing?
>
>>   Is there a specific need that you know of that requires this commit
>> in the 5.15 and earlier stable kernels?
> Yes.  And Christoph did not do the backport, so I doubt he cares :)
>
> Again, what in-kernel issue is caused by this?

Third party code that relies on the kernel-headers will no longer 
compile due to the name change.  Should we not care if we break things, 
even in userspace?

>
> thanks,
>
> greg k-h


