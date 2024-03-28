Return-Path: <linux-kernel+bounces-123483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9696B89094C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91601C2AED6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBB3137C58;
	Thu, 28 Mar 2024 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fg1ZtSMj"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259FD44376
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654448; cv=none; b=hZAE2yahQRUq36Wcpj0PySN5jxy+MJdQWVWmqYd3nCewyYbfuRA3ZV37dv9XdYLa9A3DRodVoEurBWo7hKTmtweXozHBN68/GVi5EBjnhz/9pP9mh8PUNWYy3ADGNbCyNpRYee7PrJ3p6nju/1pDvpUXCD7/DkAuupOYrqF00DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654448; c=relaxed/simple;
	bh=dTm7d/6PkkPdAmbdGkKYEnUZfhBeyHqXVigZlqrvcDE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppr/u4PhLaODUQMpeRSeZXa15+bdKOoE5l/Sjenb7nWp5gxVrudrIjms89rhLRtqjCTEAYx8Gb3eoCkN7hZrkMNXNdI7iV8fGEzMH9kI3+U2BYi5JXTJ027i3txT1XNOpedZ/RF7tNPaflmbKVt3AWLYBUjPhu8son6uTxCCdGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fg1ZtSMj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e21d1e8307so5460045ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711654446; x=1712259246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFkewoBSuuA+NyCvB5QMwy0Z4HM+U6hdKrpuaoxhXDE=;
        b=fg1ZtSMjcdTkYC860F391Q9mrZutJfc/jIZRizWeIS9pECU7BeDkwTSzoJYXN0p8wh
         uyh/NdQ3AU2/cx/4GVQWWecUZLtBJRJICaHFUvvVk1CoZteO12m9YBIUiLHsBCBsDNp+
         vBD3AdkUeLY8dwE6m2BGq9cvO3T5uzLp6Mg5jkz+a4mWyavgURCMt+jJ+PBwp99JvxnJ
         dM+mT3l5eNX2z7pVEPRvd9U+nC+aiU9eLs+Wx3ByLq/S7Fc9rfGG4pm0Nai0T3r7lJXH
         XCKAX6HZDktIicrQpNzFDCSIbrPvRlsCnk5V5HpOckqlmxYjDp+ji5sVqKxOeAnrV0nt
         UEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654446; x=1712259246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFkewoBSuuA+NyCvB5QMwy0Z4HM+U6hdKrpuaoxhXDE=;
        b=lWBSgCebiQOFNSYXYaMJbL/LJNft62wWoYVMW94UP/UuRAXqmniJRHmZE70tb9pZAj
         9iBNuYIKkT7g5qvwMwsnYyu9idbg+n+DUPhJxXADegBWLA4lvfAKMovI1Nfi5lJURVMA
         ZTTe11wnw7GrX6DEtusgc1ivbxRMjs2xAjlA4do1ssqZSWY7fNsCH+16ttw6kDqQo56o
         71RMfpwIkrffjs00Kcy3/jGkRcZjko12VJnJ73wUeCMCbFVfI95MYkMMe4TeTSnNO0+y
         4XOXO/TGcqI9VhlZYkMp5JPhwaCmXFmjPepvNSCSkQiLiE2Au+jGZy5vGt+qBfMM2gbk
         yqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4WFux6uBnS083wy/DLXMDHul9luLpZQixf7CaObrwWhkex8t1jE6EDVKEe9pZVaU/nH9C7zIuNP22hD+DiCaGdf+SJwWhBmcEdVxv
X-Gm-Message-State: AOJu0Yy/I+CsRwqR1Fgun3gI5uJZMnTXmNGS73NOBguCP2+yWqEPH9wF
	nph3sRv3aLBV6t6mpceJZuL5fWSM99gpYAD+B5ypmlMf6EC8IrFUYbuvaOFSCX4=
X-Google-Smtp-Source: AGHT+IHmXFP8K6LroTZXQuV0pdXoRjq0VtE44n+b5oHqeJDoRGPeWBgHtYgVGum7hQezukzxvp3Wiw==
X-Received: by 2002:a17:902:a388:b0:1dd:b3ef:4528 with SMTP id x8-20020a170902a38800b001ddb3ef4528mr429956pla.52.1711654446258;
        Thu, 28 Mar 2024 12:34:06 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b001e0b76bcfa5sm1995555plg.54.2024.03.28.12.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:34:05 -0700 (PDT)
Date: Thu, 28 Mar 2024 12:34:03 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org,
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
Message-ID: <ZgXGKxp0KAQI/+NC@debug.ba.rivosinc.com>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com>
 <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
 <17C0CB122DBB0EAE.6770@lists.riscv.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17C0CB122DBB0EAE.6770@lists.riscv.org>

On Wed, Mar 27, 2024 at 06:58:45PM -0700, Deepak Gupta via lists.riscv.org wrote:
>On Tue, Mar 19, 2024 at 7:21 PM Samuel Holland
><samuel.holland@sifive.com> wrote:
>>
>> >         else
>> >                 regs->status |= SR_UXL_64;
>> >  #endif
>> > +       current->thread_info.envcfg = ENVCFG_BASE;
>> >  }
>> >
>> > And instead of context switching in `_switch_to`,
>> > In `entry.S` pick up `envcfg` from `thread_info` and write it into CSR.
>>
>> The immediate reason is that writing envcfg in ret_from_exception() adds cycles
>> to every IRQ and system call exit, even though most of them will not change the
>> envcfg value. This is especially the case when returning from an IRQ/exception
>> back to S-mode, since envcfg has zero effect there.
>>
>
>A quick observation:
>So I tried this on my setup. When I put `senvcfg` writes in
>`__switch_to ` path, qemu suddenly
>just tanks and takes a lot of time to boot up as opposed to when
>`senvcfg` was in trap return path.
>In my case entire userspace (all processes) have cfi enabled for them
>via `senvcfg` and it gets
>context switched. Not sure it's specific to my setup. I don't think it
>should be an issue on actual
>hardware.
>
>Still debugging why it slows down my qemu drastically when same writes
>to same CSR
>are moved from `ret_from_exception` to `switch_to`

Nevermind and sorry for the bother. An issue on my setup.

>
>
>-=-=-=-=-=-=-=-=-=-=-=-
>Links: You receive all messages sent to this group.
>View/Reply Online (#680): https://lists.riscv.org/g/tech-j-ext/message/680
>Mute This Topic: https://lists.riscv.org/mt/105033914/7300952
>Group Owner: tech-j-ext+owner@lists.riscv.org
>Unsubscribe: https://lists.riscv.org/g/tech-j-ext/unsub [debug@rivosinc.com]
>-=-=-=-=-=-=-=-=-=-=-=-
>
>

