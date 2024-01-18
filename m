Return-Path: <linux-kernel+bounces-30501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2E9831F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA7F1C228A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB52E62E;
	Thu, 18 Jan 2024 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xS1ndC05"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770C2E621;
	Thu, 18 Jan 2024 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605599; cv=none; b=VFSIVJQGl10seYYiQgI0w6c7vzuf1kmABAf4SsjPqTh7Mu36LRsZLKa1U+YnWhVQ+lhJDD/Z0h65ziOskib1GcZZAfP1rnClZAfttJ6MF0H5fWZB5PsiOwQpaAdlEbTaHUdDk06f29kaTgXG2yJxnlxfi3GK6/MlI6N80HpfxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605599; c=relaxed/simple;
	bh=k+DLUCUySTV6V8E9Lndn3PNi1fHJQBJ4szoGQe+/80c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYrHEyGOYeBvOCgoubBvfA+2Hecs/7LPpxdNoxCnTvLCfMgClTvRuDpaAT+Z/mm6zBIqnY677g0EuSR6RDRGfkQLHYbbQf9B1h+gpprYPqeiu/w0S2p51cx6t7FukkkfNSgh5K4r6iEkbDNvolS93z19fI71Psl36oPH0qnM2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xS1ndC05; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CVyOT8QbEHYRk9mH+KsZ3nHeW0+Yr46xVFfPsGvB808=; b=xS1ndC05K1OiYG5kf8lYaCBcaM
	SEfb/ud6abcrXPFvrKDlcAizhXCIz6ETG9OP8EVi+XvfRG9/Hd0V98TPhwOYmDTSpTMkyxhck8ujS
	0j1BJbD63m3Ny3+qZVR5K07bmAhmOHO5vu1/YVOfVo0/TEB62QNaRZ5SeILbWTaCRASBteBa96a2i
	xFg/iFnBdACzscThlB7JG/BZfHFmLvrLoCHlp/509tescE7cIo610qmPTYu9qSF8mkOULY3Jx2PCT
	7m7wARn+jl+E/rJj+j0bcloCd2YRRN8KcNHzGrf2HdvqN+14n3QJ0UQmHNXBH4YTTDACxQ+3OgZ57
	GUW6eybg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQXvg-003bOW-2E;
	Thu, 18 Jan 2024 19:19:56 +0000
Message-ID: <5500fa27-13a5-420a-a558-13037d954748@infradead.org>
Date: Thu, 18 Jan 2024 11:19:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: rts5208: Add more details to Kconfig help
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Jacob Lott <jklott.git@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240118175947.82297-1-jklott.git@gmail.com>
 <2024011829-gusto-absently-8192@gregkh>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2024011829-gusto-absently-8192@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/18/24 10:59, Greg KH wrote:
> On Thu, Jan 18, 2024 at 12:59:48PM -0500, Jacob Lott wrote:
>> The current help text is short and triggers a
>> warning from checkpatch.pl. This patch adds more
>> details to the help text which should provide better
>> information for whether or not to enable the driver.
>>
>> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
>> ---
>>  drivers/staging/rts5208/Kconfig | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
>> index b864023d3ccb..c4664a26ba3b 100644
>> --- a/drivers/staging/rts5208/Kconfig
>> +++ b/drivers/staging/rts5208/Kconfig
>> @@ -3,7 +3,11 @@ config RTS5208
>>  	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>>  	depends on PCI && SCSI
>>  	help
>> -	  Say Y here to include driver code to support the Realtek
>> -	  PCI-E card reader rts5208/rts5288.
>> +	  Choose Y here to enable support for the Realtek PCI-E card reader
>> +	  RTS5208/5288. This driver facilitates communication between the Linux
>> +	  kernel and the Realtek PCI-E card reader.
>>  
>> -	  If this driver is compiled as a module, it will be named rts5208.
>> +	  If you opt to compile this driver as a module, it will be named rts5208.
>> +	  Selecting N will exclude this driver from the kernel build. Choose option
>> +	  Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
>> +	  When in doubt, it is generally safe to select N.
>> -- 
>> 2.34.1
>>
>> v3 fixes the tab spacing for line 6 in Kconfig
> 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.

Jacob,
Immediately below the "---" line, not at the end of the patch.


>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot
> 

-- 
#Randy

