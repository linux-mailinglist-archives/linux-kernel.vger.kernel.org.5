Return-Path: <linux-kernel+bounces-67426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10588856B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39E81F21C91
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0F136990;
	Thu, 15 Feb 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RjyXADeE"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63989136995
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018948; cv=none; b=WxyCT34q2rm8HgojHtppwzDiGGV5RhvMVH2jV2bT14mCSVqEWT+ZsD6YEZBHY4A0htP+3Aq+4CyGyj3gtnXbFvgIMyKSePEtKmfVBlaXz66O1YnxyXRql61vxGYdJJQxdxR3IdnCeGeV9JDxAmyDEkdS1y0qB2/N8/I3TKNqotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018948; c=relaxed/simple;
	bh=4G1/DxhVgnWI1glI9fwImDYHL4QgKnB+UwqfApIEmcc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgB1nxbwQBfDiDJgBeO+eDtmHTom6PHsIX9vBtbBnvtjzYFLtMuZ1IVaTeyQ3nY1q3eemysWOb3d1L/waLDK3lA9gviehKynQd1xERrwcYsqj12lamY5f69wiUgNuPRMFtc/R2IwkipFaY2f2QsloI0zlaDsCv18IMDepwFOucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RjyXADeE; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 481BF40C73
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708018941;
	bh=itMxjOpdbsY2nONIH8lkAcrbbGF1rBZB+VhIXId8/HU=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=RjyXADeE0VQuQMe7J3uMRstdkXdS3/F9TcaPt/sQ/e9glCDhC55JFbirVucH8sm7i
	 YJsVtR7X/niCwKKTkVfx85OTAjQ4YbiiWzCjGyCnIzxhmxnzwz5bGF47KZMcpLdvrW
	 TaYmAH763QJsyAdniDZAX1YIKWqDg+GZTa1zu+YVTkuGOWS0nco2s21IvBM0zpg2F/
	 oAGx2LbxX14cTHMusigEt42AjQSMpQRvMZF8w+qSqSgik/PDO6Gpexntl3D0lc8wo3
	 4cvvikHHi1LnqWYJCU9sQ0ZfLMUy67L0ae4pWcTqTNK9QL7pPdFwTq93T5FVFx7Ep9
	 Bp8v+Z/eTlvpA==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c02a63d499so2074445b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018939; x=1708623739;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itMxjOpdbsY2nONIH8lkAcrbbGF1rBZB+VhIXId8/HU=;
        b=wsl+Yf0MyKjTzdeukm32eTwqjT/dyhlHxxXpRLrnMndH1WpTE+gnxbV8rGYFki5k8I
         P2l6jHasRAKQ0e/A+CBWGMQCKxPXcEmw3DDwcunUwDlFczYx50oo48nopqK/1YOPKTA8
         jXhq4rP86V0BJrwoTHTSqs8z0CPf3qbYOq7C13iAgBGEAsWvhdBaSF+jm93sbQmNmwHq
         cbx4s6r7zRLKhgfYrUmU6rK5H5FHcYZapOPwu69sNsVBsIjHIBQR5oGEMULThdW907Zq
         TRpNWMzJ8nICGgHWITshf12oqQ48v6rksymgynuxpEcBILYat+Z6rv1jmcZdZ4C42IXW
         9+LA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ6xc1Y+5zR9iUldSyZ0mf09+IH2VGpBfeyCx7DIKza1Iar1XmLsDnEpWSGUYBU7ljngxfki1q6i+kvKX86vkGOYGy/biX0MlbnjEp
X-Gm-Message-State: AOJu0Yx3OuQKCAJgZ9kJ+eK+SmNnTZdVkJCcFGiNEdLYmtxvvFNUN6t2
	Yf6+2E77k1upPuaZg/ulLjdZjJCvosewnA8zXA3KnE5CcCw/grBhBAiXaL1mPHRkm5klww1PsQb
	7G0HRBt7yB7Li/QsiQOEQCLSEq36lXfC1j1d2Pu+UDQx3GrySyKZ5FJW5AMo6Rx8OnzBdHm+5zh
	/sdWYHBWnMhi9rog19AsZK3xjGqENVTFgE/JX9J38VWXnN15t+5G2euHdXimmn
X-Received: by 2002:aca:280f:0:b0:3c0:2fd9:5158 with SMTP id 15-20020aca280f000000b003c02fd95158mr2329566oix.49.1708018939361;
        Thu, 15 Feb 2024 09:42:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU08R5xI0RL8D+bUo0EqTVGH61HjNxSmKOBg31rT3nGy17WIRkBGvEBXjSjDG3faSm+XLyqVOiwzTPAZ1EUzc=
X-Received: by 2002:aca:280f:0:b0:3c0:2fd9:5158 with SMTP id
 15-20020aca280f000000b003c02fd95158mr2329556oix.49.1708018939131; Thu, 15 Feb
 2024 09:42:19 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Feb 2024 09:42:18 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <e541754cd564253b2da9efa952479c75bb7fd2d6.1708003477.git.geert+renesas@glider.be>
References: <e541754cd564253b2da9efa952479c75bb7fd2d6.1708003477.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 15 Feb 2024 09:42:18 -0800
Message-ID: <CAJM55Z92hpGq2f=CsR6CbDh_OzVO7KcvbouyGXxYgn=hNT_nmg@mail.gmail.com>
Subject: Re: [PATCH resend] riscv: misaligned: Grammar s/disable/disabled/
To: Geert Uytterhoeven <geert+renesas@glider.be>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Geert Uytterhoeven wrote:
> Fix a wrong conjugation of "disabled".
>
> Fixes: 7c83232161f609bb ("riscv: add support for misaligned trap handling in S-mode")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b49016bb5077b860..84b8200f7a625b07 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -706,7 +706,7 @@ config RISCV_MISALIGNED
>  	default y
>  	help
>  	  Say Y here if you want the kernel to embed support for misaligned
> -	  load/store for both kernel and userspace. When disable, misaligned
> +	  load/store for both kernel and userspace. When disabled, misaligned
>  	  accesses will generate SIGBUS in userspace and panic in kernel.
>
>  config RISCV_EFFICIENT_UNALIGNED_ACCESS
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

