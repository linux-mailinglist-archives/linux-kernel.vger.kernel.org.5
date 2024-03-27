Return-Path: <linux-kernel+bounces-121638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3766288EB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62F871C23504
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED0149E1F;
	Wed, 27 Mar 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="X5JzQRV3"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8342A89
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557429; cv=none; b=WHwTCrqQ0fO36EAPaokzY1HRtX+G0V+p3urFSrom0kwWrKm33AmDDHE0VSZeLCdfr/Ge+3/ch/85FwrYHNRhXVWgczUZCLohJiptVFTQbsom8FFndO+XU5elzvE1GYixaUz/RVFLllLOH3kXAIRh/w5hjHESa1KUegy1LlgIt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557429; c=relaxed/simple;
	bh=B7YKPUAkZyNb/vU3Lf73sZ+fLANRpjCqm2VPw9Ijl64=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YAETdUiFgJNcM6jxbWJtM3b/T7cYyCw+nDQutqBldDfZ4OO6thsMp4y7s6vPKrH0u4B9ryzWGRMeSRsvaqQHecE/HRUet8IKYcZ2Ibf9ZCMGbvAsUaq2SasAYaTJBI0lYUmOIeZWyygzxi1L8BeXIPyCH3BKKwk9N1q5B2Zo5Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=X5JzQRV3; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [IPV6:2a01:cb08:8dcf:1a00:16f6:d8ff:fe12:3306] (unknown [IPv6:2a01:cb08:8dcf:1a00:16f6:d8ff:fe12:3306])
	(Authenticated sender: eric.valette@free.fr)
	by smtp2-g21.free.fr (Postfix) with ESMTPSA id 8D9B420041C;
	Wed, 27 Mar 2024 17:37:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1711557426;
	bh=B7YKPUAkZyNb/vU3Lf73sZ+fLANRpjCqm2VPw9Ijl64=;
	h=Date:Reply-To:Subject:From:To:Cc:References:In-Reply-To:From;
	b=X5JzQRV3m31IbE7WmJ4Jv4OK84t6urYK2WB7tV7zTWQZ0srRXpd0NwoItYibRSL3N
	 ZBwBh+m+Z2zYNXUmE3/8PJ86hdNU1eteDFuD3zvMUrvNdq0x1uNGJw+mc43ejphBxV
	 xo6UQWfAnqU3s7GVEcrQ0UlqisYXSYFz5ZYFO2LaPTzUc/pFXZd59WBRajRdlo6kb5
	 uaUInf5tp9+hLiS1QlRn4KfSHYMGduNaEHwQLQnbCAkg0Vn68Qbh+j8AtPouE/CReu
	 Nu+rhmlatZZA+TwdpKW09SK0BfIJ0uqfAlRDNWCvL2t/7vN4LIHJbEDWotem51Kj88
	 5IBq9FZOwFHEg==
Message-ID: <1e37c6e5-7565-4564-8caf-3290cef6d134@free.fr>
Date: Wed, 27 Mar 2024 17:37:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.valette@free.fr
Subject: Re: your recently submitted patch to fix BT RIP error shall be
 applied to 6.6 stable (I have a systematic crash on reboot in 6.6.23)
From: Eric Valette <eric.valette@free.fr>
To: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <878ae145-ad1f-4b48-abe3-2966a1c9a0da@free.fr>
 <PH0PR11MB512628ED33CB0EC120ECC08AD3342@PH0PR11MB5126.namprd11.prod.outlook.com>
 <8a6d3251-f7ae-4b10-956c-7d24a45464f5@free.fr>
 <608ed80b-89dd-4815-84ed-5a03abc19c17@free.fr>
 <PH0PR11MB5126D61336DDE016C3607997D3342@PH0PR11MB5126.namprd11.prod.outlook.com>
 <4f0de5c3-8e33-4f2a-a39a-c7efe528fa04@free.fr>
Content-Language: fr
Autocrypt: addr=eric.valette@free.fr; keydata=
 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
 wycNoa755G2xgOMORgXEMg==
In-Reply-To: <4f0de5c3-8e33-4f2a-a39a-c7efe528fa04@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27/03/2024 15:10, Eric Valette wrote:
> On 27/03/2024 15:01, Von Dentz, Luiz wrote:
>> Hi Eric,
>>
>> Then it must have been backported, which is kind of odd given that it 
>> was just merged for an -rc release that is still not consider stable, 
>> anyway the real culprit might actually be the following:
>>
>> https://patchwork.kernel.org/project/bluetooth/patch/20240327140855.896095-1-kiran.k@intel.com/
> 
> 
> Reading the patch, I'm afraid, if I apply the patch bt will then not 
> work if I reboot which is not what I want (I suspect  the firmware is 
> probably not unloaded when rebooting). Or am I making wrong assumptions?
> 
> NB: I may try to be sure...

Only get the first error and bt is still functional. Thanks.

Do not forget to queue the fix for stable.

-- eric


