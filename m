Return-Path: <linux-kernel+bounces-122820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA2A88FDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE9F1C2A895
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC617D3E3;
	Thu, 28 Mar 2024 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khvoinitsky.org header.i=@khvoinitsky.org header.b="Fyl+N1f0"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3FD7E572
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624472; cv=none; b=r6rBSAy0Gx+6aByPI4cYxXBRWPLoYEieAGjP7TJN7EC8ivWVuEn50H8/hPlShA8gxAWUD4pk8cINrnPijBda7IY9m9AQg5vIijnxlzfxbmgP3DbWGWe+CFMp6THmgQdlVNFFWcF10Ndr17v+fqrU0De9WIr0WdG2a881NB6K5s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624472; c=relaxed/simple;
	bh=ih0F07PnNJ+ccJsZ5jWXyBWyimm8raUL914bms3twsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBuiTnPRwvQvxqtXTBxZLzuXvQVOU26QRyOlcGqcHX+SOBUzme7R6NbavoAxfzkWL/XXkbL+pSD6MVZU3DDSmOqYc4AGhL3lcE5cNZ6B5f9X02ZSMaGv9ndWR3JqAyi7vaUszxAIvWsNC9mc+87IlKEHaAhMjRQuVV7otpJpUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khvoinitsky.org; spf=pass smtp.mailfrom=khvoinitsky.org; dkim=pass (1024-bit key) header.d=khvoinitsky.org header.i=@khvoinitsky.org header.b=Fyl+N1f0; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=khvoinitsky.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khvoinitsky.org
X-Forwarded-Encrypted: i=1; AJvYcCVW4U0GLmODIhKI3RbPwRUVQWMfZKffME3hCG8PKH227A7x5V0BG9325dqMX6gCJQXaSw93s0JqHxro+NSiAd8KkXKQ8hxMpBH+YR7VhOEpuP2BIXp2nJJ2cPNV7D2LyHnb7YPw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khvoinitsky.org;
	s=key1; t=1711624467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyBdVLeR0iGztScqRFw42hXy5mWAAq735aD6y6toOHg=;
	b=Fyl+N1f0YO9MXqnulUPITqDlTH6mLyYzhwkSMRAUew3ScV4yMi5BGekDVqNqN/4pbVeVT1
	iviIOdy1hsp09koAF/ppHeLXZKHhpFzB2t0Up+TcP0lIqWTDOR+VEP7pSI5N6SVKedCaiz
	HBGqwhrZ8uP9P/Lk7Ue0wV46bvXRPUE=
X-Gm-Message-State: AOJu0YwZpFLgGjjWaaJHQhd8a+5w00zcU+Me6isJs64JlqCUgnAbYbdi
	HGGQtCk/BsLZdIEbIoSBRdRfN19Nqnur0W5Ik3LzNbA63zOgKOJdnqA3GS6qbLvBbgRQUNFTnmq
	jxBssZBOK8N0cWXHyKmLDWDrvRlc=
X-Google-Smtp-Source: AGHT+IFtQTfimY5bygJfYb3mmH01UJxeFQyJouq/lZdlVc9aDYaf/0Zl1hsQw4Uz3UOnLX8E/RvhVnsq6FB1N2ZYrmw=
X-Received: by 2002:a19:5e47:0:b0:513:bb6:6966 with SMTP id
 z7-20020a195e47000000b005130bb66966mr1391855lfi.6.1711624465164; Thu, 28 Mar
 2024 04:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324234027.1354210-1-sashal@kernel.org> <20240324234027.1354210-128-sashal@kernel.org>
 <ZgVJGs2OI/4QsJCQ@duo.ucw.cz>
In-Reply-To: <ZgVJGs2OI/4QsJCQ@duo.ucw.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Mikhail Khvoinitsky <me@khvoinitsky.org>
Date: Thu, 28 Mar 2024 13:14:13 +0200
X-Gmail-Original-Message-ID: <CAMMabwPNaHF67fTunfr9L2H1msntquypcd0kgzdza+OwyuZRRw@mail.gmail.com>
Message-ID: <CAMMabwPNaHF67fTunfr9L2H1msntquypcd0kgzdza+OwyuZRRw@mail.gmail.com>
Subject: Re: [PATCH 5.10 127/238] HID: lenovo: Add middleclick_workaround
 sysfs knob for cptkbd
To: Pavel Machek <pavel@denx.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jiri Kosina <jkosina@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

Hi,
This patch is already on upstream. Unfortunately, previous backports
of related commits caused some issues so just skipping this one isn't
a good option.

For module parameters, while it's quite unrealistic for users to have
more than one identical keyboard but with different firmware, this is
possible and having a module option would prevent tuning only specific
keyboard.

For the documentation, makes sense. Sorry, I should have done it
together with the change, I'll fix it, thanks for pointing it out.

On Thu, 28 Mar 2024 at 12:40, Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > From: Mikhail Khvainitski <me@khvoinitsky.org>
> >
> > [ Upstream commit 2814646f76f8518326964f12ff20aaee70ba154d ]
> >
> > Previous attempt to autodetect well-behaving patched firmware
> > introduced in commit 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw
> > on cptkbd and stop applying workaround") has shown that there are
> > false-positives on original firmware (on both 1st gen and 2nd gen
> > keyboards) which causes the middle button click workaround to be
> > mistakenly disabled.
> >
> > This commit adds explicit parameter to sysfs to control this
> > workaround.
>
> Should this go to stable? We have stream of lenovo workarounds, maybe
> -stable should wait for upstream to solve this.
>
> Plus it should really have documentation.
>
> Oh and we normally solve this stuff with module parameters, so that it
> can be fixed during bootup.
>
> Best regards,
>                                                         Pavel
>
> > Fixes: 46a0a2c96f0f ("HID: lenovo: Detect quirk-free fw on cptkbd and stop applying workaround")
> > Fixes: 43527a0094c1 ("HID: lenovo: Restrict detection of patched firmware only to USB cptkbd")
> > Signed-off-by: Mikhail Khvainitski <me@khvoinitsky.org>
> > Signed-off-by: Jiri Kosina <jkosina@suse.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

