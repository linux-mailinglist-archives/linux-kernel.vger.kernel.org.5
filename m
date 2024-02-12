Return-Path: <linux-kernel+bounces-62236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211C851D66
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E88285913
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EDF4176B;
	Mon, 12 Feb 2024 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KhAJpP54"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5853D97F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764203; cv=none; b=tEqdAjQDTr+JIUxGLazL3iRvBjDHdfAwrSGrpWS7F1z94N0+sPzq39Wn76L+VXP5DusUC4Vzv7Wmeo9/UWFBIvJofF/0WVl/gpJ8W2Q5LbmOL/rvT5ipvCQH21XWhPSZMwu8OqwBSPi/Y5b4Ufsviqzau7oBqDA3jgLZIy2/MXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764203; c=relaxed/simple;
	bh=8magsPAXosweiCdJmUy4LFIqGQ2gqWbDO4Z10h/F4rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cv+LH0Rtqe9FWR8UHDT3FhVaXra2pVFd5fHJXJScSeNN5dFxCqshShyF8OVgQTXccBVHdYvxs4Ya5F9fFhzQvW4kL3OjgDeppGN90kIIhhaZd47FPAOzJ2L9rFYezESQPIl5zKjsxkF+YLnaIQQdOdMDHrN2HzIQIzZbQRFYnSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KhAJpP54; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=m1baTKysIwyuQiFpS2joxHLjhtugrGXccjQD8FWaWpM=; b=KhAJpP54KtaON/ePLNbrIZ796l
	oRDSVhHpT0MVSmrExhD+m9suBWnsIAo+aJtfBVjHJPfau9OcjKIN0zNWW9VRryFtcH1ey3isGwqb4
	WIT8o183YuI/QD0oZNlilpYRFGo4hzVAZyhieJ+K03q2/G7TEYVxwJRXaekWMbPkn8mwHhXzIpU73
	ZeiQcfA40Tt7KOas6rApISSP/Oce8pXuQf/SU+Vbw7KBzKUkm4g9dpK6AfgmKVmEH7y7r8ycxHszm
	qfq5QPVkcsyPAQD+JQAYNPsrbTbYxeSIZSJ63ydW1zQmPaYK5Lv782PF92VK+kmgjIgdTh7b1qjxb
	W7qvWR9w==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZbTt-00000006hRv-1BZe;
	Mon, 12 Feb 2024 18:56:41 +0000
Message-ID: <4f3fa9e4-3000-4a96-a7f6-e32e69b57a84@infradead.org>
Date: Mon, 12 Feb 2024 10:56:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] iosys-map: fix typos
Content-Language: en-US
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
References: <20240212042837.21071-1-rdunlap@infradead.org>
 <bf0d02d4-2c90-40a4-8018-bd96a01f2751@suse.de>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <bf0d02d4-2c90-40a4-8018-bd96a01f2751@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/11/24 23:13, Thomas Zimmermann wrote:
> Hi
> 
> Am 12.02.24 um 05:28 schrieb Randy Dunlap:
>> Correct spellos/typos in comments.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: dri-devel@lists.freedesktop.org
>> ---
>>   include/linux/iosys-map.h |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff -- a/include/linux/iosys-map.h b/include/linux/iosys-map.h
>> --- a/include/linux/iosys-map.h
>> +++ b/include/linux/iosys-map.h
>> @@ -34,7 +34,7 @@
>>    * the same driver for allocation, read and write operations.
>>    *
>>    * Open-coding access to :c:type:`struct iosys_map <iosys_map>` is considered
>> - * bad style. Rather then accessing its fields directly, use one of the provided
>> + * bad style. Rather than accessing its fields directly, use one of the provided
> Ok.
>>    * helper functions, or implement your own. For example, instances of
>>    * :c:type:`struct iosys_map <iosys_map>` can be initialized statically with
>>    * IOSYS_MAP_INIT_VADDR(), or at runtime with iosys_map_set_vaddr(). These
>> @@ -85,7 +85,7 @@
>>    *    if (iosys_map_is_equal(&sys_map, &io_map))
>>    *        // always false
>>    *
>> - * A set up instance of struct iosys_map can be used to access or manipulate the
>> + * A setup instance of struct iosys_map can be used to access or manipulate the
> That's not a typo. This refers to "an instance that has been set up".
> 

Thanks. I'll drop that part and resend the other.

> 
>>    * buffer memory. Depending on the location of the memory, the provided helpers
>>    * will pick the correct operations. Data can be copied into the memory with
>>    * iosys_map_memcpy_to(). The address can be manipulated with iosys_map_incr().
> 

-- 
#Randy

