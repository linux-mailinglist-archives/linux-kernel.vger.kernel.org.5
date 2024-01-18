Return-Path: <linux-kernel+bounces-30599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2343383217D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E71C23487
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85C32193;
	Thu, 18 Jan 2024 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="ScB2iEqY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFC31A94
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616446; cv=none; b=sF+0INbSgXsxtTT2Qy4+bA/QpIrieec77vlpMlBQp1uqO0ZL9kli9AZbFZZkmH1/wWsm3AU+1V4VpO8Tpw9+dNJu8qAuNRqfo9BQ8YtnE0Y/exkYv1WB/bDdPND3utOg27E5m+lC2P+mVn9ggm025KJtBBUhmJguGMU4hTXVO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616446; c=relaxed/simple;
	bh=qiWTSskA5SSZePhXkZAX9YkCqabUR00Y/fxyaf4efyY=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=dsKqYiMzd0ScBTruA/NYLwJb2H9ElR/uzzNqFtMI0oMpdlEivYn29p8ORHEQL0b8VERCaNOHggfkvoD452Ba1KQkOFpss24Lb8Onuoe21PIYCUwOgKj1Xj13CE2XgZnYZc1UuhbiHnKLGRIKLG02LLRxomOHWARk2Z4J16FYu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=ScB2iEqY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d6ff29293dso1115525ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1705616443; x=1706221243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hc8hICt5ejBrlX4pfwNFCUxCM9+pbxHoveyZSbVMX8=;
        b=ScB2iEqYvaUV6bJHY4VZrJTFxfP93Z1XK0vNBqO6L5forFhnW3qjYt8sYd4EQ9s93j
         xV1MT35b0bSqJKQDeg/uBVeUYV0HFQxUNLeVtGlUmqPAuu3iebGT57mjiTY2SZgyRG2t
         aKMt5UWCMLz1WBqzk6zRO1wq4GApSKHB6b6/MJ8rf/Hod4Ep3jHitsNyEfOBu5Wqk0SL
         O1S5efwJnzUsm6dG3cDuwJ6AeMicLqj4rr9cRswq6HwqFR+MzUzJOfjqSL2Ef+Dff9Rf
         MPf889/VQDhwUFPYqUhPPJpwGDx7qDuAEuYNaXaBHHI5L5lkrEzHn3DHyihM8+xb2NuQ
         p5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705616443; x=1706221243;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hc8hICt5ejBrlX4pfwNFCUxCM9+pbxHoveyZSbVMX8=;
        b=YjIgI71zIAEJLIeDlc+H7He54nqPtzJTJPiXKTTh/buIJ2pIkLKi0o7Admi+RygosC
         f9zSwldkOvm+SwXPmvu9Sqm3cvKvUDmpqORfd1c6cr9MBT5b1Q3dFMKgZWRtz/q1CaT0
         6WgFN2smfe7U7o2/LZYdV9lYl7g/qwu5cIOTE0iepvBhv2v367gdHAY/49bu84n/d/u6
         FmVzH0J5H4YqTXD8mvJ3fs2DDgB6dv6tW4RidBhT9GCbjYyINE9W0kAvTYuIG8BB9HJf
         K3TpBNUyPl6gLuW8KsYlBVpjEHvQjWbZaC37b3aj2xuX8PfmN+hVR/xeM5BSxCYpE3u3
         7BmQ==
X-Gm-Message-State: AOJu0YwElZHHgbH7Z7XCqgZyNQkcd5YSOZHCJe3ZdRBNuwcC5aHFu2CI
	0/UFPTBfUi4X2fz0kf2uHmsAT+UIP3PJIx1itomh//7x9nZLnuqt5e6cLyfzENI=
X-Google-Smtp-Source: AGHT+IFVi1Cop1qCpjAovMwPZtxUEOt7eZBvKmMFZlsB5B6T93oqVGP+/tGtlj7m80SQ4H5A77qI4g==
X-Received: by 2002:a17:902:d505:b0:1d7:af2:869c with SMTP id b5-20020a170902d50500b001d70af2869cmr1447197plg.123.1705616443503;
        Thu, 18 Jan 2024 14:20:43 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id u2-20020a170903304200b001d706912d1esm1664293pla.225.2024.01.18.14.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 14:20:42 -0800 (PST)
Date: Thu, 18 Jan 2024 14:20:42 -0800 (PST)
X-Google-Original-Date: Thu, 18 Jan 2024 14:20:40 PST (-0800)
Subject:     Re: [PATCH] riscv: lib: Support csum on GCC <11
In-Reply-To: <20240118-museum-ample-11d649f95de8@spud>
CC: charlie@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-6127df88-9768-4f9d-8d78-a1aeb4213451@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 18 Jan 2024 14:05:44 PST (-0800), Conor Dooley wrote:
> On Thu, Jan 18, 2024 at 01:53:59PM -0800, Charlie Jenkins wrote:
>> The OutputOperands field for asm goto statements is only supported
>> starting from GCC 11. Split the asm goto to remove the use of this
>> feature.
>> 
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> Fixes: a04c192eabfb ("riscv: Add checksum library")
>> ---
>> The OutputOperands field for asm goto statements is only supported
>> starting from GCC 11. Split the asm goto to remove the use of this
>> feature.
>
> Maybe this is a super naive question, but is it possible to just not
> use the custom csum code for gcc older than 11?

Charlie and I were talking, these old GCC versions also don't support 
ZBB.  So I think we can get away with something like

diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 06ce8e7250d9..17f883b612c9 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -158,10 +158,16 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 
 	/*
 	 * Zbb support saves 6 instructions, so not worth checking without
-	 * alternatives if supported
+	 * alternatives if supported.
+	 *
+	 * Note that we pull the check for ZBB into the preprocessor proper
+	 * here, as otherwise GCC will attempt to compile the code inside the
+	 * "if (IS_ENABLED(ZBB)" block which fails because GCC10 doesn't
+	 * support ASM goto output operands.  GCC 10 also doesn't support ZBB,
+	 * so we're safe with that check here.
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+#if defined(CONFIG_RISCV_ISA_ZBB)
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
 		unsigned long fold_temp;
 
 		/*
@@ -213,6 +219,7 @@ do_csum_with_alignment(const unsigned char *buff, int len)
 end:
 		return csum >> 16;
 	}
+#endif /*CONFIG_RISCV_ISA_ZBB*/
 no_zbb:
 #ifndef CONFIG_32BIT
 	csum += ror64(csum, 32);
@@ -244,10 +251,11 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 
 	/*
 	 * Zbb support saves 6 instructions, so not worth checking without
-	 * alternatives if supported
+	 * alternatives if supported.  See above for the ZBB preprocessor
+	 * check.
 	 */
-	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
-	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+#if defined(CONFIG_RISCV_ISA_ZBB)
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
 		unsigned long fold_temp;
 
 		/*
@@ -287,6 +295,7 @@ do_csum_no_alignment(const unsigned char *buff, int len)
 #endif /* !CONFIG_32BIT */
 		return csum >> 16;
 	}
+#endif /*CONFIG_RISCV_ISA_ZBB*/
 no_zbb:
 #ifndef CONFIG_32BIT
 	csum += ror64(csum, 32);

which is building for me on GCC-10/defconfig.

>
>> ---
>>  arch/riscv/lib/csum.c | 42 ++++++++++++++++++++++++++++++------------
>>  1 file changed, 30 insertions(+), 12 deletions(-)
>> 
>> diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
>> index 06ce8e7250d9..23be289f52b6 100644
>> --- a/arch/riscv/lib/csum.c
>> +++ b/arch/riscv/lib/csum.c
>> @@ -177,22 +177,35 @@ do_csum_with_alignment(const unsigned char *buff, int len)
>>  				  : no_zbb);
>>  
>>  #ifdef CONFIG_32BIT
>> -		asm_volatile_goto(".option push			\n\
>> +		/*
>> +		 * OutputOperands in asm goto is not supported until GCC 11, so
>> +		 * this asm has to be split to be compatible.
>> +		 */
>> +		asm (".option push				\n\
>>  		.option arch,+zbb				\n\
>>  			rori	%[fold_temp], %[csum], 16	\n\
>>  			andi	%[offset], %[offset], 1		\n\
>>  			add	%[csum], %[fold_temp], %[csum]	\n\
>> -			beq	%[offset], zero, %l[end]	\n\
>> -			rev8	%[csum], %[csum]		\n\
>>  		.option pop"
>>  			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
>> -			: [offset] "r" (offset)
>> -			:
>> -			: end);
>> +			: [offset] "r" (offset));
>> +
>> +		if (offset == 0)
>> +			goto end;
>> +
>> +		asm (".option push				\n\
>> +		.option arch, +zbb				\n\
>> +			rev8	%[csum], %[csum]		\n\
>> +		.option pop"
>> +			: [csum] "+r" (csum));
>>  
>>  		return (unsigned short)csum;
>>  #else /* !CONFIG_32BIT */
>> -		asm_volatile_goto(".option push			\n\
>> +		/*
>> +		 * OutputOperands in asm goto is not supported until GCC 11, so
>> +		 * this asm has to be split to be compatible.
>> +		 */
>> +		asm (".option push				\n\
>>  		.option arch,+zbb				\n\
>>  			rori	%[fold_temp], %[csum], 32	\n\
>>  			add	%[csum], %[fold_temp], %[csum]	\n\
>> @@ -200,13 +213,18 @@ do_csum_with_alignment(const unsigned char *buff, int len)
>>  			roriw	%[fold_temp], %[csum], 16	\n\
>>  			addw	%[csum], %[fold_temp], %[csum]	\n\
>>  			andi	%[offset], %[offset], 1		\n\
>> -			beq	%[offset], zero, %l[end]	\n\
>> -			rev8	%[csum], %[csum]		\n\
>>  		.option pop"
>>  			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp)
>> -			: [offset] "r" (offset)
>> -			:
>> -			: end);
>> +			: [offset] "r" (offset));
>> +
>> +		if (offset == 0)
>> +			goto end;
>> +
>> +		asm (".option push				\n\
>> +		.option arch, +zbb				\n\
>> +			rev8	%[csum], %[csum]		\n\
>> +		.option pop"
>> +			: [csum] "+r" (csum));
>>  
>>  		return (csum << 16) >> 48;
>>  #endif /* !CONFIG_32BIT */
>> 
>> ---
>> base-commit: 080c4324fa5e81ff3780206a138223abfb57a68e
>> change-id: 20240118-csum_remove_output_operands_asm_goto-49922c141ce7
>> -- 
>> - Charlie
>> 
>> 

