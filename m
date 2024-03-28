Return-Path: <linux-kernel+bounces-122313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D98688F501
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4141F2E3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2636123772;
	Thu, 28 Mar 2024 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QHkR7Hqv"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED63D21364
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711591138; cv=none; b=BCqOfisBQeI7eA9EofxUvLoix/hFSoPRhCdbHksWG5r5XDbMfyhgz88YgMvZTd69Rr+FGacdwsmEOW0AO/NqdJww1GKKcNfj4u8MbxOfPWpYJJU6jaOC8kXIBPYK9h3y8mDeHHPwf2T3TrXVbjeOy4F1f52tsfkTo/jX7LmHKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711591138; c=relaxed/simple;
	bh=V+fLpm5BwwJrjo47+xE5Bs0hRX9SdNxiYZIHQUfxlJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ewpsMKtCJrMNyW0M0Z3/nD4ZlVgNLsDlPmd7AHa6k4Uduai9F7Bq/Twm1FFT3T2DBjRVBtTgTmQp9auYs6X1uEs+GCdt1XzWQt9+/+fu5HDjWFTUp4GssH6scEk/Q+y9iptat9D51+1ankIGWMelorpJUdpruQm7z5ke7pGynp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QHkR7Hqv; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so428552276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711591136; x=1712195936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixVd6sHhRte5be07PDHwpHq0YTAzRJfXqkR9VbnbXt0=;
        b=QHkR7Hqv63dY018Mcrn1ZXAxEeU1PFlPbKCAKcWmJHQqXcbhx+BE5RupFp/pGoKa2+
         05ZJnCe7n95N2mooj80s7KgWKJFT11zoVaZblbEN9OSpaodpgMjx6GbZ/ibmIkBq7Zu1
         e8/iKYEE4V7WVugDg0Jb/mVWGpg5KyQNW/XyTHJ0KGxc8w1sWI+hvRIKxd6r2CaJ6xUf
         L2uxWokBPS3DsIDiMINb/aIlF/5EpGRwZsSNbzx6Ss+EuEftv9Zpj+s3yZxK7B93KRgg
         SDFFAkYB5pVBCZxByJ2PTCsbsxk2a3Rw7FKWov8JOixzLV/zJEseXs3lxlYWr1eSj97e
         rXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711591136; x=1712195936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixVd6sHhRte5be07PDHwpHq0YTAzRJfXqkR9VbnbXt0=;
        b=M4nDir+nIB2CvkM7xcF7DpwjlanHLPDv8WCpeXxsoCTgV3aTjctb3Ngldk1+FeJlGQ
         I5VL8IkDXTUapeK5roIbogi7yuzBdQ42jTyRrmSsKmqVUW/HyI4R1833KSnG1SqGddRV
         n0USF4ajxh7f8qR0SYsXmmO5thgUbLKyTBQMldUkoSTosDFQNxyjzeXKkrHft0/ST5DT
         qHVpCi0nLz9rWzvP+WRUyr34ehpFUvxoiJEzNVkoWvJTpLVqczSkAxEq1tw2GyezbDK8
         FIpOUVG9HxiEzHgqvGrJk2x3KcSCOwD/NcpnTnGtl+P1srU104gC/ZvBWfOQrJNEoDnZ
         aIMg==
X-Forwarded-Encrypted: i=1; AJvYcCUeDY9EfXVHi+pJLki6IJYSB4Gm7dxB5W2fRIQIV00GPejgjNI9NawHfPr9j27sdrsgsIHTCEdUnIZjfNHpdjuq9GdzYHN+fTuixlys
X-Gm-Message-State: AOJu0YzHIvLSsR27IVo1KUK5AMsZwQcU18Di1StDuzI68x1eN5BsG/mw
	8g9KGHd6URGaFH2/sKsWJmS9WEPbyeD/cO/7B2zTFJYJXMgqCQfOJph2FhnWmtkAJ+mK1cKeXA+
	DGRhLPfBO791oZgT9SG2NjWFz6k7zgbjq+OZcdw==
X-Google-Smtp-Source: AGHT+IFVk742SrsLxx/xN8qOIT0jNnA3IKiDDXlmlpeVRfNvYaVFpDTr5g+tJ4iscdYuJ4oZ7FJJqUipXvjVYpIdzJk=
X-Received: by 2002:a25:860b:0:b0:dc6:9c51:760f with SMTP id
 y11-20020a25860b000000b00dc69c51760fmr1468859ybk.56.1711591135824; Wed, 27
 Mar 2024 18:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com> <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
In-Reply-To: <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 27 Mar 2024 18:58:45 -0700
Message-ID: <CAKC1njTOgsOCpLMCch_YBE+qDoewADhzWwjjfX9nhWCS9hs0mQ@mail.gmail.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org, 
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 7:21=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> >         else
> >                 regs->status |=3D SR_UXL_64;
> >  #endif
> > +       current->thread_info.envcfg =3D ENVCFG_BASE;
> >  }
> >
> > And instead of context switching in `_switch_to`,
> > In `entry.S` pick up `envcfg` from `thread_info` and write it into CSR.
>
> The immediate reason is that writing envcfg in ret_from_exception() adds =
cycles
> to every IRQ and system call exit, even though most of them will not chan=
ge the
> envcfg value. This is especially the case when returning from an IRQ/exce=
ption
> back to S-mode, since envcfg has zero effect there.
>

A quick observation:
So I tried this on my setup. When I put `senvcfg` writes in
`__switch_to ` path, qemu suddenly
just tanks and takes a lot of time to boot up as opposed to when
`senvcfg` was in trap return path.
In my case entire userspace (all processes) have cfi enabled for them
via `senvcfg` and it gets
context switched. Not sure it's specific to my setup. I don't think it
should be an issue on actual
hardware.

Still debugging why it slows down my qemu drastically when same writes
to same CSR
are moved from `ret_from_exception` to `switch_to`

