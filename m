Return-Path: <linux-kernel+bounces-103201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D0887BC4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2381C21544
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA1F6F071;
	Thu, 14 Mar 2024 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/Tq8uQx"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E2160ED0;
	Thu, 14 Mar 2024 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417280; cv=none; b=qSFGJHrPtMWnscd4GQpWiZMwB/m1lIX9tBCEmK2u1ADSO/4YmzLvGhOPvfO5AmwcVKZ2YUT7VCCdDuN8N9QHDoUnYbgu/UGgxNZkhhqISddYQ172yqfwAJO0MAarbWNejN2q0jQlC3zGMksHpFJx4aBwo+Gz0b0r4MZWZKDGTXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417280; c=relaxed/simple;
	bh=SjNRwbQ+Iyf7488rdWolOrVmSPqHnGM1gAhbRNL01us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+m102zxW92Ieh3UK8dy/x8xwZYLTTywq8TlCN128z2QkeRIxuDrkYCMZzB2WTIlFhYIdHerIk+HnHEycx1LY5I4n723fzotnh+7n2r95IfTYjF407zQkJgmp905RNwRoOHkoyRTPHD6NejCzRxuC6esgvKrTVx/34bLmd+/l/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/Tq8uQx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29c3438d481so799768a91.2;
        Thu, 14 Mar 2024 04:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710417278; x=1711022078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tjIhLuiu+iAZJO852Cp0BZxqmUJs/Cl3MLSxQiQDbto=;
        b=E/Tq8uQxy9tZQ3mj+ucmb+odTNV0Y7oqcmqsYYZWvrYEqoECSlFija9zYapQzHq5n3
         nSI4WQuEXM5lWEdUX5WdrfNrW+mfS7Nf+MIDgGI7UrMh9np/5kt9Z8VMnpL1UpGxFncc
         rGl32iqr3vqXIKHsU/Q+Fh9QENUXfg0WdQd674QDG+gA50kWwxvXKb9VbxLfKOGZwVht
         S85sH/pmQph7oFndlll5BM0CghVzoyqP/REsEGPdDsp731tfm57+KkPrt+QyLOTrm559
         lve2XmSMvSQwZFGAFh9osDZn0+nBwuTftVr9vjOKNhIlZM4G24aGrCk4FsfINOhxQtY4
         myRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417278; x=1711022078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjIhLuiu+iAZJO852Cp0BZxqmUJs/Cl3MLSxQiQDbto=;
        b=Ypr0PcSk4SQ8hXJ5MMu6pxhOXDn4EcIwgXJRInYc5mk7KUSYsQ3u0w9dOLSi/xRc3P
         dVF8RXgDkCITRr2I7EaVV2KPnYcHg9WXP5bnw+JyaMPYH/HXnpRfrYwj1+9pcsHo+j75
         ftEFUdrYETmOcSUaR8zgB28Kea/aNnLR0C3oPIg5wGv2sJbUOGfN7ABZ6nemXwHO4WaW
         rUgrHMQ78N3q/7cWlDl994yxnm3NQ5anaf8SK5TT6/74vV7tvtK7ISTkd71Wfq/21lbP
         urpHnWeqekX4F0n8APLkOXNYAQZaPlOawJ4tQ7jQqCyf+sPETEhZ/CWHtlg7GVfvlpHU
         5rJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzA/WZdupJ9BRNLnrfQaDAmJaQwvCdjDz4O+QVIWAvGeMi+iM35I7OsiD3tKahx6r3ESLqL2eO/KBigx7GWbvII7JoCWHm
X-Gm-Message-State: AOJu0YwVGV+Q5JINKdynUKppJB8LINyd7AXtr1Z3/p/GK1T+jkeqdb1D
	Boju6pY+ZBUZs0c5PyaOyD/Jw6Haqv4MHfiNWVvGHKGfyEwp1GoURAgYTHSwg8FANZfS7X9n4pc
	BpNHu+qkp6GVlkWuyn8jW6IzAmAalRv7Q+cE=
X-Google-Smtp-Source: AGHT+IHK+5/pVvbGantSGm7uoMnpKfebplUYUCv0i6kEvSY3T2vcBolrlboxkzMZsINsD1PsyJGUia4K0P7zteVMNMs=
X-Received: by 2002:a17:90b:f93:b0:29b:ae33:6ffe with SMTP id
 ft19-20020a17090b0f9300b0029bae336ffemr1436256pjb.2.1710417278599; Thu, 14
 Mar 2024 04:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313163019.613705-1-sashal@kernel.org> <20240313163019.613705-6-sashal@kernel.org>
 <CADo9pHis6n7FAtyTUhC0nO8wDaQGT1NzkJk11VcrEzQmG29wvw@mail.gmail.com>
In-Reply-To: <CADo9pHis6n7FAtyTUhC0nO8wDaQGT1NzkJk11VcrEzQmG29wvw@mail.gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 14 Mar 2024 12:54:27 +0100
Message-ID: <CADo9pHie+YAc7jju3sd1S4b=yYLrD+ehro8Sq8UwPf4-GxqMXg@mail.gmail.com>
Subject: Re: [PATCH 6.8 5/5] Linux 6.8.1-rc1
To: Sasha Levin <sashal@kernel.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

someone in #linux on OFTC helped me find it now:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=linux-6.8.y&id=aad69864e4400284b2792c16361be9d38237348b

Den tors 14 mars 2024 kl 12:46 skrev Luna Jernberg <droidbittin@gmail.com>:
>
> Hey!
>
> Wondering where you have uploaded this? can't find it at
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/
> but maybe i am looking in the wrong place and or are blind ?
>
> Den ons 13 mars 2024 kl 17:31 skrev Sasha Levin <sashal@kernel.org>:
> >
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index c7ee53f4bf044..dd0b283998d00 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1,8 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  VERSION = 6
> >  PATCHLEVEL = 8
> > -SUBLEVEL = 0
> > -EXTRAVERSION =
> > +SUBLEVEL = 1
> > +EXTRAVERSION = -rc1
> >  NAME = Hurr durr I'ma ninja sloth
> >
> >  # *DOCUMENTATION*
> > --
> > 2.43.0
> >
> >

