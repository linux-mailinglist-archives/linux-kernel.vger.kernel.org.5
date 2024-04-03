Return-Path: <linux-kernel+bounces-130490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267058978DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AFE1F283CE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C861552E9;
	Wed,  3 Apr 2024 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK3ZA5l+"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF076154442
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171680; cv=none; b=cA96dhrUXZ2HIfx9tRs8UDgk/LrBKvvA4f4/5CgItAiaX0bQhKq7MjF25SB4kReM2CvkL4O9Q7gKVAGzXfPk3cZXU1ugcrpNaVZrOOzuA5MliipCJWe2It+EXNXcDy74bwpubOlHx3HR96tls64/Nxcex6q4xCmWu/w/31oxbZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171680; c=relaxed/simple;
	bh=FJ+t/gDiplQiUtBc16qSLCueyfEyhKBzs5fbOgUf8SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0QOnqBOlfulT05fGuGz19ZEKvG8MGjaID1T4sk2xd/iDPmbderpFzmGWBNiIotMNxwDSlSTd1SMNHNC+7HmXeiS+Q0yiSM8tcKzldDeEB37RoFZJeeBUxnMf/WqHU6pGgoLTg5dzBDZVcuGD+u2Grtyh6pKgwbaIy+CQcDmJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK3ZA5l+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e223025ccbso771555ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712171678; x=1712776478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVpGTxFXS5uXsCBb768x+7/nyj1uORz4WNXl8EbIhlU=;
        b=dK3ZA5l+zccA1xSG5l8Jn29tXneSxyvREj1G4Z5AY3CGTgTWQd5eCm4ziBBwK/pZLu
         9ibD9L4+yVoXpmqybIQyhBQDTfpWkcdFN86HTH2VlDp8ZYu0GidyfOjyz8+j/mnaymFm
         jSSn++2lWqIVBA4yN13QjBlNi5w4VpzObV7sKk9vOhIuNERp/1z3M4/kvhne3NutqGTJ
         dZLHKesaOjACq4c17YfHclCwhJcq0LQYTKYb//YMivoDSjQBPSMXpm+ZIDdllQ1m6uHO
         cY1/U7kSIWjD+mS9KcA1gAsExCc1PGRiQMXn6/8l+f2gEuW6rWNxdnrTrF37ZoH/0wWT
         UTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712171678; x=1712776478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVpGTxFXS5uXsCBb768x+7/nyj1uORz4WNXl8EbIhlU=;
        b=C3N7XSfdLmH6TOh9pThsb2jNhctvAFExXzklE5ORbdqSbMegNfuMOjZsLTDQuK9M1G
         fhLBw+MprOSiQZr62uRIPOCbQWlbW2KHw8m3kMN0h+c+j98/dk2QfkWM2An9O1gUVfuV
         Dnc9riooaT5VqnCRziPGdw8NtLArzZXdy4uP2uw81jDu8ei6evVJ57dkqZ0D2fyOnn9R
         QIMW7YRyAI7Cyho+pkUxC+r0lLmoqc8ARoLnQhruruP4ZdryRQTC789umG7m/k7njRr0
         s+rRGxNixIe1FoJJHizWVSkdM+UE1l2n8wviJ5JrCb1He0BwYAMl+zOogeK8EmLPcg+o
         hYNg==
X-Gm-Message-State: AOJu0YzTVvQWlOh5H9Zlk+KEOckADkd/w6Vsk5L8YcwiuGwWUR1yLGq4
	RIE7w8kKgK8af/D+LHfIQliWutYWxyNXaBC2nRj+N/m4KGeR7yZo
X-Google-Smtp-Source: AGHT+IFjVj+8On2PFUPVYQMCQadRX0E6HTfgGElVggaP9InZtQw2So6f/WRTROp6i8r8ixwluZ/syw==
X-Received: by 2002:a17:902:8c97:b0:1e0:e85b:b9ca with SMTP id t23-20020a1709028c9700b001e0e85bb9camr162971plo.21.1712171678270;
        Wed, 03 Apr 2024 12:14:38 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id kx12-20020a170902f94c00b001e0b5eeee41sm4201776plb.38.2024.04.03.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 12:14:37 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Apr 2024 09:14:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug 218665 - nohz_full=0 prevents kernel from booting
Message-ID: <Zg2qnEgOo9CaFwgB@slm.duckdns.org>
References: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>

Hello, Thorsten.

On Tue, Apr 02, 2024 at 10:17:16AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developers don't keep an eye on it, I decided to forward it by mail.
> 
> Tejun, apparently it's cause by a change of yours.
> 
> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> not CCed them in mails like this.
> 
> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218665 :

This looks like the same problem that's being discussed in the following
thread.

 http://lkml.kernel.org/r/20240402105847.GA24832@redhat.com

Hopefully, we'll soon reach a resolution.

Thanks.

-- 
tejun

