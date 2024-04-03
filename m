Return-Path: <linux-kernel+bounces-130008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C7989731B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353151F28F54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD31494BB;
	Wed,  3 Apr 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jIpGFAap"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3A5CDC9;
	Wed,  3 Apr 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156111; cv=none; b=MrC0lzDv4+nR9Jy9jaerILBmD3pxYeGkz3MK2sApuKDdLO50Eg3ikO6CJU52i+FNhot4Iq7zHtnCfvdtaUq7fi6lcwD8g/r02IMBENDzNKrEoRaNtfWRGsRgjaZ9gLbOzQc68mCVcOlA24EFE+2VvRG+i7AELTUiUlo65Do31xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156111; c=relaxed/simple;
	bh=9kQ/LYVoCJX5B8ktIxgmV8Sg3jd1h969aqDlA5UHmXg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kgfL2jAuevjBMPDX6o+PD4A20N5bocCSaNi9soGfQP4TFbM9HPt2RPUTsc6JPG22OJJ1EAoLLwyENMVjjv7oAkD4KCS0dBXLkbiaDCUO5Eo8rtHSU7dR60SaxRsIIKClxTst6eTeQ2qFbLEPw50H93+nEsynk0gtOqdjigcnC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jIpGFAap; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9pVtSJ44xOIUG48fskQmP0c+CrYiusBg1BPFjxUy9dY=; b=jIpGFAapFCUN02RNfLFiWVKy35
	Nx2oLc0g6e8m9/AUdvt+Vagvd+ovgBM69W1NuGYB+AGsJSd+ECYN5/+xjwx33W5gNh6Xf9LaUgQ6K
	57JrRud/zBvtFlB3JXAYpzrA+zBiugwrU7XWeNhyaayYBUD8JSRoYTzukmaqEo4L/SRNJ2i96mL+L
	KCqBKih404TwHKdY+nBQAj5zU31iMHnWKEG++s3ToQ1eaorswU33TUx905LRIT0zUemxLtnN6LqqB
	FwfV4gyAJOE9dWlZ7BF89hzSC3x+nQ1W0oyF9bRhK3uthd53/P6G5p/zS8uNbKJ99LC8EK7aWJvYv
	+rpmNtcw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs210-0000Cf-G6; Wed, 03 Apr 2024 16:55:02 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs20z-00037x-3A;
	Wed, 03 Apr 2024 16:55:01 +0200
Subject: Re: [PATCH] bpf: replace deprecated strncpy with strscpy
To: Ratheesh Kannoth <rkannoth@marvell.com>,
 Justin Stitt <justinstitt@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20240402-strncpy-kernel-bpf-core-c-v1-1-7cb07a426e78@google.com>
 <20240403030642.GA1652044@maili.marvell.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5998a7da-9e61-1852-8281-aee919468953@iogearbox.net>
Date: Wed, 3 Apr 2024 16:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240403030642.GA1652044@maili.marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27234/Wed Apr  3 10:25:27 2024)

On 4/3/24 5:06 AM, Ratheesh Kannoth wrote:
> On 2024-04-03 at 05:22:50, Justin Stitt (justinstitt@google.com) wrote:
>> strncpy() is deprecated for use on NUL-terminated destination strings
>> [1] and as such we should prefer more robust and less ambiguous string
>> interfaces.
>>
>> bpf sym names get looked up and compared/cleaned with various string
>> apis. This suggests they need to be NUL-terminated (strncpy() suggests
>> this but does not guarantee it).
>>
>> |	static int compare_symbol_name(const char *name, char *namebuf)
>> |	{
>> |		cleanup_symbol_name(namebuf);
>> |		return strcmp(name, namebuf);
>> |	}
>>
>> |	static void cleanup_symbol_name(char *s)
>> |	{
>> |		...
>> |		res = strstr(s, ".llvm.");
>> |		...
>> |	}
>>
>> Use strscpy() as this method guarantees NUL-termination on the
>> destination buffer.
>>
>> This patch also replaces two uses of strncpy() used in log.c. These are
>> simple replacements as postfix has been zero-initialized on the stack
>> and has source arguments with a size less than the destination's size.
>>
>> Note that this patch uses the new 2-argument version of strscpy
>> introduced in Commit e6584c3964f2f ("string: Allow 2-argument
>> strscpy()").
>>
>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>> ---
>> Note: build-tested only.
>>
>> Found with: $ rg "strncpy\("
>> ---
>>   kernel/bpf/core.c | 4 ++--
>>   kernel/bpf/log.c  | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index 696bc55de8e8..8c9078f4549c 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -747,7 +747,7 @@ const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
>>   		unsigned long symbol_start = ksym->start;
>>   		unsigned long symbol_end = ksym->end;
>>
>> -		strncpy(sym, ksym->name, KSYM_NAME_LEN);
>> +		strscpy(sym, ksym->name, KSYM_NAME_LEN);
> You dont have to check return value of strscpy for errors ?

That would be overkill, it can be easily audited that both pointers are
of size KSYM_NAME_LEN, as is the count arg.

Thanks,
Daniel

