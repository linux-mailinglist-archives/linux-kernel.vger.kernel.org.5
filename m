Return-Path: <linux-kernel+bounces-109158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF25881582
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C4C1F23D24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD1B58126;
	Wed, 20 Mar 2024 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="Cb+pOU2J"
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1AB54FBB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710951683; cv=none; b=PDg7JdslJ6UNaZmO6bAog3KnV867JdIHfa6XNUNb2bFxQJAOz451eVKlJL36saSaaSAz8awDwN9uibNZet6AzTKzVZVQSpsXn4lXyVpcvt5ne+F2Fgn7EqblvvcT4jJKFM1DsAdPgtfe/igXytUntwTpti5KYsOp18YAiMOFUaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710951683; c=relaxed/simple;
	bh=gyvF1IOsSNtV7DoTvXZKG2k2ZhsNRKW2d7JqAyYwi1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRdC4HzWphaAVysQup/ISnNxFvZD1ZEs0uRFXLxFEuLMvAa8Xwno1kaDFi8+XB2cKcPiRFpbKqK1TuavUxLw7zHvW4NHlzeK6Hf5SGXGgJOY1RUoVRWsTaCrQFhDJfne7yXUK+3iyjqpXRvVXXnc7FNdgbH1Y5QAFo13feHhou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=Cb+pOU2J; arc=none smtp.client-ip=62.149.156.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.59] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id mydRrZKfJABX0myduraZxG; Wed, 20 Mar 2024 17:18:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1710951499; bh=gyvF1IOsSNtV7DoTvXZKG2k2ZhsNRKW2d7JqAyYwi1M=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=Cb+pOU2J8Aw6MULICnHrsOP4Vu0ugOjgLhTyHPXNblEf+7luegmZJ40Upu4t+CxQa
	 a2P+bCjmnHch7OOZXS7xrWRxcooWiR9PxobAwft9jpGtZMoepArg5ziguejvHr3Km0
	 0icQ8k2W+Ys9xMHFQu2a2OkHtYHSQx2RL+38AoXS+sfCZBltGpw9eHTMj9RGxcSc45
	 dYgJxkk2qBUCEzzMJIgSzfpeSmsXvmhEp752r6wYG++cA09OzG3wiOJJ3Ir5PHA7Ur
	 CzetCyMinj18glk7HPxfB3ZBQiQc9aNtbHQ1F0/utudyYZPrkGDiQakzZQ7AzqaXgS
	 xgSftN5+/rHKw==
Message-ID: <7e268aa0-f999-48af-8188-9158fc61a8c2@enneenne.com>
Date: Wed, 20 Mar 2024 17:18:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] Documentation: driver-api: pps: Add Intel Timed
 I/O PPS generator
Content-Language: en-US
To: lakshmi.sowjanya.d@intel.com, tglx@linutronix.de, jstultz@google.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, peter.hilber@opensynergy.com,
 pandith.n@intel.com, mallikarjunappa.sangannavar@intel.com,
 subramanian.mohan@intel.com, basavaraj.goudar@intel.com,
 thejesh.reddy.t.r@intel.com
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
 <20240319130547.4195-11-lakshmi.sowjanya.d@intel.com>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <20240319130547.4195-11-lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNi53SUDrigdbafA9GBsqTqvM52X7RdKb2VN1nxiFbtXbh5YcINBQR4rU5BXna+feDNynxbJcMJajiRI4vbed/FlpHFMA77WSAOYTX6AQjR/ta1DYJOn
 dDdNiSOWoAraOsufMMsPfo69B+uZQhAa6QMeVlBNZFEQIRtiJKAO4cTXKT51M2LIazKucN8o3A6GZo2ETtp30EjTcXvd/GCrlv/7p12EFmFHmGGn6uOGiGsS
 Jmcp76+bagWjvobBkHEYc/WGGUsMif5iRwohuL5hbEOvwtnE4mxiywkQ21yn7Ugx/t7DU5GRRrGdKqhV5w8Z6JnrGaNElKGhm0dmiIKmi3PfuOTwaSFBiBzi
 /Y8ACyFN2gA4+iPyMoeUi0EyawZhqIDD7pD/tvnCHb6jM1DvqUoydiUtWUdVSC9EkgW+5+eUHxc3gyTGcK0zJTLLzRrbruSbQsth3wZj7pkwUzpGScNyJxSt
 ONcgOtr36HwTuEkvuIhkJcEjJ4ODHCBumXEGy+svEpDkQcHtclO1lNVMbHT7iXAVwcJ4T8mYLNOlXrxAPY3YXthLXY1QGR9tHKo0NlybiGeYAt+68ZSIfSWc
 9AHGKUbe+hnOG0IIUThIn1sWZpBGRxYwDF3QEHToJvkTrxa0fEM26jolw86JqyayKedzPS4boZV21w2rFDi5/Hqpc8G/sx26ripVyAzpjFOKuNuJnvzW2rL3
 gD6M9yqR7qWvTsTCuh+6HC7EghcTuwtoBMVpwk+g0pwAo675NdySZDh2Hl04azaOlP76skXrOoxJplHvf+pJAkOmQ1PTyOjq2eUkMqnADsr9VIiIO5SPkNmx
 NzVmpIOqVuzdReEkHEHlNHZquccMTi5kNFmppGtPvFuBnSxRxSXkD86OBef2YoH1APKk4wGg6GQFlNHIwozbgkwm1p7c7l3uUKINUD+tJdUqbpOnSInQQ6rX
 KES82y59243FOS6wLChS2E2pfTMu1brxzhDlHyoRwMMMBIeA7rnSTYsl/WriEcL3L8PI2SY031EKgxOxqECjp7uKTOqABX/oCM9Q8saGrdr9OBMTVpXpIENh
 eRrRat2V+cAvFNapga5vhiMSQOtj5gmfJea9OTxiYl4nSm5shfzhIUMudLBxydoyclthvQYPVipznQ==

On 19/03/24 14:05, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Add Intel Timed I/O PPS usage instructions.
> 
> Co-developed-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Pandith N <pandith.n@intel.com>
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
>   Documentation/driver-api/pps.rst | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
> index 78dded03e5d8..52a6d5faf885 100644
> --- a/Documentation/driver-api/pps.rst
> +++ b/Documentation/driver-api/pps.rst
> @@ -246,3 +246,25 @@ delay between assert and clear edge as small as possible to reduce system
>   latencies. But if it is too small slave won't be able to capture clear edge
>   transition. The default of 30us should be good enough in most situations.
>   The delay can be selected using 'delay' pps_gen_parport module parameter.
> +
> +
> +Intel Timed I/O PPS signal generator
> +------------------------------------
> +
> +Intel Timed I/O is a high precision device, present on 2019 and newer Intel
> +CPUs, that can generate PPS signals.
> +
> +Timed I/O and system time are both driven by same hardware clock. The signal
> +is generated with a precision of ~20 nanoseconds. The generated PPS signal
> +is used to synchronize an external device with system clock. For example,
> +share your clock with a device that receives PPS signal, generated by
> +Timed I/O device. There are dedicated Timed I/O pins to deliver the PPS signal
> +to an external device.
> +
> +Usage of Intel Timed I/O as PPS generator:
> +
> +Start generating PPS signal::
> +        $echo 1 > /sys/devices/platform/INTCxxxx\:00/enable
> +
> +Stop generating PPS signal::
> +        $echo 0 > /sys/devices/platform/INTCxxxx\:00/enable

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


