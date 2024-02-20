Return-Path: <linux-kernel+bounces-73494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4A85C37C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69B41F221A2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFEF78B50;
	Tue, 20 Feb 2024 18:14:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E55D762EC;
	Tue, 20 Feb 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452895; cv=none; b=jKFTn5ghAY2Dk3O0FhhXEQ3O5yke+nTaddQDm8VqKyH/x5tWGEzBwiRjAG/Vgw6ysOezaMgRkEHXu8PdoTI7Wzl7Hy/Lh8QRArDkgiVYyXpfSAk4y8x5vH+entjwc7xfS7qLTwXfP9z7Q2Zvd4CvEBZBvIw89jrkCoyJ9UVASjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452895; c=relaxed/simple;
	bh=/ynjGAeQqEvhZ93KruTyPeOVmjFP4hfFO8nd6g84A9U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KUzqUk5p/1OFxDAu374iyyRWUSBfJ5jwzTaNqvjaGWxb3q/fRyd2TGbS4162fqjzmIan2f4mScjWCWHE2GCYFgfYA4humMY8Ttdyji7rFiZKVF2tkVLDEk2fzroAu1G0GcvxrPIhLtzAyrYyGOpgR+4881Ccoq/67D5+9dMJZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B9481007;
	Tue, 20 Feb 2024 10:15:32 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50C2F3F7F4;
	Tue, 20 Feb 2024 10:14:44 -0800 (PST)
Message-ID: <0ca1f2aa-913e-4b8e-bd63-dcfbb9af149b@arm.com>
Date: Tue, 20 Feb 2024 18:14:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
To: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
 <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
In-Reply-To: <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 20/02/2024 15:21, James Morse wrote:
> There ought to be some indication to user-space of how many counters it can assign, this
> number might be different for different resources. This won't be a problem today, but if
> we had 'mbm_total_bytes' on the L2 cache, the number of counters may be different.

I found this in patch 6 - sorry for the noise!


Thanks,

James

