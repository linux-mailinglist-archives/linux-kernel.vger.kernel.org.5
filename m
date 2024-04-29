Return-Path: <linux-kernel+bounces-163031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA128B63EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599D72817EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23CD1779BA;
	Mon, 29 Apr 2024 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FgPeL5ij"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4351E886
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424284; cv=none; b=Uga6ZraNEK5T8iS7TfEsXu+ECkrjwk3eZBSaVM+V3Piw8qYrimvRZi5RJb8kl46xVwsBAPZ1f4qGsvY3kZMF+SBw/2dmU9yXebI1zjRAm/X/z2/9K1EqXWnmu780IF9EfX55aRi5iYeucgocVX+SyeRvICc3DnQNHoCF7qfMSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424284; c=relaxed/simple;
	bh=tjeqQnAXPyfqb7X+qDbwtLwPhxxPfjqtjepkuaMtIEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ml60GhhP9mUwPobNHQ1Q5h31cYvpgzFLIti5Am/KC7Dt9/khoxSwdTaADzTIgiYwjEv1j8Z5+58o/9mMOD0TVJaqtF43PZE5id4/zWBEizvGx4Nx3G+4PSJrdA3O5G+IdYViW5y1PjwjyJwyI3qoVqoEADT9r8kfTl/9QYjf5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=FgPeL5ij; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43TKv5LH516495
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 29 Apr 2024 13:57:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43TKv5LH516495
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1714424230;
	bh=+GhsHmhMrDsQ4/RBIiXOwPhKdp8OKG2238MUvuiPqWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FgPeL5ijy81JJqTxJp+Bc979wLqwA/aGvbUsdh8DvYshRZuTP0r0loPhnh9v3wmHZ
	 81E45gF1MxAf6MB0OTe9RBJxYznvlmY2scPvh9IWA7sLsQHdqB2HATLrl+Zwq0sjvv
	 /+WQ3E5hizJiQ0OqD43R+yQ9u3+p8nO0/6N5fuoj0gWt33kjJUrwZmMP7r0RGYjH19
	 aymurNzUbVljOuU9Sy46IXipeaBqKFTgcH5mlAzzbIZrZ/9OBiLMzNaZyju1PcNGgs
	 nkmVTz/jQGDP9fpWV34+BYsfOPqGe66s86x/K09MdSFQq5VI49/dx33nLcUOEDq1VS
	 /nlun+C2CnzaA==
Message-ID: <9f4927cb-e8c1-4b97-b9b6-145172b469e0@zytor.com>
Date: Mon, 29 Apr 2024 13:57:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86: dynamic pt_regs pointer and kernel stack randomization
To: Kees Cook <keescook@chromium.org>
Cc: Xin Li <xin@zytor.com>, Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
References: <a793c733-267d-4930-8ee2-0fc0f24c3538@zytor.com>
 <202404290859.99763AA1@keescook>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <202404290859.99763AA1@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 09:09, Kees Cook wrote:
> 
> If I'm understanding FRED correctly, I think this exit path
> would need to call choose_random_kstack_offset() as well. (For
> syscalls, add_random_kstack_offset() is used on entry and
> choose_random_kstack_offset() is used on exit, so I think we'd want the
> same pattern for interrupt handling.)
> 

Yes, I didn't include it in here because it doesn't affect the assembly 
flow per se, since it "simply" sets up the parameters for the next entry 
and so at least logically can be executed more or less anywhere.

> Yeah, I'd like greater coverage for ring 3->0 transitions. We do want to
> double-check the original design choices, though. I *think* they still
> stand (see the comments for choose_random_kstack_offset() about entropy
> location (per-cpu area), and lifetime (across userspace execution).

Yeah, I'm not super sure of what exactly the constraints really are; 
they are written in a way that signals to me that there is implied 
context that isn't clear to me, especially the bit about "long running 
syscalls".

	-hpa

