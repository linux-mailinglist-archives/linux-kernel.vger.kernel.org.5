Return-Path: <linux-kernel+bounces-72215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE2485B0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE1D1C234CA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3E545944;
	Tue, 20 Feb 2024 02:26:57 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB7A44C76
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708396017; cv=none; b=hsLxjduHV9uhJ4NNQ8n5n1B6B6BUtMK5o4Oi4jTJ55U0y2/j0ulrIhlHQseVsnK2lPbTWG7Zs78HRUElzpwMVYImwJ0y+6EgSjEetlSxFDv95ahxGyHcjiIOfKhGy/dSm1MJ392wBRh+KBELRBzZ5+2RYaPkOYvwJAXYGsgS17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708396017; c=relaxed/simple;
	bh=8T3tY7oj4cWPmMLru07PWyLzhA0TZeU9DdNfBVxiI2k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=S/uwLys+j2utgrABEf+oOKA+xs3E5PHbyFE7LnBtTnpkDRg+4UMCxrSskDYZiy03TiCTYiPdLmFq3W/RfXxcV2mfzC6jJJ/2pIyLO+jCcNlkHBywbTH1fiTlD131nqNaWTgng+4HrSyq0tsycBvvgFMDoiSCv/hTgxsDdJ+lzoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tf3C11Y4Qz1h08w;
	Tue, 20 Feb 2024 10:24:45 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id AAC471402DE;
	Tue, 20 Feb 2024 10:26:52 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 10:26:51 +0800
Subject: Re: next-20240219: arm64: boot failed - gic_of_init
To: Marc Zyngier <maz@kernel.org>
CC: Naresh Kamboju <naresh.kamboju@linaro.org>, open list
	<linux-kernel@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, <lkft-triage@lists.linaro.org>, Linux
 Regressions <regressions@lists.linux.dev>, Catalin Marinas
	<catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter
	<dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYugYiLd7MDn3wCxK+x5Td9WO-VUX2OvOtTN7D1d4GHCfg@mail.gmail.com>
 <86edd84wer.wl-maz@kernel.org> <86cyss4rl7.wl-maz@kernel.org>
 <a7d8e529-9a44-3f88-50ef-d87b80515c36@huawei.com>
 <86a5nw4gp3.wl-maz@kernel.org>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f3bd274b-2644-ce5c-315d-36a492814d13@huawei.com>
Date: Tue, 20 Feb 2024 10:26:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <86a5nw4gp3.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/2/19 23:27, Marc Zyngier wrote:
> On Mon, 19 Feb 2024 14:46:46 +0000,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>
>> On 2024/2/19 19:32, Marc Zyngier wrote:
>>> For what it is worth, I've just tested both defconfig and my own
>>> configuration with both 4k (kvmtool, QEMU+KVM and on SynQuacer) and
>>> 16k (kvmtool), without any obvious problem.
>>
>> I had a quick test on top of next-20240219 with defconfig.  I can
>> reproduce it with QEMU parameter '-cpu max -accel tcg', but things are
>> fine with '-cpu max,lpa2=off -accel tcg'.
>>
>> Bisection shows that the problem happens when we start putting the
>> latest arm64 and kvmarm changes together.  The following hack fixes the
>> problem for me (but I **only** write it for kernel built with defconfig
>> with ARM64_4K_PAGES=y atm).
>>
>> I can investigate it further tomorrow (as it's too late now ;-) ).  Or
>> maybe Marc or Catalin can help fix it with a proper approach.
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 4f7662008ede..babdc3f4721b 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2798,6 +2798,7 @@ static const struct arm64_cpu_capabilities
>> arm64_features[] = {
>> | 		.sign = FTR_SIGNED,
>> | 		.field_pos = ID_AA64MMFR0_EL1_TGRAN4_SHIFT,
>> | 		.min_field_value = ID_AA64MMFR0_EL1_TGRAN4_52_BIT,
>> |+		.max_field_value = BIT(ID_AA64MMFR0_EL1_TGRAN4_WIDTH - 1) - 1,
>> | #else
>> | 		.sign = FTR_UNSIGNED,
>> | 		.field_pos = ID_AA64MMFR0_EL1_TGRAN16_SHIFT,
> 
> I've posted my take on this at [1], which hopefully matches what you
> were aiming at.
> 
> [1] https://lore.kernel.org/all/86bk8c4gyh.wl-maz@kernel.org/

Yup, this looks good to me.

Thanks,
Zenghui

