Return-Path: <linux-kernel+bounces-55318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25A84BAF5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CB5B23C75
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4296B15C0;
	Tue,  6 Feb 2024 16:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="YKQedl+r"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E351391
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237086; cv=none; b=EkiYKdQjrY7wLGQq/0LNJ1+n7/mq6Q/RQM6ZeY72t7AFDxhS4Sy8Vb64Omtk5xxu+gzf2B9j1DqX99xgg6Zb3oYR/AXuO4hVM9rJFA2dPhp3nQagnjnHDBCyju8A0W37q0qOeEsi6Gwj64Ns39qB2c6BGzuXfKAyGtM6XpMM8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237086; c=relaxed/simple;
	bh=m5YMgx/Rk89i31JsX7thzYfxW4hoc3JFWWBtlsOhGSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZbcAca5b6A1QmNYVHITDSTUNBM+y2G4B1rSa7d7apmSFLrro32MQF9SITbH0l2oamDr2h6kYX/KcKYZdXpChvUj7SLvAyQg8rjGffDuKuX+i0lIiFj33DL9BkDuD2CPdzKk2QWRzv7+zpDYc7AoLwSXhIC6M4iYYZ19qn+2zSuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=YKQedl+r; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6d8f19ab3so5778483276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 08:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1707237082; x=1707841882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wRJIyHV5VgYGC62PnCxR7qX0sGX7lOztrrbBlwUaWj8=;
        b=YKQedl+r7VZqwhdAcmGDUbp/RlNzWvhM23qfqFWUB7cwWEK2G9wl/mKY69IqPzWoYo
         DAj5wfTnCtgZbQ6DK91/iln5K3buC5ycQ7KbLcn45ungN8/d8c/Z2w6DdvGDa5XrMytG
         3y9CvLnUUPkiwvd/SVKFjDs0EghOGp1aqJHR6zkyAw1A4y214gcgfT/xuRWASrVFI0q1
         mUh3br6xmetxLf2qbgVItK9bDWnYiOQhUrfK2GgLv4U5/8iVs9JWFcNNXrHcXP7JpFCI
         rtbAUQDq4WLZSqQbf2URaADp1KpEp/WhxpsMZaLaXhAimTAWiecKyj8wMTWz2M9dMciA
         gabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237082; x=1707841882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRJIyHV5VgYGC62PnCxR7qX0sGX7lOztrrbBlwUaWj8=;
        b=M9dPOnrq2jnh1ZgzOWNuGgXMrWFV91Wtf2nnQ5jkTdy9YIkdgaDIwnslo5zaRfWM37
         otBw9bKzRQnY7xI7B93+7dk1tNiU82w1QAJQFunwmYSpr6kNFlTQ4sWOUtrBELUK2CO9
         oPLgBMol1W47HQRMqZMIuT1i2+EMTlMW5TrIihAig/gBhlSTSGRMEfBqOx92UnTs4aZL
         MmCYBQpce2mgnlDySLBz2JnY4D79ROtMx3dAK/Cpw39oe7NVIL2mnbuhy4AvUZhbkcuo
         XGqnxeDZVf5hO5QO3PiYeB8VGXmdh+520rCUZB1HteaXKnPPOAIttW9nMV+LSK6xpBHO
         ICtg==
X-Gm-Message-State: AOJu0YyETaSYCColV06MAueAR4NL+T2vHU/cOwUGg7Z/fyVJ34h/Ai+8
	YXyJmTuPxKhZLjj8VlPIKrWKTH0vHK7r5y8Ba5fr3aIrpX1HPd9Iuy8O94wIZUpmjaJyojW1XvZ
	aVG69OUHPAb33AOMeIruAuYet4dv73UFxHsFTpw==
X-Google-Smtp-Source: AGHT+IH/RWk7n17FsIM6ZLFkgpIBG5LLj62gEHMbGZsFtCblxeMsBXg47ecJv1kl1vVPCeDRQ/RSwDIIaW275+Ua6iY=
X-Received: by 2002:a5b:50:0:b0:dc6:e219:980e with SMTP id e16-20020a5b0050000000b00dc6e219980emr2261716ybp.56.1707237082535;
 Tue, 06 Feb 2024 08:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706948717.git.andrea.porta@suse.com> <eeb94204c30c2182f5ffd3ec083c04399ecdee32.1706948717.git.andrea.porta@suse.com>
 <8736c115-e11c-41ca-85eb-7cd19a205068@gmx.net>
In-Reply-To: <8736c115-e11c-41ca-85eb-7cd19a205068@gmx.net>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 6 Feb 2024 16:31:06 +0000
Message-ID: <CAPY8ntCEvsTJwoEBYc7JsTaYfdMURhmytvvVMcLVNBkmdTNcZQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] bcm2835-dma: Add proper 40-bit DMA support
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul <vkoul@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>, 
	Dom Cobley <popcornmix@gmail.com>, Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Hi Stefan and Andrea

On Mon, 5 Feb 2024 at 18:50, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Hi Andrea,
>
> [add Dave]
>
> Am 04.02.24 um 07:59 schrieb Andrea della Porta:
> > From: Phil Elwell <phil@raspberrypi.org>
> >
> > BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
> > to access the full 4GB of memory on a Pi 4.
> >
> > Cc: Phil Elwell <phil@raspberrypi.org>
> > Cc: Maxime Ripard <maxime@cerno.tech>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> mainlining isn't that simple by sending just the downstream patches to
> the mailing list. In many cases there reasons why this hasn't been
> upstreamed yet.
>
> In my opinion just this feature is worth a separate patch series. In
> 2021 i already send an initial version, which tried to implement it in a
> cleaner & maintainabler way [1]. In the meantime Dave Stevenson from
> Raspberry Pi wrote that he also wanted to work on this. Maybe you want
> to work on this together?

Yes, I'm looking at reworking Stefan's series to work on Pi4 & Pi5 as
it's needed for HDMI audio (and other things) on those platforms which
I'm working to upstream.

I was getting weirdness from the sdhci block when I was last looking
at it, so it was just proving a little trickier than first thought.
Hopefully I'll get some time on it in the next couple of weeks.

  Dave

> [1] -
> https://lore.kernel.org/linux-arm-kernel/13ec386b-2305-27da-9765-8fa3ad71146c@i2se.com/T/

