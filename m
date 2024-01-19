Return-Path: <linux-kernel+bounces-31599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293C83309A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09FA2875A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EF258AA9;
	Fri, 19 Jan 2024 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nkRgJE94"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719535465E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701823; cv=none; b=Exm5mG6G4CAQWZdqseQcHHluP9knaP7NrUNt21yNzh7M9GSj0RDN2hOObzomSRKaIGDGVUy4tJa1TyPTFt+09hzKmOhQT6TdpsdUqLct+fKOqvu3HVFx2Zyy2Z29O+zUwp3PhBnELh07btoT7OsQs0wCi7ZqPbQLic4fE5GM0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701823; c=relaxed/simple;
	bh=UK0vew5OPvSZbMAryrGZG51aWIjGOLTwWnU0d+JZhpc=;
	h=Date:Subject:In-Reply-To:Message-ID:Mime-Version:Content-Type:CC:
	 From:To; b=jMHl+WAyv5H8fSa2El/dHHezqL16WJiZYRseonn0LSxBSn/T25SriHcdzuqbFsfKKf6ikQ7SjnsA2tMUrznGSuXr1cD2LKREMGrmv6OMZyzrXFo+CDva9VZ/O297kM1pv911nDKEPHttaFGw8ohFKv/oWWgRtU3hhyMEC8BjUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nkRgJE94; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28b6218d102so1090175a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705701822; x=1706306622; darn=vger.kernel.org;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aaVzBMeeZblMbEUbDFmZomg/HzP8H1Gn+gnGtwevNs=;
        b=nkRgJE94OGEwBbf4XFDE7WCcKD26VaPWlMlNvY+ay0pGa++pwg7ENvD/7Ejd69vmd2
         4dfLVOC8FzQ/a/4fw3JNU4d0gNBKV7z+n2hFYmNO+M/q81/ZbVC4+t8fX4MIfiKSN/Tg
         YN+0J5Y3T8CehtTZUD3GfZRuOz+bL8otbsL5UJ5vg5PV/JYn5rhhL6xTcQo+HmIKPVFx
         y7hSNYNXF8juGB9DgrJUFlXNePF1vHmSKVhG6Iv0kyHGCG14gc3vChQ6PQgsd4FO/HkH
         6Td/hBLVKwZKxXefoNpSv2Ub1iIhq0EEVReEQkNmmI4zVyJ+ZEldKn+smkySa3ivZqOE
         h5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701822; x=1706306622;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aaVzBMeeZblMbEUbDFmZomg/HzP8H1Gn+gnGtwevNs=;
        b=AbIS59iYjbqrMFN/V1mi6WRbwMZLSf4hrDCU3D3aIhvPtSHPM061KOdpBPWsubOIhm
         CmRnhCdrgyrzbX6KEuf2eyEku/xJrf6AH9jUStMtLOo6Q32PBLCM+dkAVPHtmZ3xiXt3
         GdJpXNq+iCxPWFL20CLsr12/uEmtLD7hNknxxdrt4kjKofusalSqpiKgklGaFsxtOJnw
         ZXl4enQUVDwV0jpTl+9S9UrgkzQMvt483YUz4ZeVmj0R9vrkjLCo4smcM7qmaemhg5Z4
         Rr9t7pn6HO2eUtx8XM8WEZe1ksrNT2yKY+Zm7Qa96K0+uYdaArcXfBdzk6gFUZ8CadWu
         izwQ==
X-Gm-Message-State: AOJu0Ywdwl5xghGgIpKYHeuPwYjQ/s+dR3dOow5N2sEkDn2uEhjL8sqR
	f2oY4NuCigDTApZb6Md+EVJU2q8OmJrLR2gT2DuK0zNZLFT6pc34nljPoIw4dDI=
X-Google-Smtp-Source: AGHT+IGftZP2Jl+VwJV08AVdkfiAwWPWCiEg5yYwDaS6Y+0pO5wM+PStwOKVnAiNRaDx+cdEX7oaxg==
X-Received: by 2002:a17:90b:30c6:b0:28f:f70f:ee60 with SMTP id hi6-20020a17090b30c600b0028ff70fee60mr415981pjb.8.1705701821779;
        Fri, 19 Jan 2024 14:03:41 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id e16-20020a170902cf5000b001d5c38bfa33sm3486111plg.307.2024.01.19.14.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 14:03:41 -0800 (PST)
Date: Fri, 19 Jan 2024 14:03:41 -0800 (PST)
X-Google-Original-Date: Fri, 19 Jan 2024 14:03:11 PST (-0800)
Subject:     Re: [PATCH] tty: hvc: Fix the RISC-V SBI driver for a refactoring
In-Reply-To: <20240119215612.20529-2-palmer@rivosinc.com>
Message-ID: <mhng-dd8222be-f59f-4422-8cf5-dbefccf63f5f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
CC: linux-riscv@lists.infradead.org, Greg KH <gregkh@linuxfoundation.org>,
  jirislaby@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  ajones@ventanamicro.com, Atish Patra <atishp@rivosinc.com>, apatel@ventanamicro.com,
  linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
  linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Palmer Dabbelt <palmer@rivosinc.com>

On Fri, 19 Jan 2024 13:56:13 PST (-0800), Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> I missed the int->size_t refactoring in f32fcbedbe92 ("tty: hvc: convert
> to u8 and size_t"), which causes the newly used ops in 88ead68e764c
> ("tty: Add SBI debug console support to HVC SBI driver") to fail to
> build due to a
>
> linux/drivers/tty/hvc/hvc_riscv_sbi.c:59:15: error: incompatible function pointer types initializing 'ssize_t (*)(uint32_t, const u8 *, size_t)' (aka 'long (*)(unsigned int, const unsigned char *, unsigned long)') with an expression of type 'int (uint32_t, const char *, int)' (aka 'int (unsigned int, const char *, int)') [-Wincompatible-function-pointer-types]
>         .put_chars = hvc_sbi_dbcn_tty_put,
>
> Fixes: f32fcbedbe92 ("tty: hvc: convert to u8 and size_t")
> Fixes: 88ead68e764c ("tty: Add SBI debug console support to HVC SBI driver")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I now remember Anup pointing this one out, but looks like I forgot about
> it.
> ---
>  drivers/tty/hvc/hvc_riscv_sbi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/hvc/hvc_riscv_sbi.c b/drivers/tty/hvc/hvc_riscv_sbi.c
> index 2f3571f17ecd..c08718be8e73 100644
> --- a/drivers/tty/hvc/hvc_riscv_sbi.c
> +++ b/drivers/tty/hvc/hvc_riscv_sbi.c
> @@ -15,7 +15,7 @@
>
>  #include "hvc_console.h"
>
> -static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
> +static size_t hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)

I got a little lost in my branches here, that should be "ssize_t".  I'll 
send a v2 when I figure out why my tester is acting oddly...

>  {
>  	int i;
>
> @@ -25,7 +25,7 @@ static int hvc_sbi_tty_put(uint32_t vtermno, const char *buf, int count)
>  	return i;
>  }
>
> -static int hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
> +static size_t hvc_sbi_tty_get(uint32_t vtermno, char *buf, int count)
>  {
>  	int i, c;

