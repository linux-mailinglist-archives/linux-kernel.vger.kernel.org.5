Return-Path: <linux-kernel+bounces-84850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC87D86AC82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5EE1F24203
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D46B12C535;
	Wed, 28 Feb 2024 11:05:11 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5B7E577;
	Wed, 28 Feb 2024 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118311; cv=none; b=AmP/rm1NsdH9a7FDc22FHgq/JJ2A7IO1TL/BnQ/3DaTuElseFQKA0rCN+iX/DP9AY/e0pLF7tn61Fr8d/3q1QV9v/gOTwBNtPzNiHaGmyNlSxRSxvx+iXzeuD5IARP8UQ2r/3qhAucztV0dS0rPQ3kqL5lNMLOY9wY5OHukwxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118311; c=relaxed/simple;
	bh=8NK4irqoUtZNeA9ilQS8XOvOEpho8tVdwBHh1QuXj1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkGc9mNBfRdhZtaJqOfVf/vRn5He2YXHW8VE9smjtwMM+QNqAWj+/yjuxAsORLGP1DAnhFW3nprsQDaqgGWMCB32yLEXIBDN6i77d0vdHLLi+nJJ4jV8aWnBh3TDKQOMdEqO2dOxKPWNtT79a48MRS66p/J8crBS6izhEyBWP5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aedb1.dynamic.kabel-deutschland.de [95.90.237.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8347861E5FE05;
	Wed, 28 Feb 2024 12:03:57 +0100 (CET)
Message-ID: <e2b0b8e3-9b39-4621-9e43-d7de02286a27@molgen.mpg.de>
Date: Wed, 28 Feb 2024 12:03:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hwmon: Driver for Nuvoton NCT7363Y
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ban Feng <baneric926@gmail.com>, jdelvare@suse.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 kcfeng0@nuvoton.com, kwliu@nuvoton.com, openbmc@lists.ozlabs.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 DELPHINE_CHIU@wiwynn.com, naresh.solanki@9elements.com,
 billy_tsai@aspeedtech.com
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-4-kcfeng0@nuvoton.com>
 <62f38808-7d5f-4466-a65e-b6a64b2e7c01@molgen.mpg.de>
 <4b06d535-6739-47b5-ad1e-0ff94322620e@roeck-us.net>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4b06d535-6739-47b5-ad1e-0ff94322620e@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Guenter,


Am 28.02.24 um 10:03 schrieb Guenter Roeck:
> On 2/27/24 23:57, Paul Menzel wrote:

>> Am 27.02.24 um 01:56 schrieb baneric926@gmail.com:
>>> From: Ban Feng <kcfeng0@nuvoton.com>
>>>
>>> NCT7363Y is an I2C based hardware monitoring chip from Nuvoton.
>>
>> Please reference the datasheet.
> 
> Note that something like
> 
> Datasheet: Available from Nuvoton upon request
> 
> is quite common for hardware monitoring chips and acceptable.

Yes, it would be nice to document it though. (And finally for vendors to 
just make them available for download.)

>> Could you please give a high level description of the driver design?
> 
> Can you be more specific ? I didn't have time yet to look into details,
> but at first glance this looks like a standard hardware monitoring driver.
> One could argue that the high level design of such drivers is described
> in Documentation/hwmon/hwmon-kernel-api.rst.
> 
> I don't usually ask for a additional design information for hwmon drivers
> unless some chip interaction is unusual and needs to be explained,
> and then I prefer to have it explained in the code. Given that, I am
> quite curious and would like to understand what you are looking for.
For a 10+ lines commit, in my opinion the commit message should say 
something about the implementation. Even it is just, as you wrote, a 
note, that it follows the standard design.


Kind regards,

Paul

