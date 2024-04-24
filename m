Return-Path: <linux-kernel+bounces-156622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D08B05E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99D11C22A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018C1158DD7;
	Wed, 24 Apr 2024 09:17:01 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A971158D87;
	Wed, 24 Apr 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950220; cv=none; b=DPEvspKdsCK6SmNQmBc44gVFQ6jmsdAEchf8P7gOa+Uc6kVrYMYf34cBvjRuKFuO2bTGRGQePxfDQldp0QDdrFNnQ1mCcRTmt/i8D72UYy2n3DKv4GTEajubNPKKIEvykj4KlUdGON0YN9tzr8hmf8AJt3yPTouImZd150FSsG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950220; c=relaxed/simple;
	bh=2kFrP6usDj5u4s7STZ+gSu3x3Vy8NjbK0EDKL6B6GBo=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=QRtuXB4IkkXo7t2PEhZvMfzD5yLyhxl3hZi/2rInvow6cO+LCWCnoXwjvfXIu9N+sDik9Aiq9m3DPZUx1aAcBdPXGg3ewOF8c1Lf1UgjCD3hAEgXs0eBdm2fwsrvdzQERbdtSJuNLg/pzQMdvlFc0+VgjavttD1sqMUrLCxTmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VPYFV5Ptjz1RDHV;
	Wed, 24 Apr 2024 17:13:50 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 42C9F1A0188;
	Wed, 24 Apr 2024 17:16:55 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd500014.china.huawei.com
 (7.221.188.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 24 Apr
 2024 17:16:54 +0800
Message-ID: <6628CE06.2060901@hisilicon.com>
Date: Wed, 24 Apr 2024 17:16:54 +0800
From: Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/9] arm64: dts: hisilicon: hip05: move non-MMIO node
 out of soc
References: <20240402193148.62323-1-krzk@kernel.org> <171394159880.43787.12383182687947213751.b4-ty@linaro.org> <6628B1E9.1050300@hisilicon.com> <7adfe10b-cfb6-4242-9520-dd9819bf7f43@linaro.org> <6ce7bc63-1c47-4e3d-a3af-8f229f1c36f7@linaro.org>
In-Reply-To: <6ce7bc63-1c47-4e3d-a3af-8f229f1c36f7@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500014.china.huawei.com (7.221.188.63)

Hi Krzysztof, 

On 2024/4/24 16:37, Krzysztof Kozlowski wrote:
> On 24/04/2024 09:23, Krzysztof Kozlowski wrote:
>> On 24/04/2024 09:16, Wei Xu wrote:
>>> Hi Krzysztof,
>>>
>>> On 2024/4/24 14:54, Krzysztof Kozlowski wrote:
>>>>
>>>> On Tue, 02 Apr 2024 21:31:40 +0200, Krzysztof Kozlowski wrote:
>>>>> Non-MMIO devices, which are BTW not really part of the SoC, should not
>>>>> be within simple-bus, as reported by dtc W=1 warning:
>>>>>
>>>>>   hip05.dtsi:301.30-305.5: Warning (simple_bus_reg): /soc/refclk200mhz: missing or empty reg/ranges property
>>>>>
>>>>>
>>>>
>>>> Almost a month passed, no replies from maintainers about picking it up. Dunno,
>>>> looks abandoned, so let me grab this. If anyone else wants to pick it up, let
>>>> me know.
>>>>
>>>
>>> Sorry for the late reply!
>>> I am applying these patches which are in the following git repo.
>>>   https://github.com/hisilicon/linux-hisi/tree/next/dt64
>>>
>>> And it is fine to me to go through your git tree.
>>> Thanks!
>>
>> So you picked them up? Why you did not notify anyone? b4 does it almost
>> automatically. How anyone can know what is happening with the patches?
>>
>> I will drop them from my tree.

OK.
I will pick up them.

> 
> One more thing:
> 
> Even though you applied these patches few days ago, they are still not
> in linux-next (as of next-20240423), which suggests your tree is not in
> next.
> 
> Please read entire presentation "Beginner Linux kernel maintainer's
> toolbox" from LPC 2023 and improve your workflow by:
> 1. Properly notifying patch status.
> 2. Being part of the integration tree.
> 3. ... and more, as explained in above talk.
> 
> There is a link to video and slides:
> https://lpc.events/event/17/contributions/1498/

Got it.Thanks!
I will go through it.

Best Regards,
Wei

> 
> Best regards,
> Krzysztof
> 
> .
> 

