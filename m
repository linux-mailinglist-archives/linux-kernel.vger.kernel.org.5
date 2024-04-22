Return-Path: <linux-kernel+bounces-153679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721618AD190
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322A228642C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF5715358E;
	Mon, 22 Apr 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3aHfUaQl"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A54153588
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802103; cv=none; b=fNb+cLpyQQmhJEeTEenBUvKm6LCjQMURb+Uwz/V9HwdQgN/BuZJRv2mkvrpSMuCv9cF3T8f2v6yOGObxG05tgEH8Cd18/DiJbuGOlE17gbbq51LRuLc2K31xw8MBy2tq/xBH+QZ0EUuzJqp/Sg2VfMaW/K9F1of2maC2E5Ok37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802103; c=relaxed/simple;
	bh=lfCxICFGy+LS9hJNxD2DgWqIfrC2kPB4vVbEqlpMc5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8N0qB4GBpesMdV8gaIS6JJrZR+JnGbFC+Uvjeq12kmjuifmMpMf3Br55YwH2aaNHjthUnIMFwgXmnYXQILxIX4+/QbzBIsBIKaNCKgi6YoEiJ097JGdxsZEmQqn/arL7I+u5NoJr5XMyhcxSsKgqBv739vyrCY8pYVNHl7uRVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3aHfUaQl; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5aa4204bacdso2783497eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713802100; x=1714406900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMyhnDCrHyV4qyizjWenu586ccID3T1Re44yDyknMgo=;
        b=3aHfUaQln4PM0rUUsSmEpfHrxZ1V4d9dwcJU0q0KXP6wpKYH9xPv+4a8m92YqIq+Nk
         A6QJ9DwOHf3PD7M0lmup0oFUZ2agIgm/wmvz/sRM4oYQP1OPGtrV800CR6+GTUQx0z0Y
         uEiePBYu8XpK753MvPxbBgTs7J0KFTOqfQ5pKuorhKGMYd6FeqyMWAtgoGAEiUXltC5Q
         3eMWcCDeyuAe3sDUGaanGKE5fHU7xS8uP0/OEqEG4DnwFprc7uCFL1jlB+7DfFdQaMvW
         gQGAH56BhlcxokAj5WrMXglQzv2LPGz3thKVbx1pz+Y1ugK30boMFOZVcTsyFz5/Vto2
         oKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713802100; x=1714406900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMyhnDCrHyV4qyizjWenu586ccID3T1Re44yDyknMgo=;
        b=JPguNh94DXBUj1ZSdxhOlp0icfr/QGnR5rsTR/a4zsvTWquw9t0Q+JXGdwFTNKibjZ
         lEzbgAb7M/TONSDyePHPCy+Opjth8TuyTcoyoHwDjUjl7U+MuaeUQt+8tW4Hy7wNCKoi
         XsfAY5ferVOPShT/OleVjxZFdz0nKpRF/akDZ1jdLdKMSk3N1h87VmKceATudiS1Lp4z
         hTLeCa17yUWnjtYf7vABparHnEfwQ1Z4yEg1eJxEQdmYa7dEbjAX5mf0Lc9nNUl+ONn0
         facPU9hWvg/ROaP5+dnaaoayLPM/y6bYtA4Zj3QMc5GN0Pgt0mr2a+qLrwqNbv61g6RA
         0Uew==
X-Gm-Message-State: AOJu0Yz0VNuagsDgExeocQqqENzO1yWbAGRzZ/vZBV//ebPgPEWUTcoR
	yeCxM3wGYBZbczbZKYVRV3N6MrwsHYQhK1vsZw7lqI5TDCCbbZE2Qd8wXHAh+gk=
X-Google-Smtp-Source: AGHT+IEk5jms5r3rvB1qzw8YQ+YVRly/gMNB1pW+j4Ieau6IBs3d3/y066TBXoaCbq31F9igsdhObA==
X-Received: by 2002:a05:6358:78d:b0:186:2852:a923 with SMTP id n13-20020a056358078d00b001862852a923mr11995590rwj.27.1713802099983;
        Mon, 22 Apr 2024 09:08:19 -0700 (PDT)
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id b24-20020a25ae98000000b00db41482d349sm2103941ybj.57.2024.04.22.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:08:19 -0700 (PDT)
Date: Mon, 22 Apr 2024 12:08:17 -0400
From: Charlie Jenkins <charlie@rivosinc.com>
To: enh <enh@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] Clarify risc-v hwprobe RISCV_HWPROBE_MISALIGNED_* docs.
Message-ID: <ZiaLcRimjNY8F0sF@ghost>
References: <CAJgzZorn5anPH8dVPqvjVWmLKqTi5bkLDR=FH-ZAcdXFnNe8Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJgzZorn5anPH8dVPqvjVWmLKqTi5bkLDR=FH-ZAcdXFnNe8Eg@mail.gmail.com>

On Thu, Apr 11, 2024 at 12:18:25PM -0700, enh wrote:
> These only tell you about scalar accesses, not vector accesses.
> 
> Signed-off-by: Elliott Hughes <enh@google.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst
> b/Documentation/arch/riscv/hwprobe.rst
> index b2bcc9eed9aa..239be63f5089 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -192,21 +192,21 @@ The following keys are defined:
>    information about the selected set of processors.
> 
>    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
> -    accesses is unknown.
> +    scalar accesses is unknown.
> 
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned accesses are
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar
> accesses are
>      emulated via software, either in or below the kernel.  These accesses are
>      always extremely slow.
> 
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned accesses are slower
> -    than equivalent byte accesses.  Misaligned accesses may be supported
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
> +    slower than equivalent byte accesses.  Misaligned accesses may be supported
>      directly in hardware, or trapped and emulated by software.
> 
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned accesses are faster
> -    than equivalent byte accesses.
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
> +    faster than equivalent byte accesses.
> 
> -  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned accesses are
> -    not supported at all and will generate a misaligned address fault.
> +  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
> +    are not supported at all and will generate a misaligned address fault.
> 
>  * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>    represents the size of the Zicboz block in bytes.
> -- 
> 2.44.0.478.gd926399ef9-goog
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

- Charlie


