Return-Path: <linux-kernel+bounces-55603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2657F84BEC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A4628260F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36761B81C;
	Tue,  6 Feb 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mbYuYh4b"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748C1B805
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251682; cv=none; b=lHopWBebhG8cSN50lcCQo+MPF3BZ2vHE60cPIQn5FB7LB9dQiw3O0hFpIMCvdmcX7B20kFtV6/T8CiAC/Edpu2LTJFDTBfo7+5euvd+sUKUkMfV0qiHGtbZ1qtTHB1x8LVdOrEBDc+AN4ivgFG3lV1iRNXCEJmYBaYdmLfbxzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251682; c=relaxed/simple;
	bh=vEPV3I+CAx1isv/X5nA0vNG0WKopV7VQ2VCaydbvYVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3lDcc4Yj+52pkY3D5W5pzoCfx/OuMhAgxYgrarZBlboBDvuYzrv8qgFYMRjQDQGpHpw9eHs6kQTPrOGmOl5u3dY6UG/VUsWNIqx954J53SV+2ROpGh4T0ZDVzyqBaQzqRHIk2ty0ED/mHuNDM0AflPyFXEiEyr9VQXTUVoX0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mbYuYh4b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=diTbNYcTVwWZWU1JxmlHPNl3Y2LldxuZSFDXcVz3gu4=; b=mbYuYh4bxqq1fmVPmdXpueaKA7
	G9h6t1i7TzErN/lDGbekifPNoFpMcMbcqXEHgvjtf6TK/T3hVM7yDEA2djz6bD1aKXuLx3eUX6yKt
	SS2g7l2W3CA0iEgO3ySRDi3bLoCNC0YfFK68r2e/UxsWSoHNzSBF+OnWh7pSUFMUwT4Fm5P6GYYUQ
	DcwMAMDFo0GFnml4Af3sBb01W9JEW8JA91hMW24hbHAbeQkgPvOINpZxikxC6GD03zMPzsPPMnMmP
	iLqOKqkcwLny1SBy+kwcd57Mrv0LGjYJabW9gZ8v1FN5yGCv9vozDZC5xCJ40Q1xtIqLWWi+O75q/
	dqsQdiWg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXS9P-00000008rc7-1KML;
	Tue, 06 Feb 2024 20:34:39 +0000
Message-ID: <11173c11-ce80-4ae1-86a1-bf16c836eb6d@infradead.org>
Date: Tue, 6 Feb 2024 12:34:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] x86/tsc: Fix major kernel-doc warnings for tsc.c
Content-Language: en-US
To: Peter Hilber <peter.hilber@opensynergy.com>, linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
 "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, jstultz@google.com,
 giometti@enneenne.com, corbet@lwn.net, "Dong, Eddie" <eddie.dong@intel.com>,
 "Hall, Christopher S" <christopher.s.hall@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20240201010453.2212371-1-peter.hilber@opensynergy.com>
 <20240201010453.2212371-2-peter.hilber@opensynergy.com>
 <2b482c41-4eb0-4a49-a425-469b05d63018@infradead.org>
 <e25f9bc4-4155-4b55-bebd-48ae18fe856b@opensynergy.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e25f9bc4-4155-4b55-bebd-48ae18fe856b@opensynergy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/24 02:54, Peter Hilber wrote:
> On 01.02.24 05:52, Randy Dunlap wrote:
>>
>>
>> On 1/31/24 17:04, Peter Hilber wrote:
>>> Fix the kernel-doc warnings which show up with default arguments for tsc.c:
>>>
>>> 	$ ./scripts/kernel-doc arch/x86/kernel/tsc.c >/dev/null
>>> 	arch/x86/kernel/tsc.c:1339: warning: Excess function parameter 'cycles' description in 'convert_art_ns_to_tsc'
>>> 	arch/x86/kernel/tsc.c:1339: warning: Excess function parameter 'cs' description in 'convert_art_ns_to_tsc'
>>> 	arch/x86/kernel/tsc.c:1373: warning: Function parameter or struct member 'work' not described in 'tsc_refine_calibration_work'
>>>
>>> The first two warnings stem from members of the convert_art_ns_to_tsc()
>>> return type (struct system_counterval_t). For convert_art_ns_to_tsc(),
>>> the return type members are documented like parameters.
>>>
>>> Since these members are already documented with the struct
>>> system_counterval_t definition, remove the redundant documentation for
>>> convert_art_ns_to_tsc(). This resolves the first two warnings.
>>>
>>> Fix the third warning by appending a ':' instead of a '-' to the '@work'
>>> documentation parameter.
>>>
>>> Suggested-by: Simon Horman <horms@kernel.org>
>>> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
>>
>> Hi,
>> or this way:
>>
>> https://lore.kernel.org/lkml/20231221033620.32379-1-rdunlap@infradead.org/
> 
> Thanks for the link! I did not see your patch, I think I could add it to my
> patch series instead of my patch.

Sure, go with it. :)

thanks.
-- 
#Randy

