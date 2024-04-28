Return-Path: <linux-kernel+bounces-161323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BCB8B4AAD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A712B20F6E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7441524B1;
	Sun, 28 Apr 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b51gWh+o"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0B51C48;
	Sun, 28 Apr 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714292077; cv=none; b=GedSyL87szzj7HDy7FLoR2UfGiQMvFMxHKIb81NPoTS+UXwx9HRDJohmeyLoY8D3BUp86/wSkkPpnQDzI/sRWn3/xzih+gj3yYfazqHglz9Ev81ZjADw4arLxY1MJ3LQu9EYKTOU/w4IFXlDWo9YvCmNxr8TGFmeo1aQcmN19+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714292077; c=relaxed/simple;
	bh=LV4aEmiVjP794rtnAhBxklaJMvVHFawodaRn4ccpTZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2o5bB053AW6nI96lvvDhl6796avuRH1ka50/1NoxgnYK9wpfnf2C73hDktTsWzKbyFhQTopxMlSt0Dxju+3kJhrR/J0MQyRp0qt+UB3lNOMK1ghXwqpYmGIPobhMvh5vmoYmfdvaaftViMHf208ql9d2RyXKMlqUwsaczEdUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b51gWh+o; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ddc2ea2091so31399391fa.1;
        Sun, 28 Apr 2024 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714292074; x=1714896874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8n/BOjV6NMBaVWQY3lF6dsBughZBy/B7nsgbqTsw0Ik=;
        b=b51gWh+oSIdh23+B+Bt2jXTYumlFdavSSHl9oQ1fPRZX7YbuEw4Ne19te4xxMoLnVe
         3Jtx6bJEf7U1TmDQWTQo7CtDcT66DOLz3vEIi2iMfw9jJd7+nEufZq6WAGzOLKoJmR5R
         b7yXP6MGc6EEH0ISDwazD46QqGAAWKewZnFoJv4OrAZvy19mJh0m3ZPq3HpuGm7LnDO5
         UaPhCAcoe3ozhww9WfTm4bnvdfHlACkelkPZr61wKrTbd/yUkfpMbnW/yr5vZF2iGp/2
         8Cs2VHOSoqXWdNnyEjYYVQswZoJSjGmPx+AImUbrRQRShDUvCDhivL2iyNBfoDeWDPWh
         sRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714292074; x=1714896874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8n/BOjV6NMBaVWQY3lF6dsBughZBy/B7nsgbqTsw0Ik=;
        b=QLyyxtVk0bJoFqrcR722b6qAfgbIgq/tyC01ItUgnzcaNfAGA0OZl4Y4NDsJpZ2X92
         f2+aVCfN662vDSfhOCokahrl3q7CmOUogBAx1+fl4dsno4WWjXZP6C0XhjlF8hq394iZ
         W2BMMzj9UEhXnhw56V8Uj7uaXdeXDC5HzEK5pB7s1FJCim1Z4bWYb+dYE/Z0hd7DTopc
         bkgF+164VEqDDAKOtlcIZI2G+dkoq2PBLVmHxtwBCWaNO48jTWqz88tUoiwntyUQgcS9
         2fZFYBHD8kOyKXtgScld/TJoSDmqPNdV+CVcAVnOhHfsrJfxuCHUUIF2a3TZhTXqkvp+
         3ELQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFiX4iLI54AswiYNL+3gzdhwQ7EbXkKD0zMR+fQs/Q4JWTNjT74BzJzpMrfkvcMkJrlalaw7amiRtTRmeZKo2WpxNWcVeMu38i6TXhLDOPyOOBHycvkbv5jKOm/6IfsXbvxRckkNdFL7XDh/2SUpg=
X-Gm-Message-State: AOJu0Yyd6aECz+2So0VI6L7ANdfDSl2eGwhs2OuXlRoGJkL4UJPB3A+t
	k+ZB+yzWsuiL2nSn8XgeXTaa1nmVfpwRjy4Ltpg0mLmT/YDL2Qf2
X-Google-Smtp-Source: AGHT+IEM4RSjpZkevd+0XnjLifYgd9LCEyZS2tonnUGUleii2wKQ6huuCup406xlehv6ahb4RV10fQ==
X-Received: by 2002:a2e:9b8d:0:b0:2df:55a3:43af with SMTP id z13-20020a2e9b8d000000b002df55a343afmr4223245lji.41.1714292073286;
        Sun, 28 Apr 2024 01:14:33 -0700 (PDT)
Received: from gmail.com (1F2EF175.nat.pool.telekom.hu. [31.46.241.117])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0041c24321934sm855008wmq.41.2024.04.28.01.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 01:14:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 28 Apr 2024 10:14:30 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Phil Auld <pauld@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
	Chris von Recklinghausen <crecklin@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/urgent] sched/isolation: {revent boot crash when the
 boot CPU is nohz_full
Message-ID: <Zi4FZsjmq7FxaoSe@gmail.com>
References: <20240411143905.GA19288@redhat.com>
 <171398910227.10875.3649946025664504959.tip-bot2@tip-bot2>
 <20240424204124.GA36310@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424204124.GA36310@lorien.usersys.redhat.com>


* Phil Auld <pauld@redhat.com> wrote:

> On Wed, Apr 24, 2024 at 08:05:02PM -0000 tip-bot2 for Oleg Nesterov wrote:
> > The following commit has been merged into the sched/urgent branch of tip:
> > 
> > Commit-ID:     8e3101b38dfc20848a23525b1e6e80bd1641d44c
> > Gitweb:        https://git.kernel.org/tip/8e3101b38dfc20848a23525b1e6e80bd1641d44c
> > Author:        Oleg Nesterov <oleg@redhat.com>
> > AuthorDate:    Thu, 11 Apr 2024 16:39:05 +02:00
> > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Wed, 24 Apr 2024 21:53:34 +02:00
> > 
> > sched/isolation: {revent boot crash when the boot CPU is nohz_full
> >
> 
> Thanks Thomas, Typo in the reworded description :)

Ok, so normally we wouldn't rebase just for a typo in a changelog, but 
that's an annoying typo that will show up in shortlogs - so I fixed it all 
up in tip:sched/urgent.

Thanks,

	Ingo

