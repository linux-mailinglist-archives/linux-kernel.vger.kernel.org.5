Return-Path: <linux-kernel+bounces-154966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB46B8AE3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877812846EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2AA7E118;
	Tue, 23 Apr 2024 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYgE1nzT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB1E5D903
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871204; cv=none; b=ecZLXx2oHnacoeUZTgGrRRAnWj8IEVZwsY+N/vWJn/YikNzyY00dMB1c/KnIh+5auuT4FDIUL6LBLB+5j1WD6rBS8cLehKG0ym+owa1l5v22sZhGsd1GsEbXhn+EF498tRPrkHaFRRd6mASW46Uqz+9fSs6b2zkJ69UYQMKi0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871204; c=relaxed/simple;
	bh=YGgyJXKoN5L1hoziE8Pwb/hAAK4jMi3T8Y7cDVkU8b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMOJJUHPBnoUX+GPM1Ohtze7IK8OQG4pJOeI7t6FUjoZyLCCu3KiViiLSKHAbpoCm/3CVV2xoBSl7jg5M7ewL2iEpB4JdrVlMJxc5UK0bd0fOS1hkJld/FqMM9v7bch6J5crQ08iSNYx11mSbH4SvGqXnpvNotgnux3JmNplEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HYgE1nzT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4155819f710so45408075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713871200; x=1714476000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGgyJXKoN5L1hoziE8Pwb/hAAK4jMi3T8Y7cDVkU8b8=;
        b=HYgE1nzTDaNVlINjIWYMXBYK0SkbgrnmRsi4LXFGaecyAi10dBQP0UH33Esq2AAa3A
         jeuUL2eUE6ez1Oi+TdoIuu8GsbItuE057Agsp1i9elY0PwiF4gq51hzpc6O8VwkkCA1h
         4fnKviH33zDAoYKkhAS2PIXX2I2y9JEHCN+GW2VqbNwhz8d6RvYVT+JfmMjNmYqmebpK
         Mm2VPwRkM7vPpmHQLCZTujUC4fBaAHO1j9EApfYbiWXBZZb8QJkQwCGKodcc518cB+U8
         A+dapl4D5TvQnqQS5tLGsQTBwGOQGyW00FE1f4uvSPl+225ScismG7cDDGIAnTDxGVWi
         pzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871200; x=1714476000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGgyJXKoN5L1hoziE8Pwb/hAAK4jMi3T8Y7cDVkU8b8=;
        b=R7edmpXTQjIMvuAioftv+ZUqis4/nxJI1u60VPLcYipVkpwV11pc9UXts6t/W0H2iM
         pkqV3b4BdD0FYcnxzKnE8F0S+mqqrZpEhcBvhkr1xwJEcK5bgB63ZmJxtzA3jm/D+BKl
         qiFGnBuWDMAw2UCftLWfFWl4DnHPTSh5bq98bmC50eFbvDOUshas0gj3hCdHfZX46MP5
         WOgRqVEO9WFJyadjEw56I3DCFcfrcmFHuEjARRTQkYnD2Ni+iC0/eRkzxPRqJzRnNHcX
         RhUUQZTbMjjuhzpb/Ml6yzGkcZGMQ1JqDVIb10SEP+Y8OW0nPt0hMtVkfavN/UeEnQUz
         2LEg==
X-Forwarded-Encrypted: i=1; AJvYcCUnLy/H5gP/3vSzIzEVT6a3miej03yncT+0Hpgn2RvY7gjbBN4iuzFnDDNzje5amJ2GdhCh2z+wxNLBvj6VQ/8w4TjgBVg16T35wk6E
X-Gm-Message-State: AOJu0YxgVa6x2k0ahn6x9VRXRfspeHt6pO0onbquZ5TqnXzYTmxMO7Ia
	fiGzpGpmB3RyBs3oilbbe5HKsXeweD2tYnZQZyd2InjfpI+cLj31V8Y4qzLAUBs=
X-Google-Smtp-Source: AGHT+IHMKxMg+gfHErSx5FW+vINajDp9UAb8VLTHQPc43/6ff53K4UznbcECiMb2/I3QUr5myH9RuQ==
X-Received: by 2002:a05:600c:470d:b0:41a:c592:64ff with SMTP id v13-20020a05600c470d00b0041ac59264ffmr983585wmo.35.1713871199993;
        Tue, 23 Apr 2024 04:19:59 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g4-20020adff3c4000000b00343c1cd5aedsm14309973wrp.52.2024.04.23.04.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:19:59 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:19:57 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/7] kdb: Refactor and fix bugs in kdb_read()
Message-ID: <20240423111957.GD1567803@aspen.lan>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
 <kvmf4hcnoeuogggx5jmcqjch32shyswjv5cqvg4hwdg4g27rup@t4ddszao3354>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kvmf4hcnoeuogggx5jmcqjch32shyswjv5cqvg4hwdg4g27rup@t4ddszao3354>

On Mon, Apr 22, 2024 at 10:49:29PM +0000, Justin Stitt wrote:
> Hi,
>
> On Mon, Apr 22, 2024 at 05:35:53PM +0100, Daniel Thompson wrote:
> > Inspired by a patch from [Justin][1] I took a closer look at kdb_read().
> >
> > Despite Justin's patch being a (correct) one-line manipulation it was a
> > tough patch to review because the surrounding code was hard to read and
> > it looked like there were unfixed problems.
> >
> > This series isn't enough to make kdb_read() beautiful but it does make
> > it shorter, easier to reason about and fixes two buffer overflows and a
> > screen redraw problem!
> >
> > [1]: https://lore.kernel.org/all/20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com/
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> Seems to work nicely.
>
> There is some weird behavior which was present before your patch and is
> still present with it (let >< represent cursor position):
>
> [0]kdb> test_ap>< (now press TAB)
>
> [0]kdb> test_aperfmperf>< (so far so good, we got our autocomplete)
>
> [0]kdb> test_ap><erfmperf (now, let's move the cursor back and press TAB again)
>
> [0]kdb> test_aperfmperf><erfmperf
>
> This is because the autocomplete engine is not considering the
> characters after the cursor position. To be clear, this isn't really a
> bug but rather a decision to be made about which functionality is
> desired.
>
> For example, my shell (zsh) will just simply move the cursor back to
> the end of the complete match instead of re-writing stuff.

Interesting observation. I hadn't realized zsh does that. FWIW default
settings for both bash and gdb complete the same way as kdb. Overall
that makes me OK with the current kdb behaviour.

However I was curious about this and found "skip-completed-text" in
the GNU Readline documentation. I think that would give you zsh-like
completion in gdb if you ever want it!


> At any rate,
> Tested-by: Justin Stitt <justinstitt@google.com>

Thanks.


Daniel.

