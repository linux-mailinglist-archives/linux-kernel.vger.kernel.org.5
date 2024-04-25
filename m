Return-Path: <linux-kernel+bounces-158429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE818B1FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11328B234F5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123484FAA;
	Thu, 25 Apr 2024 11:12:20 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC81200BF;
	Thu, 25 Apr 2024 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043539; cv=none; b=X4uhkS2HiCKOroQTBWE+fdLJ6BPj1K5tderjYZKfP2pYGCGuWIBuxIEv7r7lQXbwETMm+YHTJHmyrciBBSVSmUvm0D2no2aT62Dcw76qxzY2eiBstxA0ykv62sJOEBcLFJK4Lb4aZjM+n9/R2wrriiG843Q3cozc36z6To4vsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043539; c=relaxed/simple;
	bh=iqQqPqYqACrh9TGAaoZjcz+DJ2+3d5B5bVNJL98qTn0=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=Ldfr0fU4suSn2XMbB7In6n5f3Dn51Hymkeo/z4yzYYUJ0xsixRx0iv8HofvGmPurx7VDzm25YFarYkg/C+WdWy7lGXPvjiqVTblQXPoJyWAD5uWrC64r0fplCCME6x3gStH2TXpcGCjpjSzHgQrxikP1bqbsOO33xxeV3R6LpQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VQCpM3Gmlzcb1f;
	Thu, 25 Apr 2024 19:11:07 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id 801151800AA;
	Thu, 25 Apr 2024 19:12:12 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd500014.china.huawei.com
 (7.221.188.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 25 Apr
 2024 19:12:11 +0800
Message-ID: <662A3A8B.8030602@hisilicon.com>
Date: Thu, 25 Apr 2024 19:12:11 +0800
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Series applied to the HiSilicon arm64 dt tree:
https://github.com/hisilicon/linux-hisi/tree/next/dt64

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

I have went through your slide which is very helpful and detailed.
Thanks!

Best Regards,
Wei

> 
> Best regards,
> Krzysztof
> 
> .
> 

