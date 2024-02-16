Return-Path: <linux-kernel+bounces-68658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1435B857DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C67A1F25C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638512B168;
	Fri, 16 Feb 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="pVASS9Ft"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81A1292ED;
	Fri, 16 Feb 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091114; cv=none; b=cTYUrDudDxYn1cmMgZ7KloGm/9WSKLMNI7wLYEb64Nl6hCUVFG9lhe0oq3D12OD4dmnMkiMFUhPScAs2oTSYjHPNlfzB/YShPyBzBePFN2Rvaty+9VPWtkZfymcvcV0edhm4kXPLBFSCxMjhp8KSNxqYLleGNF4xyCcbJZTaJJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091114; c=relaxed/simple;
	bh=8GtGHT8LVulw7tmu8o75PRnqg0LS6+9SOuAYeQ3UYmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RG/pziwaoL4pDr97MwiRuuHcCEE8A7NtKouVE/mzmwzM67eMypo+wU/J4sqGynzECLA64dHBkMZ8LogaLpW+m1xALE0WdW+0pSEPGQ0cpgoYEv6lvLdoAW2NhOxpIuAMo4x6mLFIaDve/bFPdwxcjCll/Bxa8Ehe+r9pP6Ym77E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=pVASS9Ft; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708091091; x=1708695891; i=deller@gmx.de;
	bh=8GtGHT8LVulw7tmu8o75PRnqg0LS6+9SOuAYeQ3UYmA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=pVASS9FthfF+htDMzA41JpflKvE7wreFUpGQFhApngF+ovk53DEhixhF5Cbxl/pG
	 shs3LymlREhOPKGbzfRNgO9ZqM+YALVLQzp3xPTy8YjPmTrN4h90eIgiHs37QkB9C
	 W4DVfepSNUyDS0A6RLfSKjydn/dgp1LkMAH3b77sIk4zbpIlz+1CQjMPqXA1Cf7Ig
	 TsekceiShM/nABTvVQKaMk6hISVm51h3hYumIay0tnGo/2nQW7OsoAqLRZACwsMMe
	 eWpCDUNTZZBgSEOXse/swsL7PTr2nm+THGavfvHYVGvJgJvfj3T7Hv6983oET8md1
	 jhTILLoN+BwUXaq9jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.214]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1qxQd12C7U-014Acs; Fri, 16
 Feb 2024 14:44:51 +0100
Message-ID: <deb81dc1-71b2-4907-82ec-ec2aab3a40b2@gmx.de>
Date: Fri, 16 Feb 2024 14:58:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: make parisc_bus_type const
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240213-bus_cleanup-parisc-v1-1-2e61c77e66c6@marliere.net>
 <2024021335-correct-repossess-1d91@gregkh>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <2024021335-correct-repossess-1d91@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nI8yIY0RMqYrEMHHd1Y5crpgtUEJCIMhYIQEpcBA0SnLfR17JMc
 hmvZVMoes8FA2gobZdl9BIy8AVNHs1wmrGhAU5imEulOTDW1zI3KDYy9HUnvn7PmyVWtAnX
 BNcv8pLPU3Hg0UmMIzzRYwK6xsZpJLZ9pmyeJcPo9rzPejr0gysazno3FvS/omXJeSalEUM
 hZmkEY68EVJplkmVp9Qng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:B06QZj9kSrU=;MUp3Vk1ySB1e2iJFIiEL2y+xVDZ
 J2NHTKild9aE5EW7EvISj26+qQims2zJTnrgxcOpdsNMx3NmsxCfc3apibQIhJ9dvAS5ZeJx9
 prDqIsEoRzWC9LtdqwRlqDFmGqG7RvePIZsLdNZUl26pqBwed4RQxk/DddSG9u6F1LpxufkOT
 98bhwC/7D656MaApBn4AE4jBQWsvw8bpy3LctUWUc+MdY0jamavAWGrdID+Dyw8UdobblTRN5
 d4HbEGXCvcEsZnFP6y40CrhqKQHO8lbvbwC2gAz5V41cAttD2so/NfpO4eRQz0pficfkAWsIU
 lteQZrP3ccYieyjzZbrJ6tdHIb32cYXVFPilJH+g1vBLvYAqh4giNhXLlghW37Gk8+gvQBauh
 BJ1Kdte+pjR/ThTy4T3HIJS5kAupp01zKhcth5S58t1/OOUVWFxyrLne4bGjgXNStUTkoBvje
 uuavfRsjgfQeyCSONZiF3zf68/pK/cnui0X1gPXIPm4tJ3phYMAxi3eS/9nuNrDzM1hwZlkJF
 mrJFfZ0JcI45yV08prABFe7aTPHF5wIlla0PUhDYr9t0hluk/FL2azaAapsJnBogLjwC4WiVu
 Biy07CQAR5OLx+bOaLLWjf8FoklxSA+qaehUA6YDg+9ISf22I8yHjAHU9ZG043Lsnld1+tuLx
 Vb0H7unt9Zo/5xoHwM0g5fTTbJbAwevP6Tl78inOppPpSncX/2jl1B/6ji5W/x8j9+3FFZyHw
 I3+XGObA1zzehydUWM9PDaX7N/iN5FS37nScq3EinhGH0eK0RGgXul6ww6R43QRnkasuP4reE
 ZbV/b+YTJbYFMHAmfkB4vzrUv4IgyaH9EGn2MI1QwkP2Y=

On 2/13/24 18:29, Greg Kroah-Hartman wrote:
> On Tue, Feb 13, 2024 at 11:38:02AM -0300, Ricardo B. Marliere wrote:
>> Since commit d492cc2573a0 ("driver core: device.h: make struct
>> bus_type a const *"), the driver core can properly handle constant
>> struct bus_type, move the parisc_bus_type variable to be a constant
>> structure as well, placing it into read-only memory which can not be
>> modified at runtime.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

applied to parisc git tree.

Thanks!
Helge



