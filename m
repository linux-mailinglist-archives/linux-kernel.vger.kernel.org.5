Return-Path: <linux-kernel+bounces-16394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C790823DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1912833DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EBE1E536;
	Thu,  4 Jan 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ibV8KN5Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEEC1E502
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso205830a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704358041; x=1704962841; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgfsQLNdDzo7kWKLxPEqtg86d6gRnxnHrr+F4939nWk=;
        b=ibV8KN5ZwQHCtG47ERLtCC2HtP4zF4RXNzxfeuMsco0zFe5lciO/s2phps8sRVaWlU
         pRd7Ve6y/1nb+xtdrhdgFljePfYAwkKc1ZzA2BTOnVX+8irimWTqvrNCFpMoZOAC6cZa
         +tOIbMG1jnhDL9BwTVAeXK5Ic+5I0Ad6mUIGQgAb1QncyYyjsiOZ4K3Id9bhbg26DLqI
         q8WeaqsHfgEJ3F8R4NFXVGottY4RSL+HRxJnoQkTi3PmVOxVtV1Vkf33LMlrx8D3cRxU
         metc8yvPmMj9S2tq70uHnoZGiaY+XVKlCHYT4yd10R77KMn40uxu/VgBB/nM0UycLgeZ
         r6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704358041; x=1704962841;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgfsQLNdDzo7kWKLxPEqtg86d6gRnxnHrr+F4939nWk=;
        b=qhkd1qj7nIcyC/yYwxHJ9PF4xRs+82GLDmi+HA9qfnYxAXHtWz8hlSsNPlOIXDyMOX
         G7vQyYpNvr8ofzjkvAjxLIWvXk6dbK27RnkIfo9FD1+weobQB91/b0NPfoisYM30HETr
         HC1ToP1gPjkYfCKApxX0AFS6KMu+QY1Ba9yzn1kKYOWDZ8Lp06zbyzteoPsC1N8y0/1V
         3o+SVMBCnYkzDke1n7Yg2uB1JSgsWF7WooQX+hAdRgSXgdJAW7n4vB0G6UkJ36vx8FSd
         wdY4nkrk2gGJDSiLsh4rK4Wy5DprkS4Ch5pyBNYZyMxkfSyOhiPrryUzSvEOz85qco08
         tGUg==
X-Gm-Message-State: AOJu0Yyy142jElnf5LR/qMKwabSIxu8rEtzWYzCdt7mfcBOKM4KRiOE/
	WziUAmDdzMDthMyh7RWCRkKylTKQguBxtQ==
X-Google-Smtp-Source: AGHT+IG/sBRaenKqK4e/aSWU0CPcqduNWKUOpDd7nVy3analENwFGwddoXVDN4ch5A9tbYfXUAIt7w==
X-Received: by 2002:a05:6a20:974b:b0:198:60af:20a5 with SMTP id hs11-20020a056a20974b00b0019860af20a5mr171949pzc.88.1704358040679;
        Thu, 04 Jan 2024 00:47:20 -0800 (PST)
Received: from ?IPv6:2402:7500:5d5:7102:b5d6:a469:295a:6de5? ([2402:7500:5d5:7102:b5d6:a469:295a:6de5])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e5c300b001d3ee84ef0csm25107555plf.235.2024.01.04.00.47.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2024 00:47:20 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [RFC PATCH 07/13] crypto: riscv - add vector crypto accelerated
 AES-{ECB,CBC,CTR,XTS}
From: Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20240103145043.GB773@quark.localdomain>
Date: Thu, 4 Jan 2024 16:47:16 +0800
Cc: linux-crypto@vger.kernel.org,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Phoebe Chen <phoebe.chen@sifive.com>,
 hongrong.hsu@sifive.com,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Andy Chiu <andy.chiu@sifive.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <905D43CF-B01A-49DE-9046-51A370B6F680@sifive.com>
References: <20240102064743.220490-1-ebiggers@kernel.org>
 <20240102064743.220490-8-ebiggers@kernel.org>
 <20240103145043.GB773@quark.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)

On Jan 3, 2024, at 22:50, Eric Biggers <ebiggers@kernel.org> wrote:
> On Tue, Jan 02, 2024 at 12:47:33AM -0600, Eric Biggers wrote:
>> diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
>> index dca698c5cba3e..5dd91f34f0d52 100644
>> --- a/arch/riscv/crypto/Makefile
>> +++ b/arch/riscv/crypto/Makefile
>> @@ -1,7 +1,10 @@
>> # SPDX-License-Identifier: GPL-2.0-only
>> #
>> # linux/arch/riscv/crypto/Makefile
>> #
>>=20
>> obj-$(CONFIG_CRYPTO_AES_RISCV64) +=3D aes-riscv64.o
>> aes-riscv64-y :=3D aes-riscv64-glue.o aes-riscv64-zvkned.o
>> +
>> +obj-$(CONFIG_CRYPTO_AES_BLOCK_RISCV64) +=3D aes-block-riscv64.o
>> +aes-block-riscv64-y :=3D aes-riscv64-block-mode-glue.o =
aes-riscv64-zvkned-zvbb-zvkg.o aes-riscv64-zvkned-zvkb.o
>=20
> A bug I noticed (which is also present in Jerry's patchset) is that =
some of the
> code of the aes-block-riscv64 module is located in =
aes-riscv64-zvkned.S, which
> isn't built into that module but rather into aes-riscv64.  This causes =
a build
> error when both CONFIG_CRYPTO_AES_RISCV64 and =
CONFIG_CRYPTO_AES_BLOCK_RISCV64
> are set to 'm':
>=20
>    ERROR: modpost: "aes_cbc_decrypt_zvkned" =
[arch/riscv/crypto/aes-block-riscv64.ko] undefined!
>    ERROR: modpost: "aes_ecb_decrypt_zvkned" =
[arch/riscv/crypto/aes-block-riscv64.ko] undefined!
>    ERROR: modpost: "aes_cbc_encrypt_zvkned" =
[arch/riscv/crypto/aes-block-riscv64.ko] undefined!
>    ERROR: modpost: "aes_ecb_encrypt_zvkned" =
[arch/riscv/crypto/aes-block-riscv64.ko] undefined!
>=20
> To fix this, I think we should just merge the two modules and kconfig =
options
> together so that there is one module that provides both the AES modes =
and the
> AES single-block cipher.  That's how x86's aesni-intel works, for =
example.
>=20
> - Eric

That's a bug in my patchset.
I don't test with all options with `M` settings since I can't boot to =
qemu with all `M` settings.

Could we move the cbc and ecb from `aes-riscv64-zvkned` to =
`aes-block-riscv64` instead of merging
these two modules?
Thus, we could still enable the single aes block cipher without other =
extensions(e.g. zvbb or zvkg).

-Jerry=

