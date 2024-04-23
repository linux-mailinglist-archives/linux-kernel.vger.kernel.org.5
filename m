Return-Path: <linux-kernel+bounces-155093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5528AE539
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73931F240E5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB40136672;
	Tue, 23 Apr 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="kKHE9Cki"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C985298
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872744; cv=none; b=PjNr47d6AAEflsDgV3lgmjF4s64jnTPF2opC/3XbWNspersxLbfRiUDdS3BbKHrqsXny21JHI4Zq8Sh9pccLtaPYf8VVH52qyvDU0+JWKaUf4z7/t96ulDZnmw2Odq4a7dBf5zX5qw7u1DKgNahO+OSOYRuoq1d6C17CE4w0dcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872744; c=relaxed/simple;
	bh=O0Ua43dYlU3Ikmubwkdm30RvMrIaRpbJc+vhrHYu4Js=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tLA1XjI1ELlOU+JOFDNXSbf+0zjBjfZ763MJjoPDAWKD6WFcaMcGT+SRlPLrCJxIWaQUvDlul3nErMtMDM+jNMzBWXYbvV6hdHG0Lx2RYUOChnd4B48foEKHQ3D/5pXQ7FuBA1YYNBmC3ywO2uAM2psHrVt8UKAy2+SU21M4baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=kKHE9Cki; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db2f6cb312so96548091fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713872741; x=1714477541; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0Ua43dYlU3Ikmubwkdm30RvMrIaRpbJc+vhrHYu4Js=;
        b=kKHE9CkiIkYm3NovvRSadFDbG0XsnjNGU3tHYWR4WTm6i2SSUTGFARC3L7zPiaw6EN
         g0acvT2DV1VdpKTi6BI2QS1xNJVBBC2+NvJDhwczdj2lvUzGrNHuH9qOz8Ac8YkoKOoK
         jM7B6Mxo3FYZbbNO/sr0JgFk/H0e/ck4013VWWIjJBqGwXDSermP6IuTV1tk7rfqXY1o
         sPaymHFVsKJbCIaz+fRQuXAyTtsaInTXOOeGdDsdpoCJbG7+iWA2tyKVK9H0mToXVJwh
         NxK0wCFMsewJqJkEgJ++BEqB9ceFTXF6p3kYme3Xgrwi1tXchvbmRkgMFXMhtWRp+YkT
         eeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713872741; x=1714477541;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0Ua43dYlU3Ikmubwkdm30RvMrIaRpbJc+vhrHYu4Js=;
        b=NS+yw5utVzGx60DU2LP07fHytLarr7ysXBUJHvmOQyFcThkmb18gdej36SziWuZ3KY
         WvGLCn1dCNdFfpVF3QaXs78m4YAWvT1NcLxY1Ao312H5N02NbecGJEUJm/fDZjSrUlxy
         3o3U0jYqarKbt60GBXUA5W2crrCvs/pB0C3qYk8XrHOU/O8xgHH0V6uttnHnYo/SJcO6
         0O6+DS6/4kFQ5vZ1drx+e3a3Y2/SRG4kHu6JPE5u6r1GulZtx+yrG8wRiEJsvj+u/otJ
         XkPval3d8GfK95HBi5T7WhqMPOyzBXVw+WK5nG+XMhtHBVxokuzvrL9djSi9YGTjNbd2
         sptw==
X-Forwarded-Encrypted: i=1; AJvYcCXe3SUghgWuIYTwz6dViAv0KDkqLYIgGUeIypVRmkNOrGwGmL3HU2rkFZILVUsvmet1MItV/1qGaHIX1GRkZNu5fvzrMlWQc3PI+AN3
X-Gm-Message-State: AOJu0Yy3/7O+Y/lo7yqSKIUpBTdjhc4wmRT1nLlFL/uJB09M1WhYoKdU
	2n9oGyVn0oR+OKM6FG+AUSD4hlMgSSwpdhW6UofGExtKBj1bvl0gnX446BHq5nc=
X-Google-Smtp-Source: AGHT+IG6hD66WTu1eXwjYXPCnj4l8sUZ4QxkH2aVMHHNRvb0x1iRwoIbqOz56UcaiKLV7da4Xc1VNw==
X-Received: by 2002:a2e:a26a:0:b0:2d6:f5c6:e5a1 with SMTP id k10-20020a2ea26a000000b002d6f5c6e5a1mr9602485ljm.12.1713872740655;
        Tue, 23 Apr 2024 04:45:40 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:dd69:e1e7:9a09:9d7e])
        by smtp.gmail.com with ESMTPSA id bi10-20020a170906a24a00b00a54c12de34dsm6918479ejb.188.2024.04.23.04.45.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2024 04:45:40 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] bitops: Change function return types from long to int
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <e7e4ff27-ebb3-4ed6-a7cc-36c36ab90a36@app.fastmail.com>
Date: Tue, 23 Apr 2024 13:45:28 +0200
Cc: =?utf-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
 Xiao W Wang <xiao.w.wang@intel.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Youling Tang <tangyouling@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Jinyang He <hejinyang@loongson.cn>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <99B58F85-CC9C-49F6-9A34-B8A59CABE162@toblux.com>
References: <20240420223836.241472-1-thorsten.blum@toblux.com>
 <42e6a510-9000-44a4-b6bf-2bca9cf74d5e@linux.intel.com>
 <C0856D2E-53FF-45EB-B0F9-D4F836C7222C@toblux.com>
 <e7e4ff27-ebb3-4ed6-a7cc-36c36ab90a36@app.fastmail.com>
To: Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 22. Apr 2024, at 17:55, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Apr 22, 2024, at 16:30, Thorsten Blum wrote:
>> On 22. Apr 2024, at 09:44, Amadeusz S=C5=82awi=C5=84ski=20
>> <amadeuszx.slawinski@linux.intel.com> wrote:
>>>=20
>>> I don't mind the idea, but in the past I've send some patches trying =
to align some arch specific implementations with asm-generic ones. Now =
you are changing only asm-generic implementation and leaving arch =
specific ones untouched (that's probably why you see no size change on =
some of them).
>>=20
>> I would submit architecture-specific changes in another patch set to =
keep it
>> simple and to be able to review each arch separately.
>=20
> I can generally merge such a series with architecture specific
> changes through the asm-generic tree, with the appropriate Acks
> from the maintainers.

Ok.

I would still prefer to keep this patch free from arch-specific changes, =
if
possible. The patch improves architectures that use the generic bitops
functions (e.g., arm64) and doesn't impact any arch-specific =
implementations,
unless I'm missing something.

Thanks,
Thorsten=

