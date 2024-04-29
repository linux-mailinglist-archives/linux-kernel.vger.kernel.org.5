Return-Path: <linux-kernel+bounces-161860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D728B5258
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D92819A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE41400B;
	Mon, 29 Apr 2024 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv71eLrz"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601714003
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375762; cv=none; b=vARSK6s0lQkoTKaZCT5m2QAVKjK9wsko41cRn3R4oC9cz2npU5yOeUAkx2R44M9l6nuNjdlTX2sm/HOXV4I59rjwJTVlrMJ5aTfrl74D79UBzYdTnPcv+LlKnvKUGuzCydey2nrlsXPdn+cl67WpKEUIRfQ7QIGA8qK52mL7Pe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375762; c=relaxed/simple;
	bh=c0lpz2Qh0TRY3qoBo+tgJXq6WMAL2Gvx8twSzbgM/XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHbZJ7nWF0ZaV8b5l23U/eh3ABUl/qnTWJNiQ0iVM54brbOn9SG9uzyP4Yvf6S7PoeZQjpCXteTpYVzYR6NAPUaRyokgUscEBTgUyHbhmmAsITRIeoBAUduk4PyPAr8VGEpkJLUf8sdnLCdXftufSJjMmzVA5vP2yI/dGKnjRcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv71eLrz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-346406a5fb9so3524327f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714375759; x=1714980559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TI3u0HfmXhOp3MPGR5XsLgD5K1uHa/+3lLcorrjRuuY=;
        b=Tv71eLrzZsrircVg/ZqMLBV4wpvckifdix5RPEocMqABack91mehpgBCdWstT8A5/2
         +YXyUI59tdFWyGO3VXmq6G8xpETqCjWrfsC7mvo/bveXSz9Mf+pYllJJl4jsljw19IBp
         kgEoR9BjCi5IK5g8Ae3Nc8WgDJ/nJgL1ZBXReJ7ywHc6ZrkeqUbUFFbAog0eV8X8cP9h
         c6aZ0AhJ4N7YtaaD29gPcUt4CSzaenLjd3kf63jgqh8dpiItqKW/tdtOmyKKhs3QZkYJ
         6tRZf5Km4UkhojYH43pdSXKCe0RZ424k/37RMrcG0gUT1BLmY1/UAkwMSEbThz1RDv/x
         7lSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714375759; x=1714980559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TI3u0HfmXhOp3MPGR5XsLgD5K1uHa/+3lLcorrjRuuY=;
        b=Ziz+UOrzjqXf485poYObpFK96EBeOJwy1VlxvStydtgIzWtp7I401Za85G7Ufnjbgo
         wQDOz0IYtALR9d/YPTneHh/OSjY/eBYTxx5MwZ06sCC7bKHzPeysCiNPU02A7eIyiNK1
         O4Vcax+Vsct6UdM/adMC1mIwSmbEKC7MI6/CwhhCXplTeRA4nsCXKNjP5NLbXVwQihCd
         n28Q9aCO9A0+Bj0ZpedZ+94bGE72DRknItrpU3iPTaaYx2QyHwS0U5ObkzJ3/jvc0yVT
         pubDdDHOUQXJCOFqECJyl5iqrclooI8A0c40idjk1hPLaiU+Xi5P445v5z6wVBrjLoFA
         ZmVA==
X-Forwarded-Encrypted: i=1; AJvYcCWJIlbm6H2RXPJWTzzNQSuT8VwkJqI3qVTut9975yRM9rVbNA3pMXgO0nix8hONIGeHSQm1bZ3vD+/tfX8CTKXsJswalgcq/LByx7Mn
X-Gm-Message-State: AOJu0YyJTULf9YOMUEHghqt7pr436Ck//UCLJR54uXKIKfLNdeWcKqh8
	TpFmlzf4w9sHxDyr/2iomrPxz2J6MQD+ZwZgeBoiWLu6WPr0Ltgc
X-Google-Smtp-Source: AGHT+IGXykTz1S0PsdC1dfHyQj/p0LT0yjYXFAbNzNii9VZGalCldPNUmRmTa61or/NuZbG0on49hA==
X-Received: by 2002:a5d:6b0b:0:b0:346:e9c4:65b with SMTP id v11-20020a5d6b0b000000b00346e9c4065bmr6135504wrw.27.1714375758600;
        Mon, 29 Apr 2024 00:29:18 -0700 (PDT)
Received: from gmail.com (1F2EF175.nat.pool.telekom.hu. [31.46.241.117])
        by smtp.gmail.com with ESMTPSA id o28-20020adfa11c000000b0034ce8f59fb1sm3053810wro.3.2024.04.29.00.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:29:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 29 Apr 2024 09:29:15 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] scheduler fixes
Message-ID: <Zi9MSxZoPzqZRql0@gmail.com>
References: <Zi4HyMFJBwm+JIKZ@gmail.com>
 <Zi4MBjmqMr0Ndwpf@gmail.com>
 <CAHk-=wiP1KA8sg9=PVTs7Xj_AC7yDpLujB6Sw=Eofg5Jtn0ymg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiP1KA8sg9=PVTs7Xj_AC7yDpLujB6Sw=Eofg5Jtn0ymg@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 28 Apr 2024 at 01:42, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > Merge note: in case you are wondering about the timestamps, I ninja-rebased
> > these two commits shortly before the pull request to fix an annoying typo
> > in a commit title.
> 
> Hmm. You also forgot to have a diffstat..

Yeah, sorry about the over-eager email trimming. You did end up pulling the 
SHA1 I intended to send to you:

  # https://lore.kernel.org/r/Zi4HyMFJBwm+JIKZ@gmail.com

  >    # HEAD: 257bf89d84121280904800acd25cc2c444c717ae sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU
               ^^^^^^^^^^^^

  # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=245c8e81741b51fe1281964e4a6525311be6858f

  commit 245c8e81741b51fe1281964e4a6525311be6858f
  Merge: aec147c18856 257bf89d8412
                      ^^^^^^^^^^^^
  Author:     Linus Torvalds <torvalds@linux-foundation.org>
  AuthorDate: Sun Apr 28 12:11:26 2024 -0700
  Commit:     Linus Torvalds <torvalds@linux-foundation.org>
  CommitDate: Sun Apr 28 12:11:26 2024 -0700

      Merge tag 'sched-urgent-2024-04-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

Which, for the record, had this diffstat:

 ------------------>
 kepler:~/tip> git diff --stat v6.9-rc5..257bf89d8412
                                         ^^^^^^^^^^^^
  Documentation/timers/no_hz.rst |  7 ++-----
  kernel/sched/fair.c            | 34 ++++++++++++++++++++--------------
  kernel/sched/isolation.c       | 18 ++++++++++++++++--
  3 files changed, 38 insertions(+), 21 deletions(-)
 <------------------

But I should have included the diffstat (statistical-) fail-safe in the 
pull request.

Thanks,

	Ingo

