Return-Path: <linux-kernel+bounces-34300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EF78377C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809341F24939
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34A44E1AE;
	Mon, 22 Jan 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="xNDp7+iw"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8A4B5A6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966760; cv=none; b=uXyFx70+zKj56pRTy4oEnPbNiC1++SocugH5rpkeyct09jTvoNweKZZ5j5afkbuwcw3q18VRSuvPRzn9yzWRa3rFH8A9LWatby/Kom3QfdKaNekX9ZyvFamawf5rZNpBtDQlX1pwtwtTPLBs0K0zk0vdh41/gmjgPdrAmsVjzlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966760; c=relaxed/simple;
	bh=xiGA4Dzc0wWP4EkQIjvNOdHLkFhWn5Xs0+/0KaZ9By0=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=jNYYiuJyHGtWZj8CMCC4wsestRR5yT9G1nGUUnv+or1XeJRS2VJTvjcYxkmJ2lMGjgFtw/zrOD/DJj7sRkPFuf6GKy96+XgDKepBj7joupICwsRpfRkPnjhVvxtep77rfptSMJEBc60Dil+8Xp41Qfwd40VEJ6isZxzeknzP4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=xNDp7+iw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dd6b80b6afso3017b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1705966757; x=1706571557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1Z7TMO+jlXXWWyWCZcJYVQVsmcsD5xU6FxCleKovtY=;
        b=xNDp7+iwFHLS/nxXeukqJC3W6XEZOTB9HCb878W6yEGzt4PzxoLwWDFZl467uQ24ut
         RccOCE1WEjXSMVY9uXhWKhdcEtmpRm0hVuNO5nkdOBJgMPynjmzdAzDXfut3RcWPm1Z/
         zCsOzlmKkTPqNqsNZ3j36/CVmHOnNIMU5TCrlnL7Z5mIWbxUUmQzUMLddhqErMkt2fpF
         ra8sheeIAdupxaZ/1dUyNSGqRD4hXM0DX0lVht8AFDTIU8I0JwMopfFjsgDFN2Mm5jRe
         ZXr8ZcNSYUXBtOTf5224xLIVW7Gw63Y66WGFIj2m3oVQFIKorL4JtK2SZh/5QQ+SIvSq
         4iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705966757; x=1706571557;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1Z7TMO+jlXXWWyWCZcJYVQVsmcsD5xU6FxCleKovtY=;
        b=nNVVIi/dQXu3u9qBE44EQSaWH3BS6Z+bemxmYk1A3dkbkfwv8APTXM2m24Ktn9xMNi
         KpDWCSTM6IwcdSvjZKPpuRLQ2AD0gXFxh3zK1c+M9TlWLexLx3mAuDFeNAQjSwGCdWpb
         Y/zpBMo/INkpqSVKBvZk/hZcIQbVlQ0J7dIawa2jMOLbcxexqLSvJw8myG92VDdDTYF3
         PPhDrSJwXk9AljXSMi5/DcS8Y/U33uUfr3jgIpBJNhLMH279YUdyuIR24U9rnHKnhb0n
         ax72YopHDaoCfLPaM6By6ev+me2RsWZdaeEe8lAmVyrJSJxa9+PEvTPwEcaD0DDT6cbZ
         gvkA==
X-Gm-Message-State: AOJu0YygWAfYMudadFcjFtt+ms9HT4YOs1XoRuoKTYZ5Dn4teNDFcx9M
	eUaK/kc72QdR3iUVelw3GVybSFU2OB7faUhIMsxxhffnMZjLuwxBu9fqSr/5JTE=
X-Google-Smtp-Source: AGHT+IHroItpJWznNEfKh19g/GnSygUrkdpTMXX24mBVJc3jFJvJ6LRrEv7NQ8110mvxwpmF/jHprQ==
X-Received: by 2002:a05:6a20:3089:b0:19a:e284:5b21 with SMTP id 9-20020a056a20308900b0019ae2845b21mr4838334pzn.74.1705966757110;
        Mon, 22 Jan 2024 15:39:17 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b006dbc4cb72ebsm6170406pff.201.2024.01.22.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 15:39:16 -0800 (PST)
Date: Mon, 22 Jan 2024 15:39:16 -0800 (PST)
X-Google-Original-Date: Mon, 22 Jan 2024 15:39:05 PST (-0800)
Subject:     RE: [PATCH v15 5/5] kunit: Add tests for csum_ipv6_magic and ip_fast_csum
In-Reply-To: <be959a4bb660466faba5ade7976485c8@AcuMS.aculab.com>
CC: linux@roeck-us.net, charlie@rivosinc.com, Conor Dooley <conor@kernel.org>,
  samuel.holland@sifive.com, xiao.w.wang@intel.com, Evan Green <evan@rivosinc.com>, guoren@kernel.org,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: David.Laight@ACULAB.COM
Message-ID: <mhng-b5f26a34-7632-4423-9f07-3224170bae9f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 22 Jan 2024 13:41:48 PST (-0800), David.Laight@ACULAB.COM wrote:
> From: Guenter Roeck
>> Sent: 22 January 2024 17:16
>> 
>> On 1/22/24 08:52, David Laight wrote:
>> > From: Guenter Roeck
>> >> Sent: 22 January 2024 16:40
>> >>
>> >> Hi,
>> >>
>> >> On Mon, Jan 08, 2024 at 03:57:06PM -0800, Charlie Jenkins wrote:
>> >>> Supplement existing checksum tests with tests for csum_ipv6_magic and
>> >>> ip_fast_csum.
>> >>>
>> >>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> >>> ---
>> >>
>> >> With this patch in the tree, the arm:mps2-an385 qemu emulation gets a bad hiccup.
>> >>
>> >> [    1.839556] Unhandled exception: IPSR = 00000006 LR = fffffff1
>> >> [    1.839804] CPU: 0 PID: 164 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc1 #1
>> >> [    1.839948] Hardware name: Generic DT based system
>> >> [    1.840062] PC is at __csum_ipv6_magic+0x8/0xb4
>> >> [    1.840408] LR is at test_csum_ipv6_magic+0x3d/0xa4
>> >> [    1.840493] pc : [<21212f34>]    lr : [<21117fd5>]    psr: 0100020b
>> >> [    1.840586] sp : 2180bebc  ip : 46c7f0d2  fp : 21275b38
>> >> [    1.840664] r10: 21276b60  r9 : 21275b28  r8 : 21465cfc
>> >> [    1.840751] r7 : 00003085  r6 : 21275b4e  r5 : 2138702c  r4 : 00000001
>> >> [    1.840847] r3 : 2c000000  r2 : 1ac7f0d2  r1 : 21275b39  r0 : 21275b29
>> >> [    1.840942] xPSR: 0100020b
>> >>
>> >> This translates to:
>> >>
>> >> PC is at __csum_ipv6_magic (arch/arm/lib/csumipv6.S:15)
>> >> LR is at test_csum_ipv6_magic (./arch/arm/include/asm/checksum.h:60
>> >> ./arch/arm/include/asm/checksum.h:163 lib/checksum_kunit.c:617)
>> >>
>> >> Obviously I can not say if this is a problem with qemu or a problem with
>> >> the Linux kernel. Given that, and the presumably low interest in
>> >> running mps2-an385 with Linux, I'll simply disable that test. Just take
>> >> it as a heads up that there _may_ be a problem with this on arm
>> >> nommu systems.
>> >
>> > Can you drop in a disassembly of __csum_ipv6_magic ?
>> > Actually I think it is:
>> 
>> It is, as per the PC pointer above. I don't know anything about arm assembler,
>> much less about its behavior with THUMB code.
> 
> Doesn't look like thumb to me (offset 8 is two 4-byte instructions) and
> the code I found looks like arm to me.
> (I haven't written any arm asm since before they invented thumb!)
> 
>> > ENTRY(__csum_ipv6_magic)
>> > 		str	lr, [sp, #-4]!
>> > 		adds	ip, r2, r3
>> > 		ldmia	r1, {r1 - r3, lr}
>> >
>> > So the fault is (probably) a misaligned ldmia ?
>> > Are they ever supported?
>> >
>> 
>> Good question. My primary guess is that this never worked. As I said,
>> this was just intended to be informational, (probably) no reason to bother.
>> 
>> Of course one might ask if it makes sense to even keep the arm nommu code
>> in the kernel, but that is of course a different question. I do wonder though
>> if anyone but me is running it.
> 
> If it is an alignment fault it isn't a 'nommu' bug.
> 
> And traditionally arm didn't support misaligned transfers (well not
> in anyway any other cpu did!).
> It might be that the kernel assumes that all ethernet packets are
> aligned, but the test suite isn't aligning the buffer.
> Which would make it a test suite bug.

From talking to Evan and Vineet, I think you're right and this is a test 
suite bug: specifically the tests weren't respecting NET_IP_ALIGN.  That 
didn't crop up for ip_fast_csum() as it just uses ldr which supports 
misaligned accesses on the M3 (at least as far as I can tell).

So I think the right fix is something like

    diff --git a/lib/checksum_kunit.c b/lib/checksum_kunit.c
    index 225bb7701460..2dd282e27dd4 100644
    --- a/lib/checksum_kunit.c
    +++ b/lib/checksum_kunit.c
    @@ -5,6 +5,7 @@
    
     #include <kunit/test.h>
     #include <asm/checksum.h>
    +#include <asm/checksum.h>
     #include <net/ip6_checksum.h>
    
     #define MAX_LEN 512
    @@ -15,6 +16,7 @@
     #define IPv4_MAX_WORDS 15
     #define NUM_IPv6_TESTS 200
     #define NUM_IP_FAST_CSUM_TESTS 181
    +#define SUPPORTED_ALIGNMENT (1 << NET_IP_ALIGN)
    
     /* Values for a little endian CPU. Byte swap each half on big endian CPU. */
     static const u32 random_init_sum = 0x2847aab;
    @@ -486,7 +488,7 @@ static void test_csum_fixed_random_inputs(struct kunit *test)
     	__sum16 result, expec;
    
     	assert_setup_correct(test);
    -	for (align = 0; align < TEST_BUFLEN; ++align) {
    +	for (align = 0; align < TEST_BUFLEN; align += SUPPORTED_ALIGNMENT) {
     		memcpy(&tmp_buf[align], random_buf,
     		       min(MAX_LEN, TEST_BUFLEN - align));
     		for (len = 0; len < MAX_LEN && (align + len) < TEST_BUFLEN;
    @@ -513,7 +515,7 @@ static void test_csum_all_carry_inputs(struct kunit *test)
    
     	assert_setup_correct(test);
     	memset(tmp_buf, 0xff, TEST_BUFLEN);
    -	for (align = 0; align < TEST_BUFLEN; ++align) {
    +	for (align = 0; align < TEST_BUFLEN; align += SUPPORTED_ALIGNMENT) {
     		for (len = 0; len < MAX_LEN && (align + len) < TEST_BUFLEN;
     		     ++len) {
     			/*
    @@ -553,7 +555,7 @@ static void test_csum_no_carry_inputs(struct kunit *test)
    
     	assert_setup_correct(test);
     	memset(tmp_buf, 0x4, TEST_BUFLEN);
    -	for (align = 0; align < TEST_BUFLEN; ++align) {
    +	for (align = 0; align < TEST_BUFLEN; align += SUPPORTED_ALIGNMENT) {
     		for (len = 0; len < MAX_LEN && (align + len) < TEST_BUFLEN;
     		     ++len) {
     			/*

but I haven't even build tested it...

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

