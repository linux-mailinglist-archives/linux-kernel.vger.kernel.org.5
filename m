Return-Path: <linux-kernel+bounces-8881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D681BDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67431F2555E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C333A634EF;
	Thu, 21 Dec 2023 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kooKke3E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DCA634E2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e4a637958so1422959e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703181236; x=1703786036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyvnsyjEDwsUuLwMHfYUDOCjkLXxDADJ3gDmnw3h4uw=;
        b=kooKke3ExWIs55KMR0sS95C5ojaPw04G7o/Ku8rr/b0D5t6O5XVMhK3gY2AqRPZx0F
         Xi9gsDW87a+bvrFGcS9FPexLLboB+zN7feG72PZ1e80s9UhOKllBC+PWapkn9BZQZZRI
         G9TB6mH+wfDbYcAvjOqAZ5BCwyPQIlkhTHTqYj7+jClty6VvLiSzdUXtapa8xw3NUczx
         ZJEMzMmeHNygs7iaClaKfrAilgha+TTI1zMan+SyENaV9TqGnI6ktLsKKlbgroiUx6W7
         qS1taynyQhDCDm2N4gGAucoRTl7Iv4tSrWBLPbfPFiVeZ39+bOAEcpifixOMtA1BFu5U
         ELxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181236; x=1703786036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyvnsyjEDwsUuLwMHfYUDOCjkLXxDADJ3gDmnw3h4uw=;
        b=F/i7k+Iuk5j0LZiKje/z7qzPN3Auk7fVmqRI1+/U09AJtjqTJ48TR1acn217kBZ2ql
         0xTv17v59T56Sm/8PyGsEewQF0bioIlXFqgLr1HFNdNRIRCtHi5I4YKiw2lZtkgEFT9W
         6dg3BtaCdN+Lb+MzEeFkx0GZzqwQu0104jhcMv6t2ZTVMWNbG5+D474TeDGyg15drcFY
         mMfaNg+xTKebMD6PoCgoRYuJ9qTT01fqFH50w5P9dG5W+Qhr74Vn2z+Bfe9iUPyQs755
         fm6ix+C9ye+9mK/aNXMtJo0AHjwbJp8gDmO9WXIRzhq0LSIT4EVSgv6/d3cjV8ZOI18v
         2+tw==
X-Gm-Message-State: AOJu0YwYyMTEFhzus+1pY3m39n3ewMbFeFO3qirO2vGmXVODU0+CBWmu
	nvioNXEWXzjgATPewbv/x9TESvazNrqrXTvz7Lve0g==
X-Google-Smtp-Source: AGHT+IE2ge4UK3B/28OyNJsYgBRrO+CoJIShGaRLGYuzONOCc/uFJ0mOz6/3Iza3du7r74b7GPBwMBxm/piGxU/FSfY=
X-Received: by 2002:a05:6512:60d:b0:50e:5e48:2282 with SMTP id
 b13-20020a056512060d00b0050e5e482282mr412065lfe.146.1703181236297; Thu, 21
 Dec 2023 09:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com> <20231220-optimize_checksum-v13-2-a73547e1cad8@rivosinc.com>
In-Reply-To: <20231220-optimize_checksum-v13-2-a73547e1cad8@rivosinc.com>
From: Evan Green <evan@rivosinc.com>
Date: Thu, 21 Dec 2023 09:53:19 -0800
Message-ID: <CALs-HstooJ5z9T_M48jwQGbxiUdL-B8eFqqsi4-6TMrMJtz7mg@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] riscv: Add static key for misaligned accesses
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, David Laight <David.Laight@aculab.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 3:37=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Support static branches depending on the value of misaligned accesses.
> This will be used by a later patch in the series. All cpus must be
> considered "fast" for this static branch to be flipped.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

You didn't pick up my tag from the last spin, so here it is again:

Reviewed-by: Evan Green <evan@rivosinc.com>

