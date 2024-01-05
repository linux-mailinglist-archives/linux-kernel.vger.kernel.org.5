Return-Path: <linux-kernel+bounces-17702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991A5825158
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA0289B76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913BE24B42;
	Fri,  5 Jan 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgHgGLPF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D8824A05
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55679552710so6455a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 01:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704448736; x=1705053536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s2WgUp2uwUQXzqO9cBgyU5Zr8leiFxlRGNJ1vYv0Dw=;
        b=wgHgGLPF/4pmwqtpKGyRRzEUDBNVHsanWh+stIS1absDp5cjbmXjY6Geg0HjrdIl0E
         9aeMtYtKAtx4ihKOhAfumLucu+I7rRr94TZT4D/5wZ54L9J3nxwX2CgXrR9Sg8nuiNtM
         v0WzhRBM+z+OOptCIZ4CThp9GPnh1ij2cQubuOz0bxs8ieSW3SAnqEeOcf+B06sUgyUa
         0+OIIAF2zZyTxlz+zYoEmga/9fpTFbj+z/vDOzhsMJ26/SKM1fpb44G8ATwQEMlJnQ5R
         mVrBE6+T7Dcpp052gjtqvSlT9bWs+DVtOgpjv02EQIAwCFl+PVibdFXzUYDtAZheL2JS
         0ekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448736; x=1705053536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s2WgUp2uwUQXzqO9cBgyU5Zr8leiFxlRGNJ1vYv0Dw=;
        b=BiBnjeG+K5Ox0sbNxndy8vNtvGD0tXwC7vwM6t5hOs+e2m3zTz/0ePzd/2hzWZzcbM
         Rxnbg81TbmyBZU9xzrjijwq8ZJo4rgBF1jlYPKy7i+yKwiL1HUiLBNLozbDwsFZ8q465
         inqkjkeNmE90cYWtXxw5fUekMNKqwFYKvaNyEu6QlDiS5HPLaw5AQ4/x5BoLiaOGO1Vt
         qLM9bfMUn2sH8UPil3cbU985c8Dd03OzxO5X4iSxHpArqobLyunIiXuY6IfzwmXW+ukJ
         zGbhAzm+udvUc2WlYPvPutYLq4+c9oB2pFIYabj8AjnIrUTX/zOBhuretJcCzeetqPCG
         NyLg==
X-Gm-Message-State: AOJu0YwaCYub9cNlWp0z8BmqfF1mI/RkZjK/M0kVm3AReO/kmhEWy6mp
	6sazU68G3dAmaf5UYjos+bCmg/j5DhsUUTTL1euDEfLiGpoC
X-Google-Smtp-Source: AGHT+IGo7jibauBuN19b7YPIMXdE4o8bzKuR2Wyh4RI9gBM3m94poauJEZy+g8VlmFYxEhnFLZw28+1UZucXoNdFHv0=
X-Received: by 2002:a05:6402:35d4:b0:557:3c8a:7242 with SMTP id
 z20-20020a05640235d400b005573c8a7242mr22196edc.3.1704448735539; Fri, 05 Jan
 2024 01:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105091556.15516-1-petr@tesarici.cz>
In-Reply-To: <20240105091556.15516-1-petr@tesarici.cz>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Jan 2024 10:58:42 +0100
Message-ID: <CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: protect statistics updates with a spinlock
To: Petr Tesarik <petr@tesarici.cz>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 10:16=E2=80=AFAM Petr Tesarik <petr@tesarici.cz> wro=
te:
>
> Add a spinlock to fix race conditions while updating Tx/Rx statistics.
>
> As explained by a comment in <linux/u64_stats_sync.h>, write side of stru=
ct
> u64_stats_sync must ensure mutual exclusion, or one seqcount update could
> be lost on 32-bit platforms, thus blocking readers forever.
>
> Such lockups have been actually observed on 32-bit Arm after stmmac_xmit(=
)
> on one core raced with stmmac_napi_poll_tx() on another core.
>
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>

This is going to add more costs to 64bit platforms ?

It seems to me that the same syncp can be used from two different
threads : hard irq and napi poller...

At this point, I do not see why you keep linux/u64_stats_sync.h if you
decide to go for a spinlock...

Alternative would use atomic64_t fields for the ones where there is no
mutual exclusion.

RX : napi poll is definitely safe (protected by an atomic bit)
TX : each TX queue is also safe (protected by an atomic exclusion for
non LLTX drivers)

This leaves the fields updated from hardware interrupt context ?

