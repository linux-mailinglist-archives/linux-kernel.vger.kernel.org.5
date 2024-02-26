Return-Path: <linux-kernel+bounces-81039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24828866F53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DBB1C24AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916747A76;
	Mon, 26 Feb 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1hX8+4ka"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74A81D69E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939344; cv=none; b=I1dp8Q6zJ0vSkgF6A+GEIUZVe4GqSFPjdvsl6B+OHIHMRw55OzgltnovGT6AFwAPU6yBG5b7HlhfHgBsPpelBWlppgOL6RMRSudohuIuE4exh86lp3J4ISX6AMGYEPd21v7hNstLijyQd/WevQeoiGc2hZ+HGigQ35kTyTUOxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939344; c=relaxed/simple;
	bh=j8XfaiFpFxA90a4LK42YXfNdmNz9AouX/NgcsYVPG08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDPW+qRw0M09PgduXStMd1Oq4GS5OqqzsCg+xq24vM81C7HYmhwo6ruE1jucZ1MMxmFbvViNbB+xWl1p0/kOJji/663jdEGj6uOVFC0DLzIpS2cph99D1cpqJC/gqu/uLlJGC+rDq+q/QWl3/Gj4kLBHCBrmUgXHic2JMK2Nb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1hX8+4ka; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d066f8239so2083044f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708939341; x=1709544141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8XfaiFpFxA90a4LK42YXfNdmNz9AouX/NgcsYVPG08=;
        b=1hX8+4ka2IXadTkHka4Jpdk+G2QU4NO3kxWy6hOWpJfarp0bgruourRNnGQ9SZ6UuM
         00TY/PhF1f3X5yi5oDsC/Xk6ARAV6WKqtvTATOM89CJeZfN0DpGCNBMzHpxMBkDE/dWV
         UOg6zfckMBw4FoGBY2eM1B7FE3MAxBKnFICjV2aqMlzt4ZZ2QUk5JNAYgNwdB5tYBoO4
         6x6yrPg3puiAo0QKR14OEEIfSAZrzhu4wt+Wc2DnmR9MCl4e213MnIG4zlzOS+S9s59y
         oKI0ua4TFTeRVxh7RVLTd3nmXcNPMI4dJvJp9IGVzAQFX9iwauzoII3lep/5gt9I8Mch
         O99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939341; x=1709544141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8XfaiFpFxA90a4LK42YXfNdmNz9AouX/NgcsYVPG08=;
        b=wSGpGQ73Am53QEpuGSCL+0M0tvAdgJkbqfNfdq4F6BwImLrld5lGrOakM+dMXjkbkI
         /CpFigedjBchlcu9644w68nmTbYGPcTrYvv/yeRDzgDLd8MYgk3AN0QjOYvRUnSET0qB
         tMkpCkxRR9HmU2dxsgLERe3W0cAGPUzYpW4Zpt7wNNwZ9SRH+mIhYS4wCbGyVbt8DXfX
         fPNTsFWArW+Jowi30JC3uZw9VevcgGEG8tYDNHJyQ0Y3yJjvvzW5J4nRXDheVuNUkx33
         +OikB2gr+v4TVeLC7BD/TSxhddjjDkupAWDXmVptaELE7Sx0yVuW81AuX39LdAD3PRJC
         FNqg==
X-Forwarded-Encrypted: i=1; AJvYcCUh/i/pyo5I6reCz6nu05AmQczwbxO9tmgcKnpo/lfW+T4R60Ml4u/yYnmr6eM9BECniaE1tZfIqsOBlD2g4u9sZvAmbT7XiIHDtKUw
X-Gm-Message-State: AOJu0YzpJq5nr2X5L7rNytMXy+BWM/2JOg3yHPp2tztLnFEDovyI7pTt
	wX/4cR2ZeQVf3h1l0QCZnHRevHLoe+MXBfYNkEL4bh+I1KW6Q1ZqajZ1/Wdmavg=
X-Google-Smtp-Source: AGHT+IFhByc7Z/s+hrcaeMhRiOLNXEQPUqLbBOTkrI67qidhCeOFDFWtzdBsTN1m+Ij8d6SU/mQ3XA==
X-Received: by 2002:adf:e40f:0:b0:33d:a185:17ec with SMTP id g15-20020adfe40f000000b0033da18517ecmr4122739wrm.4.1708939341017;
        Mon, 26 Feb 2024 01:22:21 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id e11-20020adfe7cb000000b0033d071c0477sm7605769wrn.59.2024.02.26.01.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 01:22:20 -0800 (PST)
Date: Mon, 26 Feb 2024 10:22:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@axis.com, Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH net-next v3] net: stmmac: mmc_core: Drop interrupt
 registers from stats
Message-ID: <ZdxYS6Fmd6NLScGC@nanopsycho>
References: <20240223-stmmac_stats-v3-1-5d483c2a071a@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-stmmac_stats-v3-1-5d483c2a071a@axis.com>

Fri, Feb 23, 2024 at 09:37:01PM CET, jesper.nilsson@axis.com wrote:
>The MMC IPC interrupt status and interrupt mask registers are
>of little use as Ethernet statistics, but incrementing counters
>based on the current interrupt and interrupt mask registers
>makes them actively misleading.
>
>For example, if the interrupt mask is set to 0x08420842,
>the current code will increment by that amount each iteration,
>leading to the following sequence of nonsense:
>
>mmc_rx_ipc_intr_mask: 969816526
>mmc_rx_ipc_intr_mask: 1108361744
>
>These registers have been included in the Ethernet statistics
>since the first version of MMC back in 2011 (commit 1c901a46d57).
>That commit also mentions the MMC interrupts as
>"something to add later (if actually useful)".
>
>If the registers are actually useful, they should probably
>be part of the Ethernet register dump instead of statistics,
>but for now, drop the counters for mmc_rx_ipc_intr and
>mmc_rx_ipc_intr_mask completely.
>
>Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

[...]

>---
>base-commit: a08689109c5989acdc5c320de8e45324f6cfa791
>change-id: 20240216-stmmac_stats-e3561d460d0e


Not sure what this is good for...

