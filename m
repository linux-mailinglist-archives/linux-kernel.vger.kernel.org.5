Return-Path: <linux-kernel+bounces-102548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C17987B3B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6BF1C22CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236D758AB4;
	Wed, 13 Mar 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr7Mz7hh"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C665813E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366276; cv=none; b=jUZkqe6BPpR7OHeawckzqYWHw5g1oRE0xn4FHObktNXMise3+AbGurySPDN8UEOEsSZC12SyV+ndcmFv5k1oqIH97G1ECA671LDMZASf/I9hVpShJzuX5vpx+GDZ1nLnp7B0c2JgWVIniVL5Gzg7qCGMtq7XldcupI1kN6dwMtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366276; c=relaxed/simple;
	bh=M7tMssL3rW6daJmlY8YzvszCMnWhcIOBZ0pI+5TVFAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BARzTDnYNecf+nh5KPpW7M7gcdcVdow6WM9i4cQv03LnensNIS8iCT4lxlbk+7NreKsR1qjW/jXCBuzCwYLgxByyGS5kYCvXzDqffQN22V76czjmCfrMZRtpwR89Jm7PaG4xVjAPV2YI7aLpFFfK0tYSHsPdo9sO5pQusXUtKyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr7Mz7hh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dddaa02d22so2060835ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710366274; x=1710971074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqpXVYBsDQDgSl0PQ61LrhAcbX98gzLbSWwdys5RLvI=;
        b=Dr7Mz7hhdOcnWrjy2IStgZTaq3Mq0JKlIyS9xzBr7dVBtsP1N+ERWw0aUz+m+Ma0C7
         RFGpZQutkCeDosFbjrUOtxhRGoHnDcCcC5POO8a0WhIZAa48MLIT/Fq7UQbKogxIjZbv
         QzSQatKv8W6QkVKF48mlkdeIaQ1h4XmbZm6G0aSPxv5kcc8+3eke7uOld8aFoVmYPWrs
         w6VknKtjdv0XOBgCZwOK0bOZgQMPXR9gkhHUy9al2s5Dx0Og9GUCCcn4yUnEzgrOxtMx
         PnOm/W5KJvllCTzeYp8DuhTr8DPWZ7gLY7L75yucgE1GCyF6kis3icQCLgmSq3PWiEo9
         2uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366274; x=1710971074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqpXVYBsDQDgSl0PQ61LrhAcbX98gzLbSWwdys5RLvI=;
        b=lCJa+oUp7nwiAPK8w2p2M5sfgv0AKsrKtmqn6rAk8auJJPwv38CLsC5ZMBkQakH9xm
         MuVh3Lc64JBvTpAG/Jrome8PsPgCgi7CzddWmIbdficE+9eq1UJVAoMz0leic8Kr80BI
         gsf6Gsa0wqxsOjWN66rnTyy+OTUDXLrkpCeTPBmU8i+/XCPiEspTcC2KQWHTJra1tmE8
         QSpyEkWduZraGz7BjP5RUsftG0nn++hGzvo8SUSm0Rgie38tukBd6wwhES27w/jbjsfB
         GRhzFCtHOnJyfAdvx8OdX/VSj/3lvr+XgxzHlYvWfvVKc3h+UyvoAlp7fmrWejUQjik2
         XPug==
X-Forwarded-Encrypted: i=1; AJvYcCX3AW9LS8N43tx6LXVQddUxq7oVfk+OvKi6FqQFOiyKg4LMJgfFs1TZlF35SvGKQO0ulHzc/jH6mV1OM3NpgrJ7MzPFoe7nKwX24U/8
X-Gm-Message-State: AOJu0YwWjRtqHdz70IG2Lpr1oOrdfkrgyTQKoAIkH/CY1nLP10zIV3IV
	mBr9G8ZSYEzWbebCLkCSbHI6TzqC0GYgOsqn7UmRI4xz5BG8HTHoLuMo5mVW
X-Google-Smtp-Source: AGHT+IGTROaHYXxzf+17P2vGGsVAJyT79RM3PPgmRinvxxlvM/ysxERHCOBQZqY+QnILlv5GLoVePw==
X-Received: by 2002:a17:902:7890:b0:1dc:51ac:88f5 with SMTP id q16-20020a170902789000b001dc51ac88f5mr33054pll.65.1710366274322;
        Wed, 13 Mar 2024 14:44:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2875])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b001dd7d66ac95sm91424plk.78.2024.03.13.14.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:44:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 13 Mar 2024 11:44:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs: sysfs: Fix reference leak in
 sysfs_break_active_protection()
Message-ID: <ZfIeQKluEeh7TulW@slm.duckdns.org>
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
 <e9d710fc-eace-44de-b3cc-1117c3575ef7@rowland.harvard.edu>
 <2024030428-graph-harmful-1597@gregkh>
 <416a8311-c725-419a-8b22-74c80207347f@rowland.harvard.edu>
 <9c2484f4-df62-4d23-97a2-55a160eba55f@rowland.harvard.edu>
 <ZfIKwFSmw-ACj_jO@slm.duckdns.org>
 <8a4d3f0f-c5e3-4b70-a188-0ca433f9e6f9@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4d3f0f-c5e3-4b70-a188-0ca433f9e6f9@rowland.harvard.edu>

On Wed, Mar 13, 2024 at 05:43:41PM -0400, Alan Stern wrote:
> The sysfs_break_active_protection() routine has an obvious reference
> leak in its error path.  If the call to kernfs_find_and_get() fails then
> kn will be NULL, so the companion sysfs_unbreak_active_protection()
> routine won't get called (and would only cause an access violation by
> trying to dereference kn->parent if it was called).  As a result, the
> reference to kobj acquired at the start of the function will never be
> released.
> 
> Fix the leak by adding an explicit kobject_put() call when kn is NULL.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Fixes: 2afc9166f79b ("scsi: sysfs: Introduce sysfs_{un,}break_active_protection()")
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: <stable@vger.kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

