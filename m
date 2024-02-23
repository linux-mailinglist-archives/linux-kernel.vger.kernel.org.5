Return-Path: <linux-kernel+bounces-77787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4CD860A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E622B25749
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE32125D9;
	Fri, 23 Feb 2024 05:28:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC97A11CBC;
	Fri, 23 Feb 2024 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666107; cv=none; b=M/OvewAtzz2Ug+jSc1z3wzEug5c1wMgdwN9ghpcg13CNzNCH4g/+GAZK5Mmjxi/kFdPrKv98s+lSeEFV6rZtNW7JdTrLhlSaC49oTB+BQwHdOFPgq90ZDiPG5PCL2LVmSY0PoOWompXxX3bWLixcmuHh4p3+/eK07dfIe3nGxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666107; c=relaxed/simple;
	bh=BxFIY73UwVqcn1XxxMS8/BIuaTqDQWKPcpVpw9L/lYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhcA+UbJs2UmUimFpcOoFyYIDWr7qS/uzC33WoMBmWDGLROgi6S4j71zNWDu0b2N6jJLtZwjeAWuO5R6EZBMmzX5FaftL/+dxlvEpax8L26yb18ILl1kOu+5b1hJz9WvYhvfW8kInXvPspphVaoc1QpN3AHrhE1kYmdzQtGL8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A7CE15DB;
	Thu, 22 Feb 2024 21:28:57 -0800 (PST)
Received: from [10.163.46.223] (unknown [10.163.46.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 290E43F766;
	Thu, 22 Feb 2024 21:28:13 -0800 (PST)
Message-ID: <b2dfcaf1-f466-4e81-8ca4-02bf3fa837e5@arm.com>
Date: Fri, 23 Feb 2024 10:58:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 1/8] arm64/sysreg: Add BRBE registers and fields
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
 Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
 <20240125094119.2542332-2-anshuman.khandual@arm.com>
 <ZdYAJvZf4Ut5f5Rf@FVFF77S0Q05N>
 <e89ecbde-0967-4b8e-af77-3a72f207f3d7@sirena.org.uk>
 <ZdYDJPe1n5-V-AnT@FVFF77S0Q05N>
 <7fe52cb9-12b9-4b03-8e55-08e59b4bef27@sirena.org.uk>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <7fe52cb9-12b9-4b03-8e55-08e59b4bef27@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/21/24 19:37, Mark Brown wrote:
> On Wed, Feb 21, 2024 at 02:05:24PM +0000, Mark Rutland wrote:
>> On Wed, Feb 21, 2024 at 01:59:03PM +0000, Mark Brown wrote:
>>> On Wed, Feb 21, 2024 at 01:52:38PM +0000, Mark Rutland wrote:
> 
>>> It's a good point about the sorting, though the file is currently mostly
>>> sorted by encoding rather than alphanumerically (similarly to how
>>> sysreg.h was done).
> 
>> Sure, we're inconsistent. I'd just prefer that there's *some* local ordering
>> here, as the patch is neither ordered as above nor by encoding:
> 
> I agree, I'm just saying that if we're going to fix the ordering it'd
> probably be better to go along with what the rest of the file is doing.

Sure, will change the registers order as has been suggested earlier i.e
alphanumerically instead. Because ordering registers with encoding will
push BRBCR_EL2/12 after all other BRBE registers, including BRBIDR0_EL1.

After the change

BRBCR_EL1
BRBCR_EL12
BRBCR_EL2

