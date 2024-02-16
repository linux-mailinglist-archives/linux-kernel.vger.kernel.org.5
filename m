Return-Path: <linux-kernel+bounces-69347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249D8587A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4601F244BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E699D13AA5A;
	Fri, 16 Feb 2024 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbPyu0kr"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559513AA49
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117536; cv=none; b=o8PE3X7zRq7rakH4YoBSZJe9GvF7+YSqs4JNTzzQRZBX17PaTVDxS6aGLA7fGBu6pJ7Wx9ySdiYMs2juu9RvsHX+vF3e4xHNbH9cyOQmVPZuEA5Zj1Zas5Y78hi18HKqfDtQhxht6qQeDWisXIHMpyQxt820xGFJZLIexcxiOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117536; c=relaxed/simple;
	bh=Zq+Dj8vM+mGDBcwbemhRh2i4jGsEfKxrat1MF9edXYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4RZiyLdj0jPyZaBw4lhK2W0IewgaZniAC3p34elRHZU83XKEUkTJNpmwjFt4OsfyzrcOkam2VmzMi11GEf3NBCAdW3C5xz/ecfSHQNE2fHFqSVA0oMUozSv/uYnApiGADhNvvE0sMCGpzcQd4H0H7//bqqRta4OhC+2Xhg2rug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbPyu0kr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3d159220c7so169284466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708117533; x=1708722333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=shgZmNUDjmgRe3frEU74jFBqUA2SGxRFjX4pA6qgQys=;
        b=dbPyu0krkp/vovRx3nRXC9yy36++ZrhyWeuUJntYVWIxBeagJttmEHC6VKViQIJfX+
         w3D9orTR6T636/1Vy1NpfvTNUIyE9WEXRcQaxrQjQ1oOCM+bXSDYZXVEBAVTXpQ1aVeB
         OA8GzUc/g1lirv0Fe85KJg598/JWcBeeXZJeHWPcu81Q/ne5gzhV9ggj3uzlnbkklQYU
         B6n9hKsR16KH9e74VWPnZkj7H1NcMef1Nb9Wt9Uk2FKeToaHFTbIGSSLp/GI3xTtb2bG
         gxbvseKzRtuwwDjAHb9Q01UEU4vF0Q7ydiiw/+JxFBLsFbs8EhYMP1WiE/6JK5HvBg+K
         Ef7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708117533; x=1708722333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shgZmNUDjmgRe3frEU74jFBqUA2SGxRFjX4pA6qgQys=;
        b=dYSO2U0B8ZjHnArTSWuAxrNKBPTJBd76x5Jhm1L2+0IESmz7oZOxuzGeZTSNofvxWX
         mEba/0qr29xt46Lm4mRjucPtGdxuBUU9D3V3wnd2wlFt8HWLEIqQYlxoMuX++v3BI+70
         etfJtOwmBkhtIaZE2e8Axg4IgNAdUjCxTbrETI5i7kx29u0z6zKtMCF5v6wbW1k6en21
         0Lfz2pGvi8grDf/GQxZUDtu5nPG8gPJdViF3JwNdZT4bhbcSxhR7BWEoYJDDU7ExZNJ4
         JzrJLOL4FDl3oZIcjZjfik4CHDXoOFHnv4D/+vgDHWSGakwHGKG9uKfm5yz3bbQ02oYK
         4fDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhq5iIrBQf/ChgWh1/S0gzpvc4LmSBaMQ7o9RL5Bvh7hvcLhCQtn5Q0VHQAL2NNfFotpdm6r9TNRPP2+3LV8+w4k0CwLnp/IxOpZcl
X-Gm-Message-State: AOJu0YwZSP0ipEorxSifsrlPtD4C/KSH+Vdxj4GrkN/Nut4ZfaTTjPlE
	z7e+9sxci+H6Ym/xTJkgv3IcqyZfP0MIf981R0dOywmgN/WOCkv2
X-Google-Smtp-Source: AGHT+IHVZYJGn0cvz6Sv6SWm8Y4imXPZlRLwn80Ognqtd4Py8wzXOlhGOcYZENg07BFe4Z/vpViEjw==
X-Received: by 2002:a17:906:c40c:b0:a3d:568:966e with SMTP id u12-20020a170906c40c00b00a3d0568966emr5022351ejz.6.1708117532761;
        Fri, 16 Feb 2024 13:05:32 -0800 (PST)
Received: from andrea ([31.189.39.37])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709063b8800b00a3cf243de37sm331704ejf.111.2024.02.16.13.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:05:32 -0800 (PST)
Date: Fri, 16 Feb 2024 22:05:30 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Eric Chan <ericchancf@google.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] riscv/barrier: Resolve checkpatch.pl error
Message-ID: <Zc/OGnjVKcCuKNA5@andrea>
References: <20240213223810.2595804-1-ericchancf@google.com>
 <20240213224000.2597959-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213224000.2597959-1-ericchancf@google.com>

On Tue, Feb 13, 2024 at 10:40:00PM +0000, Eric Chan wrote:
> The past form of RISCV_FENCE would cause checkpatch.pl to issue
> error messages, the example is as follows:
> ERROR: space required after that ',' (ctx:VxV)
> +#define __atomic_acquire_fence()       RISCV_FENCE(r,rw)

Not the "best" example, according to Samuel's feedback and the diff
below.  How about something like:

ERROR: space required after that ',' (ctx:VxV)
#10: FILE: arch/riscv/include/asm/barrier.h:28:
+#define __smp_mb()	RISCV_FENCE(rw,rw)


> -#define __mb()		RISCV_FENCE(iorw,iorw)
> -#define __rmb()		RISCV_FENCE(ir,ir)
> -#define __wmb()		RISCV_FENCE(ow,ow)
> +#define __mb()		RISCV_FENCE(iorw, iorw)
> +#define __rmb()		RISCV_FENCE(ir, ir)
> +#define __wmb()		RISCV_FENCE(ow, ow)

This would go away per my comment to 1/4.


From a less technical viewpoint and FYI, an unwritten rule of "working
with the Linux kernel community" is:

  Don't forget to keep people who spent time reviewing, or providing
  feedback to, your patch in the loop/in Cc: in your next iterations;
  they might be the only people who will be able to provide feedback
  /suggestions/help in your future life.

;-)

  Andrea

