Return-Path: <linux-kernel+bounces-35007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B8838A6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8142860F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7BB5A0ED;
	Tue, 23 Jan 2024 09:36:14 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5C5A0E1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002574; cv=none; b=FgpXUO2VtuAW3yx3d60Ej5cUygNnYyyf94YzcXxDwa2eM8oxDdd0sDlWAUJ3NZ01Q9cfWIDzcpeoJ36uoF3SV8W1TyVt6WMBjgA1idSse0a1UepHz7gAAJm4xeHcIr62BvhG3FmmneIw9nkfoJGktpZNSX43PhU8+/cUM8R/bVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002574; c=relaxed/simple;
	bh=1zxKXfgVeWSW6tJREAxyZEBJCUWmCztiZUXsJ1mJTlU=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WI66Hf8XP+2LQaD/fsGAedH54TfvjCmO9uS3AAxf0wqIjD4u/48iI7jb7/ujtCWJIy7SMsqooT5ZLAJ9v879QHVK83klSFozRDoQytAVVnpUgPr1KcYnE8dP9vG+mqOQNn7rRHEYQiV+TQSSnWIC4m7WNCd2+sDIPFT8NgZ0meE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TK24h2NN4zNlQS;
	Tue, 23 Jan 2024 17:35:16 +0800 (CST)
Received: from canpemm500009.china.huawei.com (unknown [7.192.105.203])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A8C018007B;
	Tue, 23 Jan 2024 17:36:08 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 17:35:34 +0800
CC: <yangyicong@hisilicon.com>, Marc Zyngier <maz@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<wanghuiqiang@huawei.com>, <wangwudi@hisilicon.com>, <guohanjun@huawei.com>,
	<linuxarm@huawei.com>
Subject: Re: [RFC PATCH 0/3] Add HiSilicon system timer driver
To: Mark Rutland <mark.rutland@arm.com>
References: <20231010123033.23258-1-yangyicong@huawei.com>
 <874jiymo2l.wl-maz@kernel.org>
 <a170493f-cd9f-a0d9-432a-2ae07d18d429@huawei.com>
 <ZSZ7OiySl1wcG3CD@FVFF77S0Q05N.cambridge.arm.com>
 <a6597f6f-2a6f-7c04-b3b8-1fd2b7b394e1@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <c87f7e91-64ec-0197-f69d-34ab24debf5d@huawei.com>
Date: Tue, 23 Jan 2024 17:35:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a6597f6f-2a6f-7c04-b3b8-1fd2b7b394e1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)

Hi Mark,

On 2023/10/11 21:10, Yicong Yang wrote:
> Hi Mark,
> 
> On 2023/10/11 18:38, Mark Rutland wrote:
>> On Wed, Oct 11, 2023 at 10:10:11AM +0800, Yicong Yang wrote:
>>> On 2023/10/11 0:36, Marc Zyngier wrote:
>>>> On Tue, 10 Oct 2023 13:30:30 +0100,
>>>> Yicong Yang <yangyicong@huawei.com> wrote:
>>>>>
>>>>> From: Yicong Yang <yangyicong@hisilicon.com>
>>>>>
>>>>> HiSilicon system timer is a memory mapped platform timer compatible with
>>>>> the arm's generic timer specification. The timer supports both SPI and
>>>>> LPI interrupt and can be enumerated through ACPI DSDT table. Since the
>>>>> timer is fully compatible with the spec, it can reuse most codes of the
>>>>> arm_arch_timer driver. However since the arm_arch_timer driver only
>>>>> supports GTDT and SPI interrupt, this series support the HiSilicon system
>>>>> timer by:
>>>>>
>>>>> - refactor some of the arm_arch_timer codes and export the function to
>>>>>   register a arch memory timer by other drivers
>>>>> - retrieve the IO memory and interrupt resource through DSDT in a separate
>>>>>   driver, then setup and register the clockevent device reuse the arm_arch_timer
>>>>>   function
>>>>>
>>>>> Using LPI for the timer is mentioned in BSA Spec section 3.8.1 (DEN0094C 1.0C).
>>>>
>>>> This strikes me as pretty odd. LPIs are, by definition, *edge*
>>>> triggered. The timer interrupt must be *level* triggered. So there
>>>> must be some bridge in the middle that is going to regenerate edges on
>>>> EOI, and that cannot be architectural.
>>>>
>>>> What am I missing?
>>>
>>> In our case, if the timer is working on LPI mode, it's not directly connected
>>> to the GIC. It'll be wired to hisi-mbigen irqchip which will send LPIs to the
>>> GIC.
>>
>> In that case, the timerr itself isn't using an LPI: it's wired to a secondary
>> interrupt controller, and the secondary interrupt controller is using an LPI.
>>
>> The BSA doesn't describe that as a permitted configuration.
>>
>> I think there are two problems here:
>>
>> (1) The BSA spec is wrong, and shouldn't say "or LPI" here as it simply doesn't
>>     make sense.
>>
>>     I think this should be fixed by removing the "or LPI" wording form the BSA
>>     spec for this interrupt.
>>
>> (2) This platform is not compatible with the BSA, and is not compatible with
>>     the existing ACPI bindings in the GTDT.
>>
>> Do you actually need this wakeup timer?
>>
> 
> Thanks for the quick feedback!
> 
> So the LPI timer mentioned in the BSA spec is probably a mistake and our LPI
> mode is not compatible to the BSA spec. Then I need to discuss with my team
> and re-evaluate the solution for the LPI mode of the timer.
> 

Since our system timer interrupt supports both SPI and non-SPI mode. For some cases
we want to leave SPI interrupt for secure system and the timer for non-secure
system (linux) will be wired to the hisi-mbigen. Just want to confirm if the
solution to support the non-SPI mode in this patchset is acceptable for our use case,
though it's not permitted by BSA spec?

Thanks,
Yicong


