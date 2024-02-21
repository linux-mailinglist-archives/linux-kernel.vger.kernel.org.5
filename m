Return-Path: <linux-kernel+bounces-74502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EF685D534
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A985B21C7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D483D96A;
	Wed, 21 Feb 2024 10:10:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2963C3D39A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510228; cv=none; b=nR+1kcTlDxm/mv7U2opiJriPNb9yZtfEmr72mGmkn6CAJK8bPH+gIqrj6/rC/+v4+I9fwMtsZJs/uD1CT7alCm1FjobI+Dqyq9Ne+Dc6WbIeGESvHblUYdXmyb2J4ym2PYa23kVg6wZIY8VXgN+68iqXsYnYa3EYbYDQwbKrGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510228; c=relaxed/simple;
	bh=P2sW9Nlam8hlinuFy+ouLIoPd0TtBGZuqKmjtrhoOVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfm3NP5BN/BLrrfOPvYcNCOOMlUA7R/IkdVky318rILj9xnKk5BVi9Yaiv+wgm/da9tKpwlQwLlMSBegMZDX1/6tSEcmIROdLXeGAnqxyfKe4+29JH1JMOFVtT0beUrQim2WWKu2zx3QfDEkovfAor35As0CzF+KEdg2+w+CYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1DFCDA7;
	Wed, 21 Feb 2024 02:11:03 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 200613F73F;
	Wed, 21 Feb 2024 02:10:20 -0800 (PST)
Message-ID: <c1e159b7-c884-e498-6b01-64a897117036@arm.com>
Date: Wed, 21 Feb 2024 10:10:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/7] arm64/sysreg/tools: Move TRFCR definitions to
 sysreg
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, maz@kernel.org, suzuki.poulose@arm.com,
 acme@kernel.org, oliver.upton@linux.dev, James Morse <james.morse@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
 Kalesh Singh <kaleshsingh@google.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Fuad Tabba <tabba@google.com>,
 Jing Zhang <jingzhangos@google.com>, linux-kernel@vger.kernel.org
References: <20240220100924.2761706-1-james.clark@arm.com>
 <20240220100924.2761706-4-james.clark@arm.com>
 <18995343-e43e-4e92-a97d-3df74ec6ddb7@sirena.org.uk>
From: James Clark <james.clark@arm.com>
In-Reply-To: <18995343-e43e-4e92-a97d-3df74ec6ddb7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/02/2024 16:11, Mark Brown wrote:
> On Tue, Feb 20, 2024 at 10:09:13AM +0000, James Clark wrote:
>> Add separate definitions for ELx and EL2 as TRFCR_EL1 doesn't have CX.
>> This also mirrors the previous definition so no code change is required.
> 
> This is also converting to automatic generation in the process.
> 
>> +SysregFields TRFCR_EL2
>> +Res0	63:7
>> +UnsignedEnum	6:5	TS
>> +	0b0000	USE_TRFCR_EL1_TS
>> +	0b0001	VIRTUAL
>> +	0b0010	GUEST_PHYSICAL
>> +	0b0011	PHYSICAL
>> +EndEnum
>> +Res0	4
>> +Field	3	CX
>> +Res0	2
>> +Field	1	E2TRE
>> +Field	0	E0HTRE
>> +EndSysregFields
> 
> This has exactly one user and I'd not expect more so why have a separate
> SysregFields?
> 

No reason, probably just a copy paste thing. I'll change it to a Sysreg.

>> +# TRFCR_EL1 doesn't have the CX bit so redefine it without CX instead of
>> +# using a shared definition between TRFCR_EL2 and TRFCR_EL1
> 
> This comment is reflecting the default state?
> 

True, will remove.

>> +Sysreg	TRFCR_EL1	3	0	1	2	1
>> +Fields	TRFCR_ELx
>> +EndSysreg
>> +
>> +Sysreg	TRFCR_EL2	3	4	1	2	1
>> +Fields	TRFCR_EL2
>> +EndSysreg
>> +
>> +Sysreg	TRFCR_EL12	3	5	1	2	1
>> +Fields	TRFCR_ELx
>> +EndSysreg
> 
> These are generally sorted by encoding (simiarly to how sysreg.h was
> sorted historically).

Ah I didn't know that. Can I add a comment to the top of the file saying
that it should be kept sorted?

