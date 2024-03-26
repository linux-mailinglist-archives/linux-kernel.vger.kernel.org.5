Return-Path: <linux-kernel+bounces-119431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5870A88C8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6EB1C3470C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337F113C9B8;
	Tue, 26 Mar 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tA8AzJEU"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353612D75D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469620; cv=none; b=G3a7KN15V+fd//+CcM7p1dIWp4ob6Jce4FhDS2l3+jbOtVb262eh1HGB4D94yweBPD2GnxwtevU4DpKKL6wLKLPru+YbdV3qBbZnQOe3aUVTWHVl8rU2LFkDx5lUu0G1BCulfHYpusXtz1vaoK38c1wK9aJDA786CxM81o5z6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469620; c=relaxed/simple;
	bh=eK+R0ABmPGj+plzVUUZwmM346UOQh8NwmmAsoudMd8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UczHT6OVu/K/TZmNnP+eQzO/58r89t1wGr0pV64xi4saQt5sFRfhM4ZExM3OgRnJPtIMvq3bkPeUjkRTbfDKEVlD6S1Ao7m4Fzu9kjtYPI1kLf7z+v9tmLAGov1NtzgdAf7A0A2SAncLrNRdbNmnk8CY6J4HVph8vDO67l9nhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tA8AzJEU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41490e42c74so2624465e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711469617; x=1712074417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4LiCt10IxAVvpC47LPV/rkaTjlk1NiUuFvMFGxx+OU=;
        b=tA8AzJEUBfZfbOxmEXQLa4fU1EZiyEAyhhe96be+6LVgsWj6PKS4xwmD+xF6ZQJbz0
         DoyEOhEtLyspx/FBLtCJ+w1N7gyKVSuaGsBhb5alk9/ZGPRL1EO4oENG2R9nmCjrZs3Y
         PyCf5t0lYgmImYgaNtduZbRTCiE6xGMORuqirC+Kyz1E1Jv5GGZlq/hex/4MY463ksDj
         Gsdli7inrFc9n7jlFTdS6ui5Z/WoR959XQG+nE+cXpNc09/lzh4O2ka+kbjzWkf+Duyc
         Qg9sKG3WOo2oWCZRDiwoXWbVa9ADXCFCcni72ykzdxllEQnAjINvV0SU5WcuznLIgQ/F
         LbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469617; x=1712074417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4LiCt10IxAVvpC47LPV/rkaTjlk1NiUuFvMFGxx+OU=;
        b=YP9TQ5/sPxspPaan4iS050wsoYlZGCiRo5A8lYuw1A64/b4Y24Cw4zWtGvYcjTfGOc
         vgzBnTH0eZArhFD+52V1F1S00z+ZjY4IMKtbmEGkQJ6YjmpOFHlxJZt6IrM7+s4FOVHs
         RSilyDFqyhB22lT+WXDMCrvYZuZUJJbS809ShRChZrz37W1wX4ggVZeS+p8IiLhpG0yI
         7C0aRqSOBjZeBr7Qalw02ERNnOwemKKF9xUCEu6frFKWTpo1QJeC0LNIDNsi5ImMUtc7
         t8/UAnfidzECIKMdzqxftTdReZwjpqmRFELFgo+ahawqXbyY5l+Y/+ExbbTzqB+NEWyY
         ud+w==
X-Forwarded-Encrypted: i=1; AJvYcCX9jFNzLzgpy802nSRm1UhiaYUf7kjlsU2VDBvA+n6J+YlstM2V/q0UdXTcmjoXXg9rmUbYKw1N+p8pIHO7OX56QjEE0KttM4xEopd8
X-Gm-Message-State: AOJu0YxZzusMmiy+LPOvgiccO6107k6jPJi4RlBkBq/aX12u6kCi9Odo
	PYMGsN0DO23J0VVnWHEvspVHTjyIUW54nxtRe7tlRXyof+pihdW7F3aqb1LQcpM=
X-Google-Smtp-Source: AGHT+IFae3IpvTMwhmsZ1ahvm5eyBHH+iWrgwf59wOFSRYY+Mv6/7CtoeKIPxy/CsrVObCbGtWXjLQ==
X-Received: by 2002:a05:600c:3553:b0:414:8fa5:b9a1 with SMTP id i19-20020a05600c355300b004148fa5b9a1mr1703262wmq.5.1711469616510;
        Tue, 26 Mar 2024 09:13:36 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id q13-20020adfcd8d000000b0033eab3520a9sm12484571wrj.43.2024.03.26.09.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:13:35 -0700 (PDT)
Date: Tue, 26 Mar 2024 17:13:33 +0100
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-omap@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Markus Mirevik <markus.mirevik@dpsolutions.se>
Subject: Re: [PATCH] gpio: omap: Fix double trigger for level interrupts
Message-ID: <niruat6lxth4j7cmb7flo6pyipmnfym5evt6amszogkhtt5kkc@njhz7h7uciz2>
References: <20240326145439.1293412-1-msp@baylibre.com>
 <6ecd284a-e3f5-4b69-b6d7-129da6b385c1@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ecd284a-e3f5-4b69-b6d7-129da6b385c1@moroto.mountain>

Hi Dan,

On Tue, Mar 26, 2024 at 06:29:45PM +0300, Dan Carpenter wrote:
> In the bug report email thread Markus Mirevik said "The interrupt
> associated with the GPIO module still fires twice" so while this patch
> is an improvement, it might not be a complete solution?

Yes, that is possible. I actually only had the level interrupt
double trigger bug which is fixed by this change.

> 
> > This patch was originally proposed by Grygorii Strashko.
> 
> The way to give authorship credit is you make the first line of your
> patch:
> 
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> When the patch is applied then git will assign authorship credit but
> remove that line from the git log.

Thanks, yes I am aware, though I didn't want to add that author tag
without someone agreeing with that. As it wasn't a formal patch, there
was no From: already present or a SoB by Grygorii. Also there was no
reaction on a ping from me on the original thread. That's why I opted
for the comment in the commit, the explanation and as I said in the
letter part I don't care about author, just that it gets upstream.

> 
> On Tue, Mar 26, 2024 at 03:50:14PM +0100, Markus Schneider-Pargmann wrote:
> > Set gpio trigger before clearing the irq status.
> > 
> 
> This commit message needs some work.  When you're reviewing on email,
> it's kind of common to read the commit message without reading the
> subject.  See how the patch looks like on lore:
> 
> https://lore.kernel.org/linux-gpio/20240326145439.1293412-1-msp@baylibre.com/T/#u
> 
> The subject is up on the first line, but it's mixed in with the headers
> so it's easy to skip.  Go ahead a restate the subject but in different
> words.
> 
> But also copy and paste more of the problem from the bug report.  To me
> if I were a user the important bit is that the bug ends up hogging the
> CPU.
> 
> "The problem is that the interrupt handler was is run twice for each
> frame.  It hogs a lot of CPU time.  Fix this by setting the GPIO trigger
> before clearing the IRQ status."

Yes, thanks, I will work on that commit message.

Best
Markus

