Return-Path: <linux-kernel+bounces-47635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8E845086
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706DD1C245B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6403BB46;
	Thu,  1 Feb 2024 04:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RdGiomsW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951082A1D3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706763140; cv=none; b=QR8As96ub91ePvFdmR+uaBznPtVCzfvWYgHE7omyQwv3OfmsixECaHbbBQkGvXoHCToFzTBCRKU33BRHqIRtLc+Pm3gcRWONRjbqmZo+4bVPny926hlC0krlLoaR6NjxxkG9eCFvWSNZs7diWHknPt91L+E8OmbI532r3ye/Jto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706763140; c=relaxed/simple;
	bh=OZlzijHS41eMYNPWuXdkhpLkci7bNC/y4ISFpdW8ohE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FG4pEagLhazFr1jKwr6vBmTbKekzPjH7RcNldo1+Hb7EOWe/qvlKk+VAoSBtMXav8jVP4aZUzeEqHDolp1eVdTQgBhIV5HR6ZVVkjwLdgkbL0pgso/sEMkmgJCdCdi+DbfbaAu6GYlIe+IMdeLFlubpJI7VLCiQt5CBzgRdnHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RdGiomsW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Cod8OqufV982nsvbulEVaxeRGjmgYsLaClkj39B5VYw=; b=RdGiomsWfbFz0vM8zRus/p/ua1
	NXtIPyOjnWGB6wiSa7uQcnASURlkdkK4CgAjo+QKi2jmRVSv2jHozzgPbYFHTjpODDe8zeKxRMvJi
	qnJYYUbebkcRBXdyY/VeBI/O/PhoFlDv2V+X/r68wUgsltgm0ItOhMuEmlKbUaobK4rL1bGBw4hkx
	lFJ0ygaPuEM4FOHyfw/TEvInD/KXA65BehgEgYrXgjyd86xrZeGcp4hSDja7PFgWDAYzoJoqGpAkk
	YkCqSdSr+JoO0xPXGq37+ZmkVIZth9WusVFgTn5bXe/hdqUKK9/BdC6LMRtfCk2btj3+Yr1REVa9S
	o96ag8lg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVP3d-00000006ZSP-3brG;
	Thu, 01 Feb 2024 04:52:13 +0000
Message-ID: <2b482c41-4eb0-4a49-a425-469b05d63018@infradead.org>
Date: Wed, 31 Jan 2024 20:52:11 -0800
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
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240201010453.2212371-2-peter.hilber@opensynergy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/31/24 17:04, Peter Hilber wrote:
> Fix the kernel-doc warnings which show up with default arguments for tsc.c:
> 
> 	$ ./scripts/kernel-doc arch/x86/kernel/tsc.c >/dev/null
> 	arch/x86/kernel/tsc.c:1339: warning: Excess function parameter 'cycles' description in 'convert_art_ns_to_tsc'
> 	arch/x86/kernel/tsc.c:1339: warning: Excess function parameter 'cs' description in 'convert_art_ns_to_tsc'
> 	arch/x86/kernel/tsc.c:1373: warning: Function parameter or struct member 'work' not described in 'tsc_refine_calibration_work'
> 
> The first two warnings stem from members of the convert_art_ns_to_tsc()
> return type (struct system_counterval_t). For convert_art_ns_to_tsc(),
> the return type members are documented like parameters.
> 
> Since these members are already documented with the struct
> system_counterval_t definition, remove the redundant documentation for
> convert_art_ns_to_tsc(). This resolves the first two warnings.
> 
> Fix the third warning by appending a ':' instead of a '-' to the '@work'
> documentation parameter.
> 
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>

Hi,
or this way:

https://lore.kernel.org/lkml/20231221033620.32379-1-rdunlap@infradead.org/

Thanks.

> ---
> 
> Notes:
>     v3: Added on suggestion of Simon Horman.
> 
>  arch/x86/kernel/tsc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index d45084c6a15e..42328f9653c1 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1329,10 +1329,6 @@ EXPORT_SYMBOL(convert_art_to_tsc);
>   * Return:
>   * struct system_counterval_t - system counter value with the pointer to the
>   *	corresponding clocksource
> - *	@cycles:	System counter value
> - *	@cs:		Clocksource corresponding to system counter value. Used
> - *			by timekeeping code to verify comparability of two cycle
> - *			values.
>   */
>  
>  struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
> @@ -1357,7 +1353,7 @@ static void tsc_refine_calibration_work(struct work_struct *work);
>  static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
>  /**
>   * tsc_refine_calibration_work - Further refine tsc freq calibration
> - * @work - ignored.
> + * @work: ignored.
>   *
>   * This functions uses delayed work over a period of a
>   * second to further refine the TSC freq value. Since this is

-- 
#Randy

