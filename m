Return-Path: <linux-kernel+bounces-100518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD4A879902
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38940B21D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4DC7E0E3;
	Tue, 12 Mar 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="RYCtRoP6"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13467D3E9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710261264; cv=none; b=Ub9DI5Z6kgYd8SL++KchfQN1b3Jv4N6u4aVXOQrwURmChoPfuQaNpIb5l7zT8EGCk7joGbkmBXuKniYiJlxog4uf5inDCPfrVjfZpskhwYP8OvLjCt36ICgc0mgjFPVn8jhKuWLYmqKqfRiLcWjpFK5nD4zaLUHbyIDfmG1jxDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710261264; c=relaxed/simple;
	bh=Q8UoEfY8g3Wp9qgup/fEbAC07VBNkur6cm30edLLvNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMhPeWBU+TS1EpzTxXVqDrl5mLwpcauuVXJncBW8dxzh8X9xwMeqA38YMWE/6Ftx70Xx1h42+5dTRmmVoG2307WV4JlSGQEEH5dU9rFcdg8FWO739J2G/65oDCV2k3tbr4nFTpW5MqKm2mxM7/HFF1JR2zJHY2UHleOIg9eIk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=RYCtRoP6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42CGXQ5Y1539853
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 12 Mar 2024 09:33:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42CGXQ5Y1539853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1710261207;
	bh=721i2dGIwI2V+YyXn258Fnkb0bOucOyCaHfzJBy5wus=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RYCtRoP6rgAVnqaQ0VMNRN2uht+VDVo223pYdiwU0I4dMNsnqMT3R7bVhP+ORAOMC
	 JIpD4ARPtC6UR3UyI4wLIUmZG6lm3aNPcaafn7aMxyJkSuP7INJDtDIJB063vMJQok
	 dXgFQaq4ZYwYW/85ZHRHKXl/nx892MRDVMUVb17Gmjs7fyvQvm6Kz4/Ec2BmXxkRyc
	 TVVDKhhMCtmJR+YH2LsC1wyaZIurAJYJsHMvlKXg/TKcEjIiIqUCNFvzoceQPZo1CS
	 wEcgOCauJSI48ByjKpZA5ZddMLXEXUuq92XejXUAU7fIrxA/tS9vUebkI3XkbkfiPf
	 R6YYlYfG8qEjA==
Message-ID: <bf22db47-2085-44fc-81b6-91f39cd5e4d0@zytor.com>
Date: Tue, 12 Mar 2024 09:33:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/fred: Add missing *it* to Kconfig description
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Thomas Gleixner
 <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Xin Li <xin3.li@intel.com>
Cc: linux-kernel@vger.kernel.org
References: <20240312161958.102927-2-pmenzel@molgen.mpg.de>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240312161958.102927-2-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

LOL. Major QA failure :)

Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

Major QA failure there.

On 3/12/24 09:19, Paul Menzel wrote:
> The sentence is incomplete, so add the missing *it*.
> 
> Fixes: 2cce95918d63 ("x86/fred: Add Kconfig option for FRED (CONFIG_X86_FRED)")
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> As a casual user, I wouldn’t know how to figure out, what is required
> from my system to support FRED.
> 
>   arch/x86/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 8f7271d9f1d7..5fc9fdb84f46 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -504,7 +504,7 @@ config X86_FRED
>   	  When enabled, try to use Flexible Return and Event Delivery
>   	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
>   	  ring transitions and exception/interrupt handling if the
> -	  system supports.
> +	  system supports it.
>   
>   if X86_32
>   config X86_BIGSMP

