Return-Path: <linux-kernel+bounces-33892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DCF836FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A13128E64E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEEF5C8F8;
	Mon, 22 Jan 2024 18:05:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFC33FB17
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946729; cv=none; b=tqbuP0h/RFOmrytamQorIunNJn4IO1nvugIyLrUMkk1MyXqwzMtvZ2gdyMLWTJJTikQBkctLLyqfETtnP+9+/Cw+sctBhyxmCL3BKsSK7dAQ/WU+WJVIToUqUWdAzmrAwv+sq+KEhY0VYmf+wIytwYpcOQwfJ3wSdylOSpq/tKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946729; c=relaxed/simple;
	bh=9fAumUvQOX0X6U44eg2upuztW2cUAYClbtHKjipRQUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ad7TYk8SduKW4GuWp9AQ6U6bhynEdkTNfgWNdad0MOESfyRUULA+S47LWBnO0Tz5QsB/ZZXnmJU22WDbjZ9jYqLrYBeNE9vkAOlKjBasdxbp4Lm5NA6eJT1be+YPb59w2XggAAkyJgDU3un6IZ2VRp6njPLWOMB1COtLPzMHX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F7101FB;
	Mon, 22 Jan 2024 10:06:11 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D4BE3F5A1;
	Mon, 22 Jan 2024 10:05:22 -0800 (PST)
Message-ID: <583e6c89-98c5-5415-0091-8b1758d8f785@arm.com>
Date: Mon, 22 Jan 2024 18:05:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 01/24] tick/nohz: Move tick_nohz_full_mask declaration
 outside the #ifdef
Content-Language: en-GB
To: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 Frederic Weisbecker <frederic@kernel.org>
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-2-james.morse@arm.com> <874jgjmclt.ffs@tglx>
From: James Morse <james.morse@arm.com>
In-Reply-To: <874jgjmclt.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas,

On 15/12/2023 20:31, Thomas Gleixner wrote:
> On Fri, Dec 15 2023 at 17:43, James Morse wrote:
>> tick_nohz_full_mask lists the CPUs that are nohz_full. This is only
>> needed when CONFIG_NO_HZ_FULL is defined. tick_nohz_full_cpu() allows
>> a specific CPU to be tested against the mask, and evaluates to false
>> when CONFIG_NO_HZ_FULL is not defined.
>>
>> The resctrl code needs to pick a CPU to run some work on, a new helper
>> prefers housekeeping CPUs by examining the tick_nohz_full_mask. Hiding
>> the declaration behind #ifdef CONFIG_NO_HZ_FULL forces all the users to
>> be behind an ifdef too.
>>
>> Move the tick_nohz_full_mask declaration, this lets callers drop the
>> ifdef, and guard access to tick_nohz_full_mask with IS_ENABLED() or
>> something like tick_nohz_full_cpu().
>>
>> The definition does not need to be moved as any callers should be
>> removed at compile time unless CONFIG_NO_HZ_FULL is defined.


> I can pick that up separately, but I'm fine when it goes with the
> resctrl lot. For that case:

> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>


Thanks!

James

