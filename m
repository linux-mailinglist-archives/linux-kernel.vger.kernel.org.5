Return-Path: <linux-kernel+bounces-152690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0048A8AC2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821F71F2107D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A299D52E;
	Mon, 22 Apr 2024 03:08:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69572468E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713755330; cv=none; b=lIEruTx54JFZDcCYZ5rp73wMuliYhrQP5tjyjx8xq2qibSgYXeSsBzGbUMZNeYLzHTf2f0BxKGBB+f63nXFsxE9Ek+D/PiI4Wk+3WzwhB1Lo9/K6RxvpaYxZrnjkJuibO2YewmWtt4ZP/HsXDtkJQMBe+o0OkyX1n6ovkwKH5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713755330; c=relaxed/simple;
	bh=lYhcy53ZK5gVs71lleOA1BOzhfoUm2WD+UbID3DZsq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODM++qMZaCZrSdfg8OLjN5WkLd5uFLvkaSjJdWmT15e0S1/qjHNoMt/1RSjAES1RgZKdqP2hCswl4cD7xi1ZFrmZkTSRGonRpgx0MjrHeOcuQlbeyrt9gDVJDVztFnGMnuVbGX/+nsWu/NhA9MNhvkoM+2LtcdBLW9PW4J4wOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DA74339;
	Sun, 21 Apr 2024 20:09:09 -0700 (PDT)
Received: from [10.163.32.192] (unknown [10.163.32.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BABB3F7BD;
	Sun, 21 Apr 2024 20:08:38 -0700 (PDT)
Message-ID: <49365864-0080-4ddd-b0cb-eef41c88b6a9@arm.com>
Date: Mon, 22 Apr 2024 08:38:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/sysreg: Update ID_AA64MMFR2_EL1 register
Content-Language: en-US
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20240419021325.2880384-1-anshuman.khandual@arm.com>
 <20240419134623.GE3148@willie-the-truck>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240419134623.GE3148@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/19/24 19:16, Will Deacon wrote:
> On Fri, Apr 19, 2024 at 07:43:25AM +0530, Anshuman Khandual wrote:
>> This updates ID_AA64MMFR2_EL1.VARange register fields as per the definition
>> based on DDI0601 2024-03.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.9-rc4
>>
>>  arch/arm64/tools/sysreg | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index a4c1dd4741a4..6d7213dcbeb5 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -1739,6 +1739,7 @@ EndEnum
>>  UnsignedEnum	19:16	VARange
>>  	0b0000	48
>>  	0b0001	52
>> +	0b0010	56
> 
> Is anybody using this? I'm not sure there's a lot of value in adding
> these fields one-by-one for the sake of completeness.

This is not being used currently but will be required for upcoming
features. I was under the impression that register fields (atleast
for the ID registers) should be kept updated, with latest released
spec ? Besides lately arch/arm64/tools/sysreg serves as very good
reference for all necessary register fields.

https://developer.arm.com/documentation/ddi0601/2024-03/AArch64-Registers/ID-AA64MMFR2-EL1--AArch64-Memory-Model-Feature-Register-2

