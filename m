Return-Path: <linux-kernel+bounces-23779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010DF82B188
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6CEB2515F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2E4CB3C;
	Thu, 11 Jan 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lTKWSADz"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B44C60A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50ec948ad31so4253096e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 07:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704986177; x=1705590977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPZFW6fjituFN6UJOUsGOAPd8JoXYWow7QZvMD6pj6I=;
        b=lTKWSADzlhcUnTD8rxogVa00pl1q/hD4/VtqPH0WDv5Mf2b7Kbb34VZ/aov9kcyphz
         hX2YYFZc0TObsrL6ZFZvlbly48nnjIpKpdILn2ZAr9NBc5AO7VafXmmPGSmwK1GeVOzd
         +iEwTlNI824sko3kaPZIEL/kWm7kNtRFadswIzwrXjCZPE0hfO0Rw78F+ckfbieEPlow
         /VWiRXgIXJymDba8PjRBLNfLDT/OcGp1j8LFXB2KjN1ad9kvsXqM3ftFzk5rB17zhGYq
         8KWQYr7YkC2V/Y423P2VOAk/L6gUxeCNZ9XrthZFR4noE+yUB+jvicMdS03rDtY+69Fj
         r06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704986177; x=1705590977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPZFW6fjituFN6UJOUsGOAPd8JoXYWow7QZvMD6pj6I=;
        b=ufR7QlHxQdYvv2NVguStsaTVZQHNJIgAMbKKvCVca5hEUWr79XdKvb256KE9EJFSWL
         M23MdgmD18Dwbvw7wMgp204einxMZiT2GiJdJcroxib+hiIrZs+4ZgFRBzpE9YaJ/QVH
         qG1kRiEThufIJqASCk+bYKyayngoysM4QLhZ4e7LmUMx54NScJHkKfFcVPHfWQuLtBii
         aAWmPpfqphncuvpe1V1I5FdzoZPfSwJh9qTdB1c0fhbBazFMuJXya04BulnB0PGU0+Fi
         Yi3ifFwfJqpU5fSvWydy80Pj6SjvSjEKkHGIOmTSyYhGAq6vWNB1IHumaCr0L5E6NSkI
         LFQA==
X-Gm-Message-State: AOJu0YxIav1I6AO26PadHjeOtxKlQVamnCWtRgmEAs++dkGD3fPcG+63
	1Tsfga7M76gG7sAOaPQ70w2iMFgKhUyk7JVdKd219O5oGs2/FA==
X-Google-Smtp-Source: AGHT+IEZLeQNv6vCjr34+occd/nO2c9YnZOYz4CaUUfcYXZe8yRhNltwk0drriyy4oGP+4xVoZ71xb7w9RVqI3OQj5U=
X-Received: by 2002:ac2:58d0:0:b0:50e:7709:9fc2 with SMTP id
 u16-20020ac258d0000000b0050e77099fc2mr626322lfo.78.1704986177471; Thu, 11 Jan
 2024 07:16:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221070449.1809020-1-songshuaishuai@tinylab.org> <170498463757.20080.7960935665061816471.git-patchwork-notify@kernel.org>
In-Reply-To: <170498463757.20080.7960935665061816471.git-patchwork-notify@kernel.org>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 11 Jan 2024 23:16:06 +0800
Message-ID: <CABgGipX7Jf7M8ZYgeRPcE9tkzc7XWpfWErsiacn2Pa9h=vG2cQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: vector: Check SR_SD before saving vstate
To: patchwork-bot+linux-riscv@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Song Shuai <songshuaishuai@tinylab.org>, linux-riscv@lists.infradead.org, 
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu, greentime.hu@sifive.com, 
	conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com, 
	xiao.w.wang@intel.com, heiko@sntech.de, ruinland.tsai@sifive.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Thu, Jan 11, 2024 at 10:50=E2=80=AFPM <patchwork-bot+linux-riscv@kernel.=
org> wrote:
>
> Hello:
>
> This patch was applied to riscv/linux.git (for-next)

IIUC the conclusion for this thread is not to check SD bit for either
vector or fpu. The patch for this was sent together with the
kernel-mode vector series and has been reviewed-by both Song and Guo.

> by Palmer Dabbelt <palmer@rivosinc.com>:
>
> On Thu, 21 Dec 2023 15:04:49 +0800 you wrote:
> > The SD bit summarizes the dirty states of FS, VS, or XS fields,
> > providing a "fast check" before saving fstate or vstate.
> >
> > Let __switch_to_vector() check SD bit as __switch_to_fpu() does.
> >
> > Fixes: 3a2df6323def ("riscv: Add task switch support for vector")
> > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> >
> > [...]
>
> Here is the summary with links:
>   - riscv: vector: Check SR_SD before saving vstate
>     https://git.kernel.org/riscv/c/e1b76bc00ed1
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>

Please let me know if I missed anything.

Thanks,
Andy

