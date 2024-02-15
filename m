Return-Path: <linux-kernel+bounces-67365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AC2856A79
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C711C23295
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB62A13699D;
	Thu, 15 Feb 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="FS9z68lJ"
Received: from cmx-torrgo002.bell.net (mta-tor-005.bell.net [209.71.212.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E413698F;
	Thu, 15 Feb 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.212.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016639; cv=none; b=Pfp7LZn+CDykFKPMFMh9dc6nyph6yvSjxEA6IltAVuZzzqDLW5GGbq12DFTxH+FQzmQcPO66XkvuQQrXwIYjEUYSm1LVgMy5ivhGxlZ778Pusiee1/t+OcgbmoNAyqzqJ2zJpacoAF5YUGoj9qzbxzTrb7Z02Yg/RUL6aTIZk64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016639; c=relaxed/simple;
	bh=JxaHZLwKPKtb9xWMBkfltHXf2WY7/2Se4NIKHvyS9II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tv8rUrW6LEe6ox3j4BPHyoN+JGDPMJJR8GsO/wVpKrBQlQH9CID6OrO1quzr73oKm2fX+yGTaFIbtOHFMIC65bBMZTTZ1EFY6yU13JD32A1N8qwhsoQ1FEcFrYqj7hL7Hnq0sDwZ4JdSS6pnwR7Udy32mFSkmn5DN8bZNY9F1KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=FS9z68lJ; arc=none smtp.client-ip=209.71.212.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1708016637; 
        bh=KKvgz6hFPrq3Yt2GwJdIIlDAGA+dk5HzFk1bja/wdOY=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
        b=FS9z68lJTq8UQ0DDce4ffUKoYT4LurrwPeg+ZXEKmMonbIZ15Jxd432xCIDzNAxhBUE1DKsPLwnkRIm1Ri4CzBwWNZQXg9tIFrdxoBmDrCD708hRlwKU4O4gVYnjRlLjJbasEylkVdQzFQLwB47M5iNTFCep7ZXQwNl6TwEKwPrPazbSzJk4+qQymmD15H8VMI3cKV5bLhEAkrhOFEiwH2eT6TlQuyHYUo6duVeUDvPLchKhEHvag/tkKmZKj8buriapUnzY9XANDpbJKlU656VdYx2cf9LRj/663qHd543Sce8A9kBc+SEF/o5OBToVo0Roi3RB4f0K3YIgReTnUA==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 65CD7507000E1CEE
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceugffnnfdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhhnhcuffgrvhhiugcutehnghhlihhnuceouggrvhgvrdgrnhhglhhinhessggvlhhlrdhnvghtqeenucggtffrrghtthgvrhhnpeelhfevheeftefhtdevteegheejtdeifeejffduuedugeffleevheegteeugfeugeenucffohhmrghinhepvghnthhrhidrshgsnecukfhppedugedvrdduvdeirdduuddvrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddvrdeglegnpdhinhgvthepudegvddruddviedrudduvddrvdeffedpmhgrihhlfhhrohhmpegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdpnhgspghrtghpthhtohepuddupdhrtghpthhtohepffgrvhhiugdrnfgrihhghhhtseetvegfnfetuedrvefqofdprhgtphhtthhopeflrghmvghsrdeuohhtthhomhhlvgihsehhrghnshgvnhhprghrthhnvghrshhhihhprdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphht
	thhopegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdprhgtphhtthhopeguvghllhgvrhesghhmgidruggv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.49] (142.126.112.233) by cmx-torrgo002.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 65CD7507000E1CEE; Thu, 15 Feb 2024 11:51:38 -0500
Message-ID: <4723822c-2acf-4c41-899c-1e3d5659d1d8@bell.net>
Date: Thu, 15 Feb 2024 11:51:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, David Laight
 <David.Laight@ACULAB.COM>, Charlie Jenkins <charlie@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <a7e9691432374000b9566a0201d004e6@AcuMS.aculab.com>
 <c22f28a2-b042-4abe-b9e4-a925b97073bb@roeck-us.net>
From: John David Anglin <dave.anglin@bell.net>
Autocrypt: addr=dave.anglin@bell.net; keydata=
 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
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <c22f28a2-b042-4abe-b9e4-a925b97073bb@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-02-15 10:44 a.m., Guenter Roeck wrote:
> On 2/15/24 02:27, David Laight wrote:
>> ...
>>> It would be worthwhile tracking this down since there are
>>> lots of unaligned data accesses (8-byte accesses on 4-byte aligned addresses)
>>> when running the kernel in 64-bit mode.
>>
>> Hmmm....
>> For performance reasons you really don't want any of them.
>> The misaligned 64bit fields need an __attribute((aligned(4)) marker.
>>
>> If the checksum code can do them it really needs to detect
>> and handle the misalignment.
>>
>> The misaligned trap handler probably ought to contain a
>> warn_on_once() to dump stack on the first such error.
>> They can then be fixed one at a time.
>>
>
> Unaligned LDD at unwind_once+0x4a8/0x5e0
>
> Decoded:
>
> Unaligned LDD at unwind_once (arch/parisc/kernel/unwind.c:212 arch/parisc/kernel/unwind.c:243 arch/parisc/kernel/unwind.c:371 
> arch/parisc/kernel/unwind.c:445)
>
> Source:
>
> static bool pc_is_kernel_fn(unsigned long pc, void *fn)
> {
>         return (unsigned long)dereference_kernel_function_descriptor(fn) == pc;
This looks wrong to me.  Function descriptors should always be 8-byte aligned.  I think this
routine should return false if fn isn't 8-byte aligned.
> }
>
> Disassembled:
>
>  c38:   50 3c 00 00     ldd 0(r1),ret0
>  c3c:   08 1b 02 44     copy dp,r4
>  c40:   0f 80 10 da     ldd 0(ret0),r26    <--
>  c44:   37 dd 3f a1     ldo -30(sp),ret1
>  c48:   51 02 00 20     ldd 10(r8),rp
>  c4c:   e8 40 f0 00     bve,l (rp),rp
>  c50:   51 1b 00 30     ldd 18(r8),dp
>
> Hmm, interesting. See below for a possible fix. Should I submit a patch ?
>
> Thanks,
> Guenter
>
> ---
> diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
> index ab23e61a6f01..1d2aab619466 100644
> --- a/arch/parisc/kernel/entry.S
> +++ b/arch/parisc/kernel/entry.S
> @@ -772,6 +772,7 @@ ENTRY_CFI(_switch_to)
>         bv      %r0(%r2)
>         mtctl   %r25,%cr30
>
> +       .align  8
Code entry points only need 4-byte alignment.
>  ENTRY(_switch_to_ret)
>         mtctl   %r0, %cr0               /* Needed for single stepping */
>         callee_rest
> @@ -1702,6 +1703,7 @@ ENTRY_CFI(sys_rt_sigreturn_wrapper)
>         LDREG   PT_GR28(%r1),%r28  /* reload original r28 for syscall_exit */
>  ENDPROC_CFI(sys_rt_sigreturn_wrapper)
>
> +       .align 8
Ditto.
>  ENTRY(syscall_exit)
>         /* NOTE: Not all syscalls exit this way.  rt_sigreturn will exit
>          * via syscall_exit_rfi if the signal was received while the process

Dave

-- 
John David Anglin  dave.anglin@bell.net


