Return-Path: <linux-kernel+bounces-89798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C438486F5CE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1872821B7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6484D67C45;
	Sun,  3 Mar 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUuxqnl5"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26342EB09;
	Sun,  3 Mar 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709479621; cv=none; b=pIrBgIo1bGLErPfevaoi3HvAkEx/79eooay/HP+u7koWs6Xu2O6Ea68ajPelTl5fXvOs5vrdy98b5nqUC4enpH7YEzVY6aFWXCc1UMGes8ot2ChpiF+ET2k+i3qzWGjlUkrngIiyva5+Z4ZzPQ+0kFmbFw/3Uib5k7HdUAkub/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709479621; c=relaxed/simple;
	bh=1LWbhrusFI+fpSiQ95v3jpN22v5e67tvYdI607w+6Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvNhRozCNNrcZoXxRBgbgxd8Uot5HTIvWPk0+egewGKjbaJ2xQsi37jMSReYKAr/y24NWHVvuw0fe4BaYlYrL37XIyVbamBsxKAypmaHGZXKFqf9ty9t3WsTPbYjht8WL7a0Zh8RWEADvpmHYfewzH7maxx4ATL9oqncS1lb1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUuxqnl5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e56d594b31so1814335b3a.1;
        Sun, 03 Mar 2024 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709479619; x=1710084419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1p1/REnFcJbIVx5JbAa8h2USBJYGT2uWIMxpDb/jKUs=;
        b=aUuxqnl5oCibkm+bX744luR0JkKx8kQbocSiSbwDj9JEDRNQYIXPG8wX2PU0St1b1W
         WOv+KruBT/j4t4jSNCPUJccAzWmER86hfaKAGG9AY7q9ski5Qpu+TWa5Dyvq0GElmzJn
         7iGmAtXx905gksKsE91li+xu8Lw/J9nz2IvIhEnQG1HTknsLRc6DjgXj+KuhB6a+RXpU
         OmivVsmlwuJp+mxvR+kgiLld2RH51uRaxUVVi8L1YhY7pAB/EKQl8mfX37gdgsxzZUJN
         4m4fRHNF+ZhAdhp8vGVODcDWad1XRhiuRp+lKc12pdlm0YYSwy80FUyo5nWdzKNkrNCR
         T8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709479619; x=1710084419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1p1/REnFcJbIVx5JbAa8h2USBJYGT2uWIMxpDb/jKUs=;
        b=Szz8jcX+bN/mCCJojVb8xuzzuPvKElm3+R/jLd63bRafrDJgUs33Z3OGlYmcsQNShr
         TPGeTXkxF0ltPeH6jmvg1DyvKadTg58oxz3DLhOOmZ90BJP6B9c1uRnG8kSjCS/hc8KG
         ADZMQYK7P4/7kO+3DyieH+6tLWuODNkf5DUpkhMseYtALcE+ra/zpx/kloZDW/uT5dWB
         /+MywpGPfjumcycrhI3ABzPOwZk6uNT3TzOZzYejg7EzMijw5le85IA47SGWiL6AYmfC
         pUje9+Sh9WR6cV5jk1xNJNkjKmp1wrQb096knpFlidxMgFm/hLrrsXrHNwfoc3hapJrm
         OF1w==
X-Forwarded-Encrypted: i=1; AJvYcCWDK1eKGdFYnVOVvY7Dc+2wrKce4sNmXtLa47VMJDc4R7k6iu/1EC2hDj9HIIN4es0K4iFLlbjPsl17EdEwdp5wsvFF4XY9oCW7rgM1
X-Gm-Message-State: AOJu0YwLbAIF8TlzSlTj6HW0YwoFARPfJPeo/JT9XGWYUAPoPwIR+KOH
	pBBTtUrQcxfQ6K3yLF6RcgyM3DoOLwrVhvR3T/E8yjf8ORezzZO8
X-Google-Smtp-Source: AGHT+IF6pq9/4mLXjtwmN2TiWhC2kuX6KuIxfSDTB2gKmzOytdu7sHPSH/LBKhz1NS9PGrdPhYqqtQ==
X-Received: by 2002:a17:902:e54f:b0:1dc:d588:bc6b with SMTP id n15-20020a170902e54f00b001dcd588bc6bmr8890187plf.0.1709479618889;
        Sun, 03 Mar 2024 07:26:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f2d300b001db63cfe07dsm6759238plc.283.2024.03.03.07.26.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 07:26:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6df98c91-26b1-497a-9202-18bf86c0130d@roeck-us.net>
Date: Sun, 3 Mar 2024 07:26:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Russell King <linux@armlinux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, David Laight <David.Laight@aculab.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@rivosinc.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Parisc List <linux-parisc@vger.kernel.org>
References: <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
 <62b69aaf-7633-4bd8-aefe-5ba47147dba7@roeck-us.net>
 <f422742a-4c86-4cb0-a4f7-a62f0310eb23@csgroup.eu>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <f422742a-4c86-4cb0-a4f7-a62f0310eb23@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/3/24 02:20, Christophe Leroy wrote:
> 
> 
> Le 01/03/2024 à 19:32, Guenter Roeck a écrit :
>> This leaves the mps2-an385:mps2_defconfig crash, which is avoided by
>> this patch.
>> My understanding, which may be wrong, is that arm images with thumb
>> instructions
>> do not support unaligned accesses (maybe I should say do not support
>> unaligned
>> accesses with the mps2-an385 qemu emulation; I did not test with real
>> hardware,
>> after all).
>>
>> Given all that, the continued discussion around the subject, and the lack
>> of agreement if unaligned accesses should be tested or not, I don't really
>> see a path forward for this patch. The remaining known problem is arm with
>> thumb instructions. I don't think that is going to be fixed. I suspect that
>> no one but me even tries to run that code (or any arm:nommu images, for
>> that
>> matter). I'd suggest to drop this patch, and I'll stop testing IP checksum
>> generation for mps2-an385:mps2_defconfig.
> 
> I'm trying to run an ARM kernel built with GCC 13.2 and mps2_defconfig
> on the mps2-an385 qemu emulation, and I get the following fatal error.
> 
> $ qemu-system-arm -M mps2-an385 -kernel vmlinux
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
> 
> R00=00000000 R01=00000000 R02=00000000 R03=00000000
> R04=00000000 R05=00000000 R06=00000000 R07=00000000
> R08=00000000 R09=00000000 R10=00000000 R11=00000000
> R12=00000000 R13=ffffffe0 R14=fffffff9 R15=00000000
> XPSR=40000003 -Z-- A handler
> FPSCR: 00000000
> Abandon (core dumped)
> 
> Can you tell how to proceed ?
> 

You can't run it directly. mps2-an385 is one of the platforms where
the qemu maintainers insisted that qemu shall not initialize the CPU.
You have to provide a shim such as
https://github.com/groeck/linux-build-test/blob/master/rootfs/arm/mps2-boot.axf
as bios. You also have to provide the dtb file.

On top of that, you would need a customized version of qemu which
actually reads the command line, the bios file, and the dtb. See
https://github.com/groeck/linux-build-test/tree/master/qemu
branch v8.2.1-local or v8.1.5-local.

It might be possible to find a bootloader which does all that and
prepares the emulation for running Linux, but I don't know if that
exists somewhere.

Guenter


