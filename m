Return-Path: <linux-kernel+bounces-18867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 555A7826431
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 14:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56015B216B8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510FE134AC;
	Sun,  7 Jan 2024 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="KRwcOonu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD4134A5
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dc36e501e1so869828a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1704633487; x=1705238287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ7uDXAAmr0puYLSf6CVOO6ldyBnrL24XwRJb0qVA3g=;
        b=KRwcOonujkZvLDk23IydJ7raT1pPmI5W5MdUvKly/eu+7fRoEkMC4MssBnUWx5uvo4
         /WTsWB+4vZ0pmZnMtg3r6AsZQHJG2m9hV45wy82Nk2LLo8rZ9ier745v3/JZcupr+5VT
         ohcmT+V8Mic/63gi60k4O9iDgWuyleoiPWU+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704633487; x=1705238287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ7uDXAAmr0puYLSf6CVOO6ldyBnrL24XwRJb0qVA3g=;
        b=WW/MahA1tUiaSYt4CtgJPJsbmOydD+yXipd3aJdhu4aXWNdTXy8pq29k1ExIldieAp
         cR+KhOrRpoXdBC6O1n344jNfaX0/2KkVX2VUCCesT2V4Wa6bW/xBAUkIkS1tXP47boNS
         fA5XbkOTsHAdK066uurdmMO43Fkqdi06PLfGK0ZwifF9qKk18jlA+4z3qZW1Q9++bkkD
         BIo1ig/sq8icV9EprH/nkpD1jdwdvaVKAc1N5Y+OkKWYH30w2ZtrGxaHXpR3sRvHpEf/
         pvo7JOucRP4q7QndOFzO8tfvQC94UsGPvLxZqznvAKI5341upvKpNSC4IQXMwWlyAnsD
         tbxQ==
X-Gm-Message-State: AOJu0YzIXJuoKLlBR3MzoMXx9DXok25FbiD38sTixb/+hLHXfszNGE0R
	qOEoEUGB8Bkz2I4aUXPhQZUpP1TCo2IXH1b8a9jKvTZ/LmGtAA==
X-Google-Smtp-Source: AGHT+IEqD211Ve0cTZTZRpJxL6Z+iwiEuQX5fLYEIoQr6EnUMsxqUHjiyG7Mw5wc+LX66pgOMEUNst1U+Wmfhu3vkOg=
X-Received: by 2002:a05:6358:93a7:b0:172:98ae:cd35 with SMTP id
 h39-20020a05635893a700b0017298aecd35mr3194744rwb.29.1704633487421; Sun, 07
 Jan 2024 05:18:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107014248.3651022-1-daniel@0x0f.com>
In-Reply-To: <20240107014248.3651022-1-daniel@0x0f.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 7 Jan 2024 22:17:56 +0900
Message-ID: <CAFr9PX=-eC-FZmmOKK_beFvs05_moe8u0jGPrSyW5Xr=AagmTA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Use macro to generate 68000 interrupt entry sleds
To: gerg@linux-m68k.org, geert@linux-m68k.org
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi me,

On Sun, 7 Jan 2024 at 10:42, Daniel Palmer <daniel@0x0f.com> wrote:
<snip>
>
> --- a/arch/m68k/68000/ints.c
> +++ b/arch/m68k/68000/ints.c
> +asmlinkage irqreturn_t inthandler65(void);
> +asmlinkage irqreturn_t inthandler66(void);
> +asmlinkage irqreturn_t inthandler67(void);
> +asmlinkage irqreturn_t inthandler68(void);
> +asmlinkage irqreturn_t inthandler69(void);
> +asmlinkage irqreturn_t inthandler70(void);
> +asmlinkage irqreturn_t inthandler71(void);
>
>  /* The 68k family did not have a good way to determine the source
>   * of interrupts until later in the family.  The EC000 core does
> --
> 2.43.0

There is a missing part of this that updates the symbols used when
populating the vector table that I missed when splitting this patch
out.
This will currently cause a build break that I didn't notice because
the change is actually in my tree.
I'll send a v2 if the general idea is ok.

Cheers,

Daniel

