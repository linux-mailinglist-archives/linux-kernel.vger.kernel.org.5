Return-Path: <linux-kernel+bounces-78560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1809A861508
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5691C20CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C46E60D;
	Fri, 23 Feb 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyyFnYft"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE121364;
	Fri, 23 Feb 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700440; cv=none; b=lriB3wyOt+VOtbr+7GxvN2MyNeksXKcKCybjeIQO5skpKPDR0J+7Btr544K8SE5wNecGaA7H51SslkHq/CX7JO4moBCgUXiOVNZGK1i9SBBGv3U1yu2dReWYPtoZTcaDNURLSNLvzlfkvSc7wMbfIyfgFt+6Fzh7gwL5jtaVCQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700440; c=relaxed/simple;
	bh=VgUlltsMr74niDfQ33mjF/yfLalcfE+W+x+KMUOuyVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b47mL1dtNuiwEFSEsi+7NOnT0ScxLJqpwVQ+/IInsj/o8+Figrv9spkEsNuiDiD8qG0rXuhYVEfJ7KwGYdqVTxOLVUjb9Kqt9Atrc+c7j3hNBqdurYRehZBj5pW3VklEJOJwwAE1u3TYyDguW5hlvEXRiHE10f9yLfRk8T6SLJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyyFnYft; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29a950152bcso9087a91.1;
        Fri, 23 Feb 2024 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708700439; x=1709305239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuiW3vgYamUonIgJifnWsdJ41+amBUZpTSrVUyXFt1U=;
        b=EyyFnYftso9DrHFua3wIMf8ykogWSe4vWkPEOAszMFrbYUrIWfefnB05UIsT3ufc47
         OXfIVTx4FB1STGWbHYVgPPxmNjxE+eZBrEXW93Sr5D3S7F37seCilsjROyqawhJllzbo
         xYd4ylRQ7RA92rge7f2QbQEPFGrLXqxhftjg1hkUk1Fxn9LICNUDKd0RTGAZIYEiWF6U
         MTRsXxFZ6uqwiI8CJKfP6B0DAw9PhpiNFLyqTYnoVTlid6Cs99QogyfjeGAr09MjomT8
         aEA8POErgLLuOSHm2Nahs6QSTr+LGY/Mx4ord8zCU1nNnqpyvkVamAdirF/NxyoS3uLy
         9qLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700439; x=1709305239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuiW3vgYamUonIgJifnWsdJ41+amBUZpTSrVUyXFt1U=;
        b=EyayzB4fJDZtcPQEKqa3HVFW1Oh/a1P/BODQ0q76rQYXi9REwOpzpauy2NZWmxhqqx
         CcFOEz7yLXNefT4QO6rHuhMXJNxFe7v/S1KXFz1OpihDnyK9m0ZPuk6CUp3biNwGpxQJ
         ITk1B/RDtf7q6uZvezKh8yCy6Lap4i2VxZ3QcjrR78luKEq39G0b/0DqtWFVhMpjoe8m
         Kjq4kQPPBpUb3pzev33+Lb+Bsh8uH/93qulLv00huU5LVpxadPvOXJlmrUDC/spxPhlN
         xwschvbJ67XpM4JssiWbZBn87HhVE5Z23/Tc3BGrnFtWqtoImRq3WOH5xpxOHaX8CVtO
         F1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWfDYnboA8GgXJk8XGSfX/7v45TBu2t4/+MQOlpH1g1oEDC1UKKViRV/yjHhduE/92qa4F7WBXHgBhliWLY3lJLPtlL61TnqbHAKmcY/wYjVXd100PI7aAcoBmUC+e6SnrS5bSk
X-Gm-Message-State: AOJu0Yzbp7k+XowdmzKst5QAlGHl14aRKt/cgwjUu/H0xiWVLpPmbzed
	c1Uk5Ir0OxeWBatE2vOp5U7dlj4M/b9BzFLfSxOdVJBsWQjj3TwdteehvhMC+UvNes7zD9T+Y95
	zK1Wf1+0AOXfyB88E5Zn70C7L2uI=
X-Google-Smtp-Source: AGHT+IGZGAqQ4Z+lKDdINw8JgTnWczel16tJ9w9dUi0R7tIHS4tgrZpBIDjoSZIuhhJsPtR6FsmUCrBc2ciVrayq/ok=
X-Received: by 2002:a17:90b:364b:b0:299:10c8:9c95 with SMTP id
 nh11-20020a17090b364b00b0029910c89c95mr58077pjb.20.1708700438618; Fri, 23 Feb
 2024 07:00:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223-x86-insn-decoder-line-fix-v2-1-cde49c69f402@valentinobst.de>
In-Reply-To: <20240223-x86-insn-decoder-line-fix-v2-1-cde49c69f402@valentinobst.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 23 Feb 2024 16:00:25 +0100
Message-ID: <CANiq72=2T9br4G2E5Ky-NgX-VgM2PJoDZ0NGTrzG7xXmd0C=hg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/tools: fix line number reported for malformed lines
To: Valentin Obst <kernel@valentinobst.de>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Baublitz <john.m.baublitz@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, 
	=?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:17=E2=80=AFPM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> - Explain why this patch fixes the commit mentioned in the 'Fixes' tag.

Thanks for this!

> - CCed the stable list and sent to all x86 maintainers.

Sorry if I was not clear -- the "Cc: stable@vger.kernel.org" needs to
be in the commit message itself, see:

    https://docs.kernel.org/process/submitting-patches.html#select-the-reci=
pients-for-your-patch

But I would wait a few days for a v3 to see if x86 says something
meanwhile -- patches to stable need to arrive in mainline anyway :)

Cheers,
Miguel

