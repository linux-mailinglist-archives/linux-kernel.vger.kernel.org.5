Return-Path: <linux-kernel+bounces-22839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A6582A3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB2528A86B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F0C4F892;
	Wed, 10 Jan 2024 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CYXg4ZNP"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E404CE1D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso5620221a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704925172; x=1705529972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1pn+yGlQbDvVpIEQ51Lj63hjmKrdoB01ABnRTe1WXO8=;
        b=CYXg4ZNPeBah6O/diokgPMR+p4RY6KyF1d9t5oxf5jYTduGslBcqbp5eddaaa7sqdQ
         In4+nxPy25RpMxqgE2+D4CI5HOoWPqxovmPCf3YTkpeEULsY+orcxzgB3Koz+ofNjNWg
         8dhLL6znU1DGkut9FSLT/uFJTbBDYBMfe5Wak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925172; x=1705529972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pn+yGlQbDvVpIEQ51Lj63hjmKrdoB01ABnRTe1WXO8=;
        b=aN773XhGpIDHH3gjIAT/w8Z79pYHhi+B20eoeFFZD6dILS0GoB8pgU55ZcEQmBoswP
         GIti5souL18V9+gh5iBy/oHuLs1+jpO+naVKDtHqZ12zOGN4ILddda5zQmROcglcsfr8
         U3TcS631zCI8e27Hb6oSnjIcz8VGiBi6ZPs0iUyTYmd3dGyoBjTcOqa486tzd+ZH/3fY
         hwYCJE5eBCxRmqjn1lwYgp+t0XUx8dt7gL6/740G4+cgV099Ryc50YCwZT4hoXVupBci
         lh+DX9fP7Q/Qn+UpFrTdYNgHQraYYmm+kiET6236kqdPnoHL690eKmCfe+UMhg9kAfEL
         afUg==
X-Gm-Message-State: AOJu0Yxrkg+2F/L8rgl1soCUpKsbzCf0I9X72yxYd1dPoYXWxsadhPzT
	wYPPt9pnt52JkEI0Six5x1MIAUfR9VkmX9ObkfD+b18pMRdY/DyH
X-Google-Smtp-Source: AGHT+IEyAPK8hk3wkYV8KwI58Jfhhld/6bO4Wp65D/GETQNo8IQppOQkgfk7MaZEPsdKk0lWt0EZXg==
X-Received: by 2002:a05:6402:26cf:b0:556:ef38:9b04 with SMTP id x15-20020a05640226cf00b00556ef389b04mr46413edd.122.1704925172692;
        Wed, 10 Jan 2024 14:19:32 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id s7-20020a056402014700b005576f4471besm2396853edu.42.2024.01.10.14.19.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 14:19:30 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so549691066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:19:29 -0800 (PST)
X-Received: by 2002:a17:907:3a08:b0:a1c:b6f8:6987 with SMTP id
 fb8-20020a1709073a0800b00a1cb6f86987mr57694ejc.16.1704925169419; Wed, 10 Jan
 2024 14:19:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
In-Reply-To: <ZZwBi/YmnMqm7zrO@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 14:19:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
Message-ID: <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jan 2024 at 06:07, Ingo Molnar <mingo@kernel.org> wrote:
>
> Please pull the latest sched/core git tree from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2024-01-08

Just a note that I'm currently bisecting into this merge for a
horrendous performance regression.

It makes my empty kernel build go from 22 seconds to 44 seconds, and
makes a full kernel build enormously slower too.

I haven't finished the bisection, but it's now inside *just* this
pull, so I can already tell that I'm going to revert something in
here, because this has been making my merge window miserable.

You've been warned,

                Linus

