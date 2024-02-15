Return-Path: <linux-kernel+bounces-67790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 940768570C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5001F2277F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02AA14534A;
	Thu, 15 Feb 2024 22:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pmAz6Pz7"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67213B2BF;
	Thu, 15 Feb 2024 22:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037619; cv=none; b=gK0zHn9YaZTmuPy7RQ5cLU051IGlFUc3c7mNsetlxzyaULXP2VvtCfnCBtDaYn2c6/XhxuVfbDPrljZ7aDqhfT6EZp3aLpH18yBhoTz7nIlHxM9E2t3ewQDxpMfv2xEacPKD6ifjFJXl67oL5qkRz5BreMUBxL7WCrGU4F170SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037619; c=relaxed/simple;
	bh=rUWuyqvYLXDrlUVnh5hZsDQvx7f4dgjjbHfhFcrcDdE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZBuvY/R/RbUBE3ZOtbGrxFLMgB1aiwkiece18xOndttr+pfKXtI2BE/bY4ofs3nLXhqHY8JirJc4ZMveJQ+4noUK3aPqxTjhokEvQRJzExuFjyDQND8BRcggwVzwsEzn37jNHNKolRskAY7Nf5pVp+mb1+xt/XB78wULPvEVxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pmAz6Pz7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.201.39] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id C773020B2000;
	Thu, 15 Feb 2024 14:53:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C773020B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708037617;
	bh=CiJoh5nLY9w4ZLUhjoAD3yt82tHarGa4oEGpH+oxCsw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=pmAz6Pz7oV3RhM3USNZQ0wb8AA62St+0eW+k3/jxNYTU1MCMDqmOa/BW7BjQyyqQ6
	 4mWlylw5SlV3mGkk4ZPGx3pQ6gEhp4dcMfoFBMMEsP0J3jlYtMu6ORVw3EHK52kFWJ
	 Gm/s6nKNiwerC7Qvsu4XUFEMxAS21wKxGkl1Yknw=
Message-ID: <b99a7196-011e-4f08-83ec-e63a690ab919@linux.microsoft.com>
Date: Thu, 15 Feb 2024 14:53:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM
 Neoverse N2 errata
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, stable@vger.kernel.org
References: <20240212232909.2276378-1-eahariha@linux.microsoft.com>
 <ZcqtUxhqUbYoRH-G@linux.dev>
 <18b3ac3e-2bfc-4fce-9be4-3e75e487f9fc@linux.microsoft.com>
In-Reply-To: <18b3ac3e-2bfc-4fce-9be4-3e75e487f9fc@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/2024 4:19 PM, Easwar Hariharan wrote:
> On 2/12/2024 3:44 PM, Oliver Upton wrote:
>> Hi Easwar,
>>
>> On Mon, Feb 12, 2024 at 11:29:06PM +0000, Easwar Hariharan wrote:
>>> Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
>>> implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
>>> suffers from all the same errata.
>>
>> Can you comment at all on where one might find this MIDR? That is, does
>> your hypervisor report the native MIDR of the implementation or does it
>> repaint it as an Arm Neoverse N2 (0x410FD490)?
> 
> We will check on the Microsoft hypervisor's plans, and get back to you.
> 
> Notwithstanding that, we do have baremetal use cases for Microsoft Azure Cobalt 100
> as well where this MIDR value will show through.
> 

<snip>

We checked in with our Microsoft hypervisor colleagues, and they do repaint the
Azure Cobalt 100 as an Arm Neoverse N2, but again, we do have baremetal use cases. 

Thanks,
Easwar


