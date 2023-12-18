Return-Path: <linux-kernel+bounces-2912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B5816423
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902A61F21D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598DF1FD7;
	Mon, 18 Dec 2023 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxKcTPm9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48E1FBE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-336601b92d3so146621f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702863694; x=1703468494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QP9cKKdIu0D7eMF95Nv/b4ZXZfvmBhOKtxAVx99xG5k=;
        b=RxKcTPm9maLK3hfUx7NfNZiEqtKfJEMMBS0LuR15GYjBdfnQB0JeB1qIk+zKEJF7zR
         j5MEwyW5nyCP3DdfjK5WJEskOON0EdZYIZflgnL/JIaOr14m2MMWWVJmnn03QWR4WPc4
         PZSerkIKvCW4OlsiunDEm4p83w1eQsAZiC5ZPNWlJ0X5XAWAbBEUbklgM35yIfKuRbiI
         TjwPMBwGxwkUFRZBcMYUHJhzivTm126+OOB9F7UgGRIfBdZSf3ux6NXxuQrW+zBNsBg8
         uQa47ihCUFVGwxmIW1vv+s/pdw89n2AmmSz7iWj8+7VbqCJA5bnk/Xm6R3jeTabieIs+
         fQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702863694; x=1703468494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QP9cKKdIu0D7eMF95Nv/b4ZXZfvmBhOKtxAVx99xG5k=;
        b=i49KpJyDKFwJLvGs6W1DMD4KSCn3pi5suJkDol4b49m0HF0hLNI1shhN7sRxixB8vh
         9MurPGIabTzbVr5PLRcJol1X9zUzqBf9YX6vU5OE39wqcsoKDKc5x9XfGjR9z/yc4l5S
         M5TKPh7EcTUIIrXRxXf4UNnfIEwQY8YvQsZSd51xrztR5zVmmF1lVuZz1EMZNJaYA8KY
         PrL2vaSPkdmb+ZGUsSmIcrxWnixivT9V7akpojG2Da6AmEIxyOr4Xiv1tEGqi0S/aEYa
         tn44hMuyePZbfS26iFMCO12TIg8629BTy2TccRYx8NlMDH8WEJci+B6F7g2mHtVFLCgz
         smVw==
X-Gm-Message-State: AOJu0YyoKIjzuYLsjjeh4sebpbZDcyVNJMCsLAjSknWpaEH7KwtmOLMm
	7W+PrWluEAobzz0CvF8AwBY=
X-Google-Smtp-Source: AGHT+IE7HTSQXD+eITvRHickGBmH36WAGaciRLnf2AicKyuRSQSP+rduYd3qrZ7c3be5KqEoyS3QCg==
X-Received: by 2002:a7b:c411:0:b0:40b:4f49:4a33 with SMTP id k17-20020a7bc411000000b0040b4f494a33mr18727176wmi.4.1702863694258;
        Sun, 17 Dec 2023 17:41:34 -0800 (PST)
Received: from ?IPV6:2a01:4b00:d20e:7300:c482:b9a:a1b4:9bfa? ([2a01:4b00:d20e:7300:c482:b9a:a1b4:9bfa])
        by smtp.gmail.com with ESMTPSA id fs27-20020a05600c3f9b00b0040b36050f1bsm38786231wmb.44.2023.12.17.17.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 17:41:33 -0800 (PST)
Message-ID: <de80b4c7-1ffb-478e-9117-9d5b829470bd@gmail.com>
Date: Mon, 18 Dec 2023 01:41:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: lib: Optimize 'strlen' function
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Cc: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
 "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
 "samuel@sholland.org" <samuel@sholland.org>,
 "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
References: <20231213154530.1970216-1-ivan.orlov0322@gmail.com>
 <86d3947bce1f49c395224998e7d65dc2@AcuMS.aculab.com>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <86d3947bce1f49c395224998e7d65dc2@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/23 17:00, David Laight wrote:
> I'd also guess that pretty much all the calls in-kernel are short.
> You might try counting as: histogram[ilog2(strlen_result)]++
> and seeing what it shows for some workload.
> I bet you (a beer if I see you!) that you won't see many over 1k.

Hi David,

Here is the statistics for strlen result:

[  223.169575] Calls count for 2^0: 6150
[  223.173293] Calls count for 2^1: 184852
[  223.177142] Calls count for 2^2: 313896
[  223.180990] Calls count for 2^3: 185844
[  223.184881] Calls count for 2^4: 87868
[  223.188660] Calls count for 2^5: 9916
[  223.192368] Calls count for 2^6: 1865
[  223.196062] Calls count for 2^7: 0
[  223.199483] Calls count for 2^8: 0
[  223.202952] Calls count for 2^9: 0
...

Looks like I've just lost a beer :)

Considering this statistics, I'd say implementing the word-oriented 
strlen is an overcomplication - we wouldn't get any performance gain and 
it just doesn't worth it.

I simplified your code a little bit, it looks like the alignment there 
is unnecessary: QEMU test shows the same performance independently from 
alignment. Tests on the board gave the same result (perhaps because the 
CPU on the board has 2 DDR channels?)

	mv t0, a0
1:
	lbu t1, 0(a0)
	lbu t2, 1(a0)
	addi a0, a0, 2
	beqz t1, 2f
	bnez t2, 1b
	addi a0, a0, 1
2:
	addi a0, a0, -2
	sub a0, a0, t0
	ret

If it looks good to you, would you mind if I send the patch with it? 
Could I add you to suggested-by tag?

-- 
Kind regards,
Ivan Orlov


