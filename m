Return-Path: <linux-kernel+bounces-153609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4758AD05A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8E31C21771
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D59152516;
	Mon, 22 Apr 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGpcVcff"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38E13E8B2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798707; cv=none; b=YISnqRQr/A3SCq4/6J6UCBHCG7yOJwX5JCDbVbl5SyCEsmsgj+MalLkjjkhPhVKxf+h8gXLVUKsI9U2svSBas15gv5U8dPS8SqB/7T+VjdjFdRVrEIRj70DwQ/yojiSm5STdFFPwAJy2CH2TkiUe+Us9mlLOD6gsEkb+W4V4ids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798707; c=relaxed/simple;
	bh=p54kIRAzaODe6wUquUv5sKINcmN5+ASrjgui2vl9nbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvWS5AXpA7Fq0UtvVJzJp6BFYRp9pjN1QBDApOOiehC2yk9qGpfPPzl2zvThDNoOWbqLolj0j5l5SU3jz7crNftjofRm/Umo6NNhL0nrMW1NLcpyKvSTZ9rzaLf+9uBNWq5IHm14ajycxIS09fdWZZVfyj82fz2FyrmUU2s28EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGpcVcff; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-571c22d9de4so6021280a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713798704; x=1714403504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVITbEQ69WrdRCplMyU1YjsnhDBFhFV+4YLUj7UPkFc=;
        b=OGpcVcffKlK3/ril0w9FQIZM5ort2Oq4HPF5gewgAU8U0XMsGDj7j2woC/Iq6TOkmX
         mL8ZzwGDROKo/pAjBCht71epAIyLCQGyYPl8N5X6jiW4NTy1UhkRGzHpaRx0cRsKMwwl
         l5vAanwe5+IRzx2w92/2Ax176JXFxBWpK/e+Jr9b+T9y4o8BIQsaDpFb3Egw0n5ywBaF
         zIz1hijHT2mZalX+YqhLOVpmSaioIdgq/VJFjssDgYdo4/dJjNpzarKK6QWFBo80RbrA
         VzxFKygFmzYHhXzzZEoytkEilibVDB5wLfiXX1DTlG5DPT4VWNps/QWC+CVrORU+pv9s
         eUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713798704; x=1714403504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVITbEQ69WrdRCplMyU1YjsnhDBFhFV+4YLUj7UPkFc=;
        b=n7lw1C/mo0CHNgxay6SM+gcW4JsrAZSRVWdsxVWKLpnlUtAfHQPLU6kJjYKDDDknD6
         vIkt3jqvPH46+V/EyU+ybinrlYv7XrincSabJAui2Wf6FuhVxtIhb5jlDD+fv38zUp7S
         a0NF8jddqqSgwOXVBlUUzQ4RoF5MFgXiXftFzX3bibv9RHYIpVtNtJSWVS+jogSObYQ1
         lH9ylH1x/unBvsv2PyGpLm8Hf/NAqe+NPrVbatIaltFLBz8pjIiceHd4bz4qShrZO242
         x2xI0kSZ5Grg/d7OgbIiRw1qE7IJ4D8dJ3t+D0whWr0UZ0D5Hd0/1BUWDg5M1Wa1sdR+
         XTLA==
X-Forwarded-Encrypted: i=1; AJvYcCXiXydWqElaTiMFIana0mmxAAH7cjRTnpajQzur0/4mudYU4c4WRx1JqSxsTMGWmFmsT4RtuQkPVzVVOVn9txAiAPRaegv8C9qAl4AV
X-Gm-Message-State: AOJu0Yz+ofNm3mRMo4blfhpqZTUeRX8Di5FNjCZvJBwZWGdaAsyxSGFw
	i0uM1Okm6QU887RtMCP85tbVvRSniAP14R6+MED/jgDQ033MbV8oftLBiFISUr1lX8/e6UCFU4S
	t/gCeEwsBadNv22fgXZXW2aqQp9KtceDHyZA=
X-Google-Smtp-Source: AGHT+IF0RAOTKc0Ne90DEw7v8X52QNp6kNAWxjGyWQNxLN5JErTtJO+d1iN6BBL9lCuHLsLBP/o/88fZ7/AHXO/6ZVs=
X-Received: by 2002:a50:c355:0:b0:566:2f24:b063 with SMTP id
 q21-20020a50c355000000b005662f24b063mr6572940edb.23.1713798704099; Mon, 22
 Apr 2024 08:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com>
 <uekqafv4wx5axijnnfybnxixui3ruzy3mkxirflv7tb3ovrtbk@ounqurycykuv>
In-Reply-To: <uekqafv4wx5axijnnfybnxixui3ruzy3mkxirflv7tb3ovrtbk@ounqurycykuv>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Mon, 22 Apr 2024 08:11:32 -0700
Message-ID: <CAJg=8jzRT=oA9g6AGd1KmAY3GBkKkczj1rCqQ+pik5LmUQYd_A@mail.gmail.com>
Subject: Re: general protection fault in mas_empty_area_rev
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Liam,

Thank you so much for the response!

> >
> > Crash log:
> >
> > general protection fault, probably for non-canonical address
> > 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> >
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> >
> > CPU: 0 PID: 79545 Comm: syz-executor.0 Not tainted 6.9.0-rc4-dirty #3
>
> This indicates that you built with your own patches.  Could you test an
> unmodified 6.9.0-rc4 with your setup?
>

I'm very sorry for this oversight. I had applied the patches for another bug
from this conversation
(https://lore.kernel.org/all/20240404070702.2744-3-osalvador@suse.de/T/#m480f21ab850996395082d0faab7f624f45b83781)
I will test the reproducer without these patches and get back to you!

If there is any other information I can provide to help you, please let me know!

Wishing you a lovely start to the week!

Best,
Marius

