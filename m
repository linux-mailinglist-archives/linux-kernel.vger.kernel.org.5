Return-Path: <linux-kernel+bounces-64062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91BB85398E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754781F247C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B9D605B8;
	Tue, 13 Feb 2024 18:11:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA902605A3;
	Tue, 13 Feb 2024 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847900; cv=none; b=YSxpnF810XXi3320J2qRdyiv7lgY/TZ2d9eyQP+seGJwIoy4rUBQO7FQyMVt0wcwVT1QVFzt8m3hK7u7KKN2Yg7xypXRzq+scLSe92cSa8KBCzODKmkBtHirIo4qwY/FHNWYUnhT6+djtXQO6nDfiPgkycYaQ/wBdeJZFxKPM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847900; c=relaxed/simple;
	bh=gkS582LnEt5AZDBlyZUbpbZ4EnHP61TwjQ5pjt1x8Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqDDOlN4eAT5qrmzeKPHSNiAK2NeQzHJ6EvyTpPBIyC6S4JFd6PfeMHeXdkxZuATys5vafvX0WkzF7IHsf1DQeLUzWqcKmOKeLFT8c6a1raJpXuIP5qI39+y9yCcbrTwKxGzERnFiFM3mIqDUIQ09RZxG3zkIFiJfEu75nEMiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57831FB;
	Tue, 13 Feb 2024 10:12:19 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8B393F766;
	Tue, 13 Feb 2024 10:11:30 -0800 (PST)
Message-ID: <a36b14b0-84d0-f815-b8c9-d10841f8b5d0@arm.com>
Date: Tue, 13 Feb 2024 18:11:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Content-Language: en-GB
To: Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: "babu.moger@amd.com" <babu.moger@amd.com>,
 "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "x86@kernel.org" <x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>,
 Drew Fustini <dfustini@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <642f81da-669b-4057-8b97-2894dd57842b@intel.com>
 <SJ1PR11MB6083036DC25D4FA55B02589AFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <16a63923-2fd2-4d44-a8a3-32d8d6eeee9e@intel.com>
 <ZcqWFr8fX9G0hoJU@agluck-desk3>
From: James Morse <james.morse@arm.com>
In-Reply-To: <ZcqWFr8fX9G0hoJU@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 12/02/2024 22:05, Tony Luck wrote:
> On Mon, Feb 12, 2024 at 01:43:56PM -0800, Reinette Chatre wrote:
>> On 2/12/2024 11:57 AM, Luck, Tony wrote:
>>>>> To be honest, I like this series more than the previous series. I always
>>>>> thought RDT_RESOURCE_L3_MON should have been a separate resource by itself.
>>>>
>>>> Would you prefer that your "Reviewed-by" tag be removed from the
>>>> previous series?
>>>
>>> I'm thinking that I could continue splitting things and break "struct rdt_resource" into
>>> separate "ctrl" and "mon" structures. Then we'd have a clean split from top to bottom.
>>
>> It is not obvious what you mean with "continue splitting things". Are you
>> speaking about "continue splitting from v14" or "continue splitting from v15-RFC"?
> 
> I'm speaking of some future potential changes. Not proposing to
> do this now.
> 
>> I think that any solution needs to consider what makes sense for resctrl
>> as a whole instead of how to support SNC with smallest patch possible.

>> There should not be any changes that makes resctrl harder to understand
>> and maintain, as exemplified by confusion introduced by a simple thing as
>> resource name choice [1].
>>
>>>
>>> Doing that would get rid of the rdt_resources_all[] array. Replacing with individual
>>> rdt_hw_ctrl_resource and rdt_hw_mon_resource declarations for each feature.
>>>
>>> Features found on a system would be added to a list of ctrl or list of mon resources.
>>
>> Could you please elaborate what is architecturally wrong with v14 and how this
>> new proposal addresses that?
> 
> There is nothing architecturally wrong with v14. I thought it was more
> complex than it needed to be. You have convinced me that my v15-RFC
> series, while simpler, is not a reasonable path for long-term resctrl
> maintainability.

I'm not sure if its helpful to describe a third approach at this point - but on the off
chance its useful:
With SNC enable, the L3 monitors are unaffected, but the controls behave as if they were
part of some other component in the system..

ACPI describes something called "memory side caches" [0] in the HMAT table, which are
outside the CPU cache hierarchy, and are associated with a Proximity-Domain. I've heard
that one of Arm's partners has built a system with MPAM controls on something like this.
How would we support this - and would this be a better fit for the way SNC behaves?

I think this would be a new resource and schema, 'MSC'(?) with domain-ids using the NUMA
nid. As these aren't CPU caches, they wouldn't appear in the same part of the sysfs
hierarchy, and wouldn't necessarily have a cache-id.

For SNC systems, I think this would look like CMT on the L3, and CAT on the 'MSC'.
Existing software wouldn't know to use the new schema, but equally wouldn't be surprised
by the domain-ids being something other than the cache-id, and the controls and monitors
not lining up.
Where its not quite right for SNC is sysfs may not describe a memory side cache, but one
would be present in resctrl. I don't think that's a problem - unless these systems do also
have a memory-side-cache that behaves differently. (where is the controls being applied at
the 'near' side of the link - I don't think the difference matters)


I'm a little nervous that the SNC support looks strange if we ever add support for
something like the above. Given its described in ACPI, I assume there are plenty of
machines out there that look like this.

(Why aren't memory-side-caches a CPU cache? They live near the memory controller and cache
based on the PA, not the CPU that issued the transaction)


Thanks,

James

[0]
https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#memory-side-cache-overview

