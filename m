Return-Path: <linux-kernel+bounces-72832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA2585B91B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E871F21404
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132A361683;
	Tue, 20 Feb 2024 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K795hQUr"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C623EA88
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708425064; cv=none; b=OOPQ5qxaEJ8DUCdh7jDecgjs/bj/YNEOa42edzrJI/PujsT+QGNWKDJ8sSbuVuhxhCsy4uVFKEYQW8A+fsYRIj/+t9kCpI/yX22eCknAcubFsd/kQ6XKTAcnXR7JNByWHDesaBslDnQdair5ulqe5TjGulli0re9+Qv/MbJVUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708425064; c=relaxed/simple;
	bh=4ka26MKTb2gAfNP6PWHyqiItjIFpe0PWywv9rC9J+GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIlFm9uSIe2SqSeGDxw0YEpgfo801d9jQn7thCwNB05MGbDI3CVNfJAp4vo6jNDfruOudyxybwV+QGiNc0ISvWlt8mPFiUoegSpPO+cA9/FEeGuH5yVdf7zRn3YwQjU+fmSItn/aEPytgllKGEq0rwo2/43gdQM/pMhalDLGbfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K795hQUr; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4cbc49dacc2so1002562e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708425061; x=1709029861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HIp91kw+zH2bWJFkkeSlk/Ch+KTOQUCDIw5fmR7h+Tc=;
        b=K795hQUrezWnH+SJ83hKk6Tdoj5ImdAilvLlQ1M60YX8YWteidf1Nzrb1WOakhXoil
         Lc7LkVfaXQWqouk0i8R8Bw3Rg/OUAVaCEiPEQqgSiIwkuC3lxRbLIBxRR2TIonpRS/J9
         6e/PXARKKO90mJk1bXVd/WKrNEdiUTLjK37NKrqeGVm/JhXEHCcjaSGPH7GnO8OzWMvM
         iVA37fXDP59m0rd+uSS2jxljyUygGR5nx2mbYp2I0F42+pH7eypLN0qj+aW62Zu+JOHT
         ej663Wh8FZxd2ZgTgvgx7P1igRVN6zy63jAvLCq9dCR37vuLwPZRdJI29vfo08Ic75yK
         oaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708425061; x=1709029861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIp91kw+zH2bWJFkkeSlk/Ch+KTOQUCDIw5fmR7h+Tc=;
        b=Cskl4CKZ8za2Y0RhB59zrMrkbwgl5bvn7LXFmUWtp3TTUrmb5It2578plCFDF5cBJT
         65XPs9pbUAKhkmafd8iHD6XJT8zeceyIesocndUZzr6YjVlxM8r1eqr2gcEWaBajtH6Z
         7ktoWPCrAWcAHLlCS49G/XPRr6a990WeveEyo43NlUnCOQshiL+xVFJplB2wnVpC5X1j
         qCfQGRe+FeXvIv5cLDAoHnOeZyWp1+QHNEUZag3hM8uwZW0fOCuXfm3NfHumZuX1SGqp
         W2wDn9UpG7XX7Eb036lqMwJ1Uv0LaH2QWLXJ7cu2RGDbvNPNssAExiEb1ENee+Dx93OD
         BuSA==
X-Forwarded-Encrypted: i=1; AJvYcCWxA2mNFsQDBmyadEKnW8er0kMBETVcm2nqdj1HV2xKCDli+qa2DiALPX4In74+zN3Y9b82DoNIH9URATtsKDBEVrzsaeHIpzIPKUQc
X-Gm-Message-State: AOJu0YyeqHovIN7C40iHeTTDsVH2w08wn57WQqmQ3g+Ve4qaNTv+kKYF
	z3smBG2qgEyALV3ri0uV2+Ppmz3M4Q6vBM5i/GjFp1ep5sZm7Ktjup2jr3U5/LefrByZRFRqFa2
	JcfS33CSSifgddFj2FXctvCjmE3MIKvfLwRZIYQ==
X-Google-Smtp-Source: AGHT+IGysc0UmXmPnthjzbU7YPIZ9HektmfceOwdP9++ToUAMtvh7ubmq2V4CELGPXIvh6F4I8e8i12+OzE29ejs2dY=
X-Received: by 2002:a1f:6603:0:b0:4c9:6628:be66 with SMTP id
 a3-20020a1f6603000000b004c96628be66mr4749965vkc.5.1708425061512; Tue, 20 Feb
 2024 02:31:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYugYiLd7MDn3wCxK+x5Td9WO-VUX2OvOtTN7D1d4GHCfg@mail.gmail.com>
 <86edd84wer.wl-maz@kernel.org> <86cyss4rl7.wl-maz@kernel.org>
 <a7d8e529-9a44-3f88-50ef-d87b80515c36@huawei.com> <86a5nw4gp3.wl-maz@kernel.org>
In-Reply-To: <86a5nw4gp3.wl-maz@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 20 Feb 2024 16:00:50 +0530
Message-ID: <CA+G9fYtWqf1h3w1nkjJGXjYis7Zx5pNxN=EvmfFpMxgktW70Xw@mail.gmail.com>
Subject: Re: next-20240219: arm64: boot failed - gic_of_init
To: Marc Zyngier <maz@kernel.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>, open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 20:57, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 19 Feb 2024 14:46:46 +0000,
> Zenghui Yu <yuzenghui@huawei.com> wrote:
> >
> > On 2024/2/19 19:32, Marc Zyngier wrote:
> > > For what it is worth, I've just tested both defconfig and my own
> > > configuration with both 4k (kvmtool, QEMU+KVM and on SynQuacer) and
> > > 16k (kvmtool), without any obvious problem.
> >
> > I had a quick test on top of next-20240219 with defconfig.  I can
> > reproduce it with QEMU parameter '-cpu max -accel tcg', but things are
> > fine with '-cpu max,lpa2=off -accel tcg'.
> >
> > Bisection shows that the problem happens when we start putting the
> > latest arm64 and kvmarm changes together.  The following hack fixes the
> > problem for me (but I **only** write it for kernel built with defconfig
> > with ARM64_4K_PAGES=y atm).
> >
> > I can investigate it further tomorrow (as it's too late now ;-) ).  Or
> > maybe Marc or Catalin can help fix it with a proper approach.
> >
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 4f7662008ede..babdc3f4721b 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2798,6 +2798,7 @@ static const struct arm64_cpu_capabilities
> > arm64_features[] = {
> > |             .sign = FTR_SIGNED,
> > |             .field_pos = ID_AA64MMFR0_EL1_TGRAN4_SHIFT,
> > |             .min_field_value = ID_AA64MMFR0_EL1_TGRAN4_52_BIT,
> > |+            .max_field_value = BIT(ID_AA64MMFR0_EL1_TGRAN4_WIDTH - 1) - 1,
> > | #else
> > |             .sign = FTR_UNSIGNED,
> > |             .field_pos = ID_AA64MMFR0_EL1_TGRAN16_SHIFT,
>
> I've posted my take on this at [1], which hopefully matches what you
> were aiming at.

This patch [1] applied on Linux next-20240219 and tested and the boot
test passed.
I have validated today's Linux next-20240220 and the boot test passed.

> Thanks,
>
>         M.
>
> [1] https://lore.kernel.org/all/86bk8c4gyh.wl-maz@kernel.org/

- Naresh

