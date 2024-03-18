Return-Path: <linux-kernel+bounces-106841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A897387F456
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14784B217CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C35F87E;
	Mon, 18 Mar 2024 23:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="sidolu/g"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7485F873
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710806394; cv=none; b=fgyyHj3ZOYDm4uCBJqpPLiHEb4eWK5qssTpNbbNWa6jmgIzsg9vChk6yQ/hqVltE1B4VWWgSESBqzE+AYBiFjScLJiU3/Wk3KAdFE7mwa6+zcEu0BHwP95CzrmDTqBHZeTZLm3Ba3yYWbQEfXGLsSs08kAc+I6TZmLbPBm3oe4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710806394; c=relaxed/simple;
	bh=ElLiTVxcmJle7UtLKCTpM6rcHrJP3m3DslckjAJ+o2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUaXgTKl6koDgsTAQncNaeey1rUrnaMaRmgQFgA3wjLvE1LK/Cmlt1QH6UQdC1gzaUArmuitwPQkYI9jeZg1JyYQMWolAF1XmPwrwOSDHo2NBdOnvv8xA6BaYVBBvZK2JhcKB/QtoVJFPtPNanU53pG9/P/IuQaBGrWf+wVV0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=sidolu/g; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id mLXZrftxHPM1hmMtNrNPcM; Mon, 18 Mar 2024 23:59:45 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mMtMrRVAvybtzmMtMr5m39; Mon, 18 Mar 2024 23:59:44 +0000
X-Authority-Analysis: v=2.4 cv=RsAOLzmK c=1 sm=1 tr=0 ts=65f8d570
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=zL1ebxPFBZ_Ilvq-UgQA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z3Vya20dY0mWdmCkQilYCaqVfInKVcnxM24ENtjMVvs=; b=sidolu/gK1+hPsSXqvNuJY/TZ1
	6fqRopQ3PFN2NHqq8Vg7oiEn+0/ZeSQLeluey3K66la59ajHf/7BnFXN8ricrHesma6c8IgSIIpG6
	smse2ekSWlyukeFykHLs/YamC+MVy1lMW077IiR8dokcvBtV6crY/bQRhVftblpoCfJpYyrD2EtW8
	bLJQ5mNChVW8Y7znDSO/z9JRSxuCbAHufnpXXU8U2k4TmiMTI+aixhUVQLzIOLW6L3UYFr1cUK+R4
	Pli8YtXjxD9uKbXoqrzZ0n13Q+EiMqusXEu4clNFUOZsEyDmGVX4nVbq19kaJAHNW+Q3rbTUoK3FP
	WKvXHyPQ==;
Received: from [201.172.174.229] (port=45042 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rmMtL-001CBX-2Y;
	Mon, 18 Mar 2024 18:59:43 -0500
Message-ID: <1c05cba3-41c9-4862-b126-4ec6a79876d6@embeddedor.com>
Date: Mon, 18 Mar 2024 17:59:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] stddef: Introduce struct_group_tagged_attr() helper
 macro
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZfjHkXJWg12rARKU@neat> <202403181652.B8787FB288@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202403181652.B8787FB288@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rmMtL-001CBX-2Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:45042
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC5DWoLMRl8B/CfshWFZcHzPAXaHOtJOeZ6SrTSBJjGAD47kvTpsRnwafz+Ge5gThlc0fZwmXgra5OY8hNWtZF3QctmzX3nKCRIMh9gTmsGcvQbJcN8W
 Yx3+cxtxW01/ZuxgOnrJJ3r74CHuaGGBdDp3Phh9IMbXQmSpejiJ4Uu23zw2FSyspj01hc8VQbzlL/TefC8B2sT2o518IGoob4IMGLbVsqgNmDodWQIMrQ9J



On 3/18/24 17:53, Kees Cook wrote:
> On Mon, Mar 18, 2024 at 05:00:33PM -0600, Gustavo A. R. Silva wrote:
>> We need a new `struct_group()` helper that allows for both having the
>> struct be tagged, and specifying struct attributes like `__packed`
>> or `__align(x)`.
>>
>> This new helper will initially be used to address
>> -Wflex-array-member-not-at-end warnings, where a tagged struct is used
>> to separate the flexible-array member from the rest of the members in
>> the flexible structure [1]. There are some scenarios in which those
>> members need to be packed, as well.
>>
>> So, `struct_group_tagged_attr()` is introduced for this.
>>
>> Link: https://lore.kernel.org/linux-hardening/ZeIgeZ5Sb0IZTOyt@neat/ [1]
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   include/linux/stddef.h | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/include/linux/stddef.h b/include/linux/stddef.h
>> index 929d67710cc5..919df9453257 100644
>> --- a/include/linux/stddef.h
>> +++ b/include/linux/stddef.h
>> @@ -80,6 +80,26 @@ enum {
>>   #define struct_group_tagged(TAG, NAME, MEMBERS...) \
>>   	__struct_group(TAG, NAME, /* no attrs */, MEMBERS)
>>   
>> +/**
>> + * struct_group_tagged_attr() - Create a struct_group with a reusable
>> + * tag and trailing attributes.
>> + *
>> + * @TAG: The tag name for the named sub-struct
>> + * @NAME: The identifier name of the mirrored sub-struct
>> + * @ATTRS: Any struct attributes to apply
>> + * @MEMBERS: The member declarations for the mirrored structs
>> + *
>> + * Used to create an anonymous union of two structs with identical
>> + * layout and size: one anonymous and one named. The former can be
>> + * used normally without sub-struct naming, and the latter can be
>> + * used to reason about the start, end, and size of the group of
>> + * struct members. Includes struct tag argument for the named copy,
>> + * so the specified layout can be reused later. Also includes
>> + * structure attributes argument.
>> + */
>> +#define struct_group_tagged_attr(TAG, NAME, ATTRS, MEMBERS...) \
>> +	__struct_group(TAG, NAME, ATTRS, MEMBERS)
> 
> This is the same as __struct_group() only with a longer name? Why not
> just use __struct_group() directly?
> 

Mmmh, the rest of the helpers in the struct_group() family fall in this
same category, can we use __struct_group() indistinctly?

--
Gustavo

