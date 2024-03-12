Return-Path: <linux-kernel+bounces-100700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86345879C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806FCB25A25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8979114290F;
	Tue, 12 Mar 2024 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="IrBQsnD6"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9391420D2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710270533; cv=none; b=QDtsTXDvHmZCuG2uxjGkvJnAVAEByBFj8kIgz3EZMou74x+dHTSOBXSNwjwfqeI5abeooBiCcNwipNDwTi7+D2jrMZHf0ZGepXerQ/NmwsuK8GyzNXRyUOl5kxyvlyWb9rKMuxyCSpKU9N6ghWVlm1fC8kxUegD8dnE3nap3Q/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710270533; c=relaxed/simple;
	bh=ubelwNN49JPtWt+zM54LAg+rdIolQj6lmX/MT8AH0ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T9ghpBhYoAdNBmp2Z0Mnjz5eOBG1HppSKEsTg0yXC163739mSFg5um9yTnryKBocAkFgUmyAcDzei0mnGLGsLyAnreSMrNlfIUUIiNpFjf3Z8L5J3zSy65EU2v5bwqWN9j9vc6yUByPP9iDf3JBQ86P0yhLMjpTPNFrujZEtVJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=IrBQsnD6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513298d6859so5794547e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1710270529; x=1710875329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjcZWf/nXIQyIPUNxD3DTUa5JiAHVZAbpXSBI/PF41I=;
        b=IrBQsnD6EXNfsWnVKPgDe3DHwnsYe6BNtSBWwzS+532D5zEDYdjMTkfmJu9zwFsnTF
         btwAKBPRvBDxWFMiZxJIa6Bgk5nyMtOMXMSR9E3nUuL6ohaeO7qZJROoEA/cRRZp7fo6
         sdZnmbWoTArO6BK9QZyy/uvd+k41vbeQJ3FciyVADTg8Ql+3mBxUeoodx9+KV/aifEt+
         Zd77Mnln2SVrNbu/rlp3oVXRkKlrY2slTY8i5+3GOvfTnZc1t2f4jZneteU9e6oo7LJp
         qiwcShDoawsTThu8PiHhRnEmLMtKbg7QGissaESn3KfPnFSA5Zq+GDIRuldq8E8uAxpY
         udhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710270529; x=1710875329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjcZWf/nXIQyIPUNxD3DTUa5JiAHVZAbpXSBI/PF41I=;
        b=o83GfXSNmdtDNr2IuVqmR/bGrNh7jl+wKFg3sEa1kMHfk1Wu5HsyuQGMgOoZVGNPzV
         gJg030OeufzUVncbmBIfdI4jknhMMpXAbbF7FnoYGb9s0bdwMl3k6aBO26XqoInWJvDD
         C+23oSGqKr6HctonFVh1D3I7hCLrBMEhKLQKiBrTDmfQDoxiS2unFAc8p96wlxhP011e
         oKp4LpEJvR3eoMubOM1XJtchp0JgqBQcFIHSmNlmhWTLLChSjR1DU4rIa1F3xs/APPML
         PlU3SpT9CBphGMM/SHUugjWN0l6WddnmDVP6H0B7W2OkHJwYyVva3pENzPeRtlCrjjXf
         Y3Ow==
X-Forwarded-Encrypted: i=1; AJvYcCV/YQAitKI7IgePN5J8wx5DGgJZeYaBkuAmWT4LQQpHQVxeg9GXsiAHOxkbyJOShZkQf8A2CLGAriJLdceSDHbCxggIn6rEx0HWjNpG
X-Gm-Message-State: AOJu0YyiD8MGavLlzsKnz6YI7GHQJ+nAzDWAlzKMHwFWxiDyIM94NDBb
	oayKbX7S3PHC1AwG/PzMg6D5bVDHg6pTtwvcO3GFXxQTvTvbkp5YgEIZ+S7lhJZ4ezMZCygzOBn
	M9sn1VONxxeGV+2LivC/RNlBFGqeTZ3pO/bqHdA==
X-Google-Smtp-Source: AGHT+IFqepFRXOh28CrZ94R8jR8QHTaaYGZhvEkRfy88tewlac/0l7Q1dZRIj80W2YM5/JpGF/ZIincLgKne/q2GfrQ=
X-Received: by 2002:a05:6512:3b94:b0:513:a977:933b with SMTP id
 g20-20020a0565123b9400b00513a977933bmr2233994lfv.42.1710270529032; Tue, 12
 Mar 2024 12:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306172330.255844-1-leyfoon.tan@starfivetech.com> <f9cc5817-234e-4612-acbb-29977e0da760@sifive.com>
In-Reply-To: <f9cc5817-234e-4612-acbb-29977e0da760@sifive.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Tue, 12 Mar 2024 12:08:38 -0700
Message-ID: <CAHBxVyGuy=LngEeGkTAD17UDP1j18028XQbzdDYTL1gLFMDskg@mail.gmail.com>
Subject: Re: [PATCH v3] clocksource: timer-riscv: Clear timer interrupt on
 timer initialization
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ley Foon Tan <lftan.linux@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:40=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> On 2024-03-06 11:23 AM, Ley Foon Tan wrote:
> > In the RISC-V specification, the stimecmp register doesn't have a defau=
lt
> > value. To prevent the timer interrupt from being triggered during timer
> > initialization, clear the timer interrupt by writing stimecmp with a
> > maximum value.
> >
> > Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> >
> > ---
> > v3:
> > Resolved comment from Samuel Holland.
> > - Function riscv_clock_event_stop() needs to be called before
> >   clockevents_config_and_register(), move riscv_clock_event_stop().
> >
> > v2:
> > Resolved comments from Anup.
> > - Moved riscv_clock_event_stop() to riscv_timer_starting_cpu().
> > - Added Fixes tag
> > ---
> >  drivers/clocksource/timer-riscv.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
> Tested-by: Samuel Holland <samuel.holland@sifive.com>
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

