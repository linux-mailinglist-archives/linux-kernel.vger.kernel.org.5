Return-Path: <linux-kernel+bounces-24967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C417C82C563
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8D9F1C22638
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BD1175B7;
	Fri, 12 Jan 2024 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8ElmKwQ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B225619
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28fb463a28so725552266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705084016; x=1705688816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX2OIRKYqtC0J//p7kMK9Nn7FSvWIPNl2OJ4Auc3QVg=;
        b=Z8ElmKwQLqD7ksbSoVyp8nqXSYdCtuST22Ca+GPwj7MQ4aQFIGvcAopS9A6NC59/LZ
         MahKtOc1HESgf1s9wCPLB80kcGUl2sInhE27NPnSVikGE5yvyv6d71QYKUnVkGqIPpQI
         DB42+Av3LPKk5DwHHTZIx46L3m2gUoEncugV2Vy06AV8rvf8K6ipCmAdzyTpxg3FQnJW
         3GQFfl8QmMPNq8FYKWoOqIAGHJLWH3Bm8ZU1bL3y8Ae4k5eUVDE5nzFXUWeuHtiIBM4W
         JF0bONvOkgobcEdKCkt313N7ycyHfAstN8zPUjm3sBgNeXV192mNmOVmYa9h07ONS7E/
         PzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084016; x=1705688816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BX2OIRKYqtC0J//p7kMK9Nn7FSvWIPNl2OJ4Auc3QVg=;
        b=WcfpNyN7SiKR8Zn0jUPbsdEGK8DA1nvjImd8mSomYf06Kkmxn1+L/sOf3GhQPw+MA8
         eTE1fFYlT8YTwGuOV0+xOgGbX4OaBnqsLvlasSifC1weF7iJiBCzyblPTqVHS7RjxPvb
         uT4eWGO4y4rvlBiGLkVhLe4lNzhMdd4VaWOgE1Mb6Ze9KGnHe8zfA2lSg4qPLsgjRPiy
         /NFnEmtxmxB7a8Ws5vqOzwk0Z+ML+InnpkuAKG1O2uSN/L1gXvvoVO8ZLOAwZoE5qt2z
         hPzECvMNDKVkSWZ5+WcA1GnzmRg+F7blPMDuFvWpxmWFJL6aC1CLsEeqAxY+spGjEaUe
         Ihtw==
X-Gm-Message-State: AOJu0YzahRnJmZcPjoxG4PAWzeUdG4VJdH8pimHo/zq5Lho/LM848KX5
	7TmeHRiLYfGztrE6JCvoV+E=
X-Google-Smtp-Source: AGHT+IHDCHmwvZIDF1k+St+jTaCt9HJQUMS2UP+ZZIPy7es1LE4HuBzP68Hd790Z/5UA9ZXntOkJ9Q==
X-Received: by 2002:a17:906:88a:b0:a28:b71d:6801 with SMTP id n10-20020a170906088a00b00a28b71d6801mr840254eje.149.1705084016358;
        Fri, 12 Jan 2024 10:26:56 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id ll5-20020a170907190500b00a2cc5199dd0sm876407ejc.135.2024.01.12.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:26:55 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 12 Jan 2024 19:26:53 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
Message-ID: <ZaGEbaa3bWVYiqhY@gmail.com>
References: <ZTz9RpZxfxysYCmt@gmail.com>
 <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> This is on a 32-core (64-thread) AMD Ryzen Threadripper 3970X, fwiw.

Same here:

   model name	: AMD Ryzen Threadripper 3970X 32-Core Processor

Could you please send me your desktop system's .config privately?

If it's triggered by something in the .config, I might be able to 
reproduce.

Thanks,

	Ingo

