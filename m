Return-Path: <linux-kernel+bounces-157641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D08B13F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578A4B2335C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B113BC3A;
	Wed, 24 Apr 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="u3Q+58yw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED00134A8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988936; cv=none; b=FD/g6cr626fnynRFLlWteOrjcj3ymPdBAmwy+0nqSa3LHqi4KJ/lIR+T6sVYPuTv5cbtmi22pcky2qI/wflm8Z0e/9UYScFhQr8CGiOFvlyyV7ayoJjn8yIFgWiBlGYuViRXyDWddq5SDHUWx8wMSuLAWc7Off/4KtXTvXa9n0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988936; c=relaxed/simple;
	bh=H4HkkCTbSA5vhrIKwhTMNVFt+//Ey1JqqJ5X/M3mkag=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=WtJYBTJGR+B/3gzB5KfjYtf9j1XQKCK23TloFpp4i2suPZbrSMEqynM9ZzfPsB+HVmJkx2GewgP4XqLrT6Zl5DPt0udzQGhbDQn/EEGYx5Bh5dOOz2EswBQeygVMuzxklPwecQSQK7JCBQBgPz3sXCd7PZg1OlBRJXBcGrptG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=u3Q+58yw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2c725e234so11136925ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1713988933; x=1714593733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PMiKR4aPVvVW83OfyGhFvZRNug52G2rTKzNtFX0PpY=;
        b=u3Q+58ywzyORoCqQSIswQ4WU8dHxlqXgI+1brWcoexTlALMp1NjBh+azeafUTkXitL
         kzcgRqFziEmFGStYTik6Z6cEI1D6JKJ0dbSZA++iHbgVLFcXSDlFn6nYvRCG5aZebj7M
         b5MiMYkoAB37wft6+4/lzkpf0NEjYv66HS/40fHSAhWS1tLnDrxG9OoZuX6+u2bWx9TL
         R1g7oI2+G2I+IicozGowa+kwCEyJ04k9C2xVXjiojT4XUbasLu2BduQmXrso0rwJMf2p
         cXGGmTWk9Yu+BbaOZgRpttjXQO1qj/0yCO9IUb83aLHhBnvHEWoXT5QqN0LQROniuamo
         8Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713988933; x=1714593733;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PMiKR4aPVvVW83OfyGhFvZRNug52G2rTKzNtFX0PpY=;
        b=CTBDR1zLA4icB6rj7nRmrI4MLW9RCSHqsTTjhPFFAi4sVdEarMI1EJW+G9xOCa0o1I
         1jwPWaP7vmw1XbXrDnZjQ4kTPO2Z0YSjZmfWOCgtgoCJwoC76tHdkiC9oezWkKsKj2vl
         sIrAIeYANribfnPQu6JUYGZO07L4r+1/xmTj4xMfuEO7BBZuBWHr743fwdr6C3xf4357
         cP2GE2lh+Qih9SznzufNanViDGIkUGjGGTtab4LBYwEAQTGYO/awaYMy77xnjamCXGFr
         e43JVQZPvbbFOcJIw+kb7Avgv8L5JKiyNlWgGJkWOtmkvIfpPa6neC2tYS6jPWNHjPKJ
         EH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU13XwCqLdz+2fkJNtkTVL0aRc4H76WXrNHX52vb2xHaOmA4oQkFNLNd8t+fB1iym1y5KqRhVHPLasjXCNO/HQUEuh9jFHEhB27+Iyd
X-Gm-Message-State: AOJu0YzQhnVJ0ljAim2txXgBE1OETGroGKTveqtQCleLiJAJbjJ91dHD
	YYaDNBhIJqMpz7J6DctXZdIdm38+Kg8DtodeKtb7thzkGeSt/MUkRGSKC83Xl4A=
X-Google-Smtp-Source: AGHT+IGNe7+hcCK2Yu7QzpuHAbzpCXHusHTOSP45V5t7RI6OE+y2MTETWng8kTxcKbvrNI+OJ4e74A==
X-Received: by 2002:a17:903:124f:b0:1e5:c131:ca0e with SMTP id u15-20020a170903124f00b001e5c131ca0emr1130620plh.6.1713988933046;
        Wed, 24 Apr 2024 13:02:13 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709027b9100b001e3e222072esm12301319pll.53.2024.04.24.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 13:02:12 -0700 (PDT)
Date: Wed, 24 Apr 2024 13:02:12 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Apr 2024 13:02:10 PDT (-0700)
Subject:     Re: [PATCH v3 RESEND] riscv: select ARCH_HAS_FAST_MULTIPLIER
In-Reply-To: <20240325105823.1483-1-jszhang@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, samuel.holland@sifive.com,
  alexghiti@rivosinc.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: jszhang@kernel.org
Message-ID: <mhng-e1db5617-3379-4205-b502-22b05fb6d07c@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 03:58:23 PDT (-0700), jszhang@kernel.org wrote:
> Currently, riscv linux requires at least IMA, so all platforms have a
> multiplier. And I assume the 'mul' efficiency is comparable or better
> than a sequence of five or so register-dependent arithmetic
> instructions. Select ARCH_HAS_FAST_MULTIPLIER to get slightly nicer
> codegen. Refer to commit f9b4192923fa ("[PATCH] bitops: hweight()
> speedup") for more details.
>
> In a simple benchmark test calling hweight64() in a loop, it got:
> about 14% performance improvement on JH7110, tested on Milkv Mars.
>
> about 23% performance improvement on TH1520 and SG2042, tested on
> Sipeed LPI4A and SG2042 platform.
>
> a slight performance drop on CV1800B, tested on milkv duo. Among all
> riscv platforms in my hands, this is the only one which sees a slight
> performance drop. It means the 'mul' isn't quick enough. However, the
> situation exists on x86 too, for example, P4 doesn't have fast
> integer multiplies as said in the above commit, x86 also selects
> ARCH_HAS_FAST_MULTIPLIER. So let's select ARCH_HAS_FAST_MULTIPLIER
> which can benefit almost riscv platforms.
>
> Samuel also provided some performance numbers:
> On Unmatched: 20% speedup for __sw_hweight32 and 30% speedup for
> __sw_hweight64.
> On D1: 8% speedup for __sw_hweight32 and 8% slowdown for
> __sw_hweight64.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> Hi Palmer,
>
> Similar as the pgprot_nx patch, this patch missed two merge window too.
> Feel free to ask me questions if there's something need to be done from
> my side.

Sorry I missed these.  I know they look small and simple, but they're 
the sort of patches that have wide-reaching implications and thus just 
take a long time to review for a tiny diff.  I think they just got lost 
in the shuffle, luckily Alex and Andrea picked up some reviews which 
helps a ton.

Really the best thing to do if you stuff merged is to go review patches 
that are in front of you in the patchwork queue, as that's what blocks 
things from getting merged.  I know that's not the most fun of 
answers...

I picked these up for the tester, the code is pretty simple so hopefully 
everything's OK and they'll show up on for-next proper within a day.

>
> Thanks
>
> since v2:
>  - rebase on v6.8-rc1
>  - collect Reviewed-by and Tested-by tag
>
> since v1:
>  - fix typo in commit msg
>  - add some performance numbers provided by Samuel
>  - collect Reviewed-by and Tested-by tag
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index be09c8836d56..aba42b2bf660 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -23,6 +23,7 @@ config RISCV
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DEBUG_WX
> +	select ARCH_HAS_FAST_MULTIPLIER
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE

