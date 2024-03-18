Return-Path: <linux-kernel+bounces-106259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86987EB92
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0811C21200
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0D4EB49;
	Mon, 18 Mar 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="zJhwOLrJ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B314F1E3;
	Mon, 18 Mar 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774260; cv=none; b=R42mK9VoYyEFb+XWHoFRjEjOzChW4Qhy5YNf81bXLknHuyJx0M7ZZwx8P5k0QLewKpdibjonEO/WjxanOWHSYheZhHBe/6OkRJfpSqFDHqa72y4/JObYD+9N0P0SdgHXreChrsJxZb/tV46qRZOX+1YsBixMlomjLhGq+lj4Cio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774260; c=relaxed/simple;
	bh=2LQU/waPjsREZUsLg9NrzpLXBHyStidTkJNjdyXC8Rg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YhbWk42GdW/gvgQPZ1ckICIndM5io/29MGvkIsfJXAvQVPyHZ/doe9DNyPqLBcdGwxSU/QQ03Q8yrm7G0CyWSalKZso69cWEleYPgDy9XfvyN8lG5LDN/kLGAM6tXjIReXm4aRz11Cm/GItUHE6K6VN7q5kiwiLad2JWBCwhuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=zJhwOLrJ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Reply-To:Subject:From:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=xIz7iXaGyTgA8QLC484uOZk8/HP4X9mjTbdpsdit22s=;
	t=1710774258; x=1711206258; b=zJhwOLrJqnKOUsr48QWkkkY5ewkRm1Y1Ay9EqFFARUcExXm
	pQEfnGYbQ2t/W/9kh2Cpn7EKzPaiW9gl3DRjGHXbtSSfOVmfvWBh/kFMc1r7XQpq3526EkEFOY90k
	1yWtvwCF1xfJQUw2txTeWI9QBnozXrpekUj4y5WRt7dUmIs4xjexVcZYZo759oGuXQqoPir7P5cjL
	xHHrx+mQThSp6iZMIUnvJTvLyzkMFLobNZOIHwqHwbyTp6LZqzuPFZHdcalGOrIl/9VlcDNFCquT+
	Roqk59yNBK41MEFOVtfMe7dmrmkbGQs3U4z9STbzfI8juU8bqT1FNOIAc/slsa5w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rmEX6-0001co-Fx; Mon, 18 Mar 2024 16:04:12 +0100
Message-ID: <2b54a5d8-b317-4df7-ab2e-d63a352dd77d@leemhuis.info>
Date: Mon, 18 Mar 2024 16:04:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Subject: Re: Problems with csum_partial with misaligned buffers on sh4
 platform
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To: Guenter Roeck <linux@roeck-us.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <65ed7c95-712c-410b-84f3-58496b0c9649@roeck-us.net>
 <351dfebd-c09f-470e-8b03-cc904753b136@roeck-us.net>
Content-Language: en-US, de-DE
In-Reply-To: <351dfebd-c09f-470e-8b03-cc904753b136@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710774258;3ff2e1e0;
X-HE-SMSGID: 1rmEX6-0001co-Fx

On 11.03.24 18:04, Guenter Roeck wrote:
> On Sat, Feb 10, 2024 at 07:12:39AM -0800, Guenter Roeck wrote:
>>
>> when running checksum unit tests on sh4 qemu emulations, I get the following
>> errors.
> 
> Adding to regression tracker.
> 
> #regzbot ^introduced cadc4e1a2b4d2

Hmmm, thx for that, but well, I'm a bit taken back and forth here. That
commit afaics is from v3.0-rc1 and Linus iirc at least once said
something along the lines of "a regression only reported after a long
time at some point becomes just a bug". I'd say that applies there,
which is why I'm wondering if tracking this really is worth it.

Ciao, Thorsten


>>     KTAP version 1
>>     # Subtest: checksum
>>     # module: checksum_kunit
>>     1..5
>>     # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
>>     Expected ( u64)result == ( u64)expec, but
>>         ( u64)result == 53378 (0xd082)
>>         ( u64)expec == 33488 (0x82d0)
>>     not ok 1 test_csum_fixed_random_inputs
>>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
>>     Expected ( u64)result == ( u64)expec, but
>>         ( u64)result == 65281 (0xff01)
>>         ( u64)expec == 65280 (0xff00)
>>     not ok 2 test_csum_all_carry_inputs
>>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:573
>>     Expected ( u64)result == ( u64)expec, but
>>         ( u64)result == 65535 (0xffff)
>>         ( u64)expec == 65534 (0xfffe)
>>     not ok 3 test_csum_no_carry_inputs
>>     ok 4 test_ip_fast_csum
>>     ok 5 test_csum_ipv6_magic
>> # checksum: pass:2 fail:3 skip:0 total:5
>>
>> The above is with from a little endian system. On a big endian system,
>> the test result is as follows.
>>
>>     KTAP version 1
>>     # Subtest: checksum
>>     # module: checksum_kunit
>>     1..5
>>     # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
>>     Expected ( u64)result == ( u64)expec, but
>>         ( u64)result == 33488 (0x82d0)
>>         ( u64)expec == 53378 (0xd082)
>>     not ok 1 test_csum_fixed_random_inputs
>>     # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
>>     Expected ( u64)result == ( u64)expec, but
>>         ( u64)result == 65281 (0xff01)
>>         ( u64)expec == 255 (0xff)
>>     not ok 2 test_csum_all_carry_inputs
>>     # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:565
>>     Expected ( u64)result == ( u64)expec, but
>>         ( u64)result == 1020 (0x3fc)
>>         ( u64)expec == 0 (0x0)
>>     not ok 3 test_csum_no_carry_inputs
>>     # test_ip_fast_csum: ASSERTION FAILED at lib/checksum_kunit.c:589
>>     Expected ( u64)expected == ( u64)csum_result, but
>>         ( u64)expected == 55939 (0xda83)
>>         ( u64)csum_result == 33754 (0x83da)
>>     not ok 4 test_ip_fast_csum
>>     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:617
>>     Expected ( u64)expected_csum_ipv6_magic[i] == ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum), but
>>         ( u64)expected_csum_ipv6_magic[i] == 6356 (0x18d4)
>>         ( u64)csum_ipv6_magic(saddr, daddr, len, proto, csum) == 43586 (0xaa42)
>>     not ok 5 test_csum_ipv6_magic
>> # checksum: pass:0 fail:5 skip:0 total:5
>>
>> Note that test_ip_fast_csum and test_csum_ipv6_magic fail on all big endian
>> systems due to a bug in the test code, unrelated to this problem.
>>
>> Analysis shows that the errors are seen only if the buffer is misaligned.
>> Looking into arch/sh/lib/checksum.S, I found commit cadc4e1a2b4d2 ("sh:
>> Handle calling csum_partial with misaligned data") which seemed to be
>> related. Reverting that commit fixes the problem.
>> This suggests that something may be wrong with that commit. Alternatively,
>> of course, it may be possible that something is wrong with the qemu
>> emulation, but that seems unlikely.
>>
>> Thanks,
>> Guenter

