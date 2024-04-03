Return-Path: <linux-kernel+bounces-130082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C86E897428
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27E0B32895
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C222C14A092;
	Wed,  3 Apr 2024 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtcfiFAH"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DA149C68;
	Wed,  3 Apr 2024 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157741; cv=none; b=hNM2HRl8AcPQbFtO+8KI0pPeoXzDJFaAKxPvIcp7CeAHd/onaYA3BslnGwj6G9ZDYRg66VA/qWiAe2iZZWk4X19R6VkUhRxWxg9Sk/xn5fap4JI5ILRt7Y8UgGGaP8x5ICloweTKHQ7uQFYJF6v7RG68oVBFkqKXibEoX56J8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157741; c=relaxed/simple;
	bh=ibwa7qVlsz6WfcpJqPrroTnKs/SIZZIG690/0G7mCPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSbS1DNZ+th1Bxk1eUSHK9+7Cavj2mu9cyH4XQo8yanFIUkXxkn3atR3XE9jA9+QyqdNhju3vvNp3BjjLmJ+6Hu8basf9vNDUShXnY+VB+4LnmgbjAT+f2phdeEyiq2fjnYrZgdeAfsrY6AapF102ewrmNb5mr1awDpY76QAK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtcfiFAH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e28efd8335so7273165ad.0;
        Wed, 03 Apr 2024 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712157739; x=1712762539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fd7qpkMBxQ2+k8rxh1w6ZQnt5fuyzAt4KYqqtVYV1Mw=;
        b=FtcfiFAHZmslRX389/ZzcFKiaE2fgsd0ET/1rDJWKGdy5tkn/W5fMJJQ4MWi0FlyKy
         YIHvaLzwvXncu2V3BVzc1mgz+ABw/0s49wNXQkhFgRBigWvVjzniDyXfhm1m36gFL+HW
         zVP0XrwWAlABPe5dBzVArOE+dFFjHsrAXMWEXlCOhv9sua8XyVdFhxOHCLTsLwQ03E2V
         H5MF/2XEypmGSGdVcXTK/59UNddKxi5Nw6vBOrGbN3kG/cu3k6CkrCys78hCtT0WhXVq
         hn4a7bAQQonrE8LuRRwEeTB5flDvFmq+uxLJWnpdDHOmDrAscfTfAG2NW7oBWRFiqhCF
         ApFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712157739; x=1712762539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fd7qpkMBxQ2+k8rxh1w6ZQnt5fuyzAt4KYqqtVYV1Mw=;
        b=SjFNUaQeNzMpmuMMyNG2mmovo24UVM1UG5VvR6Pw20SJMLHaXOJJ8MeWDqPVzUO9VE
         5RaI8e+rZ8rhjgPGZKD2eGrg27OFTxyNP8uqq8p2HlSmngCNmlZXrsuSPLxri9dD0N2c
         dJ02zPqS4qk+x5r5/jGVDF2H//Ss5LUZVd8EXdkJldSnGYFtDcThRrNkR10YRcAaQZuR
         LD3HfPdPUAXY2AgQXJ24anlAyHMdeEdaybPam/hpkxqc9rTYmvNF/yCf+hBY04D5bk9Z
         82XISP5pTVI8yNW07ArD8W0OfgiERHkGryIyCGeVI6OezUCagDITmoi0AIghqadMx80g
         UxWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRFHHQVwrQZ3K9KO2FXJloBr/QB2Ph4LsFqMFoCEveHFnlpXnwwUkvgBqyB5xLOUFPa+HHE2vf7J6muV/KRnJpa1choaSkyEnb1AGbbflrERCgmTUcYDmQMGVJLtQg/HsKbds6
X-Gm-Message-State: AOJu0YwqY2l6lp1YiulTnqU7zk1QizB7/IUMCo1tJd8hxv8pkHqfw7tt
	WJBKMQXtCSWsUWbC84A1TM6p9ET3Yv+S7docJ98YkTWIETU5WiVP
X-Google-Smtp-Source: AGHT+IHjO4mpK4Tq4azhCzt5xkjqRK+0OXIWC7WSgQ51pHzDtg/QMk6JiACDB2L0msI6Q6if578FSw==
X-Received: by 2002:a17:902:f612:b0:1e2:9ae0:2165 with SMTP id n18-20020a170902f61200b001e29ae02165mr1541870plg.0.1712157738889;
        Wed, 03 Apr 2024 08:22:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902d89500b001d91d515dffsm13428232plz.156.2024.04.03.08.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:22:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Apr 2024 05:22:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Hibernate stuck after recent kernel/workqueue.c changes in
 Stable 6.6.23
Message-ID: <Zg10Keik4KORjXMh@slm.duckdns.org>
References: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>
 <ZgylCe48FuOKNWtM@slm.duckdns.org>
 <b6cdb17f-206c-4dff-bb45-a60317e0a55e@leemhuis.info>
 <2024040328-surfacing-breezy-34c6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040328-surfacing-breezy-34c6@gregkh>

Hello,

On Wed, Apr 03, 2024 at 07:11:04AM +0200, Greg KH wrote:
> > Side note: I have no idea why the stable team backported those patches
> > and no option on whether that was wise, just trying to help finding the best
> > solution forward from the current state of things.
> 
> The Fixes: tag triggered it, that's why they were backported.
> 
> > > which would
> > > be far too invasive for -stable, thus no Cc: stable.
> > >
> > > I didn't know a Fixes
> > > tag automatically triggers backport to -stable. I will keep that in mind for
> > > future.
> > 
> > /me fears that more and more developers due to situations like this will
> > avoid Fixes: tags and wonders what consequences that might have for the
> > kernel as a whole
> 
> The problem is that we have subsystems that only use Fixes: and not cc:
> stable which is why we need to pick these up as well.  Fixes: is great,
> but if everyone were to do this "properly" then we wouldn't need to pick
> these other ones up, but instead, it's about 1/3 of our volume :(
> 
> I'll gladly revert the above series if they shouldn't have been
> backported to stable, but from reading them, it seemed like they were
> fixing an issue that was serious and should have been added to stable,
> which is why they were.

Oh, yeah, they're fixing an issue. It's just that the issue is relatively
confined peformance degradation and the fix is really invasive, so not a
great -stable candidate. At the very least, they'd need a log longer cooking
time in mainline before being considered for -stable backport.

My intention w/ Fixes: wasn't triggering -stable backport at all, so it's a
miscommunication. From now on, I'll keep in mind that Fixes: does trigger
backports. I'm not too worried about not using it as the fixee commit can be
mentioned in the commit message.

> This is also why we have review cycles, so maintainers can let us know
> if they want us to drop them :)

Heh, sorry about that. This never caused any issues, so I just glide over
the stable mails without thinking.

Thanks.

-- 
tejun

