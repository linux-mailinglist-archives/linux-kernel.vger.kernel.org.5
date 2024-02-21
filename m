Return-Path: <linux-kernel+bounces-74840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C598385DD18
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577651F22AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C187D3EE;
	Wed, 21 Feb 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="us5Brw62"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC33D981
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524066; cv=none; b=TuYLX6Wl5QfvAY4+DPE5FoeVMBmsqqT1u34eCXOdwGjTrS4f9kWwVUq58/nAmNom9u6wSlAztMsOGmyi9FW+/iagwx/HRd3V+ssEmhbY5tKAcUxtuQJQg6nt+tPQKmD/sZYxlFcAyk8Xxw3Z4z5Qn2sdkixNlPQjk2pubQQiizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524066; c=relaxed/simple;
	bh=FPP3uUJFP9oNt+uTsDguz9FxvQhJanBcuxpCpbn+k40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmpD+CnlHzjv36R3g33aEMAaZ8toHIMQ99d8uljJCnXFuBdEN0QRAMjMjqDWyCVXY3Vs3RM4M48zqxBdNi9sQvDnPrwJfDhLhL4qQoERJ2plqVA9Uyyma8hWwhk4rvR9aM3y5+2rBV3oCJEP4qDOfzUW01nnF6/PuOIrC8P86/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=us5Brw62; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2a17f3217aso896649266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708524063; x=1709128863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3caPR64aW0Svj0ZX8QTL9rwtxXC0T3Jv42aHF/VUGoU=;
        b=us5Brw62JqZXeyFBVzHVERfCpAD2vikuRBTdoPLw3TxBtccsWpyUcVObeDib4hXmUN
         MMrsrYULvPkkT4xgAWVunBHqjCWwf/Kmank5NkErY2BszS6Tk+3ZDF0SkBC3Lhhk7G7f
         IBiEBKkuaGddPLZjKpOIfA/TMCW9bZLn9vK/B7H9Fc5F2WRPNdRq6rfsRIM76Hala7Yb
         3HAPGageT3TnUVHFm6hukgrM32azslTh3pEe/H60bRgy6TAdmRrHm9tXI/Ogy1ClEw0U
         3aFv9iqVYPU/qehoGhpCvSlJeSPS+/PgAzUby8cFgdjZJte2Jkckwev78OtPyjJ1axu6
         Skeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708524063; x=1709128863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3caPR64aW0Svj0ZX8QTL9rwtxXC0T3Jv42aHF/VUGoU=;
        b=OsS6KiJ2zknCkeUk8fK/BvxRuklgYmkoT8BE3YuXNXYI/58Q8K6YO3QEYCb4Zv/Ww5
         LgR+h2t0u3pPPlAoiLfhN6rFqYHNSBNcRGyZIV84GK8w35PM4cfvoxp7ZLNMfYdvFXyc
         k47XQZeH9Rb4vP3TC9er8KdUoEPfo330B09+M585518p1IFrWpfmwKhG9dEOBVYYk6OM
         /pml7rjkGQRNOMbbdFERl8uZLVpoIkkwMnnYSS7JElY70afyXMIxEhAjZeXOcms1aQau
         IcLh8cRH2DOuurmlHMghb6ofj0J09C9uuI86VVUREt4M86srUhlZNqsXIcX7kRsqvSKj
         fmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWzWHDFKB+2f1U9xUczWFCXbURoDukfm3e9Bi300K96rUDgm3WjmHzgVc2J0bOJhHbSFIqkLPjssUElL4wzGkHFRJZmh+NDjnf4yR7
X-Gm-Message-State: AOJu0Yw9G1o9J3zOKEZ/AOVqaFeLLJdPImM8y9BFjjiromScMwfRvGdv
	Nw4BQ+zudWzOQtTbRLdndy+CspGWuJZ3dV0fJv1ZsB6/pSgsbFICA4Vy27fc1C8FTF/6hnGs169
	bxghY8m1YMSU09cg8a+5GJWVOq8/4FYjkl9kAWw==
X-Google-Smtp-Source: AGHT+IGWq07YBN/0D1Kwd3+FXXv8z5twwI8IjTPKU5ChXbfb9HGU6ARHkKhT7hS7EdZH4WB7xJFXUbF27VM8Q1T7lzc=
X-Received: by 2002:a17:906:b0d9:b0:a3d:2e0e:3f52 with SMTP id
 bk25-20020a170906b0d900b00a3d2e0e3f52mr13650667ejb.37.1708524062956; Wed, 21
 Feb 2024 06:01:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_E19FA1A095768063102E654C6FC858A32F06@qq.com>
In-Reply-To: <tencent_E19FA1A095768063102E654C6FC858A32F06@qq.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 21 Feb 2024 15:00:49 +0100
Message-ID: <CAHVXubg8NKBdeutbwrJh5hdZwhRFsgyTPknM=xUhV=VG+o2Lrw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: fix NOCACHE_THEAD does not set bit[61] correctly
To: Yangyu Chen <cyy@cyyself.name>
Cc: linux-riscv@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yangyu,

On Wed, Feb 21, 2024 at 4:04=E2=80=AFAM Yangyu Chen <cyy@cyyself.name> wrot=
e:
>
> Previous commit dbfbda3bd6bf ("riscv: mm: update T-Head memory type
> definitions") from patch [1] missed a `<` for bit shifting, result in
> bit(61) does not set in _PAGE_NOCACHE_THEAD and leaves bit(0) set instead=
.
> This patch get this fixed.
>
> Changes since v1:
> * reword commit message and add reviewed-by
>
> Link: https://lore.kernel.org/linux-riscv/20230912072510.2510-1-jszhang@k=
ernel.org/ [1]
> Fixes: dbfbda3bd6bf ("riscv: mm: update T-Head memory type definitions")
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/pgtable-64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm=
/pgtable-64.h
> index b42017d76924..b99bd66107a6 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -136,7 +136,7 @@ enum napot_cont_order {
>   * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareab=
le, Non-trustable
>   */
>  #define _PAGE_PMA_THEAD                ((1UL << 62) | (1UL << 61) | (1UL=
 << 60))
> -#define _PAGE_NOCACHE_THEAD    ((1UL < 61) | (1UL << 60))
> +#define _PAGE_NOCACHE_THEAD    ((1UL << 61) | (1UL << 60))
>  #define _PAGE_IO_THEAD         ((1UL << 63) | (1UL << 60))
>  #define _PAGE_MTMASK_THEAD     (_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL =
<< 59))
>
> --
> 2.43.0
>

I feel pretty confident on this one :)

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

