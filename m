Return-Path: <linux-kernel+bounces-106919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E35687F569
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CE91F21D53
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5B64CFF;
	Tue, 19 Mar 2024 02:26:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DA964CE9;
	Tue, 19 Mar 2024 02:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710815179; cv=none; b=mAmqoI+0cJouvy00IxFIgoghU3YbqqVxehAUjuMXHUIGR8tF0zUN6zYvKKsckdrmItztncZXEzT/fuHPW6FPGtJSHe3Kb+4rjxTT2ZMQo/v2vk3yBZXTu/6ZTg/Jd3JUXKkI9vqTy3EM7liIunFzqVrklSsvyMmtJSv5PP6J87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710815179; c=relaxed/simple;
	bh=KQzfakRcrbHa4iQaTVLI/sbWCXQ1mlHncl75EffgA64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WY2QzQwbXtVIO/MFMBmnnROGoFkDdFNLqJbQyxRG0tgAeLtRpFNocG+050E1inAh64banbty4xnp1rG0vo3py9zLpCYXq99iPqyACp+h3eP1i6hptskos2hPDVb/F4y0J3aNy7CyGSFPUhoRFQ+L8AeRUH+n+HgCmpfNqFIXwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72621106F;
	Mon, 18 Mar 2024 19:26:49 -0700 (PDT)
Received: from [10.163.53.80] (unknown [10.163.53.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB44B3F762;
	Mon, 18 Mar 2024 19:26:12 -0700 (PDT)
Message-ID: <ad9bdae3-0eb2-4262-8412-ba42c27ee767@arm.com>
Date: Tue, 19 Mar 2024 07:56:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf tools: Only treat files as map files when they
 have the extension .map
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
 anshuman.khandual@arm.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com>
 <20240220042957.2022391-3-ChaitanyaS.Prakash@arm.com>
 <CAP-5=fUFmeoTjLuZTgcaV23iGQU1AdddG+7Rw=d6buMU007+1Q@mail.gmail.com>
 <ZdYPf3wMl35VemsL@x1> <0fa391c6-fd9e-42fe-b535-17e7725280e5@arm.com>
 <ZfSw7AL8EgFoFQkM@x1>
Content-Language: en-US
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
In-Reply-To: <ZfSw7AL8EgFoFQkM@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/16/24 02:04, Arnaldo Carvalho de Melo wrote:
> On Fri, Feb 23, 2024 at 05:40:02PM +0530, Chaitanya S Prakash wrote:
>> I'll make the changes, thanks for the review.
> Have you submitted a new series?
>
> Thanks,
>
> - Arnaldo
I will be posting it this week, extremely sorry for the delay!
>   
>> On 2/21/24 20:28, Arnaldo Carvalho de Melo wrote:
>>> On Tue, Feb 20, 2024 at 06:40:47AM -0800, Ian Rogers wrote:
>>>> On Mon, Feb 19, 2024 at 8:30 PM Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:
>>>>> +++ b/tools/perf/util/string2.h
>>>>> @@ -40,5 +40,6 @@ char *strdup_esc(const char *str);
>>>>>
>>>>>    unsigned int hex(char c);
>>>>>    char *strreplace_chars(char needle, const char *haystack, const char *replace);
>>>>> +const char *ends_with(const char *str, const char *suffix);
>>>> nit: string2.h is an extension of linux's string.h. The tools copy of
>>>> that is missing functions in the kernel version:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/include/linux/string.h?h=perf-tools-next
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/include/linux/string.h?h=perf-tools-next#n398
>>>> specifically str_has_prefix.
>>>>
>>>> The naming ends_with makes sense but there is also strstarts and
>>>> str_has_prefix, perhaps str_has_suffix would be the most consistent
>>>> and intention revealing name?
>>>>
>>>> Also, we have strtailcmp which behaves like a reverse strcmp that
>>>> doesn't compare the lengths of the strings. It seems all uses of
>>>> strtailcmp are just for a "str_has_suffix". It would make sense to me
>>>> to remove that function and switch to a common str_has_suffix function
>>>> which I think is a more intention revealing way of naming what the
>>>> code is doing.
>>> So far in perf we try to just reuse whatever function the kernel has for
>>> the purpose at hand, right now the kernel has:
>>>
>>> /**
>>>    * strstarts - does @str start with @prefix?
>>>    * @str: string to examine
>>>    * @prefix: prefix to look for.
>>>    */
>>> static inline bool strstarts(const char *str, const char *prefix)
>>> {
>>>           return strncmp(str, prefix, strlen(prefix)) == 0;
>>> }
>>>
>>> And:
>>>
>>> /**
>>>    * str_has_prefix - Test if a string has a given prefix
>>>    * @str: The string to test
>>>    * @prefix: The string to see if @str starts with
>>>    *
>>>    * A common way to test a prefix of a string is to do:
>>>    *  strncmp(str, prefix, sizeof(prefix) - 1)
>>>    *
>>>    * But this can lead to bugs due to typos, or if prefix is a pointer
>>>    * and not a constant. Instead use str_has_prefix().
>>>    *
>>>    * Returns:
>>>    * * strlen(@prefix) if @str starts with @prefix
>>>    * * 0 if @str does not start with @prefix
>>>    */
>>> static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
>>> {
>>>           size_t len = strlen(prefix);
>>>           return strncmp(str, prefix, len) == 0 ? len : 0;
>>> }
>>>
>>> The later seems to give more bang for the buck, so to say, returning the
>>> prefix lenght.
>>>
>>> It is a new addition:
>>>
>>> 72921427d46bf9731 (Steven Rostedt (VMware) 2018-12-21 18:10:14 -0500 398) static __always_inline size_t str_has_prefix(const char *str, const char *prefix)
>>>
>>> While:
>>>
>>> 66f92cf9d415e96a5 (Rusty Russell           2009-03-31 13:05:36 -0600 249)  * strstarts - does @str start with @prefix?
>>>
>>> ⬢[acme@toolbox linux]$ git grep str_has_prefix| wc -l
>>> 94
>>> ⬢[acme@toolbox linux]$ git grep strstarts| wc -l
>>> 177
>>> ⬢[acme@toolbox linux]$
>>>
>>> Some places use it:
>>>
>>> kernel/printk/printk.c: len = str_has_prefix(str, "on");
>>> kernel/printk/printk.c: len = str_has_prefix(str, "off");
>>> kernel/printk/printk.c: len = str_has_prefix(str, "ratelimit");
>>>
>>>
>>> static int __control_devkmsg(char *str)
>>> {
>>> 	size_t len;
>>>
>>> 	if (!str)
>>> 		return -EINVAL;
>>>
>>> 	len = str_has_prefix(str, "on");
>>> 	if (len) {
>>> 		devkmsg_log = DEVKMSG_LOG_MASK_ON;
>>> 		return len;
>>> 	}
>>>
>>> 	len = str_has_prefix(str, "off");
>>> 	if (len) {
>>> 		devkmsg_log = DEVKMSG_LOG_MASK_OFF;
>>> 		return len;
>>> 	}
>>>
>>> 	len = str_has_prefix(str, "ratelimit");
>>> 	if (len) {
>>> 		devkmsg_log = DEVKMSG_LOG_MASK_DEFAULT;
>>> 		return len;
>>> 	}
>>>
>>> 	return -EINVAL;
>>> }
>>>
>>>
>>>                   err = __control_devkmsg(devkmsg_log_str);
>>>                   /*
>>>                    * Do not accept an unknown string OR a known string with
>>>                    * trailing crap...
>>>                    */
>>>                   if (err < 0 || (err + 1 != *lenp)) {
>>>
>>>                           /* ... and restore old setting. */
>>>                           devkmsg_log = old;
>>>                           strncpy(devkmsg_log_str, old_str, DEVKMSG_STR_MAX_SIZE);
>>>
>>>                           return -EINVAL;
>>>                   }
>>>
>>>
>>> So yeah, I agree with Ian that it is more intention revealing, has this
>>> bonus of returning the strlen for the above use cases, is in the kernel
>>> sources, so I'm in favour of grabbing a copy of it and replacing the
>>> strstarts() usage with it, drop strstarts(), then also introduce
>>> str_has_suffix(), the kernel will get it when it needs, possibly from
>>> tools/lib/ :-)
>>>
>>> - Arnaldo

