Return-Path: <linux-kernel+bounces-20270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 943BF827CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BED1F2264C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE09720F2;
	Tue,  9 Jan 2024 02:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g4p/dwnh"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE51844
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 02:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7f58c5fbso3001908e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 18:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704765985; x=1705370785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LS2AfTuEPkpRNjb3ATL+rGVUQKPF6y+0SkjPID08igU=;
        b=g4p/dwnhjUCWIhWbnb9xa3hLX287dJk+ELeNXH7Il8PywmT+iza3TmHi8y1BfsW/PI
         SP1WNs8iYsGh0h1sXyDI3yqTEYFqJ+DanXtDnOzWa8C0LYgJmhm0vEy6AKCFhkH6QHHq
         m0twC22i5JlBG52gs+6ze4bAFu8LaRPEsVB/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704765985; x=1705370785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LS2AfTuEPkpRNjb3ATL+rGVUQKPF6y+0SkjPID08igU=;
        b=XsjhCV0b1ZZ63v8KlCWcAQoTc5Bn/7beOB9+VJAeIx/S6nW7AUgQWvdBmv4HQ9bq8I
         eyFduZH5RrBwrtGzitW2bofXRWkD4m2HgdGhZhobSODqfBYR+1ukAq4jEdCt1uB9DKqr
         Plq1eFc2NZfOAQdLlXYNfTOThkIck6/BdJgUEh+N8FliCAkXbDnKGFcHIBmimCoZBmdA
         XtX7WQdQL1Mn/ssckDlwdRvSsctW+ZcQ4dUEkdSGZEqcaqaYspbWCG2Jz/20AgrCRKwf
         x2my4zNIR+um+r9ucTsOW5AP2NG2POyKYnhC1mnsJ62JFuHhlX7cVEGdZqudN8DoTmhR
         7nWQ==
X-Gm-Message-State: AOJu0YwYPrxzKbf7EUCzfvWTTQRhmPv46gDPC/p3ires4eLGruukr/QM
	nBJLsRmiOQrXGrOaQ09/FkqTvdKvA1H5kfru+cVSiZzOMjh52brQ
X-Google-Smtp-Source: AGHT+IE9cUT6IJhNIoaXdMHc5a72vBv77jf08eP+sCKhUEoPz1y2EPloFUmJ9R6s+GPm/R7QoYnAXA==
X-Received: by 2002:a05:6512:3f1b:b0:50e:7b61:39d3 with SMTP id y27-20020a0565123f1b00b0050e7b6139d3mr2644438lfa.83.1704765984818;
        Mon, 08 Jan 2024 18:06:24 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id qk9-20020a170906d9c900b00a28da51438asm469143ejb.157.2024.01.08.18.06.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 18:06:23 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so2415737f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 18:06:23 -0800 (PST)
X-Received: by 2002:a5d:5710:0:b0:337:6806:f919 with SMTP id
 a16-20020a5d5710000000b003376806f919mr143715wrv.107.1704765983000; Mon, 08
 Jan 2024 18:06:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZvd5KZKVXAtM1+F@gmail.com>
In-Reply-To: <ZZvd5KZKVXAtM1+F@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Jan 2024 18:06:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9aEe9BuiM2DQNsGoUg=ZeQS6EfOs+0pz3kTZ=qvf=pg@mail.gmail.com>
Message-ID: <CAHk-=wi9aEe9BuiM2DQNsGoUg=ZeQS6EfOs+0pz3kTZ=qvf=pg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v6.8
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, "the arch/x86 maintainers" <x86@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jan 2024 at 03:35, Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Robustify pfn_to_kaddr()
>
>  - Improve the __untagged_addr() code: RIP-relative addresses are fine th=
ese days
>    and generate better code, and update misleading/outdated comments as w=
ell.

This does not even compile for me.

  arch/x86/include/asm/uaccess_64.h: In function =E2=80=98__untagged_addr=
=E2=80=99:
  arch/x86/include/asm/uaccess_64.h:25:28: error: implicit declaration
of function =E2=80=98__my_cpu_var=E2=80=99; did you mean =E2=80=98put_cpu_v=
ar=E2=80=99?
[-Werror=3Dimplicit-function-declaration]

WTH?

Maybe this has worked in your tree by mistake because there was some
branch dependency that just happened to work out because you had
merged things in a different order.

But that would very much not be ok regardless. Those branches should
be tested independently, and clearly they were not.

             Linus

