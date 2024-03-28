Return-Path: <linux-kernel+bounces-122408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0D088F69B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D501C27E41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6273FBA2;
	Thu, 28 Mar 2024 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VoJX3Ifx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AB645BFE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601272; cv=none; b=dUHfy2zsS0L8qYJBApXHkZkCY38Tn2TeEyvV3yd3NHzJ5o1cSqnO+Tf7jZEoLTCSCcQstt1+KmuEpJcTANf+Uofb9GOLFMq+nXsMM7NUzgV1HxFmdKdSUMmt+93DpAJtF812ULTB1sGYPwNvWoLNXxU+eCZDvUxlFiOM00Xs5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601272; c=relaxed/simple;
	bh=d3A86BctIuCxhSuJwEib/WmsULz0e58Ssh5pV+xKO/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhKxIEgmOzz4hBuWA3vEyecoIvQmU+TOfi5bv8br3ULe82/IOXa2dprRU1fBADArtlf4CLIE+7fUgXsWWNPY5OdOZlfUMLKNRRawuj/UgyChseuP+Pfx+V2ZyT1meNuQ+4wBl4NE51Z/kye7P3p+y95CqksvaxkUfiBltyHdVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VoJX3Ifx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZeyI246RdPv08pafnqQ6MRH7GAOmb2wa7EV6ApCd9zc=; b=VoJX3Ifx6dpNP2vF7afTf36fav
	OgDWRnogJsWpcVZoXmhAtotOqQds9MaIcnPYG9nDRG4jNZRciFvw2Dxy+CJm3tZ6L4QGVKiZDXrhL
	2n9J4s955Fi+NnRBhCYmiGtgTQbNIfhByhNb4os8T4twId1MDPeBrj9wpmPwa6Q19BDh8HdhkKNVy
	A60/sOHE8EaI6PYlAOQs6kSOj6YeTkA0bJqit5hP0KH1gWmc0lHUlvEpr8C3uhsGL2rqV3IBnBkck
	CmuWpR/59SewYTiJ5FCUjYWoy8eLLxiu0cCX0sTvxAuqaarZwcuj+6w8C27Yz4gdSYFSYRvdjuu2x
	fFRuWunA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphg5-0000000CQcN-4Ak9;
	Thu, 28 Mar 2024 04:47:50 +0000
Message-ID: <d9bf12c1-4d21-40d4-9abe-95a4d8b59d8f@infradead.org>
Date: Wed, 27 Mar 2024 21:47:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] peci: linux/peci.h: fix Excess kernel-doc description
 warning
Content-Language: en-US
To: "Winiarska, Iwona" <iwona.winiarska@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
References: <20231223050605.13961-1-rdunlap@infradead.org>
 <a3ea93b54911f553a6ca37d33181be0cf9f89b07.camel@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <a3ea93b54911f553a6ca37d33181be0cf9f89b07.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/10/24 06:19, Winiarska, Iwona wrote:
> On Fri, 2023-12-22 at 21:06 -0800, Randy Dunlap wrote:
>> Remove the @controller: line to prevent the kernel-doc warning:
>>
>> include/linux/peci.h:84: warning: Excess struct member 'controller'
>> description in 'peci_device'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Iwona Winiarska <iwona.winiarska@intel.com>
>> Cc: openbmc@lists.ozlabs.org
> 
> Reviewed-by: Iwona Winiarska <iwona.winiarska@intel.com>
> 
> Thanks
> -Iwona

Hi Iwona,

Who should be merging this patch?

Thanks.

> 
>> ---
>>  include/linux/peci.h |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff -- a/include/linux/peci.h b/include/linux/peci.h
>> --- a/include/linux/peci.h
>> +++ b/include/linux/peci.h
>> @@ -58,7 +58,6 @@ static inline struct peci_controller *to
>>  /**
>>   * struct peci_device - PECI device
>>   * @dev: device object to register PECI device to the device model
>> - * @controller: manages the bus segment hosting this PECI device
>>   * @info: PECI device characteristics
>>   * @info.family: device family
>>   * @info.model: device model
> 

-- 
#Randy

