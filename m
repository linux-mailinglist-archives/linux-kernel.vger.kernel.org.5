Return-Path: <linux-kernel+bounces-129829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D32598970E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E73F290DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783614900E;
	Wed,  3 Apr 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSNDfrU1"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B671482FA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150778; cv=none; b=J7SUIXfY6aUOgi7RTx84AOebM7va6O/hzF4l2swpmyyP1GoI440kpFKk1JAY7HS92MmjdSrA/bGRvPEsYKvua1FsGxiFIISfxfqW7jSAxitwBM6eiKTAT8gj9aaedSpEhJxEah8L5ObqxzXuXL9IaFvuo2FivrBkLrBQO4NkyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150778; c=relaxed/simple;
	bh=/ZFx3ebO9y9cafs7GJSvKhCZCl2L53c7NYdEippbANY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nC2J2NTSuDA7bn9AqUmEYKmEVbJIv7wyU2mwTe00qPDk/DBRCMn5VYlY1gWrDn5uLY+KFlp/ebJYunfpCcSP/VKi00E63/PmrJxmJLx8nKK7G/aVjcTpZJfJMi2N6FbcUKenk4taAKyaPfENZEkIdSDzrwz3jFRoYNpE8gybVts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSNDfrU1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso4582430a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712150776; x=1712755576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kr5yQL8fx0u0tyLMbu3sLuMSllEG5G+mAeHccxYfdVY=;
        b=WSNDfrU1A5IuXWhh9HEqfMP+zlmpZ+t64/OBY35FevtWwhqB8nNVHgahOdCX79SOp3
         1yn4HDv63eYR79bakZ9SkDgU02BXUgYL9Wipu16c1zbX53EgqjoEXfn9Ts3KixMoQj8e
         ZT3d9gYmEjpubF0RDlGKNv3zHXYOgSHzz81a68rJm6oZ/xNJVXvfsteVWByLQ1UANfeU
         ybeLHoHUWN8KZwzf7IWlteXQvzSC4yGMukXof5DunOP5/NkU/nTmJDZOa1BB123Uw7RB
         ceEVVEephv1GR+LLJftUFK8eNa+o1E/zwIime3eFHQpxgsQziB+wm/Tm99kxK+BMUdib
         CLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150776; x=1712755576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kr5yQL8fx0u0tyLMbu3sLuMSllEG5G+mAeHccxYfdVY=;
        b=mUh9yjJk4YYWg67wb9Bq7xFawGVALn0EqNUKuRieXufVvaH2bu81Nz9AI8gS5gidjj
         jYAb9jcHFjQvCk5qQUNF5D2wz8aCeVtKsGkt9mKB++h9kJiVT/VtRw4SQyPB+1NesMzM
         MMVvEm/d2Xn08DZwbLtuZNji8YKoqbj1ynHyYfdzaSOQ6cV8+cBRJsuo8nSNIJGaQrVs
         ZeM153JsslEl7wuYh5ZPhWX73I2bfpcZb4MtHprSwZT0j/ceNnUzCIe48IQ1VizxnMn1
         6myw9nwXJPKSzhGuAA3KtlWdVcE9LE3oCuQ2nYhYysuQxZWaEmuWJMuCQrN7k2tqATy6
         FGig==
X-Gm-Message-State: AOJu0Yx0qOK+y4J/+ncurJyyYvnzjfNj8zoUxZMtwzTLnVOM0DBElHFh
	3OGUaTrd0HQxYc1VA6g6zgPzZSMIpm0J0sdWyePbnTlt/cgobOSEpMz0qQtYJkhr4pooCmWns3C
	k2MlJ6kfL4+mfwviWR6g+V8zBp7egNBu12lJCMA==
X-Google-Smtp-Source: AGHT+IEak/WLSgffbuVSjwab06JTulWpxWfMzkQ8I6F5L8nOzPRvaiqB048L3gfCz5mrvMfqk7JY/JqIUVyg8IDxNG0=
X-Received: by 2002:a17:90b:19c3:b0:2a2:a7be:3b5c with SMTP id
 nm3-20020a17090b19c300b002a2a7be3b5cmr1005626pjb.6.1712150776261; Wed, 03 Apr
 2024 06:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtj3aBdRreBmKZDQApEe2x8mugycPgN+_J5ebJzXDEq4g@mail.gmail.com>
In-Reply-To: <CA+G9fYtj3aBdRreBmKZDQApEe2x8mugycPgN+_J5ebJzXDEq4g@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 3 Apr 2024 15:26:05 +0200
Message-ID: <CAKfTPtC9YgbZgGNK82MhhzzsD3P6j64+w6oieJMDKQNOmrC4FQ@mail.gmail.com>
Subject: Re: kernel/sched/core.c:961:15: error: incompatible pointer to
 integer conversion passing 'typeof
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	clang-built-linux <llvm@lists.linux.dev>, Linux PM <linux-pm@vger.kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, linux-riscv@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"

Hi Naresh,

Adding riscv people

On Wed, 3 Apr 2024 at 09:38, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The riscv clang-17 defconfig build failed due to following warnings / errors
> on the Linux next-20240402.

Could you confirm that there is no problem with other arch and/or
other toolchain ?

>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> riscv:
>   build:
>     * clang-17-lkftconfig - Failed
>     * rv32-clang-17-defconfig - Failed
>     * clang-17-tinyconfig - Failed
>     * rv32-clang-17-tinyconfig - Failed
>     * clang-17-defconfig - Failed
>     * clang-17-allnoconfig - Failed
>     * rv32-clang-17-allnoconfig - Failed
>
> Build log:
> -------
> kernel/sched/core.c:961:15: error: incompatible pointer to integer
> conversion passing 'typeof (*((__ai_ptr)))' (aka 'struct wake_q_node
> *') to parameter of type 'uintptr_t' (aka 'unsigned long')
> [-Wint-conversion]
>   961 |         if (unlikely(cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL)))
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is no recent change on this code. Could it be a change in
cmpxchg_relaxed ?

>
> Steps to reproduce:
> ---------
> # tuxmake --runtime podman --target-arch riscv --toolchain clang-17
> --kconfig defconfig LLVM=1 LLVM_IAS=1
>
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240402/testrun/23264917/suite/build/test/clang-17-defconfig/details/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240402/testrun/23264917/suite/build/test/clang-17-defconfig/log
>
> --
> Linaro LKFT
> https://lkft.linaro.org

