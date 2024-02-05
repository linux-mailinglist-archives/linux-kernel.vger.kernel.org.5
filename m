Return-Path: <linux-kernel+bounces-52609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343E849A66
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20AD0B21A3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E721CAA2;
	Mon,  5 Feb 2024 12:34:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C4A1CA80;
	Mon,  5 Feb 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136474; cv=none; b=oy3Ku0ku9TABqkMMzRC6sjaydCASLdSNHNe7vFesS4W38HvupztkL4u4UjXhu6c3zOJU3fVn24uX4ARUcBGVVZaLU0IkYQyxifIKG2WfuNDAI+AIqoinDkqnNXUHw3+sWaohMDIlhBuHnziCQBGVmGrMBLVXTO62pfzXRrcozuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136474; c=relaxed/simple;
	bh=kceg1RKuaGLopnR5e28ESsP0l2T+8rKChglAS/2r7yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tONIwmqCz18i+0MQEjQQgxry8IiYoHSHY0YCR9Mkg+n54fnlUaXQB6Us1rADSrvDwXQNjiY7y1HUiztaWGPFEsVdnvDkI1SFxZlgFJx+5KgYy/lIaNGRglqCRPmS6vgI+EEEDI2H0HiGN/dXPVu2uMuhJPPkoJMduyfR8vAb4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC8431FB;
	Mon,  5 Feb 2024 04:35:13 -0800 (PST)
Received: from [10.57.48.140] (unknown [10.57.48.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61F623F762;
	Mon,  5 Feb 2024 04:34:30 -0800 (PST)
Message-ID: <51315925-21ac-427c-abea-4d652ed5280f@arm.com>
Date: Mon, 5 Feb 2024 12:34:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu/ipmmu-vmsa: Use devm_platform_get_and_ioremap_resource() in
 ipmmu_probe()
Content-Language: en-GB
To: Markus Elfring <Markus.Elfring@web.de>, iommu@lists.linux.dev,
 kernel-janitors@vger.kernel.org, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <e01cdb99-8497-4fec-b423-a0bfb483ac75@web.de>
 <324d4e02-6a5a-4112-a3a7-d7aeb5876acc@arm.com>
 <49fc6a59-2c07-4366-b32f-0599c2418916@web.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <49fc6a59-2c07-4366-b32f-0599c2418916@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-05 11:52 am, Markus Elfring wrote:
>>> Thus reuse existing functionality instead of keeping duplicate source code.
>>
>> Much as I detest the get_and_ioremap_resource obfuscator, it's not even appropriate here since nothing else is using "res".
> 
> I got the impression that this local variable is needed to perform
> a desired function call.

Yes, the call to devm_ioremap_resource(). Which you're proposing to 
remove...

Thanks,
Robin.

