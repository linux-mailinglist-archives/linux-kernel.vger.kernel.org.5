Return-Path: <linux-kernel+bounces-45708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0EE843475
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A15E0B23EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643171096F;
	Wed, 31 Jan 2024 03:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HRM9cMDa"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B4FBF5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706671235; cv=none; b=niD5TujuTA5Tfb4rv2kTBYdM7F4cXI3qbhvpUSVnng7iv0895qz5VWwkP0FUmjGuL2nyIKhE9G5AJm382lfDQjTNrG9vzds0mg1vmE6kuSHgl5u91kaIHKiTk/t3qEvV4GeqJ9j+mErirPQvsuh78ozl1G7WCpfUz4faPyD2jmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706671235; c=relaxed/simple;
	bh=/Qqp2jJQoiQcy+9XQkKKYRoLjCuSThH/r6RUzSX1uqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Riyjbg6HkhGk9z8SllnjK4imha8l//7ovRiZTJqsh+H3AO6SEkwm9D5u0AxlaGLEyUYspT/2h7nmUeNRZbJX2u30fYXnaqlhbfWBSngz252ff1T1Y/kJVsEX1aGJTHTl4abnHeq3eMrf/zitbgITOTeeR7At2BIjAsH3X7nwOtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HRM9cMDa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zzXR450Aj9tc/HlQzVUxw3+SErrBtlBnnD9/Q5pNze0=; b=HRM9cMDaKfn1MvaHYCkKefsPRy
	9bSCCe85Zyn+jMFI+XsJaCcQH3IlaC/pfvhGRHXJCM/MJpWfJDIzPquAW4DbUfuXLWppwFfdzvCS+
	HL0No4hrgxFGuFQNOXA66iO/s0cxdtvZDFYQo7ADGHXtTwds9+VZZMI1LhVZAUKCdaAnYW5kGqlH1
	wbWgBNufajje0pmyda8zm69Zmy0uTr9qRD5Q8XcyaNWItVdIf4vVs23kmuAX2kndsF0MU+cKr4gWu
	E6JPEUS7HO/8PYXDd/KtigZcHVL3mGLwsh6weT4HHXTVvFxkWecmpswK3BlskFtWYkOa6O7I+hbrd
	OU0LIZbw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV19M-00000001Mfi-1xkP;
	Wed, 31 Jan 2024 03:20:32 +0000
Message-ID: <52988afe-00df-47e5-b577-4e2dc36cf3d4@infradead.org>
Date: Tue, 30 Jan 2024 19:20:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit tag order vs. "b4 am"
Content-Language: en-US
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Tony Luck <tony.luck@intel.com>, x86@kernel.org,
 Reinette Chatre <reinette.chatre@intel.com>, linux-kernel@vger.kernel.org
References: <Zbl5XvzpqND9exmW@agluck-desk3>
 <118a560d-9e5f-4bc4-b0d2-ee0b3d6a5120@infradead.org>
 <20240130-solid-seahorse-from-camelot-e0ecdb@lemur>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240130-solid-seahorse-from-camelot-e0ecdb@lemur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/30/24 17:57, Konstantin Ryabitsev wrote:
> On Tue, Jan 30, 2024 at 04:47:26PM -0800, Randy Dunlap wrote:
>>> Reinette noticed that v14 of my resctrl/SNC patch series[1] did not adhere
>>> to the tag order proscribed in Documentation/process/maintainer-tip.rst
>>> Specifically my "Signed-off-by:" was now the last tag, instead of
>>> appearing before the "Reviewed-by:" and "Tested-by" tags as it had in
>>> v13.
>>>
>>> A little digging showed that my tag had been moved to the end by "b4 am"
>>> when I used it to pick up some additonal tags.
>>>
>>> An e-mail discussion with Konstantin ensued to determine if this was
>>> a bug. Konstantin said:
>>>
>>>    This is the intended behaviour, because b4 follows the chain-of-custody
>>>    procedure. If we encounter a Signed-off-by trailer matching the identity of
>>>    the user preparing the series, we move it to the bottom to indicate that the
>>>    chain-of-custody boundary has moved to include the code review trailers
>>>    received after the initial submission.
>>>
>>>    https://lore.kernel.org/tools/20221031165842.vxr4kp6h7qnkc53l@meerkat.local/
>>>
>>>    Basically, the "Signed-off-by" trailer is special because it indicates that
>>>    everything above it is the responsibility of the person doing the sign-off. If
>>>    we kept your Signed-off-by in the original spot, then it wouldn't be clear who
>>>    collected and applied the trailers.
>>
>> I can't find "chain of custody" anywhere in Documentation/process/, nor a
>> specification or example of this ordering.
>>
>> Where did this b4 requirement come from?
> 
> Many discussions at the Maintainer Summit and on the tools/users lists. E.g.:
> https://lore.kernel.org/tools/20221031165842.vxr4kp6h7qnkc53l@meerkat.local/
> 

Not your problem, but decisions that are made at the Maintainer Summit are not
well-documented IMO. They don't get passed down to the rest of us.
Yes, I do look at Mr Corbet's summaries, but they lack sufficient detail for this.

> The chain of custody approach is the only one that makes sense because it
> allows keeping track of who applied which trailers. I know that most people
> don't think about it twice, but it matters from the perspective of process.
> If we need to put it into the official documentation, I'm happy to submit the
> patch.

I don't yet agree that the tag order change is needed, but yes, it should be
documented, so please do that.

thanks.
-- 
#Randy

