Return-Path: <linux-kernel+bounces-16499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2945A823F62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49871C23A3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C9F20B11;
	Thu,  4 Jan 2024 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YwVG3JKn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B920B16
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d4414ec9c7so1829935ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704363827; x=1704968627; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzj3uOoh7PY5cR2xiJEt6lV6u8Aid8p6M7e8NclCE5I=;
        b=YwVG3JKnHRc8p8CiyZR1KfoHtB1sx6i0vEnH4rCCfUJao2PMuxJymH+W8g/Hd18py8
         2m9Ead/AIM9ZvIXTDAZWvgxh+0X9+bqR+4rqejKp0E96vJNBHIjRAWT+DcrRAiiWgd/t
         De3wHSVVbD5PZvyP4UxfhpBYqDWwdIoMcGmrY/D8jWJdU2z7zHc7Ktg6pC+Vs9TdUiLE
         bQRO6vWOTbWUUuacGYiz809b47+Alydft5q79s1D3POtMspnaDSoewIr8n+Hl32aSDbp
         nQAPNi4BbDWtyrrTBUz4oYHXpes+l9YFKjrzG8UbLYIg/wNr1AZ6uGPK8FMDYgBztPPo
         Ub4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704363827; x=1704968627;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzj3uOoh7PY5cR2xiJEt6lV6u8Aid8p6M7e8NclCE5I=;
        b=wC2kLTVEycQnOXalkKwTmEpKkWzZ6c5y6lm0zLgHI77pkaJg0xIHIBGwV/Lr9giWMc
         W1QwTpXcaBWKVkKBdAoZY2Sh9edIgsWxlga4HPm4+79BPtDk9iWbCGp4eE2aYG2JQ8mg
         CcDihKElHGkv2ZpR0Amxgj8Jb9a3jS1kDhPiDJXfViNjkCTNhHPSfNhK2kp4oMjJDVHI
         W70TlPcMiWeZu/ZfJGlEOWxneAHAMfDHPsLrwwGRL6u0n6qkZkGqpdzdDh3jHPCJtRvs
         afaSAOG2sSyGLnrxMUjTn67S2/tnn1BPta3D7OFe+ApBaG7qYug+SFhPZIIZYxOp0ekR
         gSlQ==
X-Gm-Message-State: AOJu0YxB4Rs9WB3bDUHz8HOo18DcNiYt5Mae//88pyLzKkNlVgBSndzX
	sigkRysJpJKuv4oXfec5fIDYmUsXEBuSTg==
X-Google-Smtp-Source: AGHT+IE+t/XnCgDoBmaNVOzJvr5a20jeY5tCq+x0APnt3WaHMTvvUZamnKncxOPcQZIME1UjYVniQw==
X-Received: by 2002:a17:902:a3cc:b0:1d3:9287:a1a9 with SMTP id q12-20020a170902a3cc00b001d39287a1a9mr277038plb.57.1704363826793;
        Thu, 04 Jan 2024 02:23:46 -0800 (PST)
Received: from ?IPv6:2402:7500:5d5:7102:b5d6:a469:295a:6de5? ([2402:7500:5d5:7102:b5d6:a469:295a:6de5])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001bbb8d5166bsm25489720plw.123.2024.01.04.02.23.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 02:23:46 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [RFC PATCH 00/13] RISC-V crypto with reworked asm files
From: Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20240103143557.GA773@quark.localdomain>
Date: Thu, 4 Jan 2024 18:23:42 +0800
Cc: Ard Biesheuvel <ardb@kernel.org>,
 linux-crypto@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>,
 Phoebe Chen <phoebe.chen@sifive.com>,
 hongrong.hsu@sifive.com,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Andy Chiu <andy.chiu@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20EF7A6D-19AE-49C0-982F-8FE7733E375A@sifive.com>
References: <20240102064743.220490-1-ebiggers@kernel.org>
 <CAMj1kXEAqxCZ_PNM9a=CyciSHUzDU_yqemKh51oncHyLbYUKtA@mail.gmail.com>
 <20240103143557.GA773@quark.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)

On Jan 3, 2024, at 22:35, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, Jan 03, 2024 at 03:00:29PM +0100, Ard Biesheuvel wrote:
>> On Tue, 2 Jan 2024 at 07:50, Eric Biggers <ebiggers@kernel.org> =
wrote:
>>>=20
>>> As discussed previously, the proposed use of the so-called perlasm =
for
>>> the RISC-V crypto assembly files makes them difficult to read, and =
these
>>> files have some other issues such extensively duplicating source =
code
>>> for the different AES key lengths and for the unrolled hash =
functions.
>>> There is/was a desire to share code with OpenSSL, but many of the =
files
>>> have already diverged significantly; also, for most of the =
algorithms
>>> the source code can be quite short anyway, due to the native support =
for
>>> them in the RISC-V vector crypto extensions combined with the way =
the
>>> RISC-V vector extension naturally scales to arbitrary vector =
lengths.
>>>=20
>>> Since we're still waiting for prerequisite patches to be merged =
anyway,
>>> we have a bit more time to get this cleaned up properly.  So I've =
had a
>>> go at cleaning up the patchset to use standard .S files, with the =
code
>>> duplication fixed.  I also made some tweaks to make the different
>>> algorithms consistent with each other and with what exists in the =
kernel

Do you mean the xts gluing part only? Do we have the different =
algorithms
for the actual implementation in .S?=20

>>> already for other architectures, and tried to improve comments.

The improved comments are better. Thanks.

>>> The result is this series, which passes all tests and is about 2400
>>> lines shorter than the latest version with the perlasm
>>> =
(https://lore.kernel.org/linux-crypto/20231231152743.6304-1-jerry.shih@sif=
ive.com/).

For the unrolled hash functions case(sha256/512), the .S implementation =
uses
macro instead. But I think the macro expanded code will be the same. Do =
we
care about the source code size instead of the final binary code size?

For the AES variants part, the .S uses branches inside the inner loop. =
Does the
branch inside the inner loop better than the bigger code size?

>>> All the same functionality and general optimizations are still =
included,
>>> except for some minor optimizations in XTS that I dropped since it's =
not
>>> clear they are worth the complexity.  (Note that almost all users of =
XTS
>>> in the kernel only use it with block-aligned messages, so it's not =
very
>>> important to optimize the ciphertext stealing case.)

The aesni/neon are SIMD, so I think the rvv version could have the =
different
design. And I think my implementation is very similar to x86-xts except =
the
tail block numbers for ciphertext stealing case.
The x86-xts-like implementation uses the fixed 2 block for the =
ciphertext
stealing case.

+		int xts_blocks =3D DIV_ROUND_UP(req->cryptlen,
+					      AES_BLOCK_SIZE) - 2;

>>> I'd appreciate people's thoughts on this series.  Jerry, I hope I'm =
not
>>> stepping on your toes too much here, but I think there are some big
>>> improvements here.
>>>=20
>>=20
>> As I have indicated before, I fully agree with Eric here that =
avoiding
>> perlasm is preferable: sharing code with OpenSSL is great if we can
>> simply adopt the exact same code (and track OpenSSL as its upstream)
>> but this never really worked that well for skciphers, due to API
>> differences. (The SHA transforms can be reused a bit more easily)

In my opinion, I would prefer the perlasm with the usage of asm =
mnemonics.
I could see the expanded asm source from perlsm. I don't know how to =
dump the
expanded asm source when we use asm `.macro` directives. I use objdump =
to
see the final asm.
And we could use function to modularize the asm implementations. The =
macro
might do the same things, but it's more clear for me for the argument =
passing
and more powerful string manipulation.
And I could have scope for the register name binding. It's more clear to =
me
comparing with a long list of `#define xxx`.

If the pure .S is still more preferable in kernel, let's do that.

-Jerry

>> I will also note that perlasm is not as useful for RISC-V as it is =
for
>> other architectures: in OpenSSL, perlasm is also used to abstract
>> differences in calling conventions between, e.g., x86_64 on Linux vs
>> Windows, or to support building with outdated [proprietary]
>> toolchains.
>>=20
>> I do wonder if we could also use .req directives for register aliases
>> instead of CPP defines? It shouldn't matter for working code, but the
>> diagnostics tend to be a bit more useful if the aliases are visible =
to
>> the assembler.
>=20
> .req unfortunately isn't an option since it is specific to AArch64 and =
ARM
> assembly.  So we have to use #defines like x86 does.  Ultimately, the =
effect is
> about the same.
>=20
> - Eric


