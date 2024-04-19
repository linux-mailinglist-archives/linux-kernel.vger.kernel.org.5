Return-Path: <linux-kernel+bounces-151377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7C38AADC7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190DA1F221DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCD4823A8;
	Fri, 19 Apr 2024 11:35:50 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40781723;
	Fri, 19 Apr 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526550; cv=none; b=kgd+VZa1/33vyuxFfWVhvpbCoPDoX1VUF9f2OwlgSTAb6G0O8YUd85lRMKHq1iDqobpKxwomJoRHW/abcX+IDCxTuEU3ODLrxEW8mJ0+kv6Ba3sK0MsFNQD8+YOu00btH+Ge+hHgNzfPE2uHWGzmtrujXjvZl3H5d2iFTe5d/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526550; c=relaxed/simple;
	bh=rlq/tKihz5oJ2zPYopZmFp+AEw0r3N3aYzkfb/0gwG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfF+PcV/faiGVSa2vPQBfrdDa9SYN8iFAmrveFFDYcp102erO2hVbwQq/JawxKJV7Wu4GgX0tFGxq4uZaljDhQyarcoAykiCVOA0jwsogeF7RKP6fO/dKiyqA2JhbSFuxzQWXzpl17WYLgjC7tasWn8rfnQ/sx+C7mh08jZzPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so5331301a12.1;
        Fri, 19 Apr 2024 04:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526547; x=1714131347;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xJo1iE+MpyYnzTox+HNu4cFWvvore+ilh6MMNgutSg=;
        b=GPdFiCe7HCYhbkap68VjwROLljNSG6+zBaBH7Cay+KcouFO6Wx2KZl2Q7MjeMgsyhM
         KZboGhqz6Fzu3PhGc8xhLANauRUxEP4hMu7SGsZ9lehmqVuXj1epnbDh55ujj1RR11Hj
         ox07qJPtdDbmH+1utwsFXtjUR5bsTkP4NzCPMFlaz8AY6pve6GtN6i37SlwWVyRvpGJ2
         aJAUMexMm5YyExEJijdpj8LSAaAn7xYthCfFznB1tTKh/BeSuSbfbCpdWFWU1TxK72JG
         C1w8F0GfamtDe+EzC8gx7qcO4ppFlYTotZi/lX4NoAeMTdPe1Ifz+wSvoT97MwcnQxuk
         Ndmw==
X-Forwarded-Encrypted: i=1; AJvYcCXP9JnOK6pltPBDVvxY6ir91DAVyky+uoVlUCIqfiJRyuQf5X8FC/KyEXS4HGVWoMmjLWct1M+zX9U1IIVguBCZS5G2FRry3tKbZ3ZGw/fRfbapH04Mygwqi4mQ+InJegm67Dd3
X-Gm-Message-State: AOJu0YyO2F1007i+cQR0exBlpID0iP7Z1iRHefjez7YH3mthTpHfjgsy
	JuTIkPrzhto0GJG81vhRS2yedLTBVAuZBczSWVlQZME5rCQXkOO0
X-Google-Smtp-Source: AGHT+IFEKhC362/r5wnRQyZNa54ckAb3ZWlpqai659Js2s92JV+R17QDB+A3YiB2fdbs7kX1PylR3g==
X-Received: by 2002:a17:906:ae94:b0:a51:ab81:6062 with SMTP id md20-20020a170906ae9400b00a51ab816062mr4348557ejb.30.1713526546888;
        Fri, 19 Apr 2024 04:35:46 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id jp4-20020a170906f74400b00a4734125fd2sm2086049ejb.31.2024.04.19.04.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 04:35:46 -0700 (PDT)
Message-ID: <3f23b551-4815-4a06-9217-ff5beeb80df2@kernel.org>
Date: Fri, 19 Apr 2024 13:35:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Song Liu <song@kernel.org>, Ricardo Ribalda <ribalda@kernel.org>,
 Fangrui Song <maskray@google.com>, Arthur Eubanks <aeubanks@google.com>,
 stable@vger.kernel.org
References: <20240418201705.3673200-2-ardb+git@google.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240418201705.3673200-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 04. 24, 22:17, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> On x86, the ordinary, position dependent 'small' and 'kernel' code models only
> support placement of the executable in 32-bit addressable memory, due to
> the use of 32-bit signed immediates to generate references to global
> variables. For the kernel, this implies that all global variables must
> reside in the top 2 GiB of the kernel virtual address space, where the
> implicit address bits 63:32 are equal to sign bit 31.
> 
> This means the kernel code model is not suitable for other bare metal
> executables such as the kexec purgatory, which can be placed arbitrarily
> in the physical address space, where its address may no longer be
> representable as a sign extended 32-bit quantity. For this reason,
> commit
> 
>    e16c2983fba0 ("x86/purgatory: Change compiler flags from -mcmodel=kernel to -mcmodel=large to fix kexec relocation errors")
> 
> switched to the 'large' code model, which uses 64-bit immediates for all
> symbol references, including function calls, in order to avoid relying
> on any assumptions regarding proximity of symbols in the final
> executable.
> 
> The large code model is rarely used, clunky and the least likely to
> operate in a similar fashion when comparing GCC and Clang, so it is best
> avoided. This is especially true now that Clang 18 has started to emit
> executable code in two separate sections (.text and .ltext), which
> triggers an issue in the kexec loading code at runtime.
> 
> Instead, use the position independent small code model, which makes no
> assumptions about placement but only about proximity, where all
> referenced symbols must be within -/+ 2 GiB, i.e., in range for a
> RIP-relative reference. Use hidden visibility to suppress the use of a
> GOT, which carries absolute addresses that are not covered by static ELF
> relocations, and is therefore incompatible with the kexec loader's
> relocation logic.

FWIW:

Fixes: https://bugzilla.suse.com/show_bug.cgi?id=1211853

thanks,
-- 
js
suse labs


